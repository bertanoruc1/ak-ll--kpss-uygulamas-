-- Kullanıcı geri bildirimi: "Haberler sürekli güncellensin, geçen gün KPSS
-- Lisans sınav yerleri belli olmuştu ama sitede o haber yoktu." İnceleme
-- sonucu: news_items TAMAMEN elle (migration/admin panelinden) doldurulan
-- statik bir tablo — hiçbir otomatik kaynak-izleme çalışmıyor. Bir
-- "sync-engine" Edge Function'ı zaten yazılmış (ÖSYM/MEB sayfalarını
-- periyodik olarak hash'leyip değişiklik arıyor) ama:
--   1) hiç deploy edilmemiş,
--   2) cron tetikleyicisi bilerek devre dışı bırakılmış (20240601000110),
--   3) değişiklik tespit ettiğinde bile SADECE sync_log'a yazıyordu,
--      news_items'a hiç dokunmuyordu.
-- Bu migration üç şeyi yapar:
--   a) Bugüne kadar kaçırılan gerçek haberi (sınav giriş yerlerinin
--      açıklanması, ÖSYM'nin resmi duyurusuna dayanarak) ekler.
--   b) record_sync_check RPC'sini genişletir: kaynakta değişiklik tespit
--      edildiğinde (status='changed') artık otomatik olarak bir news_items
--      satırı da oluşturuyor (kullanıcı "doğrudan otomatik yayınla" seçeneğini
--      seçti — admin onayı beklemiyor). Başlık/özet kasıtlı olarak GENELDİR
--      ("X sayfasında güncelleme tespit edildi, kaynağı incele") çünkü basit
--      hash-diff hangi bilginin değiştiğini kesin olarak bilemez; spesifik
--      ama YANLIŞ olabilecek bir başlık uydurmaktansa dürüst ve genel bir
--      bildirim + doğrudan kaynak linki tercih edildi.
--   c) sync-engine cron tetikleyicisini etkinleştirir (send-reminders'daki
--      pattern'le aynı: WHERE NOT EXISTS ile idempotent, proje URL'i sabit).
--      NOT: Bu, sync-engine Edge Function'ı deploy EDİLDİKTEN SONRA anlamlı
--      olur — aksi hâlde cron her 30 dakikada bir 404 alır (zararsız ama
--      işe yaramaz). Deploy için: `supabase functions deploy sync-engine`.

begin;

-- ============ a) Kaçırılan gerçek haber: sınav giriş yerleri ============
insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, exam_type, published_at)
select 'sinav_takvimi', '2026 KPSS Lisans sınav giriş yerleri açıklandı',
  'ÖSYM, 6 Eylül 2026''da yapılacak 2026 KPSS Lisans (Genel Yetenek-Genel Kültür) sınavı için adayların sınav yerini gösteren belgelere Aday İşlemleri Sistemi (ais.osym.gov.tr) üzerinden T.C. kimlik numarası ve aday şifresiyle ulaşabildiğini duyurdu (27 Ağustos 2026). Sınav günü mağduriyet yaşamamak için giriş belgesinin önceden çıktısının alınması ve mümkünse sınav binasının önceden ziyaret edilmesi öneriliyor.',
  'ÖSYM', 'https://www.osym.gov.tr/2026-kamu-personel-secme-sinavi-kpss-lisans-basvurularin-alinmasi', 'resmi', false, 'kpss_lisans', '2026-08-27 10:00:00+03'
where not exists (
  select 1 from news_items where title = '2026 KPSS Lisans sınav giriş yerleri açıklandı'
);

-- ============ b) record_sync_check: değişiklik tespitinde otomatik haber ============
create or replace function public.record_sync_check(
  p_source_id uuid, p_status sync_status, p_new_hash text, p_diff_summary text default null, p_confidence numeric default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_log_id uuid;
  v_source data_sources%rowtype;
  v_category news_category;
  v_recent_duplicate uuid;
begin
  if not (coalesce(is_admin(), false) or auth.role() = 'service_role') then
    raise exception 'unauthorized';
  end if;

  select * into v_source from data_sources where id = p_source_id;

  update data_sources set last_checked_at = now(), last_status = p_status,
    last_content_hash = coalesce(p_new_hash, last_content_hash)
  where id = p_source_id;

  insert into sync_log (source_id, status, new_hash, diff_summary, confidence)
  values (p_source_id, p_status, p_new_hash, p_diff_summary, p_confidence)
  returning id into v_log_id;

  -- Değişiklik tespit edildiyse (ilk kontrol/no_change/error hariç) otomatik haber oluştur.
  if p_status = 'changed' and v_source.id is not null then
    -- Aynı kaynak için son 6 saat içinde zaten bir haber oluşturulmuşsa tekrar oluşturma
    -- (kısa aralıklı ardışık kontrollerde aynı değişikliğin birden fazla habere dönüşmesini önler).
    select id into v_recent_duplicate from news_items
    where source_url = v_source.url and published_at > now() - interval '6 hours'
    limit 1;

    if v_recent_duplicate is null then
      v_category := case
        when v_source.name ilike '%takvim%' then 'sinav_takvimi'
        when v_source.name ilike '%başvuru%' or v_source.name ilike '%basvuru%' then 'basvuru'
        when v_source.source_type = 'meb' then 'genel_egitim'
        else 'onemli_duyuru'
      end;

      insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, published_at)
      values (
        v_category,
        format('"%s" sayfasında güncelleme tespit edildi', v_source.name),
        coalesce(p_diff_summary, 'Bu resmi kaynak sayfasında bir içerik değişikliği tespit edildi.') ||
          ' Kesin ve güncel bilgi için kaynağı doğrudan incele; bu bildirim otomatik değişiklik takibiyle oluşturulmuştur, içeriği admin tarafından henüz doğrulanmamıştır.',
        case when v_source.source_type = 'meb' then 'MEB' else 'ÖSYM' end,
        v_source.url,
        'destekleyici',
        false,
        now()
      );
    end if;
  end if;

  return v_log_id;
end;
$$;

commit;

-- ============ c) sync-engine cron tetikleyicisini etkinleştir ============
-- 20240601000110'da bilerek devre dışı bırakılmıştı (o zaman sync-engine hiç
-- deploy edilmemişti). ÖNEMLİ: Bu blok yalnızca `supabase functions deploy
-- sync-engine` çalıştırıldıktan SONRA anlamlıdır — aksi hâlde her 30 dakikada
-- bir 404 alır (zararsız, ama işe yaramaz). send-reminders'daki pattern'le
-- aynı: buradaki anon key GİZLİ DEĞİLDİR (istemci tarafında zaten herkese açık,
-- bkz. public/js/config.js) — sync-engine KENDİ İÇİNDE otomatik enjekte edilen
-- SUPABASE_SERVICE_ROLE_KEY'i kullanarak asıl yetkili işlemleri yapar, buradaki
-- anon key sadece HTTP isteğinin kimlik doğrulamasını geçmesi içindir.
select cron.schedule(
  'kpss-sync-engine-every-30min',
  '*/30 * * * *',
  $$
  select net.http_post(
    url := 'https://zptzcnzgxphxlxwuzrpo.supabase.co/functions/v1/sync-engine',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx'
    ),
    body := '{}'::jsonb
  );
  $$
)
where not exists (select 1 from cron.job where jobname = 'kpss-sync-engine-every-30min');
