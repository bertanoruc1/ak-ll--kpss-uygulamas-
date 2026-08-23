begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'Doğal, tam ve rasyonel sayı kümelerini, dört işlemde işlem önceliğini ve sayıların sıralanmasını kapsayan temel konudur.', '## Doğal, Tam ve Rasyonel Sayılar
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

Bu tür sorularda dağılma özelliğinin doğru uygulanmasına ve terimlerin doğru taşınmasına dikkat edilmelidir.', '24 ÷ 4 + 3 × (5 − 2) işleminin sonucu kaçtır?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('db651047-baec-4fa8-9dcc-9ef7520d7861', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, '12 + 3 × 4 − 6 işleminin sonucu kaçtır?', 'Dört işlemde işlem önceliğini doğru uygular.', 'Önce çarpma yapılır: 3 × 4 = 12. Sonra soldan sağa toplama ve çıkarma yapılır: 12 + 12 − 6 = 18.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db651047-baec-4fa8-9dcc-9ef7520d7861', '54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db651047-baec-4fa8-9dcc-9ef7520d7861', '18', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db651047-baec-4fa8-9dcc-9ef7520d7861', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('db651047-baec-4fa8-9dcc-9ef7520d7861', '30', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('24e7642e-fef1-4164-9079-bacaf253e8d1', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, '-5, -8, -3, 2 tam sayılarından hangisi en küçüktür?', 'Tam sayıları büyüklük-küçüklük ilişkisine göre sıralar.', 'Negatif sayılarda mutlak değeri büyük olan sayı küçüktür. Sayı doğrusunda sıralama: −8 < −5 < −3 < 2 olduğundan en küçük sayı −8''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('24e7642e-fef1-4164-9079-bacaf253e8d1', '-5', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('24e7642e-fef1-4164-9079-bacaf253e8d1', '-8', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('24e7642e-fef1-4164-9079-bacaf253e8d1', '-3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('24e7642e-fef1-4164-9079-bacaf253e8d1', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2553ae3e-67ac-4117-a293-ab383631bec5', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, '(−3) × (4 − 7) + (−2) × 5 işleminin sonucu kaçtır?', 'Negatif sayılarla çarpma ve toplama işlemlerini yapar.', 'Önce parantez: 4 − 7 = −3. Sonra çarpmalar: (−3)×(−3) = 9 ve (−2)×5 = −10. Son olarak toplama: 9 + (−10) = −1.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2553ae3e-67ac-4117-a293-ab383631bec5', '-19', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2553ae3e-67ac-4117-a293-ab383631bec5', '-1', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2553ae3e-67ac-4117-a293-ab383631bec5', '19', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2553ae3e-67ac-4117-a293-ab383631bec5', '1', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('671201fa-84e1-4a38-918d-f5b025f0c03c', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, 'Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip birinci dereceden denklemi çözer.', '2(x+3) = 3(x−5) → 2x + 6 = 3x − 15 → 6 + 15 = 3x − 2x → x = 21. Kontrol: 2×(21+3)=48 ve 3×(21−5)=48, eşit olduğundan doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('671201fa-84e1-4a38-918d-f5b025f0c03c', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('671201fa-84e1-4a38-918d-f5b025f0c03c', '11', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('671201fa-84e1-4a38-918d-f5b025f0c03c', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('671201fa-84e1-4a38-918d-f5b025f0c03c', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6a395aeb-c004-4f1d-ae28-4af73aed22b8', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'zor'::difficulty_level, 'Ali''nin yaşının 2 katının 5 fazlası, Ayşe''nin yaşının 3 katının 7 eksiğine eşittir. Ayşe 20 yaşında olduğuna göre Ali kaç yaşındadır?', 'Karmaşık sözel ifadelerden denklem kurup çözer.', 'Denklem: 2A + 5 = 3(20) − 7. Sağ taraf: 3×20−7 = 60−7 = 53. Buradan 2A + 5 = 53 → 2A = 48 → A = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a395aeb-c004-4f1d-ae28-4af73aed22b8', '17', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a395aeb-c004-4f1d-ae28-4af73aed22b8', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a395aeb-c004-4f1d-ae28-4af73aed22b8', '29', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a395aeb-c004-4f1d-ae28-4af73aed22b8', '48', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('d795c6f3-3a19-4f95-9919-007a184ced02', 'Sayıların 2, 3, 4, 5, 6, 8, 9, 10, 11 ile bölünebilme kurallarını ve EBOB/EKOK hesaplamalarını kapsayan konudur.', '## Bölünebilme Kuralları
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

Bu özellik, sayılardan biri bilinmediğinde diğerini bulmak için sıkça kullanılır.', '126 sayısı 9 ile tam bölünür mü? Rakamlar toplamını bularak açıklayınız.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('63438af9-94d5-4e7f-8be6-ea91475cbd93', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 9 ile tam bölünür? 342, 245, 368, 451', 'Bölünebilme kurallarını kullanarak 9 ile bölünebilirliği tespit eder.', '342: 3+4+2=9 → 9''un katı, bölünür. 245: 2+4+5=11 → bölünmez. 368: 3+6+8=17 → bölünmez. 451: 4+5+1=10 → bölünmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('63438af9-94d5-4e7f-8be6-ea91475cbd93', '342', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('63438af9-94d5-4e7f-8be6-ea91475cbd93', '245', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('63438af9-94d5-4e7f-8be6-ea91475cbd93', '368', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('63438af9-94d5-4e7f-8be6-ea91475cbd93', '451', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1cc79f73-123f-4b11-9aec-39db0c2a1142', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 4 ile tam bölünür? 1234, 1416, 2350, 3115', '4 ile bölünebilme kuralını uygular.', 'Bir sayının 4 ile bölünmesi için son iki basamağının 4''ün katı olması gerekir. 1234''te son iki basamak 34 (bölünmez), 1416''da 16 (4''ün katı, bölünür), 2350''de 50 (bölünmez), 3115 tek sayı (bölünmez).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cc79f73-123f-4b11-9aec-39db0c2a1142', '1234', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cc79f73-123f-4b11-9aec-39db0c2a1142', '1416', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cc79f73-123f-4b11-9aec-39db0c2a1142', '2350', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1cc79f73-123f-4b11-9aec-39db0c2a1142', '3115', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('464374bb-c48f-4ec2-a05e-d74dc4d3b866', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, '48 ve 60 sayılarının EBOB''u kaçtır?', 'İki sayının EBOB''unu asal çarpanlarına ayırarak bulur.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük kuvvetleri: 2² ve 3. EBOB = 2²×3 = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('464374bb-c48f-4ec2-a05e-d74dc4d3b866', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('464374bb-c48f-4ec2-a05e-d74dc4d3b866', '240', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('464374bb-c48f-4ec2-a05e-d74dc4d3b866', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('464374bb-c48f-4ec2-a05e-d74dc4d3b866', '6', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6ba99e05-3abb-441b-9e72-34db778753b6', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, 'Bir sayı hem 6 hem de 8 ile tam bölünmektedir. Bu sayı en az kaç olabilir?', 'İki sayının EKOK''unu bulur.', 'İstenen en küçük sayı EKOK(6,8)''dir. 6=2×3, 8=2³. EKOK = 2³×3 = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ba99e05-3abb-441b-9e72-34db778753b6', '48', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ba99e05-3abb-441b-9e72-34db778753b6', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ba99e05-3abb-441b-9e72-34db778753b6', '2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6ba99e05-3abb-441b-9e72-34db778753b6', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('73d3228c-b068-40e2-9c5d-e1e6ed5d643e', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'zor'::difficulty_level, 'EBOB''u 8, EKOK''u 240 olan iki sayıdan biri 40 olduğuna göre diğer sayı kaçtır?', 'EBOB ve EKOK arasındaki ilişkiyi kullanarak problem çözer.', 'EBOB × EKOK = sayıların çarpımı kuralından: 8 × 240 = 40 × diğer sayı → 1920 = 40 × diğer sayı → diğer sayı = 1920 ÷ 40 = 48.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73d3228c-b068-40e2-9c5d-e1e6ed5d643e', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73d3228c-b068-40e2-9c5d-e1e6ed5d643e', '48', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73d3228c-b068-40e2-9c5d-e1e6ed5d643e', '200', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('73d3228c-b068-40e2-9c5d-e1e6ed5d643e', '1920', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('52e4adee-4581-449e-bf2d-39847a1ff32a', 'Basamak değeri, rakamların toplamı ve sayı oluşturma/yer değiştirme problemlerini kapsayan konudur.', '## Basamak ve Basamak Değeri
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

Bu formül (basamak farkının 9 katı), basamak yer değiştirme problemlerinin çözümünde çok işe yarar.', '528 sayısında 5 rakamının basamak değeri kaçtır?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0604b4cd-1e7e-48f8-8017-3a68572ec3ef', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, '347 sayısında 4 rakamının basamak değeri kaçtır?', 'Bir rakamın basamak değerini hesaplar.', '347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri = rakam × basamağın değeri = 4×10 = 40.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0604b4cd-1e7e-48f8-8017-3a68572ec3ef', '4', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0604b4cd-1e7e-48f8-8017-3a68572ec3ef', '40', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0604b4cd-1e7e-48f8-8017-3a68572ec3ef', '300', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0604b4cd-1e7e-48f8-8017-3a68572ec3ef', '34', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cc4d710c-970f-40e3-b772-999ed28bab0f', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, '2856 sayısının rakamları toplamı kaçtır?', 'Bir sayının rakamları toplamını bulur.', 'Rakamlar tek tek toplanır: 2+8+5+6 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc4d710c-970f-40e3-b772-999ed28bab0f', '16', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc4d710c-970f-40e3-b772-999ed28bab0f', '20', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc4d710c-970f-40e3-b772-999ed28bab0f', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc4d710c-970f-40e3-b772-999ed28bab0f', '22', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8b1ce1fb-b3bd-4187-a71d-4b821846c1ed', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, 'Üç basamaklı en büyük tek sayı ile üç basamaklı en küçük çift sayının toplamı kaçtır?', 'En büyük/en küçük sayı kavramlarını kullanarak işlem yapar.', 'Üç basamaklı en büyük tek sayı 999''dur. Üç basamaklı en küçük sayı 100 olup çift sayıdır. Toplam: 999 + 100 = 1099.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8b1ce1fb-b3bd-4187-a71d-4b821846c1ed', '1098', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8b1ce1fb-b3bd-4187-a71d-4b821846c1ed', '1099', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8b1ce1fb-b3bd-4187-a71d-4b821846c1ed', '1101', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8b1ce1fb-b3bd-4187-a71d-4b821846c1ed', '1100', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('11bd73a3-4159-4aac-8b78-ef44b5db3f27', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, 'Rakamları farklı olan iki basamaklı en büyük sayı ile rakamları farklı olan iki basamaklı en küçük sayının farkı kaçtır?', 'Rakamları farklı en büyük ve en küçük sayıları oluşturur.', 'Rakamları farklı iki basamaklı en büyük sayı 98''dir (99''da rakamlar aynı olduğundan geçersizdir). Rakamları farklı en küçük iki basamaklı sayı 10''dur. Fark: 98 − 10 = 88.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11bd73a3-4159-4aac-8b78-ef44b5db3f27', '89', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11bd73a3-4159-4aac-8b78-ef44b5db3f27', '88', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11bd73a3-4159-4aac-8b78-ef44b5db3f27', '86', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11bd73a3-4159-4aac-8b78-ef44b5db3f27', '87', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('163ed676-76da-4554-848e-3ba48515ecce', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 12''dir. Bu sayının rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 18 fazla olduğuna göre ilk sayı kaçtır?', 'Basamakları yer değiştirme problemlerini denklemle çözer.', 'Sayı 10a+b olsun. a+b=12 ve (10b+a)−(10a+b)=18 → 9(b−a)=18 → b−a=2. a+b=12 ve b−a=2 denklemlerini toplarsak 2b=14 → b=7, a=5. İlk sayı 10×5+7=57.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('163ed676-76da-4554-848e-3ba48515ecce', '75', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('163ed676-76da-4554-848e-3ba48515ecce', '57', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('163ed676-76da-4554-848e-3ba48515ecce', '66', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('163ed676-76da-4554-848e-3ba48515ecce', '93', false, 3);
commit;
