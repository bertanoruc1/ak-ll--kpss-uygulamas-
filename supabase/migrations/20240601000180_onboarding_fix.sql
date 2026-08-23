-- "Bugünkü planı oluştur" kalıcı düzeltmesi.
--
-- KÖK NEDEN: onboarding.html, public.students satırını doğrudan
-- `.from("students").update(...)` ile güncelliyordu. Eğer o satır her
-- hangi bir nedenle mevcut değilse (ör. `drop schema public cascade` ile
-- yapılan tam sıfırlama sonrası, auth.users hesabı hayatta kalıp
-- public.students/profiles/user_gamification satırları silinen eski
-- hesaplar), Postgres'te 0 satır güncellenen bir UPDATE HATA döndürmez —
-- sessizce hiçbir şey yapmaz. onboarding.html bu durumda hatayı
-- yakalayamıyor, "başarılı" sanıp generate_study_plan'i çağırıyor ve
-- dashboard'a yönlendiriyordu. generate_study_plan de v_exam_type NULL
-- geldiği için sessizce boş bir plan üretiyor (hata da vermiyor) — bu da
-- "planı oluştur" butonunun hiçbir şey yapmıyormuş gibi görünmesine yol
-- açan tam olarak bildirilen belirtiydi.
--
-- ÇÖZÜM: (1) self-healing bir ensure_student_profile() fonksiyonu, tüm ana
-- RPC'lerin başında çağrılarak eksik profiles/students/user_gamification
-- satırlarını otomatik tamamlar; (2) onboarding artık tek, atomik bir
-- complete_onboarding() RPC'si üzerinden UPSERT yapıyor — sessiz
-- başarısızlık artık mümkün değil; (3) şu anda zaten "yetim" kalmış
-- hesapları düzeltmek için tek seferlik bir backfill.

