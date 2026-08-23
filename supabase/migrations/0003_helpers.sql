-- Yardımcı fonksiyonlar: kullanıcı oluşturma, skor→seviye, bildirim (spam korumalı), event log

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, email, role)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''), new.email, 'student');
  insert into public.students (user_id, exam_type)
  values (new.id, coalesce((new.raw_user_meta_data->>'exam_type')::exam_type, 'kpss_lisans'));
  insert into public.user_gamification (user_id) values (new.id);
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

create or replace function public.score_to_level(p_score numeric)
returns learning_level
language sql
immutable
set search_path = public
as $$
  select case
    when p_score <= 20 then 'baslangic'::learning_level
    when p_score <= 40 then 'gelistirilmeli'::learning_level
    when p_score <= 60 then 'orta'::learning_level
    when p_score <= 80 then 'iyi'::learning_level
    else 'cok_iyi'::learning_level
  end;
$$;

-- Spam korumalı bildirim: yeni değer eski değere eşitse bildirim üretmez.
create or replace function public.notify_user(
  p_user_id uuid, p_event_type notification_event_type, p_priority notification_priority,
  p_title text, p_body text, p_related_id uuid default null,
  p_old_value text default null, p_new_value text default null
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_old_value is not null and p_new_value is not null and p_old_value = p_new_value then
    return; -- değişiklik yok, bildirim yok
  end if;
  insert into public.notifications (user_id, event_type, priority, title, body, related_id)
  values (p_user_id, p_event_type, p_priority, p_title, p_body, p_related_id);
end;
$$;

create or replace function public.log_system_event(p_event_type notification_event_type, p_payload jsonb)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare v_id uuid;
begin
  insert into public.system_events (event_type, payload) values (p_event_type, p_payload) returning id into v_id;
  return v_id;
end;
$$;

create or replace function public.touch_streak(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare v_last date; v_streak int; v_longest int;
begin
  select last_activity_date, current_streak, longest_streak into v_last, v_streak, v_longest
  from user_gamification where user_id = p_user_id;

  if v_last is null then
    v_streak := 1;
  elsif v_last = current_date then
    return;
  elsif v_last = current_date - 1 then
    v_streak := v_streak + 1;
  else
    v_streak := 1;
  end if;

  update user_gamification
  set current_streak = v_streak,
      longest_streak = greatest(coalesce(v_longest,0), v_streak),
      last_activity_date = current_date
  where user_id = p_user_id;
end;
$$;

create or replace function public.add_xp(p_user_id uuid, p_amount int)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update user_gamification
  set xp = xp + p_amount,
      level = floor((xp + p_amount) / 200.0) + 1
  where user_id = p_user_id;
end;
$$;

create or replace function public.check_achievements(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare v_total_answers int; v_streak int;
begin
  select count(*) into v_total_answers from user_answers where user_id = p_user_id;
  select current_streak into v_streak from user_gamification where user_id = p_user_id;

  if v_total_answers = 1 then
    insert into user_achievements (user_id, achievement_id)
    select p_user_id, id from achievements where code = 'ilk_soru'
    on conflict do nothing;
  end if;
  if v_total_answers = 100 then
    insert into user_achievements (user_id, achievement_id)
    select p_user_id, id from achievements where code = 'yuz_soru'
    on conflict do nothing;
  end if;
  if v_total_answers = 1000 then
    insert into user_achievements (user_id, achievement_id)
    select p_user_id, id from achievements where code = 'bin_soru'
    on conflict do nothing;
  end if;
  if v_streak = 7 then
    insert into user_achievements (user_id, achievement_id)
    select p_user_id, id from achievements where code = 'yedi_gun_seri'
    on conflict do nothing;
  end if;
  if v_streak = 30 then
    insert into user_achievements (user_id, achievement_id)
    select p_user_id, id from achievements where code = 'otuz_gun_seri'
    on conflict do nothing;
  end if;
end;
$$;

-- KnowledgeScore (LearningScore) hesaplama — ağırlıklı, algorithm_weights'ten okunur.
create or replace function public.recalc_topic_progress(p_user_id uuid, p_topic_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  w_accuracy numeric; w_last_test numeric; w_repetition numeric; w_time numeric;
  w_wrong numeric; w_self numeric; w_video numeric;
  v_correct int; v_total int; v_wrong int; v_avg_time numeric; v_self boolean;
  v_last_test numeric; v_video int;
  v_accuracy_score numeric; v_time_score numeric; v_wrong_score numeric; v_self_score numeric; v_video_score numeric;
  v_rep_total int; v_rep_success int; v_repetition_score numeric;
  v_final numeric;
begin
  select weight into w_accuracy from algorithm_weights where key = 'accuracy';
  select weight into w_last_test from algorithm_weights where key = 'last_test';
  select weight into w_repetition from algorithm_weights where key = 'repetition';
  select weight into w_time from algorithm_weights where key = 'time';
  select weight into w_wrong from algorithm_weights where key = 'wrong_count';
  select weight into w_self from algorithm_weights where key = 'self_assessment';
  select weight into w_video from algorithm_weights where key = 'video';

  select correct_count, total_questions, wrong_count, avg_time_seconds, self_assessed, last_test_score, video_interactions
  into v_correct, v_total, v_wrong, v_avg_time, v_self, v_last_test, v_video
  from topic_progress where user_id = p_user_id and topic_id = p_topic_id;

  if v_total is null or v_total = 0 then
    v_accuracy_score := 0;
  else
    v_accuracy_score := (v_correct::numeric / v_total) * 100;
  end if;

  v_time_score := greatest(0, least(100, 100 - (coalesce(v_avg_time,30) - 30) * 1.2));
  v_wrong_score := greatest(0, 100 - coalesce(v_wrong,0) * 5);
  v_self_score := case when v_self then 100 else 0 end;
  v_video_score := least(100, coalesce(v_video,0) * 25);

  select count(*), count(*) filter (where status = 'completed')
  into v_rep_total, v_rep_success
  from repetitions where user_id = p_user_id and topic_id = p_topic_id and status <> 'pending';

  if v_rep_total is null or v_rep_total = 0 then
    v_repetition_score := v_accuracy_score;
  else
    v_repetition_score := (v_rep_success::numeric / v_rep_total) * 100;
  end if;

  v_final :=
    coalesce(w_accuracy,0.30) * v_accuracy_score +
    coalesce(w_last_test,0.20) * coalesce(v_last_test, v_accuracy_score) +
    coalesce(w_repetition,0.15) * v_repetition_score +
    coalesce(w_time,0.10) * v_time_score +
    coalesce(w_wrong,0.10) * v_wrong_score +
    coalesce(w_self,0.10) * v_self_score +
    coalesce(w_video,0.05) * v_video_score;

  update topic_progress
  set knowledge_score = round(v_final, 2),
      learning_level = score_to_level(round(v_final,2)),
      updated_at = now()
  where user_id = p_user_id and topic_id = p_topic_id;
end;
$$;
