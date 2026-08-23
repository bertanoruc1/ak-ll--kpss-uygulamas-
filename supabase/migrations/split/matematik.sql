begin;
-- ===== matematik =====
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ca71c67b-48cd-4ef9-a1a8-d7cdce20238f', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, '12 + 3 × 4 − 6 işleminin sonucu kaçtır?', 'Dört işlemde işlem önceliğini doğru uygular.', 'Önce çarpma yapılır: 3 × 4 = 12. Sonra soldan sağa toplama ve çıkarma yapılır: 12 + 12 − 6 = 18.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca71c67b-48cd-4ef9-a1a8-d7cdce20238f', '54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca71c67b-48cd-4ef9-a1a8-d7cdce20238f', '18', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca71c67b-48cd-4ef9-a1a8-d7cdce20238f', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca71c67b-48cd-4ef9-a1a8-d7cdce20238f', '30', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('697dd1f6-9a55-46a0-b4ab-ccf70a1bb82b', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, '-5, -8, -3, 2 tam sayılarından hangisi en küçüktür?', 'Tam sayıları büyüklük-küçüklük ilişkisine göre sıralar.', 'Negatif sayılarda mutlak değeri büyük olan sayı küçüktür. Sayı doğrusunda sıralama: −8 < −5 < −3 < 2 olduğundan en küçük sayı −8''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('697dd1f6-9a55-46a0-b4ab-ccf70a1bb82b', '-5', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('697dd1f6-9a55-46a0-b4ab-ccf70a1bb82b', '-8', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('697dd1f6-9a55-46a0-b4ab-ccf70a1bb82b', '-3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('697dd1f6-9a55-46a0-b4ab-ccf70a1bb82b', '2', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3233e68b-5c90-4595-bc4a-b42796ab9eaa', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, '(−3) × (4 − 7) + (−2) × 5 işleminin sonucu kaçtır?', 'Negatif sayılarla çarpma ve toplama işlemlerini yapar.', 'Önce parantez: 4 − 7 = −3. Sonra çarpmalar: (−3)×(−3) = 9 ve (−2)×5 = −10. Son olarak toplama: 9 + (−10) = −1.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3233e68b-5c90-4595-bc4a-b42796ab9eaa', '-19', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3233e68b-5c90-4595-bc4a-b42796ab9eaa', '-1', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3233e68b-5c90-4595-bc4a-b42796ab9eaa', '19', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3233e68b-5c90-4595-bc4a-b42796ab9eaa', '1', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dcf318c1-5993-4e78-952b-48493d2059b8', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, 'Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip birinci dereceden denklemi çözer.', '2(x+3) = 3(x−5) → 2x + 6 = 3x − 15 → 6 + 15 = 3x − 2x → x = 21. Kontrol: 2×(21+3)=48 ve 3×(21−5)=48, eşit olduğundan doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcf318c1-5993-4e78-952b-48493d2059b8', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcf318c1-5993-4e78-952b-48493d2059b8', '11', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcf318c1-5993-4e78-952b-48493d2059b8', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcf318c1-5993-4e78-952b-48493d2059b8', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c26e209e-fd3e-417d-b380-c5e23d8ed5cf', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'zor'::difficulty_level, 'Ali''nin yaşının 2 katının 5 fazlası, Ayşe''nin yaşının 3 katının 7 eksiğine eşittir. Ayşe 20 yaşında olduğuna göre Ali kaç yaşındadır?', 'Karmaşık sözel ifadelerden denklem kurup çözer.', 'Denklem: 2A + 5 = 3(20) − 7. Sağ taraf: 3×20−7 = 60−7 = 53. Buradan 2A + 5 = 53 → 2A = 48 → A = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c26e209e-fd3e-417d-b380-c5e23d8ed5cf', '17', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c26e209e-fd3e-417d-b380-c5e23d8ed5cf', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c26e209e-fd3e-417d-b380-c5e23d8ed5cf', '29', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c26e209e-fd3e-417d-b380-c5e23d8ed5cf', '48', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('38167c3d-77ef-44ca-9227-38279a94814d', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 9 ile tam bölünür? 342, 245, 368, 451', 'Bölünebilme kurallarını kullanarak 9 ile bölünebilirliği tespit eder.', '342: 3+4+2=9 → 9''un katı, bölünür. 245: 2+4+5=11 → bölünmez. 368: 3+6+8=17 → bölünmez. 451: 4+5+1=10 → bölünmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38167c3d-77ef-44ca-9227-38279a94814d', '342', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38167c3d-77ef-44ca-9227-38279a94814d', '245', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38167c3d-77ef-44ca-9227-38279a94814d', '368', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('38167c3d-77ef-44ca-9227-38279a94814d', '451', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d5516bb6-31e3-4342-acac-acdd316918dc', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 4 ile tam bölünür? 1234, 1416, 2350, 3115', '4 ile bölünebilme kuralını uygular.', 'Bir sayının 4 ile bölünmesi için son iki basamağının 4''ün katı olması gerekir. 1234''te son iki basamak 34 (bölünmez), 1416''da 16 (4''ün katı, bölünür), 2350''de 50 (bölünmez), 3115 tek sayı (bölünmez).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5516bb6-31e3-4342-acac-acdd316918dc', '1234', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5516bb6-31e3-4342-acac-acdd316918dc', '1416', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5516bb6-31e3-4342-acac-acdd316918dc', '2350', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5516bb6-31e3-4342-acac-acdd316918dc', '3115', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a138144f-f45a-4ded-b5c6-7bc8e89bffdd', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, '48 ve 60 sayılarının EBOB''u kaçtır?', 'İki sayının EBOB''unu asal çarpanlarına ayırarak bulur.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük kuvvetleri: 2² ve 3. EBOB = 2²×3 = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a138144f-f45a-4ded-b5c6-7bc8e89bffdd', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a138144f-f45a-4ded-b5c6-7bc8e89bffdd', '240', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a138144f-f45a-4ded-b5c6-7bc8e89bffdd', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a138144f-f45a-4ded-b5c6-7bc8e89bffdd', '6', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e7cbbcef-9db2-4edd-8e36-f1be4b5e5583', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, 'Bir sayı hem 6 hem de 8 ile tam bölünmektedir. Bu sayı en az kaç olabilir?', 'İki sayının EKOK''unu bulur.', 'İstenen en küçük sayı EKOK(6,8)''dir. 6=2×3, 8=2³. EKOK = 2³×3 = 24.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e7cbbcef-9db2-4edd-8e36-f1be4b5e5583', '48', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e7cbbcef-9db2-4edd-8e36-f1be4b5e5583', '24', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e7cbbcef-9db2-4edd-8e36-f1be4b5e5583', '2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e7cbbcef-9db2-4edd-8e36-f1be4b5e5583', '12', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fb446335-1257-4b00-904c-9629b61879c1', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'zor'::difficulty_level, 'EBOB''u 8, EKOK''u 240 olan iki sayıdan biri 40 olduğuna göre diğer sayı kaçtır?', 'EBOB ve EKOK arasındaki ilişkiyi kullanarak problem çözer.', 'EBOB × EKOK = sayıların çarpımı kuralından: 8 × 240 = 40 × diğer sayı → 1920 = 40 × diğer sayı → diğer sayı = 1920 ÷ 40 = 48.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb446335-1257-4b00-904c-9629b61879c1', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb446335-1257-4b00-904c-9629b61879c1', '48', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb446335-1257-4b00-904c-9629b61879c1', '200', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb446335-1257-4b00-904c-9629b61879c1', '1920', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('140df154-a815-4fb8-95b3-0e145463802d', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, '347 sayısında 4 rakamının basamak değeri kaçtır?', 'Bir rakamın basamak değerini hesaplar.', '347 sayısında 4 rakamı onlar basamağındadır. Basamak değeri = rakam × basamağın değeri = 4×10 = 40.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('140df154-a815-4fb8-95b3-0e145463802d', '4', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('140df154-a815-4fb8-95b3-0e145463802d', '40', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('140df154-a815-4fb8-95b3-0e145463802d', '300', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('140df154-a815-4fb8-95b3-0e145463802d', '34', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('399e7aea-253c-4487-ae1e-d1150df202f7', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, '2856 sayısının rakamları toplamı kaçtır?', 'Bir sayının rakamları toplamını bulur.', 'Rakamlar tek tek toplanır: 2+8+5+6 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('399e7aea-253c-4487-ae1e-d1150df202f7', '16', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('399e7aea-253c-4487-ae1e-d1150df202f7', '20', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('399e7aea-253c-4487-ae1e-d1150df202f7', '21', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('399e7aea-253c-4487-ae1e-d1150df202f7', '22', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c321ec5e-27d3-4e46-889e-6f9712d233c7', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, 'Üç basamaklı en büyük tek sayı ile üç basamaklı en küçük çift sayının toplamı kaçtır?', 'En büyük/en küçük sayı kavramlarını kullanarak işlem yapar.', 'Üç basamaklı en büyük tek sayı 999''dur. Üç basamaklı en küçük sayı 100 olup çift sayıdır. Toplam: 999 + 100 = 1099.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c321ec5e-27d3-4e46-889e-6f9712d233c7', '1098', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c321ec5e-27d3-4e46-889e-6f9712d233c7', '1099', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c321ec5e-27d3-4e46-889e-6f9712d233c7', '1101', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c321ec5e-27d3-4e46-889e-6f9712d233c7', '1100', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bb3bd6dd-42b1-40c9-948c-aba82e840149', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, 'Rakamları farklı olan iki basamaklı en büyük sayı ile rakamları farklı olan iki basamaklı en küçük sayının farkı kaçtır?', 'Rakamları farklı en büyük ve en küçük sayıları oluşturur.', 'Rakamları farklı iki basamaklı en büyük sayı 98''dir (99''da rakamlar aynı olduğundan geçersizdir). Rakamları farklı en küçük iki basamaklı sayı 10''dur. Fark: 98 − 10 = 88.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3bd6dd-42b1-40c9-948c-aba82e840149', '89', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3bd6dd-42b1-40c9-948c-aba82e840149', '88', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3bd6dd-42b1-40c9-948c-aba82e840149', '86', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bb3bd6dd-42b1-40c9-948c-aba82e840149', '87', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2c647c41-0508-4032-a5cd-2a74e18db9d1', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 12''dir. Bu sayının rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 18 fazla olduğuna göre ilk sayı kaçtır?', 'Basamakları yer değiştirme problemlerini denklemle çözer.', 'Sayı 10a+b olsun. a+b=12 ve (10b+a)−(10a+b)=18 → 9(b−a)=18 → b−a=2. a+b=12 ve b−a=2 denklemlerini toplarsak 2b=14 → b=7, a=5. İlk sayı 10×5+7=57.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c647c41-0508-4032-a5cd-2a74e18db9d1', '75', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c647c41-0508-4032-a5cd-2a74e18db9d1', '57', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c647c41-0508-4032-a5cd-2a74e18db9d1', '66', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2c647c41-0508-4032-a5cd-2a74e18db9d1', '93', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c3cbd0ed-c15c-44d6-a74d-077d93c5f3ad', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '3/4 kesrinin ondalık gösterimi nedir?', 'Kesri ondalık sayıya çevirir.', '3/4 kesrinde pay paydaya bölünür: 3 ÷ 4 = 0,75.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3cbd0ed-c15c-44d6-a74d-077d93c5f3ad', '0.34', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3cbd0ed-c15c-44d6-a74d-077d93c5f3ad', '0.75', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3cbd0ed-c15c-44d6-a74d-077d93c5f3ad', '0.43', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3cbd0ed-c15c-44d6-a74d-077d93c5f3ad', '1.33', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('198c94f8-1329-426e-bfce-690f360df839', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '2/5 + 1/5 işleminin sonucu kaçtır?', 'Aynı paydalı kesirlerde toplama işlemi yapar.', 'Paydalar eşit olduğundan sadece paylar toplanır: (2+1)/5 = 3/5.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198c94f8-1329-426e-bfce-690f360df839', '3/25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198c94f8-1329-426e-bfce-690f360df839', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198c94f8-1329-426e-bfce-690f360df839', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198c94f8-1329-426e-bfce-690f360df839', '1/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fb26d7e4-7e23-4e2c-9587-aa99b7437852', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '1/2, 3/5, 2/3 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri karşılaştırıp sıralar.', 'Ondalık karşılıkları bulunur: 1/2=0,5; 3/5=0,6; 2/3≈0,667. Küçükten büyüğe sıralama: 1/2 < 3/5 < 2/3.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb26d7e4-7e23-4e2c-9587-aa99b7437852', '1/2 < 3/5 < 2/3', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb26d7e4-7e23-4e2c-9587-aa99b7437852', '3/5 < 1/2 < 2/3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb26d7e4-7e23-4e2c-9587-aa99b7437852', '2/3 < 3/5 < 1/2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fb26d7e4-7e23-4e2c-9587-aa99b7437852', '1/2 < 2/3 < 3/5', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3a099372-2fe5-423b-b912-7adb9f5cae8f', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '0,6 ondalık sayısının kesir olarak en sade hali nedir?', 'Ondalık sayıyı sadeleştirilmiş kesre çevirir.', '0,6 = 6/10 yazılır. 6 ve 10''un ortak böleni 2 ile sadeleştirilirse 6/10 = 3/5 elde edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3a099372-2fe5-423b-b912-7adb9f5cae8f', '6/10', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3a099372-2fe5-423b-b912-7adb9f5cae8f', '3/5', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3a099372-2fe5-423b-b912-7adb9f5cae8f', '3/10', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3a099372-2fe5-423b-b912-7adb9f5cae8f', '2/3', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1e80b459-005c-4542-a751-beeb8b5f9a91', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'zor'::difficulty_level, '(2/3 + 1/6) ÷ (5/9) işleminin sonucu kaçtır?', 'Kesirlerle karışık işlem (toplama ve bölme) yapar.', 'Önce parantez: 2/3+1/6, ortak payda 6 ile 4/6+1/6=5/6. Sonra bölme: 5/6 ÷ 5/9 = 5/6 × 9/5 = 45/30 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e80b459-005c-4542-a751-beeb8b5f9a91', '25/54', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e80b459-005c-4542-a751-beeb8b5f9a91', '3/2', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e80b459-005c-4542-a751-beeb8b5f9a91', '3/5', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1e80b459-005c-4542-a751-beeb8b5f9a91', '2/3', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3f3c42b5-73c7-4cda-8e26-3f69edabdb5f', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'kolay'::difficulty_level, '250''nin %20''si kaçtır?', 'Bir sayının yüzdesini hesaplar.', '250''nin %20''si: 250 × 20/100 = 50.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f3c42b5-73c7-4cda-8e26-3f69edabdb5f', '25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f3c42b5-73c7-4cda-8e26-3f69edabdb5f', '50', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f3c42b5-73c7-4cda-8e26-3f69edabdb5f', '20', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f3c42b5-73c7-4cda-8e26-3f69edabdb5f', '45', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dccc48af-9854-4d88-a89a-9bb8a39083a2', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'kolay'::difficulty_level, 'Bir tüccar 80 TL''ye aldığı malı 100 TL''ye satıyor. Kâr yüzdesi kaçtır?', 'Kâr yüzdesini hesaplar.', 'Kâr = 100−80=20 TL. Kâr yüzdesi, kârın alış fiyatına oranıdır: 20/80×100=%25.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dccc48af-9854-4d88-a89a-9bb8a39083a2', '20%', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dccc48af-9854-4d88-a89a-9bb8a39083a2', '25%', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dccc48af-9854-4d88-a89a-9bb8a39083a2', '125%', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dccc48af-9854-4d88-a89a-9bb8a39083a2', '80%', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6bb7732b-1a81-48fd-9d47-122cdcdb8a3c', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir babanın yaşı, oğlunun yaşının 3 katından 5 fazladır. Baba ile oğlunun yaşları toplamı 53 olduğuna göre oğlunun yaşı kaçtır?', 'Yaş problemini denklem kurarak çözer.', 'Oğlun yaşı x olsun. Baba = 3x+5. Toplam: x + (3x+5) = 53 → 4x + 5 = 53 → 4x = 48 → x = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6bb7732b-1a81-48fd-9d47-122cdcdb8a3c', '41', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6bb7732b-1a81-48fd-9d47-122cdcdb8a3c', '12', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6bb7732b-1a81-48fd-9d47-122cdcdb8a3c', '16', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6bb7732b-1a81-48fd-9d47-122cdcdb8a3c', '15', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('190d8b78-3f76-4c7a-bc42-611ebc7a3b6c', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir havuzu tek başına A musluğu 6 saatte, B musluğu 12 saatte dolduruyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerinde birlikte çalışma süresini hesaplar.', 'Birim zamandaki doldurma oranları toplanır: 1/6+1/12 = 2/12+1/12 = 3/12 = 1/4. Süre = 1 ÷ (1/4) = 4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('190d8b78-3f76-4c7a-bc42-611ebc7a3b6c', '9', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('190d8b78-3f76-4c7a-bc42-611ebc7a3b6c', '4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('190d8b78-3f76-4c7a-bc42-611ebc7a3b6c', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('190d8b78-3f76-4c7a-bc42-611ebc7a3b6c', '18', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9c19ccb4-6b5f-4079-98ea-9c26ca369fc7', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'zor'::difficulty_level, 'İki şehir arası uzaklık 360 km''dir. Bir araç A şehrinden B şehrine 90 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 60 km/sa hızla hareket ediyor. Bu iki araç kaç saat sonra karşılaşır?', 'Karşılıklı hareket problemlerinde karşılaşma süresini hesaplar.', 'Zıt yönlü hareket ettikleri için hızlar toplanır: 90+60=150 km/sa. Karşılaşma süresi = Toplam yol ÷ Toplam hız = 360/150 = 2,4 saat.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c19ccb4-6b5f-4079-98ea-9c26ca369fc7', '12', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c19ccb4-6b5f-4079-98ea-9c26ca369fc7', '2.4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c19ccb4-6b5f-4079-98ea-9c26ca369fc7', '4', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9c19ccb4-6b5f-4079-98ea-9c26ca369fc7', '2.5', false, 3);

commit;