create or replace function public.ensure_student_profile(p_uid uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_email text;
  v_full_name text;
begin
  if p_uid is null then return; end if;

  select u.email, coalesce(u.raw_user_meta_data->>'full_name', '')
  into v_email, v_full_name
  from auth.users u where u.id = p_uid;

  if not found then
    -- auth.users içinde bile yoksa yapacak bir şey yok.
    return;
  end if;

  insert into public.profiles (id, full_name, email, role)
  values (p_uid, coalesce(v_full_name, ''), v_email, 'student')
  on conflict (id) do nothing;

  insert into public.students (user_id)
  values (p_uid)
  on conflict (user_id) do nothing;

  insert into public.user_gamification (user_id)
  values (p_uid)
  on conflict (user_id) do nothing;
end;
$$;

revoke all on function public.ensure_student_profile(uuid) from public, anon;
grant execute on function public.ensure_student_profile(uuid) to authenticated;

-- Tek seferlik onarım: şu anda "yetim" olan (auth.users'ta var ama
-- profiles/students/user_gamification'da eksik) tüm hesapları düzelt.
do $$
declare
  v_user record;
begin
  for v_user in select id from auth.users loop
    perform public.ensure_student_profile(v_user.id);
  end loop;
end;
$$;

-- Onboarding artık atomik bir UPSERT RPC'si üzerinden ilerliyor: sessiz
-- 0-satır güncelleme senaryosu tamamen ortadan kalkıyor.
create or replace function public.complete_onboarding(
  p_exam_type exam_type,
  p_target_score numeric default null,
  p_daily_minutes int default 120,
  p_start_time time default '19:00',
  p_end_time time default '21:00',
  p_notif_freq text default 'normal'
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_plan jsonb;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  insert into public.students (
    user_id, exam_type, target_score, daily_study_minutes,
    preferred_start_time, preferred_end_time, notification_frequency,
    onboarding_completed, updated_at
  )
  values (
    v_uid, p_exam_type, p_target_score, coalesce(p_daily_minutes, 120),
    coalesce(p_start_time, '19:00'), coalesce(p_end_time, '21:00'), coalesce(p_notif_freq, 'normal'),
    true, now()
  )
  on conflict (user_id) do update set
    exam_type = excluded.exam_type,
    target_score = excluded.target_score,
    daily_study_minutes = excluded.daily_study_minutes,
    preferred_start_time = excluded.preferred_start_time,
    preferred_end_time = excluded.preferred_end_time,
    notification_frequency = excluded.notification_frequency,
    onboarding_completed = true,
    updated_at = now();

  select public.generate_study_plan() into v_plan;

  return jsonb_build_object('ok', true, 'plan', v_plan);
end;
$$;

revoke all on function public.complete_onboarding(exam_type, numeric, int, time, time, text) from public, anon;
grant execute on function public.complete_onboarding(exam_type, numeric, int, time, time, text) to authenticated;

-- Ana RPC'lerin başına self-healing eklendi: students satırı her hangi bir
-- sebeple eksikse (eski/yetim hesap, ileride yapılacak başka bir reset,
-- vb.) kullanıcı fark etmeden otomatik tamamlanır.
create or replace function public.generate_study_plan(p_plan_date date default current_date, p_extra_minutes int default 0)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_exam_type exam_type;
  v_daily_minutes int; v_start time; v_end time;
  v_exam_date date; v_days_left int;
  v_learn numeric; v_practice numeric; v_review numeric;
  v_frac numeric;
  v_total_minutes int;
  v_plan_id uuid;
  v_cursor time;
  v_order int := 0;
  v_learn_minutes int; v_practice_minutes int; v_review_minutes int;
  v_rep record;
  v_topic record;
  v_block_minutes int := 40;
  v_break_minutes int := 10;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  select exam_type, daily_study_minutes, preferred_start_time, preferred_end_time
  into v_exam_type, v_daily_minutes, v_start, v_end
  from students where user_id = v_uid;

  -- ensure_student_profile'dan sonra bile satır yoksa (teorik olarak
  -- imkansız ama savunma amaçlı) makul varsayılanlarla devam et.
  v_exam_type := coalesce(v_exam_type, 'kpss_lisans');
  v_start := coalesce(v_start, '19:00');
  v_end := coalesce(v_end, '21:00');

  select exam_date into v_exam_date from exams
  where exam_type = v_exam_type and is_active = true and exam_date >= p_plan_date
  order by exam_date asc limit 1;

  if v_exam_date is null then
    v_days_left := null;
    v_learn := 0.40; v_practice := 0.40; v_review := 0.20;
  else
    v_days_left := v_exam_date - p_plan_date;
    if v_days_left >= 90 then
      v_learn := 0.60; v_practice := 0.25; v_review := 0.15;
    elsif v_days_left <= 7 then
      v_learn := 0.10; v_practice := 0.60; v_review := 0.30;
    elsif v_days_left <= 30 then
      v_frac := (30 - v_days_left) / 23.0;
      v_learn := 0.30 + (0.10 - 0.30) * v_frac;
      v_practice := 0.50 + (0.60 - 0.50) * v_frac;
      v_review := 0.20 + (0.30 - 0.20) * v_frac;
    else
      v_frac := (90 - v_days_left) / 60.0;
      v_learn := 0.60 + (0.30 - 0.60) * v_frac;
      v_practice := 0.25 + (0.50 - 0.25) * v_frac;
      v_review := 0.15 + (0.20 - 0.15) * v_frac;
    end if;
  end if;

  v_total_minutes := coalesce(v_daily_minutes,120) + coalesce(p_extra_minutes,0);

  insert into study_plans (user_id, plan_date, learn_ratio, practice_ratio, review_ratio, total_minutes)
  values (v_uid, p_plan_date, v_learn, v_practice, v_review, v_total_minutes)
  on conflict (user_id, plan_date) do update set
    learn_ratio = excluded.learn_ratio, practice_ratio = excluded.practice_ratio,
    review_ratio = excluded.review_ratio, total_minutes = excluded.total_minutes
  returning id into v_plan_id;

  delete from study_sessions where study_plan_id = v_plan_id;

  v_cursor := v_start;
  v_learn_minutes := round(v_total_minutes * v_learn);
  v_practice_minutes := round(v_total_minutes * v_practice);
  v_review_minutes := v_total_minutes - v_learn_minutes - v_practice_minutes;

  -- 1) Vadesi gelen tekrarlar (review_minutes içinden)
  for v_rep in
    select r.id as rep_id, r.topic_id, t.subject_id, t.name
    from repetitions r join topics t on t.id = r.topic_id
    where r.user_id = v_uid and r.status = 'pending' and r.scheduled_for <= p_plan_date
    order by r.scheduled_for asc
  loop
    exit when v_review_minutes < v_block_minutes;
    insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, question_target, order_index)
    values (v_plan_id, v_rep.subject_id, v_rep.topic_id, 'tekrar', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, 10, v_order);
    v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
    v_order := v_order + 1;
    v_review_minutes := v_review_minutes - v_block_minutes;
  end loop;

  -- 2) Zayıf / hiç çalışılmamış konular (learn_minutes içinden)
  for v_topic in
    select t.id as topic_id, t.subject_id
    from topics t
    join subjects s on s.id = t.subject_id
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where s.exam_type = v_exam_type and t.status = 'active' and t.parent_id is not null
      and (tp.knowledge_score is null or tp.knowledge_score < 60)
    order by coalesce(tp.knowledge_score, -1) asc, t.weight desc
  loop
    exit when v_learn_minutes < v_block_minutes;
    insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, order_index)
    values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'konu_ogrenme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, v_order);
    v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
    v_order := v_order + 1;
    v_learn_minutes := v_learn_minutes - v_block_minutes;
  end loop;

  -- 3) Kalan süre + kullanılmayan öğrenme süresi -> soru çözme (en zayıf konulardan)
  v_practice_minutes := v_practice_minutes + greatest(v_learn_minutes, 0);
  for v_topic in
    select t.id as topic_id, t.subject_id
    from topics t
    join subjects s on s.id = t.subject_id
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where s.exam_type = v_exam_type and t.status = 'active' and t.parent_id is not null
    order by coalesce(tp.knowledge_score, 0) asc
  loop
    exit when v_practice_minutes < v_block_minutes;
    insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, question_target, order_index)
    values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'soru_cozme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, 15, v_order);
    v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
    v_order := v_order + 1;
    v_practice_minutes := v_practice_minutes - v_block_minutes;
  end loop;

  return jsonb_build_object('plan_id', v_plan_id, 'days_left', v_days_left, 'learn_ratio', v_learn, 'practice_ratio', v_practice, 'review_ratio', v_review, 'total_minutes', v_total_minutes);
