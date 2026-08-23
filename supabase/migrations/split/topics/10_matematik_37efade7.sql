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
commit;