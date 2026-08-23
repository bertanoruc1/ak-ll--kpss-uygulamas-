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
insert into topic_contents (topic_id, summary, content_md, example_question) values ('091291bb-a136-48e2-94b1-8d12631be6ad', 'Kurtuluş Savaşı (Millî Mücadele), Mondros Ateşkes Antlaşması sonrası işgallere karşı Mustafa Kemal önderliğinde örgütlenen direniş sürecidir; kongreler, TBMM''nin açılışı, cepheler ve Lozan Antlaşması''yla sonuçlanmıştır.', '## Hazırlık Dönemi
- 30 Ekim 1918''de Mondros Ateşkes Antlaşması imzalanmış, İtilaf Devletleri Anadolu''yu işgale başlamıştır.
- 19 Mayıs 1919''da Mustafa Kemal, Millî Mücadele''yi örgütlemek üzere Samsun''a çıkmıştır.

## Kongreler ve Genelgeler
- 22 Haziran 1919''da yayımlanan Amasya Genelgesi, "Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesiyle Millî Mücadele''nin ilk yazılı belgesi kabul edilir.
- Temmuz-Ağustos 1919''da toplanan Erzurum Kongresi bölgesel, Eylül 1919''da toplanan Sivas Kongresi ise ulusal nitelikli bir kongredir; Sivas Kongresi''nde Anadolu ve Rumeli Müdafaa-i Hukuk Cemiyeti kurulmuştur.

## TBMM''nin Açılışı ve Misak-ı Millî
- Son Osmanlı Mebusan Meclisi''nde kabul edilen Misak-ı Millî kararları, millî sınırları ve bağımsızlık ilkelerini belirlemiştir.
- İstanbul''un İtilaf Devletlerince resmen işgal edilmesi (16 Mart 1920) üzerine, 23 Nisan 1920''de Ankara''da TBMM açılmıştır.

## Cepheler
- **Doğu Cephesi:** Kazım Karabekir komutasında Ermenilere karşı mücadele edilmiş, Gümrü Antlaşması ile sonuçlanmıştır.
- **Güney Cephesi:** Kuvay-ı Milliye güçleri Fransızlara karşı Antep, Maraş ve Urfa''da direnmiştir.
- **Batı Cephesi:** Yunan ordusuna karşı I. İnönü (Ocak 1921) ve II. İnönü (Mart-Nisan 1921) muharebeleri kazanılmış, Ağustos-Eylül 1921''de Sakarya Meydan Muharebesi ile Yunan ilerleyişi durdurulmuştur. 26 Ağustos 1922''de başlayan Büyük Taarruz ve 30 Ağustos''taki Başkomutanlık Meydan Muharebesi ile Yunan ordusu kesin olarak yenilgiye uğratılmıştır.

## Savaşın Sonuçları
- Ekim 1922''de Mudanya Ateşkes Antlaşması imzalanmıştır.
- 24 Temmuz 1923''te imzalanan Lozan Antlaşması ile yeni Türk devletinin bağımsızlığı uluslararası alanda tanınmıştır.', 'Millî Mücadele''nin ilk yazılı belgesi olarak kabul edilen ve 22 Haziran 1919''da yayımlanan genelge hangisidir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?', 'Millî Mücadele''nin başlangıç tarihini bilir.', 'Mustafa Kemal, 19 Mayıs 1919''da Samsun''a çıkarak Millî Mücadele''nin fiilen başlamasını sağlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '19 Mayıs 1919', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '30 Ekim 1918', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '29 Ekim 1923', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7347df83-92d4-4a37-8422-6a9da881f470', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?', 'TBMM''nin açılış tarihini ve önemini bilir.', 'TBMM, İstanbul''un işgali üzerine 23 Nisan 1920''de Ankara''da açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '23 Nisan 1920', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '19 Mayıs 1919', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '4 Eylül 1919', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '16 Mart 1920', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('084abb6b-6449-404e-858e-2e74220463dd', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?', 'Amasya Genelgesi''nin içeriğini ve önemini kavrar.', 'Bu ifade, 22 Haziran 1919''da yayımlanan Amasya Genelgesi''nde yer almaktadır ve genelge Millî Mücadele''nin ilk yazılı belgesi kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Amasya Genelgesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Erzurum Kongresi kararları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Sivas Kongresi kararları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Misak-ı Millî', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?', 'Batı Cephesi''ndeki muharebelerin kronolojik sırasını ve önemini bilir.', 'Sakarya Meydan Muharebesi, Ağustos-Eylül 1921''de kazanılmış ve Yunan ilerleyişini durdurarak Türk ordusunun taarruz gücüne geçmesinde dönüm noktası olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'Sakarya Meydan Muharebesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'I. İnönü Muharebesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'Büyük Taarruz', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'II. İnönü Muharebesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', '091291bb-a136-48e2-94b1-8d12631be6ad', 'zor'::difficulty_level, 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?', 'Kurtuluş Savaşı cephelerini ve mücadele edilen devletleri doğru eşleştirir.', 'Antep, Maraş ve Urfa, Güney Cephesi''nde Fransızlara karşı verilen direnişin öne çıktığı yerlerdir; Sakarya, İnönü ve Dumlupınar ise Batı Cephesi''nde Yunanlılara karşı yaşanan muharebe yerleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Antep, Maraş, Urfa', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Sakarya, İnönü, Dumlupınar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Gümrü, Kars, Sarıkamış', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'İzmir, Bursa, Eskişehir', false, 3);
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
