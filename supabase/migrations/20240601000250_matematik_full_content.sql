-- KPSS Matematik: 5 mevcut konu için tam kapsamlı içerik (özet, ders notu, örnek soru)
-- ve her konu için 4'er soru + 5'er seçenek. Tüm konular (Temel Kavramlar, Bölme ve
-- Bölünebilme, Sayı Basamakları, Rasyonel Sayılar, Problemler) topic_contents UPSERT
-- ile zenginleştiriliyor; yeni konu eklenmiyor (mevcut 5 konu kapsamlı görüldü).

insert into topic_contents (topic_id, summary, content_md, example_question) values ('9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'Doğal sayılar, tam sayılar ve rasyonel sayılar kümeleri; asal sayı tanımı; EBOB (En Büyük Ortak Bölen) ve EKOK (En Küçük Ortak Kat) hesaplama yöntemleri; mutlak değer ve faktöriyel kavramları bu konunun temelini oluşturur. KPSS''de bu konu genelde sonraki tüm matematik konularının (bölünebilme, rasyonel sayılar, problemler) alt yapısını oluşturduğu için ihmal edilmemelidir.', '## Sayı Kümeleri
Doğal sayılar (N) = {0, 1, 2, 3, ...}. Tam sayılar (Z) = {..., -2, -1, 0, 1, 2, ...}. Rasyonel sayılar (Q), iki tam sayının oranı (a/b, b≠0) biçiminde yazılabilen sayılardır; hem tam sayılar hem kesirler hem de sonlu/periyodik ondalık sayılar rasyoneldir.

## Asal Sayı
1''den ve kendisinden başka pozitif tam sayı böleni olmayan, 1''den büyük doğal sayılara asal sayı denir. En küçük asal sayı 2''dir ve tek çift asal sayıdır (diğer tüm asal sayılar tektir). 1 asal sayı DEĞİLDİR (tanım gereği 1''den büyük olma şartı sağlanmaz).

## EBOB (En Büyük Ortak Bölen) ve EKOK (En Küçük Ortak Kat)
EBOB, iki veya daha fazla sayıyı aynı anda bölen en büyük pozitif tam sayıdır; sayıların asal çarpanlarına ayrılıp ORTAK asal çarpanların EN KÜÇÜK kuvvetleri çarpılarak bulunur. EKOK ise bu sayıların hepsinin katı olan en küçük pozitif tam sayıdır; asal çarpanlara ayrıldıktan sonra TÜM (ortak ve ortak olmayan) asal çarpanların EN BÜYÜK kuvvetleri çarpılarak bulunur. Önemli özdeşlik: iki sayının EBOB''u ile EKOK''unun çarpımı, o iki sayının çarpımına eşittir (EBOB × EKOK = a × b).

## Mutlak Değer
Bir sayının sayı doğrusunda orijine (0 noktasına) olan uzaklığıdır ve her zaman negatif olmayan bir değerdir: |x| ≥ 0. |-5| = 5, |5| = 5. Mutlak değerli ifadelerde işlem yaparken önce mutlak değer içindeki ifade hesaplanır, sonra mutlak değer (yani işaret) alınır.

## Faktöriyel
n! (n faktöriyel), 1''den n''e kadar olan tüm pozitif tam sayıların çarpımıdır: n! = 1×2×3×...×n. Tanım gereği 0! = 1''dir. Faktöriyeller sıralama (permütasyon) ve seçme (kombinasyon) problemlerinin temelini oluşturur.

## Kritik Hap Notlar
- 2, hem asal hem de tek çift sayıdır; bu KPSS''nin en klasik "asal sayılar hep tektir" tuzağıdır — 2 bir istisnadır.
- 1 sayısı ne asal ne de bileşiktir; bu özel bir durumdur ve sıkça sorulur.
- EBOB hesabında ORTAK çarpanların KÜÇÜK kuvveti, EKOK hesabında TÜM çarpanların BÜYÜK kuvveti alınır — bu ikisi karıştırılmamalıdır.
- EBOB × EKOK = İki Sayının Çarpımı özdeşliği, EBOB veya EKOK''tan biri verilip diğeri sorulan problemlerde doğrudan kullanılabilir.
- 0! = 1 ve 1! = 1''dir; bu ikisi sıfır/bir faktöriyeliyle ilgili en sık yapılan hatadır.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Sayı kümeleri (doğal, tam, rasyonel) ve aralarındaki ilişki.
- [05:00 - 12:00] Asal sayı tanımı, 2''nin özel durumu, 1''in asal olmaması.
- [12:00 - 20:00] EBOB-EKOK hesaplama yöntemleri ve EBOB×EKOK=a×b özdeşliği.
- [20:00 - Bitiş] Mutlak değer ve faktöriyel kavramları, çözümlü örnekler.', '18 ve 24 sayılarının EBOB''u ile EKOK''unun toplamı kaçtır?
A) 74 B) 76 C) 78 D) 80 E) 82
Doğru Cevap: C — 18=2×3², 24=2³×3; EBOB (ortak çarpanların küçük kuvveti) = 2×3=6, EKOK (tüm çarpanların büyük kuvveti) = 2³×3²=72; EBOB×EKOK=6×72=432=18×24 kontrolü de doğrulanır. Toplam: 6+72=78.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi asal sayıdır?', 'Asal sayıyı tanır.', '41 sayısının 1 ve kendisinden başka pozitif tam sayı böleni yoktur (2, 3, 5 ile bölünmez), bu nedenle asaldır (E doğru). 21=3×7, 33=3×11, 51=3×17 ve 57=3×19 olduğundan bu sayıların hepsi bileşiktir (birden fazla asal çarpana sahiptir).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '21', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '33', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '51', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '57', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c6882155-d1c7-4702-a07c-e825deacc09d', '41', true, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, '24 ve 36 sayılarının EBOB''u (en büyük ortak böleni) kaçtır?', 'EBOB hesaplamasını uygular.', '24 = 2³×3 ve 36 = 2²×3² biçiminde asal çarpanlarına ayrılır. EBOB bulunurken ortak asal çarpanların (2 ve 3) en küçük kuvvetleri çarpılır: 2² × 3¹ = 4 × 3 = 12 (C doğru). Diğer seçenekler ya ortak çarpanların yanlış kuvvetiyle ya da hesap hatasıyla elde edilmiş yanlış sonuçlardır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '8', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '12', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '18', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8dcbb37-c6ce-4d3f-860f-ae7777816507', '24', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, '|-7| + |3| - |-2| işleminin sonucu kaçtır?', 'Mutlak değer işlemlerini uygular.', '|-7| = 7, |3| = 3 ve |-2| = 2 olduğundan işlem 7 + 3 - 2 = 8 olarak hesaplanır (B doğru). Mutlak değer içindeki sayının işareti ne olursa olsun mutlak değer sonucu her zaman pozitiftir; bu unutulduğunda hatalı sonuçlara ulaşılır (örneğin işaretler doğrudan toplanırsa yanlış seçeneklere gidilir).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '2', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '8', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '6', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '9', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('427b4e83-0c21-45d2-81a4-fd8225c9ff9e', '12', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'zor'::difficulty_level, '5! / (3! × 2!) işleminin sonucu kaçtır?', 'Faktöriyel işlemlerini uygular.', '5! = 120, 3! = 6 ve 2! = 2 olduğundan payda 3!×2! = 6×2 = 12 olur; 120 / 12 = 10 sonucuna ulaşılır (B doğru). Bu ifade aynı zamanda 5 elemanlı bir kümeden 2 elemanlı alt küme seçme sayısı olan C(5,2) kombinasyonuna eşittir. Diğer seçenekler faktöriyel hesabında (örneğin 3! yerine 3×2 gibi eksik çarpım) yapılan tipik hatalardan kaynaklanan yanlış sonuçlardır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '8', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '10', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '12', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '15', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5bc0a910-5d3f-4c82-88d5-6c275561862d', '20', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('d795c6f3-3a19-4f95-9919-007a184ced02', '2, 3, 4, 5, 6, 8, 9, 10 ve 11 ile bölünebilme kuralları; bölme algoritması (Bölünen = Bölen × Bölüm + Kalan); bir doğal sayının kaç tane pozitif böleni olduğunun asal çarpanlara ayırma yoluyla bulunması bu konunun ÖSYM''de en sık sorulan alt başlıklarıdır.', '## Bölünebilme Kuralları
2 ile bölünebilme: son rakamı çift olan (0,2,4,6,8) sayılar. 3 ile bölünebilme: rakamları toplamı 3''e bölünen sayılar. 4 ile bölünebilme: son iki basamağı 00 olan veya 4''e bölünen sayılar. 5 ile bölünebilme: son rakamı 0 veya 5 olan sayılar. 6 ile bölünebilme: hem 2 hem 3 ile bölünebilen sayılar. 8 ile bölünebilme: son üç basamağı 000 olan veya 8''e bölünen sayılar. 9 ile bölünebilme: rakamları toplamı 9''a bölünen sayılar. 10 ile bölünebilme: son rakamı 0 olan sayılar. 11 ile bölünebilme: rakamların sondan başlayarak sırayla +/- işaretlenip toplanmasıyla elde edilen sonucun 11''e bölünmesi (veya 0 olması).

## Bölme Algoritması
Bir A sayısı B sayısına bölündüğünde bölüm Ç ve kalan K ise: A = B × Ç + K bağıntısı geçerlidir; burada 0 ≤ K < B olmalıdır (kalan her zaman bölenden küçüktür). Bu bağıntı, "bölündüğünde kalan/bölüm şu olan sayı kaçtır" tarzı problemlerin temelidir.

## Bir Sayının Pozitif Bölen Sayısı
Bir doğal sayı N, asal çarpanlarına N = a^x × b^y × c^z biçiminde ayrıldığında, N''nin pozitif tam bölen sayısı (x+1)(y+1)(z+1) formülüyle bulunur. Örneğin 36 = 2² × 3² olduğundan bölen sayısı (2+1)(2+1) = 9''dur.

## Ortak Bölünebilirlik ve Sayma Problemleri
"1''den N''e kadar kaç tane sayı K ile tam bölünür" tarzı sorularda ⌊N/K⌋ (N''nin K''ya bölümünün tam kısmı) hesaplanır. Hem A hem B ile bölünen sayılar sorulduğunda, A ve B''nin EKOK''u bulunup bu EKOK ile bölünebilme kuralı uygulanır.

## Kritik Hap Notlar
- 6 ile bölünebilme kuralı aslında BAĞIMSIZ bir kural değildir: hem 2 hem 3 kuralının birlikte sağlanmasıdır.
- Bölme algoritmasında (A = B×Ç + K) kalan HER ZAMAN bölenden küçük olmalıdır; kalan bölenden büyük/eşit çıkarsa hesap yanlıştır.
- Bölen sayısı formülü (x+1)(y+1)(z+1)''de ÜS''lere 1 eklenir, üsler doğrudan çarpılmaz — bu en sık karıştırılan noktadır.
- "Hem A hem B ile bölünür" ifadesi görüldüğünde doğrudan A ve B''nin EKOK''u ile bölünebilme kuralına geçilmelidir, ayrı ayrı kontrol zaman kaybettirir.
- 11 ile bölünebilme kuralı diğerlerine göre az sorulur ama basamak sayısı fazla olan sorularda çözüm hızını artırır; sondan başlayarak +/- sırayla toplama yapılır.

## Video Ders Takip Rehberi
- [00:00 - 05:00] 2, 3, 4, 5 ile bölünebilme kuralları ve örnekler.
- [05:00 - 12:00] 6, 8, 9, 10, 11 ile bölünebilme kuralları.
- [12:00 - 20:00] Bölme algoritması (A=B×Ç+K) ve bölen sayısı formülü (x+1)(y+1)(z+1).
- [20:00 - Bitiş] EKOK tabanlı ortak bölünebilirlik sayma problemleri, çözümlü örnekler.', 'Bir sayı 9 ile bölündüğünde bölüm 15, kalan 4 oluyor. Buna göre bu sayı kaçtır?
A) 131 B) 135 C) 139 D) 141 E) 144
Doğru Cevap: C — Bölme algoritmasına göre A = 9×15 + 4 = 135 + 4 = 139.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, 'Aşağıdaki sayılardan hangisi 6 ile tam bölünür?', '6 ile bölünebilme kuralını uygular.', '234 sayısı çift olduğu için 2 ile, rakamları toplamı (2+3+4=9) 3''e bölündüğü için 3 ile bölünür; hem 2 hem 3 ile bölünen sayı 6 ile de bölünür (B doğru). 128 çift ama rakam toplamı (11) 3''e bölünmez. 145 tektir. 361 tektir. 502 çift ama rakam toplamı (7) 3''e bölünmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', '128', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', '234', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', '145', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', '361', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0171c7d3-c69c-4d69-8699-58a2648bc976', '502', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, 'Bir A sayısı 7''ye bölündüğünde bölüm 12, kalan 5 oluyor. Buna göre A sayısı kaçtır?', 'Bölme algoritmasını (A=B×Ç+K) uygular.', 'Bölme algoritmasına göre A = Bölen × Bölüm + Kalan = 7 × 12 + 5 = 84 + 5 = 89 (C doğru). Diğer seçenekler bölüm veya kalanın yanlış sayıyla çarpılıp toplanmasından kaynaklanan tipik hesap hatalarıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', '79', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', '84', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', '89', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', '94', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6a639194-658d-49ec-a5df-b7a44f47c9e5', '96', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('56dcb856-5d56-4149-80d0-426984f33c39', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, '36 sayısının kaç tane pozitif tam sayı böleni vardır?', 'Bölen sayısı formülünü uygular.', '36 = 2² × 3² biçiminde asal çarpanlarına ayrılır. Bölen sayısı formülüne göre (2+1)×(2+1) = 3×3 = 9 bulunur (D doğru). 36''nın bölenleri tek tek yazılırsa da doğrulanabilir: 1, 2, 3, 4, 6, 9, 12, 18, 36 — toplam 9 tane.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56dcb856-5d56-4149-80d0-426984f33c39', '6', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56dcb856-5d56-4149-80d0-426984f33c39', '7', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56dcb856-5d56-4149-80d0-426984f33c39', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56dcb856-5d56-4149-80d0-426984f33c39', '9', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('56dcb856-5d56-4149-80d0-426984f33c39', '10', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'zor'::difficulty_level, '1''den 200''e kadar olan (200 dahil) doğal sayılardan kaç tanesi hem 4 hem de 6 ile tam bölünür?', 'EKOK tabanlı ortak bölünebilirlik sayma problemini çözer.', 'Hem 4 hem 6 ile bölünen sayılar, 4 ve 6''nın EKOK''u olan 12 ile bölünen sayılardır. 1''den 200''e kadar 12 ile bölünen sayıların adedi ⌊200/12⌋ = 16 olarak bulunur (12×16=192 ≤ 200 < 12×17=204) (C doğru). Bu problemde 4 ve 6''yı ayrı ayrı kontrol etmeye çalışmak zaman kaybettirir; doğru yaklaşım doğrudan EKOK''u bulup tek bir bölme işlemi yapmaktır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', '14', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', '15', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', '16', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', '17', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88d6b4c4-46be-47c4-8680-db3316c6bc75', '18', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('52e4adee-4581-449e-bf2d-39847a1ff32a', 'Bir sayıdaki rakamların basamak adları (birler, onlar, yüzler...), her rakamın basamak değeri (rakamın bulunduğu basamağa göre aldığı değer) ile sayı değeri (rakamın kendisi) arasındaki fark ve verilen koşullara göre basamaklardan sayı oluşturma problemleri bu konunun temelini oluşturur.', '## Basamak Adları
Sağdan sola doğru bir sayının basamakları birler, onlar, yüzler, binler, on binler... şeklinde adlandırılır. Örneğin 4.532 sayısında 2 birler, 3 onlar, 5 yüzler, 4 binler basamağındadır.

## Basamak Değeri ve Sayı Değeri
Bir rakamın SAYI DEĞERİ, o rakamın kendi değeridir (örneğin 746 sayısındaki 7''nin sayı değeri 7''dir). BASAMAK DEĞERİ ise o rakamın bulunduğu basamağa göre aldığı gerçek değerdir (746''daki 7, yüzler basamağında olduğu için basamak değeri 700''dür). Bu ayrım ÖSYM''nin en sık sorduğu temel kavramdır.

## Rakamlarla Sayı Oluşturma
Verilen rakamlarla en büyük sayı oluşturmak için rakamlar büyükten küçüğe soldan sağa sıralanır; en küçük sayı oluşturmak için küçükten büyüğe sıralanır (ancak en soldaki basamak 0 olamaz, sıfır varsa ikinci sıraya konur). Rakamların tekrar edilip edilemeyeceği soruda belirtilir; belirtilmemişse genellikle tekrarsız kabul edilir.

## Basamaklar Arası İlişkili Denklemler
Bazı sorularda basamaklar arasında verilen oransal/toplamsal ilişkilerden (örneğin "onlar basamağı, birler basamağının 2 katıdır" gibi) yararlanılarak sayının kendisi bulunur; bu tür sorularda her basamağa bir değişken atanıp verilen koşullar sırayla uygulanmalıdır.

## Kritik Hap Notlar
- Sayı değeri = rakamın kendisi; basamak değeri = rakam × basamağın konumuna karşılık gelen 10''un kuvveti (birler=10⁰, onlar=10¹, yüzler=10², ...).
- Rakamlarla en büyük/en küçük sayı oluştururken en soldaki (en yüksek değerli) basamağa 0 KONULAMAZ; 0 varsa ikinci basamağa yerleştirilir.
- Basamaklar arası ilişki sorularında değişken atarken en küçük basamaktan (birler) başlanması hata riskini azaltır.
- Bir sayının rakamları toplamı ile o sayının 9''a (veya 3''e) bölünüp bölünmediği arasında doğrudan bir bağlantı vardır; bu bilgi sayı basamakları sorularını bölünebilirlikle birleştiren karma sorularda kullanılabilir.
- "Basamak değerleri toplamı" ifadesi ile "rakamları toplamı" ifadesi FARKLI kavramlardır; birincisi sayının kendisine eşittir (746 = 700+40+6), ikincisi sadece rakamların toplamıdır (7+4+6=17).

## Video Ders Takip Rehberi
- [00:00 - 05:00] Basamak adları ve sayının basamaklara ayrılması.
- [05:00 - 12:00] Basamak değeri ile sayı değeri arasındaki fark, örneklerle.
- [12:00 - 20:00] Verilen rakamlarla en büyük/en küçük sayı oluşturma teknikleri.
- [20:00 - Bitiş] Basamaklar arası ilişkili denklem problemleri, çözümlü örnekler.', '352 sayısında 5 rakamının basamak değeri ile sayı değeri arasındaki fark kaçtır?
A) 5 B) 40 C) 45 D) 50 E) 55
Doğru Cevap: C — 5''in basamak değeri (onlar basamağında olduğu için) 50''dir, sayı değeri ise 5''tir; fark 50-5=45''tir.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a76157d0-9352-4272-801f-a86185155a4b', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, '746 sayısında 7 rakamının basamak değeri kaçtır?', 'Basamak değerini hesaplar.', '746 sayısında 7 rakamı yüzler basamağındadır; bu nedenle basamak değeri 7×100 = 700''dür (C doğru). Sayı değeri (yalnızca 7) ile basamak değeri (700) birbirine karıştırılmamalıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a76157d0-9352-4272-801f-a86185155a4b', '7', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a76157d0-9352-4272-801f-a86185155a4b', '70', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a76157d0-9352-4272-801f-a86185155a4b', '700', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a76157d0-9352-4272-801f-a86185155a4b', '7000', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a76157d0-9352-4272-801f-a86185155a4b', '74', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, 'Üç basamaklı bir sayının yüzler basamağı 4, onlar basamağı yüzler basamağının 2 katı, birler basamağı ise onlar basamağının yarısı kadardır. Bu sayı kaçtır?', 'Basamaklar arası ilişkili denklemleri çözer.', 'Yüzler basamağı 4 olduğuna göre onlar basamağı 4×2=8, birler basamağı ise 8/2=4 olur; sayı 484''tür (C doğru). Diğer seçenekler basamakların yanlış sıraya konulmasından veya hesap hatasından kaynaklanmaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '424', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '442', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '484', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '488', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2e895e73-66dd-40ea-88bd-fe4bfc11dcf4', '848', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'orta'::difficulty_level, '2 ve 5 rakamları kullanılarak (rakamlar tekrar edilmeden) yazılabilecek en büyük iki basamaklı sayı ile en küçük iki basamaklı sayının farkı kaçtır?', 'Rakamlarla en büyük/en küçük sayı oluşturma tekniğini uygular.', 'En büyük iki basamaklı sayı, büyük rakam sola yazılarak 52 elde edilir; en küçük iki basamaklı sayı ise küçük rakam sola yazılarak 25 elde edilir (burada 0 olmadığı için ekstra bir kısıt yoktur). Fark 52-25=27''dir (C doğru).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '23', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '25', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '27', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '30', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e3d9dc55-5ced-472a-a42d-099a3485ee40', '33', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'zor'::difficulty_level, 'Üç basamaklı bir sayı ''abc'' biçiminde gösterilsin (a, b, c birer rakamdır). a=2b ve c=b+3 olduğuna göre, b=2 iken bu sayı kaçtır?', 'Değişkenli basamak ilişkilerini kullanarak sayıyı bulur.', 'b=2 verildiğine göre a=2×2=4 ve c=2+3=5 olur; sayı a,b,c basamaklarından oluştuğu için 425''tir (B doğru). Diğer seçenekler basamakların yanlış sıralanmasından (örneğin b ve a''nın yer değiştirmesi) kaynaklanan tipik hatalı sonuçlardır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '245', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '425', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '452', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '524', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6cba4934-8658-4e92-89e5-dc48fe6009df', '542', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'Kesir-ondalık sayı dönüşümü, kesirlerde toplama-çıkarma-çarpma-bölme işlemleri, kesirleri ortak payda veya ondalık karşılıklarına çevirerek büyüklüklerine göre sıralama ve kesirli sayı problemleri (bir sayının kesri verilip sayının kendisinin bulunması) bu konunun temel alt başlıklarıdır.', '## Kesir - Ondalık Sayı Dönüşümü
Bir a/b kesri, pay (a) paydaya (b) bölünerek ondalık sayıya çevrilir: 3/4 = 3÷4 = 0.75. Paydası 10, 100, 1000 gibi 10''un kuvvetleri olan kesirler doğrudan ondalık gösterime çevrilebilir; olmayan durumlarda payda genişletme/daraltma veya bölme işlemi uygulanır.

