-- Seed: algoritma ağırlıkları, başarımlar, veri kaynakları, sınav takvimi (gerçek arama
-- sonucu — bkz. kaynak), müfredat (KPSS Lisans Genel Yetenek-Genel Kültür), örnek sorular, haberler.

insert into algorithm_weights (key, weight, description) values
  ('accuracy', 0.30, 'Doğruluk oranı'),
  ('last_test', 0.20, 'Son mini test skoru'),
  ('repetition', 0.15, 'Tekrar başarı oranı'),
  ('time', 0.10, 'Çözüm süresi skoru'),
  ('wrong_count', 0.10, 'Yanlış sayısı cezası'),
  ('self_assessment', 0.10, 'Öz değerlendirme'),
  ('video', 0.05, 'Video etkileşimi');

insert into achievements (code, name, description, icon) values
  ('ilk_soru', 'İlk Adım', 'İlk sorunu çözdün', '🎯'),
  ('yuz_soru', 'Yüzler Kulübü', '100 soru çözdün', '💯'),
  ('bin_soru', 'Bin Bir Gece', '1000 soru çözdün', '🌙'),
  ('yedi_gun_seri', 'Bir Haftalık Azim', '7 gün üst üste çalıştın', '🔥'),
  ('otuz_gun_seri', 'Demir İrade', '30 gün üst üste çalıştın', '🏅');

