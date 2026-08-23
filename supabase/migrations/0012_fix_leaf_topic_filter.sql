-- Düzeltme: "alt konu" filtresi yanlışlıkla parent_id IS NOT NULL olarak yazılmıştı.
-- Bu MVP'nin seed verisinde konular düz (nesting olmadan) tanımlı — yani parent_id NULL
-- olan konular da gerçek, sorulu/pratik yapılabilir "yaprak" konulardır. Doğru tanım:
-- bir konu, kendi altında başka konu yoksa (children yoksa) bir "yaprak" konudur —
-- bu hem düz hem gelecekte iç içe (nested) müfredat yapısını doğru şekilde destekler.

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

  select exam_type, daily_study_minutes, preferred_start_time, preferred_end_time
  into v_exam_type, v_daily_minutes, v_start, v_end
  from students where user_id = v_uid;

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
  end loop;

  v_practice_minutes := v_practice_minutes + greatest(v_learn_minutes, 0);
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

  select exam_type into v_exam_type from students where user_id = v_uid;
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

create or replace function public.ai_assistant_ask(p_message text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_msg text := lower(p_message);
  v_topic record;
  v_mistake record;
  v_weak_topic_name text;
  v_exam_type exam_type;
  v_exam_days int;
  v_response text;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  select exam_type into v_exam_type from students where user_id = v_uid;

  select t.id, t.name, tp.knowledge_score into v_topic
  from topics t left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
  join subjects s on s.id = t.subject_id
  where s.exam_type = v_exam_type
    and not exists (select 1 from topics c where c.parent_id = t.id)
    and lower(t.name) like '%' || v_msg || '%'
  limit 1;

  if v_topic.id is not null then
    if v_topic.knowledge_score is null or v_topic.knowledge_score < 40 then
      v_response := format('%s konusunda henüz güçlü değilsin (bilgi skoru: %%%s). Önce özet ve örnek soruyu incele, sonra kolay seviyeden başlayarak soru çöz.', v_topic.name, round(coalesce(v_topic.knowledge_score,0)));
    elsif v_topic.knowledge_score < 70 then
      v_response := format('%s konusunda orta seviyedesin (bilgi skoru: %%%s). Yanlışlarını gözden geçirip orta zorlukta 15-20 soru çözmen iyi olur.', v_topic.name, round(v_topic.knowledge_score));
    else
      v_response := format('%s konusunda iyi durumdasın (bilgi skoru: %%%s). Bilgini pekiştirmek için zor sorularla ve zamanlı tekrarla devam et.', v_topic.name, round(v_topic.knowledge_score));
    end if;

  elsif v_msg like '%yanlış%' or v_msg like '%neden%' then
    select q.detailed_solution, q.question_text, t.name as topic_name into v_mistake
    from mistakes m join questions q on q.id = m.question_id join topics t on t.id = m.topic_id
    where m.user_id = v_uid order by m.created_at desc limit 1;

    if v_mistake.question_text is null then
      v_response := 'Henüz kayıtlı bir yanlışın yok — soru çözmeye başladığında burada analiz edebilirim.';
    else
      v_response := format('Son yanlışın "%s" konusundaydı. Açıklama: %s', v_mistake.topic_name, coalesce(v_mistake.detailed_solution, 'Detaylı çözüm henüz eklenmedi.'));
    end if;

  elsif v_msg like '%ne çalış%' or v_msg like '%bugün%' or v_msg like '%yarın%' or v_msg like '%sınav%' then
    select e.exam_date - current_date into v_exam_days from exams e
    where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;

    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    if v_weak_topic_name is null then
      v_response := 'Henüz yeterli veri yok. Birkaç soru çözünce sana en zayıf konunu önerebilirim.';
    else
      v_response := format('En zayıf konun "%s". %s Bugün bu konudan 20 soru çözmeni öneririm.',
        v_weak_topic_name,
        case when v_exam_days is not null then format('Sınavına %s gün kaldı.', v_exam_days) else '' end);
    end if;

  else
    v_response := 'Merhaba! Bana bir konu adı sorabilir, "bugün ne çalışmalıyım" diyebilir ya da son yanlışını sorabilirsin.';
  end if;

  insert into ai_interactions (user_id, message, response) values (v_uid, p_message, v_response);
  return jsonb_build_object('response', v_response);
end;
$$;
