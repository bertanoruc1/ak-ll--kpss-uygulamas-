-- Öğrenci tarafı öğrenme RPC'leri: soru cevaplama, öz değerlendirme, tekrar, video, mini test

create or replace function public.submit_answer(p_question_id uuid, p_choice_id uuid, p_time_spent_seconds int default 0)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_topic_id uuid;
  v_correct_choice_id uuid;
  v_correct_choice_text text;
  v_is_correct boolean;
  v_score numeric; v_level learning_level;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select topic_id into v_topic_id from questions where id = p_question_id;
  if v_topic_id is null then raise exception 'question not found'; end if;

  select id, choice_text into v_correct_choice_id, v_correct_choice_text
  from question_choices where question_id = p_question_id and is_correct = true limit 1;

  v_is_correct := (p_choice_id = v_correct_choice_id);

  insert into user_answers (user_id, question_id, choice_id, is_correct, time_spent_seconds)
  values (v_uid, p_question_id, p_choice_id, v_is_correct, p_time_spent_seconds);

  if not v_is_correct then
    insert into mistakes (user_id, question_id, topic_id, resolved)
    values (v_uid, p_question_id, v_topic_id, false);
  else
    update mistakes set resolved = true, resolved_at = now()
    where user_id = v_uid and question_id = p_question_id and resolved = false;
  end if;

  insert into topic_progress (user_id, topic_id, total_questions, correct_count, wrong_count, avg_time_seconds, last_studied_at)
  values (v_uid, v_topic_id, 1, case when v_is_correct then 1 else 0 end, case when v_is_correct then 0 else 1 end, p_time_spent_seconds, now())
  on conflict (user_id, topic_id) do update set
    total_questions = topic_progress.total_questions + 1,
    correct_count = topic_progress.correct_count + case when v_is_correct then 1 else 0 end,
    wrong_count = topic_progress.wrong_count + case when v_is_correct then 0 else 1 end,
    avg_time_seconds = ((topic_progress.avg_time_seconds * topic_progress.total_questions) + p_time_spent_seconds) / (topic_progress.total_questions + 1),
    last_studied_at = now();

  perform recalc_topic_progress(v_uid, v_topic_id);
  perform touch_streak(v_uid);
  perform add_xp(v_uid, case when v_is_correct then 10 else 3 end);
  perform check_achievements(v_uid);

  select knowledge_score, learning_level into v_score, v_level from topic_progress where user_id = v_uid and topic_id = v_topic_id;

  return jsonb_build_object(
    'is_correct', v_is_correct,
    'correct_choice_id', v_correct_choice_id,
    'correct_choice_text', v_correct_choice_text,
    'topic_id', v_topic_id,
    'knowledge_score', v_score,
    'learning_level', v_level
  );
end;
$$;

