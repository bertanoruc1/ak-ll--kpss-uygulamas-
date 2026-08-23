begin;
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