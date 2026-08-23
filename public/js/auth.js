import { supabase } from "./supabaseClient.js";

// NOT: Bu modül hem public/ kökündeki sayfalardan hem de public/admin/ altındaki
// sayfalardan import edilir. Yönlendirmelerin her iki konumdan da doğru çalışması için
// KÖKE GÖRE MUTLAK yollar (başında "/") kullanılır — uygulama `public/`i sunucu kökü
// olarak servis ettiği sürece (bkz. README) bu her zaman doğru sonuç verir.
export async function requireAuth({ requireAdmin = false, requireOnboarding = true } = {}) {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) {
    window.location.href = "/login.html";
    return null;
  }
  const user = session.user;

  // Eksik/"yetim" profil satırlarını (ör. şema sıfırlaması sonrası
  // auth.users'ta var olup public.profiles/students/user_gamification'da
  // olmayan hesaplar) her sayfa yüklemesinde otomatik tamamla. Bu olmadan
  // aşağıdaki select'ler null dönüyor ve student/profile'a doğrudan erişen
  // sayfalar (ör. Dersler) sessizce kırılıyordu.
  // NOT: hata burada YUTULMUYOR — konsola yazılıyor. Bu RPC'nin "function
  // does not exist" hatası vermesinin en olası nedeni, ilgili migration'ın
  // (20240601000180 / 20240601000190) henüz `supabase db push` ile
  // veritabanına uygulanmamış olmasıdır.
  const { error: healError } = await supabase.rpc("ensure_my_profile");
  if (healError) {
    console.error("ensure_my_profile RPC failed — muhtemelen migration'lar henüz veritabanına push edilmedi:", healError);
  }

  const { data: profile } = await supabase.from("profiles").select("*").eq("id", user.id).single();
  const { data: student } = await supabase.from("students").select("*").eq("user_id", user.id).single();

  if (requireAdmin && profile?.role !== "admin") {
    window.location.href = "/dashboard.html";
    return null;
  }
  if (!requireAdmin && profile?.role === "admin" && !window.location.pathname.includes("/admin/")) {
    window.location.href = "/admin/index.html";
    return null;
  }
  if (requireOnboarding && student && !student.onboarding_completed && !window.location.pathname.includes("onboarding")) {
    window.location.href = "/onboarding.html";
    return null;
  }

  return { user, profile, student, session };
}

export async function redirectIfAuthed() {
  const { data: { session } } = await supabase.auth.getSession();
  if (session) {
    const { data: profile } = await supabase.from("profiles").select("role").eq("id", session.user.id).single();
    window.location.href = profile?.role === "admin" ? "/admin/index.html" : "/dashboard.html";
  }
}

export async function signOut() {
  await supabase.auth.signOut();
  window.location.href = "/login.html";
}
