begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'Virgül, iki nokta, noktalı virgül, kesme işareti, üç nokta ve ünlem işaretinin doğru kullanım kurallarını örneklerle açıklayan bu konu, noktalama hatalarını ayırt etmeyi hedefler.', '## Virgül (,)
Eş görevli kelime veya kelime gruplarını sıralarken kullanılır: ''Çarşıdan elma, armut, muz ve şeftali aldı.'' Sıralı cümleleri, ara sözleri ve hitap sözlerini ayırmak için de virgül konur. ''Ve'' bağlacından hemen önce genellikle virgül kullanılmaz.

## İki Nokta (:)
Kendisinden sonra örnek verilecek, açıklama yapılacak ya da bir liste sıralanacak cümlenin sonuna konur: ''Kırtasiyeden şunları aldım: kalem, silgi, defter.'' Ayrıca alıntı sözlerden önce de kullanılır: ''Öğretmenimiz: ''Yarın sınav var.'' dedi.''

## Noktalı Virgül (;)
Virgüllerle ayrılmış öğe gruplarını birbirinden ayırmak için ya da bağlaç kullanılmadan birbirine bağlı cümleleri ayırmak için kullanılır: ''Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.''

## Kesme İşareti ('')
Özel isimlere getirilen çekim eklerini ayırmak için kullanılır: ''İstanbul''da, Ahmet''in, Türkiye''ye.'' Cins (tür bildiren) isimlere gelen ekler kesme işaretiyle ayrılmaz: ''kalemi, öğretmene, kitabı'' gibi.

## Üç Nokta (...)
Tamamlanmamış cümlelerin sonuna, sözün bir yerde kesildiğini göstermek için ya da kaba sayılan sözlerin yerine kullanılır.

## Ünlem İşareti (!)
Sevinç, kızgınlık, korku, şaşkınlık gibi güçlü duyguları anlatan cümlelerin ve seslenme sözlerinin sonuna konur: ''Ne güzel bir manzara!''

Doğru noktalama, hem okunabilirliği artırır hem de cümlenin anlamını netleştirir; bu nedenle KPSS''de noktalama işaretlerinin yerinde kullanılıp kullanılmadığı sıkça sorulur.', 'Örnek: ''Öğretmenimiz Yarın sınav var dedi.'' cümlesinde hangi noktalama işaretleri eksiktir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cfe4766a-995c-479b-9dbc-ab6a1f01784d', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmıştır?', 'Kesme işaretinin özel isimlere gelen eklerde kullanıldığını kavrar.', '''Ahmet'' bir özel isim olduğu için aldığı ''-in'' eki kesme işaretiyle ayrılmıştır. Diğer seçeneklerdeki ''kalem, öğretmen, kitap'' cins isim olduğundan aldıkları ekler kesme işaretiyle ayrılmaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cfe4766a-995c-479b-9dbc-ab6a1f01784d', 'Ahmet''in kitabını dün akşam okudum.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cfe4766a-995c-479b-9dbc-ab6a1f01784d', 'Kalem''imi masanın üstünde unuttum.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cfe4766a-995c-479b-9dbc-ab6a1f01784d', 'Öğretmen''e ödevimi teslim ettim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cfe4766a-995c-479b-9dbc-ab6a1f01784d', 'Kitab''ı çantama koydum.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9d38f7dc-0de1-4785-8c5f-98319e6503ad', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde virgül (,) doğru bir yerde kullanılmıştır?', 'Sıralama bildiren cümlelerde virgülün doğru kullanımını uygular.', 'Eş görevli kelimeler olan ''elma, armut, muz'' birbirinden virgülle ayrılmış, son öğeden önce ''ve'' bağlacı kullanıldığı için virgüle gerek duyulmamıştır. Diğer seçeneklerde virgüller anlamsız ya da gereksiz yerlere konmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d38f7dc-0de1-4785-8c5f-98319e6503ad', 'Çarşıdan elma, armut, muz ve şeftali aldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d38f7dc-0de1-4785-8c5f-98319e6503ad', 'Çarşıdan, elma armut muz ve şeftali aldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d38f7dc-0de1-4785-8c5f-98319e6503ad', 'Çarşıdan elma armut, muz ve, şeftali aldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9d38f7dc-0de1-4785-8c5f-98319e6503ad', 'Çarşıdan elma armut muz, ve şeftali, aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4dd6a8ba-8bb4-4594-bd2b-5ce1855546f2', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde iki nokta (:) doğru kullanılmıştır?', 'İki noktanın örnek/liste verme işlevini kavrar.', 'Birinci cümlede iki nokta, kendisinden sonra bir liste (örnek) sıralanacağını haber verdiği için doğru kullanılmıştır. Diğer cümlelerde iki noktayı gerektiren bir açıklama ya da örnekleme durumu yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4dd6a8ba-8bb4-4594-bd2b-5ce1855546f2', 'Kırtasiyeden şunları aldım: kalem, silgi, defter.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4dd6a8ba-8bb4-4594-bd2b-5ce1855546f2', 'Yarın: erken kalkıp işe gideceğim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4dd6a8ba-8bb4-4594-bd2b-5ce1855546f2', 'Bahçede: çiçekler yeni açmıştı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4dd6a8ba-8bb4-4594-bd2b-5ce1855546f2', 'O gün: eve oldukça geç geldi.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cdc7b08d-5cec-4ebe-a618-f5faee9f0331', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalı virgül (;) doğru kullanılmıştır?', 'Noktalı virgülün virgüllerle ayrılmış öğe gruplarını ayırma işlevini uygular.', 'Birinci cümlede virgüllerle ayrılmış iki farklı kişi grubu (''Ali, Veli, Ayşe'' ve ''Mehmet, Fatma'') noktalı virgülle birbirinden ayrılmıştır. Diğer cümlelerde noktalı virgül gereksiz yere, herhangi bir öğe grubunu ayırmadan kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cdc7b08d-5cec-4ebe-a618-f5faee9f0331', 'Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cdc7b08d-5cec-4ebe-a618-f5faee9f0331', 'Bu kitabı; okuyup çok beğendim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cdc7b08d-5cec-4ebe-a618-f5faee9f0331', 'Yarın; erkenden okula gideceğim.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cdc7b08d-5cec-4ebe-a618-f5faee9f0331', 'Akşam; ailecek yemek yedik.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('95bcc103-0280-415a-bab1-59613765dece', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin tamamı doğru kullanılmıştır?', 'Birden fazla noktalama kuralını bir arada değerlendirerek doğru cümleyi seçer.', 'İkinci cümlede iki nokta, kendisinden sonra gelen alıntı sözden önce doğru biçimde kullanılmış, tırnak içindeki alıntı da doğru noktalanmıştır. Diğer cümlelerde noktalı virgül gereksiz yere kullanılmış ya da ''masadaki'' kelimesine yanlışlıkla kesme işareti eklenmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('95bcc103-0280-415a-bab1-59613765dece', 'Ahmet''e, İstanbul''dan gelen; mektubu hemen verdim.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('95bcc103-0280-415a-bab1-59613765dece', 'Öğretmenimiz: ''Yarın sınav var.'' dedi.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('95bcc103-0280-415a-bab1-59613765dece', 'Masada''ki kitapları, düzenle dedi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('95bcc103-0280-415a-bab1-59613765dece', 'Çarşıya gidip; elma, armut aldım.', false, 3);
commit;