# KPSS Akıllı Öğrenci Platformu

KPSS'ye hazırlanan öğrenciler için, sadece soru çözme/not okuma değil, **resmi kaynakları
(ÖSYM/MEB) canlı takip eden, değişiklikleri otomatik algılayıp doğrulayan ve çalışma
planını buna göre uyarlayan** bir sistem. Bu depo çalışan bir **MVP**'dir.

> Bu proje, daha önce sizin için teslim edilen genel amaçlı "AkıllıDers" platformundan
> **tamamen bağımsız, sıfırdan** geliştirildi (ayrı Supabase projesi, ayrı kod tabanı) —
> kendi tercihinizle böyle kararlaştırıldı. Supabase ücretsiz planın 2 proje sınırı
> nedeniyle, önceki `akilli-ders-platformu` projesi **silinemedi** (elimdeki araçlarda
> proje silme yok, yalnızca duraklatma var) — bu yüzden **duraklatıldı**, istediğinizde
> Supabase panelinden geri açılabilir.

## Çalışma Felsefesi

`SOURCE → DETECT → VERIFY → NORMALIZE → UPDATE → NOTIFY → ADAPT`

Her kritik veri (sınav tarihi, başvuru tarihi, müfredat) bu boru hattından geçer. Hiçbir
otomatik tespit, düşük güven skoruyla sessizce uygulanmaz — admin onayına düşer. Ayrıntılı
mimari için `ARCHITECTURE.md` dosyasına bakın.

## Teknoloji

- **Frontend:** Saf HTML + ES modules + Tailwind CSS (CDN). Derleme adımı yok.
- **Backend:** Supabase (Postgres + Auth + RLS + PostgREST RPC + Edge Functions + pg_cron/pg_net).
  Tüm iş mantığı (skorlama, planlama, senkronizasyon) sunucu tarafında SECURITY DEFINER
  fonksiyonlar olarak çalışır.
- **Data Sync Engine:** Gerçek bir Supabase Edge Function (`supabase/functions/sync-engine`),
  `pg_cron` ile 30 dakikada bir otomatik tetiklenir, ÖSYM/MEB sayfalarını gerçekten çeker,
  hash'ler ve karşılaştırır.

Proje: `kpss-akilli-platform` — `https://anhoaebychqnjyfcarxr.supabase.co`. Bağlantı
bilgileri `public/js/config.js` içine gömülü (anon key herkese açık kullanılabilir bir
anahtardır, güvenlik RLS ile sağlanır).

## Yerelde Çalıştırma

```bash
cd public
python3 -m http.server 8080
```

Tarayıcıda `http://localhost:8080` açın. (Not: ES modülleri `file://` üzerinden çalışmaz,
mutlaka bir statik sunucu üzerinden servis edin.)

## Klasör Yapısı

```
kpss-akilli/
├── ARCHITECTURE.md          # Kodlamadan önce yazılan mimari tasarım dokümanı
├── supabase/
│   ├── migrations/          # Şema, RLS, iş mantığı fonksiyonları (12 migration, sırayla)
│   └── functions/sync-engine/  # Data Sync Engine Edge Function (Deno)
└── public/
    ├── index.html, login.html, register.html, onboarding.html
    ├── dashboard.html        # Ana sayfa — "Bugün KPSS için ne yapmalıyım?" (9 bölüm)
    ├── news.html             # Haber akışı (kategori filtreli, kaynak linkli)
    ├── subjects.html / topic.html / practice.html / mistakes.html
    ├── notifications.html / profile.html / exams.html / analytics.html / assistant.html
    ├── admin/                # Admin paneli (10 sekme — bkz. aşağı)
    ├── css/styles.css
    └── js/                   # Paylaşılan modüller
```

## Admin Kullanıcısı Nasıl Oluşturulur

1. Uygulamada normal şekilde kayıt olun (`register.html`).
2. Şu SQL'i Supabase panelinden çalıştırın (ya da bana e-posta adresinizi söyleyin):
   ```sql
   update public.profiles set role = 'admin' where email = 'sizin@eposta.com';
   ```
3. Bir sonraki girişte otomatik olarak `admin/index.html`'e yönlendirilirsiniz.

## Uygulanan Modüller

- **Sınav Takvimi Motoru:** `exams` tablosu canlı/versiyonlu (asla hardcode edilmez).
  Gerçek arama sonucuna dayanan seed verisi: **2026 KPSS Lisans — Genel Yetenek-Genel
  Kültür 6 Eylül 2026, Alan Bilgisi 12-13 Eylül 2026, başvuru 1-13 Temmuz 2026**
  (kaynak: ÖSYM resmi duyurusu, `exams.source_url` alanında). Ön Lisans/Ortaöğretim
  kayıtları düşük güven (`confidence=0.3`) ile "doğrulanmadı" olarak işaretli — admin
  panelinden gerçek tarihlerle güncellenmeli.