-- Veri kaynakları (Data Sync Engine'in izleyeceği resmi sayfalar)
insert into data_sources (name, url, source_type, check_frequency_minutes) values
  ('ÖSYM - KPSS Lisans Duyurusu', 'https://www.osym.gov.tr/2026-kamu-personel-secme-sinavi-kpss-lisans-basvurularin-alinmasi', 'osym', 360),
  ('ÖSYM - KPSS Ön Lisans Duyurusu', 'https://www.osym.gov.tr/2026-kpss-on-lisans-basvurularin-alinmasi-20260728141324252', 'osym', 360),
  ('ÖSYM - Sınav Takvimi', 'https://www.osym.gov.tr/TR,8797/sinav-takvimi.html', 'osym', 360),
  ('ÖSYM - Duyurular', 'https://www.osym.gov.tr', 'osym', 180),
  ('MEB - Duyurular', 'https://www.meb.gov.tr/baslicaduyurular', 'meb', 720);

-- Sınav takvimi — 20 Ağustos 2026 tarihli ÖSYM resmi duyurusundan alınmıştır (bkz. README kaynak notu).
insert into exams (name, exam_type, exam_date, application_start, application_end, source, source_url, last_verified_at, confidence, version) values
  ('2026 KPSS Lisans (Genel Yetenek-Genel Kültür)', 'kpss_lisans', '2026-09-06', '2026-07-01', '2026-07-13',
   'ÖSYM Resmi Duyurusu', 'https://www.osym.gov.tr/2026-kamu-personel-secme-sinavi-kpss-lisans-basvurularin-alinmasi', now(), 1.0, 1);

insert into exams (name, exam_type, exam_date, source, confidence, version, is_active) values
  ('2026 KPSS Ön Lisans', 'kpss_onlisans', null, 'Doğrulanmadı — admin panelinden güncellenmeli', 0.3, 1, true),
  ('2026 KPSS Ortaöğretim', 'kpss_ortaogretim', null, 'Doğrulanmadı — admin panelinden güncellenmeli', 0.3, 1, true),
  ('2026 DHBT', 'dhbt', '2026-11-01', 'ÖSYM Resmi Duyurusu (KPSS Lisans sayfası içinde belirtilmiştir)', 0.8, 1, true);

-- Müfredat: KPSS Lisans için 5 ana ders
-- NOT: id'ler burada BİLEREK sabit (hardcoded) UUID'ler olarak veriliyor.
-- Çünkü aşağıda uygulanacak içerik/soru batch dosyaları (batch_01..batch_07)
-- bu tam UUID'lere topic_id olarak referans veriyor. id'ler otomatik
-- (rastgele) üretilseydi o batch'ler foreign key hatası verirdi.
insert into subjects (id, exam_type, name, slug, icon, color, weight, order_index) values
  ('2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'kpss_lisans', 'Türkçe', 'turkce', '📖', '#6366f1', 1.2, 1),
  ('251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'kpss_lisans', 'Matematik', 'matematik', '🔢', '#7c3aed', 1.1, 2),
  ('0074c5df-5b70-4274-9235-a8fcfb386791', 'kpss_lisans', 'Tarih', 'tarih', '🏛️', '#dc2626', 1.0, 3),
  ('e096912f-78c9-431d-8a7b-f5b3c005f472', 'kpss_lisans', 'Coğrafya', 'cografya', '🌍', '#059669', 0.9, 4),
  ('a9ee39e3-e35c-4ff0-885a-4af773855d4d', 'kpss_lisans', 'Vatandaşlık', 'vatandaslik', '⚖️', '#d97706', 0.9, 5);

-- Türkçe konuları
insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('ffe5c195-5fea-45a3-9030-58f122e0e1ee', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Ses Bilgisi', 'ses-bilgisi', 'Türkçedeki ses olaylarını (ünlü/ünsüz uyumu, kaynaştırma) tanır ve uygular.', 1.0, 1),
  ('9683464a-e0ce-493b-ae60-58c924e2ae5c', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Yazım Kuralları', 'yazim-kurallari', 'Yazım (imla) kurallarını doğru uygular.', 1.1, 2),
  ('4d4e66fa-6b06-4194-a222-0ed30c0edd1b', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Noktalama İşaretleri', 'noktalama-isaretleri', 'Noktalama işaretlerinin işlevlerini bilir ve doğru kullanır.', 0.9, 3),
  ('d36b15a7-95b8-4c4e-bf33-8e2737e8099e', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Sözcükte Anlam', 'sozcukte-anlam', 'Sözcüklerin gerçek, mecaz, terim anlamlarını ayırt eder.', 1.0, 4),
  ('eb6df17f-05d4-49df-b626-ba5d585672a9', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Cümlede Anlam', 'cumlede-anlam', 'Cümle içi anlam ilişkilerini (öznel-nesnel, koşul, amaç vb.) çözümler.', 1.1, 5),
  ('f884a167-9e40-4c5c-bc29-810eb13f200e', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Paragraf', 'paragraf', 'Paragrafta ana düşünce, yardımcı düşünce, anlatım tekniklerini belirler.', 1.3, 6);

-- Matematik konuları
insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', '251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'Temel Kavramlar', 'temel-kavramlar', 'Sayı kümelerini ve temel işlem özelliklerini bilir.', 1.0, 1),
  ('d795c6f3-3a19-4f95-9919-007a184ced02', '251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'Bölme ve Bölünebilme', 'bolme-bolunebilme', 'Bölünebilme kurallarını ve OBEB-OKEK''i uygular.', 1.0, 2),
  ('52e4adee-4581-449e-bf2d-39847a1ff32a', '251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'Sayı Basamakları', 'sayi-basamaklari', 'Basamak değeri ve rakam kavramlarıyla ilgili problemleri çözer.', 0.9, 3),
  ('37efade7-3bb5-42a9-9e22-8fcd6c0006b7', '251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'Rasyonel Sayılar', 'rasyonel-sayilar', 'Rasyonel sayılarla dört işlem yapar.', 1.0, 4),
  ('f609f88b-2d72-42bc-bdb7-549657da2fd0', '251746a0-b050-4fbc-8dc1-d2a1856f7f9b', 'Problemler', 'problemler', 'Hareket, yaş, yüzde-kâr-zarar, işçi-havuz problemlerini çözer.', 1.4, 5);

-- Tarih konuları
insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('c876132a-c63c-4a00-bc2b-f40f32d682d6', '0074c5df-5b70-4274-9235-a8fcfb386791', 'İlk Türk Devletleri', 'ilk-turk-devletleri', 'İslamiyet öncesi Türk devletlerinin siyasi ve sosyal yapısını bilir.', 1.0, 1),
  ('145d44b3-a8e7-430f-8778-71fb8929a97d', '0074c5df-5b70-4274-9235-a8fcfb386791', 'Osmanlı Kuruluş Dönemi', 'osmanli-kurulus', 'Osmanlı Devleti''nin kuruluş ve yükseliş dönemi olaylarını sıralar.', 1.1, 2),
  ('091291bb-a136-48e2-94b1-8d12631be6ad', '0074c5df-5b70-4274-9235-a8fcfb386791', 'Kurtuluş Savaşı', 'kurtulus-savasi', 'Milli Mücadele''nin cepheleri ve önemli olaylarını bilir.', 1.3, 3),
  ('3c087fbc-2d70-4b75-880e-8e2f9e4475fb', '0074c5df-5b70-4274-9235-a8fcfb386791', 'İnkılap Tarihi', 'inkilap-tarihi', 'Atatürk İlke ve İnkılaplarını açıklar.', 1.2, 4);

-- Coğrafya konuları
insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('73d24254-55ed-43ae-8627-1456e48059b4', 'e096912f-78c9-431d-8a7b-f5b3c005f472', 'Türkiye''nin Yeri ve Konumu', 'turkiyenin-yeri-konumu', 'Türkiye''nin matematik ve özel konumunun sonuçlarını açıklar.', 1.0, 1),
  ('f4bdef2c-d148-4d88-832f-731b8e3d122c', 'e096912f-78c9-431d-8a7b-f5b3c005f472', 'İklim', 'iklim', 'Türkiye''nin iklim tiplerini ve dağılımını bilir.', 1.0, 2),
  ('6b76a27b-b27e-4065-8325-d027f3f3377a', 'e096912f-78c9-431d-8a7b-f5b3c005f472', 'Nüfus ve Yerleşme', 'nufus-yerlesme', 'Türkiye''de nüfusun dağılışını etkileyen etmenleri açıklar.', 1.0, 3);

-- Vatandaşlık konuları
insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('f046e8ff-0d47-47fa-add9-45a27a151b63', 'a9ee39e3-e35c-4ff0-885a-4af773855d4d', 'Temel Hukuk Kavramları', 'temel-hukuk-kavramlari', 'Hukuk kurallarının özelliklerini ve hukuk sistemini bilir.', 1.0, 1),
  ('86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'a9ee39e3-e35c-4ff0-885a-4af773855d4d', 'Anayasa', 'anayasa', '1982 Anayasası''nın temel ilke ve düzenlemelerini bilir.', 1.2, 2),
  ('37c6d817-c011-4012-9f18-b651bf8b022e', 'a9ee39e3-e35c-4ff0-885a-4af773855d4d', 'Yasama-Yürütme-Yargı', 'yasama-yurutme-yargi', 'Devletin temel organlarının görev ve işleyişini açıklar.', 1.1, 3);

-- Örnek içerik (2 konu için)
insert into topic_contents (topic_id, summary, content_md, example_question)
select t.id,
  'Paragrafta ana düşünce, yardımcı düşünceler ve anlatım teknikleri KPSS''de en çok soru gelen Türkçe konusudur.',
  '## Paragrafta Ana Düşünce

Bir paragrafın ana düşüncesi, yazarın o paragrafta anlatmak istediği temel fikirdir. Genellikle paragrafın başında ya da sonunda yer alır.

**İpuçları:**
- Paragrafın konusu ile ana düşüncesi farklıdır: konu "ne hakkında" sorusuna, ana düşünce "ne söyleniyor" sorusuna cevap verir.
- Örnek/karşılaştırma cümleleri genellikle ana düşünceyi desteklemek için kullanılır, ana düşüncenin kendisi değildir.',
  'Aşağıdaki paragrafın ana düşüncesi nedir? "Kitap okumak, sadece bilgi edinmek değil, aynı zamanda hayal gücünü geliştirmek ve empati kurma becerisini artırmaktır..."'
from topics t join subjects s on s.id = t.subject_id where t.slug = 'paragraf' and s.slug = 'turkce';

insert into topic_contents (topic_id, summary, content_md, example_question)
select t.id,
  'Yaş, hareket, yüzde-kâr-zarar problemleri KPSS Matematik''te en sık çıkan problem tipleridir.',
  '## Problemler

**Yaş Problemleri:** Genellikle "x yıl önce/sonra" ifadeleriyle kurulur, değişkenlerle denklem kurularak çözülür.

**Hareket Problemleri:** Yol = Hız × Zaman formülü temel alınır. Aynı yönde/zıt yönde hareket durumlarına dikkat edilir.

**Yüzde-Kâr-Zarar:** Satış fiyatı, alış fiyatı ve kâr/zarar oranı arasındaki ilişkiler kurulur.',
  'Bir satıcı bir malı %20 kârla satıyor. Satış fiyatı 600 TL ise, malın alış fiyatı kaçtır?'
from topics t join subjects s on s.id = t.subject_id where t.slug = 'problemler' and s.slug = 'matematik';

-- Örnek sorular (Paragraf ve Problemler konularından, kazanım + kaynak alanlarıyla)
insert into questions (topic_id, difficulty, question_text, kazanim, kaynak, explanation, detailed_solution)
select t.id, 'kolay', 'Bir paragrafta yazarın asıl anlatmak istediği düşünceye ne ad verilir?', 'Paragrafta ana düşünceyi belirler.', 'Örnek Soru Bankası', 'Ana düşünce, paragrafın temel iletisidir.', 'Yardımcı düşünceler ana düşünceyi destekler ama onun kendisi değildir; soru kökünde "asıl anlatmak istediği" ifadesi ana düşünceyi işaret eder.'
from topics t join subjects s on s.id=t.subject_id where t.slug='paragraf' and s.slug='turkce';

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, v.txt, v.correct, v.idx from questions q,
(values ('Yardımcı düşünce', false, 1), ('Ana düşünce', true, 2), ('Konu', false, 3), ('Bakış açısı', false, 4)) as v(txt, correct, idx)
where q.question_text = 'Bir paragrafta yazarın asıl anlatmak istediği düşünceye ne ad verilir?';

insert into questions (topic_id, difficulty, question_text, kazanim, kaynak, explanation, detailed_solution)
select t.id, 'orta', 'Bir malın alış fiyatı 500 TL''dir. %20 kârla satılırsa satış fiyatı kaç TL olur?', 'Yüzde-kâr-zarar problemlerini çözer.', 'Örnek Soru Bankası', 'Satış fiyatı = Alış fiyatı + Kâr.', '%20 kâr = 500 × 0.20 = 100 TL. Satış fiyatı = 500 + 100 = 600 TL.'
from topics t join subjects s on s.id=t.subject_id where t.slug='problemler' and s.slug='matematik';

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, v.txt, v.correct, v.idx from questions q,
(values ('550 TL', false, 1), ('580 TL', false, 2), ('600 TL', true, 3), ('620 TL', false, 4)) as v(txt, correct, idx)
where q.question_text = 'Bir malın alış fiyatı 500 TL''dir. %20 kârla satılırsa satış fiyatı kaç TL olur?';

insert into questions (topic_id, difficulty, question_text, kazanim, kaynak, explanation, detailed_solution)
select t.id, 'zor', 'Yaşları toplamı 45 olan bir baba ile oğlunun 5 yıl önceki yaşları toplamı 35 ise, babanın şu anki yaşı kaçtır? (Baba oğuldan 25 yaş büyüktür.)', 'Yaş problemlerinde denklem kurar ve çözer.', 'Örnek Soru Bankası', 'İki denklemli sistemle çözülür.', 'b+o=45, b-o=25 → b=35, o=10. (5 yıl önce toplam: 30+5=35 ✓)'
from topics t join subjects s on s.id=t.subject_id where t.slug='problemler' and s.slug='matematik';

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, v.txt, v.correct, v.idx from questions q,
(values ('30', false, 1), ('32', false, 2), ('35', true, 3), ('38', false, 4)) as v(txt, correct, idx)
where q.question_text like 'Yaşları toplamı 45 olan%';

-- Haberler (gerçek arama sonucundan — 2026-08-20 itibarıyla)
insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, published_at)
select 'sinav_takvimi', '2026 KPSS Lisans sınav tarihi ve başvuru takvimi açıklandı',
  'Genel Yetenek-Genel Kültür oturumu 6 Eylül 2026''da, Alan Bilgisi oturumları 12-13 Eylül 2026''da yapılacak. Başvurular 1-13 Temmuz 2026 tarihleri arasında alındı.',
  'ÖSYM', 'https://www.osym.gov.tr/2026-kamu-personel-secme-sinavi-kpss-lisans-basvurularin-alinmasi', 'resmi', false, now() - interval '1 day'
where not exists (select 1 from news_items where title like '2026 KPSS Lisans sınav tarihi%');

insert into news_items (category, title, summary, source, source_url, source_trust, is_learning_content, published_at)
select 'kpss', 'DHBT başvuruları 22-30 Eylül 2026 tarihlerinde alınacak',
  'Din Hizmetleri Alan Bilgisi Testi (DHBT) 1 Kasım 2026''da yapılacak, başvurular Eylül ayı sonunda alınacak.',
  'ÖSYM', 'https://www.osym.gov.tr/2026-kamu-personel-secme-sinavi-kpss-lisans-basvurularin-alinmasi', 'resmi', false, now() - interval '12 hours'
where not exists (select 1 from news_items where title like 'DHBT başvuruları%');
