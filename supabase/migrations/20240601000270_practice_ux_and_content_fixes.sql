-- Bu migration dört bağımsız düzeltmeyi bir araya getiriyor:
--
-- 1) "Soru Çöz" ekranı artık sonsuz döngüye girmiyor: bir konudaki (veya bir
--    çalışma oturumundaki) hedef soru sayısına ulaşıldığında oturum
--    tamamlanmış sayılıyor. Bunu backend tarafında mümkün kılmak için
--    study_sessions'ı "tamamlandı" olarak işaretleyen yeni bir RPC ekliyoruz.
-- 2) Sınav geri sayımına saat/dakika eklenebilmesi için exams tablosuna
--    bir sınav saati (exam_time) sütunu ekliyoruz ve get_homepage'i
--    gün+saat+dakika döndürecek şekilde güncelliyoruz.
-- 3) Haberlerin yalnızca "lisans" adaylarına göre görünmesi sorunu:
--    news_items'a nullable bir exam_type sütunu ekliyoruz (null = genel/
--    herkese açık duyuru), mevcut kayıtları buna göre etiketliyoruz, Ön
--    Lisans/Ortaöğretim adayları için de gerçek/doğrulanmış kaynaklara
--    dayanan haber kayıtları ekliyoruz ve get_homepage'in öne çıkan haberi
--    kullanıcının sınav türüne göre seçmesini sağlıyoruz.
-- 4) Soru şıklarında doğru cevabın neredeyse hep A veya B'de kümelenmesi
--    sorunu: question_choices.order_index'i her soru için rastgele
--    yeniden dağıtıyoruz (şık metinleri ve is_correct değerleri aynı kalıyor,
--    sadece hangi harfe denk geldikleri karışıyor).

-- ============================================================
-- 1) Çalışma oturumunu (görev) tamamlandı olarak işaretleme RPC'si
-- ============================================================
create or replace function public.complete_study_session(p_session_id uuid, p_actual_minutes int default null)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_owner uuid;
  v_status session_status;
  v_duration int;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select sp.user_id, ss.status, ss.duration_minutes
  into v_owner, v_status, v_duration
  from study_sessions ss
  join study_plans sp on sp.id = ss.study_plan_id
  where ss.id = p_session_id;

  if v_owner is null then raise exception 'session not found'; end if;
  if v_owner <> v_uid then raise exception 'unauthorized'; end if;

  if v_status = 'done' then
    return jsonb_build_object('ok', true, 'already_done', true);
  end if;

  update study_sessions
  set status = 'done', actual_minutes = coalesce(p_actual_minutes, v_duration)
  where id = p_session_id;

  perform touch_streak(v_uid);
  perform add_xp(v_uid, 5);

  return jsonb_build_object('ok', true, 'already_done', false);
end;
$$;

revoke execute on function public.complete_study_session(uuid, int) from public;
grant execute on function public.complete_study_session(uuid, int) to authenticated;

-- ============================================================
-- 2) Sınav saati sütunu — geri sayımın saat/dakika göstermesi için
-- ============================================================
alter table exams add column if not exists exam_time time;

-- KPSS Genel Yetenek-Genel Kültür oturumu ÖSYM tarafından güncel yıllarda
-- genellikle 10:15'te başlatılmaktadır. Kesin/doğrulanmış oturum saati
-- her sınav için farklı olabileceğinden, bu yalnızca (mevcut exam_date'i
-- olan) sınavlar için makul bir VARSAYILAN olarak ayarlanıyor; admin
-- panelinden ihtiyaç oldukça güncellenebilir.
update exams set exam_time = '10:15:00'
where exam_time is null and exam_date is not null;

-- ============================================================
-- 3) Haberlerde sınav türü etiketi — "sadece lisans" sorununun kaynağı
-- ============================================================
alter table news_items add column if not exists exam_type exam_type;
create index if not exists news_items_exam_type_idx on news_items(exam_type);

-- Mevcut kayıtları gerçek içeriklerine göre etiketle.
update news_items set exam_type = 'kpss_lisans'
where title like '2026 KPSS Lisans sınav tarihi%' and exam_type is null;

update news_items set exam_type = 'dhbt'
where title like 'DHBT başvuruları%' and exam_type is null;

-- Ön Lisans ve Ortaöğretim adayları için de gerçek/doğrulanabilir
-- kaynaklara dayanan haberler ekleniyor (kesin tarih verilmeden — bu
-- tarihler ÖSYM'nin resmi kılavuzunda netleşene kadar admin panelinden
-- doğrulanıp güncellenmelidir).
insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, exam_type, published_at)
select 'basvuru', '2026 KPSS Ön Lisans başvuruları için ÖSYM duyurusu yayımlandı',
  'ÖSYM, 2026 KPSS Ön Lisans sınavına ilişkin başvuruların alınacağını resmi sayfasından duyurdu. Kesin başvuru ve sınav tarihleri için ÖSYM''nin resmi duyurusunu incele; bu uygulamadaki sınav takvimi doğrulandıkça güncellenecektir.',
  'ÖSYM', 'https://www.osym.gov.tr/2026-kpss-on-lisans-basvurularin-alinmasi-20260728141324252', 'resmi', false, 'kpss_onlisans', now() - interval '2 hours'
where not exists (select 1 from news_items where title like '2026 KPSS Ön Lisans başvuruları için ÖSYM duyurusu%');

insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, exam_type, published_at)
select 'sinav_takvimi', 'KPSS Ortaöğretim adayları: güncel sınav takvimi ÖSYM''nin resmi sayfasında',
  'KPSS Ortaöğretim (Lise) sınavının kesin başvuru ve sınav tarihi bu uygulamada henüz doğrulanmadı. Güncel ve kesin tarihler için ÖSYM''nin resmi sınav takvimi sayfasını takip et.',
  'ÖSYM', 'https://www.osym.gov.tr/Sayfa/SinavTakvimi', 'destekleyici', false, 'kpss_ortaogretim', now() - interval '3 hours'
where not exists (select 1 from news_items where title like 'KPSS Ortaöğretim adayları: güncel sınav takvimi%');

-- ============================================================
-- 4) get_homepage: gün/saat/dakika geri sayımı + sınav türüne duyarlı haber
-- ============================================================
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

-- get_homepage zaten authenticated'e execute yetkisiyle tanımlıydı (bkz.
-- 20240601000080/90); create or replace fonksiyon imzasını değiştirmediği
-- için mevcut grant'ler korunur, yeniden grant vermeye gerek yoktur.

-- ============================================================
-- 5) Doğru cevabın şıklarda A/B'de kümelenmesini düzelt
-- ============================================================
-- Her soru için mevcut şıkların order_index'ini rastgele bir permütasyonla
-- yeniden dağıtıyoruz. Şık metni ve is_correct değeri DEĞİŞMİYOR — sadece
-- hangi harfe (A-E) denk geldiği karışıyor. question_choices üzerinde
-- (question_id, order_index) için bir unique kısıt olmadığından güvenle
-- doğrudan güncelleyebiliyoruz. Her sorunun kendi şıkları arasında (partition
-- by question_id) bağımsız olarak rastgele sıralanır.
with shuffled as (
  select id, row_number() over (partition by question_id order by random()) - 1 as new_order_index
  from question_choices
)
update question_choices qc
set order_index = shuffled.new_order_index
from shuffled
where shuffled.id = qc.id;
