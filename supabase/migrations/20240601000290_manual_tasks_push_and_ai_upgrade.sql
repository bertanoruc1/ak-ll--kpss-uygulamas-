-- Bu migration beş şeyi bir araya getiriyor:
--   1) Ön Lisans / Ortaöğretim KPSS 2026 sınav tarihlerini doldurur (bkz. kaynaklar
--      aşağıda) — daha önce exam_date NULL olduğu için "sınava kaç gün kaldı"
--      sayacı bu iki sınav türünü seçen öğrencilere hiç görünmüyordu.
--   2) Kullanıcının GÜNÜN PROGRAMI'na kendi manuel görevini ekleyebilmesini
--      (ders/konu + başlangıç-bitiş saati) ve bu görev için gerçek bir tarayıcı
--      push bildirimi (hatırlatıcı) planlayabilmesini sağlar.
--   3) get_next_question'daki NOT IN → NOT EXISTS iyileştirmesi + eksik
--      user_answers(user_id, answered_at) kompozit index'i — "site yavaş"
--      şikayetinin backend tarafındaki katkısını azaltır (asıl büyük kazanım
--      auth.js'teki 3 ardışık network isteğinin paralelleştirilmesiydi).
--   4) AI Asistan'ı genişletir: yazım hatalarına toleranslı (trigram) konu/ders
--      eşleştirme + birkaç yeni niyet (yardım, en güçlü konu, bugün kaç soru).
--      NOT: Bu hâlâ kural tabanlı bir motor — gerçek, sınırsız/serbest sohbet
--      (Claude ile konuşur gibi) için gerçek bir LLM'e (ör. Claude API)
--      bağlanmak gerekir, bu da kullanıcının kendi API anahtarını vermesini
--      gerektirir. O bağlantı hazır olduğunda ai_assistant_ask'ı bir Edge
--      Function çağrısına yönlendirmek yeterli olacak.
--
-- Kaynaklar (Ön Lisans / Ortaöğretim tarihleri, 2026-08-24 itibarıyla,
-- ÖSYM resmi kılavuzuyla teyit edilmesi önerilir — bkz. confidence=0.85):
--   https://www.ekonomist.com.tr/egitim/kpss-2026-ne-zaman-kpss-ortaogretim-onlisans-lisans-basvuru-ve-sinav-tarihleri-73611
--   https://www.milliyet.com.tr/galeri/kpss-lise-ve-onlisans-takvimi-2026-kpss-ortaogretim-lise-sinavi-ve-onlisans-sinavi-ne-zaman-kpss-ortaogretim-ve-onlisans-7622324

begin;

-- ============================================================
-- 1) Ön Lisans / Ortaöğretim sınav tarihleri
-- ============================================================

insert into exam_change_log (exam_id, field_name, old_value, new_value, source, source_url, confidence, applied_by)
select id, 'exam_date', null, '2026-10-04',
  'Haber kaynakları (ekonomist.com.tr, milliyet.com.tr) — ÖSYM resmi kılavuzuyla teyit edilmeli',
  'https://www.ekonomist.com.tr/egitim/kpss-2026-ne-zaman-kpss-ortaogretim-onlisans-lisans-basvuru-ve-sinav-tarihleri-73611',
  0.85, 'admin'
from exams where exam_type = 'kpss_onlisans' and exam_date is null;

update exams set
  exam_date = '2026-10-04',
  application_start = '2026-07-29',
  application_end = '2026-08-10',
  source = 'Haber kaynakları (ekonomist.com.tr, milliyet.com.tr) — ÖSYM resmi kılavuzuyla teyit edilmeli',
  source_url = 'https://www.ekonomist.com.tr/egitim/kpss-2026-ne-zaman-kpss-ortaogretim-onlisans-lisans-basvuru-ve-sinav-tarihleri-73611',
  confidence = 0.85, last_verified_at = now(), version = version + 1
where exam_type = 'kpss_onlisans' and exam_date is null;

insert into exam_change_log (exam_id, field_name, old_value, new_value, source, source_url, confidence, applied_by)
select id, 'exam_date', null, '2026-10-25',
  'Haber kaynakları (ekonomist.com.tr, milliyet.com.tr) — ÖSYM resmi kılavuzuyla teyit edilmeli',
  'https://www.milliyet.com.tr/galeri/kpss-lise-ve-onlisans-takvimi-2026-kpss-ortaogretim-lise-sinavi-ve-onlisans-sinavi-ne-zaman-kpss-ortaogretim-ve-onlisans-7622324',
  0.85, 'admin'
