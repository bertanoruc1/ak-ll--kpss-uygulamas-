-- kpss_lisans için kurulan 5 ders / 21 konu / 147 soruyu (105 temel + 42 ek) aynı
-- içerikle kpss_onlisans ve kpss_ortaogretim sınav türlerine de kopyalar. KPSS Genel
-- Yetenek-Genel Kültür (Türkçe, Matematik, Tarih, Coğrafya, Vatandaşlık) müfredatı bu
-- üç seviyede büyük ölçüde ortaktır; böylece Ön Lisans/Ortaöğretim adaylarının
-- onboarding'de bu türleri seçmesi durumunda dersler sayfası artık boş kalmaz.

begin;

-- ===================== kpss_onlisans =====================
insert into subjects (id, exam_type, name, slug, icon, color, weight, order_index) values
  ('2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'kpss_onlisans', 'Türkçe', 'turkce', '📖', '#6366f1', 1.2, 1),
  ('5e8d52db-5530-45fc-b778-f11f81312e04', 'kpss_onlisans', 'Matematik', 'matematik', '🔢', '#7c3aed', 1.1, 2),
  ('af4ca742-d514-473e-8682-b85af5d732b2', 'kpss_onlisans', 'Tarih', 'tarih', '🏛️', '#dc2626', 1.0, 3),
  ('d4fec40c-ccfa-447f-a40b-547c3f30cbe9', 'kpss_onlisans', 'Coğrafya', 'cografya', '🌍', '#059669', 0.9, 4),
  ('b234f580-5077-4fd1-a816-d547e2943c3b', 'kpss_onlisans', 'Vatandaşlık', 'vatandaslik', '⚖️', '#d97706', 0.9, 5);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('2d6bd953-efd9-4148-9a05-af0124ee9484', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Ses Bilgisi', 'ses-bilgisi', 'Türkçedeki ses olaylarını (ünlü/ünsüz uyumu, kaynaştırma) tanır ve uygular.', 1.0, 1),
  ('c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Yazım Kuralları', 'yazim-kurallari', 'Yazım (imla) kurallarını doğru uygular.', 1.1, 2),
  ('f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Noktalama İşaretleri', 'noktalama-isaretleri', 'Noktalama işaretlerinin işlevlerini bilir ve doğru kullanır.', 0.9, 3),
  ('8caf048a-ea8c-4fdf-963f-2f2181586d99', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Sözcükte Anlam', 'sozcukte-anlam', 'Sözcüklerin gerçek, mecaz, terim anlamlarını ayırt eder.', 1.0, 4),
  ('377a645a-e795-4ac7-826e-79daf8b0f71e', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Cümlede Anlam', 'cumlede-anlam', 'Cümle içi anlam ilişkilerini (öznel-nesnel, koşul, amaç vb.) çözümler.', 1.1, 5),
  ('71faddb6-6b16-4792-b9d7-e0da4afedaff', '2f3f207d-2b81-4302-9d6f-224ab76ac2e7', 'Paragraf', 'paragraf', 'Paragrafta ana düşünce, yardımcı düşünce, anlatım tekniklerini belirler.', 1.3, 6);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('d5e7d6ba-9273-45f0-b054-e629e31debb3', '5e8d52db-5530-45fc-b778-f11f81312e04', 'Temel Kavramlar', 'temel-kavramlar', 'Sayı kümelerini ve temel işlem özelliklerini bilir.', 1.0, 1),
  ('a49df68d-898b-4fc9-8588-8376bf5fc243', '5e8d52db-5530-45fc-b778-f11f81312e04', 'Bölme ve Bölünebilme', 'bolme-bolunebilme', 'Bölünebilme kurallarını ve OBEB-OKEK''i uygular.', 1.0, 2),
  ('f0049e53-57c1-444f-ae91-1095c74619c5', '5e8d52db-5530-45fc-b778-f11f81312e04', 'Sayı Basamakları', 'sayi-basamaklari', 'Basamak değeri ve rakam kavramlarıyla ilgili problemleri çözer.', 0.9, 3),
  ('1967a34a-00a7-4c4d-858c-3892d3444962', '5e8d52db-5530-45fc-b778-f11f81312e04', 'Rasyonel Sayılar', 'rasyonel-sayilar', 'Rasyonel sayılarla dört işlem yapar.', 1.0, 4),
  ('17f97465-ab68-42f7-abac-bce58e6b7d2d', '5e8d52db-5530-45fc-b778-f11f81312e04', 'Problemler', 'problemler', 'Hareket, yaş, yüzde-kâr-zarar, işçi-havuz problemlerini çözer.', 1.4, 5);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'af4ca742-d514-473e-8682-b85af5d732b2', 'İlk Türk Devletleri', 'ilk-turk-devletleri', 'İslamiyet öncesi Türk devletlerinin siyasi ve sosyal yapısını bilir.', 1.0, 1),
  ('b606fed8-a975-40b5-8825-c55b080bee38', 'af4ca742-d514-473e-8682-b85af5d732b2', 'Osmanlı Kuruluş Dönemi', 'osmanli-kurulus', 'Osmanlı Devleti''nin kuruluş ve yükseliş dönemi olaylarını sıralar.', 1.1, 2),
  ('9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'af4ca742-d514-473e-8682-b85af5d732b2', 'Kurtuluş Savaşı', 'kurtulus-savasi', 'Milli Mücadele''nin cepheleri ve önemli olaylarını bilir.', 1.3, 3),
  ('07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'af4ca742-d514-473e-8682-b85af5d732b2', 'İnkılap Tarihi', 'inkilap-tarihi', 'Atatürk İlke ve İnkılaplarını açıklar.', 1.2, 4);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'd4fec40c-ccfa-447f-a40b-547c3f30cbe9', 'Türkiye''nin Yeri ve Konumu', 'turkiyenin-yeri-konumu', 'Türkiye''nin matematik ve özel konumunun sonuçlarını açıklar.', 1.0, 1),
  ('37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'd4fec40c-ccfa-447f-a40b-547c3f30cbe9', 'İklim', 'iklim', 'Türkiye''nin iklim tiplerini ve dağılımını bilir.', 1.0, 2),
  ('c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'd4fec40c-ccfa-447f-a40b-547c3f30cbe9', 'Nüfus ve Yerleşme', 'nufus-yerlesme', 'Türkiye''de nüfusun dağılışını etkileyen etmenleri açıklar.', 1.0, 3);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('36e2daaa-064f-4b75-b465-d649577b4a15', 'b234f580-5077-4fd1-a816-d547e2943c3b', 'Temel Hukuk Kavramları', 'temel-hukuk-kavramlari', 'Hukuk kurallarının özelliklerini ve hukuk sistemini bilir.', 1.0, 1),
  ('f887b0f6-c0ab-468e-b053-8c335bd02151', 'b234f580-5077-4fd1-a816-d547e2943c3b', 'Anayasa', 'anayasa', '1982 Anayasası''nın temel ilke ve düzenlemelerini bilir.', 1.2, 2),
  ('7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'b234f580-5077-4fd1-a816-d547e2943c3b', 'Yasama-Yürütme-Yargı', 'yasama-yurutme-yargi', 'Devletin temel organlarının görev ve işleyişini açıklar.', 1.1, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('d5e7d6ba-9273-45f0-b054-e629e31debb3', 'Doğal, tam ve rasyonel sayı kümelerini, dört işlemde işlem önceliğini ve sayıların sıralanmasını kapsayan temel konudur.', '## Doğal, Tam ve Rasyonel Sayılar
- **Doğal sayılar (N):** 0, 1, 2, 3, ... şeklinde devam eden, negatif olmayan sayılardır.
- **Tam sayılar (Z):** Doğal sayılar ve bunların negatifleridir: ..., -3, -2, -1, 0, 1, 2, 3, ...
- **Rasyonel sayılar (Q):** a/b şeklinde yazılabilen (b≠0) sayılardır; kesirler ve ondalık sayılar bu kümeye dahildir.

## Dört İşlem ve İşlem Önceliği
Bir işlemde sırasıyla uygulanır:
1. Parantez içi işlemler
2. Çarpma ve bölme (soldan sağa)
3. Toplama ve çıkarma (soldan sağa)

**Örnek:** 12 + 3 × 4 − 6 işlemini hesaplayalım.
Önce çarpma yapılır: 3 × 4 = 12
Sonra soldan sağa toplama/çıkarma: 12 + 12 − 6 = 18

## Negatif Sayılarla İşlem
- (+) × (+) = (+), (−) × (−) = (+), (+) × (−) = (−)
- Aynı işaret kuralı bölme için de geçerlidir.

**Örnek:** (−3) × (4 − 7) + (−2) × 5
= (−3) × (−3) + (−10)
= 9 − 10 = −1

## Sıralama (Karşılaştırma)
Sayı doğrusunda sağa gidildikçe sayılar büyür. Negatif sayılarda mutlak değeri büyük olan sayı küçüktür: −8 < −5 < −3 < 2.

## Sözel İfadeleri Denkleme Çevirme
Temel kavramlar konusunda birinci dereceden denklemler de sık sorulur.

**Örnek:** Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?
2(x+3) = 3(x−5)
2x + 6 = 3x − 15
21 = x

Bu tür sorularda dağılma özelliğinin doğru uygulanmasına ve terimlerin doğru taşınmasına dikkat edilmelidir.', '24 ÷ 4 + 3 × (5 − 2) işleminin sonucu kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('133e199d-b201-47a0-9502-3968d4c1d77a', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'kolay'::difficulty_level, '12 + 3 × 4 − 6 işleminin sonucu kaçtır?', 'Dört işlemde işlem önceliğini doğru uygular.', 'Önce çarpma yapılır: 3 × 4 = 12. Sonra soldan sağa toplama ve çıkarma yapılır: 12 + 12 − 6 = 18.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('133e199d-b201-47a0-9502-3968d4c1d77a', '54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('133e199d-b201-47a0-9502-3968d4c1d77a', '18', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('133e199d-b201-47a0-9502-3968d4c1d77a', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('133e199d-b201-47a0-9502-3968d4c1d77a', '30', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0ae5ff03-8f99-41fd-9208-62db107dd97c', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'kolay'::difficulty_level, '-5, -8, -3, 2 tam sayılarından hangisi en küçüktür?', 'Tam sayıları büyüklük-küçüklük ilişkisine göre sıralar.', 'Negatif sayılarda mutlak değeri büyük olan sayı küçüktür. Sayı doğrusunda sıralama: −8 < −5 < −3 < 2 olduğundan en küçük sayı −8''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0ae5ff03-8f99-41fd-9208-62db107dd97c', '-5', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0ae5ff03-8f99-41fd-9208-62db107dd97c', '-8', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0ae5ff03-8f99-41fd-9208-62db107dd97c', '-3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0ae5ff03-8f99-41fd-9208-62db107dd97c', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('75b02bcb-10e5-4160-ac9a-e4788fb669ca', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'orta'::difficulty_level, '(−3) × (4 − 7) + (−2) × 5 işleminin sonucu kaçtır?', 'Negatif sayılarla çarpma ve toplama işlemlerini yapar.', 'Önce parantez: 4 − 7 = −3. Sonra çarpmalar: (−3)×(−3) = 9 ve (−2)×5 = −10. Son olarak toplama: 9 + (−10) = −1.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75b02bcb-10e5-4160-ac9a-e4788fb669ca', '-19', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75b02bcb-10e5-4160-ac9a-e4788fb669ca', '-1', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75b02bcb-10e5-4160-ac9a-e4788fb669ca', '19', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75b02bcb-10e5-4160-ac9a-e4788fb669ca', '1', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('36ccf008-c555-4b85-96a6-ad18dee00d22', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'orta'::difficulty_level, 'Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip birinci dereceden denklemi çözer.', '2(x+3) = 3(x−5) → 2x + 6 = 3x − 15 → 6 + 15 = 3x − 2x → x = 21. Kontrol: 2×(21+3)=48 ve 3×(21−5)=48, eşit olduğundan doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36ccf008-c555-4b85-96a6-ad18dee00d22', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36ccf008-c555-4b85-96a6-ad18dee00d22', '11', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36ccf008-c555-4b85-96a6-ad18dee00d22', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36ccf008-c555-4b85-96a6-ad18dee00d22', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('531b4e26-fa62-4f2f-81d7-b164fa4f65f6', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'zor'::difficulty_level, 'Ali''nin yaşının 2 katının 5 fazlası, Ayşe''nin yaşının 3 katının 7 eksiğine eşittir. Ayşe 20 yaşında olduğuna göre Ali kaç yaşındadır?', 'Karmaşık sözel ifadelerden denklem kurup çözer.', 'Denklem: 2A + 5 = 3(20) − 7. Sağ taraf: 3×20−7 = 60−7 = 53. Buradan 2A + 5 = 53 → 2A = 48 → A = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('531b4e26-fa62-4f2f-81d7-b164fa4f65f6', '17', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('531b4e26-fa62-4f2f-81d7-b164fa4f65f6', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('531b4e26-fa62-4f2f-81d7-b164fa4f65f6', '29', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('531b4e26-fa62-4f2f-81d7-b164fa4f65f6', '48', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('a49df68d-898b-4fc9-8588-8376bf5fc243', 'Sayıların 2, 3, 4, 5, 6, 8, 9, 10, 11 ile bölünebilme kurallarını ve EBOB/EKOK hesaplamalarını kapsayan konudur.', '## Bölünebilme Kuralları
- **2 ile:** Son rakam 0, 2, 4, 6, 8 ise
- **3 ile:** Rakamlar toplamı 3''ün katı ise
- **4 ile:** Son iki basamak 00 veya 4''ün katı ise
- **5 ile:** Son rakam 0 veya 5 ise
- **6 ile:** Hem 2 hem 3 ile bölünüyorsa
- **8 ile:** Son üç basamak 000 veya 8''in katı ise
- **9 ile:** Rakamlar toplamı 9''un katı ise
- **10 ile:** Son rakam 0 ise
- **11 ile:** Tek ve çift sıradaki basamakların toplamları farkı 0 veya 11''in katı ise

**Örnek:** 342 sayısı 9 ile tam bölünür mü?
Rakamlar toplamı: 3+4+2=9, 9''un katı olduğundan 342, 9 ile tam bölünür (342÷9=38).

## EBOB (Ortak Bölen)
İki veya daha çok sayının ortak bölenlerinin en büyüğüdür. Sayılar asal çarpanlarına ayrılır, ortak olan asal çarpanların en küçük kuvvetleri çarpılır.

**Örnek:** 48 ve 60''ın EBOB''u
48 = 2⁴×3, 60 = 2²×3×5
Ortak asal çarpanlar: 2² ve 3 → EBOB = 2²×3 = 12

## EKOK (Ortak Kat)
İki veya daha çok sayının ortak katlarının en küçüğüdür. Tüm asal çarpanlar, ortak olanların en büyük kuvveti alınarak çarpılır.

**Örnek:** 48 ve 60''ın EKOK''u
EKOK = 2⁴×3×5 = 240

## Önemli Özellik
İki sayının EBOB''u ile EKOK''unun çarpımı, o iki sayının çarpımına eşittir:
EBOB(a,b) × EKOK(a,b) = a × b

Bu özellik, sayılardan biri bilinmediğinde diğerini bulmak için sıkça kullanılır.', '126 sayısı 9 ile tam bölünür mü? Rakamlar toplamını bularak açıklayınız.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('38473505-36c1-4676-a01e-e750ed59122a', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 9 ile tam bölünür? 342, 245, 368, 451', 'Bölünebilme kurallarını kullanarak 9 ile bölünebilirliği tespit eder.', '342: 3+4+2=9 → 9''un katı, bölünür. 245: 2+4+5=11 → bölünmez. 368: 3+6+8=17 → bölünmez. 451: 4+5+1=10 → bölünmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38473505-36c1-4676-a01e-e750ed59122a', '342', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38473505-36c1-4676-a01e-e750ed59122a', '245', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38473505-36c1-4676-a01e-e750ed59122a', '368', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38473505-36c1-4676-a01e-e750ed59122a', '451', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('29a7b31a-0e49-4258-afd8-e5799707dc97', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 4 ile tam bölünür? 1234, 1416, 2350, 3115', '4 ile bölünebilme kuralını uygular.', 'Bir sayının 4 ile bölünmesi için son iki basamağının 4''ün katı olması gerekir. 1234''te son iki basamak 34 (bölünmez), 1416''da 16 (4''ün katı, bölünür), 2350''de 50 (bölünmez), 3115 tek sayı (bölünmez).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29a7b31a-0e49-4258-afd8-e5799707dc97', '1234', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29a7b31a-0e49-4258-afd8-e5799707dc97', '1416', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29a7b31a-0e49-4258-afd8-e5799707dc97', '2350', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29a7b31a-0e49-4258-afd8-e5799707dc97', '3115', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2e90a13a-58a0-418a-aa67-d1fc666eb151', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'orta'::difficulty_level, '48 ve 60 sayılarının EBOB''u kaçtır?', 'İki sayının EBOB''unu asal çarpanlarına ayırarak bulur.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük kuvvetleri: 2² ve 3. EBOB = 2²×3 = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e90a13a-58a0-418a-aa67-d1fc666eb151', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e90a13a-58a0-418a-aa67-d1fc666eb151', '240', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e90a13a-58a0-418a-aa67-d1fc666eb151', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e90a13a-58a0-418a-aa67-d1fc666eb151', '6', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('91c47120-adb0-4ea2-a86b-0471f49567e5', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'orta'::difficulty_level, 'Bir sayı hem 6 hem de 8 ile tam bölünmektedir. Bu sayı en az kaç olabilir?', 'İki sayının EKOK''unu bulur.', 'İstenen en küçük sayı EKOK(6,8)''dir. 6=2×3, 8=2³. EKOK = 2³×3 = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('91c47120-adb0-4ea2-a86b-0471f49567e5', '48', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('91c47120-adb0-4ea2-a86b-0471f49567e5', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('91c47120-adb0-4ea2-a86b-0471f49567e5', '2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('91c47120-adb0-4ea2-a86b-0471f49567e5', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f3e6078f-d83f-46c4-b733-8b56ed28dde3', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'zor'::difficulty_level, 'EBOB''u 8, EKOK''u 240 olan iki sayıdan biri 40 olduğuna göre diğer sayı kaçtır?', 'EBOB ve EKOK arasındaki ilişkiyi kullanarak problem çözer.', 'EBOB × EKOK = sayıların çarpımı kuralından: 8 × 240 = 40 × diğer sayı → 1920 = 40 × diğer sayı → diğer sayı = 1920 ÷ 40 = 48.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f3e6078f-d83f-46c4-b733-8b56ed28dde3', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f3e6078f-d83f-46c4-b733-8b56ed28dde3', '48', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f3e6078f-d83f-46c4-b733-8b56ed28dde3', '200', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f3e6078f-d83f-46c4-b733-8b56ed28dde3', '1920', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f0049e53-57c1-444f-ae91-1095c74619c5', 'Basamak değeri, rakamların toplamı ve sayı oluşturma/yer değiştirme problemlerini kapsayan konudur.', '## Basamak ve Basamak Değeri
Bir sayıdaki her rakamın bulunduğu konuma göre bir basamak adı (birler, onlar, yüzler, binler...) ve bir de basamak değeri vardır.

**Basamak değeri** = rakam × bulunduğu basamağın değeri (1, 10, 100, 1000...)

**Örnek:** 347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri: 4×10=40

## Rakamların Toplamı
Bir sayının rakamları toplamı, sayıyı oluşturan tüm rakamların basit toplamıdır (basamak değeri değil, rakamın kendisi toplanır).

**Örnek:** 2856 sayısının rakamları toplamı: 2+8+5+6=21

## Sayı Oluşturma Problemleri
Bu tip sorularda en büyük, en küçük, rakamları farklı gibi ifadelere dikkat edilmelidir.
- En büyük rakamlar sayının en solunda (en yüksek basamakta) yer alır.
- Rakamları farklı en küçük iki basamaklı sayı 10''dur (ilk rakam 0 olamaz).

**Örnek:** Rakamları farklı iki basamaklı en büyük sayı ile en küçük sayının farkı: 98 − 10 = 88

## Basamakları Yer Değiştirme Problemleri
İki basamaklı bir sayı 10a+b şeklinde yazılır (a: onlar, b: birler basamağı). Rakamları yer değiştirdiğinde sayı 10b+a olur.
Fark: (10b+a) − (10a+b) = 9(b−a)

**Örnek:** Rakamları toplamı 12 olan bir sayının rakamları yer değiştirdiğinde sayı 18 artıyorsa:
a+b=12, 9(b−a)=18 → b−a=2
İki denklem birlikte çözülürse b=7, a=5 → sayı 57

Bu formül (basamak farkının 9 katı), basamak yer değiştirme problemlerinin çözümünde çok işe yarar.', '528 sayısında 5 rakamının basamak değeri kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('38d1352b-9e8e-4c1b-b603-4ad0f8e97eb9', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'kolay'::difficulty_level, '347 sayısında 4 rakamının basamak değeri kaçtır?', 'Bir rakamın basamak değerini hesaplar.', '347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri = rakam × basamağın değeri = 4×10 = 40.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38d1352b-9e8e-4c1b-b603-4ad0f8e97eb9', '4', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38d1352b-9e8e-4c1b-b603-4ad0f8e97eb9', '40', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38d1352b-9e8e-4c1b-b603-4ad0f8e97eb9', '300', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38d1352b-9e8e-4c1b-b603-4ad0f8e97eb9', '34', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a19c108d-2439-4c20-9526-8d83006f3db5', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'kolay'::difficulty_level, '2856 sayısının rakamları toplamı kaçtır?', 'Bir sayının rakamları toplamını bulur.', 'Rakamlar tek tek toplanır: 2+8+5+6 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a19c108d-2439-4c20-9526-8d83006f3db5', '16', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a19c108d-2439-4c20-9526-8d83006f3db5', '20', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a19c108d-2439-4c20-9526-8d83006f3db5', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a19c108d-2439-4c20-9526-8d83006f3db5', '22', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('40a0e984-376e-4a21-8417-933c1f34f402', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'orta'::difficulty_level, 'Üç basamaklı en büyük tek sayı ile üç basamaklı en küçük çift sayının toplamı kaçtır?', 'En büyük/en küçük sayı kavramlarını kullanarak işlem yapar.', 'Üç basamaklı en büyük tek sayı 999''dur. Üç basamaklı en küçük sayı 100 olup çift sayıdır. Toplam: 999 + 100 = 1099.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40a0e984-376e-4a21-8417-933c1f34f402', '1098', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40a0e984-376e-4a21-8417-933c1f34f402', '1099', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40a0e984-376e-4a21-8417-933c1f34f402', '1101', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40a0e984-376e-4a21-8417-933c1f34f402', '1100', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7a8d6cdc-e3be-4486-8990-a201987179a7', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'orta'::difficulty_level, 'Rakamları farklı olan iki basamaklı en büyük sayı ile rakamları farklı olan iki basamaklı en küçük sayının farkı kaçtır?', 'Rakamları farklı en büyük ve en küçük sayıları oluşturur.', 'Rakamları farklı iki basamaklı en büyük sayı 98''dir (99''da rakamlar aynı olduğundan geçersizdir). Rakamları farklı en küçük iki basamaklı sayı 10''dur. Fark: 98 − 10 = 88.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7a8d6cdc-e3be-4486-8990-a201987179a7', '89', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7a8d6cdc-e3be-4486-8990-a201987179a7', '88', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7a8d6cdc-e3be-4486-8990-a201987179a7', '86', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7a8d6cdc-e3be-4486-8990-a201987179a7', '87', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7e56f692-dc96-4dd4-9a8f-32e00705ed8a', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 12''dir. Bu sayının rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 18 fazla olduğuna göre ilk sayı kaçtır?', 'Basamakları yer değiştirme problemlerini denklemle çözer.', 'Sayı 10a+b olsun. a+b=12 ve (10b+a)−(10a+b)=18 → 9(b−a)=18 → b−a=2. a+b=12 ve b−a=2 denklemlerini toplarsak 2b=14 → b=7, a=5. İlk sayı 10×5+7=57.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7e56f692-dc96-4dd4-9a8f-32e00705ed8a', '75', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7e56f692-dc96-4dd4-9a8f-32e00705ed8a', '57', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7e56f692-dc96-4dd4-9a8f-32e00705ed8a', '66', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7e56f692-dc96-4dd4-9a8f-32e00705ed8a', '93', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('1967a34a-00a7-4c4d-858c-3892d3444962', 'Kesirler ve ondalık sayılarda çevirme, karşılaştırma ve dört işlem becerilerini kapsayan konudur.', '## Kesirler ve Ondalık Sayılar
Bir kesir a/b, a payı b paydayı gösterir. Kesri ondalık sayıya çevirmek için pay paydaya bölünür.

**Örnek:** 3/4 = 3÷4 = 0,75

## Kesirlerde Karşılaştırma
Paydaları eşitlemek veya ondalık forma çevirmek en pratik yöntemdir.

**Örnek:** 1/2, 3/5, 2/3 sayılarını sıralayalım.
Ondalık karşılıkları: 1/2=0,5 — 3/5=0,6 — 2/3≈0,667
Küçükten büyüğe: 1/2 < 3/5 < 2/3

## Kesirlerde Dört İşlem
- **Toplama/Çıkarma:** Paydalar eşitlenir, paylar toplanır/çıkarılır.
- **Çarpma:** Pay paya, payda paydaya çarpılır.
- **Bölme:** İkinci kesrin ters çevrilmiş hâli ile çarpılır (a/b ÷ c/d = a/b × d/c)

**Örnek:** (2/3 + 1/6) ÷ (5/9)
Önce parantez: 2/3+1/6 = 4/6+1/6 = 5/6
Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2

## Ondalık Sayıyı Kesre Çevirme
Ondalık sayı, virgülden sonraki basamak sayısı kadar sıfır içeren bir paydaya yazılır, sonra sadeleştirilir.

**Örnek:** 0,6 = 6/10 = 3/5 (sadeleştirilmiş hâli)

Rasyonel sayılarla işlem yaparken en sık yapılan hatalar, bölme işleminde ters çevirmeyi unutmak ve toplama/çıkarmada paydaları eşitlemeden işlem yapmaktır. Bu yüzden her adımın ayrı ayrı kontrol edilmesi önemlidir.', '5/8 kesrinin ondalık karşılığı kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('536bac40-ea60-40d6-8b90-a243f7484a1e', '1967a34a-00a7-4c4d-858c-3892d3444962', 'kolay'::difficulty_level, '3/4 kesrinin ondalık gösterimi nedir?', 'Kesri ondalık sayıya çevirir.', '3/4 kesrinde pay paydaya bölünür: 3 ÷ 4 = 0,75.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('536bac40-ea60-40d6-8b90-a243f7484a1e', '0.34', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('536bac40-ea60-40d6-8b90-a243f7484a1e', '0.75', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('536bac40-ea60-40d6-8b90-a243f7484a1e', '0.43', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('536bac40-ea60-40d6-8b90-a243f7484a1e', '1.33', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('56e63512-4185-47fd-8c52-a19aade7c569', '1967a34a-00a7-4c4d-858c-3892d3444962', 'kolay'::difficulty_level, '2/5 + 1/5 işleminin sonucu kaçtır?', 'Aynı paydalı kesirlerde toplama işlemi yapar.', 'Paydalar eşit olduğundan sadece paylar toplanır: (2+1)/5 = 3/5.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56e63512-4185-47fd-8c52-a19aade7c569', '3/25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56e63512-4185-47fd-8c52-a19aade7c569', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56e63512-4185-47fd-8c52-a19aade7c569', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56e63512-4185-47fd-8c52-a19aade7c569', '1/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('31b490a6-d201-4d80-9386-8e12037b4af9', '1967a34a-00a7-4c4d-858c-3892d3444962', 'orta'::difficulty_level, '1/2, 3/5, 2/3 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri karşılaştırıp sıralar.', 'Ondalık karşılıkları bulunur: 1/2=0,5; 3/5=0,6; 2/3≈0,667. Küçükten büyüğe sıralama: 1/2 < 3/5 < 2/3.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('31b490a6-d201-4d80-9386-8e12037b4af9', '1/2 < 3/5 < 2/3', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('31b490a6-d201-4d80-9386-8e12037b4af9', '3/5 < 1/2 < 2/3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('31b490a6-d201-4d80-9386-8e12037b4af9', '2/3 < 3/5 < 1/2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('31b490a6-d201-4d80-9386-8e12037b4af9', '1/2 < 2/3 < 3/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('93dbd15a-f31e-492f-ab95-73ac62640d03', '1967a34a-00a7-4c4d-858c-3892d3444962', 'orta'::difficulty_level, '0,6 ondalık sayısının kesir olarak en sade hali nedir?', 'Ondalık sayıyı sadeleştirilmiş kesre çevirir.', '0,6 = 6/10 yazılır. 6 ve 10''un ortak böleni 2 ile sadeleştirilirse 6/10 = 3/5 elde edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('93dbd15a-f31e-492f-ab95-73ac62640d03', '6/10', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('93dbd15a-f31e-492f-ab95-73ac62640d03', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('93dbd15a-f31e-492f-ab95-73ac62640d03', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('93dbd15a-f31e-492f-ab95-73ac62640d03', '2/3', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0957cb30-fba6-4b20-b520-cb18038822d7', '1967a34a-00a7-4c4d-858c-3892d3444962', 'zor'::difficulty_level, '(2/3 + 1/6) ÷ (5/9) işleminin sonucu kaçtır?', 'Kesirlerle karışık işlem (toplama ve bölme) yapar.', 'Önce parantez: 2/3+1/6, ortak payda 6 ile 4/6+1/6=5/6. Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0957cb30-fba6-4b20-b520-cb18038822d7', '25/54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0957cb30-fba6-4b20-b520-cb18038822d7', '3/2', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0957cb30-fba6-4b20-b520-cb18038822d7', '3/5', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0957cb30-fba6-4b20-b520-cb18038822d7', '2/3', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('17f97465-ab68-42f7-abac-bce58e6b7d2d', 'Yüzde, kâr-zarar, yaş, işçi-havuz ve hareket problemlerinin çözüm yöntemlerini kapsayan konudur.', '## Yüzde Problemleri
A sayısının %k''i = A × k/100

**Örnek:** 250''nin %20''si: 250×20/100=50

## Kâr-Zarar Problemleri
- Kâr = Satış fiyatı − Alış fiyatı
- Kâr yüzdesi = (Kâr / Alış fiyatı) × 100

**Örnek:** 80 TL''ye alınan mal 100 TL''ye satılırsa:
Kâr = 100−80=20 TL
Kâr yüzdesi = 20/80×100=%25

## Yaş Problemleri
Genellikle bilinmeyen yaşlar x ile ifade edilip denklem kurulur. Kadar fazla/eksik, toplamı, katı gibi ifadeler denkleme dönüştürülür.

**Örnek:** Babanın yaşı, oğlunun yaşının 3 katından 5 fazla, toplamları 53.
x + (3x+5) = 53 → 4x=48 → x=12 (oğul), baba=41

## İşçi-Havuz Problemleri
Bir işi tek başına t saatte biten biri, birim zamanda işin 1/t''sini yapar. Birlikte çalışıldığında birim zamandaki iş oranları toplanır.

**Örnek:** A musluğu 6 saatte, B musluğu 12 saatte dolduruyor.
Birlikte hız: 1/6+1/12=2/12+1/12=3/12=1/4
Süre = 1 ÷ (1/4) = 4 saat

## Hareket Problemleri
- Aynı yönde hareket: hız farkı kullanılır.
- Zıt yönde (karşılıklı) hareket: hızlar toplanır.
Yol = Hız × Zaman

**Örnek:** 360 km arayla, biri 90 km/sa diğeri 60 km/sa hızla karşılıklı hareket ederse:
Toplam hız = 90+60=150 km/sa
Karşılaşma süresi = 360/150=2,4 saat

Bu problem tiplerinde birim (saat, km, TL) tutarlılığına ve toplam/fark ayrımına dikkat edilmelidir.', 'Bir üründe %15 indirim uygulanıyor. Ürünün etiket fiyatı 200 TL ise indirimli fiyat kaç TL olur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('60eb510d-bd85-47ae-a48e-24cfebeea3d7', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'kolay'::difficulty_level, '250''nin %20''si kaçtır?', 'Bir sayının yüzdesini hesaplar.', '250''nin %20''si: 250 × 20/100 = 50.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60eb510d-bd85-47ae-a48e-24cfebeea3d7', '25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60eb510d-bd85-47ae-a48e-24cfebeea3d7', '50', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60eb510d-bd85-47ae-a48e-24cfebeea3d7', '20', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60eb510d-bd85-47ae-a48e-24cfebeea3d7', '45', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1fc7ada4-3fd8-4836-9c65-fb69fb28d272', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'kolay'::difficulty_level, 'Bir tüccar 80 TL''ye aldığı malı 100 TL''ye satıyor. Kâr yüzdesi kaçtır?', 'Kâr yüzdesini hesaplar.', 'Kâr = 100−80=20 TL. Kâr yüzdesi, kârın alış fiyatına oranıdır: 20/80×100=%25.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fc7ada4-3fd8-4836-9c65-fb69fb28d272', '20%', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fc7ada4-3fd8-4836-9c65-fb69fb28d272', '25%', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fc7ada4-3fd8-4836-9c65-fb69fb28d272', '125%', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fc7ada4-3fd8-4836-9c65-fb69fb28d272', '80%', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3d4a1612-4261-4f6a-90a9-ebeccf6a09b1', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'orta'::difficulty_level, 'Bir babanın yaşı, oğlunun yaşının 3 katından 5 fazladır. Baba ile oğlunun yaşları toplamı 53 olduğuna göre oğlunun yaşı kaçtır?', 'Yaş problemini denklem kurarak çözer.', 'Oğlun yaşı x olsun. Baba = 3x+5. Toplam: x + (3x+5) = 53 → 4x + 5 = 53 → 4x = 48 → x = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3d4a1612-4261-4f6a-90a9-ebeccf6a09b1', '41', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3d4a1612-4261-4f6a-90a9-ebeccf6a09b1', '12', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3d4a1612-4261-4f6a-90a9-ebeccf6a09b1', '16', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3d4a1612-4261-4f6a-90a9-ebeccf6a09b1', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e78c7df0-aee2-4eaa-9be7-dc190c3dbeab', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'orta'::difficulty_level, 'Bir havuzu tek başına A musluğu 6 saatte, B musluğu 12 saatte dolduruyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerinde birlikte çalışma süresini hesaplar.', 'Birim zamandaki doldurma oranları toplanır: 1/6+1/12 = 2/12+1/12 = 3/12 = 1/4. Süre = 1 ÷ (1/4) = 4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e78c7df0-aee2-4eaa-9be7-dc190c3dbeab', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e78c7df0-aee2-4eaa-9be7-dc190c3dbeab', '4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e78c7df0-aee2-4eaa-9be7-dc190c3dbeab', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e78c7df0-aee2-4eaa-9be7-dc190c3dbeab', '18', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8c33de8c-2526-4e64-8671-287bf9a8e696', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'zor'::difficulty_level, 'İki şehir arası uzaklık 360 km''dir. Bir araç A şehrinden B şehrine 90 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 60 km/sa hızla hareket ediyor. Bu iki araç kaç saat sonra karşılaşır?', 'Karşılıklı hareket problemlerinde karşılaşma süresini hesaplar.', 'Zıt yönlü hareket ettikleri için hızlar toplanır: 90+60=150 km/sa. Karşılaşma süresi = Toplam yol ÷ Toplam hız = 360/150 = 2,4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c33de8c-2526-4e64-8671-287bf9a8e696', '12', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c33de8c-2526-4e64-8671-287bf9a8e696', '2.4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c33de8c-2526-4e64-8671-287bf9a8e696', '4', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c33de8c-2526-4e64-8671-287bf9a8e696', '2.5', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('36e2daaa-064f-4b75-b465-d649577b4a15', 'Hukuk kuralının tanımı, yaptırım türleri, hukukun kaynakları ile hak ve görev kavramlarının temel ilkelerini kapsar.', '## Hukuk Kuralı Nedir?
Hukuk kuralı, toplum halinde yaşayan bireylerin ilişkilerini düzenleyen, genel, soyut ve sürekli nitelikte olan; uyulmaması durumunda devlet gücü tarafından desteklenen bir yaptırıma bağlanan davranış kurallarıdır. Hukuk kuralını ahlak, din ve görgü gibi diğer toplumsal düzen kurallarından ayıran en belirgin özellik, devlet organları eliyle uygulanan **maddi yaptırıma** sahip olmasıdır.

## Yaptırım Türleri
Hukuk kurallarına aykırı davranışlar çeşitli yaptırımlarla karşılanır:
- **Ceza:** Suç niteliğindeki fiillere uygulanan hapis veya adli para cezası gibi yaptırımlardır.
- **Cebri icra (cebren yerine getirme):** Borcunu yerine getirmeyen kişinin edimini devlet gücüyle zorla yerine getirtmesidir.
- **Tazminat:** Bir kişinin hukuka aykırı fiiliyle başkasına verdiği zararı giderme yükümlülüğüdür.
- **İptal / Butlan (hükümsüzlük):** Kanunda aranan şekil veya esas şartlarına uyulmadan yapılan işlemlerin hukuken geçersiz sayılmasıdır.

## Hukukun Kaynakları
Hukukun kaynakları asli ve yardımcı kaynaklar olarak ikiye ayrılır:
- **Asli kaynaklar (yazılı):** Anayasa, kanun, cumhurbaşkanlığı kararnamesi, yönetmelik gibi yetkili organlarca yazılı şekilde konulan kurallardır.
- **Asli kaynaklar (yazısız):** Örf ve adet hukuku, toplumda uzun süredir uygulanan ve bağlayıcı olduğuna inanılan kurallardır.
- **Yardımcı kaynaklar:** Doktrin (bilimsel görüşler) ve yargısal içtihatlar, hukuk kurallarının yorumlanmasında hâkime ve hukukçulara yol gösterir; doğrudan bağlayıcı asli kaynak değildir.

## Hak ve Görev
**Hak**, hukuk düzeni tarafından bir kişiye tanınan ve korunan menfaat veya yetkidir. **Görev (borç/yükümlülük)** ise bir kişinin başka bir kişi veya devlete karşı yerine getirmek zorunda olduğu davranıştır. Hak ve görev kavramları birbirini tamamlar niteliktedir: bir kişinin hakkı, çoğunlukla başka bir kişi için buna karşılık gelen bir görev doğurur. Örneğin alacaklının alacak hakkı, borçlu için borcu ödeme görevini doğurur.', 'Hukuk kurallarını ahlak kurallarından ayıran temel özellik aşağıdakilerden hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3daa8fca-d357-4a1e-859d-9e32759fa3b8', '36e2daaa-064f-4b75-b465-d649577b4a15', 'kolay'::difficulty_level, 'Hukuk kurallarını diğer toplumsal düzen kurallarından (ahlak, din, görgü) ayıran en temel özellik nedir?', 'Hukuk kuralını diğer toplumsal düzen kurallarından ayıran temel özelliği kavrar.', 'Hukuk kuralı, ahlak ve görgü kuralları gibi diğer toplumsal düzen kurallarından farklı olarak devlet gücüyle desteklenen bir yaptırıma sahiptir; bu nedenle uyulmaması halinde devlet organları tarafından zorla uygulanabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3daa8fca-d357-4a1e-859d-9e32759fa3b8', 'Yazılı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3daa8fca-d357-4a1e-859d-9e32759fa3b8', 'Herkes tarafından bilinmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3daa8fca-d357-4a1e-859d-9e32759fa3b8', 'Devlet gücüyle desteklenen yaptırıma sahip olması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3daa8fca-d357-4a1e-859d-9e32759fa3b8', 'Değişmez olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fd836c0f-3210-45c8-acec-6b97bea3f101', '36e2daaa-064f-4b75-b465-d649577b4a15', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi hukuk kurallarının yaptırım türlerinden biri değildir?', 'Hukuk kurallarının yaptırım türlerini ayırt eder.', 'Vicdan azabı, ahlak kurallarının manevi yaptırımıdır; ceza, cebri icra ve tazminat ise hukuk kurallarının yaptırım türleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fd836c0f-3210-45c8-acec-6b97bea3f101', 'Ceza', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fd836c0f-3210-45c8-acec-6b97bea3f101', 'Vicdan azabı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fd836c0f-3210-45c8-acec-6b97bea3f101', 'Cebri icra', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fd836c0f-3210-45c8-acec-6b97bea3f101', 'Tazminat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c252bdf5-d71e-412a-a320-8e6013b3af01', '36e2daaa-064f-4b75-b465-d649577b4a15', 'orta'::difficulty_level, 'Bir sözleşmenin kanunda öngörülen şekil şartına uyulmadan yapılması durumunda ortaya çıkan yaptırım türü aşağıdakilerden hangisidir?', 'Şekil şartına aykırılığın hukuki sonucunu açıklar.', 'Kanunda öngörülen şekil şartına uyulmadan yapılan hukuki işlemler hukuken geçersiz sayılır; bu yaptırım türüne butlan (kesin hükümsüzlük) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c252bdf5-d71e-412a-a320-8e6013b3af01', 'Cebri icra', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c252bdf5-d71e-412a-a320-8e6013b3af01', 'Tazminat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c252bdf5-d71e-412a-a320-8e6013b3af01', 'İptal edilebilirlik/Butlan (hükümsüzlük)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c252bdf5-d71e-412a-a320-8e6013b3af01', 'Hapis cezası', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d88693a8-4263-4945-be39-ea6f2593e015', '36e2daaa-064f-4b75-b465-d649577b4a15', 'orta'::difficulty_level, 'Hukukun yazılı asli kaynakları arasında aşağıdakilerden hangisi yer almaz?', 'Hukukun yazılı ve yazısız asli kaynaklarını ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan asli bir kaynaktır; Anayasa, kanun ve yönetmelik ise yazılı asli kaynaklar arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d88693a8-4263-4945-be39-ea6f2593e015', 'Anayasa', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d88693a8-4263-4945-be39-ea6f2593e015', 'Örf ve adet hukuku', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d88693a8-4263-4945-be39-ea6f2593e015', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d88693a8-4263-4945-be39-ea6f2593e015', 'Yönetmelik', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1fb4ab28-f1ee-4c00-9448-2e97b936077a', '36e2daaa-064f-4b75-b465-d649577b4a15', 'zor'::difficulty_level, '"Hak" ve "görev" kavramları arasındaki ilişki açısından aşağıdaki ifadelerden hangisi doğrudur?', 'Hak ve görev kavramları arasındaki karşılıklı ilişkiyi kavrar.', 'Hukuk düzeninde bir kişiye tanınan hak, genellikle karşı tarafta buna tekabül eden bir görev veya yükümlülük doğurur; örneğin alacak hakkı borçlu için ödeme görevi yaratır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb4ab28-f1ee-4c00-9448-2e97b936077a', 'Hak, kişiye tanınan hukuki korumadan bağımsız bir yetkidir; görev ile ilişkisi yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb4ab28-f1ee-4c00-9448-2e97b936077a', 'Görev, yalnızca kamu hukuku ilişkilerinde ortaya çıkan bir kavramdır', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb4ab28-f1ee-4c00-9448-2e97b936077a', 'Bir kişinin sahip olduğu hak, genellikle başka bir kişi için buna karşılık gelen bir görev/yükümlülük doğurur', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb4ab28-f1ee-4c00-9448-2e97b936077a', 'Hak ve görev kavramları sadece anayasa hukukunda kullanılır', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f887b0f6-c0ab-468e-b053-8c335bd02151', '1982 Anayasası''nın kabul süreci, temel ilkeleri, Başlangıç hükümlerinin bağlayıcılığı ve değiştirilemez maddelerini ele alır.', '## 1982 Anayasası''nın Genel Çerçevesi
1982 Anayasası, halkoylaması sonucunda kabul edilerek yürürlüğe girmiş ve Türkiye Cumhuriyeti''nin temel hukuki metnidir. Anayasa, devletin yapısını, temel hak ve özgürlükleri, devlet organlarının kuruluş ve işleyişini düzenler.

## Başlangıç Hükümlerinin Niteliği
Anayasa''nın **Başlangıç** kısmı, sadece siyasi bir bildiri niteliğinde değildir; Anayasa metninin **ayrılmaz bir parçasını** oluşturur ve Anayasa''nın diğer maddeleriyle birlikte hukuken bağlayıcıdır. Başlangıç''ta Atatürk milliyetçiliği, milli egemenlik, cumhuriyetin nitelikleri gibi temel değerlere vurgu yapılır ve bu değerler Anayasa''nın yorumlanmasında da esas alınır.

## Anayasa''nın Temel İlkeleri
1982 Anayasası''na göre Türkiye Devleti''nin nitelikleri şunlardır:
- **Cumhuriyetçilik:** Devletin yönetim şekli cumhuriyettir.
- **Milli (ulusal) egemenlik:** Egemenlik kayıtsız şartsız millete aittir.
- **Demokratik devlet:** Yönetimde çoğulcu demokrasi esastır.
- **Laik devlet:** Din ve devlet işleri birbirinden ayrıdır.
- **Sosyal devlet:** Devlet, sosyal adalet ve refahı sağlamakla yükümlüdür.
- **Hukuk devleti:** Devlet, kendi eylem ve işlemlerinde hukuk kurallarıyla bağlıdır.
- **İnsan haklarına saygılı devlet:** Temel hak ve özgürlükler anayasal güvence altındadır.
- **Atatürk milliyetçiliğine bağlılık.**

## Değiştirilemez Hükümler
Anayasa''da bazı hükümler diğerlerinden farklı bir güvenceye sahiptir: Devletin şeklinin Cumhuriyet olduğunu belirten hüküm, Cumhuriyetin temel niteliklerini sayan hüküm ve devletin bütünlüğü, resmî dili, bayrağı, millî marşı ile başkentine ilişkin hükümler **değiştirilemez** ve bunların değiştirilmesi **teklif dahi edilemez**. Bu düzenleme, devletin temel kimliğini siyasi çoğunluk değişikliklerine karşı güvence altına almayı amaçlar.', '1982 Anayasası''nın Başlangıç kısmının hukuki niteliği ile ilgili aşağıdaki ifadelerden hangisi doğrudur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('64a53e3e-a2d9-4d14-bb8b-90aaa7e54cc2', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'kolay'::difficulty_level, '1982 Anayasası''na göre Türkiye Devleti''nin şekli nedir?', 'Türkiye Devleti''nin temel yönetim şeklini bilir.', '1982 Anayasası''nın ilgili hükmüne göre Türkiye Devleti''nin şekli Cumhuriyettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('64a53e3e-a2d9-4d14-bb8b-90aaa7e54cc2', 'Monarşi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('64a53e3e-a2d9-4d14-bb8b-90aaa7e54cc2', 'Federasyon', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('64a53e3e-a2d9-4d14-bb8b-90aaa7e54cc2', 'Cumhuriyet', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('64a53e3e-a2d9-4d14-bb8b-90aaa7e54cc2', 'Konfederasyon', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a06720de-8c71-4000-b99a-cc70627bedde', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi 1982 Anayasası''nda Cumhuriyetin nitelikleri arasında sayılan temel ilkelerden biri değildir?', 'Cumhuriyetin Anayasa''da sayılan temel niteliklerini ayırt eder.', 'Tek parti yönetimi, çoğulcu demokrasi ilkesiyle bağdaşmadığından Anayasa''da sayılan Cumhuriyetin nitelikleri arasında yer almaz; laiklik, sosyal devlet ve hukuk devleti ise temel niteliklerdendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a06720de-8c71-4000-b99a-cc70627bedde', 'Laiklik', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a06720de-8c71-4000-b99a-cc70627bedde', 'Tek parti yönetimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a06720de-8c71-4000-b99a-cc70627bedde', 'Sosyal devlet', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a06720de-8c71-4000-b99a-cc70627bedde', 'Hukuk devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e8572442-4ea2-43f1-9cb5-2cff6ce84c17', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'orta'::difficulty_level, '1982 Anayasası''nın Başlangıç kısmı hakkında aşağıdakilerden hangisi doğrudur?', 'Başlangıç hükümlerinin hukuki bağlayıcılığını açıklar.', 'Anayasa''nın Başlangıç kısmı, Anayasa metninin ayrılmaz bir parçası olup diğer hükümlerle birlikte hukuken bağlayıcıdır; salt sembolik bir metin değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8572442-4ea2-43f1-9cb5-2cff6ce84c17', 'Başlangıç kısmı yalnızca sembolik bir metindir, hukuki bağlayıcılığı yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8572442-4ea2-43f1-9cb5-2cff6ce84c17', 'Başlangıç kısmı sadece Anayasa Mahkemesi kararlarında referans olarak kullanılabilir', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8572442-4ea2-43f1-9cb5-2cff6ce84c17', 'Başlangıç kısmı kanunlarla değiştirilebilir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8572442-4ea2-43f1-9cb5-2cff6ce84c17', 'Başlangıç kısmı, Anayasa''nın ayrılmaz bir parçasını oluşturur ve Anayasa metnine dahildir', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('05565b04-8ba8-44d4-8b0b-5b7136b29108', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'orta'::difficulty_level, 'Anayasa''da yer alan "değiştirilemez ve değiştirilmesi teklif dahi edilemez" hükümler esas olarak neyi korumayı amaçlar?', 'Değiştirilemez Anayasa hükümlerinin amacını kavrar.', 'Değiştirilemez hükümler, devletin şekli, temel nitelikleri ve devletin bütünlüğü gibi temel unsurları siyasi çoğunluk değişikliklerine karşı korumayı amaçlar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05565b04-8ba8-44d4-8b0b-5b7136b29108', 'Bakanlar Kurulunun yetkilerini', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05565b04-8ba8-44d4-8b0b-5b7136b29108', 'Yerel yönetimlerin özerkliğini', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05565b04-8ba8-44d4-8b0b-5b7136b29108', 'Devletin temel niteliklerini (Cumhuriyet, devletin şekli, temel unsurları)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05565b04-8ba8-44d4-8b0b-5b7136b29108', 'Siyasi partilerin kapatılma usulünü', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3dcce82c-bbe5-4119-80c9-fa1111f3ebba', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'zor'::difficulty_level, '1982 Anayasası''nın "değiştirilemeyecek hükümler" ile ilgili düzenlemesi hakkında aşağıdakilerden hangisi doğrudur?', 'Değiştirilemez hükümlere ilişkin özel güvenceyi açıklar.', 'Anayasa''da bu hükümlerin yalnızca değiştirilmesi değil, değiştirilmesinin teklif edilmesi bile açıkça yasaklanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3dcce82c-bbe5-4119-80c9-fa1111f3ebba', 'Bu hükümlerin değiştirilmesi TBMM üye tam sayısının 2/3 çoğunluğuyla mümkündür', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3dcce82c-bbe5-4119-80c9-fa1111f3ebba', 'Bu hükümler halkoylaması ile değiştirilebilir ancak TBMM tarafından değiştirilemez', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3dcce82c-bbe5-4119-80c9-fa1111f3ebba', 'Bu hükümlerin sadece değiştirilmesi değil, değiştirilmesinin teklif edilmesi dahi yasaktır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3dcce82c-bbe5-4119-80c9-fa1111f3ebba', 'Bu hükümler yalnızca Anayasa Mahkemesi kararıyla değiştirilebilir', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'TBMM, Cumhurbaşkanlığı ve yargı organlarının genel yapısını, temel görevlerini ve kuvvetler ayrılığı ilkesini özetler.', '## Yasama Organı: TBMM
Türkiye Büyük Millet Meclisi (TBMM), yasama yetkisini kullanan tek organdır. Milletvekilleri genel oyla ve belirli aralıklarla yapılan seçimlerle halk tarafından seçilir. TBMM''nin başlıca görevleri şunlardır:
- Kanun yapmak, değiştirmek ve yürürlükten kaldırmak
- Bütçe ve kesin hesap kanun tekliflerini görüşüp kabul etmek
- Yürütme organını denetlemek (soru, meclis araştırması, genel görüşme gibi araçlarla)
- Milletlerarası antlaşmaların onaylanmasını uygun bulmak

## Yürütme Organı: Cumhurbaşkanlığı
Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetki ve görevi **Cumhurbaşkanı** tarafından kullanılır. Cumhurbaşkanı halk tarafından doğrudan seçilir; devletin başıdır ve aynı zamanda yürütmenin başıdır. Cumhurbaşkanı yardımcıları ve bakanlar, Cumhurbaşkanı tarafından atanır ve yürütme faaliyetlerinin yürütülmesinde ona yardımcı olur. Yürütmenin başlıca görevleri arasında kanunları uygulamak, cumhurbaşkanlığı kararnamesi çıkarmak, dış politikayı yürütmek ve ülkeyi idare etmek yer alır.

## Yargı Organı: Mahkemeler
Yargı yetkisi, Türk Milleti adına **bağımsız ve tarafsız mahkemeler** tarafından kullanılır. Hâkimler, görevlerinde bağımsızdır ve hâkimlik teminatına sahiptir; bu sayede yürütme ve yasamanın etkisinden korunurlar. Türkiye''de görev alanına göre çeşitli yüksek yargı organları bulunur:
- **Anayasa Mahkemesi:** Kanunların Anayasa''ya uygunluğunu denetler.
- **Yargıtay:** Adli yargının en üst denetim merciidir.
- **Danıştay:** İdari yargının en üst denetim merciidir.
- **Sayıştay:** Kamu kaynaklarının kullanımını denetler.

## Kuvvetler Ayrılığı İlkesi
Yasama, yürütme ve yargı yetkilerinin farklı organlarca kullanılması, gücün tek elde toplanmasını önlemeyi ve organlar arasında karşılıklı denetim sağlamayı amaçlayan **kuvvetler ayrılığı ilkesi**nin bir gereğidir. Bu ilke, hukuk devletinin ve demokratik yönetimin temel güvencelerinden biridir.', 'Türkiye''de yürütme yetkisinin kullanılmasına ilişkin aşağıdaki ifadelerden hangisi Cumhurbaşkanlığı Hükümet Sistemi''ne uygundur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3e8b5f58-7d8a-4ce6-ac9e-29f87fe93cd3', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'kolay'::difficulty_level, 'Türkiye''de yasama yetkisi hangi organa aittir?', 'Yasama organını ve yetkisinin kime ait olduğunu bilir.', 'Yasama yetkisi Türk Milleti adına Türkiye Büyük Millet Meclisi tarafından kullanılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e8b5f58-7d8a-4ce6-ac9e-29f87fe93cd3', 'Cumhurbaşkanlığı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e8b5f58-7d8a-4ce6-ac9e-29f87fe93cd3', 'Yargıtay', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e8b5f58-7d8a-4ce6-ac9e-29f87fe93cd3', 'Türkiye Büyük Millet Meclisi', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e8b5f58-7d8a-4ce6-ac9e-29f87fe93cd3', 'Bakanlar Kurulu', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9fb23b60-d4e0-4aa0-a53a-7bebca8eaeb0', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi yargı organının temel işlevidir?', 'Yargı organının temel işlevini açıklar.', 'Yargı organının temel işlevi, taraflar arasındaki hukuki uyuşmazlıkları bağımsız ve tarafsız mahkemeler eliyle çözüme kavuşturmaktır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9fb23b60-d4e0-4aa0-a53a-7bebca8eaeb0', 'Kanun yapmak', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9fb23b60-d4e0-4aa0-a53a-7bebca8eaeb0', 'Bütçeyi hazırlamak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9fb23b60-d4e0-4aa0-a53a-7bebca8eaeb0', 'Uyuşmazlıkları bağımsız ve tarafsız biçimde çözüme kavuşturmak', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9fb23b60-d4e0-4aa0-a53a-7bebca8eaeb0', 'Milletlerarası antlaşma imzalamak', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a005b9e8-6d7d-4194-b5f3-c6f002410d93', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'orta'::difficulty_level, 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisi kime aittir?', 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisinin kullanımını bilir.', 'Cumhurbaşkanlığı Hükümet Sistemi''nde başbakanlık makamı kaldırılmış olup yürütme yetkisi Cumhurbaşkanı tarafından kullanılmaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a005b9e8-6d7d-4194-b5f3-c6f002410d93', 'TBMM Başkanına', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a005b9e8-6d7d-4194-b5f3-c6f002410d93', 'Başbakana', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a005b9e8-6d7d-4194-b5f3-c6f002410d93', 'Anayasa Mahkemesi Başkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a005b9e8-6d7d-4194-b5f3-c6f002410d93', 'Cumhurbaşkanına', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('04ba9de5-69b2-4032-a5d3-c603fd9b379a', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''deki yüksek yargı organlarından biridir?', 'Türkiye''deki yüksek yargı organlarını tanır.', 'Danıştay, idari yargının en üst denetim mercii olan yüksek bir yargı organıdır; diğer seçenekler yargı organı değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04ba9de5-69b2-4032-a5d3-c603fd9b379a', 'TBMM Başkanlık Divanı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04ba9de5-69b2-4032-a5d3-c603fd9b379a', 'Milli Güvenlik Kurulu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04ba9de5-69b2-4032-a5d3-c603fd9b379a', 'Danıştay', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04ba9de5-69b2-4032-a5d3-c603fd9b379a', 'Cumhurbaşkanlığı Kabinesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e98e519c-1ba2-41ba-a48b-652decede773', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'zor'::difficulty_level, 'Kuvvetler ayrılığı ilkesi bağlamında yasama, yürütme ve yargı organlarının birbirleriyle ilişkisi hakkında aşağıdakilerden hangisi doğrudur?', 'Kuvvetler ayrılığı ilkesinin amacını ve işleyişini kavrar.', 'Kuvvetler ayrılığı ilkesi, gücün tek bir organda toplanmasını önlemek amacıyla yasama, yürütme ve yargı arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür; organlar arasında tam bir kopukluk anlamına gelmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e98e519c-1ba2-41ba-a48b-652decede773', 'Kuvvetler ayrılığı, organların birbirinden tamamen kopuk ve hiçbir denetim ilişkisi bulunmadığı anlamına gelir', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e98e519c-1ba2-41ba-a48b-652decede773', 'Kuvvetler ayrılığı ilkesi yalnızca yasama ve yürütme arasındaki ilişkiyi düzenler, yargıyı kapsamaz', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e98e519c-1ba2-41ba-a48b-652decede773', 'Kuvvetler ayrılığı, güç yoğunlaşmasını önlemek amacıyla organlar arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e98e519c-1ba2-41ba-a48b-652decede773', 'Kuvvetler ayrılığı ilkesine göre yargı organı yasama organına bağlı çalışır', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'Türkiye''nin matematik (mutlak) konumu enlem-boylam değerleriyle, özel (coğrafi) konumu ise komşuları, denizlerle ilişkisi ve kıtalar arasındaki yeriyle tanımlanır; bu iki konum türü ülkenin iklim, ulaşım ve jeopolitik özelliklerini şekillendirir.', '## Matematik (Mutlak) Konum
- Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer alır.
- Yaklaşık 36°-42° kuzey enlemleri ile 26°-45° doğu boylamları arasında bulunur.
- Orta Kuşak''ta (kuzey ılıman kuşak) yer aldığından yıl içinde dört mevsim belirgin biçimde yaşanır.
- Boylamlar arasındaki yaklaşık 19 derecelik açı farkı, doğu ile batı arasında yerel saatte belirgin bir farka (yaklaşık 76 dakika) yol açar; bu nedenle güneş doğuda batıya göre daha erken doğar.
- Uç noktalar: en kuzeyde Sinop (İnceburun), en güneyde Hatay, en doğuda Iğdır, en batıda Gökçeada (Çanakkale).

## Özel (Coğrafi) Konum
- Üç tarafı denizlerle (Karadeniz, Ege Denizi, Akdeniz) çevrilidir.
- İstanbul ve Çanakkale Boğazları aracılığıyla Asya ile Avrupa kıtaları arasında bir geçiş/köprü konumundadır.
- Enerji kaynakları bakımından zengin Orta Doğu ve Hazar-Orta Asya bölgeleri ile Avrupa arasında transit güzergâh üzerindedir.
- Farklı basınç sistemlerinin ve hava kütlelerinin etkisi altında kalması, iklim ve bitki örtüsü çeşitliliğine zemin hazırlar.
- Levha sınırlarına yakın konumu nedeniyle diri fay hatları üzerinde yer alır ve deprem riski taşır.

## Matematik Konumun Sonuçları
- Mevsimlerin belirgin biçimde yaşanması ve gün uzunluğunun mevsimlere göre değişmesi.
- Güneş ışınlarının geliş açısının enlemlere ve mevsimlere göre farklılaşması.
- Doğu-batı yönünde yerel saat farkının bulunması.

## Özel Konumun Sonuçları
- Ticaret ve ulaşım açısından önemli bir kavşak noktası olması.
- Kültürel çeşitlilik, tarihi zenginlik ve yüksek turizm potansiyeli.
- Jeopolitik ve stratejik önemin fazla olması.
- İklim ve doğal bitki örtüsü çeşitliliğine bağlı tarımsal ürün çeşitliliği.', 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi gösterilebilir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f90aca23-433d-4116-8f27-7d66e18cf3db', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'kolay'::difficulty_level, 'Türkiye''nin üç tarafının denizlerle çevrili olması, aşağıdaki konum türlerinden hangisine örnektir?', 'Matematik konum ile özel konum kavramlarını ayırt edebilme.', 'Denizlerle çevrili olma, komşu ülkeler ve ulaşım yolları gibi özellikler özel (coğrafi) konumun kapsamına girer; enlem-boylam gibi ölçülebilir değerler ise matematik konuma aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f90aca23-433d-4116-8f27-7d66e18cf3db', 'Matematik konum', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f90aca23-433d-4116-8f27-7d66e18cf3db', 'Özel konum', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f90aca23-433d-4116-8f27-7d66e18cf3db', 'Astronomik konum', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f90aca23-433d-4116-8f27-7d66e18cf3db', 'Mutlak konum', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('be5dd177-a024-4730-8c31-68354b103dc0', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin matematik konumunun bir sonucu değildir?', 'Matematik konumun sonuçlarını özel konumun sonuçlarından ayırt edebilme.', 'Kıtalar arası transit ticaret, Türkiye''nin özel (coğrafi) konumunun bir sonucudur; enlem-boylama bağlı sonuçlar arasında yer almaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be5dd177-a024-4730-8c31-68354b103dc0', 'Dört mevsimin belirgin biçimde yaşanması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be5dd177-a024-4730-8c31-68354b103dc0', 'Doğu ile batı arasında yerel saat farkının olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be5dd177-a024-4730-8c31-68354b103dc0', 'Farklı kıtalar arasında transit ticaret yapılması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be5dd177-a024-4730-8c31-68354b103dc0', 'Güneş ışınlarının geliş açısının mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9d036646-0114-4289-9375-f3fca6d889b3', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'orta'::difficulty_level, 'Türkiye, boylamlar üzerinde doğuda Iğdır''dan batıda Gökçeada''ya kadar yaklaşık 19 derecelik bir açı genişliğine sahiptir. Bu durumun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Boylam farkının yerel saat ve gün doğumu-batımı üzerindeki etkisini kavrayabilme.', 'Boylam farkı arttıkça yerel saat farkı da artar; Dünya batıdan doğuya döndüğü için doğudaki yerler güneşi daha erken karşılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d036646-0114-4289-9375-f3fca6d889b3', 'Ülkenin tamamında bitki örtüsü aynıdır', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d036646-0114-4289-9375-f3fca6d889b3', 'Doğudaki iller, batıdaki illere göre güneşi daha erken karşılar', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d036646-0114-4289-9375-f3fca6d889b3', 'Ülkenin dört tarafı denizlerle çevrilidir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d036646-0114-4289-9375-f3fca6d889b3', 'Yıl boyunca gece-gündüz süreleri hep eşittir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fcc7a205-4f19-4e58-b968-18f20ea89cdf', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası aşağıdaki illerden hangisinde yer alır?', 'Türkiye''nin uç noktalarını bilme.', 'Türkiye''nin en doğu noktası Iğdır ilinde yer alır; Sinop en kuzey, Hatay en güney, Çanakkale (Gökçeada) ise en batı noktasını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fcc7a205-4f19-4e58-b968-18f20ea89cdf', 'Hatay', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fcc7a205-4f19-4e58-b968-18f20ea89cdf', 'Sinop', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fcc7a205-4f19-4e58-b968-18f20ea89cdf', 'Iğdır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fcc7a205-4f19-4e58-b968-18f20ea89cdf', 'Çanakkale', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6f586373-c7fc-4fd3-9900-e653220b9e33', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'zor'::difficulty_level, 'Türkiye''de saatler ülke genelinde tek bir resmi saat dilimine göre ayarlanmasına rağmen, Karadeniz kıyısında güneş henüz doğarken Doğu Anadolu''nun doğu kesiminde güneş çoktan doğmuş ve gökyüzünde belirgin biçimde yükselmiş olabilir. Bu durumun temel nedeni aşağıdakilerden hangisidir?', 'Boylam genişliğinin yerel güneş konumu üzerindeki etkisini analiz edebilme.', 'Bu fark, Türkiye''nin doğu-batı doğrultusunda geniş bir boylam aralığına yayılmış olmasından (matematik konum) kaynaklanır; deniz kıyısı, kıta geçişi gibi özel konum unsurları bu durumun nedeni değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6f586373-c7fc-4fd3-9900-e653220b9e33', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6f586373-c7fc-4fd3-9900-e653220b9e33', 'Türkiye''nin farklı boylamlar üzerinde geniş bir alana yayılmış olması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6f586373-c7fc-4fd3-9900-e653220b9e33', 'Türkiye''nin Asya ile Avrupa arasında bir geçiş bölgesinde bulunması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6f586373-c7fc-4fd3-9900-e653220b9e33', 'Türkiye''nin dağlık ve engebeli bir yapıya sahip olması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'Türkiye''de yer şekilleri, denize yakınlık ve enlem gibi faktörlerin etkisiyle Akdeniz, Karadeniz, Marmara (geçiş) ve karasal iklim olmak üzere birbirinden belirgin biçimde farklı iklim tipleri görülür.', '## Türkiye''de Görülen İklim Tipleri

### Akdeniz İklimi
- Akdeniz ve Ege kıyı şeridinde görülür.
- Yazlar sıcak ve kurak, kışlar ılık ve yağışlı geçer.
- Yağışlar çoğunlukla kış aylarında düşer.

### Karadeniz İklimi
- Karadeniz kıyı şeridi boyunca görülür.
- Her mevsim yağışlıdır; yazlar serin, kıyı kesiminde kışlar diğer iç bölgelere göre daha ılımandır.
- Yıllık yağış miktarı ve yağış düzenliliği bakımından Türkiye''nin en yağışlı iklim tipidir.

### Marmara (Geçiş) İklimi
- Marmara Bölgesi''nin büyük bölümünde görülür.
- Karadeniz iklimi ile Akdeniz iklimi arasında geçiş özellikleri taşır; her mevsim yağış görülmekle birlikte yazın yağış azalır.

### Karasal İklim
- İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun büyük bölümünde ve iç kesimlerde görülür.
- Yazlar sıcak ve kurak, kışlar soğuk ve kar yağışlı geçer.
- Yıllık ve günlük sıcaklık farkı fazladır, yıllık yağış miktarı azdır.
- Doğu Anadolu''da yükseltinin fazla olması nedeniyle kışlar daha sert ve uzun geçer.

## İklim Dağılışını Etkileyen Faktörler
- **Enlem:** Güneye gidildikçe sıcaklık genel olarak artar.
- **Yükselti:** Yükseldikçe sıcaklık düşer; bu nedenle iç ve yüksek kesimlerde kışlar daha soğuk geçer.
- **Denize yakınlık/uzaklık:** Kıyı kesimlerde deniz etkisiyle sıcaklık farkları azalır; iç kesimlerde karasallık artar.
- **Dağların uzanış doğrultusu:** Kıyıya paralel uzanan Karadeniz ve Toros Dağları, deniz etkisinin iç kesimlere sokulmasını engeller; bu yüzden kıyıdan iç kesimlere geçişte iklim kısa mesafede belirgin biçimde değişebilir.
- **Bakı (yön):** Güneye bakan yamaçlar daha fazla güneş ışını alır.', 'Aşağıdaki iklim tiplerinden hangisi her mevsim yağışlı olması bakımından diğerlerinden ayrılır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8658d1de-0f40-4e6f-a04b-a08e9fb74a15', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'kolay'::difficulty_level, 'Yazların sıcak ve kurak, kışların ise ılık ve yağışlı geçtiği iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin temel özelliklerini tanıyabilme.', 'Yazın sıcak-kurak, kışın ılık-yağışlı geçmesi Akdeniz ikliminin temel özelliğidir; bu iklim Akdeniz ve Ege kıyılarında görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8658d1de-0f40-4e6f-a04b-a08e9fb74a15', 'Karadeniz iklimi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8658d1de-0f40-4e6f-a04b-a08e9fb74a15', 'Akdeniz iklimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8658d1de-0f40-4e6f-a04b-a08e9fb74a15', 'Karasal iklim', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8658d1de-0f40-4e6f-a04b-a08e9fb74a15', 'Marmara iklimi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b301b393-91ee-4708-990b-dee081075de7', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'kolay'::difficulty_level, 'Türkiye''de her mevsim yağış alan ve yıllık yağış miktarı en fazla olan iklim tipi aşağıdaki bölgelerin hangisinde görülür?', 'İklim tiplerinin bölgesel dağılışını bilme.', 'Karadeniz iklimi her mevsim yağışlı olup Türkiye''nin en yağışlı iklim tipidir ve Karadeniz kıyı şeridinde görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b301b393-91ee-4708-990b-dee081075de7', 'İç Anadolu Bölgesi''nin iç kesimleri', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b301b393-91ee-4708-990b-dee081075de7', 'Karadeniz Bölgesi kıyıları', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b301b393-91ee-4708-990b-dee081075de7', 'Akdeniz Bölgesi kıyıları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b301b393-91ee-4708-990b-dee081075de7', 'Doğu Anadolu Bölgesi''nin yüksek kesimleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7b3aaa6d-9bab-4ff8-a777-a78012bdfe9e', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'orta'::difficulty_level, 'Türkiye''de kıyı kesimlerinden iç kesimlere gidildikçe iklimin kısa mesafede belirgin biçimde değişmesinin temel nedeni aşağıdakilerden hangisidir?', 'Yer şekillerinin iklim üzerindeki etkisini kavrayabilme.', 'Karadeniz ve Toros Dağları kıyıya paralel uzandığından denizden gelen nemli hava kütlelerinin iç kesimlere ulaşmasını engeller; bu nedenle kıyı ile iç kesim arasında kısa mesafede belirgin iklim farklılıkları oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b3aaa6d-9bab-4ff8-a777-a78012bdfe9e', 'Enlem farkının fazla olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b3aaa6d-9bab-4ff8-a777-a78012bdfe9e', 'Dağların kıyıya paralel uzanarak deniz etkisinin iç kesimlere sokulmasını engellemesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b3aaa6d-9bab-4ff8-a777-a78012bdfe9e', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b3aaa6d-9bab-4ff8-a777-a78012bdfe9e', 'Yıllık güneşlenme süresinin her yerde aynı olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5ac7bf1b-cb0d-4676-8c26-7df86d254592', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'orta'::difficulty_level, 'Aşağıdaki illerden hangisinde yaz ile kış arasındaki sıcaklık farkının en fazla olması beklenir?', 'Karasallığın sıcaklık farkına etkisini örnekle ilişkilendirebilme.', 'Erzurum, denizden uzak ve yüksek bir iç kesimde yer aldığından karasal iklimin etkisiyle yaz-kış sıcaklık farkı diğer kıyı kentlerine göre daha fazladır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ac7bf1b-cb0d-4676-8c26-7df86d254592', 'Antalya', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ac7bf1b-cb0d-4676-8c26-7df86d254592', 'Rize', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ac7bf1b-cb0d-4676-8c26-7df86d254592', 'Erzurum', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ac7bf1b-cb0d-4676-8c26-7df86d254592', 'İzmir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('370e280b-3d1e-43d9-8b5b-aaa031e8c3b0', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'zor'::difficulty_level, 'Enlemleri birbirine yakın olmasına karşın Rize ile Erzurum arasında kış sıcaklıkları bakımından büyük fark bulunmasının temel nedeni aşağıdakilerden hangisidir?', 'Denizellik-karasallık ve yükseltinin sıcaklık üzerindeki birlikte etkisini analiz edebilme.', 'Rize kıyıda yer aldığından denizin ılımanlaştırıcı etkisi altındadır; Erzurum ise hem yüksek hem de karasal bir iç kesimde bulunduğundan kışları çok daha soğuk geçer. İki merkezin enlemleri birbirine yakın olsa da belirleyici olan denize yakınlık ve yükselti farkıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('370e280b-3d1e-43d9-8b5b-aaa031e8c3b0', 'İki merkezin farklı boylamlarda yer alması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('370e280b-3d1e-43d9-8b5b-aaa031e8c3b0', 'Rize''nin denize kıyısının olması, Erzurum''un ise yüksek ve karasal bir konumda bulunması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('370e280b-3d1e-43d9-8b5b-aaa031e8c3b0', 'Rize''de yağışın yalnızca kış mevsiminde düşmesi, Erzurum''da hiç yağış düşmemesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('370e280b-3d1e-43d9-8b5b-aaa031e8c3b0', 'Erzurum''un güneşten daha fazla ışın alması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'Türkiye''de nüfus dağılışı yer şekilleri, iklim ve ekonomik faaliyetler gibi doğal ve beşeri faktörlere bağlı olarak kıyı ve ova kesimlerinde yoğunlaşırken; yerleşme dokusu ise su kaynağı ve iklim koşullarına göre toplu veya dağınık biçimde şekillenir.', '## Nüfus Dağılışını Etkileyen Faktörler

### Doğal (Fiziki) Faktörler
- **Yer şekilleri:** Dağlık ve engebeli alanlarda nüfus seyrek, ova ve düzlüklerde nüfus yoğundur.
- **İklim:** Elverişli/ılıman iklim koşullarının görüldüğü kıyı bölgelerinde nüfus daha yoğundur; sert karasal iklimin görüldüğü yüksek platolarda nüfus seyrektir.
- **Su kaynakları:** Akarsu vadileri ve ovalar gibi su kaynağına yakın alanlarda yerleşim ve tarım kolaylaştığından nüfus yoğunlaşır.
- **Toprak verimliliği:** Çukurova, Gediz ve Büyük Menderes ovaları gibi verimli tarım alanlarında nüfus yoğundur.

### Beşeri ve Ekonomik Faktörler
- **Ekonomik faaliyetler:** Sanayi, ticaret ve hizmet sektörünün geliştiği kentlerde nüfus yoğunlaşır.
- **Ulaşım:** Ulaşım olanaklarının geliştiği bölgelerde yerleşim ve nüfus artar.
- **Tarihi ve kültürel etkenler:** Tarih boyunca yerleşime elverişli, güvenli bölgeler daha yoğun nüfuslanmıştır.
- **Kentleşme:** Sanayileşme ve iş imkânlarına bağlı göç, büyük kentlerdeki nüfus oranını artırmıştır.

## Türkiye''de Nüfusun Dağılışı
- Kıyı bölgeleri (özellikle Marmara, Ege ve Akdeniz kıyıları) ile büyük ovalar nüfus bakımından yoğundur.
- Doğu Anadolu''nun yüksek ve engebeli kesimleri, iklim koşullarının elverişsizliği ve tarım alanlarının kısıtlı olması nedeniyle seyrek nüfusludur.
- Nüfusun büyük bölümü kentlerde yaşamaktadır; kırsal nüfus oranı zamanla azalmıştır.

## Yerleşme Tipleri

### Kırsal Yerleşme
- Ekonomik faaliyeti büyük ölçüde tarım ve hayvancılığa dayanan, nüfus ve yapı yoğunluğu şehirlere göre az olan yerleşmelerdir (köy, mezra, kom, yayla gibi).

### Kentsel (Şehirsel) Yerleşme
- Nüfusu kalabalık, ekonomik faaliyetleri sanayi, ticaret ve hizmet sektörüne dayanan yerleşmelerdir.

### Yerleşme Dokusuna Göre Sınıflandırma
- **Toplu (kümeleşmiş) yerleşme:** Su kaynaklarının sınırlı, güvenlik ihtiyacının ön planda olduğu kurak/yarı kurak bölgelerde evler bir arada ve sık dokulu kurulur (örn. İç Anadolu, Güneydoğu Anadolu).
- **Dağınık yerleşme:** Su kaynaklarının bol olduğu nemli ve yağışlı bölgelerde her hane kendi arazisine ve su kaynağına yakın, birbirinden uzak konumlanır (örn. Karadeniz Bölgesi''nin kırsal kesimleri).', 'Türkiye''de kırsal yerleşmelerin dağınık ya da toplu doku göstermesinde en belirleyici etken aşağıdakilerden hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9be2d2fe-46cb-4a8d-a832-6cf1329648aa', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfusun seyrek olduğu alanlara örnektir?', 'Nüfusun seyrek olduğu alanları örnekle ilişkilendirebilme.', 'Doğu Anadolu''nun yüksek ve engebeli platoları, sert iklim koşulları ve sınırlı tarım alanları nedeniyle Türkiye''nin en seyrek nüfuslu bölgelerindendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9be2d2fe-46cb-4a8d-a832-6cf1329648aa', 'Çukurova Ovası', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9be2d2fe-46cb-4a8d-a832-6cf1329648aa', 'Marmara kıyıları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9be2d2fe-46cb-4a8d-a832-6cf1329648aa', 'Doğu Anadolu''nun yüksek platoları', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9be2d2fe-46cb-4a8d-a832-6cf1329648aa', 'Ege kıyı ovaları', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6ca6ec88-a7cd-4bb3-86a0-ba3d0166b3e5', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi kırsal yerleşme tiplerinden biri değildir?', 'Kırsal ve kentsel yerleşme tiplerini ayırt edebilme.', 'Metropol, nüfusu ve ekonomik faaliyetleri bakımından büyük bir kentsel yerleşmeyi ifade eder; köy, mezra ve yayla ise kırsal yerleşme tipleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ca6ec88-a7cd-4bb3-86a0-ba3d0166b3e5', 'Köy', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ca6ec88-a7cd-4bb3-86a0-ba3d0166b3e5', 'Mezra', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ca6ec88-a7cd-4bb3-86a0-ba3d0166b3e5', 'Yayla', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ca6ec88-a7cd-4bb3-86a0-ba3d0166b3e5', 'Metropol', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8c157ba8-dfae-4ed7-80b3-f614232e4f14', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfus dağılışını etkileyen beşeri (insan kaynaklı) faktörlerden biridir?', 'Nüfus dağılışını etkileyen doğal ve beşeri faktörleri ayırt edebilme.', 'Sanayileşme ve ekonomik faaliyetler insan kaynaklı (beşeri) bir faktördür; yükselti, iklim ve yer şekilleri ise doğal (fiziki) faktörler arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c157ba8-dfae-4ed7-80b3-f614232e4f14', 'Yükselti', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c157ba8-dfae-4ed7-80b3-f614232e4f14', 'Sanayileşme ve ekonomik faaliyetler', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c157ba8-dfae-4ed7-80b3-f614232e4f14', 'İklim koşulları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8c157ba8-dfae-4ed7-80b3-f614232e4f14', 'Yer şekilleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('58acee3d-bdd3-4154-b0f2-4d7ec4f6c4a7', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'orta'::difficulty_level, 'Karadeniz Bölgesi''nin kırsal kesimlerinde evlerin genellikle birbirinden uzak ve dağınık şekilde kurulmasının temel nedeni aşağıdakilerden hangisidir?', 'Doğal koşulların yerleşme dokusuna etkisini analiz edebilme.', 'Karadeniz Bölgesi''nde yağış ve su kaynağı bolluğu ile engebeli arazi yapısı, ailelerin kendi tarım arazilerine ve su kaynaklarına yakın yerleşmesine yol açar; bu da dağınık yerleşme dokusunu oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58acee3d-bdd3-4154-b0f2-4d7ec4f6c4a7', 'Bölgede su kaynaklarının kısıtlı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58acee3d-bdd3-4154-b0f2-4d7ec4f6c4a7', 'Bölgenin engebeli olması nedeniyle her ailenin kendi arazisine ve su kaynağına yakın yerleşmesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58acee3d-bdd3-4154-b0f2-4d7ec4f6c4a7', 'Bölgede güvenlik kaygısının fazla olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58acee3d-bdd3-4154-b0f2-4d7ec4f6c4a7', 'Bölgede tarım alanlarının bulunmaması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a520c470-6eda-4d0c-93cf-bf8373c624fd', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'zor'::difficulty_level, 'Kurak bir iklim bölgesinde, su kaynaklarının sınırlı sayıda kaynak veya kuyu etrafında toplandığı bir yerleşim alanında evlerin sık ve bir arada (toplu) kurulmuş olması aşağıdakilerden hangisiyle açıklanabilir?', 'Toplu yerleşmenin oluşum nedenlerini kurak iklim koşullarıyla ilişkilendirerek analiz edebilme.', 'Kurak bölgelerde su kaynağı sınırlı olduğundan halk bu kaynaklara yakın ve bir arada yerleşir; ayrıca güvenlik ihtiyacı da toplu yerleşme dokusunu güçlendiren bir etkendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a520c470-6eda-4d0c-93cf-bf8373c624fd', 'Halkın tamamının aynı ekonomik faaliyetle uğraşması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a520c470-6eda-4d0c-93cf-bf8373c624fd', 'Sınırlı su kaynağının ortak kullanılması ve güvenlik ihtiyacının yerleşmeyi bir arada tutması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a520c470-6eda-4d0c-93cf-bf8373c624fd', 'Bölgenin deniz kıyısında yer alması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a520c470-6eda-4d0c-93cf-bf8373c624fd', 'Bölgede yağışın her mevsim düzenli olması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'İlk Türk devletleri; Asya Hun Devleti, Avrupa Hun Devleti, Göktürk Devleti ve Uygur Devleti başta olmak üzere Orta Asya bozkırlarında kurulan, Türk devlet geleneğinin temelini oluşturan siyasi yapılardır.', '## Asya Hun Devleti
- Bilinen ilk teşkilatlı Türk devleti olarak kabul edilir.
- En parlak dönemini Mete Han (Mao-tun) zamanında, MÖ 209''dan itibaren yaşamıştır.
- Mete Han, "onlu sistem" adı verilen ordu teşkilatını kurarak Türk-Moğol bozkır dünyasında askeri disiplinin temelini atmıştır.
- Çin ile uzun süre mücadele ederek Orta Asya''da geniş bir hakimiyet alanı oluşturmuştur.

## Kavimler Göçü ve Avrupa Hun Devleti
- Asya Hun Devleti''nin zamanla zayıflaması ve Çin baskısı, bazı Hun boylarının batıya yönelmesine yol açmıştır.
- Bu hareket, 375 yılında Kavimler Göçü''nün başlamasına zemin hazırlamıştır.
- Kavimler Göçü, Roma İmparatorluğu''nun 395''te Doğu ve Batı olarak ikiye ayrılmasına, 476''da ise Batı Roma İmparatorluğu''nun yıkılmasına neden olan gelişmelerin önünü açmıştır.
- Avrupa Hun Devleti, 5. yüzyılda Attila döneminde en güçlü dönemini yaşamış, Avrupa''da geniş bir alanda etkili olmuştur.

## Göktürk Devleti
- 552 yılında Bumin Kağan tarafından kurulmuştur.
- "Türk" adını taşıyan ilk devlettir.
- 582 yılında Doğu ve Batı Göktürk Devleti olarak ikiye ayrılmıştır.
- Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen Orhun Yazıtları (Göktürk Abideleri), Türk adının geçtiği ilk yazılı belgeler ve Türkçenin bilinen ilk yazılı metinleri olarak kabul edilir.

## Uygur Devleti
- 745 yılında kurulmuştur.
- Yerleşik hayata geçen ilk Türk devleti olarak bilinir.
- Mani dinini benimseyerek savaşçı bozkır kültüründen uzaklaşmış, tarım ve şehir hayatına yönelmişlerdir.
- Kağıt ve matbaayı kullanan ilk Türk devleti olarak KPSS müfredatında yer alır.

## Ortak Özellikler
İlk Türk devletlerinde "kut" anlayışına dayalı hükümdarlık, kurultay (devlet meclisi) geleneği ve ikili teşkilat (doğu-batı yönetim biçimi) gibi ortak siyasi ve sosyal yapılar dikkat çeker.', 'Aşağıdakilerden hangisi yerleşik hayata geçen ve kağıt-matbaayı kullanan ilk Türk devleti olarak bilinir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('74a57933-b90f-4ddd-889f-5e231a44e6ab', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'kolay'::difficulty_level, 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?', 'İlk Türk devletlerinden Asya Hun Devleti''nin özelliklerini kavrar.', 'Asya Hun Devleti, Mete Han döneminde onlu sistem ordu teşkilatıyla güçlenmiş ve bilinen ilk teşkilatlı Türk devleti kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('74a57933-b90f-4ddd-889f-5e231a44e6ab', 'Asya Hun Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('74a57933-b90f-4ddd-889f-5e231a44e6ab', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('74a57933-b90f-4ddd-889f-5e231a44e6ab', 'Uygur Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('74a57933-b90f-4ddd-889f-5e231a44e6ab', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b09fd4cc-8c03-42fa-bb3b-47e32e2d5873', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'kolay'::difficulty_level, '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?', 'Göktürk Devleti''nin kuruluşu ve kurucusunu bilir.', 'Göktürk Devleti 552 yılında Bumin Kağan tarafından kurulmuş olup Türk adını taşıyan ilk devlettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b09fd4cc-8c03-42fa-bb3b-47e32e2d5873', 'Bumin Kağan', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b09fd4cc-8c03-42fa-bb3b-47e32e2d5873', 'Mete Han', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b09fd4cc-8c03-42fa-bb3b-47e32e2d5873', 'Attila', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b09fd4cc-8c03-42fa-bb3b-47e32e2d5873', 'Bilge Kağan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8e5bf0c0-81ae-4ca5-a69a-62a330c7c114', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'orta'::difficulty_level, 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yerleşik yaşam ve kültürel özelliklerini ayırt eder.', 'Uygurlar, Mani dinini kabul ederek yerleşik hayata geçmiş ve kağıt-matbaayı kullanan ilk Türk devleti olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e5bf0c0-81ae-4ca5-a69a-62a330c7c114', 'Uygur Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e5bf0c0-81ae-4ca5-a69a-62a330c7c114', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e5bf0c0-81ae-4ca5-a69a-62a330c7c114', 'Asya Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e5bf0c0-81ae-4ca5-a69a-62a330c7c114', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fafb09d1-a184-40bd-b13e-a4e135d19805', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'orta'::difficulty_level, 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?', 'Orhun Yazıtları''nın hangi devlete ait olduğunu ve önemini bilir.', 'Orhun Yazıtları (Göktürk Abideleri), Göktürk Devleti dönemine ait olup Türkçenin bilinen ilk yazılı metinleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fafb09d1-a184-40bd-b13e-a4e135d19805', 'Göktürk Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fafb09d1-a184-40bd-b13e-a4e135d19805', 'Uygur Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fafb09d1-a184-40bd-b13e-a4e135d19805', 'Avrupa Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fafb09d1-a184-40bd-b13e-a4e135d19805', 'Asya Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2ee8360f-1902-4292-90a2-ece1823a2eb5', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'zor'::difficulty_level, '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?', 'Kavimler Göçü''nün Türk tarihiyle bağlantısını ve Avrupa tarihine etkisini analiz eder.', 'Asya Hun Devleti''nin Çin baskısıyla zayıflaması sonucu Hun boylarının batıya yönelmesi, Kavimler Göçü''nü başlatan temel gelişmedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ee8360f-1902-4292-90a2-ece1823a2eb5', 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ee8360f-1902-4292-90a2-ece1823a2eb5', 'Göktürklerin Doğu ve Batı olarak ikiye ayrılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ee8360f-1902-4292-90a2-ece1823a2eb5', 'Uygurların Moğolistan''daki hakimiyetini kaybetmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ee8360f-1902-4292-90a2-ece1823a2eb5', 'Bumin Kağan''ın Göktürk Devleti''ni kurması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('b606fed8-a975-40b5-8825-c55b080bee38', 'Osmanlı Kuruluş Dönemi, Osman Bey''in 1299''da beyliği kurmasından Fatih Sultan Mehmed''in tahta çıkışına kadar geçen, devletin bir uç beyliğinden güçlü bir imparatorluğa dönüştüğü süreçtir.', '## Osman Bey Dönemi
- Osmanlı Devleti''nin kuruluşu geleneksel olarak 1299 yılı kabul edilir.
- Osman Bey, Söğüt ve çevresinde küçük bir uç beyliği olarak devletin temellerini atmıştır.

## Orhan Bey Dönemi
- 1326''da Bursa fethedilerek başkent yapılmıştır.
- İlk düzenli ordu (Yaya ve Müsellem birlikleri) kurulmuştur.
- İznik''te ilk medrese açılmış, ilk Osmanlı parası bastırılmıştır.

## I. Murad (Hüdavendigar) Dönemi
- Edirne fethedilerek yeni başkent yapılmıştır.
- Yeniçeri Ocağı kurulmuş, Çandarlı ailesi devlet yönetiminde etkili olmuştur.
- 1389 Kosova Savaşı''nda Sırplara karşı zafer kazanılmış, ancak I. Murad savaş meydanında şehit düşmüştür.

## Yıldırım Bayezid Dönemi
- 1396 Niğbolu Savaşı''nda Haçlı ordusuna karşı büyük bir zafer kazanılmıştır.
- İstanbul ilk kez kuşatılmıştır.
- 1402 Ankara Savaşı''nda Timur''a yenilerek esir düşmüş, bu durum Anadolu Türk siyasi birliğinin bozulmasına yol açmıştır.

## Fetret Devri (1402-1413)
- Yıldırım Bayezid''in şehzadeleri arasında taht kavgalarının yaşandığı, devletin dağılma tehlikesi geçirdiği dönemdir.

## Çelebi Mehmed (I. Mehmed) Dönemi
- Fetret Devri''ni sona erdirerek siyasi birliği yeniden sağlamış, bu nedenle Osmanlı''nın "ikinci kurucusu" olarak anılmıştır.

## II. Murad Dönemi
- 1444 Varna Savaşı ve 1448 II. Kosova Savaşı''nda Haçlı ordularına karşı önemli zaferler kazanılmıştır.
- Devlet, II. Mehmed''in (Fatih) 1451''de tahta çıkışıyla kuruluş döneminin sonuna ve yükseliş dönemine geçiş yapmıştır.', 'Ankara Savaşı sonrasında yaşanan ve şehzadeler arasındaki taht mücadelelerine sahne olan döneme ne ad verilir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0a062320-12ef-412d-a82d-498ed847b67c', 'b606fed8-a975-40b5-8825-c55b080bee38', 'kolay'::difficulty_level, 'Osmanlı Devleti''nin kuruluş tarihi olarak kabul edilen 1299 yılında beyliği kuran kişi kimdir?', 'Osmanlı Devleti''nin kuruluşunu ve kurucusunu bilir.', 'Osmanlı Devleti''nin kuruluşu, Osman Bey tarafından 1299 yılında gerçekleştirilmiş olarak kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0a062320-12ef-412d-a82d-498ed847b67c', 'Osman Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0a062320-12ef-412d-a82d-498ed847b67c', 'Orhan Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0a062320-12ef-412d-a82d-498ed847b67c', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0a062320-12ef-412d-a82d-498ed847b67c', 'II. Mehmed', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d19af763-cd47-4398-a021-aadc6c91b319', 'b606fed8-a975-40b5-8825-c55b080bee38', 'kolay'::difficulty_level, 'Bursa''nın fethedilerek başkent yapıldığı, ilk düzenli ordu (Yaya-Müsellem) ve ilk medresenin (İznik) kurulduğu dönem hangi padişaha aittir?', 'Orhan Bey dönemindeki kurumsallaşma adımlarını bilir.', 'Orhan Bey döneminde Bursa fethedilmiş, ilk düzenli ordu kurulmuş ve İznik''te ilk medrese açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d19af763-cd47-4398-a021-aadc6c91b319', 'Orhan Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d19af763-cd47-4398-a021-aadc6c91b319', 'Osman Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d19af763-cd47-4398-a021-aadc6c91b319', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d19af763-cd47-4398-a021-aadc6c91b319', 'Yıldırım Bayezid', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8dacb1a7-7b7b-4525-adf1-55dc91a9acd1', 'b606fed8-a975-40b5-8825-c55b080bee38', 'orta'::difficulty_level, 'Yıldırım Bayezid''in Timur''a yenilerek esir düştüğü ve Anadolu Türk siyasi birliğinin bozulmasına yol açan savaş aşağıdakilerden hangisidir?', 'Ankara Savaşı''nın Osmanlı kuruluş dönemine etkisini kavrar.', '1402 Ankara Savaşı''nda Yıldırım Bayezid Timur''a yenilmiş ve esir düşmüş, bu durum Fetret Devri''ne zemin hazırlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dacb1a7-7b7b-4525-adf1-55dc91a9acd1', 'Ankara Savaşı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dacb1a7-7b7b-4525-adf1-55dc91a9acd1', 'Niğbolu Savaşı', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dacb1a7-7b7b-4525-adf1-55dc91a9acd1', 'Kosova Savaşı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dacb1a7-7b7b-4525-adf1-55dc91a9acd1', 'Varna Savaşı', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6a80223e-348a-4970-b307-00f7fc09a1d3', 'b606fed8-a975-40b5-8825-c55b080bee38', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi I. Murad (Hüdavendigar) döneminde gerçekleşen gelişmelerden biridir?', 'I. Murad dönemi kurumsal ve askeri gelişmelerini diğer padişahlar dönemindeki gelişmelerden ayırt eder.', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması I. Murad dönemine aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a80223e-348a-4970-b307-00f7fc09a1d3', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a80223e-348a-4970-b307-00f7fc09a1d3', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a80223e-348a-4970-b307-00f7fc09a1d3', 'Ankara Savaşı''nın kaybedilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a80223e-348a-4970-b307-00f7fc09a1d3', 'Bursa''nın fethedilmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3e989bd9-5110-48b7-9f0f-f3cc42319b3d', 'b606fed8-a975-40b5-8825-c55b080bee38', 'zor'::difficulty_level, 'Fetret Devri''ni sona erdirerek Osmanlı siyasi birliğini yeniden sağlayan ve bu nedenle "ikinci kurucu" olarak da anılan padişah kimdir?', 'Fetret Devri''nin sona eriş sürecini ve bu süreçteki padişahın rolünü analiz eder.', 'Çelebi Mehmed (I. Mehmed), şehzadeler arası taht mücadelelerini sona erdirerek devletin siyasi birliğini yeniden sağlamış ve bu nedenle ikinci kurucu olarak anılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e989bd9-5110-48b7-9f0f-f3cc42319b3d', 'Çelebi Mehmed (I. Mehmed)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e989bd9-5110-48b7-9f0f-f3cc42319b3d', 'II. Murad', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e989bd9-5110-48b7-9f0f-f3cc42319b3d', 'Yıldırım Bayezid', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3e989bd9-5110-48b7-9f0f-f3cc42319b3d', 'Orhan Bey', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'Kurtuluş Savaşı (Millî Mücadele), Mondros Ateşkes Antlaşması sonrası işgallere karşı Mustafa Kemal önderliğinde örgütlenen direniş sürecidir; kongreler, TBMM''nin açılışı, cepheler ve Lozan Antlaşması''yla sonuçlanmıştır.', '## Hazırlık Dönemi
- 30 Ekim 1918''de Mondros Ateşkes Antlaşması imzalanmış, İtilaf Devletleri Anadolu''yu işgale başlamıştır.
- 19 Mayıs 1919''da Mustafa Kemal, Millî Mücadele''yi örgütlemek üzere Samsun''a çıkmıştır.

## Kongreler ve Genelgeler
- 22 Haziran 1919''da yayımlanan Amasya Genelgesi, "Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesiyle Millî Mücadele''nin ilk yazılı belgesi kabul edilir.
- Temmuz-Ağustos 1919''da toplanan Erzurum Kongresi bölgesel, Eylül 1919''da toplanan Sivas Kongresi ise ulusal nitelikli bir kongredir; Sivas Kongresi''nde Anadolu ve Rumeli Müdafaa-i Hukuk Cemiyeti kurulmuştur.

## TBMM''nin Açılışı ve Misak-ı Millî
- Son Osmanlı Mebusan Meclisi''nde kabul edilen Misak-ı Millî kararları, millî sınırları ve bağımsızlık ilkelerini belirlemiştir.
- İstanbul''un İtilaf Devletlerince resmen işgal edilmesi (16 Mart 1920) üzerine, 23 Nisan 1920''de Ankara''da TBMM açılmıştır.

## Cepheler
- **Doğu Cephesi:** Kazım Karabekir komutasında Ermenilere karşı mücadele edilmiş, Gümrü Antlaşması ile sonuçlanmıştır.
- **Güney Cephesi:** Kuvay-ı Milliye güçleri Fransızlara karşı Antep, Maraş ve Urfa''da direnmiştir.
- **Batı Cephesi:** Yunan ordusuna karşı I. İnönü (Ocak 1921) ve II. İnönü (Mart-Nisan 1921) muharebeleri kazanılmış, Ağustos-Eylül 1921''de Sakarya Meydan Muharebesi ile Yunan ilerleyişi durdurulmuştur. 26 Ağustos 1922''de başlayan Büyük Taarruz ve 30 Ağustos''taki Başkomutanlık Meydan Muharebesi ile Yunan ordusu kesin olarak yenilgiye uğratılmıştır.

## Savaşın Sonuçları
- Ekim 1922''de Mudanya Ateşkes Antlaşması imzalanmıştır.
- 24 Temmuz 1923''te imzalanan Lozan Antlaşması ile yeni Türk devletinin bağımsızlığı uluslararası alanda tanınmıştır.', 'Millî Mücadele''nin ilk yazılı belgesi olarak kabul edilen ve 22 Haziran 1919''da yayımlanan genelge hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d1c31689-c56a-464c-b4e8-49b7d9e87b2d', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'kolay'::difficulty_level, 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?', 'Millî Mücadele''nin başlangıç tarihini bilir.', 'Mustafa Kemal, 19 Mayıs 1919''da Samsun''a çıkarak Millî Mücadele''nin fiilen başlamasını sağlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d1c31689-c56a-464c-b4e8-49b7d9e87b2d', '19 Mayıs 1919', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d1c31689-c56a-464c-b4e8-49b7d9e87b2d', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d1c31689-c56a-464c-b4e8-49b7d9e87b2d', '30 Ekim 1918', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d1c31689-c56a-464c-b4e8-49b7d9e87b2d', '29 Ekim 1923', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1fd0a7f0-f514-4ba0-9ab4-617701ac3686', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?', 'TBMM''nin açılış tarihini ve önemini bilir.', 'TBMM, İstanbul''un işgali üzerine 23 Nisan 1920''de Ankara''da açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fd0a7f0-f514-4ba0-9ab4-617701ac3686', '23 Nisan 1920', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fd0a7f0-f514-4ba0-9ab4-617701ac3686', '19 Mayıs 1919', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fd0a7f0-f514-4ba0-9ab4-617701ac3686', '4 Eylül 1919', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fd0a7f0-f514-4ba0-9ab4-617701ac3686', '16 Mart 1920', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e69b91c9-0485-465b-9f95-f274a701c977', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'orta'::difficulty_level, '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?', 'Amasya Genelgesi''nin içeriğini ve önemini kavrar.', 'Bu ifade, 22 Haziran 1919''da yayımlanan Amasya Genelgesi''nde yer almaktadır ve genelge Millî Mücadele''nin ilk yazılı belgesi kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e69b91c9-0485-465b-9f95-f274a701c977', 'Amasya Genelgesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e69b91c9-0485-465b-9f95-f274a701c977', 'Erzurum Kongresi kararları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e69b91c9-0485-465b-9f95-f274a701c977', 'Sivas Kongresi kararları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e69b91c9-0485-465b-9f95-f274a701c977', 'Misak-ı Millî', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('20e69757-12aa-4478-8cc8-ce5c943b77a3', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'orta'::difficulty_level, 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?', 'Batı Cephesi''ndeki muharebelerin kronolojik sırasını ve önemini bilir.', 'Sakarya Meydan Muharebesi, Ağustos-Eylül 1921''de kazanılmış ve Yunan ilerleyişini durdurarak Türk ordusunun taarruz gücüne geçmesinde dönüm noktası olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('20e69757-12aa-4478-8cc8-ce5c943b77a3', 'Sakarya Meydan Muharebesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('20e69757-12aa-4478-8cc8-ce5c943b77a3', 'I. İnönü Muharebesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('20e69757-12aa-4478-8cc8-ce5c943b77a3', 'Büyük Taarruz', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('20e69757-12aa-4478-8cc8-ce5c943b77a3', 'II. İnönü Muharebesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('29c19ecd-0f10-4484-b998-0db54533fd04', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'zor'::difficulty_level, 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?', 'Kurtuluş Savaşı cephelerini ve mücadele edilen devletleri doğru eşleştirir.', 'Antep, Maraş ve Urfa, Güney Cephesi''nde Fransızlara karşı verilen direnişin öne çıktığı yerlerdir; Sakarya, İnönü ve Dumlupınar ise Batı Cephesi''nde Yunanlılara karşı yaşanan muharebe yerleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29c19ecd-0f10-4484-b998-0db54533fd04', 'Antep, Maraş, Urfa', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29c19ecd-0f10-4484-b998-0db54533fd04', 'Sakarya, İnönü, Dumlupınar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29c19ecd-0f10-4484-b998-0db54533fd04', 'Gümrü, Kars, Sarıkamış', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('29c19ecd-0f10-4484-b998-0db54533fd04', 'İzmir, Bursa, Eskişehir', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'İnkılap Tarihi, Cumhuriyet''in ilanından itibaren Mustafa Kemal Atatürk önderliğinde siyasi, hukuki, eğitim ve toplumsal alanlarda gerçekleştirilen köklü değişimleri (inkılapları) kapsar.', '## Siyasi İnkılaplar
- 1 Kasım 1922''de saltanat kaldırılarak Osmanlı hanedanının siyasi yetkisi sona erdirilmiştir.
- 29 Ekim 1923''te Cumhuriyet ilan edilmiş, Mustafa Kemal ilk Cumhurbaşkanı seçilmiştir.
- 3 Mart 1924''te halifelik kaldırılarak laik devlet düzenine geçişte önemli bir adım atılmıştır.

## Eğitim ve Hukuk Alanındaki İnkılaplar
- 3 Mart 1924''te kabul edilen Tevhid-i Tedrisat Kanunu ile eğitim kurumları Millî Eğitim Bakanlığı çatısı altında birleştirilerek eğitimde birlik sağlanmıştır.
- 1925 yılında tekke, zaviye ve türbeler kapatılmıştır.
- 25 Kasım 1925''te Şapka Kanunu kabul edilmiştir.
- 17 Şubat 1926''da İsviçre Medeni Kanunu esas alınarak Türk Medeni Kanunu kabul edilmiş; kadın-erkek eşitliği hukuki zeminde güçlendirilmiştir.

## Harf ve Dil İnkılabı
- 1 Kasım 1928''de kabul edilen kanunla Latin harflerine dayalı yeni Türk alfabesine geçilmiştir.

## Toplumsal ve Siyasi Haklar
- 1930 yılında kadınlara belediye seçimlerinde seçme hakkı tanınmıştır.
- 1934 yılında kadınlara milletvekili seçme ve seçilme hakkı tanınmıştır.
- 1934 yılında Soyadı Kanunu kabul edilerek herkesin bir soyadı alması zorunlu hale getirilmiştir.

## Genel Değerlendirme
Bu inkılaplar; laik, çağdaş ve millî egemenliğe dayalı bir devlet ve toplum yapısı oluşturmayı amaçlamış, kısa sürede birbirini tamamlayan bir bütünlük içinde gerçekleştirilmiştir.', 'Eğitim kurumlarını Millî Eğitim Bakanlığı çatısı altında birleştiren ve eğitimde birliği sağlayan kanun hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3f15f56a-261a-4939-a50f-0da7b2c65c91', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'kolay'::difficulty_level, 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', 'Cumhuriyetin ilan tarihini bilir.', 'Türkiye Cumhuriyeti, 29 Ekim 1923 tarihinde ilan edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f15f56a-261a-4939-a50f-0da7b2c65c91', '29 Ekim 1923', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f15f56a-261a-4939-a50f-0da7b2c65c91', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f15f56a-261a-4939-a50f-0da7b2c65c91', '1 Kasım 1922', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f15f56a-261a-4939-a50f-0da7b2c65c91', '3 Mart 1924', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5eb60081-006b-4c44-8295-43c64a1636a5', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'kolay'::difficulty_level, 'Osmanlı hanedanının siyasi yetkisinin sona erdirildiği saltanatın kaldırılması hangi tarihte gerçekleşmiştir?', 'Saltanatın kaldırılış tarihini ve önemini bilir.', 'Saltanat, 1 Kasım 1922 tarihinde TBMM kararıyla kaldırılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb60081-006b-4c44-8295-43c64a1636a5', '1 Kasım 1922', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb60081-006b-4c44-8295-43c64a1636a5', '29 Ekim 1923', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb60081-006b-4c44-8295-43c64a1636a5', '3 Mart 1924', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb60081-006b-4c44-8295-43c64a1636a5', '17 Şubat 1926', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8524f8ab-d63d-4303-a34f-fbfbf40ecdaa', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'orta'::difficulty_level, 'Halifeliğin kaldırılması ile eğitimde birliği sağlayan Tevhid-i Tedrisat Kanunu''nun kabulü, 1924 yılında hangi tarihte aynı gün gerçekleşmiştir?', 'Halifeliğin kaldırılması ve Tevhid-i Tedrisat Kanunu''nun tarihini ve ilişkisini bilir.', 'Halifelik ile Tevhid-i Tedrisat Kanunu, aynı gün olan 3 Mart 1924''te kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8524f8ab-d63d-4303-a34f-fbfbf40ecdaa', '3 Mart', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8524f8ab-d63d-4303-a34f-fbfbf40ecdaa', '1 Kasım', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8524f8ab-d63d-4303-a34f-fbfbf40ecdaa', '25 Kasım', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8524f8ab-d63d-4303-a34f-fbfbf40ecdaa', '17 Şubat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b4ff29bb-17ed-4499-842d-84a0592d674f', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'orta'::difficulty_level, 'Türk kadınına milletvekili seçme ve seçilme hakkının tanındığı yıl aşağıdakilerden hangisidir?', 'Kadınlara tanınan siyasi hakların tarihsel sürecini bilir.', 'Kadınlara milletvekili seçme ve seçilme hakkı 1934 yılında tanınmıştır; 1930 yılında ise yalnızca belediye seçimlerinde seçme hakkı verilmişti.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4ff29bb-17ed-4499-842d-84a0592d674f', '1934', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4ff29bb-17ed-4499-842d-84a0592d674f', '1930', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4ff29bb-17ed-4499-842d-84a0592d674f', '1926', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4ff29bb-17ed-4499-842d-84a0592d674f', '1928', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('554f945e-5dac-480d-99d8-4d7ea732a6aa', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'zor'::difficulty_level, 'Aşağıdaki inkılaplardan hangisi kronolojik olarak diğerlerinden daha sonra gerçekleşmiştir?', 'Cumhuriyet dönemi inkılaplarını kronolojik sıraya göre değerlendirir.', 'Soyadı Kanunu 1934 yılında kabul edilmiş olup, Medeni Kanun (1926), Harf İnkılabı (1928) ve Şapka Kanunu''ndan (1925) daha sonraki bir tarihte gerçekleşmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('554f945e-5dac-480d-99d8-4d7ea732a6aa', 'Soyadı Kanunu (1934)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('554f945e-5dac-480d-99d8-4d7ea732a6aa', 'Medeni Kanun''un kabulü (1926)', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('554f945e-5dac-480d-99d8-4d7ea732a6aa', 'Harf İnkılabı (1928)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('554f945e-5dac-480d-99d8-4d7ea732a6aa', 'Şapka Kanunu (1925)', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('2d6bd953-efd9-4148-9a05-af0124ee9484', 'Ünlü ve ünsüz uyumu, ünsüz yumuşaması/sertleşmesi, ünlü düşmesi ve kaynaştırma ünsüzleri gibi ses olaylarını kapsayan bu konu, Türkçenin ses bilgisi kurallarını örneklerle açıklar.', '## Büyük Ünlü Uyumu (Kalınlık-İncelik Uyumu)
Türkçe kökenli bir kelimenin ilk hecesinde kalın ünlü (a, ı, o, u) varsa sonraki hecelerde de kalın ünlü bulunur; ilk hecede ince ünlü (e, i, ö, ü) varsa sonraki hecelerde de ince ünlü bulunur. Örneğin ''kalemlik'' kelimesindeki ''kalem'' kökü Arapça kökenli olduğu için bu kurala aykırıdır (a-e). ''Kalem, hangi, elma, anne'' gibi bazı yabancı kökenli ya da kalıplaşmış kelimeler bu kuralın istisnasıdır.

## Küçük Ünlü Uyumu (Düzlük-Yuvarlaklık Uyumu)
Düz ünlülerden (a, e, ı, i) sonra düz ünlü gelir. Yuvarlak ünlülerden (o, ö, u, ü) sonra ise ya düz-geniş (a, e) ya da dar-yuvarlak (u, ü) ünlü gelir. ''Doktor, otobüs, radyo'' gibi yabancı kökenli kelimeler bu kurala da aykırıdır çünkü yuvarlak bir ünlüden sonra yine geniş-yuvarlak (o, ö) bir ünlü gelmiştir.

## Ünsüz Benzeşmesi (Sertleşme)
Sert ünsüzle (ç, f, h, k, p, s, ş, t = ''fıstıkçı şahap'') biten bir kelimeye yumuşak ünsüzle başlayan bir ek gelirse, ekin başındaki ünsüz sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta, iş+ci → işçi.

## Ünsüz Yumuşaması
p, ç, t, k ile biten bir kelime ünlüyle başlayan bir ek aldığında bu ünsüzler yumuşayarak sırasıyla b, c, d, ğ/g''ye dönüşür: kitap→kitabı, ağaç→ağacı, at→adı, çocuk→çocuğu.

## Ünlü Düşmesi (Hece Düşmesi)
İkinci hecesinde dar ünlü (ı, i, u, ü) bulunan bazı iki heceli kelimeler ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: burun→burnu, ağız→ağzı, akıl→aklı, oğul→oğlu, şehir→şehri.

## Kaynaştırma Ünsüzleri
Ünlüyle biten bir kelime ünlüyle başlayan bir ek aldığında, iki ünlünün yan yana gelmesini önlemek için araya ''y, ş, s, n'' kaynaştırma ünsüzlerinden biri girer: kapı+ı→kapıyı, iki+er→ikişer, araba+ın→arabasının, kapı+ın→kapının.', 'Örnek: ''Ağacın gölgesinde otururken kitabını okudu.'' cümlesinde hangi kelimede ünsüz yumuşaması görülür?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a2c55666-f6a9-4d68-b5e6-76b23f8825cd', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi büyük ünlü uyumuna (kalınlık-incelik uyumuna) aykırıdır?', 'Büyük ünlü uyumu kuralını kelimeler üzerinde uygular.', '''Kalem'' kökü Arapça kökenli olup ilk hecesinde kalın ünlü (a), ikinci hecesinde ince ünlü (e) bulunur; bu nedenle kelime büyük ünlü uyumuna aykırıdır. Diğer seçeneklerdeki kelimelerin tüm heceleri ya kalın ya da ince ünlülerden oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2c55666-f6a9-4d68-b5e6-76b23f8825cd', 'kalemlik', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2c55666-f6a9-4d68-b5e6-76b23f8825cd', 'yapraklar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2c55666-f6a9-4d68-b5e6-76b23f8825cd', 'sevgili', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2c55666-f6a9-4d68-b5e6-76b23f8825cd', 'doğrular', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('475ec8cd-4d35-4b26-942b-48835e0e0879', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde ünsüz yumuşaması (p, ç, t, k seslerinin yumuşaması) görülür?', 'Ünsüz yumuşaması kuralını örneklerde tespit eder.', '''Ağaç'' kökündeki sert ünsüz ''ç'', ünlüyle başlayan iyelik eki ''-ı'' aldığında yumuşayarak ''c''ye dönüşmüş ve ''ağacı'' biçimini almıştır. Diğer seçeneklerde ünsüzle başlayan ekler geldiği için yumuşama gerçekleşmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('475ec8cd-4d35-4b26-942b-48835e0e0879', 'kitaptan', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('475ec8cd-4d35-4b26-942b-48835e0e0879', 'ağacı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('475ec8cd-4d35-4b26-942b-48835e0e0879', 'sokakta', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('475ec8cd-4d35-4b26-942b-48835e0e0879', 'çocuktan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bb0a793c-4595-4096-9ca7-fbe270f1149c', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlü düşmesi (hece düşmesi) örneği vardır?', 'Ünlü düşmesi kuralının işlediği kelimeleri cümlede belirler.', '''Burun'' kelimesi ünlüyle başlayan iyelik eki ''-u'' aldığında ikinci hecesindeki dar ünlü ''u'' düşerek ''burnu'' biçimini almıştır. Diğer cümlelerdeki kelimelerde böyle bir ses düşmesi yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb0a793c-4595-4096-9ca7-fbe270f1149c', 'Burnu kanayan çocuğu hemen hastaneye götürdüler.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb0a793c-4595-4096-9ca7-fbe270f1149c', 'Bahçedeki güller sabaha karşı açmıştı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb0a793c-4595-4096-9ca7-fbe270f1149c', 'Kitapları düzenli bir şekilde masaya bıraktı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb0a793c-4595-4096-9ca7-fbe270f1149c', 'Sınavdan beklediğinden yüksek bir not aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ac7d8e98-2a3a-4f20-a0e3-68aef4ee0c62', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'orta'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde kaynaştırma ünsüzü kullanılmıştır?', 'Kaynaştırma ünsüzlerinin kullanıldığı kelimeleri ayırt eder.', 'Ünlüyle biten ''kapı'' kelimesi ünlüyle başlayan ''-ı'' ekini aldığında iki ünlünün yan yana gelmesini önlemek için araya ''y'' kaynaştırma ünsüzü girmiş ve ''kapıyı'' biçimi oluşmuştur. Diğer seçeneklerdeki ekler ünsüzle başladığı için kaynaştırma ünsüzüne gerek yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac7d8e98-2a3a-4f20-a0e3-68aef4ee0c62', 'kapıyı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac7d8e98-2a3a-4f20-a0e3-68aef4ee0c62', 'evden', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac7d8e98-2a3a-4f20-a0e3-68aef4ee0c62', 'kitaplar', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac7d8e98-2a3a-4f20-a0e3-68aef4ee0c62', 'sokakta', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('adaa63c2-0e6b-4e0f-b454-caf1a5351a4d', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'zor'::difficulty_level, 'Aşağıdaki kelimelerden hangisi küçük ünlü uyumuna (düzlük-yuvarlaklık uyumuna) aykırıdır?', 'Küçük ünlü uyumu kuralını ileri düzeyde uygular.', 'Yuvarlak bir ünlüden (o) sonra ancak düz-geniş (a, e) ya da dar-yuvarlak (u, ü) bir ünlü gelebilir; ''doktor'' kelimesinde ise yuvarlak ''o'' ünlüsünden sonra yine geniş-yuvarlak ''o'' geldiği için kural bozulmuştur. Diğer kelimelerin tamamı küçük ünlü uyumuna uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('adaa63c2-0e6b-4e0f-b454-caf1a5351a4d', 'doktor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('adaa63c2-0e6b-4e0f-b454-caf1a5351a4d', 'kuzu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('adaa63c2-0e6b-4e0f-b454-caf1a5351a4d', 'çocuk', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('adaa63c2-0e6b-4e0f-b454-caf1a5351a4d', 'balık', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'Bu konu; ''de/da'' bağlacı ile hâl eki, ''ki'' bağlacı ile ''-ki'' eki, ''mi'' soru eki ve büyük harf kullanımı gibi en sık karıştırılan yazım kurallarını örneklerle ele alır.', '## ''de/da'' Bağlacı ve Hâl Eki
Bağlaç olan ''de/da'' her zaman ayrı yazılır ve sertleşerek ''te/ta'' biçimini almaz: ''O da bizimle geldi.'' Cümleden çıkarıldığında anlam bütünlüğü bozulmuyorsa bağlaçtır. Bulunma hâli eki olan ''-de/-da'' ise bitişik yazılır ve sert ünsüzden sonra ''-te/-ta'' biçimine sertleşebilir: ''Evde kimse yoktu.'', ''Kitapta ilginç bilgiler vardı.''

## ''mi'' Soru Eki
Soru eki ''mi/mı/mu/mü'' her zaman kendinden önceki kelimeden ayrı yazılır; kendisinden sonra gelen ekler ise bitişik yazılır: ''Geliyor musun?'', ''Bu doğru mudur?''

## ''ki'' Bağlacı ve ''-ki'' Eki
Bağlaç olan ''ki'' ayrı yazılır: ''Biliyordum ki bu iş kolay olmayacak.'' Sıfat yapan ilgi eki ''-ki'' ise bitişik yazılır: ''Sokaktaki çocuklar, benimki, yarınki toplantı.'' ''Hâlbuki, mademki, oysaki, sanki, belki'' gibi kalıplaşmış sözcükler bitişik yazılır; bunlar artık bağlaç ''ki'' olarak değil, tek bir kelime olarak kabul edilir.

## Büyük Harf Kullanımı
Özel adlar (kişi, yer, kurum adları), unvanlardan sonra veya önce gelen özel adlar (Ahmet Bey, Doktor Ayşe), belirli bir tarih bildiren gün ve ay adları (29 Ekim Cumhuriyet Bayramı) büyük harfle başlar. Ancak mevsim adları (ilkbahar, yaz, sonbahar, kış) hiçbir zaman büyük harfle yazılmaz; genel ifadelerde kullanılan gün ve ay adları da (''Her ay toplanırız.'') küçük harfle yazılır.

## Bitişik Yazılan Bazı Yapılar
Anlam kayması olan kalıcı birleşik kelimeler (gecekondu, hanımeli) bitişik yazılır. Yazım kuralları çoğunlukla bir ''çıkarma testi'' ile denetlenir: kelime cümleden çıkarıldığında anlam bozuluyorsa genellikle bir ektir ve bitişik yazılır; anlam bozulmuyorsa genellikle bir bağlaçtır ve ayrı yazılır.', 'Örnek: ''Sen de mi bu işe karıştın?'' cümlesindeki yazım kurallarını değerlendiriniz.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f8a80327-b1c6-4418-8691-41d1c7ddb8e1', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''de'' bağlaç olarak kullanılmış, bu nedenle ayrı yazılmıştır?', 'Bağlaç olan ''de/da'' ile hâl eki olan ''-de/-da''yı ayırt eder.', 'İkinci cümledeki ''da'', ''O bizimle gelmek istedi.'' cümlesinden çıkarıldığında anlam bütünlüğü bozulmadığı için bağlaçtır ve ayrı yazılır. Diğer cümlelerdeki ''-de'' ekleri isme bulunma hâli katan bir ek olduğu için bitişik yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f8a80327-b1c6-4418-8691-41d1c7ddb8e1', 'Sende kalan kitabımı getirir misin?', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f8a80327-b1c6-4418-8691-41d1c7ddb8e1', 'O da bizimle gelmek istedi.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f8a80327-b1c6-4418-8691-41d1c7ddb8e1', 'Evde kimse yoktu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f8a80327-b1c6-4418-8691-41d1c7ddb8e1', 'Bahçede oynayan çocukları gördüm.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a70ecf59-3a5d-4b07-b01d-23275c3f951d', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''ki'' bağlaç olarak kullanılmış ve bu nedenle ayrı yazılmıştır?', 'Bağlaç ''ki'' ile sıfat yapan ''-ki'' ekini ayırt eder.', 'İkinci cümlede ''ki'', iki cümleyi birbirine bağlayan bir bağlaçtır ve ayrı yazılır. Diğer cümlelerde ''-ki'', isme sıfat ya da ilgi zamiri işlevi kazandıran bir ek olduğu için bitişik yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a70ecf59-3a5d-4b07-b01d-23275c3f951d', 'Sokaktaki çocuklar top oynuyordu.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a70ecf59-3a5d-4b07-b01d-23275c3f951d', 'Biliyordum ki bu iş kolay olmayacaktı.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a70ecf59-3a5d-4b07-b01d-23275c3f951d', 'Benimki masanın üzerinde duruyor.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a70ecf59-3a5d-4b07-b01d-23275c3f951d', 'Yarınki toplantıya katılamayacağım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d268da8d-98d8-405f-937e-d0b6310860f3', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı vardır?', '''-ki'' ekinin bitişik yazılması gereken durumları fark eder.', '''Yarın'' kelimesine gelen sıfat yapan ''-ki'' eki bitişik yazılmalıdır; doğru yazım ''yarınki'' biçimindedir. Diğer cümlelerdeki yazımlar kurallara uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d268da8d-98d8-405f-937e-d0b6310860f3', 'Yarın ki sınava çalışmalıyım.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d268da8d-98d8-405f-937e-d0b6310860f3', 'Sokaktaki köpek durmadan havlıyordu.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d268da8d-98d8-405f-937e-d0b6310860f3', 'O da toplantıya katılacağını söyledi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d268da8d-98d8-405f-937e-d0b6310860f3', 'Kitaptaki resimleri çok beğendim.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('847da628-ee23-4416-bd66-e5838fece956', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harf kullanımıyla ilgili bir yanlışlık vardır?', 'Mevsim adlarının büyük harfle yazılmadığı kuralını uygular.', 'Mevsim adları hiçbir zaman büyük harfle başlamaz; bu nedenle ''ilkbahar'' kelimesi küçük harfle yazılmalıdır. Diğer cümlelerdeki büyük harf kullanımları (unvan, özel gün adı, dil adı) doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('847da628-ee23-4416-bd66-e5838fece956', 'Bu yıl İlkbahar çok erken geldi.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('847da628-ee23-4416-bd66-e5838fece956', 'Ahmet Bey toplantıya geç kaldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('847da628-ee23-4416-bd66-e5838fece956', '29 Ekim Cumhuriyet Bayramı''nı coşkuyla kutladık.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('847da628-ee23-4416-bd66-e5838fece956', 'Türkçe dersinde güzel bir şiir okuduk.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c99b8db1-0e5b-43dd-b0dc-404bbc344456', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı yoktur?', 'Birden fazla yazım kuralını bir arada değerlendirerek doğru cümleyi belirler.', 'İkinci cümlede bağlaç olan ''de'' doğru biçimde ayrı, soru eki ''mi'' de kurala uygun olarak ayrı yazılmıştır. Diğer cümlelerde sırasıyla ''kitapta'' yerine ''kitapda'', ''yarınki'' yerine ''yarın ki'' ve ''onunki'' yerine ''onun ki'' kullanılarak yazım yanlışı yapılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c99b8db1-0e5b-43dd-b0dc-404bbc344456', 'Kitapda ne yazdığını çok merak ediyorum.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c99b8db1-0e5b-43dd-b0dc-404bbc344456', 'Sen de mi bu işe karıştın?', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c99b8db1-0e5b-43dd-b0dc-404bbc344456', 'Yarın ki toplantıyı sakın unutma.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c99b8db1-0e5b-43dd-b0dc-404bbc344456', 'Herkes onun ki kadar başarılı olamadı.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'Virgül, iki nokta, noktalı virgül, kesme işareti, üç nokta ve ünlem işaretinin doğru kullanım kurallarını örneklerle açıklayan bu konu, noktalama hatalarını ayırt etmeyi hedefler.', '## Virgül (,)
Eş görevli kelime veya kelime gruplarını sıralarken kullanılır: ''Çarşıdan elma, armut, muz ve şeftali aldı.'' Sıralı cümleleri, ara sözleri ve hitap sözlerini ayırmak için de virgül konur. ''Ve'' bağlacından hemen önce genellikle virgül kullanılmaz.

## İki Nokta (:)
Kendisinden sonra örnek verilecek, açıklama yapılacak ya da bir liste sıralanacak cümlenin sonuna konur: ''Kırtasiyeden şunları aldım: kalem, silgi, defter.'' Ayrıca alıntı sözlerden önce de kullanılır: ''Öğretmenimiz: ''Yarın sınav var.'' dedi.''

## Noktalı Virgül (;)
Virgüllerle ayrılmış öğe gruplarını birbirinden ayırmak için ya da bağlaç kullanılmadan birbirine bağlı cümleleri ayırmak için kullanılır: ''Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.''

## Kesme İşareti ('')
Özel isimlere getirilen çekim eklerini ayırmak için kullanılır: ''İstanbul''da, Ahmet''in, Türkiye''ye.'' Cins (tür bildiren) isimlere gelen ekler kesme işaretiyle ayrılmaz: ''kalemi, öğretmene, kitabı'' gibi.

## Üç Nokta (...)
Tamamlanmamış cümlelerin sonuna, sözün bir yerde kesildiğini göstermek için ya da kaba sayılan sözlerin yerine kullanılır.

## Ünlem İşareti (!)
Sevinç, kızgınlık, korku, şaşkınlık gibi güçlü duyguları anlatan cümlelerin ve seslenme sözlerinin sonuna konur: ''Ne güzel bir manzara!''

Doğru noktalama, hem okunabilirliği artırır hem de cümlenin anlamını netleştirir; bu nedenle KPSS''de noktalama işaretlerinin yerinde kullanılıp kullanılmadığı sıkça sorulur.', 'Örnek: ''Öğretmenimiz Yarın sınav var dedi.'' cümlesinde hangi noktalama işaretleri eksiktir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ecb9e591-abb1-4ca0-a34f-74610b825218', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmıştır?', 'Kesme işaretinin özel isimlere gelen eklerde kullanıldığını kavrar.', '''Ahmet'' bir özel isim olduğu için aldığı ''-in'' eki kesme işaretiyle ayrılmıştır. Diğer seçeneklerdeki ''kalem, öğretmen, kitap'' cins isim olduğundan aldıkları ekler kesme işaretiyle ayrılmaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ecb9e591-abb1-4ca0-a34f-74610b825218', 'Ahmet''in kitabını dün akşam okudum.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ecb9e591-abb1-4ca0-a34f-74610b825218', 'Kalem''imi masanın üstünde unuttum.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ecb9e591-abb1-4ca0-a34f-74610b825218', 'Öğretmen''e ödevimi teslim ettim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ecb9e591-abb1-4ca0-a34f-74610b825218', 'Kitab''ı çantama koydum.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4cdf6950-fcd8-4d67-a5eb-7f13cc487a0a', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde virgül (,) doğru bir yerde kullanılmıştır?', 'Sıralama bildiren cümlelerde virgülün doğru kullanımını uygular.', 'Eş görevli kelimeler olan ''elma, armut, muz'' birbirinden virgülle ayrılmış, son öğeden önce ''ve'' bağlacı kullanıldığı için virgüle gerek duyulmamıştır. Diğer seçeneklerde virgüller anlamsız ya da gereksiz yerlere konmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cdf6950-fcd8-4d67-a5eb-7f13cc487a0a', 'Çarşıdan elma, armut, muz ve şeftali aldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cdf6950-fcd8-4d67-a5eb-7f13cc487a0a', 'Çarşıdan, elma armut muz ve şeftali aldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cdf6950-fcd8-4d67-a5eb-7f13cc487a0a', 'Çarşıdan elma armut, muz ve, şeftali aldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cdf6950-fcd8-4d67-a5eb-7f13cc487a0a', 'Çarşıdan elma armut muz, ve şeftali, aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fa1d768e-b7bd-4801-89ed-4bdb6747d437', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde iki nokta (:) doğru kullanılmıştır?', 'İki noktanın örnek/liste verme işlevini kavrar.', 'Birinci cümlede iki nokta, kendisinden sonra bir liste (örnek) sıralanacağını haber verdiği için doğru kullanılmıştır. Diğer cümlelerde iki noktayı gerektiren bir açıklama ya da örnekleme durumu yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa1d768e-b7bd-4801-89ed-4bdb6747d437', 'Kırtasiyeden şunları aldım: kalem, silgi, defter.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa1d768e-b7bd-4801-89ed-4bdb6747d437', 'Yarın: erken kalkıp işe gideceğim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa1d768e-b7bd-4801-89ed-4bdb6747d437', 'Bahçede: çiçekler yeni açmıştı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa1d768e-b7bd-4801-89ed-4bdb6747d437', 'O gün: eve oldukça geç geldi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7df43876-6e13-47b3-bff8-db27826a6dd8', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalı virgül (;) doğru kullanılmıştır?', 'Noktalı virgülün virgüllerle ayrılmış öğe gruplarını ayırma işlevini uygular.', 'Birinci cümlede virgüllerle ayrılmış iki farklı kişi grubu (''Ali, Veli, Ayşe'' ve ''Mehmet, Fatma'') noktalı virgülle birbirinden ayrılmıştır. Diğer cümlelerde noktalı virgül gereksiz yere, herhangi bir öğe grubunu ayırmadan kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df43876-6e13-47b3-bff8-db27826a6dd8', 'Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df43876-6e13-47b3-bff8-db27826a6dd8', 'Bu kitabı; okuyup çok beğendim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df43876-6e13-47b3-bff8-db27826a6dd8', 'Yarın; erkenden okula gideceğim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df43876-6e13-47b3-bff8-db27826a6dd8', 'Akşam; ailecek yemek yedik.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b5a8e1c8-8c5c-49ff-839a-445c8fb994f3', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin tamamı doğru kullanılmıştır?', 'Birden fazla noktalama kuralını bir arada değerlendirerek doğru cümleyi seçer.', 'İkinci cümlede iki nokta, kendisinden sonra gelen alıntı sözden önce doğru biçimde kullanılmış, tırnak içindeki alıntı da doğru noktalanmıştır. Diğer cümlelerde noktalı virgül gereksiz yere kullanılmış ya da ''masadaki'' kelimesine yanlışlıkla kesme işareti eklenmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5a8e1c8-8c5c-49ff-839a-445c8fb994f3', 'Ahmet''e, İstanbul''dan gelen; mektubu hemen verdim.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5a8e1c8-8c5c-49ff-839a-445c8fb994f3', 'Öğretmenimiz: ''Yarın sınav var.'' dedi.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5a8e1c8-8c5c-49ff-839a-445c8fb994f3', 'Masada''ki kitapları, düzenle dedi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5a8e1c8-8c5c-49ff-839a-445c8fb994f3', 'Çarşıya gidip; elma, armut aldım.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('8caf048a-ea8c-4fdf-963f-2f2181586d99', 'Gerçek, mecaz, yan ve terim anlam ile eş anlam, zıt anlam, sesteşlik ve deyimlerin cümle içindeki kullanımını örneklerle işleyen sözcükte anlam konusu.', '## Gerçek (Temel) Anlam ve Mecaz Anlam
Bir kelimenin ilk akla gelen, sözlükteki asıl anlamına gerçek (temel) anlam denir: ''Bu çanta çok ağırdı.'' Kelimenin benzetme yoluyla kazandığı, gerçek anlamından uzaklaşmış anlamına ise mecaz anlam denir: ''Sınav soruları oldukça ağırdı.'' (zor anlamında)

## Yan Anlam ve Terim Anlam
Bir kelimenin temel anlamıyla ilgili fakat ondan biraz uzaklaşmış anlamına yan anlam denir: ''Masanın ayağı kırıldı.'' Bir bilim, sanat veya meslek dalına özgü kavramı karşılayan anlama ise terim anlam denir: ''Bu cümlenin öznesini bulun.'' veya ''Kelimenin kökünü belirleyin.''

## Eş Anlam (Anlamdaş) ve Zıt Anlam (Karşıt)
Yazılışları farklı, anlamları aynı veya çok yakın olan kelimelere eş anlamlı (anlamdaş) denir: ''kara-siyah, misafir-konuk.'' Birbirinin karşıtı olan kelimelere ise zıt anlamlı (karşıt) denir: ''büyük-küçük, sıcak-soğuk.''

## Eş Sesli (Sesteş) Kelimeler
Yazılışları aynı, anlamları farklı kelimelere sesteş (eş sesli) denir: ''Yüzünde bir gülümseme vardı.'' (yüz=çehre) ile ''Denizde saatlerce yüzdü.'' (yüz=yüzmek eylemi) cümlelerindeki ''yüz'' kelimeleri sesteştir.

## Deyimler
İki veya daha fazla kelimeden oluşan, çoğunlukla mecazlı anlam taşıyan kalıplaşmış söz gruplarına deyim denir: ''eli kulağında'' (bir işin bitmesine az kalmış olması), ''içi kararmak'' (çok üzülmek). Deyimler, cümle içinde kalıplaşmış anlamlarıyla ve bu anlama uygun bağlamda kullanılmalıdır; anlamına ters düşen bir bağlamda kullanılması anlatım bozukluğuna yol açar.', '''Eli kulağında'' deyimi aşağıdaki cümlelerin hangisinde doğru kullanılmıştır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2ad5f2eb-0b4f-4fea-b211-0b081e93e0a5', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''ağır'' sözcüğü mecaz anlamda kullanılmıştır?', 'Gerçek anlam ile mecaz anlamı ayırt eder.', 'İkinci cümlede ''ağır'' sözcüğü fiziksel bir ağırlığı değil, ''zor, çetin'' anlamını karşıladığı için mecaz anlamda kullanılmıştır. Diğer cümlelerde ''ağır'' sözcüğü nesnenin gerçek fiziksel ağırlığını belirtir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ad5f2eb-0b4f-4fea-b211-0b081e93e0a5', 'Bu çanta gerçekten çok ağırdı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ad5f2eb-0b4f-4fea-b211-0b081e93e0a5', 'Sınav soruları oldukça ağırdı.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ad5f2eb-0b4f-4fea-b211-0b081e93e0a5', 'Valizi taşırken sırtım ağrıdı, çünkü çok ağırdı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2ad5f2eb-0b4f-4fea-b211-0b081e93e0a5', 'Demir, ağır bir madendir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('161a1da2-0330-4116-a7d7-315ea6eed761', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'kolay'::difficulty_level, 'Aşağıdaki kelime çiftlerinden hangisi eş anlamlıdır (anlamdaştır)?', 'Eş anlamlı (anlamdaş) kelimeleri tanır.', '''Kara'' ve ''siyah'' kelimeleri aynı rengi karşıladığı için eş anlamlıdır. Diğer seçeneklerdeki kelime çiftleri ise birbirinin zıt anlamlısıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('161a1da2-0330-4116-a7d7-315ea6eed761', 'kara - siyah', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('161a1da2-0330-4116-a7d7-315ea6eed761', 'büyük - küçük', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('161a1da2-0330-4116-a7d7-315ea6eed761', 'sıcak - soğuk', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('161a1da2-0330-4116-a7d7-315ea6eed761', 'ışık - karanlık', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('982bcdd9-9c54-40b3-9415-d966749d290c', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'orta'::difficulty_level, '''Eli kulağında'' deyimi aşağıdaki cümlelerin hangisinde doğru kullanılmıştır?', 'Deyimlerin cümle içindeki uygun kullanımını değerlendirir.', '''Eli kulağında'' deyimi bir işin bitmesine çok az kaldığını anlatır; birinci cümlede projenin yakında tamamlanacağı belirtildiği için deyim doğru bağlamda kullanılmıştır. Diğer cümlelerde deyimin anlamıyla cümlenin geri kalanı çelişmektedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('982bcdd9-9c54-40b3-9415-d966749d290c', 'Proje eli kulağında, birkaç güne kadar tamamlanmış olacak.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('982bcdd9-9c54-40b3-9415-d966749d290c', 'Bu iş eli kulağında, çünkü daha yeni başladık.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('982bcdd9-9c54-40b3-9415-d966749d290c', 'O her zaman eli kulağında biriydi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('982bcdd9-9c54-40b3-9415-d966749d290c', 'Param eli kulağında bittiği için borç almak zorunda kaldım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('54498058-1b7f-45d6-abd5-cc268a53f13c', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''yüz'' sözcüğü diğerlerinden farklı bir anlamda (sesteş olarak) kullanılmıştır?', 'Sesteş (eş sesli) kelimeleri cümle bağlamında ayırt eder.', 'İkinci cümlede ''yüzdü'', ''yüzmek'' eyleminden gelir ve suda hareket etmeyi ifade eder; diğer cümlelerdeki ''yüz'' ise ''çehre, surat'' anlamındaki isimdir. Yazılışları aynı fakat anlamları farklı olduğu için bu kelimeler sesteştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54498058-1b7f-45d6-abd5-cc268a53f13c', 'Yüzünde güzel bir gülümseme vardı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54498058-1b7f-45d6-abd5-cc268a53f13c', 'Denizde saatlerce yüzdü.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54498058-1b7f-45d6-abd5-cc268a53f13c', 'Yüzü hafif kızarmıştı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54498058-1b7f-45d6-abd5-cc268a53f13c', 'Onun yüzüne bakamadım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('812bc2b4-ef0b-4b7a-8c59-77901f8ffa2a', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'zor'::difficulty_level, '''Kök'' sözcüğü aşağıdaki cümlelerin hangisinde terim anlamda (dil bilgisi terimi olarak) kullanılmıştır?', 'Terim anlamı gerçek ve mecaz anlamdan ayırt eder.', 'İkinci cümlede ''kök'', bir kelimenin anlam taşıyan en küçük parçasını belirten dil bilgisi terimi olarak kullanılmıştır. Diğer cümlelerde ''kök'' sözcüğü sırasıyla gerçek anlamda (bitki kökü) ve mecaz anlamda (kaynak, köken) kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('812bc2b4-ef0b-4b7a-8c59-77901f8ffa2a', 'Bahçedeki ağacın kökü çok derinlere inmişti.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('812bc2b4-ef0b-4b7a-8c59-77901f8ffa2a', 'Bu kelimenin kökü Arapçadır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('812bc2b4-ef0b-4b7a-8c59-77901f8ffa2a', 'Sorunun kökünü araştırmalıyız.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('812bc2b4-ef0b-4b7a-8c59-77901f8ffa2a', 'Bu ailenin kökleri çok eskiye dayanıyor.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('377a645a-e795-4ac7-826e-79daf8b0f71e', 'Anlatım bozukluğu türlerini (gereksiz sözcük, çelişki, mantık hatası, tamlama yanlışlığı), öznel-nesnel yargı ayrımını ve cümle tamamlamayı örneklerle açıklayan konu.', '## Anlatım Bozukluğu Türleri
Anlatım bozukluğu, bir cümlede anlam veya dil bilgisi açısından ortaya çıkan hatalardır. Başlıca türleri:
- **Gereksiz sözcük kullanımı:** Aynı anlama gelen iki kelimenin bir arada kullanılması. ''Bu haber beni hem çok sevindirdi hem de mutlu etti.'' (sevindirmek ve mutlu etmek eş anlamlıdır, biri gereksizdir.)
- **Çelişki:** Cümledeki iki ifadenin birbiriyle çelişmesi. ''Belki de bu sınavı kesinlikle kazanacak.'' (''belki'' ihtimal, ''kesinlikle'' kesinlik bildirir; bir arada kullanılamaz.)
- **Mantık (neden-sonuç) hatası:** Cümledeki neden ile sonucun birbiriyle uyuşmaması. ''Param olmadığı için kitabı alamadım ama yine de aldım.''
- **Tamlama yanlışlığı:** Ortak kullanılan bir öğeye ait ekin eksik bırakılması. ''Ali ve babasının arabası kaza yaptı.'' cümlesinde ''Ali'' kelimesinden sonra ''-nin'' tamlayan eki eksiktir; doğrusu ''Ali''nin ve babasının arabası'' olmalıdır.

## Öznel Yargı ve Nesnel Yargı
Nesnel yargı, kişiden kişiye değişmeyen, kanıtlanabilir, gözlemlenebilir bilgi içeren yargıdır: ''Roman 320 sayfadan oluşmaktadır.'' Öznel yargı ise kişisel görüş, beğeni ya da yorum içerir ve kişiden kişiye değişebilir: ''Bence bu roman çok sıkıcıydı.'' ''En, en güzel, bence, bana göre, sanırım'' gibi ifadeler genellikle öznelliğin işaretidir.

## Cümle Tamamlama
Bir cümlenin ya da paragrafın bağlamına en uygun ifadeyi seçmek, cümledeki anlam bütünlüğünü ve mantıksal akışı bozmayan seçeneği bulmayı gerektirir. Doğru seçenek, metinde verilen bilgilerle çelişmemeli ve konu dışına çıkmamalıdır.', '''Belki de bu sınavı kesinlikle kazanacak.'' cümlesindeki anlatım bozukluğunun türünü belirtiniz.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ab6d174b-e810-4b5d-b7b3-4cc100766326', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisi nesnel bir yargı bildirmektedir?', 'Öznel yargı ile nesnel yargıyı ayırt eder.', 'Birinci cümlede sayfa sayısı, kişiden kişiye değişmeyen, kanıtlanabilir bir bilgi olduğu için nesneldir. Diğer cümleler kişisel görüş ve beğeni içerdiğinden özneldir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab6d174b-e810-4b5d-b7b3-4cc100766326', 'Roman, 320 sayfadan oluşmaktadır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab6d174b-e810-4b5d-b7b3-4cc100766326', 'Bence bu roman çok sıkıcıydı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab6d174b-e810-4b5d-b7b3-4cc100766326', 'Yazarın en başarılı eseri budur.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab6d174b-e810-4b5d-b7b3-4cc100766326', 'Bu film gelmiş geçmiş en iyi yapımdı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('94296b35-d5af-461a-98c6-15f8ecaa752b', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Gereksiz sözcük kullanımından kaynaklanan anlatım bozukluğunu fark eder.', '''Sevindirmek'' ve ''mutlu etmek'' aynı anlama geldiği için bu iki ifadenin bir arada kullanılması gereksiz tekrara, dolayısıyla anlatım bozukluğuna yol açmıştır. Diğer cümlelerde böyle bir tekrar yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('94296b35-d5af-461a-98c6-15f8ecaa752b', 'Bu haber beni hem çok sevindirdi hem de mutlu etti.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('94296b35-d5af-461a-98c6-15f8ecaa752b', 'Öğrenciler sınava iyi hazırlandı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('94296b35-d5af-461a-98c6-15f8ecaa752b', 'Kitabı okuyup arkadaşına anlattı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('94296b35-d5af-461a-98c6-15f8ecaa752b', 'Yağmur yağınca sokaklar ıslandı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('eea65aff-a620-4a3f-acf2-c570e1815617', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Çelişkiden kaynaklanan anlatım bozukluğunu tespit eder.', '''Belki'' ihtimal, ''kesinlikle'' ise kesinlik bildirir; bu iki ifade anlamca birbiriyle çeliştiği için cümlede anlatım bozukluğu vardır. Diğer cümlelerde böyle bir çelişki bulunmamaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eea65aff-a620-4a3f-acf2-c570e1815617', 'Belki de bu sınavı kesinlikle kazanacak.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eea65aff-a620-4a3f-acf2-c570e1815617', 'Öğretmen konuyu tekrar anlattı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eea65aff-a620-4a3f-acf2-c570e1815617', 'Sabah erkenden yola çıktık.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eea65aff-a620-4a3f-acf2-c570e1815617', 'Kitapları düzenli bir şekilde raflara yerleştirdi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e70793d4-3d68-45d8-8e23-b3d68b72e120', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Neden-sonuç ilişkisindeki mantık hatasını fark eder.', 'Cümlede önce parası olmadığı için kitabı alamadığı söylenmiş, ardından yine de aldığı belirtilerek çelişkili bir mantık hatası oluşturulmuştur. Diğer cümlelerde neden ile sonuç arasında tutarlı bir ilişki vardır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e70793d4-3d68-45d8-8e23-b3d68b72e120', 'Param olmadığı için kitabı alamadım ama yine de aldım.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e70793d4-3d68-45d8-8e23-b3d68b72e120', 'Erken kalktığım için derse zamanında yetiştim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e70793d4-3d68-45d8-8e23-b3d68b72e120', 'Yorgun olduğu için erken yattı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e70793d4-3d68-45d8-8e23-b3d68b72e120', 'Kitabı bitirince bana geri verdi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6c268cc4-b57b-4d88-b011-e981c0256843', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Tamlama yanlışlığından kaynaklanan anlatım bozukluğunu ileri düzeyde tespit eder.', '''Ali'' kelimesinden sonra tamlayan eki ''-nin'' eksik bırakıldığı için cümlede tamlama yanlışlığı vardır; doğrusu ''Ali''nin ve babasının arabası'' biçiminde olmalıdır. Diğer cümlelerde böyle bir ek eksikliği yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6c268cc4-b57b-4d88-b011-e981c0256843', 'Ali ve babasının arabası kaza yaptı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6c268cc4-b57b-4d88-b011-e981c0256843', 'Ali''nin ve babasının arabası kaza yaptı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6c268cc4-b57b-4d88-b011-e981c0256843', 'Öğrenciler sınıfa girdi ve yerlerine oturdu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6c268cc4-b57b-4d88-b011-e981c0256843', 'Yağmur dinince hep birlikte dışarı çıktık.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('71faddb6-6b16-4792-b9d7-e0da4afedaff', 'Paragrafta ana düşünce ve yardımcı düşünceyi ayırt etme, paragraf tamamlama ve metinden çıkarılabilecek/çıkarılamayacak yargıları belirleme becerilerini işleyen konu.', '## Konu ve Ana Düşünce
Bir paragrafın neyle ilgili olduğunu belirten kavrama konu denir; yazarın bu konu hakkında okura iletmek istediği asıl mesaja ise ana düşünce denir. Ana düşünce genellikle paragrafın son cümlesinde, bazen de ilk cümlesinde yer alır ve paragraftaki tüm cümleleri kapsayan bir yargı niteliğindedir.

## Yardımcı Düşünce
Ana düşünceyi destekleyen, açıklayan veya örnekleyen düşüncelere yardımcı düşünce denir. Bir paragrafta birden fazla yardımcı düşünce bulunabilir, ancak ana düşünce tektir.

## Paragraf Tamamlama
Paragrafın başına, ortasına ya da sonuna getirilecek cümle; paragrafın anlam bütünlüğünü, konu akışını ve mantık örgüsünü bozmamalıdır. Başa gelecek cümle genellikle konuyu tanıtır; sona gelecek cümle ise paragrafta anlatılanların bir sonucu, genellemesi ya da tamamlayıcısı niteliğinde olmalıdır. Doğru seçenek metindeki bilgilerle çelişmemeli ve konu dışına çıkmamalıdır.

## Metinden Çıkarılabilecek Yargılar
''Bu parçadan hangi yargıya ulaşılabilir/ulaşılamaz'' tipi sorularda, seçeneklerin metinde açıkça ifade edilen ya da metinden mantıksal olarak çıkarılabilen bilgilerle örtüşüp örtüşmediğine bakılır. Metinde yer almayan, aşırı genelleme içeren ya da metinle çelişen seçenekler yanlıştır.

## Anlatım Biçimleri
Paragraflarda yazarın öznel ya da nesnel bir bakış açısıyla yazıp yazmadığı; örnekleme, tanık gösterme, karşılaştırma gibi düşünceyi geliştirme yollarının kullanılıp kullanılmadığı da sıkça sorulur.', 'Aşağıdaki paragrafın ana düşüncesi ne olabilir? ''Kitap okumak, insanın hayal gücünü geliştirir, kelime dağarcığını zenginleştirir...''');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f85e3edd-9942-4ff1-9bfd-6f480619bfcf', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'kolay'::difficulty_level, '''İnsanlar günlük hayatlarında birçok karar verir. Bu kararların bazıları küçük, bazıları ise hayatı derinden etkileyecek kadar büyüktür. Küçük kararlar genellikle anlık düşünülüp hızla alınırken büyük kararlar için uzun süre düşünülür, çevredeki insanların fikirleri alınır. Çünkü büyük kararların sonuçları, kişinin hayatını uzun yıllar etkileyebilir.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?', 'Paragrafın ana düşüncesini belirler.', 'Parça, büyük kararların uzun süre düşünülerek ve başkalarının görüşü alınarak verilmesi gerektiğini, çünkü sonuçlarının kalıcı olduğunu vurgulamaktadır. Diğer seçenekler ya parçanın yalnızca bir kısmını yansıtır ya da metinde yer almayan aşırı bir genelleme içerir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f85e3edd-9942-4ff1-9bfd-6f480619bfcf', 'İnsanlar hayatları boyunca sürekli karar alma durumundadır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f85e3edd-9942-4ff1-9bfd-6f480619bfcf', 'Büyük kararlar, sonuçlarının kalıcı etkisi nedeniyle daha dikkatli ve uzun düşünülerek alınmalıdır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f85e3edd-9942-4ff1-9bfd-6f480619bfcf', 'Küçük kararlar hızlı alındığı için önemsizdir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f85e3edd-9942-4ff1-9bfd-6f480619bfcf', 'Çevredeki insanların fikirleri her zaman doğru kararlar verdirir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('58a877f9-6dae-433c-a325-970c7f12a300', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'kolay'::difficulty_level, '''Kitap okumak, insanın hayal gücünü geliştirir, kelime dağarcığını zenginleştirir ve empati kurma becerisini artırır. Ayrıca düzenli kitap okuyan bireylerin analitik düşünme yetenekleri de gelişir. Bu nedenle ______'' Bu parçada boş bırakılan yere aşağıdakilerden hangisi getirilmelidir?', 'Paragrafın anlam akışına uygun tamamlama cümlesini seçer.', 'Parçada kitap okumanın sağladığı faydalar sıralandığı için mantıksal sonuç, bu alışkanlığın erken yaşta kazandırılması gerektiğidir. Diğer seçenekler parçanın konusuyla ilgisizdir ya da metinde değinilmeyen konulara değinir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58a877f9-6dae-433c-a325-970c7f12a300', 'televizyon izlemek de kitap okumak kadar faydalıdır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58a877f9-6dae-433c-a325-970c7f12a300', 'çocuklara küçük yaştan itibaren kitap okuma alışkanlığı kazandırılmalıdır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58a877f9-6dae-433c-a325-970c7f12a300', 'kitap okumanın hiçbir zararı yoktur.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58a877f9-6dae-433c-a325-970c7f12a300', 'herkesin aynı türde kitap okuması gerekir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('80bc5dea-dd4c-442c-aa9f-3f89bd87d612', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'orta'::difficulty_level, '''Şehirlerin hızla büyümesiyle birlikte yeşil alanlar giderek azalmaktadır. Betonlaşan kentlerde hava kalitesi düşmekte, sıcaklık artışları daha belirgin hissedilmektedir. Bununla birlikte bazı belediyeler, çatı bahçeleri ve dikey ormanlar gibi projelerle bu soruna çözüm aramaktadır. Ancak bu çabalar, kaybedilen yeşil alanların yerini tam olarak dolduramamaktadır.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?', 'Paragrafta ana düşünce ile yardımcı düşünceleri ayırt eder.', 'Parça, kentleşmeyle azalan yeşil alanlar için belediyelerin çözüm aradığını ama bu çabaların yeterli olmadığını vurgulamaktadır. Diğer seçenekler metinle çelişir ya da metinde yapılmayan bir karşılaştırma veya aşırı genelleme içerir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('80bc5dea-dd4c-442c-aa9f-3f89bd87d612', 'Belediyeler çevre sorunlarına duyarsız kalmaktadır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('80bc5dea-dd4c-442c-aa9f-3f89bd87d612', 'Kentleşmeyle azalan yeşil alanların yerini, alınan önlemler yeterince dolduramamaktadır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('80bc5dea-dd4c-442c-aa9f-3f89bd87d612', 'Çatı bahçeleri, dikey ormanlardan daha etkilidir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('80bc5dea-dd4c-442c-aa9f-3f89bd87d612', 'Hava kalitesi yalnızca sıcaklıkla ilgilidir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f7db822d-8e4b-4786-81c3-29889cd2f72c', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'orta'::difficulty_level, '''______ Bu tür kitaplar, karmaşık bilimsel kavramları sade bir dille anlatarak okurun ilgisini çeker. Yazar, günlük hayattan örnekler kullanarak konuyu somutlaştırır. Böylece bilim, sadece uzmanların değil herkesin anlayabileceği bir alan hâline gelir.'' Bu parçanın başına aşağıdaki cümlelerden hangisi getirilmelidir?', 'Paragrafın başına gelecek en uygun giriş cümlesini belirler.', 'Parçanın devamında ''bu tür kitaplar'' ifadesiyle atıf yapılan konu, ancak popüler bilim kitaplarını tanıtan birinci seçenekle uyumludur. Diğer seçenekler parçanın konusuyla ilgisizdir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f7db822d-8e4b-4786-81c3-29889cd2f72c', 'Popüler bilim kitapları, bilimi geniş kitlelere ulaştırmayı amaçlayan eserlerdir.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f7db822d-8e4b-4786-81c3-29889cd2f72c', 'Bilim insanları genellikle yalnız çalışmayı tercih eder.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f7db822d-8e4b-4786-81c3-29889cd2f72c', 'Roman yazarları hayal gücünü kullanarak eser üretir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f7db822d-8e4b-4786-81c3-29889cd2f72c', 'Her kitap mutlaka bir amaç taşımalıdır.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a72bc452-cd6f-4047-862a-01c46f6c4c0d', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'zor'::difficulty_level, '''Bir sanat eserinin değeri, yalnızca teknik ustalıkla ölçülemez. Tuval üzerine ustaca işlenmiş bir tablo, izleyicide hiçbir duygu uyandırmıyorsa amacına ulaşamamış demektir. Oysa bazen çok basit çizgilerle oluşturulmuş bir eser, izleyicisini derinden etkileyebilir, onu düşünmeye sevk edebilir. Bu nedenle sanatı değerlendirirken teknik beceri kadar, eserin izleyicide bıraktığı etkiye de bakmak gerekir.'' Bu parçadan aşağıdaki yargılardan hangisine ulaşılamaz?', 'Paragraftan çıkarılabilecek ve çıkarılamayacak yargıları ayırt eder.', 'Parçada sanatçının ününden hiç söz edilmediği için dördüncü seçenekteki yargıya metinden ulaşılamaz. Diğer seçenekler parçada doğrudan ya da dolaylı olarak ifade edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a72bc452-cd6f-4047-862a-01c46f6c4c0d', 'Teknik açıdan kusursuz bir eser, izleyicide duygu uyandırmayabilir.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a72bc452-cd6f-4047-862a-01c46f6c4c0d', 'Basit görünen eserler de izleyici üzerinde güçlü bir etki bırakabilir.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a72bc452-cd6f-4047-862a-01c46f6c4c0d', 'Bir sanat eserini değerlendirirken hem teknik beceri hem de duygusal etki göz önünde bulundurulmalıdır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a72bc452-cd6f-4047-862a-01c46f6c4c0d', 'Sanat eserlerinin değeri, yalnızca sanatçının ününe göre belirlenir.', true, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('23739e5f-698c-4748-930d-42e77e92d16d', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'kolay'::difficulty_level, '"Gitti + i" birleşiminde olduğu gibi düz-dar bir ünlüyle biten fiil kök/gövdesine "-yor" eki geldiğinde hangi ses olayı görülür?', 'Ünlü daralmasını fark eder.', '"Bekle-" gibi geniş ünlüyle (e, a) biten fiillere "-yor" eki geldiğinde son hecedeki geniş ünlü daralarak "i, ı, u, ü"ye dönüşür: bekle-yor → bekliyor. Bu olaya ünlü daralması denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23739e5f-698c-4748-930d-42e77e92d16d', 'bekliyor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23739e5f-698c-4748-930d-42e77e92d16d', 'geliyor', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23739e5f-698c-4748-930d-42e77e92d16d', 'biliyor', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23739e5f-698c-4748-930d-42e77e92d16d', 'gidiyor', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('979b4d86-bc2f-48f2-b953-ef09493337b4', '2d6bd953-efd9-4148-9a05-af0124ee9484', 'orta'::difficulty_level, '"Kitap+cı" birleşiminde görüldüğü gibi, sert ünsüzle biten bir kelimeye yumuşak ünsüzle başlayan bir ek geldiğinde ekin ünsüzünün sertleşmesine ne ad verilir?', 'Ünsüz benzeşmesi (sertleşme) kuralını tanır.', '"Fıstıkçı şahap" sözündeki sert ünsüzlerden (ç, f, h, k, p, s, ş, t) biriyle biten bir kelimeye "c, d, g" gibi yumuşak bir ünsüzle başlayan ek gelirse, ekin ünsüzü sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta. Bu ses olayına ünsüz benzeşmesi (sertleşmesi) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979b4d86-bc2f-48f2-b953-ef09493337b4', 'Ünsüz benzeşmesi (sertleşme)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979b4d86-bc2f-48f2-b953-ef09493337b4', 'Ünsüz yumuşaması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979b4d86-bc2f-48f2-b953-ef09493337b4', 'Ünlü düşmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979b4d86-bc2f-48f2-b953-ef09493337b4', 'Kaynaştırma', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('05699ea3-edfe-4e09-a06e-d5668ecba02c', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harflerin kullanımıyla ilgili bir yazım yanlışı vardır?', 'Özel isimlerde büyük harf kullanımını uygular.', 'Ay ve mevsim adları özel isim olmadığı için büyük harfle başlamaz; "Mayıs" değil "mayıs" yazılmalıdır. Diğer seçeneklerde büyük harf kullanımı kurallara uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05699ea3-edfe-4e09-a06e-d5668ecba02c', 'Okullar Mayıs ayında tatile girecek.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05699ea3-edfe-4e09-a06e-d5668ecba02c', 'Ahmet Bey toplantıya geç kaldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05699ea3-edfe-4e09-a06e-d5668ecba02c', 'Türkiye Cumhuriyeti 1923''te kuruldu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05699ea3-edfe-4e09-a06e-d5668ecba02c', 'Anadolu''nun ortasında küçük bir köy vardı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7efe31b6-e269-444a-b135-20ed5d4c8567', 'c2c62223-74f3-441e-8b2d-f74bd3d7ef0a', 'orta'::difficulty_level, '"de/da" bağlacının yazımıyla ilgili aşağıdaki cümlelerin hangisinde bir yazım yanlışı yapılmıştır?', 'Bağlaç "de/da" ile bulunma hâli ekini ayırt eder.', '"Bu da" cümlesinde "da" bir bağlaç olup ayrı yazılmalıdır: "O da geldi." "Odada" örneğinde ise "-da" bulunma hâli eki olduğu için bitişik yazılır. "Sende" örneğinde "-de" bulunma eki olduğundan bitişik doğru bir kullanımdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efe31b6-e269-444a-b135-20ed5d4c8567', 'Ali de bize katıldı ama o da geç kaldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efe31b6-e269-444a-b135-20ed5d4c8567', 'Kitap masadaydı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efe31b6-e269-444a-b135-20ed5d4c8567', 'Sende kalsın bu anahtar.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efe31b6-e269-444a-b135-20ed5d4c8567', 'O da bizimle gelecek.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b11f40a6-cbed-411a-82d0-e3a0378feb13', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmamıştır?', 'Kesme işaretinin özel isimlerde ve eklerde kullanımını uygular.', 'Kurum, kuruluş ve kısaltmalara gelen ekler kesme işaretiyle ayrılmaz: "TBMM''de" değil, kısaltmalar zaten büyük harfle yazıldığından ek kesmeyle ayrılır — asıl yanlış "Türkiye''nin" gibi doğru kullanımların yanında "okulun" gibi cins isimlere kesme eklenmesidir; "Okul''un bahçesi" yanlıştır çünkü "okul" özel isim değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b11f40a6-cbed-411a-82d0-e3a0378feb13', 'Okul''un bahçesi çok güzeldi.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b11f40a6-cbed-411a-82d0-e3a0378feb13', 'Ankara''ya yarın gideceğiz.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b11f40a6-cbed-411a-82d0-e3a0378feb13', 'TBMM''de önemli bir görüşme yapıldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b11f40a6-cbed-411a-82d0-e3a0378feb13', 'Atatürk''ün ilkeleri hâlâ geçerlidir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b4924763-8bf4-493d-a72b-a75e44d884b6', 'f09bf2d1-ea3a-4341-b668-bdfe7d87ca44', 'orta'::difficulty_level, '"Kardeşim  gel buraya  dedi." cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri gelmelidir?', 'Doğrudan aktarılan cümlelerde noktalama işaretlerini doğru kullanır.', 'Doğrudan aktarılan (tırnak içine alınan) cümleden önce iki nokta, aktarılan cümlenin sonunda ise tırnak içinde uygun noktalama kullanılır: Kardeşim: "Gel buraya." dedi.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4924763-8bf4-493d-a72b-a75e44d884b6', ': " ... ."', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4924763-8bf4-493d-a72b-a75e44d884b6', ', " ... "', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4924763-8bf4-493d-a72b-a75e44d884b6', '; " ... "', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b4924763-8bf4-493d-a72b-a75e44d884b6', '... " ... "', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cbe27297-4418-4ff2-867d-de52852a25da', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'kolay'::difficulty_level, '"Yüreği dağ gibi" ifadesindeki "dağ" sözcüğü hangi anlamda kullanılmıştır?', 'Mecaz anlamı gerçek anlamdan ayırt eder.', '"Dağ" sözcüğü burada gerçek anlamından (yeryüzü şekli) uzaklaşarak "büyük, cesur" anlamında mecaz olarak kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cbe27297-4418-4ff2-867d-de52852a25da', 'Mecaz anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cbe27297-4418-4ff2-867d-de52852a25da', 'Gerçek anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cbe27297-4418-4ff2-867d-de52852a25da', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cbe27297-4418-4ff2-867d-de52852a25da', 'Yan anlam', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('601c7b71-cd2f-40d2-9819-13f8c94e9871', '8caf048a-ea8c-4fdf-963f-2f2181586d99', 'orta'::difficulty_level, '"Bu kumaşın ''eli'' çok yumuşak." cümlesindeki altı çizili sözcük hangi anlam ilişkisiyle kullanılmıştır?', 'Yan anlamı ayırt eder.', '"El" sözcüğü asıl anlamıyla (vücut organı) değil, kumaşın dokusunu/tuşesini belirtmek için "yan anlam" olarak kullanılmıştır; sözcüğün gerçek anlamıyla bağlantısı hâlâ hissedilir, bu da onu mecazdan ayırır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601c7b71-cd2f-40d2-9819-13f8c94e9871', 'Yan anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601c7b71-cd2f-40d2-9819-13f8c94e9871', 'Mecaz anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601c7b71-cd2f-40d2-9819-13f8c94e9871', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601c7b71-cd2f-40d2-9819-13f8c94e9871', 'Gerçek anlam', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5057aa7a-6f51-4590-b05d-24be4ca15c68', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'kolay'::difficulty_level, '"Yağmur yağarsa pikniğe gitmeyeceğiz." cümlesi anlamca hangi tür bir cümledir?', 'Koşul (şart) anlamı taşıyan cümleleri tanır.', 'Cümlede "-arsa/-erse" koşul ekiyle kurulmuş bir şart cümlesi vardır; bir eylemin gerçekleşmesi başka bir duruma bağlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5057aa7a-6f51-4590-b05d-24be4ca15c68', 'Koşul (şart) cümlesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5057aa7a-6f51-4590-b05d-24be4ca15c68', 'Amaç cümlesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5057aa7a-6f51-4590-b05d-24be4ca15c68', 'Sebep-sonuç cümlesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5057aa7a-6f51-4590-b05d-24be4ca15c68', 'Karşılaştırma cümlesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dbf4ccc1-88fb-49de-af6e-455130ec7a38', '377a645a-e795-4ac7-826e-79daf8b0f71e', 'orta'::difficulty_level, '"Herkes onun başarılı olacağını biliyordu, o da bunu biliyordu ama yine de denemekten korkuyordu." cümlesinde hangi anlam ilişkisi vardır?', 'Karşıtlık (zıtlık) anlamı taşıyan cümleleri çözümler.', '"Ama" bağlacı ile cümlede beklenenin aksine bir durum (bilmesine rağmen korkma) anlatılmıştır; bu da karşıtlık/zıtlık ilişkisini gösterir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dbf4ccc1-88fb-49de-af6e-455130ec7a38', 'Karşıtlık ilişkisi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dbf4ccc1-88fb-49de-af6e-455130ec7a38', 'Neden-sonuç ilişkisi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dbf4ccc1-88fb-49de-af6e-455130ec7a38', 'Amaç-sonuç ilişkisi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dbf4ccc1-88fb-49de-af6e-455130ec7a38', 'Koşul ilişkisi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('378cd5b7-65a1-4ea7-afff-ba9cb68ae3fb', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'orta'::difficulty_level, 'Bir paragrafın giriş cümlesi genellikle hangi özelliği taşır?', 'Paragrafın giriş cümlesinin işlevini bilir.', 'Giriş cümlesi, paragrafın konusunu ortaya koyar ve okuyucuyu paragrafın devamına hazırlar; genellikle kendinden önceki bir bağlama ihtiyaç duymadan anlaşılabilir, bağlaçla başlamaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('378cd5b7-65a1-4ea7-afff-ba9cb68ae3fb', 'Paragrafın konusunu tanıtır ve tek başına anlaşılır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('378cd5b7-65a1-4ea7-afff-ba9cb68ae3fb', 'Mutlaka bir örnekle başlar.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('378cd5b7-65a1-4ea7-afff-ba9cb68ae3fb', 'Bağlaçla başlar ve önceki paragrafa bağlıdır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('378cd5b7-65a1-4ea7-afff-ba9cb68ae3fb', 'Yalnızca yazarın kişisel görüşünü içerir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c98568c7-d8bc-45a1-a35c-8b901dac041f', '71faddb6-6b16-4792-b9d7-e0da4afedaff', 'zor'::difficulty_level, '"Bu görüşe katılmıyorum. Çünkü..." ifadesiyle başlayan bir paragraf parçası, paragrafın hangi bölümünde yer alamaz?', 'Paragrafın bölümlerini (giriş-gelişme-sonuç) ayırt eder.', '"Bu görüşe katılmıyorum" ifadesi önceki bir görüşe atıfta bulunduğu için bağlama ihtiyaç duyar; bu nedenle paragrafın kendi başına anlaşılması gereken giriş (ilk) cümlesi olamaz, gelişme ya da sonuç bölümünde yer alabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c98568c7-d8bc-45a1-a35c-8b901dac041f', 'Giriş (ilk cümle)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c98568c7-d8bc-45a1-a35c-8b901dac041f', 'Gelişme bölümü', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c98568c7-d8bc-45a1-a35c-8b901dac041f', 'Sonuç bölümü', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c98568c7-d8bc-45a1-a35c-8b901dac041f', 'Paragrafın ortası', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('968c2720-b43d-4e5a-bf38-c8eeaeecfadd', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'kolay'::difficulty_level, '18 − (6 − 2) × 3 işleminin sonucu kaçtır?', 'İşlem önceliğini karmaşık ifadelerde uygular.', 'Önce parantez içi işlem yapılır: 6 − 2 = 4. Sonra çarpma yapılır: 4 × 3 = 12. Son olarak çıkarma yapılır: 18 − 12 = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968c2720-b43d-4e5a-bf38-c8eeaeecfadd', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968c2720-b43d-4e5a-bf38-c8eeaeecfadd', '12', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968c2720-b43d-4e5a-bf38-c8eeaeecfadd', '18', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968c2720-b43d-4e5a-bf38-c8eeaeecfadd', '4', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('afeb25b0-e0c2-425d-a5dd-136200ba2fe5', 'd5e7d6ba-9273-45f0-b054-e629e31debb3', 'orta'::difficulty_level, 'Bir sayının 4 katının 7 fazlası, aynı sayının 2 katının 19 fazlasına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip çözer.', '4x + 7 = 2x + 19 → 4x − 2x = 19 − 7 → 2x = 12 → x = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afeb25b0-e0c2-425d-a5dd-136200ba2fe5', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afeb25b0-e0c2-425d-a5dd-136200ba2fe5', '4', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afeb25b0-e0c2-425d-a5dd-136200ba2fe5', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afeb25b0-e0c2-425d-a5dd-136200ba2fe5', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('968e425d-7f97-4274-a186-bee6929840ff', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'kolay'::difficulty_level, '648 sayısı aşağıdaki sayılardan hangisine tam bölünmez?', 'Bölünebilme kurallarını uygular.', '648 sayısının rakamları toplamı 6+4+8=18 olup 9''a bölünür, dolayısıyla 648, 9''a tam bölünür. Ancak 648, 5''e bölünmez çünkü son rakamı 0 veya 5 değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968e425d-7f97-4274-a186-bee6929840ff', '5', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968e425d-7f97-4274-a186-bee6929840ff', '2', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968e425d-7f97-4274-a186-bee6929840ff', '3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('968e425d-7f97-4274-a186-bee6929840ff', '9', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e9e5cf00-656f-4f8d-bf80-deb5962bfed6', 'a49df68d-898b-4fc9-8588-8376bf5fc243', 'orta'::difficulty_level, '48 ile 60 sayılarının OBEB''i (en büyük ortak böleni) kaçtır?', 'OBEB hesaplama becerisini uygular.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük üsleri alınır: 2²×3 = 12. OBEB = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9e5cf00-656f-4f8d-bf80-deb5962bfed6', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9e5cf00-656f-4f8d-bf80-deb5962bfed6', '6', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9e5cf00-656f-4f8d-bf80-deb5962bfed6', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9e5cf00-656f-4f8d-bf80-deb5962bfed6', '4', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('27b1de84-6a38-4903-a158-942732bce09e', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'kolay'::difficulty_level, 'Üç basamaklı "7a5" sayısı 9''a tam bölünebildiğine göre a rakamı kaç olabilir?', 'Basamak değeri ile bölünebilme kurallarını birlikte kullanır.', '9''a bölünebilme için rakamlar toplamının 9''a bölünmesi gerekir: 7+a+5 = 12+a. 12+a değerinin 9''a bölünmesi için a=6 olmalıdır (12+6=18).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('27b1de84-6a38-4903-a158-942732bce09e', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('27b1de84-6a38-4903-a158-942732bce09e', '3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('27b1de84-6a38-4903-a158-942732bce09e', '9', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('27b1de84-6a38-4903-a158-942732bce09e', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('92bd22a5-86c2-473e-b32f-21a509cfe2ea', 'f0049e53-57c1-444f-ae91-1095c74619c5', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 11''dir. Rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 45 fazladır. Buna göre ilk sayı kaçtır?', 'Basamak değeri problemlerini denklem kurarak çözer.', 'Sayı 10a+b, rakamları toplamı a+b=11. Yer değiştirmiş hâli 10b+a olup (10b+a)-(10a+b)=45 → 9(b-a)=45 → b-a=5. a+b=11 ve b-a=5 denklemlerinden b=8, a=3 bulunur. İlk sayı 38''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92bd22a5-86c2-473e-b32f-21a509cfe2ea', '38', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92bd22a5-86c2-473e-b32f-21a509cfe2ea', '29', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92bd22a5-86c2-473e-b32f-21a509cfe2ea', '47', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92bd22a5-86c2-473e-b32f-21a509cfe2ea', '56', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dcbe4b2b-498e-401c-be33-e1f09a633409', '1967a34a-00a7-4c4d-858c-3892d3444962', 'kolay'::difficulty_level, '3/4 + 1/6 işleminin sonucu kaçtır?', 'Rasyonel sayılarla toplama işlemi yapar.', 'Paydalar eşitlenir (OKEK=12): 3/4=9/12, 1/6=2/12. Toplam: 9/12+2/12=11/12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcbe4b2b-498e-401c-be33-e1f09a633409', '11/12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcbe4b2b-498e-401c-be33-e1f09a633409', '4/10', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcbe4b2b-498e-401c-be33-e1f09a633409', '5/6', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcbe4b2b-498e-401c-be33-e1f09a633409', '7/12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c9eb6ed1-c8a0-4651-aa44-ad13471b6946', '1967a34a-00a7-4c4d-858c-3892d3444962', 'orta'::difficulty_level, '(2/3) ÷ (4/9) işleminin sonucu kaçtır?', 'Rasyonel sayılarla bölme işlemi yapar.', 'Bölme işleminde ikinci kesirin tersiyle çarpılır: (2/3) × (9/4) = 18/12 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9eb6ed1-c8a0-4651-aa44-ad13471b6946', '3/2', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9eb6ed1-c8a0-4651-aa44-ad13471b6946', '8/27', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9eb6ed1-c8a0-4651-aa44-ad13471b6946', '2/3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9eb6ed1-c8a0-4651-aa44-ad13471b6946', '9/8', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6edea09e-75fb-45b8-a83c-c3e8f5782e80', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'orta'::difficulty_level, 'Bir havuzu bir musluk tek başına 6 saatte, başka bir musluk tek başına 3 saatte doldurabiliyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerini oran-orantı ile çözer.', 'Birinci musluk saatte havuzun 1/6''sını, ikinci musluk 1/3''ünü doldurur. Birlikte: 1/6+1/3=1/6+2/6=3/6=1/2. Havuzun yarısı 1 saatte dolduğuna göre tamamı 2 saatte dolar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6edea09e-75fb-45b8-a83c-c3e8f5782e80', '2 saat', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6edea09e-75fb-45b8-a83c-c3e8f5782e80', '3 saat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6edea09e-75fb-45b8-a83c-c3e8f5782e80', '4,5 saat', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6edea09e-75fb-45b8-a83c-c3e8f5782e80', '1,5 saat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ada891f4-0cd3-4316-be06-570af5e2f53d', '17f97465-ab68-42f7-abac-bce58e6b7d2d', 'zor'::difficulty_level, 'Ali''nin yaşı, kardeşinin yaşının 2 katından 3 fazladır. İki kardeşin yaşları toplamı 30 olduğuna göre Ali kaç yaşındadır?', 'Yaş problemlerini denklem kurarak çözer.', 'Kardeşin yaşı x, Ali''nin yaşı 2x+3 olsun. x + 2x + 3 = 30 → 3x = 27 → x = 9. Ali''nin yaşı = 2(9)+3 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ada891f4-0cd3-4316-be06-570af5e2f53d', '21', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ada891f4-0cd3-4316-be06-570af5e2f53d', '18', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ada891f4-0cd3-4316-be06-570af5e2f53d', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ada891f4-0cd3-4316-be06-570af5e2f53d', '19', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ebf1ff27-bb6c-4c5a-9080-9ea1a8526a6a', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'kolay'::difficulty_level, 'İlk Türk devletlerinde "kurultay" adı verilen meclisin temel işlevi nedir?', 'İlk Türk devletlerindeki yönetim yapılarını bilir.', 'Kurultay, devlet işlerinin (savaş, barış, hukuk vb.) görüşülüp karara bağlandığı, hakan başkanlığında toplanan danışma meclisidir; Türklerde ilk demokratik yönetim uygulamalarından biri sayılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebf1ff27-bb6c-4c5a-9080-9ea1a8526a6a', 'Devlet işlerinin görüşülüp karara bağlandığı meclis olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebf1ff27-bb6c-4c5a-9080-9ea1a8526a6a', 'Sadece dini törenlerin yapıldığı yer olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebf1ff27-bb6c-4c5a-9080-9ea1a8526a6a', 'Yalnızca ticaretin düzenlendiği kurum olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebf1ff27-bb6c-4c5a-9080-9ea1a8526a6a', 'Ordunun eğitim aldığı okul olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dc199d42-aa0d-44f9-82d6-eb6ad57c5f11', '5deadcc9-6e6e-42c5-840e-6cd3b65d3880', 'orta'::difficulty_level, 'Orhun Abideleri (Göktürk Kitabeleri) tarih açısından neden önemlidir?', 'Yazılı ilk Türkçe kaynakların önemini kavrar.', 'Orhun Abideleri, Türk adının geçtiği ve Türkçenin bilinen ilk yazılı metinlerini içeren, Göktürk Devleti dönemine ait tarihî kaynaklardır; bu yönüyle Türk tarihi ve dili için birinci elden bir belgedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc199d42-aa0d-44f9-82d6-eb6ad57c5f11', 'Türk adının geçtiği bilinen ilk yazılı Türkçe metinler olmaları', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc199d42-aa0d-44f9-82d6-eb6ad57c5f11', 'İslamiyet''in kabulünü anlatmaları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc199d42-aa0d-44f9-82d6-eb6ad57c5f11', 'Osmanlı dönemine ait olmaları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc199d42-aa0d-44f9-82d6-eb6ad57c5f11', 'Sadece ticaret anlaşmalarını içermeleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('542d1241-1e9a-40de-8811-d33c3d20e61f', 'b606fed8-a975-40b5-8825-c55b080bee38', 'kolay'::difficulty_level, 'Osmanlı Devleti''nde "İskân Politikası" hangi amaçla uygulanmıştır?', 'Osmanlı''nın kuruluş dönemi fetih ve yerleşim politikalarını bilir.', 'İskân politikası, fethedilen yerlere Anadolu''dan Türkmen aileler yerleştirilerek buraların Türkleştirilmesi ve devlet otoritesinin kalıcı hâle getirilmesi amacıyla uygulanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('542d1241-1e9a-40de-8811-d33c3d20e61f', 'Fethedilen bölgeleri Türkleştirmek ve otoriteyi kalıcı kılmak', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('542d1241-1e9a-40de-8811-d33c3d20e61f', 'Sadece vergi gelirlerini artırmak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('542d1241-1e9a-40de-8811-d33c3d20e61f', 'Ordunun beslenmesini kolaylaştırmak', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('542d1241-1e9a-40de-8811-d33c3d20e61f', 'Yalnızca göçebe hayatı özendirmek', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dea8952b-457a-4d70-881a-e291e3e3db4f', 'b606fed8-a975-40b5-8825-c55b080bee38', 'orta'::difficulty_level, 'I. Kosova Savaşı''nın (1389) sonuçlarından biri aşağıdakilerden hangisidir?', 'Osmanlı''nın Balkanlardaki fetihlerinin sonuçlarını bilir.', 'I. Kosova Savaşı sonucunda Sırp Krallığı Osmanlı''ya bağlı bir vasal (tabi) devlet hâline gelmiş, Osmanlı''nın Balkanlardaki hâkimiyeti pekişmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dea8952b-457a-4d70-881a-e291e3e3db4f', 'Sırbistan''ın Osmanlı''ya bağlı bir devlet hâline gelmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dea8952b-457a-4d70-881a-e291e3e3db4f', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dea8952b-457a-4d70-881a-e291e3e3db4f', 'Anadolu Türk birliğinin sağlanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dea8952b-457a-4d70-881a-e291e3e3db4f', 'Osmanlı Devleti''nin yıkılması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bb3b7c36-ae37-443d-9df5-4dab4d7f74ea', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'kolay'::difficulty_level, 'Kurtuluş Savaşı''nda "Kongreler Dönemi" hangi cepheyle ilgilidir?', 'Kurtuluş Savaşı sürecindeki siyasi örgütlenme aşamalarını bilir.', 'Kongreler Dönemi (Erzurum ve Sivas Kongreleri gibi) askerî değil siyasi/örgütlenme sürecidir; millî iradenin ortaya konması ve Millî Mücadele''nin teşkilatlandırılması amaçlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3b7c36-ae37-443d-9df5-4dab4d7f74ea', 'Siyasi cephe (örgütlenme süreci)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3b7c36-ae37-443d-9df5-4dab4d7f74ea', 'Doğu Cephesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3b7c36-ae37-443d-9df5-4dab4d7f74ea', 'Güney Cephesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3b7c36-ae37-443d-9df5-4dab4d7f74ea', 'Batı Cephesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fe2817f7-fca2-487f-ad70-b1411e39e102', '9b86c24d-60ba-42ab-9cf5-9fd561f3fc42', 'orta'::difficulty_level, 'Sakarya Meydan Muharebesi''nin en önemli sonucu aşağıdakilerden hangisidir?', 'Kurtuluş Savaşı''ndaki dönüm noktası muharebeleri ve sonuçlarını bilir.', 'Sakarya Meydan Muharebesi''nin kazanılmasıyla Türk ordusu taarruz gücüne sahip olduğunu göstermiş, Mustafa Kemal''e TBMM tarafından "Gazilik" unvanı ve "Mareşallik" rütbesi verilmiştir; savaşın gidişatı Türk lehine dönmüştür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fe2817f7-fca2-487f-ad70-b1411e39e102', 'Savaşın gidişatının Türk lehine dönmesi ve Mustafa Kemal''e Mareşallik unvanının verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fe2817f7-fca2-487f-ad70-b1411e39e102', 'İstanbul''un işgalden kurtarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fe2817f7-fca2-487f-ad70-b1411e39e102', 'Lozan Antlaşması''nın imzalanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fe2817f7-fca2-487f-ad70-b1411e39e102', 'Saltanatın kaldırılması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ba2c1bde-5e82-4a94-9c99-72e21cbaa802', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Atatürk''ün "halkçılık" ilkesiyle doğrudan ilişkilidir?', 'Atatürk ilkelerini örneklerle ilişkilendirir.', 'Halkçılık ilkesi, kanun önünde herkesin eşit olmasını ve egemenliğin kayıtsız şartsız millete ait olmasını öngörür; bu ilkeyle doğrudan ilişkili uygulama sınıf/zümre ayrıcalıklarının kaldırılmasıdır (soyadı kanunu, saltanatın kaldırılması gibi eşitlikçi düzenlemeler).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ba2c1bde-5e82-4a94-9c99-72e21cbaa802', 'Saltanatın kaldırılarak egemenliğin millete verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ba2c1bde-5e82-4a94-9c99-72e21cbaa802', 'Kabotaj Kanunu''nun çıkarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ba2c1bde-5e82-4a94-9c99-72e21cbaa802', 'Tevhid-i Tedrisat Kanunu''nun çıkarılması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ba2c1bde-5e82-4a94-9c99-72e21cbaa802', 'Yeni Türk harflerinin kabulü', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('66820737-0a94-4ca6-b732-16a07a7e426a', '07b62d62-6c36-4cb7-9d0f-2278147c87c8', 'orta'::difficulty_level, '1926''da kabul edilen Türk Medeni Kanunu ile aşağıdakilerden hangisi sağlanmıştır?', 'Hukuk alanındaki inkılapların sonuçlarını bilir.', 'Türk Medeni Kanunu ile tek eşlilik esası getirilmiş, kadın-erkek eşitliği hukuki olarak güçlendirilmiş (miras, boşanma, şahitlik gibi haklarda) ve laik hukuk düzenine geçiş tamamlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66820737-0a94-4ca6-b732-16a07a7e426a', 'Kadın-erkek eşitliğinin hukuki güvenceye kavuşturulması ve tek eşliliğin getirilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66820737-0a94-4ca6-b732-16a07a7e426a', 'Çok eşliliğin yasal hâle getirilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66820737-0a94-4ca6-b732-16a07a7e426a', 'Şeriat mahkemelerinin güçlendirilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66820737-0a94-4ca6-b732-16a07a7e426a', 'Yalnızca ticaret hukukunun düzenlenmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ff72ace0-6815-4dc4-b91f-48e14044ca08', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'kolay'::difficulty_level, 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Matematik konumun sonuçlarını yorumlar.', 'Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer aldığından yerel saat farkı doğu-batı yönünde değişir; matematik konum, saat farkları, mevsimlerin yaşanışı ve gün uzunluğu değişimi gibi sonuçlar doğurur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff72ace0-6815-4dc4-b91f-48e14044ca08', 'Doğuda güneş daha erken doğar, batıda daha geç doğar.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff72ace0-6815-4dc4-b91f-48e14044ca08', 'Dört mevsim tam olarak aynı sürede yaşanır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff72ace0-6815-4dc4-b91f-48e14044ca08', 'İklim çeşitliliği yalnızca özel konumla açıklanır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff72ace0-6815-4dc4-b91f-48e14044ca08', 'Komşu ülke sayısı matematik konumun sonucudur.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a4911ec5-99d9-4327-806f-80511d547a92', 'f7e381ec-4cc3-48b0-93e8-74fee8611c8d', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin özel (coğrafi) konumunun sonuçlarından biridir?', 'Özel konumun matematik konumdan farkını ve sonuçlarını ayırt eder.', 'Özel konum; komşularla ilişkiler, ulaşım, ticaret yolları üzerinde bulunma, jeopolitik önem gibi beşerî-ekonomik sonuçları kapsar. Üç tarafının denizlerle çevrili olması ve önemli boğazlara sahip olması, Türkiye''yi transit ticaret açısından önemli kılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4911ec5-99d9-4327-806f-80511d547a92', 'Önemli boğazlara sahip olması nedeniyle transit ticarette avantajlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4911ec5-99d9-4327-806f-80511d547a92', 'Yerel saat farkının bulunması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4911ec5-99d9-4327-806f-80511d547a92', 'Güneş ışınlarının açısının mevsime göre değişmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4911ec5-99d9-4327-806f-80511d547a92', 'Gece-gündüz sürelerinin mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1849b93e-94af-4f7d-9b80-c498b64d675f', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'kolay'::difficulty_level, 'Karadeniz Bölgesi''nde görülen iklim tipinin en belirgin özelliği nedir?', 'Türkiye''deki iklim tiplerinin özelliklerini bilir.', 'Karadeniz iklimi, her mevsim yağışlı olması ve yıllık yağış miktarının fazla olmasıyla karakterizedir; yazlar diğer bölgelere göre serin, kışlar ise ılıman geçer.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1849b93e-94af-4f7d-9b80-c498b64d675f', 'Her mevsim yağışlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1849b93e-94af-4f7d-9b80-c498b64d675f', 'Yazların çok kurak geçmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1849b93e-94af-4f7d-9b80-c498b64d675f', 'Kışların en sert şekilde yaşanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1849b93e-94af-4f7d-9b80-c498b64d675f', 'Yıl boyunca yağış görülmemesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c0ba3a0f-5bd8-4965-bfee-322389c4954d', '37bc8f16-37a4-4503-a71d-d05f63b59d2c', 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde karasal iklimin görülmesinin temel nedeni aşağıdakilerden hangisidir?', 'İklim tiplerinin oluşumunda etkili coğrafi faktörleri açıklar.', 'İç Anadolu, kıyıdan uzak ve dağlarla çevrili bir konumda olduğundan nemli deniz havasından yeterince yararlanamaz; bu nedenle yazları sıcak ve kurak, kışları soğuk ve kar yağışlı karasal iklim görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0ba3a0f-5bd8-4965-bfee-322389c4954d', 'Denizden uzak ve dağlarla çevrili bir konumda bulunması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0ba3a0f-5bd8-4965-bfee-322389c4954d', 'Deniz seviyesine çok yakın olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0ba3a0f-5bd8-4965-bfee-322389c4954d', 'Yıl boyunca nemli hava kütlelerinin etkisinde kalması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0ba3a0f-5bd8-4965-bfee-322389c4954d', 'Ekvatora çok yakın bir enlemde bulunması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7bc07d67-e194-4bda-83f8-2accd91f7a92', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'kolay'::difficulty_level, 'Türkiye''de nüfusun kıyı bölgelerde iç kesimlere göre daha yoğun olmasının temel nedeni aşağıdakilerden hangisidir?', 'Nüfus dağılışını etkileyen doğal ve beşerî faktörleri açıklar.', 'Kıyı bölgelerde iklim koşullarının daha elverişli olması, tarım, sanayi ve ticaret imkânlarının fazlalığı ile ulaşım kolaylığı nüfusun bu bölgelerde yoğunlaşmasına neden olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7bc07d67-e194-4bda-83f8-2accd91f7a92', 'İklim ve ekonomik imkânların daha elverişli olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7bc07d67-e194-4bda-83f8-2accd91f7a92', 'Yükseltinin fazla olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7bc07d67-e194-4bda-83f8-2accd91f7a92', 'Tarım alanlarının kıyıda hiç bulunmaması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7bc07d67-e194-4bda-83f8-2accd91f7a92', 'Deprem riskinin kıyıda daha az olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('56a99b9e-0693-4faa-bb30-d8a38285fbf1', 'c12a56f5-ebe1-406d-b5b5-c0a458d9dad2', 'orta'::difficulty_level, 'Bir bölgede engebeli arazi yapısı, nüfus yoğunluğunu genellikle nasıl etkiler?', 'Yer şekillerinin nüfus dağılışına etkisini yorumlar.', 'Engebeli/dağlık araziler tarım, sanayi ve ulaşım açısından elverişsiz olduğundan bu tür bölgelerde yerleşme ve nüfus yoğunluğu düşük olma eğilimindedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56a99b9e-0693-4faa-bb30-d8a38285fbf1', 'Nüfus yoğunluğunu azaltır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56a99b9e-0693-4faa-bb30-d8a38285fbf1', 'Nüfus yoğunluğunu artırır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56a99b9e-0693-4faa-bb30-d8a38285fbf1', 'Nüfus dağılışını hiç etkilemez.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56a99b9e-0693-4faa-bb30-d8a38285fbf1', 'Yalnızca kentleşmeyi hızlandırır.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('75664ad3-07cf-444d-8497-a4a937dddfcb', '36e2daaa-064f-4b75-b465-d649577b4a15', 'kolay'::difficulty_level, 'Yazılı olmayan, toplumda uzun süre uygulanarak yerleşmiş kurallara ne ad verilir?', 'Hukukun kaynaklarını (yazılı-yazısız) ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan ancak toplum tarafından benimsenip uzun süre uygulanan kurallardan oluşur ve hukukun yazısız kaynaklarından biridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75664ad3-07cf-444d-8497-a4a937dddfcb', 'Örf ve adet hukuku', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75664ad3-07cf-444d-8497-a4a937dddfcb', 'Anayasa', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75664ad3-07cf-444d-8497-a4a937dddfcb', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('75664ad3-07cf-444d-8497-a4a937dddfcb', 'Tüzük', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4a90bb99-cb17-4b32-bec3-1a8006ea3e41', '36e2daaa-064f-4b75-b465-d649577b4a15', 'orta'::difficulty_level, 'Bir hukuk kuralına uyulmadığında devlet gücüyle uygulanan yaptırıma ne ad verilir?', 'Hukuk kurallarının yaptırım unsurunu tanır.', 'Yaptırım (müeyyide), bir hukuk kuralına uyulmaması durumunda devletin zor kullanma gücüyle uyguladığı sonuçtur (ceza, tazminat vb.) ve hukuk kurallarını ahlaki/dini kurallardan ayıran temel özelliktir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a90bb99-cb17-4b32-bec3-1a8006ea3e41', 'Yaptırım (müeyyide)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a90bb99-cb17-4b32-bec3-1a8006ea3e41', 'Örf', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a90bb99-cb17-4b32-bec3-1a8006ea3e41', 'Teamül', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a90bb99-cb17-4b32-bec3-1a8006ea3e41', 'Doktrin', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('23d7f825-7899-4534-8c52-4a1392dce865', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'kolay'::difficulty_level, '1982 Anayasası''na göre egemenlik kayıtsız şartsız kime aittir?', 'Anayasa''nın temel ilkelerinden egemenlik kavramını bilir.', '1982 Anayasası''nın 6. maddesine göre egemenlik, kayıtsız şartsız Türk Milletine aittir; millet bu yetkisini yetkili organlar eliyle kullanır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23d7f825-7899-4534-8c52-4a1392dce865', 'Türk Milletine', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23d7f825-7899-4534-8c52-4a1392dce865', 'TBMM''ye', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23d7f825-7899-4534-8c52-4a1392dce865', 'Cumhurbaşkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('23d7f825-7899-4534-8c52-4a1392dce865', 'Anayasa Mahkemesine', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1cfe3b26-4786-49d1-a1a0-ffb47efe94aa', 'f887b0f6-c0ab-468e-b053-8c335bd02151', 'orta'::difficulty_level, 'Anayasa değişikliği teklifi TBMM''de en az kaç üyenin yazılı teklifiyle yapılabilir?', 'Anayasa değişikliği usulünü bilir.', 'Anayasanın değiştirilmesi, TBMM üye tam sayısının en az üçte biri tarafından yazılı olarak teklif edilebilir (600 üyeli Meclis''te bu sayı 200''dür).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cfe3b26-4786-49d1-a1a0-ffb47efe94aa', 'Üye tam sayısının en az üçte biri', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cfe3b26-4786-49d1-a1a0-ffb47efe94aa', 'Üye tam sayısının salt çoğunluğu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cfe3b26-4786-49d1-a1a0-ffb47efe94aa', 'Üye tam sayısının tamamı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cfe3b26-4786-49d1-a1a0-ffb47efe94aa', 'Sadece hükümet üyeleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('35130a80-cd97-4c35-9c54-0ebc6630ede7', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) devletin hangi temel organını oluşturur?', 'Kuvvetler ayrılığı ilkesindeki organları ayırt eder.', 'TBMM, kanun yapma, değiştirme ve kaldırma yetkisine sahip olduğu için yasama organını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35130a80-cd97-4c35-9c54-0ebc6630ede7', 'Yasama', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35130a80-cd97-4c35-9c54-0ebc6630ede7', 'Yürütme', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35130a80-cd97-4c35-9c54-0ebc6630ede7', 'Yargı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35130a80-cd97-4c35-9c54-0ebc6630ede7', 'Denetleme', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('abfc2c1d-8beb-4d0c-b695-963c74076048', '7fa65b30-e84d-4576-a785-fbe8a75f6e8a', 'orta'::difficulty_level, 'Türkiye''de yargı bağımsızlığı ilkesi temel olarak neyi ifade eder?', 'Yargı organının işleyiş ilkelerini bilir.', 'Yargı bağımsızlığı, mahkemelerin hiçbir organ, makam veya kişinin emir ve talimatı olmaksızın, yalnızca Anayasa''ya, kanuna ve hukuka uygun olarak vicdani kanaatlerine göre karar vermesini ifade eder.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abfc2c1d-8beb-4d0c-b695-963c74076048', 'Mahkemelerin hiçbir etki altında kalmadan bağımsız karar vermesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abfc2c1d-8beb-4d0c-b695-963c74076048', 'Yargı kararlarının yürütme tarafından onaylanması gerekliliği', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abfc2c1d-8beb-4d0c-b695-963c74076048', 'Hâkimlerin yasama organına bağlı çalışması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abfc2c1d-8beb-4d0c-b695-963c74076048', 'Mahkeme kararlarının Cumhurbaşkanı onayına tabi olması', false, 3);

-- ===================== kpss_ortaogretim =====================
insert into subjects (id, exam_type, name, slug, icon, color, weight, order_index) values
  ('d71bac66-45c4-4334-b6cb-aa98737aedf7', 'kpss_ortaogretim', 'Türkçe', 'turkce', '📖', '#6366f1', 1.2, 1),
  ('db73b28e-af04-4ee8-ab60-d9644366709f', 'kpss_ortaogretim', 'Matematik', 'matematik', '🔢', '#7c3aed', 1.1, 2),
  ('2a7517b3-32f7-441e-a474-99295e45e0d3', 'kpss_ortaogretim', 'Tarih', 'tarih', '🏛️', '#dc2626', 1.0, 3),
  ('4667014a-235d-46a7-8e68-650682394b42', 'kpss_ortaogretim', 'Coğrafya', 'cografya', '🌍', '#059669', 0.9, 4),
  ('c728b4c1-770d-491b-8559-6202dc1d67c7', 'kpss_ortaogretim', 'Vatandaşlık', 'vatandaslik', '⚖️', '#d97706', 0.9, 5);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Ses Bilgisi', 'ses-bilgisi', 'Türkçedeki ses olaylarını (ünlü/ünsüz uyumu, kaynaştırma) tanır ve uygular.', 1.0, 1),
  ('8884d23b-b21f-4a37-b931-8de0e0921942', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Yazım Kuralları', 'yazim-kurallari', 'Yazım (imla) kurallarını doğru uygular.', 1.1, 2),
  ('e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Noktalama İşaretleri', 'noktalama-isaretleri', 'Noktalama işaretlerinin işlevlerini bilir ve doğru kullanır.', 0.9, 3),
  ('7ec4f569-8e17-456f-b938-c05e33b7a53c', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Sözcükte Anlam', 'sozcukte-anlam', 'Sözcüklerin gerçek, mecaz, terim anlamlarını ayırt eder.', 1.0, 4),
  ('f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Cümlede Anlam', 'cumlede-anlam', 'Cümle içi anlam ilişkilerini (öznel-nesnel, koşul, amaç vb.) çözümler.', 1.1, 5),
  ('e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'd71bac66-45c4-4334-b6cb-aa98737aedf7', 'Paragraf', 'paragraf', 'Paragrafta ana düşünce, yardımcı düşünce, anlatım tekniklerini belirler.', 1.3, 6);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('7b7b290d-42c3-49b5-afe5-8994c54c8946', 'db73b28e-af04-4ee8-ab60-d9644366709f', 'Temel Kavramlar', 'temel-kavramlar', 'Sayı kümelerini ve temel işlem özelliklerini bilir.', 1.0, 1),
  ('f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'db73b28e-af04-4ee8-ab60-d9644366709f', 'Bölme ve Bölünebilme', 'bolme-bolunebilme', 'Bölünebilme kurallarını ve OBEB-OKEK''i uygular.', 1.0, 2),
  ('c3dddc6e-eea4-4706-a157-f67f4325984b', 'db73b28e-af04-4ee8-ab60-d9644366709f', 'Sayı Basamakları', 'sayi-basamaklari', 'Basamak değeri ve rakam kavramlarıyla ilgili problemleri çözer.', 0.9, 3),
  ('171c474e-c3bd-409e-852a-b1bd4bf6606b', 'db73b28e-af04-4ee8-ab60-d9644366709f', 'Rasyonel Sayılar', 'rasyonel-sayilar', 'Rasyonel sayılarla dört işlem yapar.', 1.0, 4),
  ('3bbd5f38-934b-4418-9af9-543e84b4f23e', 'db73b28e-af04-4ee8-ab60-d9644366709f', 'Problemler', 'problemler', 'Hareket, yaş, yüzde-kâr-zarar, işçi-havuz problemlerini çözer.', 1.4, 5);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('d54e692f-8d6b-4be3-bc8e-55c53b88f1db', '2a7517b3-32f7-441e-a474-99295e45e0d3', 'İlk Türk Devletleri', 'ilk-turk-devletleri', 'İslamiyet öncesi Türk devletlerinin siyasi ve sosyal yapısını bilir.', 1.0, 1),
  ('394c0e59-d739-45ae-8c1e-1529ae7d63e7', '2a7517b3-32f7-441e-a474-99295e45e0d3', 'Osmanlı Kuruluş Dönemi', 'osmanli-kurulus', 'Osmanlı Devleti''nin kuruluş ve yükseliş dönemi olaylarını sıralar.', 1.1, 2),
  ('7640798b-40ed-4450-8685-63853ff9609e', '2a7517b3-32f7-441e-a474-99295e45e0d3', 'Kurtuluş Savaşı', 'kurtulus-savasi', 'Milli Mücadele''nin cepheleri ve önemli olaylarını bilir.', 1.3, 3),
  ('6b451e80-fb9b-420c-a0cc-4954a3b713bc', '2a7517b3-32f7-441e-a474-99295e45e0d3', 'İnkılap Tarihi', 'inkilap-tarihi', 'Atatürk İlke ve İnkılaplarını açıklar.', 1.2, 4);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('9091f497-3f4f-481c-90a7-6ae19c1c1c45', '4667014a-235d-46a7-8e68-650682394b42', 'Türkiye''nin Yeri ve Konumu', 'turkiyenin-yeri-konumu', 'Türkiye''nin matematik ve özel konumunun sonuçlarını açıklar.', 1.0, 1),
  ('f1aab841-ba67-4a16-99fc-6f1afc8f1b63', '4667014a-235d-46a7-8e68-650682394b42', 'İklim', 'iklim', 'Türkiye''nin iklim tiplerini ve dağılımını bilir.', 1.0, 2),
  ('9667c94f-dd9b-468f-bf26-b192f8a3b1d0', '4667014a-235d-46a7-8e68-650682394b42', 'Nüfus ve Yerleşme', 'nufus-yerlesme', 'Türkiye''de nüfusun dağılışını etkileyen etmenleri açıklar.', 1.0, 3);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values
  ('a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'c728b4c1-770d-491b-8559-6202dc1d67c7', 'Temel Hukuk Kavramları', 'temel-hukuk-kavramlari', 'Hukuk kurallarının özelliklerini ve hukuk sistemini bilir.', 1.0, 1),
  ('7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'c728b4c1-770d-491b-8559-6202dc1d67c7', 'Anayasa', 'anayasa', '1982 Anayasası''nın temel ilke ve düzenlemelerini bilir.', 1.2, 2),
  ('5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'c728b4c1-770d-491b-8559-6202dc1d67c7', 'Yasama-Yürütme-Yargı', 'yasama-yurutme-yargi', 'Devletin temel organlarının görev ve işleyişini açıklar.', 1.1, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('7b7b290d-42c3-49b5-afe5-8994c54c8946', 'Doğal, tam ve rasyonel sayı kümelerini, dört işlemde işlem önceliğini ve sayıların sıralanmasını kapsayan temel konudur.', '## Doğal, Tam ve Rasyonel Sayılar
- **Doğal sayılar (N):** 0, 1, 2, 3, ... şeklinde devam eden, negatif olmayan sayılardır.
- **Tam sayılar (Z):** Doğal sayılar ve bunların negatifleridir: ..., -3, -2, -1, 0, 1, 2, 3, ...
- **Rasyonel sayılar (Q):** a/b şeklinde yazılabilen (b≠0) sayılardır; kesirler ve ondalık sayılar bu kümeye dahildir.

## Dört İşlem ve İşlem Önceliği
Bir işlemde sırasıyla uygulanır:
1. Parantez içi işlemler
2. Çarpma ve bölme (soldan sağa)
3. Toplama ve çıkarma (soldan sağa)

**Örnek:** 12 + 3 × 4 − 6 işlemini hesaplayalım.
Önce çarpma yapılır: 3 × 4 = 12
Sonra soldan sağa toplama/çıkarma: 12 + 12 − 6 = 18

## Negatif Sayılarla İşlem
- (+) × (+) = (+), (−) × (−) = (+), (+) × (−) = (−)
- Aynı işaret kuralı bölme için de geçerlidir.

**Örnek:** (−3) × (4 − 7) + (−2) × 5
= (−3) × (−3) + (−10)
= 9 − 10 = −1

## Sıralama (Karşılaştırma)
Sayı doğrusunda sağa gidildikçe sayılar büyür. Negatif sayılarda mutlak değeri büyük olan sayı küçüktür: −8 < −5 < −3 < 2.

## Sözel İfadeleri Denkleme Çevirme
Temel kavramlar konusunda birinci dereceden denklemler de sık sorulur.

**Örnek:** Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?
2(x+3) = 3(x−5)
2x + 6 = 3x − 15
21 = x

Bu tür sorularda dağılma özelliğinin doğru uygulanmasına ve terimlerin doğru taşınmasına dikkat edilmelidir.', '24 ÷ 4 + 3 × (5 − 2) işleminin sonucu kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('90b1a16f-8fa6-4098-90a0-6e522cb8a8a6', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'kolay'::difficulty_level, '12 + 3 × 4 − 6 işleminin sonucu kaçtır?', 'Dört işlemde işlem önceliğini doğru uygular.', 'Önce çarpma yapılır: 3 × 4 = 12. Sonra soldan sağa toplama ve çıkarma yapılır: 12 + 12 − 6 = 18.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90b1a16f-8fa6-4098-90a0-6e522cb8a8a6', '54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90b1a16f-8fa6-4098-90a0-6e522cb8a8a6', '18', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90b1a16f-8fa6-4098-90a0-6e522cb8a8a6', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90b1a16f-8fa6-4098-90a0-6e522cb8a8a6', '30', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('edaf2a20-142c-41c6-8aa3-dc7fd07f47b3', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'kolay'::difficulty_level, '-5, -8, -3, 2 tam sayılarından hangisi en küçüktür?', 'Tam sayıları büyüklük-küçüklük ilişkisine göre sıralar.', 'Negatif sayılarda mutlak değeri büyük olan sayı küçüktür. Sayı doğrusunda sıralama: −8 < −5 < −3 < 2 olduğundan en küçük sayı −8''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('edaf2a20-142c-41c6-8aa3-dc7fd07f47b3', '-5', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('edaf2a20-142c-41c6-8aa3-dc7fd07f47b3', '-8', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('edaf2a20-142c-41c6-8aa3-dc7fd07f47b3', '-3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('edaf2a20-142c-41c6-8aa3-dc7fd07f47b3', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8d28962f-0d17-446b-8c08-593b7eb0d973', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'orta'::difficulty_level, '(−3) × (4 − 7) + (−2) × 5 işleminin sonucu kaçtır?', 'Negatif sayılarla çarpma ve toplama işlemlerini yapar.', 'Önce parantez: 4 − 7 = −3. Sonra çarpmalar: (−3)×(−3) = 9 ve (−2)×5 = −10. Son olarak toplama: 9 + (−10) = −1.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8d28962f-0d17-446b-8c08-593b7eb0d973', '-19', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8d28962f-0d17-446b-8c08-593b7eb0d973', '-1', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8d28962f-0d17-446b-8c08-593b7eb0d973', '19', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8d28962f-0d17-446b-8c08-593b7eb0d973', '1', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('10c57530-7bfc-4314-bae7-cb3f10fa954c', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'orta'::difficulty_level, 'Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip birinci dereceden denklemi çözer.', '2(x+3) = 3(x−5) → 2x + 6 = 3x − 15 → 6 + 15 = 3x − 2x → x = 21. Kontrol: 2×(21+3)=48 ve 3×(21−5)=48, eşit olduğundan doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c57530-7bfc-4314-bae7-cb3f10fa954c', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c57530-7bfc-4314-bae7-cb3f10fa954c', '11', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c57530-7bfc-4314-bae7-cb3f10fa954c', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c57530-7bfc-4314-bae7-cb3f10fa954c', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('99feac8c-04ea-4b58-8e1a-5262116e7270', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'zor'::difficulty_level, 'Ali''nin yaşının 2 katının 5 fazlası, Ayşe''nin yaşının 3 katının 7 eksiğine eşittir. Ayşe 20 yaşında olduğuna göre Ali kaç yaşındadır?', 'Karmaşık sözel ifadelerden denklem kurup çözer.', 'Denklem: 2A + 5 = 3(20) − 7. Sağ taraf: 3×20−7 = 60−7 = 53. Buradan 2A + 5 = 53 → 2A = 48 → A = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('99feac8c-04ea-4b58-8e1a-5262116e7270', '17', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('99feac8c-04ea-4b58-8e1a-5262116e7270', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('99feac8c-04ea-4b58-8e1a-5262116e7270', '29', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('99feac8c-04ea-4b58-8e1a-5262116e7270', '48', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'Sayıların 2, 3, 4, 5, 6, 8, 9, 10, 11 ile bölünebilme kurallarını ve EBOB/EKOK hesaplamalarını kapsayan konudur.', '## Bölünebilme Kuralları
- **2 ile:** Son rakam 0, 2, 4, 6, 8 ise
- **3 ile:** Rakamlar toplamı 3''ün katı ise
- **4 ile:** Son iki basamak 00 veya 4''ün katı ise
- **5 ile:** Son rakam 0 veya 5 ise
- **6 ile:** Hem 2 hem 3 ile bölünüyorsa
- **8 ile:** Son üç basamak 000 veya 8''in katı ise
- **9 ile:** Rakamlar toplamı 9''un katı ise
- **10 ile:** Son rakam 0 ise
- **11 ile:** Tek ve çift sıradaki basamakların toplamları farkı 0 veya 11''in katı ise

**Örnek:** 342 sayısı 9 ile tam bölünür mü?
Rakamlar toplamı: 3+4+2=9, 9''un katı olduğundan 342, 9 ile tam bölünür (342÷9=38).

## EBOB (Ortak Bölen)
İki veya daha çok sayının ortak bölenlerinin en büyüğüdür. Sayılar asal çarpanlarına ayrılır, ortak olan asal çarpanların en küçük kuvvetleri çarpılır.

**Örnek:** 48 ve 60''ın EBOB''u
48 = 2⁴×3, 60 = 2²×3×5
Ortak asal çarpanlar: 2² ve 3 → EBOB = 2²×3 = 12

## EKOK (Ortak Kat)
İki veya daha çok sayının ortak katlarının en küçüğüdür. Tüm asal çarpanlar, ortak olanların en büyük kuvveti alınarak çarpılır.

**Örnek:** 48 ve 60''ın EKOK''u
EKOK = 2⁴×3×5 = 240

## Önemli Özellik
İki sayının EBOB''u ile EKOK''unun çarpımı, o iki sayının çarpımına eşittir:
EBOB(a,b) × EKOK(a,b) = a × b

Bu özellik, sayılardan biri bilinmediğinde diğerini bulmak için sıkça kullanılır.', '126 sayısı 9 ile tam bölünür mü? Rakamlar toplamını bularak açıklayınız.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c0d3af9b-eeb0-4a3b-801c-e2325211ce94', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 9 ile tam bölünür? 342, 245, 368, 451', 'Bölünebilme kurallarını kullanarak 9 ile bölünebilirliği tespit eder.', '342: 3+4+2=9 → 9''un katı, bölünür. 245: 2+4+5=11 → bölünmez. 368: 3+6+8=17 → bölünmez. 451: 4+5+1=10 → bölünmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0d3af9b-eeb0-4a3b-801c-e2325211ce94', '342', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0d3af9b-eeb0-4a3b-801c-e2325211ce94', '245', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0d3af9b-eeb0-4a3b-801c-e2325211ce94', '368', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0d3af9b-eeb0-4a3b-801c-e2325211ce94', '451', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f88c8959-aab6-4941-9f7a-378ad233e534', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 4 ile tam bölünür? 1234, 1416, 2350, 3115', '4 ile bölünebilme kuralını uygular.', 'Bir sayının 4 ile bölünmesi için son iki basamağının 4''ün katı olması gerekir. 1234''te son iki basamak 34 (bölünmez), 1416''da 16 (4''ün katı, bölünür), 2350''de 50 (bölünmez), 3115 tek sayı (bölünmez).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f88c8959-aab6-4941-9f7a-378ad233e534', '1234', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f88c8959-aab6-4941-9f7a-378ad233e534', '1416', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f88c8959-aab6-4941-9f7a-378ad233e534', '2350', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f88c8959-aab6-4941-9f7a-378ad233e534', '3115', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a2783f96-60d8-4fd8-bb4b-1697e37b8f76', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'orta'::difficulty_level, '48 ve 60 sayılarının EBOB''u kaçtır?', 'İki sayının EBOB''unu asal çarpanlarına ayırarak bulur.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük kuvvetleri: 2² ve 3. EBOB = 2²×3 = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2783f96-60d8-4fd8-bb4b-1697e37b8f76', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2783f96-60d8-4fd8-bb4b-1697e37b8f76', '240', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2783f96-60d8-4fd8-bb4b-1697e37b8f76', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2783f96-60d8-4fd8-bb4b-1697e37b8f76', '6', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a923fb16-91ca-4b77-a414-542f909e0740', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'orta'::difficulty_level, 'Bir sayı hem 6 hem de 8 ile tam bölünmektedir. Bu sayı en az kaç olabilir?', 'İki sayının EKOK''unu bulur.', 'İstenen en küçük sayı EKOK(6,8)''dir. 6=2×3, 8=2³. EKOK = 2³×3 = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a923fb16-91ca-4b77-a414-542f909e0740', '48', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a923fb16-91ca-4b77-a414-542f909e0740', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a923fb16-91ca-4b77-a414-542f909e0740', '2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a923fb16-91ca-4b77-a414-542f909e0740', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('68236e31-7998-4763-93c2-38c95889b99e', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'zor'::difficulty_level, 'EBOB''u 8, EKOK''u 240 olan iki sayıdan biri 40 olduğuna göre diğer sayı kaçtır?', 'EBOB ve EKOK arasındaki ilişkiyi kullanarak problem çözer.', 'EBOB × EKOK = sayıların çarpımı kuralından: 8 × 240 = 40 × diğer sayı → 1920 = 40 × diğer sayı → diğer sayı = 1920 ÷ 40 = 48.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('68236e31-7998-4763-93c2-38c95889b99e', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('68236e31-7998-4763-93c2-38c95889b99e', '48', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('68236e31-7998-4763-93c2-38c95889b99e', '200', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('68236e31-7998-4763-93c2-38c95889b99e', '1920', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('c3dddc6e-eea4-4706-a157-f67f4325984b', 'Basamak değeri, rakamların toplamı ve sayı oluşturma/yer değiştirme problemlerini kapsayan konudur.', '## Basamak ve Basamak Değeri
Bir sayıdaki her rakamın bulunduğu konuma göre bir basamak adı (birler, onlar, yüzler, binler...) ve bir de basamak değeri vardır.

**Basamak değeri** = rakam × bulunduğu basamağın değeri (1, 10, 100, 1000...)

**Örnek:** 347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri: 4×10=40

## Rakamların Toplamı
Bir sayının rakamları toplamı, sayıyı oluşturan tüm rakamların basit toplamıdır (basamak değeri değil, rakamın kendisi toplanır).

**Örnek:** 2856 sayısının rakamları toplamı: 2+8+5+6=21

## Sayı Oluşturma Problemleri
Bu tip sorularda en büyük, en küçük, rakamları farklı gibi ifadelere dikkat edilmelidir.
- En büyük rakamlar sayının en solunda (en yüksek basamakta) yer alır.
- Rakamları farklı en küçük iki basamaklı sayı 10''dur (ilk rakam 0 olamaz).

**Örnek:** Rakamları farklı iki basamaklı en büyük sayı ile en küçük sayının farkı: 98 − 10 = 88

## Basamakları Yer Değiştirme Problemleri
İki basamaklı bir sayı 10a+b şeklinde yazılır (a: onlar, b: birler basamağı). Rakamları yer değiştirdiğinde sayı 10b+a olur.
Fark: (10b+a) − (10a+b) = 9(b−a)

**Örnek:** Rakamları toplamı 12 olan bir sayının rakamları yer değiştirdiğinde sayı 18 artıyorsa:
a+b=12, 9(b−a)=18 → b−a=2
İki denklem birlikte çözülürse b=7, a=5 → sayı 57

Bu formül (basamak farkının 9 katı), basamak yer değiştirme problemlerinin çözümünde çok işe yarar.', '528 sayısında 5 rakamının basamak değeri kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e31a6fba-c4cd-4bcc-86f3-b6382129953a', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'kolay'::difficulty_level, '347 sayısında 4 rakamının basamak değeri kaçtır?', 'Bir rakamın basamak değerini hesaplar.', '347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri = rakam × basamağın değeri = 4×10 = 40.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e31a6fba-c4cd-4bcc-86f3-b6382129953a', '4', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e31a6fba-c4cd-4bcc-86f3-b6382129953a', '40', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e31a6fba-c4cd-4bcc-86f3-b6382129953a', '300', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e31a6fba-c4cd-4bcc-86f3-b6382129953a', '34', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('66cd891e-0ff3-4a16-af2f-0b5d042d6900', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'kolay'::difficulty_level, '2856 sayısının rakamları toplamı kaçtır?', 'Bir sayının rakamları toplamını bulur.', 'Rakamlar tek tek toplanır: 2+8+5+6 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66cd891e-0ff3-4a16-af2f-0b5d042d6900', '16', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66cd891e-0ff3-4a16-af2f-0b5d042d6900', '20', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66cd891e-0ff3-4a16-af2f-0b5d042d6900', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66cd891e-0ff3-4a16-af2f-0b5d042d6900', '22', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b5c15f5f-acd5-407b-8cf0-0326a698004d', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'orta'::difficulty_level, 'Üç basamaklı en büyük tek sayı ile üç basamaklı en küçük çift sayının toplamı kaçtır?', 'En büyük/en küçük sayı kavramlarını kullanarak işlem yapar.', 'Üç basamaklı en büyük tek sayı 999''dur. Üç basamaklı en küçük sayı 100 olup çift sayıdır. Toplam: 999 + 100 = 1099.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5c15f5f-acd5-407b-8cf0-0326a698004d', '1098', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5c15f5f-acd5-407b-8cf0-0326a698004d', '1099', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5c15f5f-acd5-407b-8cf0-0326a698004d', '1101', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b5c15f5f-acd5-407b-8cf0-0326a698004d', '1100', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('18853169-c0f8-4bbe-8fe0-431572cb838c', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'orta'::difficulty_level, 'Rakamları farklı olan iki basamaklı en büyük sayı ile rakamları farklı olan iki basamaklı en küçük sayının farkı kaçtır?', 'Rakamları farklı en büyük ve en küçük sayıları oluşturur.', 'Rakamları farklı iki basamaklı en büyük sayı 98''dir (99''da rakamlar aynı olduğundan geçersizdir). Rakamları farklı en küçük iki basamaklı sayı 10''dur. Fark: 98 − 10 = 88.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('18853169-c0f8-4bbe-8fe0-431572cb838c', '89', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('18853169-c0f8-4bbe-8fe0-431572cb838c', '88', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('18853169-c0f8-4bbe-8fe0-431572cb838c', '86', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('18853169-c0f8-4bbe-8fe0-431572cb838c', '87', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('83f42303-317f-449c-950a-b84706a1f813', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 12''dir. Bu sayının rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 18 fazla olduğuna göre ilk sayı kaçtır?', 'Basamakları yer değiştirme problemlerini denklemle çözer.', 'Sayı 10a+b olsun. a+b=12 ve (10b+a)−(10a+b)=18 → 9(b−a)=18 → b−a=2. a+b=12 ve b−a=2 denklemlerini toplarsak 2b=14 → b=7, a=5. İlk sayı 10×5+7=57.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83f42303-317f-449c-950a-b84706a1f813', '75', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83f42303-317f-449c-950a-b84706a1f813', '57', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83f42303-317f-449c-950a-b84706a1f813', '66', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83f42303-317f-449c-950a-b84706a1f813', '93', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('171c474e-c3bd-409e-852a-b1bd4bf6606b', 'Kesirler ve ondalık sayılarda çevirme, karşılaştırma ve dört işlem becerilerini kapsayan konudur.', '## Kesirler ve Ondalık Sayılar
Bir kesir a/b, a payı b paydayı gösterir. Kesri ondalık sayıya çevirmek için pay paydaya bölünür.

**Örnek:** 3/4 = 3÷4 = 0,75

## Kesirlerde Karşılaştırma
Paydaları eşitlemek veya ondalık forma çevirmek en pratik yöntemdir.

**Örnek:** 1/2, 3/5, 2/3 sayılarını sıralayalım.
Ondalık karşılıkları: 1/2=0,5 — 3/5=0,6 — 2/3≈0,667
Küçükten büyüğe: 1/2 < 3/5 < 2/3

## Kesirlerde Dört İşlem
- **Toplama/Çıkarma:** Paydalar eşitlenir, paylar toplanır/çıkarılır.
- **Çarpma:** Pay paya, payda paydaya çarpılır.
- **Bölme:** İkinci kesrin ters çevrilmiş hâli ile çarpılır (a/b ÷ c/d = a/b × d/c)

**Örnek:** (2/3 + 1/6) ÷ (5/9)
Önce parantez: 2/3+1/6 = 4/6+1/6 = 5/6
Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2

## Ondalık Sayıyı Kesre Çevirme
Ondalık sayı, virgülden sonraki basamak sayısı kadar sıfır içeren bir paydaya yazılır, sonra sadeleştirilir.

**Örnek:** 0,6 = 6/10 = 3/5 (sadeleştirilmiş hâli)

Rasyonel sayılarla işlem yaparken en sık yapılan hatalar, bölme işleminde ters çevirmeyi unutmak ve toplama/çıkarmada paydaları eşitlemeden işlem yapmaktır. Bu yüzden her adımın ayrı ayrı kontrol edilmesi önemlidir.', '5/8 kesrinin ondalık karşılığı kaçtır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4b033ab6-0f28-468b-8a2e-d60a5c3f3e05', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'kolay'::difficulty_level, '3/4 kesrinin ondalık gösterimi nedir?', 'Kesri ondalık sayıya çevirir.', '3/4 kesrinde pay paydaya bölünür: 3 ÷ 4 = 0,75.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4b033ab6-0f28-468b-8a2e-d60a5c3f3e05', '0.34', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4b033ab6-0f28-468b-8a2e-d60a5c3f3e05', '0.75', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4b033ab6-0f28-468b-8a2e-d60a5c3f3e05', '0.43', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4b033ab6-0f28-468b-8a2e-d60a5c3f3e05', '1.33', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8367f626-c1b7-4ef7-b765-64d694a659ed', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'kolay'::difficulty_level, '2/5 + 1/5 işleminin sonucu kaçtır?', 'Aynı paydalı kesirlerde toplama işlemi yapar.', 'Paydalar eşit olduğundan sadece paylar toplanır: (2+1)/5 = 3/5.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8367f626-c1b7-4ef7-b765-64d694a659ed', '3/25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8367f626-c1b7-4ef7-b765-64d694a659ed', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8367f626-c1b7-4ef7-b765-64d694a659ed', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8367f626-c1b7-4ef7-b765-64d694a659ed', '1/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('88db8e5c-1082-48fa-a0ce-d0e49ccb6bf2', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'orta'::difficulty_level, '1/2, 3/5, 2/3 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri karşılaştırıp sıralar.', 'Ondalık karşılıkları bulunur: 1/2=0,5; 3/5=0,6; 2/3≈0,667. Küçükten büyüğe sıralama: 1/2 < 3/5 < 2/3.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88db8e5c-1082-48fa-a0ce-d0e49ccb6bf2', '1/2 < 3/5 < 2/3', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88db8e5c-1082-48fa-a0ce-d0e49ccb6bf2', '3/5 < 1/2 < 2/3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88db8e5c-1082-48fa-a0ce-d0e49ccb6bf2', '2/3 < 3/5 < 1/2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88db8e5c-1082-48fa-a0ce-d0e49ccb6bf2', '1/2 < 2/3 < 3/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5f7ddea4-3c74-4337-8230-269b21e99289', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'orta'::difficulty_level, '0,6 ondalık sayısının kesir olarak en sade hali nedir?', 'Ondalık sayıyı sadeleştirilmiş kesre çevirir.', '0,6 = 6/10 yazılır. 6 ve 10''un ortak böleni 2 ile sadeleştirilirse 6/10 = 3/5 elde edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5f7ddea4-3c74-4337-8230-269b21e99289', '6/10', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5f7ddea4-3c74-4337-8230-269b21e99289', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5f7ddea4-3c74-4337-8230-269b21e99289', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5f7ddea4-3c74-4337-8230-269b21e99289', '2/3', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a4629e03-1388-4b39-a903-47be0ff2521c', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'zor'::difficulty_level, '(2/3 + 1/6) ÷ (5/9) işleminin sonucu kaçtır?', 'Kesirlerle karışık işlem (toplama ve bölme) yapar.', 'Önce parantez: 2/3+1/6, ortak payda 6 ile 4/6+1/6=5/6. Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4629e03-1388-4b39-a903-47be0ff2521c', '25/54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4629e03-1388-4b39-a903-47be0ff2521c', '3/2', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4629e03-1388-4b39-a903-47be0ff2521c', '3/5', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a4629e03-1388-4b39-a903-47be0ff2521c', '2/3', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('3bbd5f38-934b-4418-9af9-543e84b4f23e', 'Yüzde, kâr-zarar, yaş, işçi-havuz ve hareket problemlerinin çözüm yöntemlerini kapsayan konudur.', '## Yüzde Problemleri
A sayısının %k''i = A × k/100

**Örnek:** 250''nin %20''si: 250×20/100=50

## Kâr-Zarar Problemleri
- Kâr = Satış fiyatı − Alış fiyatı
- Kâr yüzdesi = (Kâr / Alış fiyatı) × 100

**Örnek:** 80 TL''ye alınan mal 100 TL''ye satılırsa:
Kâr = 100−80=20 TL
Kâr yüzdesi = 20/80×100=%25

## Yaş Problemleri
Genellikle bilinmeyen yaşlar x ile ifade edilip denklem kurulur. Kadar fazla/eksik, toplamı, katı gibi ifadeler denkleme dönüştürülür.

**Örnek:** Babanın yaşı, oğlunun yaşının 3 katından 5 fazla, toplamları 53.
x + (3x+5) = 53 → 4x=48 → x=12 (oğul), baba=41

## İşçi-Havuz Problemleri
Bir işi tek başına t saatte biten biri, birim zamanda işin 1/t''sini yapar. Birlikte çalışıldığında birim zamandaki iş oranları toplanır.

**Örnek:** A musluğu 6 saatte, B musluğu 12 saatte dolduruyor.
Birlikte hız: 1/6+1/12=2/12+1/12=3/12=1/4
Süre = 1 ÷ (1/4) = 4 saat

## Hareket Problemleri
- Aynı yönde hareket: hız farkı kullanılır.
- Zıt yönde (karşılıklı) hareket: hızlar toplanır.
Yol = Hız × Zaman

**Örnek:** 360 km arayla, biri 90 km/sa diğeri 60 km/sa hızla karşılıklı hareket ederse:
Toplam hız = 90+60=150 km/sa
Karşılaşma süresi = 360/150=2,4 saat

Bu problem tiplerinde birim (saat, km, TL) tutarlılığına ve toplam/fark ayrımına dikkat edilmelidir.', 'Bir üründe %15 indirim uygulanıyor. Ürünün etiket fiyatı 200 TL ise indirimli fiyat kaç TL olur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('40559cc5-ba6e-4a3d-982a-a5706433f784', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'kolay'::difficulty_level, '250''nin %20''si kaçtır?', 'Bir sayının yüzdesini hesaplar.', '250''nin %20''si: 250 × 20/100 = 50.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40559cc5-ba6e-4a3d-982a-a5706433f784', '25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40559cc5-ba6e-4a3d-982a-a5706433f784', '50', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40559cc5-ba6e-4a3d-982a-a5706433f784', '20', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('40559cc5-ba6e-4a3d-982a-a5706433f784', '45', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ebc00f2c-910a-4e56-b1a1-ee6ff233b7b9', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'kolay'::difficulty_level, 'Bir tüccar 80 TL''ye aldığı malı 100 TL''ye satıyor. Kâr yüzdesi kaçtır?', 'Kâr yüzdesini hesaplar.', 'Kâr = 100−80=20 TL. Kâr yüzdesi, kârın alış fiyatına oranıdır: 20/80×100=%25.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebc00f2c-910a-4e56-b1a1-ee6ff233b7b9', '20%', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebc00f2c-910a-4e56-b1a1-ee6ff233b7b9', '25%', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebc00f2c-910a-4e56-b1a1-ee6ff233b7b9', '125%', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ebc00f2c-910a-4e56-b1a1-ee6ff233b7b9', '80%', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2f00a062-fce8-47ed-a68e-b5a6b8b74907', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'orta'::difficulty_level, 'Bir babanın yaşı, oğlunun yaşının 3 katından 5 fazladır. Baba ile oğlunun yaşları toplamı 53 olduğuna göre oğlunun yaşı kaçtır?', 'Yaş problemini denklem kurarak çözer.', 'Oğlun yaşı x olsun. Baba = 3x+5. Toplam: x + (3x+5) = 53 → 4x + 5 = 53 → 4x = 48 → x = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2f00a062-fce8-47ed-a68e-b5a6b8b74907', '41', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2f00a062-fce8-47ed-a68e-b5a6b8b74907', '12', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2f00a062-fce8-47ed-a68e-b5a6b8b74907', '16', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2f00a062-fce8-47ed-a68e-b5a6b8b74907', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('43b7d384-0b08-4f43-9dd8-cf1a63e86579', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'orta'::difficulty_level, 'Bir havuzu tek başına A musluğu 6 saatte, B musluğu 12 saatte dolduruyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerinde birlikte çalışma süresini hesaplar.', 'Birim zamandaki doldurma oranları toplanır: 1/6+1/12 = 2/12+1/12 = 3/12 = 1/4. Süre = 1 ÷ (1/4) = 4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('43b7d384-0b08-4f43-9dd8-cf1a63e86579', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('43b7d384-0b08-4f43-9dd8-cf1a63e86579', '4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('43b7d384-0b08-4f43-9dd8-cf1a63e86579', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('43b7d384-0b08-4f43-9dd8-cf1a63e86579', '18', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('97d1ce29-1972-4673-a77d-96d2ec88bd22', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'zor'::difficulty_level, 'İki şehir arası uzaklık 360 km''dir. Bir araç A şehrinden B şehrine 90 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 60 km/sa hızla hareket ediyor. Bu iki araç kaç saat sonra karşılaşır?', 'Karşılıklı hareket problemlerinde karşılaşma süresini hesaplar.', 'Zıt yönlü hareket ettikleri için hızlar toplanır: 90+60=150 km/sa. Karşılaşma süresi = Toplam yol ÷ Toplam hız = 360/150 = 2,4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97d1ce29-1972-4673-a77d-96d2ec88bd22', '12', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97d1ce29-1972-4673-a77d-96d2ec88bd22', '2.4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97d1ce29-1972-4673-a77d-96d2ec88bd22', '4', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97d1ce29-1972-4673-a77d-96d2ec88bd22', '2.5', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'Hukuk kuralının tanımı, yaptırım türleri, hukukun kaynakları ile hak ve görev kavramlarının temel ilkelerini kapsar.', '## Hukuk Kuralı Nedir?
Hukuk kuralı, toplum halinde yaşayan bireylerin ilişkilerini düzenleyen, genel, soyut ve sürekli nitelikte olan; uyulmaması durumunda devlet gücü tarafından desteklenen bir yaptırıma bağlanan davranış kurallarıdır. Hukuk kuralını ahlak, din ve görgü gibi diğer toplumsal düzen kurallarından ayıran en belirgin özellik, devlet organları eliyle uygulanan **maddi yaptırıma** sahip olmasıdır.

## Yaptırım Türleri
Hukuk kurallarına aykırı davranışlar çeşitli yaptırımlarla karşılanır:
- **Ceza:** Suç niteliğindeki fiillere uygulanan hapis veya adli para cezası gibi yaptırımlardır.
- **Cebri icra (cebren yerine getirme):** Borcunu yerine getirmeyen kişinin edimini devlet gücüyle zorla yerine getirtmesidir.
- **Tazminat:** Bir kişinin hukuka aykırı fiiliyle başkasına verdiği zararı giderme yükümlülüğüdür.
- **İptal / Butlan (hükümsüzlük):** Kanunda aranan şekil veya esas şartlarına uyulmadan yapılan işlemlerin hukuken geçersiz sayılmasıdır.

## Hukukun Kaynakları
Hukukun kaynakları asli ve yardımcı kaynaklar olarak ikiye ayrılır:
- **Asli kaynaklar (yazılı):** Anayasa, kanun, cumhurbaşkanlığı kararnamesi, yönetmelik gibi yetkili organlarca yazılı şekilde konulan kurallardır.
- **Asli kaynaklar (yazısız):** Örf ve adet hukuku, toplumda uzun süredir uygulanan ve bağlayıcı olduğuna inanılan kurallardır.
- **Yardımcı kaynaklar:** Doktrin (bilimsel görüşler) ve yargısal içtihatlar, hukuk kurallarının yorumlanmasında hâkime ve hukukçulara yol gösterir; doğrudan bağlayıcı asli kaynak değildir.

## Hak ve Görev
**Hak**, hukuk düzeni tarafından bir kişiye tanınan ve korunan menfaat veya yetkidir. **Görev (borç/yükümlülük)** ise bir kişinin başka bir kişi veya devlete karşı yerine getirmek zorunda olduğu davranıştır. Hak ve görev kavramları birbirini tamamlar niteliktedir: bir kişinin hakkı, çoğunlukla başka bir kişi için buna karşılık gelen bir görev doğurur. Örneğin alacaklının alacak hakkı, borçlu için borcu ödeme görevini doğurur.', 'Hukuk kurallarını ahlak kurallarından ayıran temel özellik aşağıdakilerden hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fa17d85a-6f79-43e8-a759-acee7edaeb52', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'kolay'::difficulty_level, 'Hukuk kurallarını diğer toplumsal düzen kurallarından (ahlak, din, görgü) ayıran en temel özellik nedir?', 'Hukuk kuralını diğer toplumsal düzen kurallarından ayıran temel özelliği kavrar.', 'Hukuk kuralı, ahlak ve görgü kuralları gibi diğer toplumsal düzen kurallarından farklı olarak devlet gücüyle desteklenen bir yaptırıma sahiptir; bu nedenle uyulmaması halinde devlet organları tarafından zorla uygulanabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa17d85a-6f79-43e8-a759-acee7edaeb52', 'Yazılı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa17d85a-6f79-43e8-a759-acee7edaeb52', 'Herkes tarafından bilinmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa17d85a-6f79-43e8-a759-acee7edaeb52', 'Devlet gücüyle desteklenen yaptırıma sahip olması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa17d85a-6f79-43e8-a759-acee7edaeb52', 'Değişmez olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b0139266-fceb-4a05-aa7a-271e21f3f05c', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi hukuk kurallarının yaptırım türlerinden biri değildir?', 'Hukuk kurallarının yaptırım türlerini ayırt eder.', 'Vicdan azabı, ahlak kurallarının manevi yaptırımıdır; ceza, cebri icra ve tazminat ise hukuk kurallarının yaptırım türleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b0139266-fceb-4a05-aa7a-271e21f3f05c', 'Ceza', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b0139266-fceb-4a05-aa7a-271e21f3f05c', 'Vicdan azabı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b0139266-fceb-4a05-aa7a-271e21f3f05c', 'Cebri icra', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b0139266-fceb-4a05-aa7a-271e21f3f05c', 'Tazminat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('30ba8af3-4bdc-45d7-acc0-c3fc46901180', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'orta'::difficulty_level, 'Bir sözleşmenin kanunda öngörülen şekil şartına uyulmadan yapılması durumunda ortaya çıkan yaptırım türü aşağıdakilerden hangisidir?', 'Şekil şartına aykırılığın hukuki sonucunu açıklar.', 'Kanunda öngörülen şekil şartına uyulmadan yapılan hukuki işlemler hukuken geçersiz sayılır; bu yaptırım türüne butlan (kesin hükümsüzlük) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30ba8af3-4bdc-45d7-acc0-c3fc46901180', 'Cebri icra', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30ba8af3-4bdc-45d7-acc0-c3fc46901180', 'Tazminat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30ba8af3-4bdc-45d7-acc0-c3fc46901180', 'İptal edilebilirlik/Butlan (hükümsüzlük)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30ba8af3-4bdc-45d7-acc0-c3fc46901180', 'Hapis cezası', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('691c3161-9752-4d07-af9f-8d805fc5630f', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'orta'::difficulty_level, 'Hukukun yazılı asli kaynakları arasında aşağıdakilerden hangisi yer almaz?', 'Hukukun yazılı ve yazısız asli kaynaklarını ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan asli bir kaynaktır; Anayasa, kanun ve yönetmelik ise yazılı asli kaynaklar arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('691c3161-9752-4d07-af9f-8d805fc5630f', 'Anayasa', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('691c3161-9752-4d07-af9f-8d805fc5630f', 'Örf ve adet hukuku', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('691c3161-9752-4d07-af9f-8d805fc5630f', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('691c3161-9752-4d07-af9f-8d805fc5630f', 'Yönetmelik', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0cd1aaa0-6c91-449b-921c-f5b1a45f37a0', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'zor'::difficulty_level, '"Hak" ve "görev" kavramları arasındaki ilişki açısından aşağıdaki ifadelerden hangisi doğrudur?', 'Hak ve görev kavramları arasındaki karşılıklı ilişkiyi kavrar.', 'Hukuk düzeninde bir kişiye tanınan hak, genellikle karşı tarafta buna tekabül eden bir görev veya yükümlülük doğurur; örneğin alacak hakkı borçlu için ödeme görevi yaratır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd1aaa0-6c91-449b-921c-f5b1a45f37a0', 'Hak, kişiye tanınan hukuki korumadan bağımsız bir yetkidir; görev ile ilişkisi yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd1aaa0-6c91-449b-921c-f5b1a45f37a0', 'Görev, yalnızca kamu hukuku ilişkilerinde ortaya çıkan bir kavramdır', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd1aaa0-6c91-449b-921c-f5b1a45f37a0', 'Bir kişinin sahip olduğu hak, genellikle başka bir kişi için buna karşılık gelen bir görev/yükümlülük doğurur', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd1aaa0-6c91-449b-921c-f5b1a45f37a0', 'Hak ve görev kavramları sadece anayasa hukukunda kullanılır', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', '1982 Anayasası''nın kabul süreci, temel ilkeleri, Başlangıç hükümlerinin bağlayıcılığı ve değiştirilemez maddelerini ele alır.', '## 1982 Anayasası''nın Genel Çerçevesi
1982 Anayasası, halkoylaması sonucunda kabul edilerek yürürlüğe girmiş ve Türkiye Cumhuriyeti''nin temel hukuki metnidir. Anayasa, devletin yapısını, temel hak ve özgürlükleri, devlet organlarının kuruluş ve işleyişini düzenler.

## Başlangıç Hükümlerinin Niteliği
Anayasa''nın **Başlangıç** kısmı, sadece siyasi bir bildiri niteliğinde değildir; Anayasa metninin **ayrılmaz bir parçasını** oluşturur ve Anayasa''nın diğer maddeleriyle birlikte hukuken bağlayıcıdır. Başlangıç''ta Atatürk milliyetçiliği, milli egemenlik, cumhuriyetin nitelikleri gibi temel değerlere vurgu yapılır ve bu değerler Anayasa''nın yorumlanmasında da esas alınır.

## Anayasa''nın Temel İlkeleri
1982 Anayasası''na göre Türkiye Devleti''nin nitelikleri şunlardır:
- **Cumhuriyetçilik:** Devletin yönetim şekli cumhuriyettir.
- **Milli (ulusal) egemenlik:** Egemenlik kayıtsız şartsız millete aittir.
- **Demokratik devlet:** Yönetimde çoğulcu demokrasi esastır.
- **Laik devlet:** Din ve devlet işleri birbirinden ayrıdır.
- **Sosyal devlet:** Devlet, sosyal adalet ve refahı sağlamakla yükümlüdür.
- **Hukuk devleti:** Devlet, kendi eylem ve işlemlerinde hukuk kurallarıyla bağlıdır.
- **İnsan haklarına saygılı devlet:** Temel hak ve özgürlükler anayasal güvence altındadır.
- **Atatürk milliyetçiliğine bağlılık.**

## Değiştirilemez Hükümler
Anayasa''da bazı hükümler diğerlerinden farklı bir güvenceye sahiptir: Devletin şeklinin Cumhuriyet olduğunu belirten hüküm, Cumhuriyetin temel niteliklerini sayan hüküm ve devletin bütünlüğü, resmî dili, bayrağı, millî marşı ile başkentine ilişkin hükümler **değiştirilemez** ve bunların değiştirilmesi **teklif dahi edilemez**. Bu düzenleme, devletin temel kimliğini siyasi çoğunluk değişikliklerine karşı güvence altına almayı amaçlar.', '1982 Anayasası''nın Başlangıç kısmının hukuki niteliği ile ilgili aşağıdaki ifadelerden hangisi doğrudur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bb5b189e-18a0-4a54-964c-a5dfb24a94f0', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'kolay'::difficulty_level, '1982 Anayasası''na göre Türkiye Devleti''nin şekli nedir?', 'Türkiye Devleti''nin temel yönetim şeklini bilir.', '1982 Anayasası''nın ilgili hükmüne göre Türkiye Devleti''nin şekli Cumhuriyettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb5b189e-18a0-4a54-964c-a5dfb24a94f0', 'Monarşi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb5b189e-18a0-4a54-964c-a5dfb24a94f0', 'Federasyon', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb5b189e-18a0-4a54-964c-a5dfb24a94f0', 'Cumhuriyet', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb5b189e-18a0-4a54-964c-a5dfb24a94f0', 'Konfederasyon', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d487272b-b7bb-46ae-b83d-18f0180e5c65', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi 1982 Anayasası''nda Cumhuriyetin nitelikleri arasında sayılan temel ilkelerden biri değildir?', 'Cumhuriyetin Anayasa''da sayılan temel niteliklerini ayırt eder.', 'Tek parti yönetimi, çoğulcu demokrasi ilkesiyle bağdaşmadığından Anayasa''da sayılan Cumhuriyetin nitelikleri arasında yer almaz; laiklik, sosyal devlet ve hukuk devleti ise temel niteliklerdendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d487272b-b7bb-46ae-b83d-18f0180e5c65', 'Laiklik', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d487272b-b7bb-46ae-b83d-18f0180e5c65', 'Tek parti yönetimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d487272b-b7bb-46ae-b83d-18f0180e5c65', 'Sosyal devlet', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d487272b-b7bb-46ae-b83d-18f0180e5c65', 'Hukuk devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b43c2c91-4bef-4f9b-8851-ca07b3a5f947', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'orta'::difficulty_level, '1982 Anayasası''nın Başlangıç kısmı hakkında aşağıdakilerden hangisi doğrudur?', 'Başlangıç hükümlerinin hukuki bağlayıcılığını açıklar.', 'Anayasa''nın Başlangıç kısmı, Anayasa metninin ayrılmaz bir parçası olup diğer hükümlerle birlikte hukuken bağlayıcıdır; salt sembolik bir metin değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b43c2c91-4bef-4f9b-8851-ca07b3a5f947', 'Başlangıç kısmı yalnızca sembolik bir metindir, hukuki bağlayıcılığı yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b43c2c91-4bef-4f9b-8851-ca07b3a5f947', 'Başlangıç kısmı sadece Anayasa Mahkemesi kararlarında referans olarak kullanılabilir', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b43c2c91-4bef-4f9b-8851-ca07b3a5f947', 'Başlangıç kısmı kanunlarla değiştirilebilir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b43c2c91-4bef-4f9b-8851-ca07b3a5f947', 'Başlangıç kısmı, Anayasa''nın ayrılmaz bir parçasını oluşturur ve Anayasa metnine dahildir', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('81f2db9d-4e0d-464f-b2a6-f93f138a0870', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'orta'::difficulty_level, 'Anayasa''da yer alan "değiştirilemez ve değiştirilmesi teklif dahi edilemez" hükümler esas olarak neyi korumayı amaçlar?', 'Değiştirilemez Anayasa hükümlerinin amacını kavrar.', 'Değiştirilemez hükümler, devletin şekli, temel nitelikleri ve devletin bütünlüğü gibi temel unsurları siyasi çoğunluk değişikliklerine karşı korumayı amaçlar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81f2db9d-4e0d-464f-b2a6-f93f138a0870', 'Bakanlar Kurulunun yetkilerini', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81f2db9d-4e0d-464f-b2a6-f93f138a0870', 'Yerel yönetimlerin özerkliğini', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81f2db9d-4e0d-464f-b2a6-f93f138a0870', 'Devletin temel niteliklerini (Cumhuriyet, devletin şekli, temel unsurları)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81f2db9d-4e0d-464f-b2a6-f93f138a0870', 'Siyasi partilerin kapatılma usulünü', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('81db5908-a34d-436f-8a3d-99c001613f48', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'zor'::difficulty_level, '1982 Anayasası''nın "değiştirilemeyecek hükümler" ile ilgili düzenlemesi hakkında aşağıdakilerden hangisi doğrudur?', 'Değiştirilemez hükümlere ilişkin özel güvenceyi açıklar.', 'Anayasa''da bu hükümlerin yalnızca değiştirilmesi değil, değiştirilmesinin teklif edilmesi bile açıkça yasaklanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81db5908-a34d-436f-8a3d-99c001613f48', 'Bu hükümlerin değiştirilmesi TBMM üye tam sayısının 2/3 çoğunluğuyla mümkündür', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81db5908-a34d-436f-8a3d-99c001613f48', 'Bu hükümler halkoylaması ile değiştirilebilir ancak TBMM tarafından değiştirilemez', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81db5908-a34d-436f-8a3d-99c001613f48', 'Bu hükümlerin sadece değiştirilmesi değil, değiştirilmesinin teklif edilmesi dahi yasaktır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('81db5908-a34d-436f-8a3d-99c001613f48', 'Bu hükümler yalnızca Anayasa Mahkemesi kararıyla değiştirilebilir', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'TBMM, Cumhurbaşkanlığı ve yargı organlarının genel yapısını, temel görevlerini ve kuvvetler ayrılığı ilkesini özetler.', '## Yasama Organı: TBMM
Türkiye Büyük Millet Meclisi (TBMM), yasama yetkisini kullanan tek organdır. Milletvekilleri genel oyla ve belirli aralıklarla yapılan seçimlerle halk tarafından seçilir. TBMM''nin başlıca görevleri şunlardır:
- Kanun yapmak, değiştirmek ve yürürlükten kaldırmak
- Bütçe ve kesin hesap kanun tekliflerini görüşüp kabul etmek
- Yürütme organını denetlemek (soru, meclis araştırması, genel görüşme gibi araçlarla)
- Milletlerarası antlaşmaların onaylanmasını uygun bulmak

## Yürütme Organı: Cumhurbaşkanlığı
Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetki ve görevi **Cumhurbaşkanı** tarafından kullanılır. Cumhurbaşkanı halk tarafından doğrudan seçilir; devletin başıdır ve aynı zamanda yürütmenin başıdır. Cumhurbaşkanı yardımcıları ve bakanlar, Cumhurbaşkanı tarafından atanır ve yürütme faaliyetlerinin yürütülmesinde ona yardımcı olur. Yürütmenin başlıca görevleri arasında kanunları uygulamak, cumhurbaşkanlığı kararnamesi çıkarmak, dış politikayı yürütmek ve ülkeyi idare etmek yer alır.

## Yargı Organı: Mahkemeler
Yargı yetkisi, Türk Milleti adına **bağımsız ve tarafsız mahkemeler** tarafından kullanılır. Hâkimler, görevlerinde bağımsızdır ve hâkimlik teminatına sahiptir; bu sayede yürütme ve yasamanın etkisinden korunurlar. Türkiye''de görev alanına göre çeşitli yüksek yargı organları bulunur:
- **Anayasa Mahkemesi:** Kanunların Anayasa''ya uygunluğunu denetler.
- **Yargıtay:** Adli yargının en üst denetim merciidir.
- **Danıştay:** İdari yargının en üst denetim merciidir.
- **Sayıştay:** Kamu kaynaklarının kullanımını denetler.

## Kuvvetler Ayrılığı İlkesi
Yasama, yürütme ve yargı yetkilerinin farklı organlarca kullanılması, gücün tek elde toplanmasını önlemeyi ve organlar arasında karşılıklı denetim sağlamayı amaçlayan **kuvvetler ayrılığı ilkesi**nin bir gereğidir. Bu ilke, hukuk devletinin ve demokratik yönetimin temel güvencelerinden biridir.', 'Türkiye''de yürütme yetkisinin kullanılmasına ilişkin aşağıdaki ifadelerden hangisi Cumhurbaşkanlığı Hükümet Sistemi''ne uygundur?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9c34c62b-e31f-4f49-acb4-f690298d7e9f', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'kolay'::difficulty_level, 'Türkiye''de yasama yetkisi hangi organa aittir?', 'Yasama organını ve yetkisinin kime ait olduğunu bilir.', 'Yasama yetkisi Türk Milleti adına Türkiye Büyük Millet Meclisi tarafından kullanılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c34c62b-e31f-4f49-acb4-f690298d7e9f', 'Cumhurbaşkanlığı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c34c62b-e31f-4f49-acb4-f690298d7e9f', 'Yargıtay', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c34c62b-e31f-4f49-acb4-f690298d7e9f', 'Türkiye Büyük Millet Meclisi', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c34c62b-e31f-4f49-acb4-f690298d7e9f', 'Bakanlar Kurulu', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8bfa7963-8c81-4714-b473-4291cbdb4667', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi yargı organının temel işlevidir?', 'Yargı organının temel işlevini açıklar.', 'Yargı organının temel işlevi, taraflar arasındaki hukuki uyuşmazlıkları bağımsız ve tarafsız mahkemeler eliyle çözüme kavuşturmaktır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bfa7963-8c81-4714-b473-4291cbdb4667', 'Kanun yapmak', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bfa7963-8c81-4714-b473-4291cbdb4667', 'Bütçeyi hazırlamak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bfa7963-8c81-4714-b473-4291cbdb4667', 'Uyuşmazlıkları bağımsız ve tarafsız biçimde çözüme kavuşturmak', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bfa7963-8c81-4714-b473-4291cbdb4667', 'Milletlerarası antlaşma imzalamak', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('85c220e8-2411-48ac-90da-053c623c7317', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'orta'::difficulty_level, 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisi kime aittir?', 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisinin kullanımını bilir.', 'Cumhurbaşkanlığı Hükümet Sistemi''nde başbakanlık makamı kaldırılmış olup yürütme yetkisi Cumhurbaşkanı tarafından kullanılmaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('85c220e8-2411-48ac-90da-053c623c7317', 'TBMM Başkanına', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('85c220e8-2411-48ac-90da-053c623c7317', 'Başbakana', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('85c220e8-2411-48ac-90da-053c623c7317', 'Anayasa Mahkemesi Başkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('85c220e8-2411-48ac-90da-053c623c7317', 'Cumhurbaşkanına', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('910121a6-fcd9-4f5d-bd3a-0a3ff5e285bc', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''deki yüksek yargı organlarından biridir?', 'Türkiye''deki yüksek yargı organlarını tanır.', 'Danıştay, idari yargının en üst denetim mercii olan yüksek bir yargı organıdır; diğer seçenekler yargı organı değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('910121a6-fcd9-4f5d-bd3a-0a3ff5e285bc', 'TBMM Başkanlık Divanı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('910121a6-fcd9-4f5d-bd3a-0a3ff5e285bc', 'Milli Güvenlik Kurulu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('910121a6-fcd9-4f5d-bd3a-0a3ff5e285bc', 'Danıştay', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('910121a6-fcd9-4f5d-bd3a-0a3ff5e285bc', 'Cumhurbaşkanlığı Kabinesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9bbf93f2-2799-4fd0-8015-b8935fefe162', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'zor'::difficulty_level, 'Kuvvetler ayrılığı ilkesi bağlamında yasama, yürütme ve yargı organlarının birbirleriyle ilişkisi hakkında aşağıdakilerden hangisi doğrudur?', 'Kuvvetler ayrılığı ilkesinin amacını ve işleyişini kavrar.', 'Kuvvetler ayrılığı ilkesi, gücün tek bir organda toplanmasını önlemek amacıyla yasama, yürütme ve yargı arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür; organlar arasında tam bir kopukluk anlamına gelmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bbf93f2-2799-4fd0-8015-b8935fefe162', 'Kuvvetler ayrılığı, organların birbirinden tamamen kopuk ve hiçbir denetim ilişkisi bulunmadığı anlamına gelir', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bbf93f2-2799-4fd0-8015-b8935fefe162', 'Kuvvetler ayrılığı ilkesi yalnızca yasama ve yürütme arasındaki ilişkiyi düzenler, yargıyı kapsamaz', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bbf93f2-2799-4fd0-8015-b8935fefe162', 'Kuvvetler ayrılığı, güç yoğunlaşmasını önlemek amacıyla organlar arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bbf93f2-2799-4fd0-8015-b8935fefe162', 'Kuvvetler ayrılığı ilkesine göre yargı organı yasama organına bağlı çalışır', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'Türkiye''nin matematik (mutlak) konumu enlem-boylam değerleriyle, özel (coğrafi) konumu ise komşuları, denizlerle ilişkisi ve kıtalar arasındaki yeriyle tanımlanır; bu iki konum türü ülkenin iklim, ulaşım ve jeopolitik özelliklerini şekillendirir.', '## Matematik (Mutlak) Konum
- Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer alır.
- Yaklaşık 36°-42° kuzey enlemleri ile 26°-45° doğu boylamları arasında bulunur.
- Orta Kuşak''ta (kuzey ılıman kuşak) yer aldığından yıl içinde dört mevsim belirgin biçimde yaşanır.
- Boylamlar arasındaki yaklaşık 19 derecelik açı farkı, doğu ile batı arasında yerel saatte belirgin bir farka (yaklaşık 76 dakika) yol açar; bu nedenle güneş doğuda batıya göre daha erken doğar.
- Uç noktalar: en kuzeyde Sinop (İnceburun), en güneyde Hatay, en doğuda Iğdır, en batıda Gökçeada (Çanakkale).

## Özel (Coğrafi) Konum
- Üç tarafı denizlerle (Karadeniz, Ege Denizi, Akdeniz) çevrilidir.
- İstanbul ve Çanakkale Boğazları aracılığıyla Asya ile Avrupa kıtaları arasında bir geçiş/köprü konumundadır.
- Enerji kaynakları bakımından zengin Orta Doğu ve Hazar-Orta Asya bölgeleri ile Avrupa arasında transit güzergâh üzerindedir.
- Farklı basınç sistemlerinin ve hava kütlelerinin etkisi altında kalması, iklim ve bitki örtüsü çeşitliliğine zemin hazırlar.
- Levha sınırlarına yakın konumu nedeniyle diri fay hatları üzerinde yer alır ve deprem riski taşır.

## Matematik Konumun Sonuçları
- Mevsimlerin belirgin biçimde yaşanması ve gün uzunluğunun mevsimlere göre değişmesi.
- Güneş ışınlarının geliş açısının enlemlere ve mevsimlere göre farklılaşması.
- Doğu-batı yönünde yerel saat farkının bulunması.

## Özel Konumun Sonuçları
- Ticaret ve ulaşım açısından önemli bir kavşak noktası olması.
- Kültürel çeşitlilik, tarihi zenginlik ve yüksek turizm potansiyeli.
- Jeopolitik ve stratejik önemin fazla olması.
- İklim ve doğal bitki örtüsü çeşitliliğine bağlı tarımsal ürün çeşitliliği.', 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi gösterilebilir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8e9ca825-e2b1-4b5a-b17c-0656d6bb846a', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'kolay'::difficulty_level, 'Türkiye''nin üç tarafının denizlerle çevrili olması, aşağıdaki konum türlerinden hangisine örnektir?', 'Matematik konum ile özel konum kavramlarını ayırt edebilme.', 'Denizlerle çevrili olma, komşu ülkeler ve ulaşım yolları gibi özellikler özel (coğrafi) konumun kapsamına girer; enlem-boylam gibi ölçülebilir değerler ise matematik konuma aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e9ca825-e2b1-4b5a-b17c-0656d6bb846a', 'Matematik konum', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e9ca825-e2b1-4b5a-b17c-0656d6bb846a', 'Özel konum', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e9ca825-e2b1-4b5a-b17c-0656d6bb846a', 'Astronomik konum', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8e9ca825-e2b1-4b5a-b17c-0656d6bb846a', 'Mutlak konum', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1fb105fe-1e31-46b9-9484-dba5d44602fb', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin matematik konumunun bir sonucu değildir?', 'Matematik konumun sonuçlarını özel konumun sonuçlarından ayırt edebilme.', 'Kıtalar arası transit ticaret, Türkiye''nin özel (coğrafi) konumunun bir sonucudur; enlem-boylama bağlı sonuçlar arasında yer almaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb105fe-1e31-46b9-9484-dba5d44602fb', 'Dört mevsimin belirgin biçimde yaşanması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb105fe-1e31-46b9-9484-dba5d44602fb', 'Doğu ile batı arasında yerel saat farkının olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb105fe-1e31-46b9-9484-dba5d44602fb', 'Farklı kıtalar arasında transit ticaret yapılması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1fb105fe-1e31-46b9-9484-dba5d44602fb', 'Güneş ışınlarının geliş açısının mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('36923ff4-c98b-444f-b16f-cf203a640fdc', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'orta'::difficulty_level, 'Türkiye, boylamlar üzerinde doğuda Iğdır''dan batıda Gökçeada''ya kadar yaklaşık 19 derecelik bir açı genişliğine sahiptir. Bu durumun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Boylam farkının yerel saat ve gün doğumu-batımı üzerindeki etkisini kavrayabilme.', 'Boylam farkı arttıkça yerel saat farkı da artar; Dünya batıdan doğuya döndüğü için doğudaki yerler güneşi daha erken karşılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36923ff4-c98b-444f-b16f-cf203a640fdc', 'Ülkenin tamamında bitki örtüsü aynıdır', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36923ff4-c98b-444f-b16f-cf203a640fdc', 'Doğudaki iller, batıdaki illere göre güneşi daha erken karşılar', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36923ff4-c98b-444f-b16f-cf203a640fdc', 'Ülkenin dört tarafı denizlerle çevrilidir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36923ff4-c98b-444f-b16f-cf203a640fdc', 'Yıl boyunca gece-gündüz süreleri hep eşittir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a9362c6e-00dc-404c-87af-d1b765c62e4b', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası aşağıdaki illerden hangisinde yer alır?', 'Türkiye''nin uç noktalarını bilme.', 'Türkiye''nin en doğu noktası Iğdır ilinde yer alır; Sinop en kuzey, Hatay en güney, Çanakkale (Gökçeada) ise en batı noktasını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9362c6e-00dc-404c-87af-d1b765c62e4b', 'Hatay', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9362c6e-00dc-404c-87af-d1b765c62e4b', 'Sinop', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9362c6e-00dc-404c-87af-d1b765c62e4b', 'Iğdır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9362c6e-00dc-404c-87af-d1b765c62e4b', 'Çanakkale', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('400d7b5a-a49e-4617-a2c2-859aaf36190e', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'zor'::difficulty_level, 'Türkiye''de saatler ülke genelinde tek bir resmi saat dilimine göre ayarlanmasına rağmen, Karadeniz kıyısında güneş henüz doğarken Doğu Anadolu''nun doğu kesiminde güneş çoktan doğmuş ve gökyüzünde belirgin biçimde yükselmiş olabilir. Bu durumun temel nedeni aşağıdakilerden hangisidir?', 'Boylam genişliğinin yerel güneş konumu üzerindeki etkisini analiz edebilme.', 'Bu fark, Türkiye''nin doğu-batı doğrultusunda geniş bir boylam aralığına yayılmış olmasından (matematik konum) kaynaklanır; deniz kıyısı, kıta geçişi gibi özel konum unsurları bu durumun nedeni değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('400d7b5a-a49e-4617-a2c2-859aaf36190e', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('400d7b5a-a49e-4617-a2c2-859aaf36190e', 'Türkiye''nin farklı boylamlar üzerinde geniş bir alana yayılmış olması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('400d7b5a-a49e-4617-a2c2-859aaf36190e', 'Türkiye''nin Asya ile Avrupa arasında bir geçiş bölgesinde bulunması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('400d7b5a-a49e-4617-a2c2-859aaf36190e', 'Türkiye''nin dağlık ve engebeli bir yapıya sahip olması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'Türkiye''de yer şekilleri, denize yakınlık ve enlem gibi faktörlerin etkisiyle Akdeniz, Karadeniz, Marmara (geçiş) ve karasal iklim olmak üzere birbirinden belirgin biçimde farklı iklim tipleri görülür.', '## Türkiye''de Görülen İklim Tipleri

### Akdeniz İklimi
- Akdeniz ve Ege kıyı şeridinde görülür.
- Yazlar sıcak ve kurak, kışlar ılık ve yağışlı geçer.
- Yağışlar çoğunlukla kış aylarında düşer.

### Karadeniz İklimi
- Karadeniz kıyı şeridi boyunca görülür.
- Her mevsim yağışlıdır; yazlar serin, kıyı kesiminde kışlar diğer iç bölgelere göre daha ılımandır.
- Yıllık yağış miktarı ve yağış düzenliliği bakımından Türkiye''nin en yağışlı iklim tipidir.

### Marmara (Geçiş) İklimi
- Marmara Bölgesi''nin büyük bölümünde görülür.
- Karadeniz iklimi ile Akdeniz iklimi arasında geçiş özellikleri taşır; her mevsim yağış görülmekle birlikte yazın yağış azalır.

### Karasal İklim
- İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun büyük bölümünde ve iç kesimlerde görülür.
- Yazlar sıcak ve kurak, kışlar soğuk ve kar yağışlı geçer.
- Yıllık ve günlük sıcaklık farkı fazladır, yıllık yağış miktarı azdır.
- Doğu Anadolu''da yükseltinin fazla olması nedeniyle kışlar daha sert ve uzun geçer.

## İklim Dağılışını Etkileyen Faktörler
- **Enlem:** Güneye gidildikçe sıcaklık genel olarak artar.
- **Yükselti:** Yükseldikçe sıcaklık düşer; bu nedenle iç ve yüksek kesimlerde kışlar daha soğuk geçer.
- **Denize yakınlık/uzaklık:** Kıyı kesimlerde deniz etkisiyle sıcaklık farkları azalır; iç kesimlerde karasallık artar.
- **Dağların uzanış doğrultusu:** Kıyıya paralel uzanan Karadeniz ve Toros Dağları, deniz etkisinin iç kesimlere sokulmasını engeller; bu yüzden kıyıdan iç kesimlere geçişte iklim kısa mesafede belirgin biçimde değişebilir.
- **Bakı (yön):** Güneye bakan yamaçlar daha fazla güneş ışını alır.', 'Aşağıdaki iklim tiplerinden hangisi her mevsim yağışlı olması bakımından diğerlerinden ayrılır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a13a7c52-6420-4542-973e-b9965786bc11', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'kolay'::difficulty_level, 'Yazların sıcak ve kurak, kışların ise ılık ve yağışlı geçtiği iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin temel özelliklerini tanıyabilme.', 'Yazın sıcak-kurak, kışın ılık-yağışlı geçmesi Akdeniz ikliminin temel özelliğidir; bu iklim Akdeniz ve Ege kıyılarında görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a13a7c52-6420-4542-973e-b9965786bc11', 'Karadeniz iklimi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a13a7c52-6420-4542-973e-b9965786bc11', 'Akdeniz iklimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a13a7c52-6420-4542-973e-b9965786bc11', 'Karasal iklim', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a13a7c52-6420-4542-973e-b9965786bc11', 'Marmara iklimi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('01abf6fb-4a7b-4d2d-a1ac-e373808b8a2c', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'kolay'::difficulty_level, 'Türkiye''de her mevsim yağış alan ve yıllık yağış miktarı en fazla olan iklim tipi aşağıdaki bölgelerin hangisinde görülür?', 'İklim tiplerinin bölgesel dağılışını bilme.', 'Karadeniz iklimi her mevsim yağışlı olup Türkiye''nin en yağışlı iklim tipidir ve Karadeniz kıyı şeridinde görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('01abf6fb-4a7b-4d2d-a1ac-e373808b8a2c', 'İç Anadolu Bölgesi''nin iç kesimleri', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('01abf6fb-4a7b-4d2d-a1ac-e373808b8a2c', 'Karadeniz Bölgesi kıyıları', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('01abf6fb-4a7b-4d2d-a1ac-e373808b8a2c', 'Akdeniz Bölgesi kıyıları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('01abf6fb-4a7b-4d2d-a1ac-e373808b8a2c', 'Doğu Anadolu Bölgesi''nin yüksek kesimleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8217a707-e9a3-46d8-b5ac-702dcbfc1390', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'orta'::difficulty_level, 'Türkiye''de kıyı kesimlerinden iç kesimlere gidildikçe iklimin kısa mesafede belirgin biçimde değişmesinin temel nedeni aşağıdakilerden hangisidir?', 'Yer şekillerinin iklim üzerindeki etkisini kavrayabilme.', 'Karadeniz ve Toros Dağları kıyıya paralel uzandığından denizden gelen nemli hava kütlelerinin iç kesimlere ulaşmasını engeller; bu nedenle kıyı ile iç kesim arasında kısa mesafede belirgin iklim farklılıkları oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8217a707-e9a3-46d8-b5ac-702dcbfc1390', 'Enlem farkının fazla olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8217a707-e9a3-46d8-b5ac-702dcbfc1390', 'Dağların kıyıya paralel uzanarak deniz etkisinin iç kesimlere sokulmasını engellemesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8217a707-e9a3-46d8-b5ac-702dcbfc1390', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8217a707-e9a3-46d8-b5ac-702dcbfc1390', 'Yıllık güneşlenme süresinin her yerde aynı olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9ea1d097-5e8f-46f8-b36e-9752c158344a', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'orta'::difficulty_level, 'Aşağıdaki illerden hangisinde yaz ile kış arasındaki sıcaklık farkının en fazla olması beklenir?', 'Karasallığın sıcaklık farkına etkisini örnekle ilişkilendirebilme.', 'Erzurum, denizden uzak ve yüksek bir iç kesimde yer aldığından karasal iklimin etkisiyle yaz-kış sıcaklık farkı diğer kıyı kentlerine göre daha fazladır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea1d097-5e8f-46f8-b36e-9752c158344a', 'Antalya', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea1d097-5e8f-46f8-b36e-9752c158344a', 'Rize', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea1d097-5e8f-46f8-b36e-9752c158344a', 'Erzurum', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea1d097-5e8f-46f8-b36e-9752c158344a', 'İzmir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0d7b4d94-fdc3-4e32-b5b6-1bff90d72073', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'zor'::difficulty_level, 'Enlemleri birbirine yakın olmasına karşın Rize ile Erzurum arasında kış sıcaklıkları bakımından büyük fark bulunmasının temel nedeni aşağıdakilerden hangisidir?', 'Denizellik-karasallık ve yükseltinin sıcaklık üzerindeki birlikte etkisini analiz edebilme.', 'Rize kıyıda yer aldığından denizin ılımanlaştırıcı etkisi altındadır; Erzurum ise hem yüksek hem de karasal bir iç kesimde bulunduğundan kışları çok daha soğuk geçer. İki merkezin enlemleri birbirine yakın olsa da belirleyici olan denize yakınlık ve yükselti farkıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0d7b4d94-fdc3-4e32-b5b6-1bff90d72073', 'İki merkezin farklı boylamlarda yer alması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0d7b4d94-fdc3-4e32-b5b6-1bff90d72073', 'Rize''nin denize kıyısının olması, Erzurum''un ise yüksek ve karasal bir konumda bulunması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0d7b4d94-fdc3-4e32-b5b6-1bff90d72073', 'Rize''de yağışın yalnızca kış mevsiminde düşmesi, Erzurum''da hiç yağış düşmemesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0d7b4d94-fdc3-4e32-b5b6-1bff90d72073', 'Erzurum''un güneşten daha fazla ışın alması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'Türkiye''de nüfus dağılışı yer şekilleri, iklim ve ekonomik faaliyetler gibi doğal ve beşeri faktörlere bağlı olarak kıyı ve ova kesimlerinde yoğunlaşırken; yerleşme dokusu ise su kaynağı ve iklim koşullarına göre toplu veya dağınık biçimde şekillenir.', '## Nüfus Dağılışını Etkileyen Faktörler

### Doğal (Fiziki) Faktörler
- **Yer şekilleri:** Dağlık ve engebeli alanlarda nüfus seyrek, ova ve düzlüklerde nüfus yoğundur.
- **İklim:** Elverişli/ılıman iklim koşullarının görüldüğü kıyı bölgelerinde nüfus daha yoğundur; sert karasal iklimin görüldüğü yüksek platolarda nüfus seyrektir.
- **Su kaynakları:** Akarsu vadileri ve ovalar gibi su kaynağına yakın alanlarda yerleşim ve tarım kolaylaştığından nüfus yoğunlaşır.
- **Toprak verimliliği:** Çukurova, Gediz ve Büyük Menderes ovaları gibi verimli tarım alanlarında nüfus yoğundur.

### Beşeri ve Ekonomik Faktörler
- **Ekonomik faaliyetler:** Sanayi, ticaret ve hizmet sektörünün geliştiği kentlerde nüfus yoğunlaşır.
- **Ulaşım:** Ulaşım olanaklarının geliştiği bölgelerde yerleşim ve nüfus artar.
- **Tarihi ve kültürel etkenler:** Tarih boyunca yerleşime elverişli, güvenli bölgeler daha yoğun nüfuslanmıştır.
- **Kentleşme:** Sanayileşme ve iş imkânlarına bağlı göç, büyük kentlerdeki nüfus oranını artırmıştır.

## Türkiye''de Nüfusun Dağılışı
- Kıyı bölgeleri (özellikle Marmara, Ege ve Akdeniz kıyıları) ile büyük ovalar nüfus bakımından yoğundur.
- Doğu Anadolu''nun yüksek ve engebeli kesimleri, iklim koşullarının elverişsizliği ve tarım alanlarının kısıtlı olması nedeniyle seyrek nüfusludur.
- Nüfusun büyük bölümü kentlerde yaşamaktadır; kırsal nüfus oranı zamanla azalmıştır.

## Yerleşme Tipleri

### Kırsal Yerleşme
- Ekonomik faaliyeti büyük ölçüde tarım ve hayvancılığa dayanan, nüfus ve yapı yoğunluğu şehirlere göre az olan yerleşmelerdir (köy, mezra, kom, yayla gibi).

### Kentsel (Şehirsel) Yerleşme
- Nüfusu kalabalık, ekonomik faaliyetleri sanayi, ticaret ve hizmet sektörüne dayanan yerleşmelerdir.

### Yerleşme Dokusuna Göre Sınıflandırma
- **Toplu (kümeleşmiş) yerleşme:** Su kaynaklarının sınırlı, güvenlik ihtiyacının ön planda olduğu kurak/yarı kurak bölgelerde evler bir arada ve sık dokulu kurulur (örn. İç Anadolu, Güneydoğu Anadolu).
- **Dağınık yerleşme:** Su kaynaklarının bol olduğu nemli ve yağışlı bölgelerde her hane kendi arazisine ve su kaynağına yakın, birbirinden uzak konumlanır (örn. Karadeniz Bölgesi''nin kırsal kesimleri).', 'Türkiye''de kırsal yerleşmelerin dağınık ya da toplu doku göstermesinde en belirleyici etken aşağıdakilerden hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('630517a7-e332-4a03-8bfb-35e24f908887', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfusun seyrek olduğu alanlara örnektir?', 'Nüfusun seyrek olduğu alanları örnekle ilişkilendirebilme.', 'Doğu Anadolu''nun yüksek ve engebeli platoları, sert iklim koşulları ve sınırlı tarım alanları nedeniyle Türkiye''nin en seyrek nüfuslu bölgelerindendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('630517a7-e332-4a03-8bfb-35e24f908887', 'Çukurova Ovası', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('630517a7-e332-4a03-8bfb-35e24f908887', 'Marmara kıyıları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('630517a7-e332-4a03-8bfb-35e24f908887', 'Doğu Anadolu''nun yüksek platoları', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('630517a7-e332-4a03-8bfb-35e24f908887', 'Ege kıyı ovaları', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e5cc5c0b-cdb0-4be7-9af5-c4f2d4000982', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi kırsal yerleşme tiplerinden biri değildir?', 'Kırsal ve kentsel yerleşme tiplerini ayırt edebilme.', 'Metropol, nüfusu ve ekonomik faaliyetleri bakımından büyük bir kentsel yerleşmeyi ifade eder; köy, mezra ve yayla ise kırsal yerleşme tipleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e5cc5c0b-cdb0-4be7-9af5-c4f2d4000982', 'Köy', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e5cc5c0b-cdb0-4be7-9af5-c4f2d4000982', 'Mezra', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e5cc5c0b-cdb0-4be7-9af5-c4f2d4000982', 'Yayla', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e5cc5c0b-cdb0-4be7-9af5-c4f2d4000982', 'Metropol', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('373386a1-0a5c-4416-bf49-a436c6b2f176', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfus dağılışını etkileyen beşeri (insan kaynaklı) faktörlerden biridir?', 'Nüfus dağılışını etkileyen doğal ve beşeri faktörleri ayırt edebilme.', 'Sanayileşme ve ekonomik faaliyetler insan kaynaklı (beşeri) bir faktördür; yükselti, iklim ve yer şekilleri ise doğal (fiziki) faktörler arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('373386a1-0a5c-4416-bf49-a436c6b2f176', 'Yükselti', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('373386a1-0a5c-4416-bf49-a436c6b2f176', 'Sanayileşme ve ekonomik faaliyetler', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('373386a1-0a5c-4416-bf49-a436c6b2f176', 'İklim koşulları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('373386a1-0a5c-4416-bf49-a436c6b2f176', 'Yer şekilleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fddd9caa-7a46-4c11-b39f-c6d71f124a01', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'orta'::difficulty_level, 'Karadeniz Bölgesi''nin kırsal kesimlerinde evlerin genellikle birbirinden uzak ve dağınık şekilde kurulmasının temel nedeni aşağıdakilerden hangisidir?', 'Doğal koşulların yerleşme dokusuna etkisini analiz edebilme.', 'Karadeniz Bölgesi''nde yağış ve su kaynağı bolluğu ile engebeli arazi yapısı, ailelerin kendi tarım arazilerine ve su kaynaklarına yakın yerleşmesine yol açar; bu da dağınık yerleşme dokusunu oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fddd9caa-7a46-4c11-b39f-c6d71f124a01', 'Bölgede su kaynaklarının kısıtlı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fddd9caa-7a46-4c11-b39f-c6d71f124a01', 'Bölgenin engebeli olması nedeniyle her ailenin kendi arazisine ve su kaynağına yakın yerleşmesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fddd9caa-7a46-4c11-b39f-c6d71f124a01', 'Bölgede güvenlik kaygısının fazla olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fddd9caa-7a46-4c11-b39f-c6d71f124a01', 'Bölgede tarım alanlarının bulunmaması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3899a647-0807-4e95-8ea1-d4337780b0c5', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'zor'::difficulty_level, 'Kurak bir iklim bölgesinde, su kaynaklarının sınırlı sayıda kaynak veya kuyu etrafında toplandığı bir yerleşim alanında evlerin sık ve bir arada (toplu) kurulmuş olması aşağıdakilerden hangisiyle açıklanabilir?', 'Toplu yerleşmenin oluşum nedenlerini kurak iklim koşullarıyla ilişkilendirerek analiz edebilme.', 'Kurak bölgelerde su kaynağı sınırlı olduğundan halk bu kaynaklara yakın ve bir arada yerleşir; ayrıca güvenlik ihtiyacı da toplu yerleşme dokusunu güçlendiren bir etkendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3899a647-0807-4e95-8ea1-d4337780b0c5', 'Halkın tamamının aynı ekonomik faaliyetle uğraşması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3899a647-0807-4e95-8ea1-d4337780b0c5', 'Sınırlı su kaynağının ortak kullanılması ve güvenlik ihtiyacının yerleşmeyi bir arada tutması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3899a647-0807-4e95-8ea1-d4337780b0c5', 'Bölgenin deniz kıyısında yer alması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3899a647-0807-4e95-8ea1-d4337780b0c5', 'Bölgede yağışın her mevsim düzenli olması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('d54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'İlk Türk devletleri; Asya Hun Devleti, Avrupa Hun Devleti, Göktürk Devleti ve Uygur Devleti başta olmak üzere Orta Asya bozkırlarında kurulan, Türk devlet geleneğinin temelini oluşturan siyasi yapılardır.', '## Asya Hun Devleti
- Bilinen ilk teşkilatlı Türk devleti olarak kabul edilir.
- En parlak dönemini Mete Han (Mao-tun) zamanında, MÖ 209''dan itibaren yaşamıştır.
- Mete Han, "onlu sistem" adı verilen ordu teşkilatını kurarak Türk-Moğol bozkır dünyasında askeri disiplinin temelini atmıştır.
- Çin ile uzun süre mücadele ederek Orta Asya''da geniş bir hakimiyet alanı oluşturmuştur.

## Kavimler Göçü ve Avrupa Hun Devleti
- Asya Hun Devleti''nin zamanla zayıflaması ve Çin baskısı, bazı Hun boylarının batıya yönelmesine yol açmıştır.
- Bu hareket, 375 yılında Kavimler Göçü''nün başlamasına zemin hazırlamıştır.
- Kavimler Göçü, Roma İmparatorluğu''nun 395''te Doğu ve Batı olarak ikiye ayrılmasına, 476''da ise Batı Roma İmparatorluğu''nun yıkılmasına neden olan gelişmelerin önünü açmıştır.
- Avrupa Hun Devleti, 5. yüzyılda Attila döneminde en güçlü dönemini yaşamış, Avrupa''da geniş bir alanda etkili olmuştur.

## Göktürk Devleti
- 552 yılında Bumin Kağan tarafından kurulmuştur.
- "Türk" adını taşıyan ilk devlettir.
- 582 yılında Doğu ve Batı Göktürk Devleti olarak ikiye ayrılmıştır.
- Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen Orhun Yazıtları (Göktürk Abideleri), Türk adının geçtiği ilk yazılı belgeler ve Türkçenin bilinen ilk yazılı metinleri olarak kabul edilir.

## Uygur Devleti
- 745 yılında kurulmuştur.
- Yerleşik hayata geçen ilk Türk devleti olarak bilinir.
- Mani dinini benimseyerek savaşçı bozkır kültüründen uzaklaşmış, tarım ve şehir hayatına yönelmişlerdir.
- Kağıt ve matbaayı kullanan ilk Türk devleti olarak KPSS müfredatında yer alır.

## Ortak Özellikler
İlk Türk devletlerinde "kut" anlayışına dayalı hükümdarlık, kurultay (devlet meclisi) geleneği ve ikili teşkilat (doğu-batı yönetim biçimi) gibi ortak siyasi ve sosyal yapılar dikkat çeker.', 'Aşağıdakilerden hangisi yerleşik hayata geçen ve kağıt-matbaayı kullanan ilk Türk devleti olarak bilinir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ce9f8d3c-9843-4978-9ce0-0594334d49d2', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'kolay'::difficulty_level, 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?', 'İlk Türk devletlerinden Asya Hun Devleti''nin özelliklerini kavrar.', 'Asya Hun Devleti, Mete Han döneminde onlu sistem ordu teşkilatıyla güçlenmiş ve bilinen ilk teşkilatlı Türk devleti kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ce9f8d3c-9843-4978-9ce0-0594334d49d2', 'Asya Hun Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ce9f8d3c-9843-4978-9ce0-0594334d49d2', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ce9f8d3c-9843-4978-9ce0-0594334d49d2', 'Uygur Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ce9f8d3c-9843-4978-9ce0-0594334d49d2', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('73456640-f5ac-4d27-b7d6-6c1ace78cc31', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'kolay'::difficulty_level, '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?', 'Göktürk Devleti''nin kuruluşu ve kurucusunu bilir.', 'Göktürk Devleti 552 yılında Bumin Kağan tarafından kurulmuş olup Türk adını taşıyan ilk devlettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73456640-f5ac-4d27-b7d6-6c1ace78cc31', 'Bumin Kağan', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73456640-f5ac-4d27-b7d6-6c1ace78cc31', 'Mete Han', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73456640-f5ac-4d27-b7d6-6c1ace78cc31', 'Attila', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73456640-f5ac-4d27-b7d6-6c1ace78cc31', 'Bilge Kağan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8f0a9518-2570-431b-a5c8-1efd037cf34a', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'orta'::difficulty_level, 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yerleşik yaşam ve kültürel özelliklerini ayırt eder.', 'Uygurlar, Mani dinini kabul ederek yerleşik hayata geçmiş ve kağıt-matbaayı kullanan ilk Türk devleti olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8f0a9518-2570-431b-a5c8-1efd037cf34a', 'Uygur Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8f0a9518-2570-431b-a5c8-1efd037cf34a', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8f0a9518-2570-431b-a5c8-1efd037cf34a', 'Asya Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8f0a9518-2570-431b-a5c8-1efd037cf34a', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b8b52ae1-974f-47ce-b50b-4d96df5fc816', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'orta'::difficulty_level, 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?', 'Orhun Yazıtları''nın hangi devlete ait olduğunu ve önemini bilir.', 'Orhun Yazıtları (Göktürk Abideleri), Göktürk Devleti dönemine ait olup Türkçenin bilinen ilk yazılı metinleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b8b52ae1-974f-47ce-b50b-4d96df5fc816', 'Göktürk Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b8b52ae1-974f-47ce-b50b-4d96df5fc816', 'Uygur Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b8b52ae1-974f-47ce-b50b-4d96df5fc816', 'Avrupa Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b8b52ae1-974f-47ce-b50b-4d96df5fc816', 'Asya Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('08ebff6f-b756-41fc-9297-7d4095edb909', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'zor'::difficulty_level, '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?', 'Kavimler Göçü''nün Türk tarihiyle bağlantısını ve Avrupa tarihine etkisini analiz eder.', 'Asya Hun Devleti''nin Çin baskısıyla zayıflaması sonucu Hun boylarının batıya yönelmesi, Kavimler Göçü''nü başlatan temel gelişmedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('08ebff6f-b756-41fc-9297-7d4095edb909', 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('08ebff6f-b756-41fc-9297-7d4095edb909', 'Göktürklerin Doğu ve Batı olarak ikiye ayrılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('08ebff6f-b756-41fc-9297-7d4095edb909', 'Uygurların Moğolistan''daki hakimiyetini kaybetmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('08ebff6f-b756-41fc-9297-7d4095edb909', 'Bumin Kağan''ın Göktürk Devleti''ni kurması', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'Osmanlı Kuruluş Dönemi, Osman Bey''in 1299''da beyliği kurmasından Fatih Sultan Mehmed''in tahta çıkışına kadar geçen, devletin bir uç beyliğinden güçlü bir imparatorluğa dönüştüğü süreçtir.', '## Osman Bey Dönemi
- Osmanlı Devleti''nin kuruluşu geleneksel olarak 1299 yılı kabul edilir.
- Osman Bey, Söğüt ve çevresinde küçük bir uç beyliği olarak devletin temellerini atmıştır.

## Orhan Bey Dönemi
- 1326''da Bursa fethedilerek başkent yapılmıştır.
- İlk düzenli ordu (Yaya ve Müsellem birlikleri) kurulmuştur.
- İznik''te ilk medrese açılmış, ilk Osmanlı parası bastırılmıştır.

## I. Murad (Hüdavendigar) Dönemi
- Edirne fethedilerek yeni başkent yapılmıştır.
- Yeniçeri Ocağı kurulmuş, Çandarlı ailesi devlet yönetiminde etkili olmuştur.
- 1389 Kosova Savaşı''nda Sırplara karşı zafer kazanılmış, ancak I. Murad savaş meydanında şehit düşmüştür.

## Yıldırım Bayezid Dönemi
- 1396 Niğbolu Savaşı''nda Haçlı ordusuna karşı büyük bir zafer kazanılmıştır.
- İstanbul ilk kez kuşatılmıştır.
- 1402 Ankara Savaşı''nda Timur''a yenilerek esir düşmüş, bu durum Anadolu Türk siyasi birliğinin bozulmasına yol açmıştır.

## Fetret Devri (1402-1413)
- Yıldırım Bayezid''in şehzadeleri arasında taht kavgalarının yaşandığı, devletin dağılma tehlikesi geçirdiği dönemdir.

## Çelebi Mehmed (I. Mehmed) Dönemi
- Fetret Devri''ni sona erdirerek siyasi birliği yeniden sağlamış, bu nedenle Osmanlı''nın "ikinci kurucusu" olarak anılmıştır.

## II. Murad Dönemi
- 1444 Varna Savaşı ve 1448 II. Kosova Savaşı''nda Haçlı ordularına karşı önemli zaferler kazanılmıştır.
- Devlet, II. Mehmed''in (Fatih) 1451''de tahta çıkışıyla kuruluş döneminin sonuna ve yükseliş dönemine geçiş yapmıştır.', 'Ankara Savaşı sonrasında yaşanan ve şehzadeler arasındaki taht mücadelelerine sahne olan döneme ne ad verilir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('79ae26b9-dcc5-463a-ab8b-3ff9b4c128de', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'kolay'::difficulty_level, 'Osmanlı Devleti''nin kuruluş tarihi olarak kabul edilen 1299 yılında beyliği kuran kişi kimdir?', 'Osmanlı Devleti''nin kuruluşunu ve kurucusunu bilir.', 'Osmanlı Devleti''nin kuruluşu, Osman Bey tarafından 1299 yılında gerçekleştirilmiş olarak kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79ae26b9-dcc5-463a-ab8b-3ff9b4c128de', 'Osman Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79ae26b9-dcc5-463a-ab8b-3ff9b4c128de', 'Orhan Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79ae26b9-dcc5-463a-ab8b-3ff9b4c128de', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79ae26b9-dcc5-463a-ab8b-3ff9b4c128de', 'II. Mehmed', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a2f46833-94ed-4730-abb0-afced16d6b78', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'kolay'::difficulty_level, 'Bursa''nın fethedilerek başkent yapıldığı, ilk düzenli ordu (Yaya-Müsellem) ve ilk medresenin (İznik) kurulduğu dönem hangi padişaha aittir?', 'Orhan Bey dönemindeki kurumsallaşma adımlarını bilir.', 'Orhan Bey döneminde Bursa fethedilmiş, ilk düzenli ordu kurulmuş ve İznik''te ilk medrese açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2f46833-94ed-4730-abb0-afced16d6b78', 'Orhan Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2f46833-94ed-4730-abb0-afced16d6b78', 'Osman Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2f46833-94ed-4730-abb0-afced16d6b78', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a2f46833-94ed-4730-abb0-afced16d6b78', 'Yıldırım Bayezid', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('da5dc931-3b5b-4047-ba4b-a4d8230ad1d3', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'orta'::difficulty_level, 'Yıldırım Bayezid''in Timur''a yenilerek esir düştüğü ve Anadolu Türk siyasi birliğinin bozulmasına yol açan savaş aşağıdakilerden hangisidir?', 'Ankara Savaşı''nın Osmanlı kuruluş dönemine etkisini kavrar.', '1402 Ankara Savaşı''nda Yıldırım Bayezid Timur''a yenilmiş ve esir düşmüş, bu durum Fetret Devri''ne zemin hazırlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da5dc931-3b5b-4047-ba4b-a4d8230ad1d3', 'Ankara Savaşı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da5dc931-3b5b-4047-ba4b-a4d8230ad1d3', 'Niğbolu Savaşı', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da5dc931-3b5b-4047-ba4b-a4d8230ad1d3', 'Kosova Savaşı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da5dc931-3b5b-4047-ba4b-a4d8230ad1d3', 'Varna Savaşı', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ff6bc8bd-d43c-4823-8a25-d69dc96a877a', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi I. Murad (Hüdavendigar) döneminde gerçekleşen gelişmelerden biridir?', 'I. Murad dönemi kurumsal ve askeri gelişmelerini diğer padişahlar dönemindeki gelişmelerden ayırt eder.', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması I. Murad dönemine aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff6bc8bd-d43c-4823-8a25-d69dc96a877a', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff6bc8bd-d43c-4823-8a25-d69dc96a877a', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff6bc8bd-d43c-4823-8a25-d69dc96a877a', 'Ankara Savaşı''nın kaybedilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ff6bc8bd-d43c-4823-8a25-d69dc96a877a', 'Bursa''nın fethedilmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b15443b4-1cbf-48fd-9837-79fba8e22d36', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'zor'::difficulty_level, 'Fetret Devri''ni sona erdirerek Osmanlı siyasi birliğini yeniden sağlayan ve bu nedenle "ikinci kurucu" olarak da anılan padişah kimdir?', 'Fetret Devri''nin sona eriş sürecini ve bu süreçteki padişahın rolünü analiz eder.', 'Çelebi Mehmed (I. Mehmed), şehzadeler arası taht mücadelelerini sona erdirerek devletin siyasi birliğini yeniden sağlamış ve bu nedenle ikinci kurucu olarak anılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b15443b4-1cbf-48fd-9837-79fba8e22d36', 'Çelebi Mehmed (I. Mehmed)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b15443b4-1cbf-48fd-9837-79fba8e22d36', 'II. Murad', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b15443b4-1cbf-48fd-9837-79fba8e22d36', 'Yıldırım Bayezid', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b15443b4-1cbf-48fd-9837-79fba8e22d36', 'Orhan Bey', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('7640798b-40ed-4450-8685-63853ff9609e', 'Kurtuluş Savaşı (Millî Mücadele), Mondros Ateşkes Antlaşması sonrası işgallere karşı Mustafa Kemal önderliğinde örgütlenen direniş sürecidir; kongreler, TBMM''nin açılışı, cepheler ve Lozan Antlaşması''yla sonuçlanmıştır.', '## Hazırlık Dönemi
- 30 Ekim 1918''de Mondros Ateşkes Antlaşması imzalanmış, İtilaf Devletleri Anadolu''yu işgale başlamıştır.
- 19 Mayıs 1919''da Mustafa Kemal, Millî Mücadele''yi örgütlemek üzere Samsun''a çıkmıştır.

## Kongreler ve Genelgeler
- 22 Haziran 1919''da yayımlanan Amasya Genelgesi, "Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesiyle Millî Mücadele''nin ilk yazılı belgesi kabul edilir.
- Temmuz-Ağustos 1919''da toplanan Erzurum Kongresi bölgesel, Eylül 1919''da toplanan Sivas Kongresi ise ulusal nitelikli bir kongredir; Sivas Kongresi''nde Anadolu ve Rumeli Müdafaa-i Hukuk Cemiyeti kurulmuştur.

## TBMM''nin Açılışı ve Misak-ı Millî
- Son Osmanlı Mebusan Meclisi''nde kabul edilen Misak-ı Millî kararları, millî sınırları ve bağımsızlık ilkelerini belirlemiştir.
- İstanbul''un İtilaf Devletlerince resmen işgal edilmesi (16 Mart 1920) üzerine, 23 Nisan 1920''de Ankara''da TBMM açılmıştır.

## Cepheler
- **Doğu Cephesi:** Kazım Karabekir komutasında Ermenilere karşı mücadele edilmiş, Gümrü Antlaşması ile sonuçlanmıştır.
- **Güney Cephesi:** Kuvay-ı Milliye güçleri Fransızlara karşı Antep, Maraş ve Urfa''da direnmiştir.
- **Batı Cephesi:** Yunan ordusuna karşı I. İnönü (Ocak 1921) ve II. İnönü (Mart-Nisan 1921) muharebeleri kazanılmış, Ağustos-Eylül 1921''de Sakarya Meydan Muharebesi ile Yunan ilerleyişi durdurulmuştur. 26 Ağustos 1922''de başlayan Büyük Taarruz ve 30 Ağustos''taki Başkomutanlık Meydan Muharebesi ile Yunan ordusu kesin olarak yenilgiye uğratılmıştır.

## Savaşın Sonuçları
- Ekim 1922''de Mudanya Ateşkes Antlaşması imzalanmıştır.
- 24 Temmuz 1923''te imzalanan Lozan Antlaşması ile yeni Türk devletinin bağımsızlığı uluslararası alanda tanınmıştır.', 'Millî Mücadele''nin ilk yazılı belgesi olarak kabul edilen ve 22 Haziran 1919''da yayımlanan genelge hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('933bbe51-2af8-4d5c-9317-c8a5dcb5388e', '7640798b-40ed-4450-8685-63853ff9609e', 'kolay'::difficulty_level, 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?', 'Millî Mücadele''nin başlangıç tarihini bilir.', 'Mustafa Kemal, 19 Mayıs 1919''da Samsun''a çıkarak Millî Mücadele''nin fiilen başlamasını sağlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('933bbe51-2af8-4d5c-9317-c8a5dcb5388e', '19 Mayıs 1919', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('933bbe51-2af8-4d5c-9317-c8a5dcb5388e', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('933bbe51-2af8-4d5c-9317-c8a5dcb5388e', '30 Ekim 1918', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('933bbe51-2af8-4d5c-9317-c8a5dcb5388e', '29 Ekim 1923', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0abcb872-5229-4adc-8fd6-aec9c854c52f', '7640798b-40ed-4450-8685-63853ff9609e', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?', 'TBMM''nin açılış tarihini ve önemini bilir.', 'TBMM, İstanbul''un işgali üzerine 23 Nisan 1920''de Ankara''da açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0abcb872-5229-4adc-8fd6-aec9c854c52f', '23 Nisan 1920', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0abcb872-5229-4adc-8fd6-aec9c854c52f', '19 Mayıs 1919', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0abcb872-5229-4adc-8fd6-aec9c854c52f', '4 Eylül 1919', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0abcb872-5229-4adc-8fd6-aec9c854c52f', '16 Mart 1920', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3f557c63-403b-4539-bad1-d3bd1abc0c2f', '7640798b-40ed-4450-8685-63853ff9609e', 'orta'::difficulty_level, '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?', 'Amasya Genelgesi''nin içeriğini ve önemini kavrar.', 'Bu ifade, 22 Haziran 1919''da yayımlanan Amasya Genelgesi''nde yer almaktadır ve genelge Millî Mücadele''nin ilk yazılı belgesi kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f557c63-403b-4539-bad1-d3bd1abc0c2f', 'Amasya Genelgesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f557c63-403b-4539-bad1-d3bd1abc0c2f', 'Erzurum Kongresi kararları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f557c63-403b-4539-bad1-d3bd1abc0c2f', 'Sivas Kongresi kararları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f557c63-403b-4539-bad1-d3bd1abc0c2f', 'Misak-ı Millî', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b9edea4e-ec34-4c5b-b753-199c90273182', '7640798b-40ed-4450-8685-63853ff9609e', 'orta'::difficulty_level, 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?', 'Batı Cephesi''ndeki muharebelerin kronolojik sırasını ve önemini bilir.', 'Sakarya Meydan Muharebesi, Ağustos-Eylül 1921''de kazanılmış ve Yunan ilerleyişini durdurarak Türk ordusunun taarruz gücüne geçmesinde dönüm noktası olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9edea4e-ec34-4c5b-b753-199c90273182', 'Sakarya Meydan Muharebesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9edea4e-ec34-4c5b-b753-199c90273182', 'I. İnönü Muharebesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9edea4e-ec34-4c5b-b753-199c90273182', 'Büyük Taarruz', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9edea4e-ec34-4c5b-b753-199c90273182', 'II. İnönü Muharebesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e94d74a8-9ede-4818-92d6-fcb9569bef47', '7640798b-40ed-4450-8685-63853ff9609e', 'zor'::difficulty_level, 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?', 'Kurtuluş Savaşı cephelerini ve mücadele edilen devletleri doğru eşleştirir.', 'Antep, Maraş ve Urfa, Güney Cephesi''nde Fransızlara karşı verilen direnişin öne çıktığı yerlerdir; Sakarya, İnönü ve Dumlupınar ise Batı Cephesi''nde Yunanlılara karşı yaşanan muharebe yerleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e94d74a8-9ede-4818-92d6-fcb9569bef47', 'Antep, Maraş, Urfa', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e94d74a8-9ede-4818-92d6-fcb9569bef47', 'Sakarya, İnönü, Dumlupınar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e94d74a8-9ede-4818-92d6-fcb9569bef47', 'Gümrü, Kars, Sarıkamış', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e94d74a8-9ede-4818-92d6-fcb9569bef47', 'İzmir, Bursa, Eskişehir', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'İnkılap Tarihi, Cumhuriyet''in ilanından itibaren Mustafa Kemal Atatürk önderliğinde siyasi, hukuki, eğitim ve toplumsal alanlarda gerçekleştirilen köklü değişimleri (inkılapları) kapsar.', '## Siyasi İnkılaplar
- 1 Kasım 1922''de saltanat kaldırılarak Osmanlı hanedanının siyasi yetkisi sona erdirilmiştir.
- 29 Ekim 1923''te Cumhuriyet ilan edilmiş, Mustafa Kemal ilk Cumhurbaşkanı seçilmiştir.
- 3 Mart 1924''te halifelik kaldırılarak laik devlet düzenine geçişte önemli bir adım atılmıştır.

## Eğitim ve Hukuk Alanındaki İnkılaplar
- 3 Mart 1924''te kabul edilen Tevhid-i Tedrisat Kanunu ile eğitim kurumları Millî Eğitim Bakanlığı çatısı altında birleştirilerek eğitimde birlik sağlanmıştır.
- 1925 yılında tekke, zaviye ve türbeler kapatılmıştır.
- 25 Kasım 1925''te Şapka Kanunu kabul edilmiştir.
- 17 Şubat 1926''da İsviçre Medeni Kanunu esas alınarak Türk Medeni Kanunu kabul edilmiş; kadın-erkek eşitliği hukuki zeminde güçlendirilmiştir.

## Harf ve Dil İnkılabı
- 1 Kasım 1928''de kabul edilen kanunla Latin harflerine dayalı yeni Türk alfabesine geçilmiştir.

## Toplumsal ve Siyasi Haklar
- 1930 yılında kadınlara belediye seçimlerinde seçme hakkı tanınmıştır.
- 1934 yılında kadınlara milletvekili seçme ve seçilme hakkı tanınmıştır.
- 1934 yılında Soyadı Kanunu kabul edilerek herkesin bir soyadı alması zorunlu hale getirilmiştir.

## Genel Değerlendirme
Bu inkılaplar; laik, çağdaş ve millî egemenliğe dayalı bir devlet ve toplum yapısı oluşturmayı amaçlamış, kısa sürede birbirini tamamlayan bir bütünlük içinde gerçekleştirilmiştir.', 'Eğitim kurumlarını Millî Eğitim Bakanlığı çatısı altında birleştiren ve eğitimde birliği sağlayan kanun hangisidir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('70e7e462-ec0e-46cc-8ec5-fa49778dc5b5', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'kolay'::difficulty_level, 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', 'Cumhuriyetin ilan tarihini bilir.', 'Türkiye Cumhuriyeti, 29 Ekim 1923 tarihinde ilan edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('70e7e462-ec0e-46cc-8ec5-fa49778dc5b5', '29 Ekim 1923', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('70e7e462-ec0e-46cc-8ec5-fa49778dc5b5', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('70e7e462-ec0e-46cc-8ec5-fa49778dc5b5', '1 Kasım 1922', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('70e7e462-ec0e-46cc-8ec5-fa49778dc5b5', '3 Mart 1924', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fbcfd750-07cd-4238-94b0-9faf5768fa69', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'kolay'::difficulty_level, 'Osmanlı hanedanının siyasi yetkisinin sona erdirildiği saltanatın kaldırılması hangi tarihte gerçekleşmiştir?', 'Saltanatın kaldırılış tarihini ve önemini bilir.', 'Saltanat, 1 Kasım 1922 tarihinde TBMM kararıyla kaldırılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fbcfd750-07cd-4238-94b0-9faf5768fa69', '1 Kasım 1922', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fbcfd750-07cd-4238-94b0-9faf5768fa69', '29 Ekim 1923', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fbcfd750-07cd-4238-94b0-9faf5768fa69', '3 Mart 1924', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fbcfd750-07cd-4238-94b0-9faf5768fa69', '17 Şubat 1926', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('031da193-d42a-4fd3-be74-53b2608517d9', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'orta'::difficulty_level, 'Halifeliğin kaldırılması ile eğitimde birliği sağlayan Tevhid-i Tedrisat Kanunu''nun kabulü, 1924 yılında hangi tarihte aynı gün gerçekleşmiştir?', 'Halifeliğin kaldırılması ve Tevhid-i Tedrisat Kanunu''nun tarihini ve ilişkisini bilir.', 'Halifelik ile Tevhid-i Tedrisat Kanunu, aynı gün olan 3 Mart 1924''te kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('031da193-d42a-4fd3-be74-53b2608517d9', '3 Mart', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('031da193-d42a-4fd3-be74-53b2608517d9', '1 Kasım', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('031da193-d42a-4fd3-be74-53b2608517d9', '25 Kasım', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('031da193-d42a-4fd3-be74-53b2608517d9', '17 Şubat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('47a61fef-f9c1-4f97-947f-43d23a2f007a', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'orta'::difficulty_level, 'Türk kadınına milletvekili seçme ve seçilme hakkının tanındığı yıl aşağıdakilerden hangisidir?', 'Kadınlara tanınan siyasi hakların tarihsel sürecini bilir.', 'Kadınlara milletvekili seçme ve seçilme hakkı 1934 yılında tanınmıştır; 1930 yılında ise yalnızca belediye seçimlerinde seçme hakkı verilmişti.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47a61fef-f9c1-4f97-947f-43d23a2f007a', '1934', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47a61fef-f9c1-4f97-947f-43d23a2f007a', '1930', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47a61fef-f9c1-4f97-947f-43d23a2f007a', '1926', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47a61fef-f9c1-4f97-947f-43d23a2f007a', '1928', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('30f8e157-0506-4271-b6e8-de3c86e6dbdc', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'zor'::difficulty_level, 'Aşağıdaki inkılaplardan hangisi kronolojik olarak diğerlerinden daha sonra gerçekleşmiştir?', 'Cumhuriyet dönemi inkılaplarını kronolojik sıraya göre değerlendirir.', 'Soyadı Kanunu 1934 yılında kabul edilmiş olup, Medeni Kanun (1926), Harf İnkılabı (1928) ve Şapka Kanunu''ndan (1925) daha sonraki bir tarihte gerçekleşmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30f8e157-0506-4271-b6e8-de3c86e6dbdc', 'Soyadı Kanunu (1934)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30f8e157-0506-4271-b6e8-de3c86e6dbdc', 'Medeni Kanun''un kabulü (1926)', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30f8e157-0506-4271-b6e8-de3c86e6dbdc', 'Harf İnkılabı (1928)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('30f8e157-0506-4271-b6e8-de3c86e6dbdc', 'Şapka Kanunu (1925)', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'Ünlü ve ünsüz uyumu, ünsüz yumuşaması/sertleşmesi, ünlü düşmesi ve kaynaştırma ünsüzleri gibi ses olaylarını kapsayan bu konu, Türkçenin ses bilgisi kurallarını örneklerle açıklar.', '## Büyük Ünlü Uyumu (Kalınlık-İncelik Uyumu)
Türkçe kökenli bir kelimenin ilk hecesinde kalın ünlü (a, ı, o, u) varsa sonraki hecelerde de kalın ünlü bulunur; ilk hecede ince ünlü (e, i, ö, ü) varsa sonraki hecelerde de ince ünlü bulunur. Örneğin ''kalemlik'' kelimesindeki ''kalem'' kökü Arapça kökenli olduğu için bu kurala aykırıdır (a-e). ''Kalem, hangi, elma, anne'' gibi bazı yabancı kökenli ya da kalıplaşmış kelimeler bu kuralın istisnasıdır.

## Küçük Ünlü Uyumu (Düzlük-Yuvarlaklık Uyumu)
Düz ünlülerden (a, e, ı, i) sonra düz ünlü gelir. Yuvarlak ünlülerden (o, ö, u, ü) sonra ise ya düz-geniş (a, e) ya da dar-yuvarlak (u, ü) ünlü gelir. ''Doktor, otobüs, radyo'' gibi yabancı kökenli kelimeler bu kurala da aykırıdır çünkü yuvarlak bir ünlüden sonra yine geniş-yuvarlak (o, ö) bir ünlü gelmiştir.

## Ünsüz Benzeşmesi (Sertleşme)
Sert ünsüzle (ç, f, h, k, p, s, ş, t = ''fıstıkçı şahap'') biten bir kelimeye yumuşak ünsüzle başlayan bir ek gelirse, ekin başındaki ünsüz sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta, iş+ci → işçi.

## Ünsüz Yumuşaması
p, ç, t, k ile biten bir kelime ünlüyle başlayan bir ek aldığında bu ünsüzler yumuşayarak sırasıyla b, c, d, ğ/g''ye dönüşür: kitap→kitabı, ağaç→ağacı, at→adı, çocuk→çocuğu.

## Ünlü Düşmesi (Hece Düşmesi)
İkinci hecesinde dar ünlü (ı, i, u, ü) bulunan bazı iki heceli kelimeler ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: burun→burnu, ağız→ağzı, akıl→aklı, oğul→oğlu, şehir→şehri.

## Kaynaştırma Ünsüzleri
Ünlüyle biten bir kelime ünlüyle başlayan bir ek aldığında, iki ünlünün yan yana gelmesini önlemek için araya ''y, ş, s, n'' kaynaştırma ünsüzlerinden biri girer: kapı+ı→kapıyı, iki+er→ikişer, araba+ın→arabasının, kapı+ın→kapının.', 'Örnek: ''Ağacın gölgesinde otururken kitabını okudu.'' cümlesinde hangi kelimede ünsüz yumuşaması görülür?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1e5400b9-090a-47b8-9716-ee773e542e07', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi büyük ünlü uyumuna (kalınlık-incelik uyumuna) aykırıdır?', 'Büyük ünlü uyumu kuralını kelimeler üzerinde uygular.', '''Kalem'' kökü Arapça kökenli olup ilk hecesinde kalın ünlü (a), ikinci hecesinde ince ünlü (e) bulunur; bu nedenle kelime büyük ünlü uyumuna aykırıdır. Diğer seçeneklerdeki kelimelerin tüm heceleri ya kalın ya da ince ünlülerden oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e5400b9-090a-47b8-9716-ee773e542e07', 'kalemlik', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e5400b9-090a-47b8-9716-ee773e542e07', 'yapraklar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e5400b9-090a-47b8-9716-ee773e542e07', 'sevgili', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e5400b9-090a-47b8-9716-ee773e542e07', 'doğrular', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b3b7c1f5-8c5f-4715-b30c-e067f89ee278', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde ünsüz yumuşaması (p, ç, t, k seslerinin yumuşaması) görülür?', 'Ünsüz yumuşaması kuralını örneklerde tespit eder.', '''Ağaç'' kökündeki sert ünsüz ''ç'', ünlüyle başlayan iyelik eki ''-ı'' aldığında yumuşayarak ''c''ye dönüşmüş ve ''ağacı'' biçimini almıştır. Diğer seçeneklerde ünsüzle başlayan ekler geldiği için yumuşama gerçekleşmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3b7c1f5-8c5f-4715-b30c-e067f89ee278', 'kitaptan', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3b7c1f5-8c5f-4715-b30c-e067f89ee278', 'ağacı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3b7c1f5-8c5f-4715-b30c-e067f89ee278', 'sokakta', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3b7c1f5-8c5f-4715-b30c-e067f89ee278', 'çocuktan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2c5e353b-b9dd-4b03-86fa-e8a20516831a', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlü düşmesi (hece düşmesi) örneği vardır?', 'Ünlü düşmesi kuralının işlediği kelimeleri cümlede belirler.', '''Burun'' kelimesi ünlüyle başlayan iyelik eki ''-u'' aldığında ikinci hecesindeki dar ünlü ''u'' düşerek ''burnu'' biçimini almıştır. Diğer cümlelerdeki kelimelerde böyle bir ses düşmesi yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c5e353b-b9dd-4b03-86fa-e8a20516831a', 'Burnu kanayan çocuğu hemen hastaneye götürdüler.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c5e353b-b9dd-4b03-86fa-e8a20516831a', 'Bahçedeki güller sabaha karşı açmıştı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c5e353b-b9dd-4b03-86fa-e8a20516831a', 'Kitapları düzenli bir şekilde masaya bıraktı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c5e353b-b9dd-4b03-86fa-e8a20516831a', 'Sınavdan beklediğinden yüksek bir not aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('406079d9-122e-4ef6-87b5-f09189820a42', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'orta'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde kaynaştırma ünsüzü kullanılmıştır?', 'Kaynaştırma ünsüzlerinin kullanıldığı kelimeleri ayırt eder.', 'Ünlüyle biten ''kapı'' kelimesi ünlüyle başlayan ''-ı'' ekini aldığında iki ünlünün yan yana gelmesini önlemek için araya ''y'' kaynaştırma ünsüzü girmiş ve ''kapıyı'' biçimi oluşmuştur. Diğer seçeneklerdeki ekler ünsüzle başladığı için kaynaştırma ünsüzüne gerek yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('406079d9-122e-4ef6-87b5-f09189820a42', 'kapıyı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('406079d9-122e-4ef6-87b5-f09189820a42', 'evden', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('406079d9-122e-4ef6-87b5-f09189820a42', 'kitaplar', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('406079d9-122e-4ef6-87b5-f09189820a42', 'sokakta', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1e48fe9b-5c1c-4e93-9f4f-be539159ebb9', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'zor'::difficulty_level, 'Aşağıdaki kelimelerden hangisi küçük ünlü uyumuna (düzlük-yuvarlaklık uyumuna) aykırıdır?', 'Küçük ünlü uyumu kuralını ileri düzeyde uygular.', 'Yuvarlak bir ünlüden (o) sonra ancak düz-geniş (a, e) ya da dar-yuvarlak (u, ü) bir ünlü gelebilir; ''doktor'' kelimesinde ise yuvarlak ''o'' ünlüsünden sonra yine geniş-yuvarlak ''o'' geldiği için kural bozulmuştur. Diğer kelimelerin tamamı küçük ünlü uyumuna uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e48fe9b-5c1c-4e93-9f4f-be539159ebb9', 'doktor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e48fe9b-5c1c-4e93-9f4f-be539159ebb9', 'kuzu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e48fe9b-5c1c-4e93-9f4f-be539159ebb9', 'çocuk', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e48fe9b-5c1c-4e93-9f4f-be539159ebb9', 'balık', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('8884d23b-b21f-4a37-b931-8de0e0921942', 'Bu konu; ''de/da'' bağlacı ile hâl eki, ''ki'' bağlacı ile ''-ki'' eki, ''mi'' soru eki ve büyük harf kullanımı gibi en sık karıştırılan yazım kurallarını örneklerle ele alır.', '## ''de/da'' Bağlacı ve Hâl Eki
Bağlaç olan ''de/da'' her zaman ayrı yazılır ve sertleşerek ''te/ta'' biçimini almaz: ''O da bizimle geldi.'' Cümleden çıkarıldığında anlam bütünlüğü bozulmuyorsa bağlaçtır. Bulunma hâli eki olan ''-de/-da'' ise bitişik yazılır ve sert ünsüzden sonra ''-te/-ta'' biçimine sertleşebilir: ''Evde kimse yoktu.'', ''Kitapta ilginç bilgiler vardı.''

## ''mi'' Soru Eki
Soru eki ''mi/mı/mu/mü'' her zaman kendinden önceki kelimeden ayrı yazılır; kendisinden sonra gelen ekler ise bitişik yazılır: ''Geliyor musun?'', ''Bu doğru mudur?''

## ''ki'' Bağlacı ve ''-ki'' Eki
Bağlaç olan ''ki'' ayrı yazılır: ''Biliyordum ki bu iş kolay olmayacak.'' Sıfat yapan ilgi eki ''-ki'' ise bitişik yazılır: ''Sokaktaki çocuklar, benimki, yarınki toplantı.'' ''Hâlbuki, mademki, oysaki, sanki, belki'' gibi kalıplaşmış sözcükler bitişik yazılır; bunlar artık bağlaç ''ki'' olarak değil, tek bir kelime olarak kabul edilir.

## Büyük Harf Kullanımı
Özel adlar (kişi, yer, kurum adları), unvanlardan sonra veya önce gelen özel adlar (Ahmet Bey, Doktor Ayşe), belirli bir tarih bildiren gün ve ay adları (29 Ekim Cumhuriyet Bayramı) büyük harfle başlar. Ancak mevsim adları (ilkbahar, yaz, sonbahar, kış) hiçbir zaman büyük harfle yazılmaz; genel ifadelerde kullanılan gün ve ay adları da (''Her ay toplanırız.'') küçük harfle yazılır.

## Bitişik Yazılan Bazı Yapılar
Anlam kayması olan kalıcı birleşik kelimeler (gecekondu, hanımeli) bitişik yazılır. Yazım kuralları çoğunlukla bir ''çıkarma testi'' ile denetlenir: kelime cümleden çıkarıldığında anlam bozuluyorsa genellikle bir ektir ve bitişik yazılır; anlam bozulmuyorsa genellikle bir bağlaçtır ve ayrı yazılır.', 'Örnek: ''Sen de mi bu işe karıştın?'' cümlesindeki yazım kurallarını değerlendiriniz.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('accc7040-cb71-4395-8f7b-33b08e83df82', '8884d23b-b21f-4a37-b931-8de0e0921942', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''de'' bağlaç olarak kullanılmış, bu nedenle ayrı yazılmıştır?', 'Bağlaç olan ''de/da'' ile hâl eki olan ''-de/-da''yı ayırt eder.', 'İkinci cümledeki ''da'', ''O bizimle gelmek istedi.'' cümlesinden çıkarıldığında anlam bütünlüğü bozulmadığı için bağlaçtır ve ayrı yazılır. Diğer cümlelerdeki ''-de'' ekleri isme bulunma hâli katan bir ek olduğu için bitişik yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('accc7040-cb71-4395-8f7b-33b08e83df82', 'Sende kalan kitabımı getirir misin?', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('accc7040-cb71-4395-8f7b-33b08e83df82', 'O da bizimle gelmek istedi.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('accc7040-cb71-4395-8f7b-33b08e83df82', 'Evde kimse yoktu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('accc7040-cb71-4395-8f7b-33b08e83df82', 'Bahçede oynayan çocukları gördüm.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c7e77e50-f0cb-4443-8cc6-77c18a2ee115', '8884d23b-b21f-4a37-b931-8de0e0921942', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''ki'' bağlaç olarak kullanılmış ve bu nedenle ayrı yazılmıştır?', 'Bağlaç ''ki'' ile sıfat yapan ''-ki'' ekini ayırt eder.', 'İkinci cümlede ''ki'', iki cümleyi birbirine bağlayan bir bağlaçtır ve ayrı yazılır. Diğer cümlelerde ''-ki'', isme sıfat ya da ilgi zamiri işlevi kazandıran bir ek olduğu için bitişik yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c7e77e50-f0cb-4443-8cc6-77c18a2ee115', 'Sokaktaki çocuklar top oynuyordu.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c7e77e50-f0cb-4443-8cc6-77c18a2ee115', 'Biliyordum ki bu iş kolay olmayacaktı.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c7e77e50-f0cb-4443-8cc6-77c18a2ee115', 'Benimki masanın üzerinde duruyor.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c7e77e50-f0cb-4443-8cc6-77c18a2ee115', 'Yarınki toplantıya katılamayacağım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('266752e8-9859-4c84-842b-6588aff83571', '8884d23b-b21f-4a37-b931-8de0e0921942', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı vardır?', '''-ki'' ekinin bitişik yazılması gereken durumları fark eder.', '''Yarın'' kelimesine gelen sıfat yapan ''-ki'' eki bitişik yazılmalıdır; doğru yazım ''yarınki'' biçimindedir. Diğer cümlelerdeki yazımlar kurallara uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('266752e8-9859-4c84-842b-6588aff83571', 'Yarın ki sınava çalışmalıyım.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('266752e8-9859-4c84-842b-6588aff83571', 'Sokaktaki köpek durmadan havlıyordu.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('266752e8-9859-4c84-842b-6588aff83571', 'O da toplantıya katılacağını söyledi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('266752e8-9859-4c84-842b-6588aff83571', 'Kitaptaki resimleri çok beğendim.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('619bb60f-ec96-44ae-a7c8-1e145b96e73e', '8884d23b-b21f-4a37-b931-8de0e0921942', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harf kullanımıyla ilgili bir yanlışlık vardır?', 'Mevsim adlarının büyük harfle yazılmadığı kuralını uygular.', 'Mevsim adları hiçbir zaman büyük harfle başlamaz; bu nedenle ''ilkbahar'' kelimesi küçük harfle yazılmalıdır. Diğer cümlelerdeki büyük harf kullanımları (unvan, özel gün adı, dil adı) doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('619bb60f-ec96-44ae-a7c8-1e145b96e73e', 'Bu yıl İlkbahar çok erken geldi.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('619bb60f-ec96-44ae-a7c8-1e145b96e73e', 'Ahmet Bey toplantıya geç kaldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('619bb60f-ec96-44ae-a7c8-1e145b96e73e', '29 Ekim Cumhuriyet Bayramı''nı coşkuyla kutladık.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('619bb60f-ec96-44ae-a7c8-1e145b96e73e', 'Türkçe dersinde güzel bir şiir okuduk.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5c5da4f2-b92a-4f66-9a2e-689166546078', '8884d23b-b21f-4a37-b931-8de0e0921942', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı yoktur?', 'Birden fazla yazım kuralını bir arada değerlendirerek doğru cümleyi belirler.', 'İkinci cümlede bağlaç olan ''de'' doğru biçimde ayrı, soru eki ''mi'' de kurala uygun olarak ayrı yazılmıştır. Diğer cümlelerde sırasıyla ''kitapta'' yerine ''kitapda'', ''yarınki'' yerine ''yarın ki'' ve ''onunki'' yerine ''onun ki'' kullanılarak yazım yanlışı yapılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c5da4f2-b92a-4f66-9a2e-689166546078', 'Kitapda ne yazdığını çok merak ediyorum.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c5da4f2-b92a-4f66-9a2e-689166546078', 'Sen de mi bu işe karıştın?', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c5da4f2-b92a-4f66-9a2e-689166546078', 'Yarın ki toplantıyı sakın unutma.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c5da4f2-b92a-4f66-9a2e-689166546078', 'Herkes onun ki kadar başarılı olamadı.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'Virgül, iki nokta, noktalı virgül, kesme işareti, üç nokta ve ünlem işaretinin doğru kullanım kurallarını örneklerle açıklayan bu konu, noktalama hatalarını ayırt etmeyi hedefler.', '## Virgül (,)
Eş görevli kelime veya kelime gruplarını sıralarken kullanılır: ''Çarşıdan elma, armut, muz ve şeftali aldı.'' Sıralı cümleleri, ara sözleri ve hitap sözlerini ayırmak için de virgül konur. ''Ve'' bağlacından hemen önce genellikle virgül kullanılmaz.

## İki Nokta (:)
Kendisinden sonra örnek verilecek, açıklama yapılacak ya da bir liste sıralanacak cümlenin sonuna konur: ''Kırtasiyeden şunları aldım: kalem, silgi, defter.'' Ayrıca alıntı sözlerden önce de kullanılır: ''Öğretmenimiz: ''Yarın sınav var.'' dedi.''

## Noktalı Virgül (;)
Virgüllerle ayrılmış öğe gruplarını birbirinden ayırmak için ya da bağlaç kullanılmadan birbirine bağlı cümleleri ayırmak için kullanılır: ''Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.''

## Kesme İşareti ('')
Özel isimlere getirilen çekim eklerini ayırmak için kullanılır: ''İstanbul''da, Ahmet''in, Türkiye''ye.'' Cins (tür bildiren) isimlere gelen ekler kesme işaretiyle ayrılmaz: ''kalemi, öğretmene, kitabı'' gibi.

## Üç Nokta (...)
Tamamlanmamış cümlelerin sonuna, sözün bir yerde kesildiğini göstermek için ya da kaba sayılan sözlerin yerine kullanılır.

## Ünlem İşareti (!)
Sevinç, kızgınlık, korku, şaşkınlık gibi güçlü duyguları anlatan cümlelerin ve seslenme sözlerinin sonuna konur: ''Ne güzel bir manzara!''

Doğru noktalama, hem okunabilirliği artırır hem de cümlenin anlamını netleştirir; bu nedenle KPSS''de noktalama işaretlerinin yerinde kullanılıp kullanılmadığı sıkça sorulur.', 'Örnek: ''Öğretmenimiz Yarın sınav var dedi.'' cümlesinde hangi noktalama işaretleri eksiktir?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('566138c1-9fd5-468d-8bb1-37d9ec6b2b5c', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmıştır?', 'Kesme işaretinin özel isimlere gelen eklerde kullanıldığını kavrar.', '''Ahmet'' bir özel isim olduğu için aldığı ''-in'' eki kesme işaretiyle ayrılmıştır. Diğer seçeneklerdeki ''kalem, öğretmen, kitap'' cins isim olduğundan aldıkları ekler kesme işaretiyle ayrılmaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('566138c1-9fd5-468d-8bb1-37d9ec6b2b5c', 'Ahmet''in kitabını dün akşam okudum.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('566138c1-9fd5-468d-8bb1-37d9ec6b2b5c', 'Kalem''imi masanın üstünde unuttum.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('566138c1-9fd5-468d-8bb1-37d9ec6b2b5c', 'Öğretmen''e ödevimi teslim ettim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('566138c1-9fd5-468d-8bb1-37d9ec6b2b5c', 'Kitab''ı çantama koydum.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d4507a5c-5eb1-46ee-b12d-e9b34325caae', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde virgül (,) doğru bir yerde kullanılmıştır?', 'Sıralama bildiren cümlelerde virgülün doğru kullanımını uygular.', 'Eş görevli kelimeler olan ''elma, armut, muz'' birbirinden virgülle ayrılmış, son öğeden önce ''ve'' bağlacı kullanıldığı için virgüle gerek duyulmamıştır. Diğer seçeneklerde virgüller anlamsız ya da gereksiz yerlere konmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d4507a5c-5eb1-46ee-b12d-e9b34325caae', 'Çarşıdan elma, armut, muz ve şeftali aldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d4507a5c-5eb1-46ee-b12d-e9b34325caae', 'Çarşıdan, elma armut muz ve şeftali aldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d4507a5c-5eb1-46ee-b12d-e9b34325caae', 'Çarşıdan elma armut, muz ve, şeftali aldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d4507a5c-5eb1-46ee-b12d-e9b34325caae', 'Çarşıdan elma armut muz, ve şeftali, aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('12c78daa-2f18-4a26-a762-46b8b4c82f81', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde iki nokta (:) doğru kullanılmıştır?', 'İki noktanın örnek/liste verme işlevini kavrar.', 'Birinci cümlede iki nokta, kendisinden sonra bir liste (örnek) sıralanacağını haber verdiği için doğru kullanılmıştır. Diğer cümlelerde iki noktayı gerektiren bir açıklama ya da örnekleme durumu yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('12c78daa-2f18-4a26-a762-46b8b4c82f81', 'Kırtasiyeden şunları aldım: kalem, silgi, defter.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('12c78daa-2f18-4a26-a762-46b8b4c82f81', 'Yarın: erken kalkıp işe gideceğim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('12c78daa-2f18-4a26-a762-46b8b4c82f81', 'Bahçede: çiçekler yeni açmıştı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('12c78daa-2f18-4a26-a762-46b8b4c82f81', 'O gün: eve oldukça geç geldi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('37676d5f-b1f1-4479-a08f-2fd57af64ac3', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalı virgül (;) doğru kullanılmıştır?', 'Noktalı virgülün virgüllerle ayrılmış öğe gruplarını ayırma işlevini uygular.', 'Birinci cümlede virgüllerle ayrılmış iki farklı kişi grubu (''Ali, Veli, Ayşe'' ve ''Mehmet, Fatma'') noktalı virgülle birbirinden ayrılmıştır. Diğer cümlelerde noktalı virgül gereksiz yere, herhangi bir öğe grubunu ayırmadan kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37676d5f-b1f1-4479-a08f-2fd57af64ac3', 'Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37676d5f-b1f1-4479-a08f-2fd57af64ac3', 'Bu kitabı; okuyup çok beğendim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37676d5f-b1f1-4479-a08f-2fd57af64ac3', 'Yarın; erkenden okula gideceğim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37676d5f-b1f1-4479-a08f-2fd57af64ac3', 'Akşam; ailecek yemek yedik.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a05132ab-2855-4597-9dfa-a577a234a09d', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin tamamı doğru kullanılmıştır?', 'Birden fazla noktalama kuralını bir arada değerlendirerek doğru cümleyi seçer.', 'İkinci cümlede iki nokta, kendisinden sonra gelen alıntı sözden önce doğru biçimde kullanılmış, tırnak içindeki alıntı da doğru noktalanmıştır. Diğer cümlelerde noktalı virgül gereksiz yere kullanılmış ya da ''masadaki'' kelimesine yanlışlıkla kesme işareti eklenmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a05132ab-2855-4597-9dfa-a577a234a09d', 'Ahmet''e, İstanbul''dan gelen; mektubu hemen verdim.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a05132ab-2855-4597-9dfa-a577a234a09d', 'Öğretmenimiz: ''Yarın sınav var.'' dedi.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a05132ab-2855-4597-9dfa-a577a234a09d', 'Masada''ki kitapları, düzenle dedi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a05132ab-2855-4597-9dfa-a577a234a09d', 'Çarşıya gidip; elma, armut aldım.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('7ec4f569-8e17-456f-b938-c05e33b7a53c', 'Gerçek, mecaz, yan ve terim anlam ile eş anlam, zıt anlam, sesteşlik ve deyimlerin cümle içindeki kullanımını örneklerle işleyen sözcükte anlam konusu.', '## Gerçek (Temel) Anlam ve Mecaz Anlam
Bir kelimenin ilk akla gelen, sözlükteki asıl anlamına gerçek (temel) anlam denir: ''Bu çanta çok ağırdı.'' Kelimenin benzetme yoluyla kazandığı, gerçek anlamından uzaklaşmış anlamına ise mecaz anlam denir: ''Sınav soruları oldukça ağırdı.'' (zor anlamında)

## Yan Anlam ve Terim Anlam
Bir kelimenin temel anlamıyla ilgili fakat ondan biraz uzaklaşmış anlamına yan anlam denir: ''Masanın ayağı kırıldı.'' Bir bilim, sanat veya meslek dalına özgü kavramı karşılayan anlama ise terim anlam denir: ''Bu cümlenin öznesini bulun.'' veya ''Kelimenin kökünü belirleyin.''

## Eş Anlam (Anlamdaş) ve Zıt Anlam (Karşıt)
Yazılışları farklı, anlamları aynı veya çok yakın olan kelimelere eş anlamlı (anlamdaş) denir: ''kara-siyah, misafir-konuk.'' Birbirinin karşıtı olan kelimelere ise zıt anlamlı (karşıt) denir: ''büyük-küçük, sıcak-soğuk.''

## Eş Sesli (Sesteş) Kelimeler
Yazılışları aynı, anlamları farklı kelimelere sesteş (eş sesli) denir: ''Yüzünde bir gülümseme vardı.'' (yüz=çehre) ile ''Denizde saatlerce yüzdü.'' (yüz=yüzmek eylemi) cümlelerindeki ''yüz'' kelimeleri sesteştir.

## Deyimler
İki veya daha fazla kelimeden oluşan, çoğunlukla mecazlı anlam taşıyan kalıplaşmış söz gruplarına deyim denir: ''eli kulağında'' (bir işin bitmesine az kalmış olması), ''içi kararmak'' (çok üzülmek). Deyimler, cümle içinde kalıplaşmış anlamlarıyla ve bu anlama uygun bağlamda kullanılmalıdır; anlamına ters düşen bir bağlamda kullanılması anlatım bozukluğuna yol açar.', '''Eli kulağında'' deyimi aşağıdaki cümlelerin hangisinde doğru kullanılmıştır?');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4170e6be-f2a2-43ae-b5f7-3bda2aac533c', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''ağır'' sözcüğü mecaz anlamda kullanılmıştır?', 'Gerçek anlam ile mecaz anlamı ayırt eder.', 'İkinci cümlede ''ağır'' sözcüğü fiziksel bir ağırlığı değil, ''zor, çetin'' anlamını karşıladığı için mecaz anlamda kullanılmıştır. Diğer cümlelerde ''ağır'' sözcüğü nesnenin gerçek fiziksel ağırlığını belirtir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4170e6be-f2a2-43ae-b5f7-3bda2aac533c', 'Bu çanta gerçekten çok ağırdı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4170e6be-f2a2-43ae-b5f7-3bda2aac533c', 'Sınav soruları oldukça ağırdı.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4170e6be-f2a2-43ae-b5f7-3bda2aac533c', 'Valizi taşırken sırtım ağrıdı, çünkü çok ağırdı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4170e6be-f2a2-43ae-b5f7-3bda2aac533c', 'Demir, ağır bir madendir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c31304a3-73fb-4c8a-8ff9-b7d9aa5aef88', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'kolay'::difficulty_level, 'Aşağıdaki kelime çiftlerinden hangisi eş anlamlıdır (anlamdaştır)?', 'Eş anlamlı (anlamdaş) kelimeleri tanır.', '''Kara'' ve ''siyah'' kelimeleri aynı rengi karşıladığı için eş anlamlıdır. Diğer seçeneklerdeki kelime çiftleri ise birbirinin zıt anlamlısıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c31304a3-73fb-4c8a-8ff9-b7d9aa5aef88', 'kara - siyah', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c31304a3-73fb-4c8a-8ff9-b7d9aa5aef88', 'büyük - küçük', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c31304a3-73fb-4c8a-8ff9-b7d9aa5aef88', 'sıcak - soğuk', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c31304a3-73fb-4c8a-8ff9-b7d9aa5aef88', 'ışık - karanlık', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b22370b6-9e82-4512-b180-be56179a95b3', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'orta'::difficulty_level, '''Eli kulağında'' deyimi aşağıdaki cümlelerin hangisinde doğru kullanılmıştır?', 'Deyimlerin cümle içindeki uygun kullanımını değerlendirir.', '''Eli kulağında'' deyimi bir işin bitmesine çok az kaldığını anlatır; birinci cümlede projenin yakında tamamlanacağı belirtildiği için deyim doğru bağlamda kullanılmıştır. Diğer cümlelerde deyimin anlamıyla cümlenin geri kalanı çelişmektedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b22370b6-9e82-4512-b180-be56179a95b3', 'Proje eli kulağında, birkaç güne kadar tamamlanmış olacak.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b22370b6-9e82-4512-b180-be56179a95b3', 'Bu iş eli kulağında, çünkü daha yeni başladık.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b22370b6-9e82-4512-b180-be56179a95b3', 'O her zaman eli kulağında biriydi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b22370b6-9e82-4512-b180-be56179a95b3', 'Param eli kulağında bittiği için borç almak zorunda kaldım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ef49f725-2875-4404-a17e-e857698118c7', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''yüz'' sözcüğü diğerlerinden farklı bir anlamda (sesteş olarak) kullanılmıştır?', 'Sesteş (eş sesli) kelimeleri cümle bağlamında ayırt eder.', 'İkinci cümlede ''yüzdü'', ''yüzmek'' eyleminden gelir ve suda hareket etmeyi ifade eder; diğer cümlelerdeki ''yüz'' ise ''çehre, surat'' anlamındaki isimdir. Yazılışları aynı fakat anlamları farklı olduğu için bu kelimeler sesteştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ef49f725-2875-4404-a17e-e857698118c7', 'Yüzünde güzel bir gülümseme vardı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ef49f725-2875-4404-a17e-e857698118c7', 'Denizde saatlerce yüzdü.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ef49f725-2875-4404-a17e-e857698118c7', 'Yüzü hafif kızarmıştı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ef49f725-2875-4404-a17e-e857698118c7', 'Onun yüzüne bakamadım.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('603121f0-373b-45b7-bc8e-7f5ca3a7e163', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'zor'::difficulty_level, '''Kök'' sözcüğü aşağıdaki cümlelerin hangisinde terim anlamda (dil bilgisi terimi olarak) kullanılmıştır?', 'Terim anlamı gerçek ve mecaz anlamdan ayırt eder.', 'İkinci cümlede ''kök'', bir kelimenin anlam taşıyan en küçük parçasını belirten dil bilgisi terimi olarak kullanılmıştır. Diğer cümlelerde ''kök'' sözcüğü sırasıyla gerçek anlamda (bitki kökü) ve mecaz anlamda (kaynak, köken) kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('603121f0-373b-45b7-bc8e-7f5ca3a7e163', 'Bahçedeki ağacın kökü çok derinlere inmişti.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('603121f0-373b-45b7-bc8e-7f5ca3a7e163', 'Bu kelimenin kökü Arapçadır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('603121f0-373b-45b7-bc8e-7f5ca3a7e163', 'Sorunun kökünü araştırmalıyız.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('603121f0-373b-45b7-bc8e-7f5ca3a7e163', 'Bu ailenin kökleri çok eskiye dayanıyor.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'Anlatım bozukluğu türlerini (gereksiz sözcük, çelişki, mantık hatası, tamlama yanlışlığı), öznel-nesnel yargı ayrımını ve cümle tamamlamayı örneklerle açıklayan konu.', '## Anlatım Bozukluğu Türleri
Anlatım bozukluğu, bir cümlede anlam veya dil bilgisi açısından ortaya çıkan hatalardır. Başlıca türleri:
- **Gereksiz sözcük kullanımı:** Aynı anlama gelen iki kelimenin bir arada kullanılması. ''Bu haber beni hem çok sevindirdi hem de mutlu etti.'' (sevindirmek ve mutlu etmek eş anlamlıdır, biri gereksizdir.)
- **Çelişki:** Cümledeki iki ifadenin birbiriyle çelişmesi. ''Belki de bu sınavı kesinlikle kazanacak.'' (''belki'' ihtimal, ''kesinlikle'' kesinlik bildirir; bir arada kullanılamaz.)
- **Mantık (neden-sonuç) hatası:** Cümledeki neden ile sonucun birbiriyle uyuşmaması. ''Param olmadığı için kitabı alamadım ama yine de aldım.''
- **Tamlama yanlışlığı:** Ortak kullanılan bir öğeye ait ekin eksik bırakılması. ''Ali ve babasının arabası kaza yaptı.'' cümlesinde ''Ali'' kelimesinden sonra ''-nin'' tamlayan eki eksiktir; doğrusu ''Ali''nin ve babasının arabası'' olmalıdır.

## Öznel Yargı ve Nesnel Yargı
Nesnel yargı, kişiden kişiye değişmeyen, kanıtlanabilir, gözlemlenebilir bilgi içeren yargıdır: ''Roman 320 sayfadan oluşmaktadır.'' Öznel yargı ise kişisel görüş, beğeni ya da yorum içerir ve kişiden kişiye değişebilir: ''Bence bu roman çok sıkıcıydı.'' ''En, en güzel, bence, bana göre, sanırım'' gibi ifadeler genellikle öznelliğin işaretidir.

## Cümle Tamamlama
Bir cümlenin ya da paragrafın bağlamına en uygun ifadeyi seçmek, cümledeki anlam bütünlüğünü ve mantıksal akışı bozmayan seçeneği bulmayı gerektirir. Doğru seçenek, metinde verilen bilgilerle çelişmemeli ve konu dışına çıkmamalıdır.', '''Belki de bu sınavı kesinlikle kazanacak.'' cümlesindeki anlatım bozukluğunun türünü belirtiniz.');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('529bc291-091b-484a-a64e-7124475a5526', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisi nesnel bir yargı bildirmektedir?', 'Öznel yargı ile nesnel yargıyı ayırt eder.', 'Birinci cümlede sayfa sayısı, kişiden kişiye değişmeyen, kanıtlanabilir bir bilgi olduğu için nesneldir. Diğer cümleler kişisel görüş ve beğeni içerdiğinden özneldir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('529bc291-091b-484a-a64e-7124475a5526', 'Roman, 320 sayfadan oluşmaktadır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('529bc291-091b-484a-a64e-7124475a5526', 'Bence bu roman çok sıkıcıydı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('529bc291-091b-484a-a64e-7124475a5526', 'Yazarın en başarılı eseri budur.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('529bc291-091b-484a-a64e-7124475a5526', 'Bu film gelmiş geçmiş en iyi yapımdı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b3ca0c6a-972c-453b-91b9-e0be2c0c73a8', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Gereksiz sözcük kullanımından kaynaklanan anlatım bozukluğunu fark eder.', '''Sevindirmek'' ve ''mutlu etmek'' aynı anlama geldiği için bu iki ifadenin bir arada kullanılması gereksiz tekrara, dolayısıyla anlatım bozukluğuna yol açmıştır. Diğer cümlelerde böyle bir tekrar yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3ca0c6a-972c-453b-91b9-e0be2c0c73a8', 'Bu haber beni hem çok sevindirdi hem de mutlu etti.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3ca0c6a-972c-453b-91b9-e0be2c0c73a8', 'Öğrenciler sınava iyi hazırlandı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3ca0c6a-972c-453b-91b9-e0be2c0c73a8', 'Kitabı okuyup arkadaşına anlattı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b3ca0c6a-972c-453b-91b9-e0be2c0c73a8', 'Yağmur yağınca sokaklar ıslandı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cb997a3d-570a-4680-8152-be4db6625d83', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Çelişkiden kaynaklanan anlatım bozukluğunu tespit eder.', '''Belki'' ihtimal, ''kesinlikle'' ise kesinlik bildirir; bu iki ifade anlamca birbiriyle çeliştiği için cümlede anlatım bozukluğu vardır. Diğer cümlelerde böyle bir çelişki bulunmamaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cb997a3d-570a-4680-8152-be4db6625d83', 'Belki de bu sınavı kesinlikle kazanacak.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cb997a3d-570a-4680-8152-be4db6625d83', 'Öğretmen konuyu tekrar anlattı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cb997a3d-570a-4680-8152-be4db6625d83', 'Sabah erkenden yola çıktık.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cb997a3d-570a-4680-8152-be4db6625d83', 'Kitapları düzenli bir şekilde raflara yerleştirdi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6fc27344-ecc9-4910-8ba9-8543f7ce7886', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Neden-sonuç ilişkisindeki mantık hatasını fark eder.', 'Cümlede önce parası olmadığı için kitabı alamadığı söylenmiş, ardından yine de aldığı belirtilerek çelişkili bir mantık hatası oluşturulmuştur. Diğer cümlelerde neden ile sonuç arasında tutarlı bir ilişki vardır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6fc27344-ecc9-4910-8ba9-8543f7ce7886', 'Param olmadığı için kitabı alamadım ama yine de aldım.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6fc27344-ecc9-4910-8ba9-8543f7ce7886', 'Erken kalktığım için derse zamanında yetiştim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6fc27344-ecc9-4910-8ba9-8543f7ce7886', 'Yorgun olduğu için erken yattı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6fc27344-ecc9-4910-8ba9-8543f7ce7886', 'Kitabı bitirince bana geri verdi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('69b0fd7a-4984-4bb9-808f-f2cd319aa169', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?', 'Tamlama yanlışlığından kaynaklanan anlatım bozukluğunu ileri düzeyde tespit eder.', '''Ali'' kelimesinden sonra tamlayan eki ''-nin'' eksik bırakıldığı için cümlede tamlama yanlışlığı vardır; doğrusu ''Ali''nin ve babasının arabası'' biçiminde olmalıdır. Diğer cümlelerde böyle bir ek eksikliği yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('69b0fd7a-4984-4bb9-808f-f2cd319aa169', 'Ali ve babasının arabası kaza yaptı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('69b0fd7a-4984-4bb9-808f-f2cd319aa169', 'Ali''nin ve babasının arabası kaza yaptı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('69b0fd7a-4984-4bb9-808f-f2cd319aa169', 'Öğrenciler sınıfa girdi ve yerlerine oturdu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('69b0fd7a-4984-4bb9-808f-f2cd319aa169', 'Yağmur dinince hep birlikte dışarı çıktık.', false, 3);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'Paragrafta ana düşünce ve yardımcı düşünceyi ayırt etme, paragraf tamamlama ve metinden çıkarılabilecek/çıkarılamayacak yargıları belirleme becerilerini işleyen konu.', '## Konu ve Ana Düşünce
Bir paragrafın neyle ilgili olduğunu belirten kavrama konu denir; yazarın bu konu hakkında okura iletmek istediği asıl mesaja ise ana düşünce denir. Ana düşünce genellikle paragrafın son cümlesinde, bazen de ilk cümlesinde yer alır ve paragraftaki tüm cümleleri kapsayan bir yargı niteliğindedir.

## Yardımcı Düşünce
Ana düşünceyi destekleyen, açıklayan veya örnekleyen düşüncelere yardımcı düşünce denir. Bir paragrafta birden fazla yardımcı düşünce bulunabilir, ancak ana düşünce tektir.

## Paragraf Tamamlama
Paragrafın başına, ortasına ya da sonuna getirilecek cümle; paragrafın anlam bütünlüğünü, konu akışını ve mantık örgüsünü bozmamalıdır. Başa gelecek cümle genellikle konuyu tanıtır; sona gelecek cümle ise paragrafta anlatılanların bir sonucu, genellemesi ya da tamamlayıcısı niteliğinde olmalıdır. Doğru seçenek metindeki bilgilerle çelişmemeli ve konu dışına çıkmamalıdır.

## Metinden Çıkarılabilecek Yargılar
''Bu parçadan hangi yargıya ulaşılabilir/ulaşılamaz'' tipi sorularda, seçeneklerin metinde açıkça ifade edilen ya da metinden mantıksal olarak çıkarılabilen bilgilerle örtüşüp örtüşmediğine bakılır. Metinde yer almayan, aşırı genelleme içeren ya da metinle çelişen seçenekler yanlıştır.

## Anlatım Biçimleri
Paragraflarda yazarın öznel ya da nesnel bir bakış açısıyla yazıp yazmadığı; örnekleme, tanık gösterme, karşılaştırma gibi düşünceyi geliştirme yollarının kullanılıp kullanılmadığı da sıkça sorulur.', 'Aşağıdaki paragrafın ana düşüncesi ne olabilir? ''Kitap okumak, insanın hayal gücünü geliştirir, kelime dağarcığını zenginleştirir...''');
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('66da05fb-c5be-4dfe-838d-989c9cedc5ec', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'kolay'::difficulty_level, '''İnsanlar günlük hayatlarında birçok karar verir. Bu kararların bazıları küçük, bazıları ise hayatı derinden etkileyecek kadar büyüktür. Küçük kararlar genellikle anlık düşünülüp hızla alınırken büyük kararlar için uzun süre düşünülür, çevredeki insanların fikirleri alınır. Çünkü büyük kararların sonuçları, kişinin hayatını uzun yıllar etkileyebilir.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?', 'Paragrafın ana düşüncesini belirler.', 'Parça, büyük kararların uzun süre düşünülerek ve başkalarının görüşü alınarak verilmesi gerektiğini, çünkü sonuçlarının kalıcı olduğunu vurgulamaktadır. Diğer seçenekler ya parçanın yalnızca bir kısmını yansıtır ya da metinde yer almayan aşırı bir genelleme içerir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66da05fb-c5be-4dfe-838d-989c9cedc5ec', 'İnsanlar hayatları boyunca sürekli karar alma durumundadır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66da05fb-c5be-4dfe-838d-989c9cedc5ec', 'Büyük kararlar, sonuçlarının kalıcı etkisi nedeniyle daha dikkatli ve uzun düşünülerek alınmalıdır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66da05fb-c5be-4dfe-838d-989c9cedc5ec', 'Küçük kararlar hızlı alındığı için önemsizdir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('66da05fb-c5be-4dfe-838d-989c9cedc5ec', 'Çevredeki insanların fikirleri her zaman doğru kararlar verdirir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aa434fc9-1894-46c6-9ed5-b9c52b73c5e1', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'kolay'::difficulty_level, '''Kitap okumak, insanın hayal gücünü geliştirir, kelime dağarcığını zenginleştirir ve empati kurma becerisini artırır. Ayrıca düzenli kitap okuyan bireylerin analitik düşünme yetenekleri de gelişir. Bu nedenle ______'' Bu parçada boş bırakılan yere aşağıdakilerden hangisi getirilmelidir?', 'Paragrafın anlam akışına uygun tamamlama cümlesini seçer.', 'Parçada kitap okumanın sağladığı faydalar sıralandığı için mantıksal sonuç, bu alışkanlığın erken yaşta kazandırılması gerektiğidir. Diğer seçenekler parçanın konusuyla ilgisizdir ya da metinde değinilmeyen konulara değinir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa434fc9-1894-46c6-9ed5-b9c52b73c5e1', 'televizyon izlemek de kitap okumak kadar faydalıdır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa434fc9-1894-46c6-9ed5-b9c52b73c5e1', 'çocuklara küçük yaştan itibaren kitap okuma alışkanlığı kazandırılmalıdır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa434fc9-1894-46c6-9ed5-b9c52b73c5e1', 'kitap okumanın hiçbir zararı yoktur.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa434fc9-1894-46c6-9ed5-b9c52b73c5e1', 'herkesin aynı türde kitap okuması gerekir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5fc43a40-dc34-41aa-990d-218bf5988bb9', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'orta'::difficulty_level, '''Şehirlerin hızla büyümesiyle birlikte yeşil alanlar giderek azalmaktadır. Betonlaşan kentlerde hava kalitesi düşmekte, sıcaklık artışları daha belirgin hissedilmektedir. Bununla birlikte bazı belediyeler, çatı bahçeleri ve dikey ormanlar gibi projelerle bu soruna çözüm aramaktadır. Ancak bu çabalar, kaybedilen yeşil alanların yerini tam olarak dolduramamaktadır.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?', 'Paragrafta ana düşünce ile yardımcı düşünceleri ayırt eder.', 'Parça, kentleşmeyle azalan yeşil alanlar için belediyelerin çözüm aradığını ama bu çabaların yeterli olmadığını vurgulamaktadır. Diğer seçenekler metinle çelişir ya da metinde yapılmayan bir karşılaştırma veya aşırı genelleme içerir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5fc43a40-dc34-41aa-990d-218bf5988bb9', 'Belediyeler çevre sorunlarına duyarsız kalmaktadır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5fc43a40-dc34-41aa-990d-218bf5988bb9', 'Kentleşmeyle azalan yeşil alanların yerini, alınan önlemler yeterince dolduramamaktadır.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5fc43a40-dc34-41aa-990d-218bf5988bb9', 'Çatı bahçeleri, dikey ormanlardan daha etkilidir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5fc43a40-dc34-41aa-990d-218bf5988bb9', 'Hava kalitesi yalnızca sıcaklıkla ilgilidir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('be8f37ce-f4d1-4ef2-983d-a8fd159f493a', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'orta'::difficulty_level, '''______ Bu tür kitaplar, karmaşık bilimsel kavramları sade bir dille anlatarak okurun ilgisini çeker. Yazar, günlük hayattan örnekler kullanarak konuyu somutlaştırır. Böylece bilim, sadece uzmanların değil herkesin anlayabileceği bir alan hâline gelir.'' Bu parçanın başına aşağıdaki cümlelerden hangisi getirilmelidir?', 'Paragrafın başına gelecek en uygun giriş cümlesini belirler.', 'Parçanın devamında ''bu tür kitaplar'' ifadesiyle atıf yapılan konu, ancak popüler bilim kitaplarını tanıtan birinci seçenekle uyumludur. Diğer seçenekler parçanın konusuyla ilgisizdir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be8f37ce-f4d1-4ef2-983d-a8fd159f493a', 'Popüler bilim kitapları, bilimi geniş kitlelere ulaştırmayı amaçlayan eserlerdir.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be8f37ce-f4d1-4ef2-983d-a8fd159f493a', 'Bilim insanları genellikle yalnız çalışmayı tercih eder.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be8f37ce-f4d1-4ef2-983d-a8fd159f493a', 'Roman yazarları hayal gücünü kullanarak eser üretir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('be8f37ce-f4d1-4ef2-983d-a8fd159f493a', 'Her kitap mutlaka bir amaç taşımalıdır.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a54a377f-9f5d-444a-b186-486ffd096ea4', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'zor'::difficulty_level, '''Bir sanat eserinin değeri, yalnızca teknik ustalıkla ölçülemez. Tuval üzerine ustaca işlenmiş bir tablo, izleyicide hiçbir duygu uyandırmıyorsa amacına ulaşamamış demektir. Oysa bazen çok basit çizgilerle oluşturulmuş bir eser, izleyicisini derinden etkileyebilir, onu düşünmeye sevk edebilir. Bu nedenle sanatı değerlendirirken teknik beceri kadar, eserin izleyicide bıraktığı etkiye de bakmak gerekir.'' Bu parçadan aşağıdaki yargılardan hangisine ulaşılamaz?', 'Paragraftan çıkarılabilecek ve çıkarılamayacak yargıları ayırt eder.', 'Parçada sanatçının ününden hiç söz edilmediği için dördüncü seçenekteki yargıya metinden ulaşılamaz. Diğer seçenekler parçada doğrudan ya da dolaylı olarak ifade edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a54a377f-9f5d-444a-b186-486ffd096ea4', 'Teknik açıdan kusursuz bir eser, izleyicide duygu uyandırmayabilir.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a54a377f-9f5d-444a-b186-486ffd096ea4', 'Basit görünen eserler de izleyici üzerinde güçlü bir etki bırakabilir.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a54a377f-9f5d-444a-b186-486ffd096ea4', 'Bir sanat eserini değerlendirirken hem teknik beceri hem de duygusal etki göz önünde bulundurulmalıdır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a54a377f-9f5d-444a-b186-486ffd096ea4', 'Sanat eserlerinin değeri, yalnızca sanatçının ününe göre belirlenir.', true, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('abee70c0-fb52-4de0-bd14-8f64282b0c88', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'kolay'::difficulty_level, '"Gitti + i" birleşiminde olduğu gibi düz-dar bir ünlüyle biten fiil kök/gövdesine "-yor" eki geldiğinde hangi ses olayı görülür?', 'Ünlü daralmasını fark eder.', '"Bekle-" gibi geniş ünlüyle (e, a) biten fiillere "-yor" eki geldiğinde son hecedeki geniş ünlü daralarak "i, ı, u, ü"ye dönüşür: bekle-yor → bekliyor. Bu olaya ünlü daralması denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abee70c0-fb52-4de0-bd14-8f64282b0c88', 'bekliyor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abee70c0-fb52-4de0-bd14-8f64282b0c88', 'geliyor', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abee70c0-fb52-4de0-bd14-8f64282b0c88', 'biliyor', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('abee70c0-fb52-4de0-bd14-8f64282b0c88', 'gidiyor', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bf59f485-4e62-4513-98f4-64cfc42fc266', 'a8f86b1e-13a3-4347-9a39-b32f15d12f33', 'orta'::difficulty_level, '"Kitap+cı" birleşiminde görüldüğü gibi, sert ünsüzle biten bir kelimeye yumuşak ünsüzle başlayan bir ek geldiğinde ekin ünsüzünün sertleşmesine ne ad verilir?', 'Ünsüz benzeşmesi (sertleşme) kuralını tanır.', '"Fıstıkçı şahap" sözündeki sert ünsüzlerden (ç, f, h, k, p, s, ş, t) biriyle biten bir kelimeye "c, d, g" gibi yumuşak bir ünsüzle başlayan ek gelirse, ekin ünsüzü sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta. Bu ses olayına ünsüz benzeşmesi (sertleşmesi) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf59f485-4e62-4513-98f4-64cfc42fc266', 'Ünsüz benzeşmesi (sertleşme)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf59f485-4e62-4513-98f4-64cfc42fc266', 'Ünsüz yumuşaması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf59f485-4e62-4513-98f4-64cfc42fc266', 'Ünlü düşmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf59f485-4e62-4513-98f4-64cfc42fc266', 'Kaynaştırma', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e56c1015-9363-4beb-b1dd-9364ea879a81', '8884d23b-b21f-4a37-b931-8de0e0921942', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harflerin kullanımıyla ilgili bir yazım yanlışı vardır?', 'Özel isimlerde büyük harf kullanımını uygular.', 'Ay ve mevsim adları özel isim olmadığı için büyük harfle başlamaz; "Mayıs" değil "mayıs" yazılmalıdır. Diğer seçeneklerde büyük harf kullanımı kurallara uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e56c1015-9363-4beb-b1dd-9364ea879a81', 'Okullar Mayıs ayında tatile girecek.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e56c1015-9363-4beb-b1dd-9364ea879a81', 'Ahmet Bey toplantıya geç kaldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e56c1015-9363-4beb-b1dd-9364ea879a81', 'Türkiye Cumhuriyeti 1923''te kuruldu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e56c1015-9363-4beb-b1dd-9364ea879a81', 'Anadolu''nun ortasında küçük bir köy vardı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('10f14040-4093-4b10-be92-0896a5013fac', '8884d23b-b21f-4a37-b931-8de0e0921942', 'orta'::difficulty_level, '"de/da" bağlacının yazımıyla ilgili aşağıdaki cümlelerin hangisinde bir yazım yanlışı yapılmıştır?', 'Bağlaç "de/da" ile bulunma hâli ekini ayırt eder.', '"Bu da" cümlesinde "da" bir bağlaç olup ayrı yazılmalıdır: "O da geldi." "Odada" örneğinde ise "-da" bulunma hâli eki olduğu için bitişik yazılır. "Sende" örneğinde "-de" bulunma eki olduğundan bitişik doğru bir kullanımdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10f14040-4093-4b10-be92-0896a5013fac', 'Ali de bize katıldı ama o da geç kaldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10f14040-4093-4b10-be92-0896a5013fac', 'Kitap masadaydı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10f14040-4093-4b10-be92-0896a5013fac', 'Sende kalsın bu anahtar.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10f14040-4093-4b10-be92-0896a5013fac', 'O da bizimle gelecek.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0c230058-62ab-4f92-95a8-d19cc475c55e', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmamıştır?', 'Kesme işaretinin özel isimlerde ve eklerde kullanımını uygular.', 'Kurum, kuruluş ve kısaltmalara gelen ekler kesme işaretiyle ayrılmaz: "TBMM''de" değil, kısaltmalar zaten büyük harfle yazıldığından ek kesmeyle ayrılır — asıl yanlış "Türkiye''nin" gibi doğru kullanımların yanında "okulun" gibi cins isimlere kesme eklenmesidir; "Okul''un bahçesi" yanlıştır çünkü "okul" özel isim değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0c230058-62ab-4f92-95a8-d19cc475c55e', 'Okul''un bahçesi çok güzeldi.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0c230058-62ab-4f92-95a8-d19cc475c55e', 'Ankara''ya yarın gideceğiz.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0c230058-62ab-4f92-95a8-d19cc475c55e', 'TBMM''de önemli bir görüşme yapıldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0c230058-62ab-4f92-95a8-d19cc475c55e', 'Atatürk''ün ilkeleri hâlâ geçerlidir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6901eba6-5dd3-44fd-abd6-80a70f12c819', 'e4c83fb7-a30c-4b9e-ba7c-704b9ac4b576', 'orta'::difficulty_level, '"Kardeşim  gel buraya  dedi." cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri gelmelidir?', 'Doğrudan aktarılan cümlelerde noktalama işaretlerini doğru kullanır.', 'Doğrudan aktarılan (tırnak içine alınan) cümleden önce iki nokta, aktarılan cümlenin sonunda ise tırnak içinde uygun noktalama kullanılır: Kardeşim: "Gel buraya." dedi.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6901eba6-5dd3-44fd-abd6-80a70f12c819', ': " ... ."', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6901eba6-5dd3-44fd-abd6-80a70f12c819', ', " ... "', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6901eba6-5dd3-44fd-abd6-80a70f12c819', '; " ... "', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6901eba6-5dd3-44fd-abd6-80a70f12c819', '... " ... "', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7f1f01ce-9f79-4a09-9a12-600cd57980d7', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'kolay'::difficulty_level, '"Yüreği dağ gibi" ifadesindeki "dağ" sözcüğü hangi anlamda kullanılmıştır?', 'Mecaz anlamı gerçek anlamdan ayırt eder.', '"Dağ" sözcüğü burada gerçek anlamından (yeryüzü şekli) uzaklaşarak "büyük, cesur" anlamında mecaz olarak kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f1f01ce-9f79-4a09-9a12-600cd57980d7', 'Mecaz anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f1f01ce-9f79-4a09-9a12-600cd57980d7', 'Gerçek anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f1f01ce-9f79-4a09-9a12-600cd57980d7', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f1f01ce-9f79-4a09-9a12-600cd57980d7', 'Yan anlam', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('06e81d0b-cb14-48d4-9e92-1dde3198472d', '7ec4f569-8e17-456f-b938-c05e33b7a53c', 'orta'::difficulty_level, '"Bu kumaşın ''eli'' çok yumuşak." cümlesindeki altı çizili sözcük hangi anlam ilişkisiyle kullanılmıştır?', 'Yan anlamı ayırt eder.', '"El" sözcüğü asıl anlamıyla (vücut organı) değil, kumaşın dokusunu/tuşesini belirtmek için "yan anlam" olarak kullanılmıştır; sözcüğün gerçek anlamıyla bağlantısı hâlâ hissedilir, bu da onu mecazdan ayırır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06e81d0b-cb14-48d4-9e92-1dde3198472d', 'Yan anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06e81d0b-cb14-48d4-9e92-1dde3198472d', 'Mecaz anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06e81d0b-cb14-48d4-9e92-1dde3198472d', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06e81d0b-cb14-48d4-9e92-1dde3198472d', 'Gerçek anlam', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d76fd821-a53c-43d8-8182-76e11f38c89b', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'kolay'::difficulty_level, '"Yağmur yağarsa pikniğe gitmeyeceğiz." cümlesi anlamca hangi tür bir cümledir?', 'Koşul (şart) anlamı taşıyan cümleleri tanır.', 'Cümlede "-arsa/-erse" koşul ekiyle kurulmuş bir şart cümlesi vardır; bir eylemin gerçekleşmesi başka bir duruma bağlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d76fd821-a53c-43d8-8182-76e11f38c89b', 'Koşul (şart) cümlesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d76fd821-a53c-43d8-8182-76e11f38c89b', 'Amaç cümlesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d76fd821-a53c-43d8-8182-76e11f38c89b', 'Sebep-sonuç cümlesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d76fd821-a53c-43d8-8182-76e11f38c89b', 'Karşılaştırma cümlesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('42a417f8-2ee6-4e93-80bd-089585625aed', 'f98d3bdb-0e25-4f4e-8db7-741a5f1c81a3', 'orta'::difficulty_level, '"Herkes onun başarılı olacağını biliyordu, o da bunu biliyordu ama yine de denemekten korkuyordu." cümlesinde hangi anlam ilişkisi vardır?', 'Karşıtlık (zıtlık) anlamı taşıyan cümleleri çözümler.', '"Ama" bağlacı ile cümlede beklenenin aksine bir durum (bilmesine rağmen korkma) anlatılmıştır; bu da karşıtlık/zıtlık ilişkisini gösterir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('42a417f8-2ee6-4e93-80bd-089585625aed', 'Karşıtlık ilişkisi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('42a417f8-2ee6-4e93-80bd-089585625aed', 'Neden-sonuç ilişkisi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('42a417f8-2ee6-4e93-80bd-089585625aed', 'Amaç-sonuç ilişkisi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('42a417f8-2ee6-4e93-80bd-089585625aed', 'Koşul ilişkisi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a9655591-bc9d-4075-bbcf-b43b92bfcc49', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'orta'::difficulty_level, 'Bir paragrafın giriş cümlesi genellikle hangi özelliği taşır?', 'Paragrafın giriş cümlesinin işlevini bilir.', 'Giriş cümlesi, paragrafın konusunu ortaya koyar ve okuyucuyu paragrafın devamına hazırlar; genellikle kendinden önceki bir bağlama ihtiyaç duymadan anlaşılabilir, bağlaçla başlamaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9655591-bc9d-4075-bbcf-b43b92bfcc49', 'Paragrafın konusunu tanıtır ve tek başına anlaşılır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9655591-bc9d-4075-bbcf-b43b92bfcc49', 'Mutlaka bir örnekle başlar.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9655591-bc9d-4075-bbcf-b43b92bfcc49', 'Bağlaçla başlar ve önceki paragrafa bağlıdır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a9655591-bc9d-4075-bbcf-b43b92bfcc49', 'Yalnızca yazarın kişisel görüşünü içerir.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0b2cf7b5-ee2e-4d72-b43f-abe062313be1', 'e0b4748b-bb65-4960-9950-fd1005a7d7a0', 'zor'::difficulty_level, '"Bu görüşe katılmıyorum. Çünkü..." ifadesiyle başlayan bir paragraf parçası, paragrafın hangi bölümünde yer alamaz?', 'Paragrafın bölümlerini (giriş-gelişme-sonuç) ayırt eder.', '"Bu görüşe katılmıyorum" ifadesi önceki bir görüşe atıfta bulunduğu için bağlama ihtiyaç duyar; bu nedenle paragrafın kendi başına anlaşılması gereken giriş (ilk) cümlesi olamaz, gelişme ya da sonuç bölümünde yer alabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0b2cf7b5-ee2e-4d72-b43f-abe062313be1', 'Giriş (ilk cümle)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0b2cf7b5-ee2e-4d72-b43f-abe062313be1', 'Gelişme bölümü', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0b2cf7b5-ee2e-4d72-b43f-abe062313be1', 'Sonuç bölümü', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0b2cf7b5-ee2e-4d72-b43f-abe062313be1', 'Paragrafın ortası', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d3985bcd-7e78-42da-a093-d19acd362861', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'kolay'::difficulty_level, '18 − (6 − 2) × 3 işleminin sonucu kaçtır?', 'İşlem önceliğini karmaşık ifadelerde uygular.', 'Önce parantez içi işlem yapılır: 6 − 2 = 4. Sonra çarpma yapılır: 4 × 3 = 12. Son olarak çıkarma yapılır: 18 − 12 = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3985bcd-7e78-42da-a093-d19acd362861', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3985bcd-7e78-42da-a093-d19acd362861', '12', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3985bcd-7e78-42da-a093-d19acd362861', '18', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3985bcd-7e78-42da-a093-d19acd362861', '4', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b55f4fcb-7d0b-4077-ac2d-9805862451f5', '7b7b290d-42c3-49b5-afe5-8994c54c8946', 'orta'::difficulty_level, 'Bir sayının 4 katının 7 fazlası, aynı sayının 2 katının 19 fazlasına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip çözer.', '4x + 7 = 2x + 19 → 4x − 2x = 19 − 7 → 2x = 12 → x = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b55f4fcb-7d0b-4077-ac2d-9805862451f5', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b55f4fcb-7d0b-4077-ac2d-9805862451f5', '4', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b55f4fcb-7d0b-4077-ac2d-9805862451f5', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b55f4fcb-7d0b-4077-ac2d-9805862451f5', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('21c9fed0-deb6-4b52-8d51-6a8cd66f4959', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'kolay'::difficulty_level, '648 sayısı aşağıdaki sayılardan hangisine tam bölünmez?', 'Bölünebilme kurallarını uygular.', '648 sayısının rakamları toplamı 6+4+8=18 olup 9''a bölünür, dolayısıyla 648, 9''a tam bölünür. Ancak 648, 5''e bölünmez çünkü son rakamı 0 veya 5 değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('21c9fed0-deb6-4b52-8d51-6a8cd66f4959', '5', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('21c9fed0-deb6-4b52-8d51-6a8cd66f4959', '2', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('21c9fed0-deb6-4b52-8d51-6a8cd66f4959', '3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('21c9fed0-deb6-4b52-8d51-6a8cd66f4959', '9', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e81bb2c7-e803-4c34-a60b-248742bd34f0', 'f5141b91-15fc-40ab-b1d5-bd051bfd3543', 'orta'::difficulty_level, '48 ile 60 sayılarının OBEB''i (en büyük ortak böleni) kaçtır?', 'OBEB hesaplama becerisini uygular.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük üsleri alınır: 2²×3 = 12. OBEB = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e81bb2c7-e803-4c34-a60b-248742bd34f0', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e81bb2c7-e803-4c34-a60b-248742bd34f0', '6', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e81bb2c7-e803-4c34-a60b-248742bd34f0', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e81bb2c7-e803-4c34-a60b-248742bd34f0', '4', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('92f822bd-c0b2-45f2-badc-38cda928102d', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'kolay'::difficulty_level, 'Üç basamaklı "7a5" sayısı 9''a tam bölünebildiğine göre a rakamı kaç olabilir?', 'Basamak değeri ile bölünebilme kurallarını birlikte kullanır.', '9''a bölünebilme için rakamlar toplamının 9''a bölünmesi gerekir: 7+a+5 = 12+a. 12+a değerinin 9''a bölünmesi için a=6 olmalıdır (12+6=18).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92f822bd-c0b2-45f2-badc-38cda928102d', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92f822bd-c0b2-45f2-badc-38cda928102d', '3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92f822bd-c0b2-45f2-badc-38cda928102d', '9', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('92f822bd-c0b2-45f2-badc-38cda928102d', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6b7097e0-30f4-487d-829f-e4d4942b0bf2', 'c3dddc6e-eea4-4706-a157-f67f4325984b', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 11''dir. Rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 45 fazladır. Buna göre ilk sayı kaçtır?', 'Basamak değeri problemlerini denklem kurarak çözer.', 'Sayı 10a+b, rakamları toplamı a+b=11. Yer değiştirmiş hâli 10b+a olup (10b+a)-(10a+b)=45 → 9(b-a)=45 → b-a=5. a+b=11 ve b-a=5 denklemlerinden b=8, a=3 bulunur. İlk sayı 38''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6b7097e0-30f4-487d-829f-e4d4942b0bf2', '38', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6b7097e0-30f4-487d-829f-e4d4942b0bf2', '29', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6b7097e0-30f4-487d-829f-e4d4942b0bf2', '47', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6b7097e0-30f4-487d-829f-e4d4942b0bf2', '56', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c030a01f-6970-4d7c-9e8d-9bce2fed2207', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'kolay'::difficulty_level, '3/4 + 1/6 işleminin sonucu kaçtır?', 'Rasyonel sayılarla toplama işlemi yapar.', 'Paydalar eşitlenir (OKEK=12): 3/4=9/12, 1/6=2/12. Toplam: 9/12+2/12=11/12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c030a01f-6970-4d7c-9e8d-9bce2fed2207', '11/12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c030a01f-6970-4d7c-9e8d-9bce2fed2207', '4/10', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c030a01f-6970-4d7c-9e8d-9bce2fed2207', '5/6', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c030a01f-6970-4d7c-9e8d-9bce2fed2207', '7/12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('13581c0f-8ed3-438a-bb33-b63be3cd21b2', '171c474e-c3bd-409e-852a-b1bd4bf6606b', 'orta'::difficulty_level, '(2/3) ÷ (4/9) işleminin sonucu kaçtır?', 'Rasyonel sayılarla bölme işlemi yapar.', 'Bölme işleminde ikinci kesirin tersiyle çarpılır: (2/3) × (9/4) = 18/12 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13581c0f-8ed3-438a-bb33-b63be3cd21b2', '3/2', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13581c0f-8ed3-438a-bb33-b63be3cd21b2', '8/27', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13581c0f-8ed3-438a-bb33-b63be3cd21b2', '2/3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13581c0f-8ed3-438a-bb33-b63be3cd21b2', '9/8', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9292c58d-c084-41b3-9ae4-b001aaa7fb94', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'orta'::difficulty_level, 'Bir havuzu bir musluk tek başına 6 saatte, başka bir musluk tek başına 3 saatte doldurabiliyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerini oran-orantı ile çözer.', 'Birinci musluk saatte havuzun 1/6''sını, ikinci musluk 1/3''ünü doldurur. Birlikte: 1/6+1/3=1/6+2/6=3/6=1/2. Havuzun yarısı 1 saatte dolduğuna göre tamamı 2 saatte dolar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9292c58d-c084-41b3-9ae4-b001aaa7fb94', '2 saat', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9292c58d-c084-41b3-9ae4-b001aaa7fb94', '3 saat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9292c58d-c084-41b3-9ae4-b001aaa7fb94', '4,5 saat', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9292c58d-c084-41b3-9ae4-b001aaa7fb94', '1,5 saat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('286c37a6-ba61-4800-92a6-d23a218e6d67', '3bbd5f38-934b-4418-9af9-543e84b4f23e', 'zor'::difficulty_level, 'Ali''nin yaşı, kardeşinin yaşının 2 katından 3 fazladır. İki kardeşin yaşları toplamı 30 olduğuna göre Ali kaç yaşındadır?', 'Yaş problemlerini denklem kurarak çözer.', 'Kardeşin yaşı x, Ali''nin yaşı 2x+3 olsun. x + 2x + 3 = 30 → 3x = 27 → x = 9. Ali''nin yaşı = 2(9)+3 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('286c37a6-ba61-4800-92a6-d23a218e6d67', '21', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('286c37a6-ba61-4800-92a6-d23a218e6d67', '18', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('286c37a6-ba61-4800-92a6-d23a218e6d67', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('286c37a6-ba61-4800-92a6-d23a218e6d67', '19', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('10c22015-8bfe-4286-b571-3e62d6dda0c7', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'kolay'::difficulty_level, 'İlk Türk devletlerinde "kurultay" adı verilen meclisin temel işlevi nedir?', 'İlk Türk devletlerindeki yönetim yapılarını bilir.', 'Kurultay, devlet işlerinin (savaş, barış, hukuk vb.) görüşülüp karara bağlandığı, hakan başkanlığında toplanan danışma meclisidir; Türklerde ilk demokratik yönetim uygulamalarından biri sayılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c22015-8bfe-4286-b571-3e62d6dda0c7', 'Devlet işlerinin görüşülüp karara bağlandığı meclis olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c22015-8bfe-4286-b571-3e62d6dda0c7', 'Sadece dini törenlerin yapıldığı yer olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c22015-8bfe-4286-b571-3e62d6dda0c7', 'Yalnızca ticaretin düzenlendiği kurum olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('10c22015-8bfe-4286-b571-3e62d6dda0c7', 'Ordunun eğitim aldığı okul olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1d854d2e-639c-4c42-8ac1-0b790eab7517', 'd54e692f-8d6b-4be3-bc8e-55c53b88f1db', 'orta'::difficulty_level, 'Orhun Abideleri (Göktürk Kitabeleri) tarih açısından neden önemlidir?', 'Yazılı ilk Türkçe kaynakların önemini kavrar.', 'Orhun Abideleri, Türk adının geçtiği ve Türkçenin bilinen ilk yazılı metinlerini içeren, Göktürk Devleti dönemine ait tarihî kaynaklardır; bu yönüyle Türk tarihi ve dili için birinci elden bir belgedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1d854d2e-639c-4c42-8ac1-0b790eab7517', 'Türk adının geçtiği bilinen ilk yazılı Türkçe metinler olmaları', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1d854d2e-639c-4c42-8ac1-0b790eab7517', 'İslamiyet''in kabulünü anlatmaları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1d854d2e-639c-4c42-8ac1-0b790eab7517', 'Osmanlı dönemine ait olmaları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1d854d2e-639c-4c42-8ac1-0b790eab7517', 'Sadece ticaret anlaşmalarını içermeleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4935ef82-5d19-47c5-b017-960a126d7999', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'kolay'::difficulty_level, 'Osmanlı Devleti''nde "İskân Politikası" hangi amaçla uygulanmıştır?', 'Osmanlı''nın kuruluş dönemi fetih ve yerleşim politikalarını bilir.', 'İskân politikası, fethedilen yerlere Anadolu''dan Türkmen aileler yerleştirilerek buraların Türkleştirilmesi ve devlet otoritesinin kalıcı hâle getirilmesi amacıyla uygulanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4935ef82-5d19-47c5-b017-960a126d7999', 'Fethedilen bölgeleri Türkleştirmek ve otoriteyi kalıcı kılmak', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4935ef82-5d19-47c5-b017-960a126d7999', 'Sadece vergi gelirlerini artırmak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4935ef82-5d19-47c5-b017-960a126d7999', 'Ordunun beslenmesini kolaylaştırmak', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4935ef82-5d19-47c5-b017-960a126d7999', 'Yalnızca göçebe hayatı özendirmek', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aecc757e-8c9a-4eaf-b37c-74b557b96678', '394c0e59-d739-45ae-8c1e-1529ae7d63e7', 'orta'::difficulty_level, 'I. Kosova Savaşı''nın (1389) sonuçlarından biri aşağıdakilerden hangisidir?', 'Osmanlı''nın Balkanlardaki fetihlerinin sonuçlarını bilir.', 'I. Kosova Savaşı sonucunda Sırp Krallığı Osmanlı''ya bağlı bir vasal (tabi) devlet hâline gelmiş, Osmanlı''nın Balkanlardaki hâkimiyeti pekişmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aecc757e-8c9a-4eaf-b37c-74b557b96678', 'Sırbistan''ın Osmanlı''ya bağlı bir devlet hâline gelmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aecc757e-8c9a-4eaf-b37c-74b557b96678', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aecc757e-8c9a-4eaf-b37c-74b557b96678', 'Anadolu Türk birliğinin sağlanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aecc757e-8c9a-4eaf-b37c-74b557b96678', 'Osmanlı Devleti''nin yıkılması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e8561527-bbe7-48ab-90b5-7470e304aeb8', '7640798b-40ed-4450-8685-63853ff9609e', 'kolay'::difficulty_level, 'Kurtuluş Savaşı''nda "Kongreler Dönemi" hangi cepheyle ilgilidir?', 'Kurtuluş Savaşı sürecindeki siyasi örgütlenme aşamalarını bilir.', 'Kongreler Dönemi (Erzurum ve Sivas Kongreleri gibi) askerî değil siyasi/örgütlenme sürecidir; millî iradenin ortaya konması ve Millî Mücadele''nin teşkilatlandırılması amaçlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8561527-bbe7-48ab-90b5-7470e304aeb8', 'Siyasi cephe (örgütlenme süreci)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8561527-bbe7-48ab-90b5-7470e304aeb8', 'Doğu Cephesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8561527-bbe7-48ab-90b5-7470e304aeb8', 'Güney Cephesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e8561527-bbe7-48ab-90b5-7470e304aeb8', 'Batı Cephesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4424e9ba-3b9c-406f-98a6-7cae6771e162', '7640798b-40ed-4450-8685-63853ff9609e', 'orta'::difficulty_level, 'Sakarya Meydan Muharebesi''nin en önemli sonucu aşağıdakilerden hangisidir?', 'Kurtuluş Savaşı''ndaki dönüm noktası muharebeleri ve sonuçlarını bilir.', 'Sakarya Meydan Muharebesi''nin kazanılmasıyla Türk ordusu taarruz gücüne sahip olduğunu göstermiş, Mustafa Kemal''e TBMM tarafından "Gazilik" unvanı ve "Mareşallik" rütbesi verilmiştir; savaşın gidişatı Türk lehine dönmüştür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4424e9ba-3b9c-406f-98a6-7cae6771e162', 'Savaşın gidişatının Türk lehine dönmesi ve Mustafa Kemal''e Mareşallik unvanının verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4424e9ba-3b9c-406f-98a6-7cae6771e162', 'İstanbul''un işgalden kurtarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4424e9ba-3b9c-406f-98a6-7cae6771e162', 'Lozan Antlaşması''nın imzalanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4424e9ba-3b9c-406f-98a6-7cae6771e162', 'Saltanatın kaldırılması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('afa4a53b-90f3-44ec-91ba-d07ca70f2de9', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Atatürk''ün "halkçılık" ilkesiyle doğrudan ilişkilidir?', 'Atatürk ilkelerini örneklerle ilişkilendirir.', 'Halkçılık ilkesi, kanun önünde herkesin eşit olmasını ve egemenliğin kayıtsız şartsız millete ait olmasını öngörür; bu ilkeyle doğrudan ilişkili uygulama sınıf/zümre ayrıcalıklarının kaldırılmasıdır (soyadı kanunu, saltanatın kaldırılması gibi eşitlikçi düzenlemeler).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afa4a53b-90f3-44ec-91ba-d07ca70f2de9', 'Saltanatın kaldırılarak egemenliğin millete verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afa4a53b-90f3-44ec-91ba-d07ca70f2de9', 'Kabotaj Kanunu''nun çıkarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afa4a53b-90f3-44ec-91ba-d07ca70f2de9', 'Tevhid-i Tedrisat Kanunu''nun çıkarılması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('afa4a53b-90f3-44ec-91ba-d07ca70f2de9', 'Yeni Türk harflerinin kabulü', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a78c2313-9374-42ae-9575-479506af38d5', '6b451e80-fb9b-420c-a0cc-4954a3b713bc', 'orta'::difficulty_level, '1926''da kabul edilen Türk Medeni Kanunu ile aşağıdakilerden hangisi sağlanmıştır?', 'Hukuk alanındaki inkılapların sonuçlarını bilir.', 'Türk Medeni Kanunu ile tek eşlilik esası getirilmiş, kadın-erkek eşitliği hukuki olarak güçlendirilmiş (miras, boşanma, şahitlik gibi haklarda) ve laik hukuk düzenine geçiş tamamlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a78c2313-9374-42ae-9575-479506af38d5', 'Kadın-erkek eşitliğinin hukuki güvenceye kavuşturulması ve tek eşliliğin getirilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a78c2313-9374-42ae-9575-479506af38d5', 'Çok eşliliğin yasal hâle getirilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a78c2313-9374-42ae-9575-479506af38d5', 'Şeriat mahkemelerinin güçlendirilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a78c2313-9374-42ae-9575-479506af38d5', 'Yalnızca ticaret hukukunun düzenlenmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9a6dddaf-d28f-43a8-9a94-965e26e2cb16', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'kolay'::difficulty_level, 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Matematik konumun sonuçlarını yorumlar.', 'Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer aldığından yerel saat farkı doğu-batı yönünde değişir; matematik konum, saat farkları, mevsimlerin yaşanışı ve gün uzunluğu değişimi gibi sonuçlar doğurur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a6dddaf-d28f-43a8-9a94-965e26e2cb16', 'Doğuda güneş daha erken doğar, batıda daha geç doğar.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a6dddaf-d28f-43a8-9a94-965e26e2cb16', 'Dört mevsim tam olarak aynı sürede yaşanır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a6dddaf-d28f-43a8-9a94-965e26e2cb16', 'İklim çeşitliliği yalnızca özel konumla açıklanır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a6dddaf-d28f-43a8-9a94-965e26e2cb16', 'Komşu ülke sayısı matematik konumun sonucudur.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('51434340-5290-4ec5-8130-d4d1dd3b49cc', '9091f497-3f4f-481c-90a7-6ae19c1c1c45', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin özel (coğrafi) konumunun sonuçlarından biridir?', 'Özel konumun matematik konumdan farkını ve sonuçlarını ayırt eder.', 'Özel konum; komşularla ilişkiler, ulaşım, ticaret yolları üzerinde bulunma, jeopolitik önem gibi beşerî-ekonomik sonuçları kapsar. Üç tarafının denizlerle çevrili olması ve önemli boğazlara sahip olması, Türkiye''yi transit ticaret açısından önemli kılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('51434340-5290-4ec5-8130-d4d1dd3b49cc', 'Önemli boğazlara sahip olması nedeniyle transit ticarette avantajlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('51434340-5290-4ec5-8130-d4d1dd3b49cc', 'Yerel saat farkının bulunması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('51434340-5290-4ec5-8130-d4d1dd3b49cc', 'Güneş ışınlarının açısının mevsime göre değişmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('51434340-5290-4ec5-8130-d4d1dd3b49cc', 'Gece-gündüz sürelerinin mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dc5be0ec-e8ec-4b0d-871d-a38d83b44808', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'kolay'::difficulty_level, 'Karadeniz Bölgesi''nde görülen iklim tipinin en belirgin özelliği nedir?', 'Türkiye''deki iklim tiplerinin özelliklerini bilir.', 'Karadeniz iklimi, her mevsim yağışlı olması ve yıllık yağış miktarının fazla olmasıyla karakterizedir; yazlar diğer bölgelere göre serin, kışlar ise ılıman geçer.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc5be0ec-e8ec-4b0d-871d-a38d83b44808', 'Her mevsim yağışlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc5be0ec-e8ec-4b0d-871d-a38d83b44808', 'Yazların çok kurak geçmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc5be0ec-e8ec-4b0d-871d-a38d83b44808', 'Kışların en sert şekilde yaşanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dc5be0ec-e8ec-4b0d-871d-a38d83b44808', 'Yıl boyunca yağış görülmemesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2d62c421-52d1-488b-ad76-cbae1a2a87ff', 'f1aab841-ba67-4a16-99fc-6f1afc8f1b63', 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde karasal iklimin görülmesinin temel nedeni aşağıdakilerden hangisidir?', 'İklim tiplerinin oluşumunda etkili coğrafi faktörleri açıklar.', 'İç Anadolu, kıyıdan uzak ve dağlarla çevrili bir konumda olduğundan nemli deniz havasından yeterince yararlanamaz; bu nedenle yazları sıcak ve kurak, kışları soğuk ve kar yağışlı karasal iklim görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d62c421-52d1-488b-ad76-cbae1a2a87ff', 'Denizden uzak ve dağlarla çevrili bir konumda bulunması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d62c421-52d1-488b-ad76-cbae1a2a87ff', 'Deniz seviyesine çok yakın olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d62c421-52d1-488b-ad76-cbae1a2a87ff', 'Yıl boyunca nemli hava kütlelerinin etkisinde kalması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d62c421-52d1-488b-ad76-cbae1a2a87ff', 'Ekvatora çok yakın bir enlemde bulunması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e83ac092-319e-4d16-9ea5-0fd87803ab40', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'kolay'::difficulty_level, 'Türkiye''de nüfusun kıyı bölgelerde iç kesimlere göre daha yoğun olmasının temel nedeni aşağıdakilerden hangisidir?', 'Nüfus dağılışını etkileyen doğal ve beşerî faktörleri açıklar.', 'Kıyı bölgelerde iklim koşullarının daha elverişli olması, tarım, sanayi ve ticaret imkânlarının fazlalığı ile ulaşım kolaylığı nüfusun bu bölgelerde yoğunlaşmasına neden olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e83ac092-319e-4d16-9ea5-0fd87803ab40', 'İklim ve ekonomik imkânların daha elverişli olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e83ac092-319e-4d16-9ea5-0fd87803ab40', 'Yükseltinin fazla olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e83ac092-319e-4d16-9ea5-0fd87803ab40', 'Tarım alanlarının kıyıda hiç bulunmaması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e83ac092-319e-4d16-9ea5-0fd87803ab40', 'Deprem riskinin kıyıda daha az olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('eca5238c-9b52-45ba-8c1f-0bb90aaaa6a0', '9667c94f-dd9b-468f-bf26-b192f8a3b1d0', 'orta'::difficulty_level, 'Bir bölgede engebeli arazi yapısı, nüfus yoğunluğunu genellikle nasıl etkiler?', 'Yer şekillerinin nüfus dağılışına etkisini yorumlar.', 'Engebeli/dağlık araziler tarım, sanayi ve ulaşım açısından elverişsiz olduğundan bu tür bölgelerde yerleşme ve nüfus yoğunluğu düşük olma eğilimindedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eca5238c-9b52-45ba-8c1f-0bb90aaaa6a0', 'Nüfus yoğunluğunu azaltır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eca5238c-9b52-45ba-8c1f-0bb90aaaa6a0', 'Nüfus yoğunluğunu artırır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eca5238c-9b52-45ba-8c1f-0bb90aaaa6a0', 'Nüfus dağılışını hiç etkilemez.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eca5238c-9b52-45ba-8c1f-0bb90aaaa6a0', 'Yalnızca kentleşmeyi hızlandırır.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('65cd2332-2c2b-4853-b7da-a083f0fe91a9', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'kolay'::difficulty_level, 'Yazılı olmayan, toplumda uzun süre uygulanarak yerleşmiş kurallara ne ad verilir?', 'Hukukun kaynaklarını (yazılı-yazısız) ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan ancak toplum tarafından benimsenip uzun süre uygulanan kurallardan oluşur ve hukukun yazısız kaynaklarından biridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65cd2332-2c2b-4853-b7da-a083f0fe91a9', 'Örf ve adet hukuku', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65cd2332-2c2b-4853-b7da-a083f0fe91a9', 'Anayasa', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65cd2332-2c2b-4853-b7da-a083f0fe91a9', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65cd2332-2c2b-4853-b7da-a083f0fe91a9', 'Tüzük', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aaec4005-5b8c-4efc-b37a-6eb312005149', 'a121b6ae-e7e2-4d62-8cd2-9db38daa97bb', 'orta'::difficulty_level, 'Bir hukuk kuralına uyulmadığında devlet gücüyle uygulanan yaptırıma ne ad verilir?', 'Hukuk kurallarının yaptırım unsurunu tanır.', 'Yaptırım (müeyyide), bir hukuk kuralına uyulmaması durumunda devletin zor kullanma gücüyle uyguladığı sonuçtur (ceza, tazminat vb.) ve hukuk kurallarını ahlaki/dini kurallardan ayıran temel özelliktir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aaec4005-5b8c-4efc-b37a-6eb312005149', 'Yaptırım (müeyyide)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aaec4005-5b8c-4efc-b37a-6eb312005149', 'Örf', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aaec4005-5b8c-4efc-b37a-6eb312005149', 'Teamül', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aaec4005-5b8c-4efc-b37a-6eb312005149', 'Doktrin', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a21787e9-f45f-4537-8e10-738405a6b617', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'kolay'::difficulty_level, '1982 Anayasası''na göre egemenlik kayıtsız şartsız kime aittir?', 'Anayasa''nın temel ilkelerinden egemenlik kavramını bilir.', '1982 Anayasası''nın 6. maddesine göre egemenlik, kayıtsız şartsız Türk Milletine aittir; millet bu yetkisini yetkili organlar eliyle kullanır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a21787e9-f45f-4537-8e10-738405a6b617', 'Türk Milletine', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a21787e9-f45f-4537-8e10-738405a6b617', 'TBMM''ye', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a21787e9-f45f-4537-8e10-738405a6b617', 'Cumhurbaşkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a21787e9-f45f-4537-8e10-738405a6b617', 'Anayasa Mahkemesine', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('57f49441-229e-47be-a20a-6618de3646cd', '7b326eac-a999-4b5b-a3c2-c08a29dc2fd5', 'orta'::difficulty_level, 'Anayasa değişikliği teklifi TBMM''de en az kaç üyenin yazılı teklifiyle yapılabilir?', 'Anayasa değişikliği usulünü bilir.', 'Anayasanın değiştirilmesi, TBMM üye tam sayısının en az üçte biri tarafından yazılı olarak teklif edilebilir (600 üyeli Meclis''te bu sayı 200''dür).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57f49441-229e-47be-a20a-6618de3646cd', 'Üye tam sayısının en az üçte biri', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57f49441-229e-47be-a20a-6618de3646cd', 'Üye tam sayısının salt çoğunluğu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57f49441-229e-47be-a20a-6618de3646cd', 'Üye tam sayısının tamamı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57f49441-229e-47be-a20a-6618de3646cd', 'Sadece hükümet üyeleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c949489b-1dcc-4e07-a30d-3d7fb2ed8dcf', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) devletin hangi temel organını oluşturur?', 'Kuvvetler ayrılığı ilkesindeki organları ayırt eder.', 'TBMM, kanun yapma, değiştirme ve kaldırma yetkisine sahip olduğu için yasama organını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c949489b-1dcc-4e07-a30d-3d7fb2ed8dcf', 'Yasama', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c949489b-1dcc-4e07-a30d-3d7fb2ed8dcf', 'Yürütme', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c949489b-1dcc-4e07-a30d-3d7fb2ed8dcf', 'Yargı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c949489b-1dcc-4e07-a30d-3d7fb2ed8dcf', 'Denetleme', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9774ea9b-3cbf-4a0b-8622-8a88a84ba323', '5eac92dc-9e97-46ca-87b1-5bb4ee449fa3', 'orta'::difficulty_level, 'Türkiye''de yargı bağımsızlığı ilkesi temel olarak neyi ifade eder?', 'Yargı organının işleyiş ilkelerini bilir.', 'Yargı bağımsızlığı, mahkemelerin hiçbir organ, makam veya kişinin emir ve talimatı olmaksızın, yalnızca Anayasa''ya, kanuna ve hukuka uygun olarak vicdani kanaatlerine göre karar vermesini ifade eder.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9774ea9b-3cbf-4a0b-8622-8a88a84ba323', 'Mahkemelerin hiçbir etki altında kalmadan bağımsız karar vermesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9774ea9b-3cbf-4a0b-8622-8a88a84ba323', 'Yargı kararlarının yürütme tarafından onaylanması gerekliliği', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9774ea9b-3cbf-4a0b-8622-8a88a84ba323', 'Hâkimlerin yasama organına bağlı çalışması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9774ea9b-3cbf-4a0b-8622-8a88a84ba323', 'Mahkeme kararlarının Cumhurbaşkanı onayına tabi olması', false, 3);

commit;

-- Kontrol:
select exam_type, count(*) from subjects group by exam_type order by exam_type;
select s.exam_type, count(*) as soru_sayisi from questions q join topics t on t.id=q.topic_id join subjects s on s.id=t.subject_id group by s.exam_type order by s.exam_type;