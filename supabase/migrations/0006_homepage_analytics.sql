-- Ana sayfa (9 bölüm), analiz paneli, bildirim okundu işaretleme, AI asistan

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

  select p.full_name, s.exam_type into v_name, v_exam_type
  from profiles p join students s on s.user_id = p.id where p.id = v_uid;

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

create or replace function public.get_analytics()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_total int; v_correct int; v_success numeric;
  v_best record; v_worst record;
  v_this_week jsonb; v_last_week jsonb;
  v_subject_breakdown jsonb;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select count(*), count(*) filter (where is_correct) into v_total, v_correct from user_answers where user_id = v_uid;
  v_success := case when v_total = 0 then 0 else round((v_correct::numeric/v_total)*100,1) end;

  select sub.name as name, avg(tp.knowledge_score) as avg_score
  into v_best
  from topic_progress tp join topics t on t.id = tp.topic_id join subjects sub on sub.id = t.subject_id
  where tp.user_id = v_uid
  group by sub.name order by avg_score desc limit 1;

  select sub.name as name, avg(tp.knowledge_score) as avg_score
  into v_worst
  from topic_progress tp join topics t on t.id = tp.topic_id join subjects sub on sub.id = t.subject_id
  where tp.user_id = v_uid
  group by sub.name order by avg_score asc limit 1;

  select jsonb_build_object(
    'questions', count(*), 'minutes', coalesce((select sum(actual_minutes) from study_sessions ss join study_plans sp on sp.id=ss.study_plan_id where sp.user_id=v_uid and sp.plan_date >= current_date - 6 and ss.status='done'),0),
    'success', case when count(*)=0 then 0 else round((count(*) filter (where is_correct)::numeric/count(*))*100,1) end
  ) into v_this_week
  from user_answers where user_id = v_uid and answered_at >= current_date - 6;

  select jsonb_build_object(
    'questions', count(*), 'minutes', coalesce((select sum(actual_minutes) from study_sessions ss join study_plans sp on sp.id=ss.study_plan_id where sp.user_id=v_uid and sp.plan_date between current_date-13 and current_date-7 and ss.status='done'),0),
    'success', case when count(*)=0 then 0 else round((count(*) filter (where is_correct)::numeric/count(*))*100,1) end
  ) into v_last_week
  from user_answers where user_id = v_uid and answered_at >= current_date - 13 and answered_at < current_date - 6;

  select coalesce(jsonb_agg(row_to_json(sb)), '[]'::jsonb) into v_subject_breakdown
  from (
    select sub.name, sub.icon, sub.color, avg(tp.knowledge_score) as avg_score, count(*) as topic_count
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects sub on sub.id = t.subject_id
    where tp.user_id = v_uid
    group by sub.name, sub.icon, sub.color
  ) sb;

  return jsonb_build_object(
    'total_questions', v_total, 'success_rate', v_success,
    'best_subject', case when v_best.name is null then null else v_best.name end,
    'worst_subject', case when v_worst.name is null then null else v_worst.name end,
    'this_week', v_this_week, 'last_week', v_last_week,
    'subject_breakdown', v_subject_breakdown
  );
end;
$$;

create or replace function public.mark_notification_read(p_id uuid)
returns void
language sql
security definer
set search_path = public
as $$
  update notifications set is_read = true where id = p_id and user_id = auth.uid();
$$;

create or replace function public.mark_all_notifications_read()
returns void
language sql
security definer
set search_path = public
as $$
  update notifications set is_read = true where user_id = auth.uid() and is_read = false;
$$;

-- Kural tabanlı AI çalışma asistanı — gerçek performans verisine göre kişiselleştirilmiş yanıt.
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
  where s.exam_type = v_exam_type and t.parent_id is not null and lower(t.name) like '%' || v_msg || '%'
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
