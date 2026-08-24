export const SUPABASE_URL = "https://zptzcnzgxphxlxwuzrpo.supabase.co";
export const SUPABASE_ANON_KEY = "sb_publishable_mJzUaaJskzVDkzoctF8tHw_CEya7aLx";

// Push bildirimleri (hatırlatıcılar) için VAPID PUBLIC anahtarı — bu anahtar
// GİZLİ DEĞİLDİR, tarayıcıya gönderilmek üzere tasarlanmıştır (bkz. push.js).
// Eşleşen PRIVATE anahtar yalnızca Supabase Edge Function secret'ı olarak
// saklanır, hiçbir zaman bu depoya (repo) yazılmaz — bkz.
// supabase/functions/send-reminders/README.md.
export const VAPID_PUBLIC_KEY = "BNs0rKPIYVX0llovMXRfL0c0Vd9yEBKRtdHGp5fgTEzRQsypDOsw-99nOCjIwx-B9BASg2enGSp8ekpb1rPxqMA";

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
};

export const NOTIFICATION_PRIORITY_LABELS = { kritik: "Kritik", onemli: "Önemli", normal: "Normal", dusuk: "Düşük" };
export const NOTIFICATION_PRIORITY_COLORS = { kritik: "#dc2626", onemli: "#d97706", normal: "#6366f1", dusuk: "#94a3b8" };
