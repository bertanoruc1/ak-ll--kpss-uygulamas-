-- ⚠️ DİKKAT: Bu script public şemasındaki HER ŞEYİ (tüm tablolar, fonksiyonlar,
-- tipler, veriler) KALICI ve GERİ ALINAMAZ şekilde SİLER. auth/storage gibi
-- Supabase'in kendi yönettiği şemalara dokunmaz (kullanıcı hesapları silinmez,
-- sadece bu uygulamanın students/questions/vb. tabloları silinir).
--
-- SADECE orucbertan7@gmail.com hesabındaki "kpss-backend" projesinde (zptzcnzgxphxlxwuzrpo)
-- ve SADECE bu projeyi migration dosyalarından (0010-0160) tertemiz yeniden kurmak
-- istediğinde BİR KEZ çalıştır. Bundan sonra "supabase db push" ile tüm migration'lar
-- otomatik olarak sırayla uygulanacak.
--
-- GÜVENLİK ÖNLEMİ (2026-08-30 denetiminde eklendi): Bu dosya daha önce hiçbir
-- mekanik korumaya sahip değildi — sadece bir yorum satırı uyarıyordu. Bir
-- geliştiricinin `DATABASE_URL`'i yanlışlıkla PRODUCTION'a işaret ederken bu
-- dosyayı (ör. tüm kurulum-*.sql dosyalarını sırayla çalıştıran bir script
-- içinde) çalıştırması, TÜM canlı kullanıcı verisinin geri dönüşsüz şekilde
-- silinmesine yol açabilirdi. Şimdi, gerçekten çalıştırmak istediğini
-- ONAYLAMAN gerekiyor — aşağıdaki satırdaki 'HAYIR' yazısını elle 'EVET-SIFIRLA'
-- olarak DEĞİŞTİRMEDEN script hiçbir şey yapmadan hata verir.
do $$
declare
  v_onay text := 'HAYIR';  -- <-- gerçekten sıfırlamak istiyorsan bunu 'EVET-SIFIRLA' yap
begin
  if v_onay <> 'EVET-SIFIRLA' then
    raise exception 'Sıfırlama İPTAL EDİLDİ — bu, kazara production''u silmeni önleyen bir güvenlik kontrolü. Gerçekten devam etmek istiyorsan bu dosyadaki v_onay değerini ''EVET-SIFIRLA'' yap ve TEKRAR ÇALIŞTIR (ve doğru projede olduğundan emin ol).';
  end if;
end $$;

drop schema public cascade;
create schema public;
grant usage on schema public to postgres, anon, authenticated, service_role;
grant all on schema public to postgres, service_role;