- **Data Sync Engine:** `supabase/functions/sync-engine` — 5 resmi kaynağı (ÖSYM
  duyuruları, sınav takvimi, MEB duyuruları) gerçekten HTTP ile çeker, SHA-256 hash'ler,
  önceki hash ile karşılaştırır, `sync_log`'a yazar. Bu oturumda **canlı test edildi** —
  gerçek ÖSYM sayfalarına başarıyla bağlandı (bkz. "Doğrulama" bölümü). `pg_cron` ile
  30 dakikada bir otomatik çalışır; admin panelinden "Şimdi Senkronize Et" ile manuel
  de tetiklenebilir.
- **Kaynak güven hiyerarşisi:** `data_sources.source_type` (osym > meb > destekleyici),
  her tespit bir `confidence` skoruyla gelir. `apply_exam_field_change`/
  `apply_curriculum_change` RPC'leri, sync_engine kaynaklı düşük güvenli (exam: <0.85,
  müfredat: <0.70) değişiklikleri **asla otomatik uygulamaz** — `admin_audit_log`'a
  "pending_review" olarak düşer, admin onaylamadan öğrenciye hiçbir etkisi olmaz.
- **Haber Motoru:** `news_items` — kategori (ÖSYM/KPSS/Başvuru/Sınav Takvimi/Kılavuz/
  Sonuç/Tercih/Yerleştirme/Müfredat/Ders/Genel Eğitim/Önemli Duyuru), her haberde kaynak
  + "Resmi kaynağı görüntüle" linki. `is_learning_content` alanı "Haber" ile "Güncel
  Bilgiler"i kesin olarak ayırır.
- **Müfredat Motoru:** `topics` tablosu versiyonlu (`version`, `status`), her değişiklik
  `curriculum_change_log`'a düşer. Yeni konu tespit edildiğinde otomatik "İçerik
  Bekliyor" durumunda oluşturulur ve etkilenen öğrencilere bildirim gider.
- **Learning Engine (KnowledgeScore):** %30 doğruluk + %20 son test + %15 tekrar başarısı
  + %10 süre + %10 yanlış sayısı + %10 öz değerlendirme + %5 video etkileşimi.
  Ağırlıklar `algorithm_weights` tablosunda saklanır. Her soru `kazanim` + `kaynak`
  alanlarını taşır. "Bu konuyu anladım" skoru asla %100 yapmaz — yalnızca ağırlıklı
  formülün bir bileşenidir.
- **Video izleme ve Mini Test:** `mark_video_watched`/`submit_mini_test` RPC'leri
  `video_interactions`/`last_test_score`'u gerçekten besler (yaygın bir tasarım hatası
  olan "formülde ağırlığı var ama hiçbir yerden güncellenmiyor" durumunu önler).
- **Spaced Repetition:** 1→3→7→14→30 gün merdiveni, başarısızlıkta 3 güne kısalır.
- **Study Planner:** Sınava kalan güne göre dinamik oranlar (90+g: %60/25/15 → 7g:
  %10/60/30), event-reaktif yeniden planlama (`replan_due_to_event` — sınav tarihi
  değişince kritik bildirim + yeniden planlama tetiklenir).
- **Tek Öncelik Önerisi:** `get_today_priority()` — aciliyet skoruna göre tek bir konu +
  gerekçe cümlesi üretir (örn. "Matematik–Problemler, çünkü başarı %51, son test %45,
  6 gündür tekrar edilmedi, sınava 17 gün kaldı → 30dk tekrar + 20 soru").
- **Notification Engine:** 10 event tipi, 4 öncelik seviyesi (kritik/önemli/normal/
  düşük), spam engelleme (`notify_user` — yeni değer eskiyle aynıysa bildirim üretmez).
- **AI İçerik Onay Kuyruğu:** Haberden taslak flashcard/soru/özet üretilir
  (`generate_ai_draft_from_news`), **admin onaylamadan asla** öğrenciye gösterilmez
  (`ai_content_queue.status`: ai_generated → approved/rejected → published).
- **AI Çalışma Asistanı:** Kural tabanlı, öğrencinin gerçek performans verisine göre
  kişiselleştirilmiş yanıt üretir. Gerçek bir LLM'e bağlamak için aşağıdaki bölüme bakın.
- **Yanlışlarım:** Ders bazlı gruplu, çözülmemiş yanlışlar + detaylı çözüm + tekrar pratiği.
- **Admin Paneli (10 sekme):** Genel Bakış, Sınav Takvimi, Müfredat, Sorular, Haberler,
  AI Onay Kuyruğu, Veri Kaynakları/Sync Monitor (canlı senkronizasyon durumu + manuel
  tetikleme), Audit Log (OLD/NEW/SOURCE/DETECTED/CONFIDENCE), Öğrenciler, Bildirim Gönder.
- **Güvenlik:** RLS her tabloda; `question_choices` (doğru cevaplar) öğrenciye **hiçbir
  zaman doğrudan** açılmaz, yalnızca sunucu tarafı `get_next_question`/`submit_answer`
  RPC'leri üzerinden dolaylı olarak kullanılır. İç yardımcı fonksiyonlar ve admin/
  sync-engine fonksiyonları `anon`'dan (Supabase'in her yeni fonksiyona otomatik verdiği
  varsayılan yetkiden) açıkça geri alındı — bu oturumda `pg_proc.proacl` sorgusuyla
  doğrulandı.

