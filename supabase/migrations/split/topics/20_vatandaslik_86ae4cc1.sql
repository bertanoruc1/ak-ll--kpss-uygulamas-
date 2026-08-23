begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('86ae4cc1-2323-4a43-8448-b1fa4daf514e', '1982 Anayasası''nın kabul süreci, temel ilkeleri, Başlangıç hükümlerinin bağlayıcılığı ve değiştirilemez maddelerini ele alır.', '## 1982 Anayasası''nın Genel Çerçevesi
1982 Anayasası, halkoylaması sonucunda kabul edilerek yürürlüğe girmiş ve Türkiye Cumhuriyeti''nin temel hukuki metnidir. Anayasa, devletin yapısını, temel hak ve özgürlükleri, devlet organlarının kuruluş ve işleyişini düzenler.

## Başlangıç Hükümlerinin Niteliği
Anayasa''nın **Başlangıç** kısmı, sadece siyasi bir bildiri niteliğinde değildir; Anayasa metninin **ayrılmaz bir parçasını** oluşturur ve Anayasa''nın diğer maddeleriyle birlikte hukuken bağlayıcıdır. Başlangıç''ta Atatürk milliyetçiliği, milli egemenlik, cumhuriyetin nitelikleri gibi temel değerlere vurgu yapılır ve bu değerler Anayasa''nın yorumlanmasında da esas alınır.

## Anayasa''nın Temel İlkeleri
1982 Anayasası''na göre Türkiye Devleti''nin nitelikleri şunlardır:
- **Cumhuriyetçilik:** Devletin yönetim şekli cumhuriyettir.
- **Milli (ulusal) egemenlik:** Egemenlik kayıtsız şartsız millete aittir.
- **Demokratik devlet:** Yönetimde çoğulcu demokrasi esastır.
- **Laik devlet:** Din ve devlet işleri birbirinden ayrıdır.
- **Sosyal devlet:** Devlet, sosyal adalet ve refahı sağlamakla yükümlüdür.
- **Hukuk devleti:** Devlet, kendi eylem ve işlemlerinde hukuk kurallarıyla bağlıdır.
- **İnsan haklarına saygılı devlet:** Temel hak ve özgürlükler anayasal güvence altındadır.
- **Atatürk milliyetçiliğine bağlılık.**

## Değiştirilemez Hükümler
Anayasa''da bazı hükümler diğerlerinden farklı bir güvenceye sahiptir: Devletin şeklinin Cumhuriyet olduğunu belirten hüküm, Cumhuriyetin temel niteliklerini sayan hüküm ve devletin bütünlüğü, resmî dili, bayrağı, millî marşı ile başkentine ilişkin hükümler **değiştirilemez** ve bunların değiştirilmesi **teklif dahi edilemez**. Bu düzenleme, devletin temel kimliğini siyasi çoğunluk değişikliklerine karşı güvence altına almayı amaçlar.', '1982 Anayasası''nın Başlangıç kısmının hukuki niteliği ile ilgili aşağıdaki ifadelerden hangisi doğrudur?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('16d79726-f8f9-4eaf-9dce-024e16436c20', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'kolay'::difficulty_level, '1982 Anayasası''na göre Türkiye Devleti''nin şekli nedir?', 'Türkiye Devleti''nin temel yönetim şeklini bilir.', '1982 Anayasası''nın ilgili hükmüne göre Türkiye Devleti''nin şekli Cumhuriyettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('16d79726-f8f9-4eaf-9dce-024e16436c20', 'Monarşi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('16d79726-f8f9-4eaf-9dce-024e16436c20', 'Federasyon', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('16d79726-f8f9-4eaf-9dce-024e16436c20', 'Cumhuriyet', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('16d79726-f8f9-4eaf-9dce-024e16436c20', 'Konfederasyon', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0e0d7bc7-a816-487e-87e1-f4033cffaa3d', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi 1982 Anayasası''nda Cumhuriyetin nitelikleri arasında sayılan temel ilkelerden biri değildir?', 'Cumhuriyetin Anayasa''da sayılan temel niteliklerini ayırt eder.', 'Tek parti yönetimi, çoğulcu demokrasi ilkesiyle bağdaşmadığından Anayasa''da sayılan Cumhuriyetin nitelikleri arasında yer almaz; laiklik, sosyal devlet ve hukuk devleti ise temel niteliklerdendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0e0d7bc7-a816-487e-87e1-f4033cffaa3d', 'Laiklik', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0e0d7bc7-a816-487e-87e1-f4033cffaa3d', 'Tek parti yönetimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0e0d7bc7-a816-487e-87e1-f4033cffaa3d', 'Sosyal devlet', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0e0d7bc7-a816-487e-87e1-f4033cffaa3d', 'Hukuk devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c9a259da-dcbf-4dca-bdbe-96ec617d2e64', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'orta'::difficulty_level, '1982 Anayasası''nın Başlangıç kısmı hakkında aşağıdakilerden hangisi doğrudur?', 'Başlangıç hükümlerinin hukuki bağlayıcılığını açıklar.', 'Anayasa''nın Başlangıç kısmı, Anayasa metninin ayrılmaz bir parçası olup diğer hükümlerle birlikte hukuken bağlayıcıdır; salt sembolik bir metin değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9a259da-dcbf-4dca-bdbe-96ec617d2e64', 'Başlangıç kısmı yalnızca sembolik bir metindir, hukuki bağlayıcılığı yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9a259da-dcbf-4dca-bdbe-96ec617d2e64', 'Başlangıç kısmı sadece Anayasa Mahkemesi kararlarında referans olarak kullanılabilir', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9a259da-dcbf-4dca-bdbe-96ec617d2e64', 'Başlangıç kısmı kanunlarla değiştirilebilir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c9a259da-dcbf-4dca-bdbe-96ec617d2e64', 'Başlangıç kısmı, Anayasa''nın ayrılmaz bir parçasını oluşturur ve Anayasa metnine dahildir', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('da347a01-7530-4a50-b5ee-1f5fe5dd5307', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'orta'::difficulty_level, 'Anayasa''da yer alan "değiştirilemez ve değiştirilmesi teklif dahi edilemez" hükümler esas olarak neyi korumayı amaçlar?', 'Değiştirilemez Anayasa hükümlerinin amacını kavrar.', 'Değiştirilemez hükümler, devletin şekli, temel nitelikleri ve devletin bütünlüğü gibi temel unsurları siyasi çoğunluk değişikliklerine karşı korumayı amaçlar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da347a01-7530-4a50-b5ee-1f5fe5dd5307', 'Bakanlar Kurulunun yetkilerini', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da347a01-7530-4a50-b5ee-1f5fe5dd5307', 'Yerel yönetimlerin özerkliğini', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da347a01-7530-4a50-b5ee-1f5fe5dd5307', 'Devletin temel niteliklerini (Cumhuriyet, devletin şekli, temel unsurları)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('da347a01-7530-4a50-b5ee-1f5fe5dd5307', 'Siyasi partilerin kapatılma usulünü', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d2974b43-53b4-4364-90bb-302616514f64', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'zor'::difficulty_level, '1982 Anayasası''nın "değiştirilemeyecek hükümler" ile ilgili düzenlemesi hakkında aşağıdakilerden hangisi doğrudur?', 'Değiştirilemez hükümlere ilişkin özel güvenceyi açıklar.', 'Anayasa''da bu hükümlerin yalnızca değiştirilmesi değil, değiştirilmesinin teklif edilmesi bile açıkça yasaklanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d2974b43-53b4-4364-90bb-302616514f64', 'Bu hükümlerin değiştirilmesi TBMM üye tam sayısının 2/3 çoğunluğuyla mümkündür', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d2974b43-53b4-4364-90bb-302616514f64', 'Bu hükümler halkoylaması ile değiştirilebilir ancak TBMM tarafından değiştirilemez', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d2974b43-53b4-4364-90bb-302616514f64', 'Bu hükümlerin sadece değiştirilmesi değil, değiştirilmesinin teklif edilmesi dahi yasaktır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d2974b43-53b4-4364-90bb-302616514f64', 'Bu hükümler yalnızca Anayasa Mahkemesi kararıyla değiştirilebilir', false, 3);
commit;