end;
$$;

create or replace function public.get_today_priority()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_exam_type exam_type;
  v_exam_date date; v_days_left int;
  v_best record;
  v_reason text;
  v_days_since_study int;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  select exam_type into v_exam_type from students where user_id = v_uid;
  v_exam_type := coalesce(v_exam_type, 'kpss_lisans');

  select exam_date into v_exam_date from exams
  where exam_type = v_exam_type and is_active = true and exam_date >= current_date
  order by exam_date asc limit 1;
  v_days_left := case when v_exam_date is null then null else v_exam_date - current_date end;

  select t.id as topic_id, t.name as topic_name, s.name as subject_name,
         coalesce(tp.knowledge_score, 0) as score,
         coalesce(tp.last_test_score, coalesce(tp.knowledge_score,0)) as last_test,
         coalesce(extract(day from now() - tp.last_studied_at)::int, 999) as days_since,
         (
           (100 - coalesce(tp.knowledge_score,0)) * 1.0
           + least(coalesce(extract(day from now() - tp.last_studied_at)::int, 30), 30) * 1.5
           + t.weight * 5
         ) as urgency
  into v_best
  from topics t
  join subjects s on s.id = t.subject_id
  left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
  where s.exam_type = v_exam_type and t.status = 'active' and t.parent_id is not null
  order by urgency desc
  limit 1;

  if v_best.topic_id is null then
    return jsonb_build_object('has_priority', false);
  end if;

  v_reason := format(
    '%s–%s, çünkü başarı %%%s, son test %%%s, %s gündür tekrar edilmedi%s → 30dk tekrar + 20 soru + yanlış analizi',
    v_best.subject_name, v_best.topic_name, round(v_best.score), round(v_best.last_test),
    case when v_best.days_since >= 999 then 'hiç' else v_best.days_since::text end,
    case when v_days_left is not null then format(', sınava %s gün kaldı', v_days_left) else '' end
  );

  return jsonb_build_object(
    'has_priority', true, 'topic_id', v_best.topic_id, 'topic_name', v_best.topic_name,
    'subject_name', v_best.subject_name, 'score', v_best.score, 'reason', v_reason
  );