from exams where exam_type = 'kpss_ortaogretim' and exam_date is null;

update exams set
  exam_date = '2026-10-25',
  application_start = '2026-08-27',
  application_end = '2026-09-08',
  source = 'Haber kaynakları (ekonomist.com.tr, milliyet.com.tr) — ÖSYM resmi kılavuzuyla teyit edilmeli',
  source_url = 'https://www.milliyet.com.tr/galeri/kpss-lise-ve-onlisans-takvimi-2026-kpss-ortaogretim-lise-sinavi-ve-onlisans-sinavi-ne-zaman-kpss-ortaogretim-ve-onlisans-7622324',
  confidence = 0.85, last_verified_at = now(), version = version + 1
where exam_type = 'kpss_ortaogretim' and exam_date is null;

-- ============================================================
-- 2) Performans: composite index + NOT IN -> NOT EXISTS
-- ============================================================

create index if not exists user_answers_user_answered_idx on user_answers(user_id, answered_at desc);

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
    and not exists (
      select 1 from user_answers ua
      where ua.user_id = v_uid and ua.question_id = q.id and ua.answered_at > now() - interval '24 hours'
    )
  order by random() limit 1;

  if v_question.id is null then
    select q.* into v_question from questions q
    where q.topic_id = p_topic_id
      and not exists (
        select 1 from user_answers ua
        where ua.user_id = v_uid and ua.question_id = q.id and ua.answered_at > now() - interval '24 hours'
      )
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