create or replace function public.mark_topic_understood(p_topic_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare v_uid uuid := auth.uid(); v_exists boolean;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  insert into topic_progress (user_id, topic_id, self_assessed, last_studied_at)
  values (v_uid, p_topic_id, true, now())
  on conflict (user_id, topic_id) do update set self_assessed = true, last_studied_at = now();

  perform recalc_topic_progress(v_uid, p_topic_id);

  select exists(select 1 from repetitions where user_id = v_uid and topic_id = p_topic_id) into v_exists;
  if not v_exists then
    insert into repetitions (user_id, topic_id, stage, scheduled_for, status)
    values (v_uid, p_topic_id, 1, current_date + 1, 'pending');
  end if;

  return jsonb_build_object('ok', true);
end;
$$;

create or replace function public.complete_repetition(p_repetition_id uuid, p_success boolean)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_topic_id uuid; v_stage int;
  v_ladder int[] := array[1,3,7,14,30];
  v_next_stage int; v_next_date date;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select topic_id, stage into v_topic_id, v_stage from repetitions
  where id = p_repetition_id and user_id = v_uid;
  if v_topic_id is null then raise exception 'repetition not found'; end if;

  if p_success then
    v_next_stage := least(v_stage + 1, 5);
    v_next_date := current_date + v_ladder[v_next_stage];
  else
    v_next_stage := 1;
    v_next_date := current_date + 3;
  end if;

  update repetitions
  set status = (case when p_success then 'completed' else 'failed' end)::repetition_status,
      completed_at = now()
  where id = p_repetition_id;

  insert into repetitions (user_id, topic_id, stage, scheduled_for, status)
  values (v_uid, v_topic_id, v_next_stage, v_next_date, 'pending');

  update topic_progress set review_stage = v_next_stage, next_review_at = v_next_date
  where user_id = v_uid and topic_id = v_topic_id;

  perform recalc_topic_progress(v_uid, v_topic_id);

  return jsonb_build_object('stage', v_next_stage, 'next_review_at', v_next_date);
end;
$$;

create or replace function public.get_next_question(p_topic_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_accuracy numeric;
  v_easy_pct int; v_med_pct int; v_hard_pct int;
  v_roll numeric;
  v_target_diff difficulty_level;
  v_question record;
  v_choices jsonb;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select case when total_questions = 0 then 50 else (correct_count::numeric/total_questions)*100 end
  into v_accuracy
  from topic_progress where user_id = v_uid and topic_id = p_topic_id;
  v_accuracy := coalesce(v_accuracy, 50);

  if v_accuracy >= 80 then v_easy_pct := 10; v_med_pct := 40; v_hard_pct := 50;
  elsif v_accuracy <= 40 then v_easy_pct := 50; v_med_pct := 40; v_hard_pct := 10;
  else v_easy_pct := 30; v_med_pct := 45; v_hard_pct := 25;
  end if;

  v_roll := random() * 100;
  if v_roll < v_easy_pct then v_target_diff := 'kolay';
  elsif v_roll < v_easy_pct + v_med_pct then v_target_diff := 'orta';
  else v_target_diff := 'zor';
  end if;

  select q.* into v_question from questions q
  where q.topic_id = p_topic_id and q.difficulty = v_target_diff
    and q.id not in (select question_id from user_answers where user_id = v_uid and answered_at > now() - interval '24 hours')
  order by random() limit 1;

  if v_question.id is null then
    select q.* into v_question from questions q
    where q.topic_id = p_topic_id
      and q.id not in (select question_id from user_answers where user_id = v_uid and answered_at > now() - interval '24 hours')
    order by random() limit 1;
  end if;

  if v_question.id is null then
    select q.* into v_question from questions q where q.topic_id = p_topic_id order by random() limit 1;
  end if;

  if v_question.id is null then
    return null;
  end if;

  select coalesce(jsonb_agg(jsonb_build_object('id', id, 'choice_text', choice_text) order by order_index), '[]'::jsonb)
  into v_choices
  from question_choices where question_id = v_question.id;

  return jsonb_build_object(
    'id', v_question.id, 'question_text', v_question.question_text, 'image_url', v_question.image_url,
    'difficulty', v_question.difficulty, 'kazanim', v_question.kazanim, 'choices', v_choices
  );
end;
$$;

-- Video izleme takibi — knowledge score'un %5'lik bileşenini gerçekten besler.
create or replace function public.mark_video_watched(p_topic_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  insert into topic_progress (user_id, topic_id, video_interactions, last_studied_at)
  values (v_uid, p_topic_id, 1, now())
  on conflict (user_id, topic_id) do update set
    video_interactions = topic_progress.video_interactions + 1,
    last_studied_at = now();
  perform recalc_topic_progress(v_uid, p_topic_id);
  return jsonb_build_object('ok', true);
end;
$$;

-- Mini test — konu başına ayrı bir "test" akışı, last_test_score'u gerçekten besler.
create or replace function public.submit_mini_test(p_topic_id uuid, p_answers jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_item jsonb;
  v_correct_id uuid;
  v_total int := 0; v_correct int := 0;
  v_score numeric;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  for v_item in select * from jsonb_array_elements(p_answers) loop
    v_total := v_total + 1;
    select id into v_correct_id from question_choices
    where question_id = (v_item->>'question_id')::uuid and is_correct = true limit 1;
    if v_correct_id::text = (v_item->>'choice_id') then
      v_correct := v_correct + 1;
    end if;
    insert into user_answers (user_id, question_id, choice_id, is_correct, time_spent_seconds)
    values (v_uid, (v_item->>'question_id')::uuid, (v_item->>'choice_id')::uuid,
            v_correct_id::text = (v_item->>'choice_id'), coalesce((v_item->>'time_spent_seconds')::int,0));
  end loop;

  if v_total = 0 then
    return jsonb_build_object('error', 'no_answers');
  end if;

  v_score := round((v_correct::numeric / v_total) * 100, 2);

  insert into topic_progress (user_id, topic_id, last_test_score, last_studied_at)
  values (v_uid, p_topic_id, v_score, now())
  on conflict (user_id, topic_id) do update set last_test_score = v_score, last_studied_at = now();

  perform recalc_topic_progress(v_uid, p_topic_id);
  perform touch_streak(v_uid);
  perform add_xp(v_uid, 15);

  return jsonb_build_object('correct', v_correct, 'total', v_total, 'score', v_score);
end;
$$;