end;
$$;

create or replace function public.get_homepage()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_name text;
  v_exam_type exam_type;
  v_exam record;
  v_top_news record;
  v_today_sessions jsonb;
  v_today_done int; v_today_total int;
  v_priority jsonb;
  v_success_rate numeric;
  v_weekly jsonb;
  v_streak int; v_xp int; v_level int;
  v_unread_notifs int;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  select p.full_name, s.exam_type into v_name, v_exam_type
  from profiles p join students s on s.user_id = p.id where p.id = v_uid;
  v_exam_type := coalesce(v_exam_type, 'kpss_lisans');

  select e.id, e.name, e.exam_date, (e.exam_date - current_date) as days_left
  into v_exam
  from exams e where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
  order by e.exam_date asc limit 1;

  select n.id, n.title, n.summary, n.category, n.source, n.source_url, n.published_at
  into v_top_news
  from news_items n where n.is_learning_content = false
  order by n.published_at desc limit 1;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id', ss.id, 'session_type', ss.session_type, 'subject_id', ss.subject_id, 'topic_id', ss.topic_id,
    'planned_start', ss.planned_start, 'planned_end', ss.planned_end, 'duration_minutes', ss.duration_minutes,
    'status', ss.status, 'question_target', ss.question_target,
    'topic_name', t.name, 'subject_name', sub.name, 'subject_icon', sub.icon
  ) order by ss.order_index), '[]'::jsonb),
  count(*) filter (where ss.status = 'done'), count(*)
  into v_today_sessions, v_today_done, v_today_total
  from study_plans sp
  join study_sessions ss on ss.study_plan_id = sp.id
  left join topics t on t.id = ss.topic_id
  left join subjects sub on sub.id = ss.subject_id
  where sp.user_id = v_uid and sp.plan_date = current_date;

  select get_today_priority() into v_priority;

  select case when count(*) = 0 then 0 else round((count(*) filter (where is_correct)::numeric / count(*)) * 100, 1) end
  into v_success_rate
  from user_answers where user_id = v_uid;

  select coalesce(jsonb_agg(row_to_json(d) order by d.day), '[]'::jsonb) into v_weekly
  from (
    select gs::date as day,
      coalesce((select sum(ss.actual_minutes) from study_sessions ss join study_plans sp on sp.id = ss.study_plan_id
                where sp.user_id = v_uid and sp.plan_date = gs::date and ss.status='done'),0) as minutes,
      coalesce((select count(*) from user_answers ua where ua.user_id = v_uid and ua.answered_at::date = gs::date),0) as questions
    from generate_series(current_date - 6, current_date, interval '1 day') gs
  ) d;

  select current_streak, xp, level into v_streak, v_xp, v_level from user_gamification where user_id = v_uid;
  select count(*) into v_unread_notifs from notifications where user_id = v_uid and is_read = false;

  return jsonb_build_object(
    'greeting_name', v_name,
    'exam', case when v_exam.id is null then null else jsonb_build_object('id', v_exam.id, 'name', v_exam.name, 'exam_date', v_exam.exam_date, 'days_left', v_exam.days_left) end,
    'top_news', case when v_top_news.id is null then null else jsonb_build_object('id', v_top_news.id, 'title', v_top_news.title, 'summary', v_top_news.summary, 'category', v_top_news.category, 'source', v_top_news.source, 'source_url', v_top_news.source_url) end,
    'today_status', jsonb_build_object('done', coalesce(v_today_done,0), 'total', coalesce(v_today_total,0)),
    'today_sessions', v_today_sessions,
    'today_priority', v_priority,
    'success_rate', v_success_rate,
    'weekly_progress', v_weekly,
    'streak', coalesce(v_streak,0), 'xp', coalesce(v_xp,0), 'level', coalesce(v_level,1),
    'unread_notifications', coalesce(v_unread_notifs,0)
  );
end;
$$;