-- ============================================================
-- 3) Manuel görev ekleme ("Bugün Matematik'te EBOB-EKOK'a 12:00-14:00
--    arası çalışacağım" gibi kullanıcının kendi belirlediği görevler)
-- ============================================================

alter table study_sessions add column if not exists is_manual boolean not null default false;
alter table study_sessions add column if not exists reminder_sent boolean not null default false;

create index if not exists study_sessions_topic_idx on study_sessions(topic_id);
create index if not exists study_sessions_subject_idx on study_sessions(subject_id);

-- get_homepage'in "today_sessions" listesine is_manual eklendi — front-end
-- (dashboard.js) bunu, kullanıcının kendi eklediği görevlerin yanına bir
-- silme butonu koyabilmek için kullanıyor. Fonksiyonun geri kalanı
-- 20240601000270'teki hâliyle AYNI, sadece bu tek alan eklendi.
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
  v_target_ts timestamp;
  v_remaining_seconds numeric;
  v_days_left int; v_hours_left int; v_minutes_left int; v_seconds_left int;
  v_total_seconds_left bigint;
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

  select e.id, e.name, e.exam_date, e.exam_time, (e.exam_date - current_date) as days_left
  into v_exam
  from exams e where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
  order by e.exam_date asc limit 1;

  if v_exam.id is not null then
    v_target_ts := v_exam.exam_date + coalesce(v_exam.exam_time, '00:00:00'::time);
    v_remaining_seconds := greatest(0, extract(epoch from (v_target_ts - now()::timestamp)));
    v_days_left := floor(v_remaining_seconds / 86400)::int;
    v_hours_left := floor((v_remaining_seconds - v_days_left::numeric * 86400) / 3600)::int;
    v_minutes_left := floor((v_remaining_seconds - v_days_left::numeric * 86400 - v_hours_left::numeric * 3600) / 60)::int;
    v_seconds_left := floor(v_remaining_seconds - v_days_left::numeric * 86400 - v_hours_left::numeric * 3600 - v_minutes_left::numeric * 60)::int;
    v_total_seconds_left := floor(v_remaining_seconds)::bigint;
  end if;

  select n.id, n.title, n.summary, n.category, n.source, n.source_url, n.published_at
  into v_top_news
  from news_items n
  where n.is_learning_content = false
    and (n.exam_type is null or n.exam_type = v_exam_type)
  order by n.published_at desc limit 1;

  select coalesce(jsonb_agg(jsonb_build_object(
    'id', ss.id, 'session_type', ss.session_type, 'subject_id', ss.subject_id, 'topic_id', ss.topic_id,
    'planned_start', ss.planned_start, 'planned_end', ss.planned_end, 'duration_minutes', ss.duration_minutes,
    'status', ss.status, 'question_target', ss.question_target, 'is_manual', ss.is_manual,
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
    'exam', case when v_exam.id is null then null else jsonb_build_object(
      'id', v_exam.id, 'name', v_exam.name, 'exam_date', v_exam.exam_date, 'exam_time', v_exam.exam_time,
      'days_left', v_exam.days_left,
      'days_left_precise', v_days_left, 'hours_left', v_hours_left, 'minutes_left', v_minutes_left,
      'seconds_left', v_seconds_left, 'total_seconds_left', v_total_seconds_left
    ) end,
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
-- get_homepage zaten authenticated'e execute yetkisiyle tanımlıydı; imza
-- değişmediği için mevcut grant korunur, yeniden grant vermeye gerek yok.

create or replace function public.create_manual_session(
  p_subject_id uuid,
  p_topic_id uuid,
  p_session_type session_type,
  p_planned_start time,
  p_planned_end time,
  p_question_target int default null,
  p_plan_date date default current_date
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_plan_id uuid;
  v_duration int;
  v_order int;
  v_session_id uuid;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  if p_planned_start is null or p_planned_end is null then
    raise exception 'Başlangıç ve bitiş saati zorunludur';
  end if;
  if p_planned_end <= p_planned_start then
    raise exception 'Bitiş saati başlangıç saatinden sonra olmalı';
  end if;

  if p_topic_id is not null then
    perform 1 from topics t where t.id = p_topic_id and t.subject_id = p_subject_id;
    if not found then
      raise exception 'Geçersiz konu/ders eşleşmesi';
    end if;
  end if;

  insert into study_plans (user_id, plan_date, total_minutes)
  values (v_uid, p_plan_date, 0)
  on conflict (user_id, plan_date) do nothing;

  select id into v_plan_id from study_plans where user_id = v_uid and plan_date = p_plan_date;

  select coalesce(max(order_index), -1) + 1 into v_order from study_sessions where study_plan_id = v_plan_id;

  v_duration := greatest(1, (extract(epoch from (p_planned_end - p_planned_start)) / 60)::int);

  insert into study_sessions (
    study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end,
    duration_minutes, question_target, order_index, is_manual
  ) values (
    v_plan_id, p_subject_id, p_topic_id, p_session_type, p_planned_start, p_planned_end,
    v_duration, p_question_target, v_order, true
  )
  returning id into v_session_id;

  update study_plans set total_minutes = total_minutes + v_duration where id = v_plan_id;

  return jsonb_build_object('session_id', v_session_id, 'plan_id', v_plan_id);
end;
$$;

create or replace function public.delete_manual_session(p_session_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_minutes int;
  v_plan_id uuid;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select ss.duration_minutes, ss.study_plan_id into v_minutes, v_plan_id
  from study_sessions ss
  join study_plans sp on sp.id = ss.study_plan_id
  where ss.id = p_session_id and sp.user_id = v_uid and ss.is_manual = true;

  if v_plan_id is null then
    raise exception 'Görev bulunamadı veya silme yetkiniz yok';
  end if;

  delete from study_sessions where id = p_session_id;
  update study_plans set total_minutes = greatest(0, total_minutes - coalesce(v_minutes,0)) where id = v_plan_id;

  return jsonb_build_object('ok', true);
end;
$$;

revoke execute on function public.create_manual_session(uuid, uuid, session_type, time, time, int, date) from public, anon;
grant execute on function public.create_manual_session(uuid, uuid, session_type, time, time, int, date) to authenticated;
revoke execute on function public.delete_manual_session(uuid) from public, anon;
grant execute on function public.delete_manual_session(uuid) to authenticated;

-- ============================================================
-- 4) Push bildirimleri (gerçek tarayıcı hatırlatıcısı — sekme kapalıyken
--    de çalışır). Web Push standardına (VAPID) dayanır; gönderim tarafı
--    supabase/functions/send-reminders adlı Edge Function'da, her dakika
--    pg_cron ile tetiklenir (bkz. dosya sonu).
-- ============================================================

create table if not exists push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  endpoint text not null,
  p256dh text not null,
  auth_key text not null,
  created_at timestamptz not null default now(),
  unique (user_id, endpoint)
);

create index if not exists push_subscriptions_user_idx on push_subscriptions(user_id);

alter table push_subscriptions enable row level security;

drop policy if exists "own push subscriptions select" on push_subscriptions;
drop policy if exists "own push subscriptions insert" on push_subscriptions;
drop policy if exists "own push subscriptions delete" on push_subscriptions;

create policy "own push subscriptions select" on push_subscriptions for select using (user_id = auth.uid() or is_admin());
create policy "own push subscriptions insert" on push_subscriptions for insert with check (user_id = auth.uid());
create policy "own push subscriptions delete" on push_subscriptions for delete using (user_id = auth.uid());

create or replace function public.save_push_subscription(p_endpoint text, p_p256dh text, p_auth text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  insert into push_subscriptions (user_id, endpoint, p256dh, auth_key)
  values (v_uid, p_endpoint, p_p256dh, p_auth)
  on conflict (user_id, endpoint) do update set p256dh = excluded.p256dh, auth_key = excluded.auth_key;
  return jsonb_build_object('ok', true);
end;
$$;

create or replace function public.delete_push_subscription(p_endpoint text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  delete from push_subscriptions where user_id = v_uid and endpoint = p_endpoint;
  return jsonb_build_object('ok', true);
end;
$$;

revoke execute on function public.save_push_subscription(text, text, text) from public, anon;
grant execute on function public.save_push_subscription(text, text, text) to authenticated;
revoke execute on function public.delete_push_subscription(text) from public, anon;
grant execute on function public.delete_push_subscription(text) to authenticated;

-- send-reminders Edge Function'ının service_role ile çağıracağı yardımcı:
-- vadesi gelen (planlanan saati son 1-2 dakika içinde geçmiş, henüz
-- hatırlatılmamış) görevleri, alıcının push aboneliği bilgileriyle birlikte
-- döner ve aynı anda reminder_sent=true olarak işaretler (tekrar
-- gönderilmesin diye). Tüm öğrencilerin Türkiye saatinde olduğu varsayılır.
create or replace function public.claim_due_reminders()
returns table (
  r_session_id uuid, r_user_id uuid, r_subject_name text, r_topic_name text,
  r_session_type session_type, r_planned_start time, r_endpoint text, r_p256dh text, r_auth_key text
)
language plpgsql
security definer
set search_path = public
as $$
begin
  -- NOT: RETURNS TABLE sütun adları PL/pgSQL'de örtük olarak birer değişken
  -- gibi işlev görür; bu yüzden hepsi "r_" ön ekiyle adlandırıldı — aksi
  -- hâlde aşağıdaki CTE'nin gerçek study_sessions/study_plans sütunlarıyla
  -- (ör. "session_type", "planned_start", "user_id") isim çakışması olur ve
  -- "ambiguous column reference" hatası alınır (yerel testte tam olarak bu
  -- şekilde tespit edilip düzeltildi).
  return query
  with due as (
    select ss.id
    from study_sessions ss
    join study_plans sp on sp.id = ss.study_plan_id
    where ss.status = 'planned'
      and ss.reminder_sent = false
      and ss.planned_start is not null
      and (sp.plan_date + ss.planned_start) at time zone 'Europe/Istanbul' <= now()
      and (sp.plan_date + ss.planned_start) at time zone 'Europe/Istanbul' >= now() - interval '3 minutes'
  ), marked as (
    update study_sessions set reminder_sent = true
    where id in (select id from due)
    returning id, study_plan_id, subject_id, topic_id, session_type, planned_start
  )
  select
    m.id as session_id, sp.user_id, s.name as subject_name, t.name as topic_name,
    m.session_type, m.planned_start, ps.endpoint, ps.p256dh, ps.auth_key
  from marked m
  join study_plans sp on sp.id = m.study_plan_id
  left join subjects s on s.id = m.subject_id
  left join topics t on t.id = m.topic_id
  join push_subscriptions ps on ps.user_id = sp.user_id;
end;
$$;

revoke execute on function public.claim_due_reminders() from public, anon, authenticated;
grant execute on function public.claim_due_reminders() to service_role;
-- Sadece service_role çağırabilir (Edge Function bunu service_role key ile çağırır).

-- notify_user daha önce public/anon/authenticated'den REVOKE edilmişti (bkz.
-- 20240601000080/090) ve normalde SADECE başka bir SECURITY DEFINER
-- fonksiyonun İÇİNDEN (perform notify_user(...)) çağrılıyordu — o durumda
-- fonksiyon SAHİBİNİN yetkisiyle çalıştığı için ayrıca grant gerekmiyordu.
-- send-reminders Edge Function'ı ise notify_user'ı DOĞRUDAN (service_role
-- REST/RPC çağrısıyla) çağırıyor — bu yüzden service_role'e açıkça EXECUTE
-- veriyoruz, aksi hâlde "permission denied" alınır.
grant execute on function public.notify_user(uuid, notification_event_type, notification_priority, text, text, uuid, text, text) to service_role;

-- ============================================================
-- 5) AI Asistanı genişletme: yazım hatalarına toleranslı eşleştirme
--    (pg_trgm) + birkaç yeni niyet.
-- ============================================================

create extension if not exists pg_trgm;

create or replace function public.ai_assistant_ask(p_message text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
  v_uid uuid := auth.uid();
  v_msg text := normalize_tr(p_message);
  v_name text;
  v_topic record;
  v_subject record;
  v_mistake record;
  v_mistake_count int;
  v_weak_topic_name text; v_weak_subject_name text;
  v_strong_topic_name text;
  v_exam_type exam_type;
  v_exam_days int; v_exam_name text;
  v_response text;
  v_success numeric; v_total_answers int;
  v_streak int; v_xp int; v_level int;
  v_today_total int; v_today_done int;
  v_today_questions int;
  v_news_title text;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select p.full_name, s.exam_type into v_name, v_exam_type
  from profiles p join students s on s.user_id = p.id where p.id = v_uid;

  -- ============ 1) Belirli bir KONU'dan bahsediliyor mu? (iki yönlü, normalize edilmiş eşleşme) ============
  select t.id, t.name, tp.knowledge_score, s.name as subject_name into v_topic
  from topics t
  left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
  join subjects s on s.id = t.subject_id
  where s.exam_type = v_exam_type
    and not exists (select 1 from topics c where c.parent_id = t.id)
    and t.status = 'active'
    and (v_msg like '%' || normalize_tr(t.name) || '%' or normalize_tr(t.name) like '%' || v_msg || '%')
    and length(normalize_tr(t.name)) > 2
  order by length(normalize_tr(t.name)) desc
  limit 1;

  -- ============ 2) Belirli bir DERS'ten mi bahsediliyor? ============
  if v_topic.id is null then
    select s.id, s.name into v_subject
    from subjects s
    where s.exam_type = v_exam_type
      and (v_msg like '%' || normalize_tr(s.name) || '%' or normalize_tr(s.name) like '%' || v_msg || '%')
      and length(normalize_tr(s.name)) > 2
    order by length(normalize_tr(s.name)) desc
    limit 1;
  end if;

  -- ============ 1b/2b) Bulanık (yazım hatası toleranslı) eşleşme ============
  -- Tam substring eşleşmesi bulunamadıysa, mesajdaki her kelimeyi konu/ders
  -- adlarıyla trigram benzerliğine göre karşılaştır ("mateamtik" -> "Matematik").
  if v_topic.id is null and v_subject.id is null then
    select t.id, t.name, tp.knowledge_score, s.name as subject_name into v_topic
    from topics t
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    join subjects s on s.id = t.subject_id
    cross join lateral unnest(string_to_array(v_msg, ' ')) as w(word)
    where s.exam_type = v_exam_type
      and not exists (select 1 from topics c where c.parent_id = t.id)
      and t.status = 'active'
      and length(w.word) >= 4
      and similarity(normalize_tr(t.name), w.word) > 0.4
    order by similarity(normalize_tr(t.name), w.word) desc
    limit 1;

    if v_topic.id is null then
      select s.id, s.name into v_subject
      from subjects s
      cross join lateral unnest(string_to_array(v_msg, ' ')) as w(word)
      where s.exam_type = v_exam_type
        and length(w.word) >= 4
        and similarity(normalize_tr(s.name), w.word) > 0.4
      order by similarity(normalize_tr(s.name), w.word) desc
      limit 1;
    end if;
  end if;

  if v_topic.id is not null then
    if v_topic.knowledge_score is null or v_topic.knowledge_score < 40 then
      v_response := format('%s konusunda henüz güçlü değilsin (bilgi skoru: %%%s). Önce konu özetini ve örnek soruyu incele, sonra kolay seviyeden başlayarak soru çöz. İstersen "%s çalış" diyerek konuya gidebilirim.', v_topic.name, round(coalesce(v_topic.knowledge_score,0)), v_topic.name);
    elsif v_topic.knowledge_score < 70 then
      v_response := format('%s konusunda orta seviyedesin (bilgi skoru: %%%s). Yanlışlarını gözden geçirip orta zorlukta 15-20 soru çözmen iyi olur.', v_topic.name, round(v_topic.knowledge_score));
    else
      v_response := format('%s konusunda iyi durumdasın (bilgi skoru: %%%s). Bilgini pekiştirmek için zor sorularla ve zamanlı tekrarla devam et. 👏', v_topic.name, round(v_topic.knowledge_score));
    end if;

  elsif v_subject.id is not null then
    select t.name, tp.knowledge_score into v_weak_topic_name
    from topics t left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where t.subject_id = v_subject.id and t.status = 'active'
      and not exists (select 1 from topics c where c.parent_id = t.id)
    order by coalesce(tp.knowledge_score, -1) asc limit 1;

    select round(avg(coalesce(tp.knowledge_score,0)),1) into v_success
    from topics t left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where t.subject_id = v_subject.id and t.status = 'active'
      and not exists (select 1 from topics c where c.parent_id = t.id);

    if v_weak_topic_name is null then
      v_response := format('%s dersinde henüz veri yok, birkaç soru çözünce sana en zayıf konunu söyleyebilirim.', v_subject.name);
    else
      v_response := format('%s dersinde ortalama bilgi skorun %%%s. En çok "%s" konusuna zaman ayırmanı öneririm.', v_subject.name, coalesce(v_success,0), v_weak_topic_name);
    end if;

  -- ============ 3) Yanlışlar ============
  elsif v_msg like '%yanlis%' or v_msg like '%neden%' or v_msg like '%hata%' then
    select count(*) into v_mistake_count from mistakes where user_id = v_uid and resolved = false;
    select q.detailed_solution, q.question_text, t.name as topic_name into v_mistake
    from mistakes m join questions q on q.id = m.question_id join topics t on t.id = m.topic_id
    where m.user_id = v_uid order by m.created_at desc limit 1;

    if v_mistake.question_text is null then
      v_response := 'Henüz kayıtlı bir yanlışın yok — soru çözmeye başladığında burada analiz edebilirim.';
    else
      v_response := format('Son yanlışın "%s" konusundaydı. Açıklama: %s Şu anda çözülmemiş %s yanlışın var; "Yanlışlarım" sayfasından tek tek gözden geçirebilirsin.',
        v_mistake.topic_name, coalesce(v_mistake.detailed_solution, 'Detaylı çözüm henüz eklenmedi.'), coalesce(v_mistake_count,0));
    end if;

  -- ============ 4) Bugün / plan / ne çalışmalıyım ============
  -- NOT: "kac soru" ifadesi burada DEĞİL, aşağıdaki 12. niyette (bugün kaç
  -- soru çözdüm) ele alınmalı — "bugun" kelimesi ikisinde de geçtiği için bu
  -- dal onu yutmasın diye burada bilerek hariç tutuluyor.
  elsif (v_msg like '%ne calis%' or v_msg like '%bugun%' or v_msg like '%plan%' or v_msg like '%program%')
    and v_msg not like '%kac soru%' and v_msg not like '%kac tane soru%' then
    select e.exam_date - current_date, e.name into v_exam_days, v_exam_name from exams e
    where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;

    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    select count(*) filter (where ss.status='done'), count(*) into v_today_done, v_today_total
    from study_plans sp join study_sessions ss on ss.study_plan_id = sp.id
    where sp.user_id = v_uid and sp.plan_date = current_date;

    if coalesce(v_today_total,0) > 0 then
      v_response := format('Bugünkü planında %s görevden %s tanesini tamamladın. Devam etmek için Ana Sayfa''daki "Bugünün Programı" listesine bak. İstersen oraya kendi görevini de ekleyebilirsin ("+ Görev Ekle").%s',
        v_today_total, coalesce(v_today_done,0),
        case when v_exam_days is not null then format(' Sınavına %s gün kaldı.', v_exam_days) else '' end);
    elsif v_weak_topic_name is null then
      v_response := 'Henüz yeterli veri yok. Birkaç soru çözünce sana en zayıf konunu önerebilirim. Ana sayfadan "Bugünkü Planı Oluştur" butonuna basarak da otomatik program alabilirsin.';
    else
      v_response := format('Henüz bugün için bir planın yok. Ana sayfadan "Bugünkü Planı Oluştur" butonuna basabilir ya da en zayıf konun olan "%s" ile başlayabilirsin.%s',
        v_weak_topic_name,
        case when v_exam_days is not null then format(' Sınavına %s gün kaldı.', v_exam_days) else '' end);
    end if;

  -- ============ 5) Sınav tarihi / geri sayım ============
  elsif v_msg like '%sinav%' or v_msg like '%kac gun%' or v_msg like '%tarih%' then
    select e.exam_date - current_date, e.name into v_exam_days, v_exam_name
    from exams e where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;
    if v_exam_days is null then
      v_response := 'Sınav takvimin için henüz doğrulanmış bir tarih yok. "Sınav Takvimi" sayfasından güncel durumu takip edebilirsin.';
    else
      v_response := format('Sınavına %s gün kaldı. Detaylar için "Sınav Takvimi" sayfasına göz atabilirsin.', v_exam_days);
    end if;

  -- ============ 6) Başarı oranı / performans ============
  elsif v_msg like '%basari%' or v_msg like '%performans%' or v_msg like '%oran%' or v_msg like '%dogru%' then
    select count(*), case when count(*)=0 then 0 else round((count(*) filter (where is_correct)::numeric/count(*))*100,1) end
    into v_total_answers, v_success
    from user_answers where user_id = v_uid;
    if coalesce(v_total_answers,0) = 0 then
      v_response := 'Henüz hiç soru çözmedin, bu yüzden başarı oranın yok. İlk 10 soruyu çözünce burada net bir yüzde görebileceksin.';
    else
      v_response := format('Şu ana kadar %s soru çözdün, genel başarı oranın %%%s. Detaylı kırılım için "Analiz" sayfasına bakabilirsin.', v_total_answers, v_success);
    end if;

  -- ============ 7) Seviye / XP / seri ============
  elsif v_msg like '%seviye%' or v_msg like '%xp%' or v_msg like '%seri%' or v_msg like '%streak%' or v_msg like '%rozet%' then
    select current_streak, xp, level into v_streak, v_xp, v_level from user_gamification where user_id = v_uid;
    v_response := format('Şu an seviye %s''desin, %s XP''in ve %s günlük çalışma serin var. Her gün en az bir konu çözerek serini koru! 🔥', coalesce(v_level,1), coalesce(v_xp,0), coalesce(v_streak,0));

  -- ============ 8) Motivasyon / moral ============
  elsif v_msg like '%motiv%' or v_msg like '%bikt%' or v_msg like '%yorul%' or v_msg like '%yapamiyo%' or v_msg like '%zor geliyo%' or v_msg like '%moral%' then
    select current_streak into v_streak from user_gamification where user_id = v_uid;
    v_response := format('Anlıyorum, bazen zor gelebilir. %sŞimdi küçük bir adım at: 5-10 soruluk kısa bir tur bile ilerleme sayılır. Sen yapabilirsin! 💪',
      case when coalesce(v_streak,0) > 0 then format('%s gündür seriyi sürdürüyorsun, bu bile büyük bir başarı. ', v_streak) else '' end);

  -- ============ 9) Çalışma tavsiyesi ============
  elsif v_msg like '%tavsiye%' or v_msg like '%ipucu%' or v_msg like '%nasil calis%' or v_msg like '%verimli%' then
    select e.exam_date - current_date into v_exam_days from exams e
    where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;
    if v_exam_days is not null and v_exam_days <= 30 then
      v_response := 'Sınava az kaldığı için ağırlığı soru çözme ve tekrara ver: her gün 1 konu tekrarı + en az 30 soru + yanlış analizi ideal olur.';
    else
      v_response := 'Düzenli çalış: 40 dakikalık bloklar halinde çalış, aralarda 10 dakika mola ver (Pomodoro benzeri). Yeni konu öğrendikten sonra mutlaka aynı gün soru çözerek pekiştir.';
    end if;

  -- ============ 10) Haberler / duyurular ============
  elsif v_msg like '%haber%' or v_msg like '%duyuru%' or v_msg like '%guncel%' then
    select title into v_news_title from news_items where is_learning_content = false order by published_at desc limit 1;
    if v_news_title is null then
      v_response := 'Şu anda gösterilecek güncel bir haber yok.';
    else
      v_response := format('En son duyuru: "%s". Tüm haberler için "Haberler" sayfasına bakabilirsin.', v_news_title);
    end if;

  -- ============ 11) En güçlü olduğun konu ============
  elsif v_msg like '%en iyi%' or v_msg like '%en guclu%' or v_msg like '%guclu oldugum%' or v_msg like '%en basarili%' then
    select t.name, s.name into v_strong_topic_name, v_weak_subject_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type and tp.total_questions > 0
    order by tp.knowledge_score desc limit 1;
    if v_strong_topic_name is null then
      v_response := 'Henüz yeterli veri yok — birkaç soru çözünce en güçlü olduğun konuyu söyleyebilirim.';
    else
      v_response := format('En güçlü olduğun konu "%s" (%s dersi). Böyle devam! Bu konudaki bilgini zor sorularla pekiştirebilirsin. 👏', v_strong_topic_name, v_weak_subject_name);
    end if;

  -- ============ 12) Bugün kaç soru çözdüm ============
  elsif v_msg like '%bugun kac soru%' or v_msg like '%kac soru cozdum%' or v_msg like '%bugun kac tane soru%' then
    select count(*) into v_today_questions from user_answers
    where user_id = v_uid and answered_at >= date_trunc('day', now());
    v_response := format('Bugün %s soru çözdün. %s', coalesce(v_today_questions,0),
      case when coalesce(v_today_questions,0) = 0 then 'Hadi birkaç soruyla başla!' else 'Devam et, her soru seni sınava biraz daha hazırlıyor. 💪' end);

  -- ============ 13) Yardım / neler yapabilirsin ============
  elsif v_msg like '%yardim%' or v_msg like '%ne yapabilir%' or v_msg like '%neler sorabilir%' or v_msg like '%nasil kullan%' then
    v_response := 'Sana şunlarda yardımcı olabilirim: bir konu/ders adı yazarsan durumunu değerlendiririm ("Matematik nasılım?"), "bugün ne çalışmalıyım", "sınava kaç gün kaldı", "başarı oranım", "seviyem", "en güçlü konum", "bugün kaç soru çözdüm", "son yanlışımı açıkla" ya da "motivasyona ihtiyacım var" diyebilirsin. Serbest, doğal bir dille yazman yeterli — belirli kalıplara bağlı değilim.';

  -- ============ 14) Selamlaşma / küçük sohbet ============
  elsif v_msg like '%merhaba%' or v_msg like '%selam%' or v_msg like '%nasilsin%' or v_msg like '%gunaydin%' or v_msg like '%iyi aksam%' then
    v_response := format('Merhaba%s! Sana çalışma programın, konuların ve performansın hakkında yardımcı olabilirim. Bir konu adı yazabilir, "bugün ne çalışmalıyım" ya da "en zayıf konum ne" diyebilirsin.',
      case when v_name is not null and v_name <> '' then ', ' || v_name else '' end);

  -- ============ 15) Teşekkür ============
  elsif v_msg like '%tesekkur%' or v_msg like '%sagol%' or v_msg like '%eyval%' then
    v_response := 'Rica ederim! Başka bir sorun olursa buradayım. 🙌';

  else
    -- Akıllı varsayılan: sabit metin yerine kullanıcının en zayıf konusunu önererek yanıt ver.
    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    if v_weak_topic_name is not null then
      v_response := format('Tam anlayamadım ama sana yine de yardımcı olayım: en zayıf konun "%s" görünüyor, oradan devam edebilirsin. İstersen bir konu adı, "bugün ne çalışmalıyım", "başarı oranım", "seviyem", "en güçlü konum" ya da "motivasyon" gibi bir şey de sorabilirsin — ya da "yardım" yaz, neler sorabileceğini sıralayayım.', v_weak_topic_name);
    else
      v_response := 'Tam anlayamadım. Bana bir konu/ders adı ("Matematik nasılım?"), "bugün ne çalışmalıyım", "son yanlışımı açıkla", "başarı oranım", "seviyem" ya da "motivasyona ihtiyacım var" gibi bir şey sorabilirsin. "Yardım" yazarsan neler sorabileceğini sıralarım.';
    end if;
  end if;

  insert into ai_interactions (user_id, message, response) values (v_uid, p_message, v_response);
  return jsonb_build_object('response', v_response);
