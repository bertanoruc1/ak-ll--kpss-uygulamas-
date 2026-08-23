-- Data Sync Engine destek fonksiyonları + Admin işlemleri (curriculum/exam override, AI onay kuyruğu)

-- Adjust replan_due_to_event to also allow the Edge Function's service_role caller.
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
  if not (coalesce(is_admin(), false) or auth.role() = 'service_role') then
    raise exception 'unauthorized';
  end if;

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

-- Edge Function tarafından çağrılır (service_role): kaynağın kontrol sonucunu kaydeder.
create or replace function public.record_sync_check(
  p_source_id uuid, p_status sync_status, p_new_hash text, p_diff_summary text default null, p_confidence numeric default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare v_log_id uuid;
begin
  if not (coalesce(is_admin(), false) or auth.role() = 'service_role') then
    raise exception 'unauthorized';
  end if;

  update data_sources set last_checked_at = now(), last_status = p_status,
    last_content_hash = coalesce(p_new_hash, last_content_hash)
  where id = p_source_id;

  insert into sync_log (source_id, status, new_hash, diff_summary, confidence)
  values (p_source_id, p_status, p_new_hash, p_diff_summary, p_confidence)
  returning id into v_log_id;

  return v_log_id;
end;
$$;

-- Sınav alanı güncelleme (hem sync engine hem admin manuel override için tek giriş noktası).
-- Kritik alan (exam_date, application_start/end) için düşük güvenle otomatik uygulanmaz.
create or replace function public.apply_exam_field_change(
  p_exam_id uuid, p_field_name text, p_new_value text,
  p_source text, p_source_url text, p_confidence numeric, p_applied_by applied_by_type
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_old_value text;
  v_allowed text[] := array['exam_date','application_start','application_end','late_application_date','result_date','name'];
  v_event_id uuid;
begin
  if p_applied_by = 'admin' then
    if not is_admin() then raise exception 'unauthorized'; end if;
  else
    if not auth.role() = 'service_role' then raise exception 'unauthorized'; end if;
  end if;

  if not (p_field_name = any(v_allowed)) then
    raise exception 'invalid field_name: %', p_field_name;
  end if;

  execute format('select %I::text from exams where id = $1', p_field_name) into v_old_value using p_exam_id;

  if v_old_value is not distinct from p_new_value then
    return jsonb_build_object('applied', false, 'reason', 'no_change');
  end if;

  -- Düşük güvenli otomatik tespitler admin onayına düşer, tabloya doğrudan yazılmaz.
  if p_applied_by = 'sync_engine' and coalesce(p_confidence, 0) < 0.85 then
    insert into exam_change_log (exam_id, field_name, old_value, new_value, source, source_url, confidence, applied_by)
    values (p_exam_id, p_field_name, v_old_value, p_new_value, p_source, p_source_url, p_confidence, 'sync_engine');
    insert into admin_audit_log (actor_type, action, table_name, record_id, old_data, new_data)
    values ('sync_engine', 'pending_review', 'exams', p_exam_id,
      jsonb_build_object(p_field_name, v_old_value), jsonb_build_object(p_field_name, p_new_value, 'confidence', p_confidence, 'source', p_source));
    return jsonb_build_object('applied', false, 'reason', 'low_confidence_pending_review');
  end if;

  if p_field_name in ('exam_date','application_start','application_end','late_application_date','result_date') then
    execute format('update exams set %I = $1::date, last_verified_at = now(), version = version + 1, source = coalesce($2, source), source_url = coalesce($3, source_url), confidence = $4 where id = $5', p_field_name)
      using p_new_value, p_source, p_source_url, coalesce(p_confidence,1.0), p_exam_id;
  else
    execute format('update exams set %I = $1, last_verified_at = now(), version = version + 1, source = coalesce($2, source), source_url = coalesce($3, source_url), confidence = $4 where id = $5', p_field_name)
      using p_new_value, p_source, p_source_url, coalesce(p_confidence,1.0), p_exam_id;
  end if;

  insert into exam_change_log (exam_id, field_name, old_value, new_value, source, source_url, confidence, applied_by)
  values (p_exam_id, p_field_name, v_old_value, p_new_value, p_source, p_source_url, coalesce(p_confidence,1.0), p_applied_by);

  insert into admin_audit_log (actor_type, action, table_name, record_id, old_data, new_data)
  values (p_applied_by, 'update', 'exams', p_exam_id, jsonb_build_object(p_field_name, v_old_value), jsonb_build_object(p_field_name, p_new_value));

  if p_field_name = 'exam_date' then
    v_event_id := log_system_event('EXAM_DATE_CHANGED', jsonb_build_object(
      'exam_id', p_exam_id, 'old_value', v_old_value, 'new_value', p_new_value,
      'message', format('Sınav tarihi %s → %s olarak güncellendi.', v_old_value, p_new_value)
    ));
    perform replan_due_to_event(v_event_id);
  end if;

  return jsonb_build_object('applied', true);
end;
$$;

-- Müfredat değişikliği uygulama (ekleme/kaldırma/yeniden adlandırma/kazanım/ağırlık).
create or replace function public.apply_curriculum_change(
  p_change_type curriculum_change_type, p_topic_id uuid default null, p_subject_id uuid default null,
  p_name text default null, p_slug text default null, p_kazanim_text text default null, p_weight numeric default null,
  p_source text default null, p_source_url text default null, p_confidence numeric default null, p_applied_by applied_by_type default 'admin'
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_topic_id uuid := p_topic_id;
  v_old_value text; v_new_value text;
  v_event_id uuid;
begin
  if p_applied_by = 'admin' then
    if not is_admin() then raise exception 'unauthorized'; end if;
  else
    if not auth.role() = 'service_role' then raise exception 'unauthorized'; end if;
  end if;

  if p_change_type = 'added' then
    insert into topics (subject_id, parent_id, name, slug, kazanim_text, status, weight)
    values (p_subject_id, null, p_name, coalesce(p_slug, lower(regexp_replace(p_name,'[^a-zA-Z0-9]+','-','g'))), p_kazanim_text, 'icerik_bekliyor', coalesce(p_weight,1.0))
    returning id into v_topic_id;
    v_new_value := p_name;

    insert into curriculum_change_log (topic_id, change_type, new_value, source, source_url, confidence, applied_by)
    values (v_topic_id, 'added', v_new_value, p_source, p_source_url, coalesce(p_confidence,1.0), p_applied_by);

    v_event_id := log_system_event('NEW_TOPIC_ADDED', jsonb_build_object('topic_id', v_topic_id, 'message', format('Yeni konu eklendi: %s', p_name)));
    perform replan_due_to_event(v_event_id);
    return jsonb_build_object('applied', true, 'topic_id', v_topic_id);
  end if;

  if v_topic_id is null then raise exception 'topic_id required'; end if;

  if p_applied_by = 'sync_engine' and coalesce(p_confidence,0) < 0.70 then
    insert into curriculum_change_log (topic_id, change_type, new_value, source, source_url, confidence, applied_by)
    values (v_topic_id, p_change_type, coalesce(p_name, p_kazanim_text, p_weight::text), p_source, p_source_url, p_confidence, 'sync_engine');
    insert into admin_audit_log (actor_type, action, table_name, record_id, new_data)
    values ('sync_engine', 'pending_review', 'topics', v_topic_id, jsonb_build_object('change_type', p_change_type, 'confidence', p_confidence));
    return jsonb_build_object('applied', false, 'reason', 'low_confidence_pending_review');
  end if;

  if p_change_type = 'removed' then
    select name into v_old_value from topics where id = v_topic_id;
    update topics set status = 'kaldirildi', version = version + 1, updated_at = now() where id = v_topic_id;
    v_new_value := 'kaldirildi';
  elsif p_change_type = 'renamed' then
    select name into v_old_value from topics where id = v_topic_id;
    update topics set name = p_name, version = version + 1, updated_at = now() where id = v_topic_id;
    v_new_value := p_name;
  elsif p_change_type = 'kazanim_changed' then
    select kazanim_text into v_old_value from topics where id = v_topic_id;
    update topics set kazanim_text = p_kazanim_text, version = version + 1, updated_at = now() where id = v_topic_id;
    v_new_value := p_kazanim_text;
  elsif p_change_type = 'weight_changed' then
    select weight::text into v_old_value from topics where id = v_topic_id;
    update topics set weight = p_weight, version = version + 1, updated_at = now() where id = v_topic_id;
    v_new_value := p_weight::text;
  end if;

  insert into curriculum_change_log (topic_id, change_type, old_value, new_value, source, source_url, confidence, applied_by)
  values (v_topic_id, p_change_type, v_old_value, v_new_value, p_source, p_source_url, coalesce(p_confidence,1.0), p_applied_by);

  v_event_id := log_system_event('CURRICULUM_CHANGED', jsonb_build_object('topic_id', v_topic_id, 'message', format('%s güncellendi.', coalesce(v_new_value,''))));
  perform replan_due_to_event(v_event_id);

  return jsonb_build_object('applied', true, 'topic_id', v_topic_id);
end;
$$;

-- AI içerik onay kuyruğu
create or replace function public.generate_ai_draft_from_news(p_news_id uuid, p_content_type ai_content_type)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_news record;
  v_draft jsonb;
  v_id uuid;
begin
  if not is_admin() then raise exception 'unauthorized'; end if;

  select * into v_news from news_items where id = p_news_id;
  if v_news.id is null then raise exception 'news not found'; end if;

  if p_content_type = 'flashcard' then
    v_draft := jsonb_build_object('front', v_news.title, 'back', coalesce(v_news.summary, left(v_news.body, 280)));
  elsif p_content_type = 'summary' then
    v_draft := jsonb_build_object('summary', coalesce(v_news.summary, left(v_news.body, 400)));
  else
    v_draft := jsonb_build_object('question_text', format('%s ile ilgili aşağıdakilerden hangisi doğrudur?', v_news.title), 'source_hint', v_news.summary);
  end if;

  insert into ai_content_queue (source_news_id, content_type, draft_content, status)
  values (p_news_id, p_content_type, v_draft, 'ai_generated')
  returning id into v_id;

  return v_id;
end;
$$;

create or replace function public.approve_ai_content(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not is_admin() then raise exception 'unauthorized'; end if;
  update ai_content_queue set status = 'published', reviewed_by = auth.uid(), reviewed_at = now() where id = p_id;
  insert into admin_audit_log (actor, action, table_name, record_id) values (auth.uid(), 'approve_ai_content', 'ai_content_queue', p_id);
end;
$$;

create or replace function public.reject_ai_content(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not is_admin() then raise exception 'unauthorized'; end if;
  update ai_content_queue set status = 'rejected', reviewed_by = auth.uid(), reviewed_at = now() where id = p_id;
  insert into admin_audit_log (actor, action, table_name, record_id) values (auth.uid(), 'reject_ai_content', 'ai_content_queue', p_id);
end;
$$;