## Kesirlerde Dört İşlem
Toplama-çıkarmada kesirler ortak paydaya (paydaların EKOK''una) getirilerek paylar toplanır/çıkarılır: 2/3 + 3/4 = 8/12 + 9/12 = 17/12. Çarpmada pay paya, payda paydaya çarpılır: (a/b)×(c/d) = (a×c)/(b×d). Bölmede ikinci kesirin ters çevrilmiş hâli ile çarpma yapılır: (a/b)÷(c/d) = (a/b)×(d/c).

## Kesirleri Sıralama
Kesirleri büyüklüklerine göre sıralamak için ya ortak paydaya getirilir ya da her biri ondalık sayıya çevrilerek karşılaştırılır. Paydaları eşit kesirlerde payı büyük olan kesir daha büyüktür; payları eşit kesirlerde ise paydası küçük olan kesir daha büyüktür (parça sayısı azaldıkça her parçanın büyüklüğü artar).

## Kesirli Sayı Problemleri
"Bir sayının kesri verilip sayının kendisinin bulunması" tipi problemlerde, verilen kesir bir denklem kurmak için kullanılır: "Bir sayının 2/5''i 40''tır" ifadesi (2/5)×x = 40 denklemine karşılık gelir ve x = 40 ÷ (2/5) = 40 × (5/2) = 100 bulunur.

