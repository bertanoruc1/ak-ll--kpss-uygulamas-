-- Kullanıcı isteği: "hata bildirimleri sorunları görebileceğim, kimlerin giriş
-- yaptığını kimlerin aktif olduğunu görebileceğim bir admin paneli + profil
-- sayfasında hata/eksik konu/eksik soru gibi seçeneklerle sorun bildirme".
--
-- Bu migration iki şeyi ekler:
--   a) user_reports tablosu — öğrencilerin (hata/eksik konu/eksik soru/içerik
--      hatası/öneri/diğer kategorilerinde) bildirdiği sorunlar. Kullanıcı
--      sadece kendi bildirdiklerini görebilir/oluşturabilir; durumu
--      (açık/inceleniyor/çözüldü/reddedildi) ve admin notunu SADECE admin
--      değiştirebilir.
--   b) admin_list_users() RPC'si — admin panelindeki "Öğrenciler" sekmesinin
--      artık sadece students tablosundaki (onboarding tamamlamış) kullanıcıları
--      değil, TÜM kayıtlı kullanıcıları (auth.users ile join'lenmiş: son giriş
--      zamanı, e-posta doğrulama durumu dahil) göstermesini sağlar — "kimler
--      giriş yaptı, kimler aktif" sorusuna cevap verir.

begin;

-- ============ a) user_reports ============
do $$ begin
  create type report_type as enum ('hata', 'eksik_konu', 'eksik_soru', 'icerik_hatasi', 'oneri', 'diger');
exception when duplicate_object then null; end $$;

do $$ begin
  create type report_status as enum ('acik', 'inceleniyor', 'cozuldu', 'reddedildi');
exception when duplicate_object then null; end $$;

create table if not exists user_reports (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  report_type report_type not null,
  message text not null,
  subject_id uuid references subjects(id) on delete set null,
  topic_id uuid references topics(id) on delete set null,
  question_id uuid references questions(id) on delete set null,
  page_context text,
  status report_status not null default 'acik',
  admin_note text,
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

create index if not exists idx_user_reports_status on user_reports(status);
create index if not exists idx_user_reports_user on user_reports(user_id);
create index if not exists idx_user_reports_created on user_reports(created_at desc);

alter table user_reports enable row level security;

drop policy if exists "own reports select" on user_reports;
create policy "own reports select" on user_reports
  for select using (user_id = auth.uid() or is_admin());

drop policy if exists "own reports insert" on user_reports;
create policy "own reports insert" on user_reports
  for insert with check (user_id = auth.uid());

drop policy if exists "admin update reports" on user_reports;
create policy "admin update reports" on user_reports
  for update using (is_admin()) with check (is_admin());

drop policy if exists "admin delete reports" on user_reports;
create policy "admin delete reports" on user_reports
  for delete using (is_admin());

-- Durum "çözüldü"/"reddedildi" olarak işaretlenince resolved_at'i otomatik doldur
-- (admin panelinden ayrıca elle set etmeye gerek kalmasın diye).
create or replace function public.set_report_resolved_at()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.status in ('cozuldu', 'reddedildi') and old.status not in ('cozuldu', 'reddedildi') then
    new.resolved_at := now();
  elsif new.status not in ('cozuldu', 'reddedildi') then
    new.resolved_at := null;
  end if;
  return new;
end;
$$;

drop trigger if exists trg_set_report_resolved_at on user_reports;
create trigger trg_set_report_resolved_at
before update on user_reports
for each row execute function public.set_report_resolved_at();

-- ============ b) admin_list_users(): admin paneli "Öğrenciler" sekmesi için ============
create or replace function public.admin_list_users()
returns table (
  id uuid,
  full_name text,
  email text,
  role app_role,
  created_at timestamptz,
  last_sign_in_at timestamptz,
  email_confirmed_at timestamptz,
  exam_type exam_type,
  onboarding_completed boolean
)
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not coalesce(is_admin(), false) then
    raise exception 'unauthorized';
  end if;

  return query
    select
      p.id, p.full_name, p.email, p.role, p.created_at,
      u.last_sign_in_at, u.email_confirmed_at,
      s.exam_type, s.onboarding_completed
    from profiles p
    join auth.users u on u.id = p.id
    left join students s on s.user_id = p.id
    order by u.last_sign_in_at desc nulls last;
end;
$$;

revoke execute on function public.admin_list_users() from public, anon;
grant execute on function public.admin_list_users() to authenticated;

commit;