end;
$$;

revoke execute on function public.ai_assistant_ask(text) from public, anon;
grant execute on function public.ai_assistant_ask(text) to authenticated;

commit;

-- ============================================================
-- pg_cron: her dakika vadesi gelen hatırlatıcıları gönder
-- ============================================================
-- NOT: anon key gizli bir bilgi DEĞİLDİR (istemci tarafında zaten herkese
-- açık şekilde kullanılıyor, bkz. public/js/config.js) — bu yüzden burada
-- doğrudan yazılması güvenlidir. send-reminders fonksiyonu KENDİ İÇİNDE
-- otomatik enjekte edilen SUPABASE_SERVICE_ROLE_KEY'i kullanarak asıl
-- yetkili işlemleri yapar; buradaki anon key sadece HTTP isteğinin kimlik
-- doğrulamasını geçmesi içindir.
--
-- Bu blok yalnızca `send-reminders` Edge Function'ı deploy edildikten SONRA
-- çalışır (aksi hâlde 404 döner ama zararsızdır). Deploy için:
--   supabase functions deploy send-reminders
--   supabase secrets set VAPID_PUBLIC_KEY=... VAPID_PRIVATE_KEY=... VAPID_SUBJECT=mailto:...
-- (Tam talimatlar için bkz. supabase/functions/send-reminders/README.md)

select cron.schedule(
  'kpss-send-reminders-every-minute',
  '* * * * *',
  $$
  select net.http_post(
    url := 'https://zptzcnzgxphxlxwuzrpo.supabase.co/functions/v1/send-reminders',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx'
    ),
    body := '{}'::jsonb
  );
  $$
)
where not exists (select 1 from cron.job where jobname = 'kpss-send-reminders-every-minute');