## Kritik Hap Notlar
- Kesir toplama-çıkarmada PAYDALAR eşitlenmeden PAYLAR toplanamaz; bu en sık yapılan işlem hatasıdır.
- Kesirleri hızlıca karşılaştırmanın en güvenilir yolu her birini ondalık sayıya çevirmektir; özellikle üç veya daha fazla kesir karşılaştırılırken bu yöntem zaman kazandırır.
- Payları eşit kesirlerde paydası KÜÇÜK olan kesir daha BÜYÜKTÜR (örnek: 1/3 > 1/5, çünkü bütün 3 eşit parçaya bölündüğünde her parça, 5 eşit parçaya bölündüğünde oluşan parçadan daha büyüktür).
- "Bir sayının X/Y''si Z''dir" tarzı problemlerde sayının TAMAMI, Z''nin (Y/X) ile çarpılmasıyla (yani Z''nin X/Y''ye bölünmesiyle) bulunur.
- Kesirli işlemlerde çarpma ve bölme işlem önceliği toplama-çıkarmadan önce gelir; karma işlemlerde bu sıra gözetilmelidir.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Kesir-ondalık sayı dönüşümü ve örnekler.
- [05:00 - 12:00] Kesirlerde toplama, çıkarma, çarpma ve bölme işlemleri.
- [12:00 - 20:00] Kesirleri ondalık karşılıklarıyla büyüklüklerine göre sıralama.
- [20:00 - Bitiş] "Bir sayının kesri verilen" problem tipleri ve çözümlü örnekler.', 'Bir sayının 3/8''i 24 olduğuna göre bu sayının yarısı kaçtır?
A) 24 B) 28 C) 32 D) 36 E) 40
Doğru Cevap: C — Sayı = 24 ÷ (3/8) = 24 × (8/3) = 64; bu sayının yarısı 64/2 = 32''dir.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '3/4 kesrinin ondalık gösterimi aşağıdakilerden hangisidir?', 'Kesir-ondalık sayı dönüşümünü uygular.', '3/4 kesrinde pay (3), paydaya (4) bölündüğünde 0.75 sonucu elde edilir (C doğru). Bu dönüşüm doğrudan bölme işlemiyle veya kesri paydası 100 olacak şekilde genişleterek (3/4 = 75/100 = 0.75) yapılabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '0.25', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '0.34', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '0.75', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '0.43', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('601566c2-fc70-4140-a48c-1399c2ef4d1d', '1.33', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '2/3 ile 3/4 kesirlerinin toplamı kaçtır?', 'Kesirlerde toplama işlemini uygular.', '2/3 ve 3/4 kesirlerinin paydalarının EKOK''u 12''dir; 2/3 = 8/12 ve 3/4 = 9/12 olarak yazılıp paylar toplanır: 8/12 + 9/12 = 17/12 (A doğru). Bu sonuç bileşik kesir olduğu için 1''den büyüktür, bu da mantıksal olarak beklenen bir durumdur çünkü her iki kesir de 1/2''den büyüktür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '17/12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '5/7', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '6/12', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '1', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d9743d4-f9eb-460d-add9-53c5b58d48b4', '5/12', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '1/2, 2/3 ve 3/5 kesirleri büyükten küçüğe nasıl sıralanır?', 'Kesirleri büyüklüklerine göre sıralar.', 'Kesirler ondalık sayıya çevrildiğinde 1/2=0.5, 2/3≈0.667 ve 3/5=0.6 değerlerine ulaşılır. Büyükten küçüğe sıralama 2/3 > 3/5 > 1/2 şeklindedir (B doğru). Bu tür üç kesirli karşılaştırmalarda ondalık çevirme, ortak payda bulmaktan genellikle daha hızlı bir yöntemdir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '1/2, 2/3, 3/5', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '2/3, 3/5, 1/2', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '3/5, 2/3, 1/2', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '1/2, 3/5, 2/3', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b7621750-bd7d-45b2-9426-1d218e26a8d2', '2/3, 1/2, 3/5', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'zor'::difficulty_level, 'Bir sayının 2/5''i 40 olduğuna göre bu sayının 3/4''ü kaçtır?', 'Kesirli sayı problemlerini çözer.', 'Önce sayının kendisi bulunur: (2/5)×x = 40 → x = 40 ÷ (2/5) = 40 × (5/2) = 100. Bu sayının 3/4''ü ise (3/4)×100 = 75''tir (D doğru). Bu tür iki aşamalı problemlerde önce sayının tamamını bulup ardından istenen kesri hesaplamak en güvenilir yoldur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '60', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '64', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '70', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '75', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('25f527ea-0ce9-4aef-89fb-972f6ea49be5', '80', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f609f88b-2d72-42bc-bdb7-549657da2fd0', 'Yaş problemleri, hareket (hız-yol-zaman) problemleri, işçi/havuz (birlikte çalışma) problemleri ve yüzde-kâr/zarar problemleri KPSS Matematik''te en sık çıkan problem tipleridir. Her biri kendine özgü bir denklem kurma mantığına sahiptir ve bu mantığı kavramak, farklı sayılarla sorulan varyasyonları hızla çözmeyi sağlar.', '## Yaş Problemleri
Yaş problemlerinde kişilerin şu anki yaşlarına bir değişken atanır (örneğin kızın yaşı x, babanın yaşı bu değişkene bağlı bir ifade). "N yıl sonra/önce" ifadeleri geçtiğinde HER İKİ kişinin yaşına da aynı N eklenir/çıkarılır — yaş farkı zamanla DEĞİŞMEZ, bu problemlerin temel prensibidir.

