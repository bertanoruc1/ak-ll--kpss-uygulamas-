-- Güvenlik denetimi (app mağazalarına başvuru öncesi baştan aşağı kontrol)
-- sonucunda bulunan sorunları düzeltir. Bulgular:
--
--   a) KRİTİK — Yetki yükseltme açığı: "own profile update" RLS politikası
--      (20240601000020) `update ... using (id = auth.uid() or is_admin())`
--      şeklindeydi ve WITH CHECK içermiyordu. Postgres, UPDATE politikalarında
--      WITH CHECK verilmezse USING ifadesini yeni satır için de kullanır — ve
--      USING sadece `id` sütununu doğruluyor, `role` sütununu değil. Sonuç:
--      HERHANGİ bir giriş yapmış kullanıcı kendi profilinde
--      `update profiles set role='admin' where id=auth.uid()` çalıştırıp
--      admin olabiliyordu (yerel test veritabanında bizzat doğrulandı: bu
--      sorgu gerçekten UPDATE 1 ile başarılı oluyor ve is_admin() o andan
--      itibaren true dönüyor). Bu, sistemdeki TÜM is_admin() kontrollerini
--      (öğrenciler, sınavlar, sorular, haberler, admin_audit_log dahil)
--      geçersiz kılan en ciddi bulgu. Düzeltme: rolü sadece admin
--      değiştirebilsin diye bir BEFORE UPDATE trigger ekleniyor (RLS
--      politikasını bozmadan, ek bir savunma katmanı olarak — subquery
--      tabanlı bir WITH CHECK yerine trigger tercih edildi çünkü aynı
--      satırı hedefleyen subquery'lerin UPDATE sırasındaki görünürlüğü
--      kırılgan/sürüm bağımlı olabilir, trigger her zaman OLD/NEW'e temiz
--      erişir).
--
--   b) ORTA — 20240601000320'de eklenen update_study_session/
--      delete_study_session fonksiyonları, projedeki diğer tüm RPC'lerin
--      aksine anon/public'ten EXECUTE yetkisi hiç geri alınmamış (sadece
--      authenticated'a grant edilmiş, ama Postgres/Supabase varsayılanı
--      olarak anon da örtük EXECUTE alabiliyor — bkz. 20240601000090'ın
--      açıklaması). Fonksiyon içi auth.uid() kontrolü bugüne kadar bunu
--      istismar edilemez kılmış olsa da (anon çağrıda auth.uid() null
--      döner ve fonksiyon 'unauthorized' fırlatır), projenin kendi
--      "varsayılan olarak kapalı" sertleştirme deseniyle tutarlı olması
--      için burada da açıkça revoke ediliyor (savunma derinliği).
--
--   c) DÜŞÜK — algorithm_weights (ödev/tekrar zamanlama algoritmasının iç
--      ayar değerleri) tüm giriş yapmış kullanıcılar tarafından
--      okunabiliyordu; bu PII değil ama gereksiz bir iç-bilgi sızıntısı,
--      sadece admin'e kısıtlanıyor.
--
--   d) Mağaza gereksinimi — hesap silme: Google Play / App Store
--      politikaları, hesap oluşturabilen uygulamaların uygulama-içi bir
--      hesap silme yolu sunmasını zorunlu kılıyor. `delete_own_account()`
--      RPC'si ekleniyor (auth.users satırını siler; profiles ve ona bağlı
--      tüm satırlar `on delete cascade` ile otomatik temizlenir — bkz.
--      20240601000010).
--
--   e) sync-engine ve send-reminders Edge Function'ları hiçbir auth
--      kontrolü yapmıyordu (bkz. ilgili .ts dosyalarındaki güncelleme) —
--      bu fonksiyonları çağıran cron job'larına paylaşılan bir gizli
--      anahtar (x-cron-secret header'ı) ekleniyor; fonksiyonlar artık bu
--      anahtarı (veya admin JWT'sini, sync-engine için) doğrulamadan
--      çalışmayacak. ÖNEMLİ: Bu migration'ın uygulanması TEK BAŞINA
--      yeterli değil — aşağıdaki adım da gerekli:
--      `supabase secrets set CRON_SECRET=<bu dosyadaki değerle aynı>`
--      (gerçek değer bu dosyada sabit yazılıdır çünkü pg_cron job'ları
--      migration dosyasından başka bir yerden secret okuyamıyor — anon
--      key'in aynı sebeple burada sabit yazılı olmasıyla aynı desen).
--      Bu, anon key kadar "kamuya açık" değildir (sadece repoya erişimi
--      olanlar görür) ama gerçek anlamda gizli de değildir; ekstra
--      güvenlik için ileride Supabase Vault'a taşınması önerilir.

begin;

-- ============ a) KRİTİK: profiles.role kendine-atama koruması ============
create or replace function public.prevent_role_self_escalation()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.role is distinct from old.role and not coalesce(is_admin(), false) then
    raise exception 'yetkisiz: rol değişikliği sadece yönetici tarafından yapılabilir';
  end if;
  return new;
end;
$$;

drop trigger if exists trg_prevent_role_escalation on profiles;
create trigger trg_prevent_role_escalation
before update on profiles
for each row execute function public.prevent_role_self_escalation();

-- ============ b) update/delete_study_session: anon/public revoke ============
revoke execute on function public.update_study_session(
  uuid, uuid, uuid, session_type, time, time, int
) from public, anon;

revoke execute on function public.delete_study_session(uuid) from public, anon;

-- ============ c) algorithm_weights: sadece admin okuyabilsin ============
drop policy if exists "read algorithm_weights" on algorithm_weights;
drop policy if exists "admin read algorithm_weights" on algorithm_weights;
create policy "admin read algorithm_weights" on algorithm_weights
  for select using (is_admin());

