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
commit;