## Hareket (Hız-Yol-Zaman) Problemleri
Temel bağıntı: Yol = Hız × Zaman. İki araç birbirine doğru (ZIT yönde) hareket ediyorsa hızları TOPLANARAK birleşik hız bulunur ve karşılaşma süresi Toplam Yol ÷ Toplam Hız ile hesaplanır. İki araç AYNI yönde hareket ediyorsa hızları arasındaki FARK kullanılır (biri diğerine yetişme problemi).

## İşçi / Havuz (Birlikte Çalışma) Problemleri
Bir işi tek başına N günde bitiren birinin bir günde yaptığı iş miktarı 1/N''dir (iş = 1 birim kabul edilir). Birden fazla kişi/musluk birlikte çalışıyorsa günlük iş oranları TOPLANIR; toplam süre bu toplamın tersi (1''e bölünmesi) alınarak bulunur.

## Yüzde - Kâr/Zarar Problemleri
%K kârla satış, alış fiyatının (1 + K/100) katıdır; %K zararla satış ise alış fiyatının (1 - K/100) katıdır. ÖNEMLİ TUZAK: ardışık yüzde değişimlerinde (önce %a artış sonra %b azalış gibi) yüzdeler DOĞRUDAN TOPLANIP/ÇIKARILAMAZ; her işlem sırayla bir önceki sonuç üzerinden çarpanla uygulanmalıdır (örneğin %20 artış sonra %20 azalış, başlangıca göre net bir DEĞİŞİKLİK olmadan kalmaz, aksine %4 azalmaya yol açar).