## Bu Oturumda Yapılan Doğrulama

- Geçici bir test kullanıcısıyla (Supabase üzerinde, sonra tamamen temizlendi) uçtan uca
  akış simüle edildi: kayıt tetikleyicisi → `generate_study_plan` (doğru oran
  hesaplaması, elle doğrulandı) → `get_homepage` (9 bölümün tamamı doğru veri döndü) →
  `get_next_question` (doğru cevap istemciye asla sızmadı) → `submit_answer` (KnowledgeScore
  formülü elle doğrulandı: 85 = 0.30×100 + 0.20×100 + 0.15×100 + 0.10×100 + 0.10×100 +
  0.10×0 + 0.05×0) → `mark_topic_understood` → `complete_repetition` (başarısızlıkta
  +3 gün doğru hesaplandı) → `mark_video_watched` → `submit_mini_test` → `ai_assistant_ask`.
- İkinci bir test kullanıcısıyla **RLS izolasyonu** doğrulandı: bir öğrenci diğerinin
  `topic_progress` satırlarını göremiyor.
- **Data Sync Engine gerçekten çalıştırıldı**: Edge Function, 5 gerçek ÖSYM/MEB URL'sine
  bağlandı, içerik hash'ledi, `data_sources`/`sync_log` tablolarına yazdı (HTTP 200,
  gerçek zaman damgalarıyla doğrulandı).
- `get_advisors(security)` ile fonksiyon izinleri kontrol edildi; `anon` rolünün
  authenticated-only RPC'lere doğrudan erişimi olduğu tespit edilip düzeltildi
  (0009 migration) ve yeniden doğrulandı.
- Test kullanıcıları temizlendi, kademeli (cascade) silme ile hiç yetim satır kalmadığı
  doğrulandı.

## Gerçek AI Entegrasyonu (opsiyonel yükseltme)

Şu anki AI asistan ve haber-özetleme kural tabanlıdır (harici API anahtarı gerektirmez).
Gerçek bir LLM'e bağlamak isterseniz:

1. Bir Supabase Edge Function oluşturup Anthropic/OpenAI API'sini çağırın, API anahtarını
   Supabase proje sırları (secrets) olarak saklayın.
2. `ai_assistant_ask` ve `generate_ai_draft_from_news` fonksiyonlarını, ilgili verileri bir
   prompt'a gömüp bu Edge Function'ı çağıracak şekilde güncelleyin.
3. İsterseniz bu adımı sizin için yapabilirim.

## Bilinen Sınırlamalar / Dürüstlük Notları

- **Data Sync Engine'in yapısal veri çıkarımı (tarih/alan tespiti) sınırlıdır.** Motor
  gerçekten HTTP ile resmi sayfaları çekiyor ve içerik değişikliğini gerçek şekilde
  tespit ediyor; ancak ÖSYM'nin HTML yapısından "hangi tarih hangi alana ait" çıkarımı
  basit bir regex/tarih-deseni sinyaline dayanır ve **güven skoru düşükse asla otomatik
  uygulanmaz** — admin onayına düşer. Bu, spesifikasyondaki "asla halüsinasyona
  güvenme" güvenlik gereksinimini karşılamak için bilinçli bir tasarım tercihidir.
- **KPSS Deneme Sistemi (zamanlı tam deneme sınavı)** spesifikasyonda da "gelecek" olarak
  işaretlenmişti — bu MVP'de uygulanmadı, ama veri modeli (`user_answers`, `questions`)
  buna genişlemeye uygun.
- **Öğretmen/veli panelleri, canlı dersler** yol haritada, `profiles.role` bu genişlemeye
  izin verir.
- Push bildirimleri yok; `notifications` tablosu ve admin'den toplu bildirim gönderme var,
  tarayıcı/mobil push için ayrıca bir servis (web push/FCM) bağlanmalı.
- Ön Lisans/Ortaöğretim/DHBT sınav tarihleri seed verisinde düşük güvenle işaretli —
  admin panelinden gerçek ÖSYM duyurularıyla güncellenmesi önerilir.
