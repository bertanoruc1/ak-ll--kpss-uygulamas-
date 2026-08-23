begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('145d44b3-a8e7-430f-8778-71fb8929a97d', 'Osmanlı Kuruluş Dönemi, Osman Bey''in 1299''da beyliği kurmasından Fatih Sultan Mehmed''in tahta çıkışına kadar geçen, devletin bir uç beyliğinden güçlü bir imparatorluğa dönüştüğü süreçtir.', '## Osman Bey Dönemi
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
- Devlet, II. Mehmed''in (Fatih) 1451''de tahta çıkışıyla kuruluş döneminin sonuna ve yükseliş dönemine geçiş yapmıştır.', 'Ankara Savaşı sonrasında yaşanan ve şehzadeler arasındaki taht mücadelelerine sahne olan döneme ne ad verilir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dedc139b-195c-4dc2-aa00-7016ca7e986c', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'kolay'::difficulty_level, 'Osmanlı Devleti''nin kuruluş tarihi olarak kabul edilen 1299 yılında beyliği kuran kişi kimdir?', 'Osmanlı Devleti''nin kuruluşunu ve kurucusunu bilir.', 'Osmanlı Devleti''nin kuruluşu, Osman Bey tarafından 1299 yılında gerçekleştirilmiş olarak kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dedc139b-195c-4dc2-aa00-7016ca7e986c', 'Osman Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dedc139b-195c-4dc2-aa00-7016ca7e986c', 'Orhan Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dedc139b-195c-4dc2-aa00-7016ca7e986c', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dedc139b-195c-4dc2-aa00-7016ca7e986c', 'II. Mehmed', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('13f8c492-d1f0-47ca-b3fb-b68ccb2b437a', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'kolay'::difficulty_level, 'Bursa''nın fethedilerek başkent yapıldığı, ilk düzenli ordu (Yaya-Müsellem) ve ilk medresenin (İznik) kurulduğu dönem hangi padişaha aittir?', 'Orhan Bey dönemindeki kurumsallaşma adımlarını bilir.', 'Orhan Bey döneminde Bursa fethedilmiş, ilk düzenli ordu kurulmuş ve İznik''te ilk medrese açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13f8c492-d1f0-47ca-b3fb-b68ccb2b437a', 'Orhan Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13f8c492-d1f0-47ca-b3fb-b68ccb2b437a', 'Osman Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13f8c492-d1f0-47ca-b3fb-b68ccb2b437a', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('13f8c492-d1f0-47ca-b3fb-b68ccb2b437a', 'Yıldırım Bayezid', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('79c8c371-bd67-46be-8499-acd09104288b', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'orta'::difficulty_level, 'Yıldırım Bayezid''in Timur''a yenilerek esir düştüğü ve Anadolu Türk siyasi birliğinin bozulmasına yol açan savaş aşağıdakilerden hangisidir?', 'Ankara Savaşı''nın Osmanlı kuruluş dönemine etkisini kavrar.', '1402 Ankara Savaşı''nda Yıldırım Bayezid Timur''a yenilmiş ve esir düşmüş, bu durum Fetret Devri''ne zemin hazırlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79c8c371-bd67-46be-8499-acd09104288b', 'Ankara Savaşı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79c8c371-bd67-46be-8499-acd09104288b', 'Niğbolu Savaşı', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79c8c371-bd67-46be-8499-acd09104288b', 'Kosova Savaşı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('79c8c371-bd67-46be-8499-acd09104288b', 'Varna Savaşı', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('198f1bb2-ef06-4de3-8659-c2caa717b4cd', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi I. Murad (Hüdavendigar) döneminde gerçekleşen gelişmelerden biridir?', 'I. Murad dönemi kurumsal ve askeri gelişmelerini diğer padişahlar dönemindeki gelişmelerden ayırt eder.', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması I. Murad dönemine aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198f1bb2-ef06-4de3-8659-c2caa717b4cd', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198f1bb2-ef06-4de3-8659-c2caa717b4cd', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198f1bb2-ef06-4de3-8659-c2caa717b4cd', 'Ankara Savaşı''nın kaybedilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('198f1bb2-ef06-4de3-8659-c2caa717b4cd', 'Bursa''nın fethedilmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('221d56b9-ac38-4e2b-9c61-1e7060b10ed5', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'zor'::difficulty_level, 'Fetret Devri''ni sona erdirerek Osmanlı siyasi birliğini yeniden sağlayan ve bu nedenle "ikinci kurucu" olarak da anılan padişah kimdir?', 'Fetret Devri''nin sona eriş sürecini ve bu süreçteki padişahın rolünü analiz eder.', 'Çelebi Mehmed (I. Mehmed), şehzadeler arası taht mücadelelerini sona erdirerek devletin siyasi birliğini yeniden sağlamış ve bu nedenle ikinci kurucu olarak anılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('221d56b9-ac38-4e2b-9c61-1e7060b10ed5', 'Çelebi Mehmed (I. Mehmed)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('221d56b9-ac38-4e2b-9c61-1e7060b10ed5', 'II. Murad', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('221d56b9-ac38-4e2b-9c61-1e7060b10ed5', 'Yıldırım Bayezid', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('221d56b9-ac38-4e2b-9c61-1e7060b10ed5', 'Orhan Bey', false, 3);
commit;