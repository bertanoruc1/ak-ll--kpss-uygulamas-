-- KRİTİK REGRESYON DÜZELTMESİ: "yaprak konu" (leaf topic) filtresi yanlışlıkla
-- tekrar `t.parent_id is not null` olarak geri gelmişti.
--
-- GEÇMİŞ: 20240601000120_fix_leaf_topic_filter.sql bu hatayı zaten bir kez
-- düzeltmişti (doğru filtre: bir konu, kendi altında başka konu yoksa/hiçbir
-- konu onu parent olarak göstermiyorsa bir "yaprak" konudur — seed verisinde
-- TÜM konular düz/nesting olmadan tanımlı, yani parent_id sütunlarının kendisi
-- her zaman NULL'dur). Ama 20240601000180_onboarding_fix.sql, generate_study_plan
-- ve get_today_priority fonksiyonlarını self-healing eklemek için yeniden
-- `create or replace` ederken, yanlışlıkla ESKİ/BOZUK `t.parent_id is not null`
-- filtresini (120 düzeltmesinden ÖNCEKİ hâli) kopyalayıp geri getirmiş. Bu da
-- benim 20240601000200_fulltime_plan.sql'de üzerine inşa ederken fark etmeden
-- taşıdığım bir regresyondu.
--
-- SONUÇ: seed verisindeki HİÇBİR konunun kendi parent_id'si NULL olmadığı
-- durum yok (hepsi NULL) — yani `parent_id is not null` filtresi PostgreSQL'de
-- HİÇBİR satırla eşleşmiyordu. Bunun pratik etkisi:
--   • generate_study_plan: "konu öğrenme" ve "soru çözme" oturumları için uygun
--     HİÇBİR konu bulunamıyordu → günlük planın öğrenme/pratik kısımları
--     (bütçenin %80-100'ü) SESSİZCE boş kalıyordu, yalnızca o gün vadesi gelen
--     tekrarlar (çoğu yeni kullanıcıda hiç yok) plana giriyordu.
--   • get_today_priority: "Bugünün Önceliği" kartı için hiçbir konu
--     bulunamadığından her zaman `has_priority: false` dönüyor, kart hep
--     "Henüz yeterli veri yok" mesajını gösteriyordu.
--
-- ÇÖZÜM: her iki fonksiyonda da filtre tekrar doğru hâline (120'deki gibi)
-- döndürülüyor: `not exists (select 1 from topics c where c.parent_id = t.id)`.
-- generate_study_plan'deki diğer tüm mantık (tam kapsamlı saat aralığı
-- doldurma, tekrar bütçesi devri, çok turlu döngüler) 200'den aynen korunuyor.

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
  v_window_minutes int;
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
  v_pass int;
  v_inserted_this_pass boolean;
  v_max_passes constant int := 6;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  select exam_type, daily_study_minutes, preferred_start_time, preferred_end_time
  into v_exam_type, v_daily_minutes, v_start, v_end
  from students where user_id = v_uid;

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

  v_window_minutes := (extract(epoch from (v_end - v_start)) / 60)::int;
  if v_window_minutes <= 0 then
    v_window_minutes := v_window_minutes + 24 * 60;
  end if;
  v_window_minutes := greatest(coalesce(v_window_minutes, v_daily_minutes, 120), 30);
  v_window_minutes := least(v_window_minutes, 720);

  v_total_minutes := v_window_minutes + coalesce(p_extra_minutes, 0);

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

  -- DÜZELTİLDİ: `t.parent_id is not null` yerine doğru "yaprak konu" tanımı.
  v_pass := 0;
  loop
    v_pass := v_pass + 1;
    exit when v_learn_minutes < v_block_minutes or v_pass > v_max_passes;
    v_inserted_this_pass := false;
    for v_topic in
      select t.id as topic_id, t.subject_id
      from topics t
      join subjects s on s.id = t.subject_id
      left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
      where s.exam_type = v_exam_type and t.status = 'active'
        and not exists (select 1 from topics c where c.parent_id = t.id)
        and (tp.knowledge_score is null or tp.knowledge_score < 60)
      order by coalesce(tp.knowledge_score, -1) asc, t.weight desc
    loop
      exit when v_learn_minutes < v_block_minutes;
      insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, order_index)
      values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'konu_ogrenme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, v_order);
      v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
      v_order := v_order + 1;
      v_learn_minutes := v_learn_minutes - v_block_minutes;
      v_inserted_this_pass := true;
    end loop;
    exit when not v_inserted_this_pass;
  end loop;

  v_practice_minutes := v_practice_minutes + greatest(v_learn_minutes, 0) + greatest(v_review_minutes, 0);
  v_pass := 0;
  loop
    v_pass := v_pass + 1;
    exit when v_practice_minutes < v_block_minutes or v_pass > v_max_passes;
    v_inserted_this_pass := false;
    for v_topic in
      select t.id as topic_id, t.subject_id
      from topics t
      join subjects s on s.id = t.subject_id
      left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
      where s.exam_type = v_exam_type and t.status = 'active'
        and not exists (select 1 from topics c where c.parent_id = t.id)
      order by coalesce(tp.knowledge_score, 0) asc
    loop
      exit when v_practice_minutes < v_block_minutes;
      insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, question_target, order_index)
      values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'soru_cozme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, 15, v_order);
      v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
      v_order := v_order + 1;
      v_practice_minutes := v_practice_minutes - v_block_minutes;
      v_inserted_this_pass := true;
    end loop;
    exit when not v_inserted_this_pass;
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
  where s.exam_type = v_exam_type and t.status = 'active'
    and not exists (select 1 from topics c where c.parent_id = t.id)
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
