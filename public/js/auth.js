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
  // olmayan hesaplar) otomatik tamamla. Bu olmadan aşağıdaki select'ler null
  // dönüyor ve student/profile'a doğrudan erişen sayfalar (ör. Dersler)
  // sessizce kırılıyordu.
  //
  // PERFORMANS: Bu healing RPC'si + iki select ÖNCEDEN sırayla (await await
  // await) çalıştırılıyordu — her sayfa geçişinde 3 ardışık network
  // round-trip'i demekti ve "site çok yavaş" şikayetinin en büyük tekil
  // sebebiydi (her tek sayfa yüklemesinde tetikleniyordu). Artık üçü
  // PARALEL çalıştırılıyor; ayrıca healing tipik olarak tek seferlik bir
  // onarımdır — bu sekmede daha önce başarıyla çalıştıysa (sessionStorage)
  // tekrar tekrar çağrılmıyor, bu da tekrarlayan sayfa geçişlerinde 3
  // round-trip'i 2'ye (hatta healing'e hiç gerek yoksa 2 paralel isteğe)
  // indiriyor.
  // NOT: hata burada YUTULMUYOR — konsola yazılıyor. Bu RPC'nin "function
  // does not exist" hatası vermesinin en olası nedeni, ilgili migration'ın
  // (20240601000180 / 20240601000190) henüz `supabase db push` ile
  // veritabanına uygulanmamış olmasıdır.
  const alreadyHealed = sessionStorage.getItem("kpss_profile_healed") === "1";

  const [healResult, profileResult, studentResult] = await Promise.all([
    alreadyHealed ? Promise.resolve({ error: null }) : supabase.rpc("ensure_my_profile"),
    supabase.from("profiles").select("*").eq("id", user.id).single(),
    supabase.from("students").select("*").eq("user_id", user.id).single(),
  ]);

  if (!healResult.error) {
    sessionStorage.setItem("kpss_profile_healed", "1");
  } else {
    console.error("ensure_my_profile RPC failed — muhtemelen migration'lar henüz veritabanına push edilmedi:", healResult.error);
  }

  let profile = profileResult.data;
  let student = studentResult.data;

  // İlk hiç ziyaretse (healing paralel koşarken profil/students satırları
  // henüz yoktu, RPC onları az önce oluşturmuş olabilir) eksik olanı tek
  // seferlik yeniden çek — bu, yalnızca bir hesabın hayatındaki İLK sayfa
  // yüklemesinde ekstra bir round-trip ekler, sonraki hiçbir yüklemede değil.
  if ((!profile || !student) && !alreadyHealed) {
    const [{ data: p2 }, { data: s2 }] = await Promise.all([
      profile ? Promise.resolve({ data: profile }) : supabase.from("profiles").select("*").eq("id", user.id).single(),
      student ? Promise.resolve({ data: student }) : supabase.from("students").select("*").eq("user_id", user.id).single(),
    ]);
    profile = profile || p2;
    student = student || s2;
  }

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
