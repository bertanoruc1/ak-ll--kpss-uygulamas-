-- "Dersler sayfası yüklenmiyor" kalıcı düzeltmesi.
--
-- KÖK NEDEN: Bir önceki düzeltme (20240601000180), self-healing'i sadece
-- generate_study_plan / get_today_priority / get_homepage RPC'lerine
-- ekledi. Ama public/js/auth.js içindeki requireAuth() — TÜM korumalı
-- sayfaların en başında çalışan, students/profiles satırlarını DOĞRUDAN
-- (RPC değil) client-side select eden fonksiyon — hâlâ eski haliyle
-- kalmıştı. "Yetim" bir hesapta (students satırı yok) requireAuth()
-- `student: null` döndürüyor, hata fırlatmıyor; ama subjects.js gibi
-- sayfalar `student.exam_type`'a doğrudan erişince (student null olduğu
-- için) JS hatası fırlatıp sayfa yüklemesini tamamen durduruyordu —
-- "Dersler" ekranı sonsuza kadar iskelet (skeleton) halinde kalıyordu.
--
-- ÇÖZÜM: requireAuth() artık profiles/students'ı okumadan ÖNCE, no-arg
-- bir ensure_my_profile() RPC'si çağırıyor — bu da (20240601000180'de
-- eklenen) ensure_student_profile()'ı auth.uid() ile çağırır. Böylece
-- her korumalı sayfa açıldığında, hangi RPC'yi kullandığına bakılmaksızın
-- eksik satırlar otomatik tamamlanır.

create or replace function public.ensure_my_profile()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  perform public.ensure_student_profile(auth.uid());
end;
$$;

revoke all on function public.ensure_my_profile() from public, anon;
grant execute on function public.ensure_my_profile() to authenticated;
