-- Bu script'i, 01 ve 02'yi çalıştırdıktan sonra çalıştırın.
-- Amaç: giriş yapmış kullanıcıların (authenticated) ve giriş yapmamış
-- ziyaretçilerin (anon) uygulamadaki tablolara erişebilmesi için gereken
-- temel izinleri vermek. Satır bazlı güvenlik (RLS, zaten 0002_rls_policies.sql
-- ile kurulmuştu) kimin hangi SATIRI görüp değiştirebileceğini zaten
-- kısıtlıyor; bu script sadece tabloya erişim iznini açıyor.

grant usage on schema public to anon, authenticated;

grant select, insert, update, delete on all tables in schema public to authenticated;
grant select on all tables in schema public to anon;

grant usage, select on all sequences in schema public to authenticated;

-- Bundan sonra oluşturulacak yeni tablolar için de aynı izinler otomatik uygulansın:
alter default privileges in schema public grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema public grant select on tables to anon;
alter default privileges in schema public grant usage, select on sequences to authenticated;
