begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'Kesirler ve ondalık sayılarda çevirme, karşılaştırma ve dört işlem becerilerini kapsayan konudur.', '## Kesirler ve Ondalık Sayılar
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

Rasyonel sayılarla işlem yaparken en sık yapılan hatalar, bölme işleminde ters çevirmeyi unutmak ve toplama/çıkarmada paydaları eşitlemeden işlem yapmaktır. Bu yüzden her adımın ayrı ayrı kontrol edilmesi önemlidir.', '5/8 kesrinin ondalık karşılığı kaçtır?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('05015e9e-6596-462a-9fcf-a2988a5a81a0', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '3/4 kesrinin ondalık gösterimi nedir?', 'Kesri ondalık sayıya çevirir.', '3/4 kesrinde pay paydaya bölünür: 3 ÷ 4 = 0,75.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05015e9e-6596-462a-9fcf-a2988a5a81a0', '0.34', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05015e9e-6596-462a-9fcf-a2988a5a81a0', '0.75', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05015e9e-6596-462a-9fcf-a2988a5a81a0', '0.43', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05015e9e-6596-462a-9fcf-a2988a5a81a0', '1.33', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e2f1277f-49c3-4b83-8901-d2b5921facea', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '2/5 + 1/5 işleminin sonucu kaçtır?', 'Aynı paydalı kesirlerde toplama işlemi yapar.', 'Paydalar eşit olduğundan sadece paylar toplanır: (2+1)/5 = 3/5.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2f1277f-49c3-4b83-8901-d2b5921facea', '3/25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2f1277f-49c3-4b83-8901-d2b5921facea', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2f1277f-49c3-4b83-8901-d2b5921facea', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2f1277f-49c3-4b83-8901-d2b5921facea', '1/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ee7c219a-51df-4df5-801d-3cf110c3158b', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '1/2, 3/5, 2/3 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri karşılaştırıp sıralar.', 'Ondalık karşılıkları bulunur: 1/2=0,5; 3/5=0,6; 2/3≈0,667. Küçükten büyüğe sıralama: 1/2 < 3/5 < 2/3.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee7c219a-51df-4df5-801d-3cf110c3158b', '1/2 < 3/5 < 2/3', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee7c219a-51df-4df5-801d-3cf110c3158b', '3/5 < 1/2 < 2/3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee7c219a-51df-4df5-801d-3cf110c3158b', '2/3 < 3/5 < 1/2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee7c219a-51df-4df5-801d-3cf110c3158b', '1/2 < 2/3 < 3/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('97a434b8-553a-4423-a2d2-8653bfc1f640', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '0,6 ondalık sayısının kesir olarak en sade hali nedir?', 'Ondalık sayıyı sadeleştirilmiş kesre çevirir.', '0,6 = 6/10 yazılır. 6 ve 10''un ortak böleni 2 ile sadeleştirilirse 6/10 = 3/5 elde edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97a434b8-553a-4423-a2d2-8653bfc1f640', '6/10', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97a434b8-553a-4423-a2d2-8653bfc1f640', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97a434b8-553a-4423-a2d2-8653bfc1f640', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('97a434b8-553a-4423-a2d2-8653bfc1f640', '2/3', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a1fd5a90-6ffb-4562-9b78-ccfcf27474a3', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'zor'::difficulty_level, '(2/3 + 1/6) ÷ (5/9) işleminin sonucu kaçtır?', 'Kesirlerle karışık işlem (toplama ve bölme) yapar.', 'Önce parantez: 2/3+1/6, ortak payda 6 ile 4/6+1/6=5/6. Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1fd5a90-6ffb-4562-9b78-ccfcf27474a3', '25/54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1fd5a90-6ffb-4562-9b78-ccfcf27474a3', '3/2', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1fd5a90-6ffb-4562-9b78-ccfcf27474a3', '3/5', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1fd5a90-6ffb-4562-9b78-ccfcf27474a3', '2/3', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('f609f88b-2d72-42bc-bdb7-549657da2fd0', 'Yüzde, kâr-zarar, yaş, işçi-havuz ve hareket problemlerinin çözüm yöntemlerini kapsayan konudur.', '## Yüzde Problemleri
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

Bu problem tiplerinde birim (saat, km, TL) tutarlılığına ve toplam/fark ayrımına dikkat edilmelidir.', 'Bir üründe %15 indirim uygulanıyor. Ürünün etiket fiyatı 200 TL ise indirimli fiyat kaç TL olur?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('771d30e2-c32d-4048-98dc-61bce0cfd813', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'kolay'::difficulty_level, '250''nin %20''si kaçtır?', 'Bir sayının yüzdesini hesaplar.', '250''nin %20''si: 250 × 20/100 = 50.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('771d30e2-c32d-4048-98dc-61bce0cfd813', '25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('771d30e2-c32d-4048-98dc-61bce0cfd813', '50', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('771d30e2-c32d-4048-98dc-61bce0cfd813', '20', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('771d30e2-c32d-4048-98dc-61bce0cfd813', '45', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('db7e862b-68e1-4f9d-b8f7-6fcda806c8e6', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'kolay'::difficulty_level, 'Bir tüccar 80 TL''ye aldığı malı 100 TL''ye satıyor. Kâr yüzdesi kaçtır?', 'Kâr yüzdesini hesaplar.', 'Kâr = 100−80=20 TL. Kâr yüzdesi, kârın alış fiyatına oranıdır: 20/80×100=%25.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db7e862b-68e1-4f9d-b8f7-6fcda806c8e6', '20%', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db7e862b-68e1-4f9d-b8f7-6fcda806c8e6', '25%', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db7e862b-68e1-4f9d-b8f7-6fcda806c8e6', '125%', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db7e862b-68e1-4f9d-b8f7-6fcda806c8e6', '80%', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('60fab7ca-35c7-4bf6-9245-6bb8f3b272c7', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir babanın yaşı, oğlunun yaşının 3 katından 5 fazladır. Baba ile oğlunun yaşları toplamı 53 olduğuna göre oğlunun yaşı kaçtır?', 'Yaş problemini denklem kurarak çözer.', 'Oğlun yaşı x olsun. Baba = 3x+5. Toplam: x + (3x+5) = 53 → 4x + 5 = 53 → 4x = 48 → x = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60fab7ca-35c7-4bf6-9245-6bb8f3b272c7', '41', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60fab7ca-35c7-4bf6-9245-6bb8f3b272c7', '12', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60fab7ca-35c7-4bf6-9245-6bb8f3b272c7', '16', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('60fab7ca-35c7-4bf6-9245-6bb8f3b272c7', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d6ef4191-948f-471f-bc8c-6e2a25c89d15', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir havuzu tek başına A musluğu 6 saatte, B musluğu 12 saatte dolduruyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerinde birlikte çalışma süresini hesaplar.', 'Birim zamandaki doldurma oranları toplanır: 1/6+1/12 = 2/12+1/12 = 3/12 = 1/4. Süre = 1 ÷ (1/4) = 4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d6ef4191-948f-471f-bc8c-6e2a25c89d15', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d6ef4191-948f-471f-bc8c-6e2a25c89d15', '4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d6ef4191-948f-471f-bc8c-6e2a25c89d15', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d6ef4191-948f-471f-bc8c-6e2a25c89d15', '18', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('360c7c68-ed0f-46d2-826d-2ea4a0faa092', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'zor'::difficulty_level, 'İki şehir arası uzaklık 360 km''dir. Bir araç A şehrinden B şehrine 90 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 60 km/sa hızla hareket ediyor. Bu iki araç kaç saat sonra karşılaşır?', 'Karşılıklı hareket problemlerinde karşılaşma süresini hesaplar.', 'Zıt yönlü hareket ettikleri için hızlar toplanır: 90+60=150 km/sa. Karşılaşma süresi = Toplam yol ÷ Toplam hız = 360/150 = 2,4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('360c7c68-ed0f-46d2-826d-2ea4a0faa092', '12', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('360c7c68-ed0f-46d2-826d-2ea4a0faa092', '2.4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('360c7c68-ed0f-46d2-826d-2ea4a0faa092', '4', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('360c7c68-ed0f-46d2-826d-2ea4a0faa092', '2.5', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('c876132a-c63c-4a00-bc2b-f40f32d682d6', 'İlk Türk devletleri; Asya Hun Devleti, Avrupa Hun Devleti, Göktürk Devleti ve Uygur Devleti başta olmak üzere Orta Asya bozkırlarında kurulan, Türk devlet geleneğinin temelini oluşturan siyasi yapılardır.', '## Asya Hun Devleti
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
İlk Türk devletlerinde "kut" anlayışına dayalı hükümdarlık, kurultay (devlet meclisi) geleneği ve ikili teşkilat (doğu-batı yönetim biçimi) gibi ortak siyasi ve sosyal yapılar dikkat çeker.', 'Aşağıdakilerden hangisi yerleşik hayata geçen ve kağıt-matbaayı kullanan ilk Türk devleti olarak bilinir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?', 'İlk Türk devletlerinden Asya Hun Devleti''nin özelliklerini kavrar.', 'Asya Hun Devleti, Mete Han döneminde onlu sistem ordu teşkilatıyla güçlenmiş ve bilinen ilk teşkilatlı Türk devleti kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Asya Hun Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Uygur Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?', 'Göktürk Devleti''nin kuruluşu ve kurucusunu bilir.', 'Göktürk Devleti 552 yılında Bumin Kağan tarafından kurulmuş olup Türk adını taşıyan ilk devlettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Bumin Kağan', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Mete Han', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Attila', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Bilge Kağan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yerleşik yaşam ve kültürel özelliklerini ayırt eder.', 'Uygurlar, Mani dinini kabul ederek yerleşik hayata geçmiş ve kağıt-matbaayı kullanan ilk Türk devleti olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Uygur Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Asya Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?', 'Orhun Yazıtları''nın hangi devlete ait olduğunu ve önemini bilir.', 'Orhun Yazıtları (Göktürk Abideleri), Göktürk Devleti dönemine ait olup Türkçenin bilinen ilk yazılı metinleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Göktürk Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Uygur Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Avrupa Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Asya Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'zor'::difficulty_level, '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?', 'Kavimler Göçü''nün Türk tarihiyle bağlantısını ve Avrupa tarihine etkisini analiz eder.', 'Asya Hun Devleti''nin Çin baskısıyla zayıflaması sonucu Hun boylarının batıya yönelmesi, Kavimler Göçü''nü başlatan temel gelişmedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Göktürklerin Doğu ve Batı olarak ikiye ayrılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Uygurların Moğolistan''daki hakimiyetini kaybetmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Bumin Kağan''ın Göktürk Devleti''ni kurması', false, 3);
commit;