-- ============ c2) ai-chat Edge Function'ının kendi mesaj geçmişini yazabilmesi ============
-- ai_interactions'a bugüne kadar sadece SECURITY DEFINER RPC'ler (ai_assistant_ask)
-- yazabiliyordu (tablo sahibi olarak RLS'i by-pass ediyorlardı). Yeni ai-chat Edge
-- Function'ı ise kullanıcının KENDİ JWT'siyle (RLS'e tabi) çalışıyor — hem hız
-- sınırlama sayımının doğru olması hem de kullanıcının kendi sohbet geçmişini
-- yazabilmesi için explicit bir insert politikası gerekiyor.
drop policy if exists "own ai_interactions insert" on ai_interactions;
create policy "own ai_interactions insert" on ai_interactions
  for insert with check (user_id = auth.uid());

-- ============ d) Kullanıcının kendi hesabını silmesi (mağaza zorunluluğu) ============
create or replace function public.delete_own_account()
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'unauthorized';
  end if;

  -- ai_content_queue.reviewed_by ve admin_audit_log.actor, profiles(id)'e
  -- CASCADE OLMADAN referans veriyor (bkz. 20240601000010) — kullanıcı bir
  -- admin olarak inceleme/işlem geçmişine sahipse silme işlemi FK hatasıyla
  -- başarısız olmasın diye referansları null'a çekiyoruz (audit kaydının
  -- kendisi silinmiyor, sadece "kim yaptı" bağlantısı kopuyor).
  update ai_content_queue set reviewed_by = null where reviewed_by = v_uid;
  update admin_audit_log set actor = null where actor = v_uid;

  -- profiles (ve on delete cascade ile students, user_subjects, user_answers,
  -- mistakes, topic_progress, repetitions, notifications, study_plans,
  -- study_sessions, user_gamification, user_achievements, ai_interactions,
  -- push_subscriptions) satırları auth.users silinince otomatik temizlenir.
  delete from auth.users where id = v_uid;
end;
$$;

revoke execute on function public.delete_own_account() from public, anon;
grant execute on function public.delete_own_account() to authenticated;

commit;

-- ============ e) cron job'larına paylaşılan gizli anahtar ekle ============
-- NOT: cron.schedule() aynı jobname ile tekrar çağrıldığında pg_cron mevcut
-- job'ı GÜNCELLER (upsert) — 20240601000290 ve 20240601000370'te tanımlanan
-- job'ları burada aynı isimle yeniden tanımlamak, onları güncellemek
-- anlamına gelir (yeni bir job oluşturmaz).
select cron.schedule(
  'kpss-send-reminders-every-minute',
  '* * * * *',
  $$
  select net.http_post(
    url := 'https://zptzcnzgxphxlxwuzrpo.supabase.co/functions/v1/send-reminders',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx',
      'x-cron-secret', '4718b8fc55e30e64d9bca52750f2947b48587db1ff2c3163'
    ),
    body := '{}'::jsonb
  );
  $$
);

select cron.schedule(
  'kpss-sync-engine-every-30min',
  '*/30 * * * *',
  $$
  select net.http_post(
    url := 'https://zptzcnzgxphxlxwuzrpo.supabase.co/functions/v1/sync-engine',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx',
      'x-cron-secret', '4718b8fc55e30e64d9bca52750f2947b48587db1ff2c3163'
    ),
    body := '{}'::jsonb
  );
  $$
);