## Kritik Hap Notlar
- Yaş problemlerinde iki kişi arasındaki YAŞ FARKI zaman içinde asla değişmez; bu bilgi birçok yaş problemini kısayoldan çözmeyi sağlar.
- Hareket problemlerinde "karşılaşma/buluşma" ifadesi ZIT yön ve hızların TOPLANMASI anlamına gelirken, "yetişme/kovalama" ifadesi AYNI yön ve hızların FARKI anlamına gelir.
- İşçi/havuz problemlerinde iş her zaman "1 birim" kabul edilir; kişilerin/musluğun birim zamandaki iş oranları (1/süre) toplanarak birlikte çalışma süresi bulunur.
- Ardışık yüzde artış-azalışlarda (%a artış + %b azalış) net değişim asla a-b değildir; doğru yöntem çarpanları (1+a/100)×(1-b/100) sırayla uygulamaktır.
- Kâr/zarar problemlerinde "satış fiyatı" ile "alış fiyatı" karıştırılmamalı; yüzde her zaman ALIŞ FİYATI üzerinden hesaplanır (aksi belirtilmedikçe).

## Video Ders Takip Rehberi
- [00:00 - 05:00] Yaş problemlerinde denklem kurma mantığı, yaş farkının sabitliği.
- [05:00 - 12:00] Hareket problemleri: karşılaşma (hız toplamı) ve yetişme (hız farkı) tipleri.
- [12:00 - 20:00] İşçi/havuz problemlerinde birim iş oranı ve birlikte çalışma süresi hesaplama.
- [20:00 - Bitiş] Yüzde-kâr/zarar problemleri ve ardışık yüzde değişimi tuzağı, çözümlü örnekler.', 'Bir işi Ayşe tek başına 8 günde, Fatma tek başına 24 günde bitirebiliyor. İkisi birlikte kaç günde bitirirler?
A) 4 B) 5 C) 6 D) 8 E) 12
Doğru Cevap: C — Günlük iş oranları toplamı 1/8 + 1/24 = 3/24 + 1/24 = 4/24 = 1/6; bu nedenle iş 6 günde biter.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7f202ec4-62cc-476e-b961-2318481297c7', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'kolay'::difficulty_level, 'Ali''nin yaşı, kızının yaşının 3 katıdır. İki yıl sonra Ali''nin yaşı, kızının yaşının 2 katı olacaktır. Buna göre kızın şu anki yaşı kaçtır?', 'Yaş problemlerinde denklem kurar.', 'Kızın şu anki yaşı x, Ali''nin yaşı 3x olsun. İki yıl sonra: 3x+2 = 2(x+2) → 3x+2 = 2x+4 → x = 2 bulunur (A doğru). Doğrulama: kız şu an 2, Ali 6 yaşındadır; iki yıl sonra kız 4, Ali 8 yaşında olur ve 8, 4''ün tam olarak 2 katıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f202ec4-62cc-476e-b961-2318481297c7', '2', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f202ec4-62cc-476e-b961-2318481297c7', '3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f202ec4-62cc-476e-b961-2318481297c7', '4', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f202ec4-62cc-476e-b961-2318481297c7', '5', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7f202ec4-62cc-476e-b961-2318481297c7', '6', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8328c403-2194-4400-938d-b83a50e422f4', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'İki şehir arası uzaklık 300 km''dir. Bir araç A şehrinden B şehrine 60 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 90 km/sa hızla hareket ederse kaç saat sonra karşılaşırlar?', 'Hareket problemlerinde karşılaşma (zıt yön) mantığını uygular.', 'Araçlar zıt yönlerden hareket ettiği için hızları toplanır: 60+90=150 km/sa birleşik hız elde edilir. Karşılaşma süresi Toplam Yol ÷ Birleşik Hız = 300 ÷ 150 = 2 saat olarak bulunur (C doğru).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8328c403-2194-4400-938d-b83a50e422f4', '1 saat', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8328c403-2194-4400-938d-b83a50e422f4', '1,5 saat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8328c403-2194-4400-938d-b83a50e422f4', '2 saat', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8328c403-2194-4400-938d-b83a50e422f4', '2,5 saat', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8328c403-2194-4400-938d-b83a50e422f4', '3 saat', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a77eea97-c992-469b-94b0-ca8d22782688', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir işi Ali tek başına 12 günde, Veli tek başına 6 günde bitirebiliyor. İkisi birlikte çalışırsa işi kaç günde bitirirler?', 'İşçi problemlerinde birlikte çalışma süresini hesaplar.', 'Ali''nin günlük iş oranı 1/12, Veli''ninki 1/6''dır. Birlikte günlük iş oranları toplamı 1/12 + 1/6 = 1/12 + 2/12 = 3/12 = 1/4''tür; bu da işin 4 günde biteceği anlamına gelir (B doğru).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a77eea97-c992-469b-94b0-ca8d22782688', '3', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a77eea97-c992-469b-94b0-ca8d22782688', '4', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a77eea97-c992-469b-94b0-ca8d22782688', '5', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a77eea97-c992-469b-94b0-ca8d22782688', '6', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a77eea97-c992-469b-94b0-ca8d22782688', '8', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'zor'::difficulty_level, 'Bir ürünün fiyatı önce %20 zamlanmış, ardından yeni fiyat üzerinden %20 indirim uygulanmıştır. Ürünün son fiyatı ilk fiyatına göre nasıl değişmiştir?', 'Ardışık yüzde değişimlerinin net etkisini hesaplar.', 'İlk fiyat 100 birim kabul edilirse, %20 zamdan sonra fiyat 100×1,20=120 olur. Bu yeni fiyat üzerinden %20 indirim uygulandığında 120×0,80=96 elde edilir; bu da ilk fiyata göre %4''lük bir AZALIŞ anlamına gelir (B doğru). Bu problem, ardışık yüzde değişimlerinde yüzdelerin doğrudan toplanıp çıkarılamayacağının (%20-%20=0 gibi yanlış bir sezgiyle) klasik bir örneğidir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', '%4 artmıştır', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', '%4 azalmıştır', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', 'Değişmemiştir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', '%40 azalmıştır', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aab90621-7453-4006-a2cc-7ee3e8aa1e89', '%20 azalmıştır', false, 4);

