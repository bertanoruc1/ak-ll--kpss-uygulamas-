-- Study Planner: sınav yakınlığına duyarlı program üretimi, kaçırılan çalışmanın
-- dengeli dağıtımı, event-reaktif yeniden planlama, tek öncelik önerisi.

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

create or replace function public.reschedule_missed_study(p_missed_date date)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_planned int; v_done int; v_missed int;
  v_per_day int; v_i int;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select coalesce(sp.total_minutes,0) into v_planned from study_plans sp where sp.user_id = v_uid and sp.plan_date = p_missed_date;
  select coalesce(sum(ss.actual_minutes),0) into v_done
  from study_sessions ss join study_plans sp on sp.id = ss.study_plan_id
  where sp.user_id = v_uid and sp.plan_date = p_missed_date and ss.status = 'done';

  v_missed := greatest(0, coalesce(v_planned,0) - coalesce(v_done,0));
  if v_missed = 0 then
    return jsonb_build_object('missed_minutes', 0);
  end if;

  perform generate_study_plan(p_missed_date + 1, least(v_missed, 30));
  v_missed := v_missed - least(v_missed, 30);

  if v_missed > 0 then
    v_per_day := least(20, ceil(v_missed / 6.0));
    for v_i in 2..7 loop
      exit when v_missed <= 0;
      perform generate_study_plan(p_missed_date + v_i, least(v_missed, v_per_day));
      v_missed := v_missed - least(v_missed, v_per_day);
    end loop;
  end if;

  perform notify_user(v_uid, 'MISSED_STUDY', 'dusuk', 'Kaçırılan çalışma yeniden dağıtıldı',
    'Dünkü eksik çalışma süren önümüzdeki günlere dengeli şekilde eklendi.', null);

  return jsonb_build_object('missed_minutes', greatest(0,coalesce(v_planned,0) - coalesce(v_done,0)));
end;
$$;

-- Tek öncelik önerisi: en düşük skor + en uzun süredir tekrar edilmemiş + sınav yakınlığı
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

-- Event-reaktif yeniden planlama (admin / sync engine tarafından tetiklenir)
create or replace function public.replan_due_to_event(p_event_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_event record;
  v_exam_id uuid; v_exam_type exam_type;
  v_student record;
  v_affected int := 0;
begin
  if not is_admin() then raise exception 'unauthorized'; end if;

  select * into v_event from system_events where id = p_event_id;
  if v_event.id is null then raise exception 'event not found'; end if;

  if v_event.event_type = 'EXAM_DATE_CHANGED' then
    v_exam_id := (v_event.payload->>'exam_id')::uuid;
    select exam_type into v_exam_type from exams where id = v_exam_id;

    for v_student in select user_id from students where exam_type = v_exam_type loop
      insert into study_plans (user_id, plan_date, total_minutes)
      values (v_student.user_id, current_date, 0)
      on conflict (user_id, plan_date) do nothing;
      perform notify_user(v_student.user_id, 'EXAM_DATE_CHANGED', 'kritik',
        'Sınav tarihi güncellendi',
        coalesce(v_event.payload->>'message', 'Sınav tarihinde değişiklik tespit edildi, çalışma planın buna göre yeniden hesaplandı.'),
        v_exam_id, v_event.payload->>'old_value', v_event.payload->>'new_value');
      v_affected := v_affected + 1;
    end loop;

  elsif v_event.event_type = 'NEW_TOPIC_ADDED' then
    for v_student in
      select st.user_id from students st
      join topics t on t.id = (v_event.payload->>'topic_id')::uuid
      join subjects s on s.id = t.subject_id and s.exam_type = st.exam_type
    loop
      perform notify_user(v_student.user_id, 'NEW_TOPIC_ADDED', 'normal',
        'Müfredata yeni konu eklendi', coalesce(v_event.payload->>'message', 'Yeni bir konu eklendi.'),
        (v_event.payload->>'topic_id')::uuid);
      v_affected := v_affected + 1;
    end loop;

  elsif v_event.event_type = 'CURRICULUM_CHANGED' then
    for v_student in
      select st.user_id from students st
      join topics t on t.id = (v_event.payload->>'topic_id')::uuid
      join subjects s on s.id = t.subject_id and s.exam_type = st.exam_type
    loop
      perform notify_user(v_student.user_id, 'CURRICULUM_CHANGED', 'onemli',
        'Müfredatta değişiklik', coalesce(v_event.payload->>'message', 'İlgili konuda güncelleme var.'),
        (v_event.payload->>'topic_id')::uuid);
      v_affected := v_affected + 1;
    end loop;
  end if;

  update system_events set processed_at = now() where id = p_event_id;
  return jsonb_build_object('affected_students', v_affected);
end;
$$;
