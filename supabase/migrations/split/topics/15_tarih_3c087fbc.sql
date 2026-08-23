begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'İnkılap Tarihi, Cumhuriyet''in ilanından itibaren Mustafa Kemal Atatürk önderliğinde siyasi, hukuki, eğitim ve toplumsal alanlarda gerçekleştirilen köklü değişimleri (inkılapları) kapsar.', '## Siyasi İnkılaplar
- 1 Kasım 1922''de saltanat kaldırılarak Osmanlı hanedanının siyasi yetkisi sona erdirilmiştir.
- 29 Ekim 1923''te Cumhuriyet ilan edilmiş, Mustafa Kemal ilk Cumhurbaşkanı seçilmiştir.
- 3 Mart 1924''te halifelik kaldırılarak laik devlet düzenine geçişte önemli bir adım atılmıştır.

## Eğitim ve Hukuk Alanındaki İnkılaplar
- 3 Mart 1924''te kabul edilen Tevhid-i Tedrisat Kanunu ile eğitim kurumları Millî Eğitim Bakanlığı çatısı altında birleştirilerek eğitimde birlik sağlanmıştır.
- 1925 yılında tekke, zaviye ve türbeler kapatılmıştır.
- 25 Kasım 1925''te Şapka Kanunu kabul edilmiştir.
- 17 Şubat 1926''da İsviçre Medeni Kanunu esas alınarak Türk Medeni Kanunu kabul edilmiş; kadın-erkek eşitliği hukuki zeminde güçlendirilmiştir.

## Harf ve Dil İnkılabı
- 1 Kasım 1928''de kabul edilen kanunla Latin harflerine dayalı yeni Türk alfabesine geçilmiştir.

## Toplumsal ve Siyasi Haklar
- 1930 yılında kadınlara belediye seçimlerinde seçme hakkı tanınmıştır.
- 1934 yılında kadınlara milletvekili seçme ve seçilme hakkı tanınmıştır.
- 1934 yılında Soyadı Kanunu kabul edilerek herkesin bir soyadı alması zorunlu hale getirilmiştir.

## Genel Değerlendirme
Bu inkılaplar; laik, çağdaş ve millî egemenliğe dayalı bir devlet ve toplum yapısı oluşturmayı amaçlamış, kısa sürede birbirini tamamlayan bir bütünlük içinde gerçekleştirilmiştir.', 'Eğitim kurumlarını Millî Eğitim Bakanlığı çatısı altında birleştiren ve eğitimde birliği sağlayan kanun hangisidir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7561cded-6fc6-4674-a746-2c36f53e4ce9', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'kolay'::difficulty_level, 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', 'Cumhuriyetin ilan tarihini bilir.', 'Türkiye Cumhuriyeti, 29 Ekim 1923 tarihinde ilan edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7561cded-6fc6-4674-a746-2c36f53e4ce9', '29 Ekim 1923', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7561cded-6fc6-4674-a746-2c36f53e4ce9', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7561cded-6fc6-4674-a746-2c36f53e4ce9', '1 Kasım 1922', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7561cded-6fc6-4674-a746-2c36f53e4ce9', '3 Mart 1924', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7efba5dc-1c61-4a64-aee9-c2ea34c8adf9', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'kolay'::difficulty_level, 'Osmanlı hanedanının siyasi yetkisinin sona erdirildiği saltanatın kaldırılması hangi tarihte gerçekleşmiştir?', 'Saltanatın kaldırılış tarihini ve önemini bilir.', 'Saltanat, 1 Kasım 1922 tarihinde TBMM kararıyla kaldırılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efba5dc-1c61-4a64-aee9-c2ea34c8adf9', '1 Kasım 1922', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efba5dc-1c61-4a64-aee9-c2ea34c8adf9', '29 Ekim 1923', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efba5dc-1c61-4a64-aee9-c2ea34c8adf9', '3 Mart 1924', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7efba5dc-1c61-4a64-aee9-c2ea34c8adf9', '17 Şubat 1926', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fdfe8289-3755-43dd-bba4-9070ad028bc7', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'orta'::difficulty_level, 'Halifeliğin kaldırılması ile eğitimde birliği sağlayan Tevhid-i Tedrisat Kanunu''nun kabulü, 1924 yılında hangi tarihte aynı gün gerçekleşmiştir?', 'Halifeliğin kaldırılması ve Tevhid-i Tedrisat Kanunu''nun tarihini ve ilişkisini bilir.', 'Halifelik ile Tevhid-i Tedrisat Kanunu, aynı gün olan 3 Mart 1924''te kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fdfe8289-3755-43dd-bba4-9070ad028bc7', '3 Mart', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fdfe8289-3755-43dd-bba4-9070ad028bc7', '1 Kasım', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fdfe8289-3755-43dd-bba4-9070ad028bc7', '25 Kasım', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fdfe8289-3755-43dd-bba4-9070ad028bc7', '17 Şubat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fce18be3-ef6f-4d53-9637-3281a4cebea6', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'orta'::difficulty_level, 'Türk kadınına milletvekili seçme ve seçilme hakkının tanındığı yıl aşağıdakilerden hangisidir?', 'Kadınlara tanınan siyasi hakların tarihsel sürecini bilir.', 'Kadınlara milletvekili seçme ve seçilme hakkı 1934 yılında tanınmıştır; 1930 yılında ise yalnızca belediye seçimlerinde seçme hakkı verilmişti.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fce18be3-ef6f-4d53-9637-3281a4cebea6', '1934', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fce18be3-ef6f-4d53-9637-3281a4cebea6', '1930', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fce18be3-ef6f-4d53-9637-3281a4cebea6', '1926', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fce18be3-ef6f-4d53-9637-3281a4cebea6', '1928', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('04764c8b-d0e6-451e-9692-dc6c568f9dcc', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'zor'::difficulty_level, 'Aşağıdaki inkılaplardan hangisi kronolojik olarak diğerlerinden daha sonra gerçekleşmiştir?', 'Cumhuriyet dönemi inkılaplarını kronolojik sıraya göre değerlendirir.', 'Soyadı Kanunu 1934 yılında kabul edilmiş olup, Medeni Kanun (1926), Harf İnkılabı (1928) ve Şapka Kanunu''ndan (1925) daha sonraki bir tarihte gerçekleşmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04764c8b-d0e6-451e-9692-dc6c568f9dcc', 'Soyadı Kanunu (1934)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04764c8b-d0e6-451e-9692-dc6c568f9dcc', 'Medeni Kanun''un kabulü (1926)', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04764c8b-d0e6-451e-9692-dc6c568f9dcc', 'Harf İnkılabı (1928)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('04764c8b-d0e6-451e-9692-dc6c568f9dcc', 'Şapka Kanunu (1925)', false, 3);
commit;