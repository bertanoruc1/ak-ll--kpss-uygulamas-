export const SUPABASE_URL = "https://zptzcnzgxphxlxwuzrpo.supabase.co";
export const SUPABASE_ANON_KEY = "sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx";

// Push bildirimleri (hatırlatıcılar) için VAPID PUBLIC anahtarı — bu anahtar
// GİZLİ DEĞİLDİR, tarayıcıya gönderilmek üzere tasarlanmıştır (bkz. push.js).
// Eşleşen PRIVATE anahtar yalnızca Supabase Edge Function secret'ı olarak
// saklanır, hiçbir zaman bu depoya (repo) yazılmaz — bkz.
// supabase/functions/send-reminders/README.md.
//
// ROTASYON NOTU (2026-08-30 güvenlik denetimi): Eski çift, PRIVATE anahtarı
// yanlışlıkla send-reminders/README.md içine düz metin olarak yazılmış ve
// git'e commit edilmiş olduğu için sızmış sayılıyor — bu yüzden tamamen yeni
// bir VAPID çifti üretildi ve burada güncellendi. Eski anahtarla oluşturulmuş
// TÜM push abonelikleri artık geçersizdir (public key değiştiği için tarayıcı
// otomatik olarak yeni abonelik isteyecek) — kullanıcıların bildirim iznini
// tekrar vermesi gerekebilir, bu normaldir.
export const VAPID_PUBLIC_KEY = "BG-PBgyM3gYJkV4Boqg_NcX9k7vu4zOEQ5L307mx8s0jiUM_NY1qO_rlli0bz1WSpqniX_KSt-r3t178hsUUq5Y";

export const EXAM_TYPE_LABELS = {
  kpss_lisans: "KPSS Lisans",
  kpss_onlisans: "KPSS Ön Lisans",
  kpss_ortaogretim: "KPSS Ortaöğretim",
  dhbt: "DHBT",
  diger: "Diğer",
};

export const NEWS_CATEGORY_LABELS = {
  osym: "ÖSYM", kpss: "KPSS", basvuru: "Başvuru", sinav_takvimi: "Sınav Takvimi",
  kilavuz: "Kılavuz", sonuc: "Sonuç", tercih: "Tercih", yerlestirme: "Yerleştirme",
  mufredat: "Müfredat", ders: "Ders", genel_egitim: "Genel Eğitim", onemli_duyuru: "Önemli Duyuru",
  kaynak_kampanya: "Kaynak Kampanyası",
};

export const NOTIFICATION_PRIORITY_LABELS = { kritik: "Kritik", onemli: "Önemli", normal: "Normal", dusuk: "Düşük" };
export const NOTIFICATION_PRIORITY_COLORS = { kritik: "#dc2626", onemli: "#d97706", normal: "#14b8a6", dusuk: "#94a3b8" };
