begin;
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
commit;