begin;
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
commit;