begin;
-- ===== tarih =====
insert into topic_contents (topic_id, summary, content_md, example_question) values ('c876132a-c63c-4a00-bc2b-f40f32d682d6', 'İlk Türk devletleri; Asya Hun Devleti, Avrupa Hun Devleti, Göktürk Devleti ve Uygur Devleti başta olmak üzere Orta Asya bozkırlarında kurulan, Türk devlet geleneğinin temelini oluşturan siyasi yapılardır.', '## Asya Hun Devleti
- Bilinen ilk teşkilatlı Türk devleti olarak kabul edilir.
- En parlak dönemini Mete Han (Mao-tun) zamanında, MÖ 209''dan itibaren yaşamıştır.
- Mete Han, "onlu sistem" adı verilen ordu teşkilatını kurarak Türk-Moğol bozkır dünyasında askeri disiplinin temelini atmıştır.
- Çin ile uzun süre mücadele ederek Orta Asya''da geniş bir hakimiyet alanı oluşturmuştur.

## Kavimler Göçü ve Avrupa Hun Devleti
- Asya Hun Devleti''nin zamanla zayıflaması ve Çin baskısı, bazı Hun boylarının batıya yönelmesine yol açmıştır.
- Bu hareket, 375 yılında Kavimler Göçü''nün başlamasına zemin hazırlamıştır.
- Kavimler Göçü, Roma İmparatorluğu''nun 395''te Doğu ve Batı olarak ikiye ayrılmasına, 476''da ise Batı Roma İmparatorluğu''nun yıkılmasına neden olan gelişmelerin önünü açmıştır.
- Avrupa Hun Devleti, 5. yüzyılda Attila döneminde en güçlü dönemini yaşamış, Avrupa''da geniş bir alanda etkili olmuştur.

## Göktürk Devleti
- 552 yılında Bumin Kağan tarafından kurulmuştur.
- "Türk" adını taşıyan ilk devlettir.
- 582 yılında Doğu ve Batı Göktürk Devleti olarak ikiye ayrılmıştır.
- Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen Orhun Yazıtları (Göktürk Abideleri), Türk adının geçtiği ilk yazılı belgeler ve Türkçenin bilinen ilk yazılı metinleri olarak kabul edilir.

## Uygur Devleti
- 745 yılında kurulmuştur.
- Yerleşik hayata geçen ilk Türk devleti olarak bilinir.
- Mani dinini benimseyerek savaşçı bozkır kültüründen uzaklaşmış, tarım ve şehir hayatına yönelmişlerdir.
- Kağıt ve matbaayı kullanan ilk Türk devleti olarak KPSS müfredatında yer alır.

## Ortak Özellikler
İlk Türk devletlerinde "kut" anlayışına dayalı hükümdarlık, kurultay (devlet meclisi) geleneği ve ikili teşkilat (doğu-batı yönetim biçimi) gibi ortak siyasi ve sosyal yapılar dikkat çeker.', 'Aşağıdakilerden hangisi yerleşik hayata geçen ve kağıt-matbaayı kullanan ilk Türk devleti olarak bilinir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aa64213c-9715-4beb-8cda-6ebeb2186996', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?', 'İlk Türk devletlerinden Asya Hun Devleti''nin özelliklerini kavrar.', 'Asya Hun Devleti, Mete Han döneminde onlu sistem ordu teşkilatıyla güçlenmiş ve bilinen ilk teşkilatlı Türk devleti kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa64213c-9715-4beb-8cda-6ebeb2186996', 'Asya Hun Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa64213c-9715-4beb-8cda-6ebeb2186996', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa64213c-9715-4beb-8cda-6ebeb2186996', 'Uygur Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa64213c-9715-4beb-8cda-6ebeb2186996', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a7e8f4a2-2567-4d8e-8477-c23ea61b273b', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?', 'Göktürk Devleti''nin kuruluşu ve kurucusunu bilir.', 'Göktürk Devleti 552 yılında Bumin Kağan tarafından kurulmuş olup Türk adını taşıyan ilk devlettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7e8f4a2-2567-4d8e-8477-c23ea61b273b', 'Bumin Kağan', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7e8f4a2-2567-4d8e-8477-c23ea61b273b', 'Mete Han', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7e8f4a2-2567-4d8e-8477-c23ea61b273b', 'Attila', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7e8f4a2-2567-4d8e-8477-c23ea61b273b', 'Bilge Kağan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c0c851f6-d764-4fbc-84e6-04072b00dff9', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yerleşik yaşam ve kültürel özelliklerini ayırt eder.', 'Uygurlar, Mani dinini kabul ederek yerleşik hayata geçmiş ve kağıt-matbaayı kullanan ilk Türk devleti olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0c851f6-d764-4fbc-84e6-04072b00dff9', 'Uygur Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0c851f6-d764-4fbc-84e6-04072b00dff9', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0c851f6-d764-4fbc-84e6-04072b00dff9', 'Asya Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c0c851f6-d764-4fbc-84e6-04072b00dff9', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('706650d6-3559-4f51-9196-f253d3efb6b4', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?', 'Orhun Yazıtları''nın hangi devlete ait olduğunu ve önemini bilir.', 'Orhun Yazıtları (Göktürk Abideleri), Göktürk Devleti dönemine ait olup Türkçenin bilinen ilk yazılı metinleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('706650d6-3559-4f51-9196-f253d3efb6b4', 'Göktürk Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('706650d6-3559-4f51-9196-f253d3efb6b4', 'Uygur Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('706650d6-3559-4f51-9196-f253d3efb6b4', 'Avrupa Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('706650d6-3559-4f51-9196-f253d3efb6b4', 'Asya Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('37916c9b-c3d0-451a-9cf8-a41014a77dd9', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'zor'::difficulty_level, '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?', 'Kavimler Göçü''nün Türk tarihiyle bağlantısını ve Avrupa tarihine etkisini analiz eder.', 'Asya Hun Devleti''nin Çin baskısıyla zayıflaması sonucu Hun boylarının batıya yönelmesi, Kavimler Göçü''nü başlatan temel gelişmedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37916c9b-c3d0-451a-9cf8-a41014a77dd9', 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37916c9b-c3d0-451a-9cf8-a41014a77dd9', 'Göktürklerin Doğu ve Batı olarak ikiye ayrılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37916c9b-c3d0-451a-9cf8-a41014a77dd9', 'Uygurların Moğolistan''daki hakimiyetini kaybetmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37916c9b-c3d0-451a-9cf8-a41014a77dd9', 'Bumin Kağan''ın Göktürk Devleti''ni kurması', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4f284a58-aa53-4917-8ecb-435e907bec6f', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'kolay'::difficulty_level, 'Osmanlı Devleti''nin kuruluş tarihi olarak kabul edilen 1299 yılında beyliği kuran kişi kimdir?', 'Osmanlı Devleti''nin kuruluşunu ve kurucusunu bilir.', 'Osmanlı Devleti''nin kuruluşu, Osman Bey tarafından 1299 yılında gerçekleştirilmiş olarak kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f284a58-aa53-4917-8ecb-435e907bec6f', 'Osman Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f284a58-aa53-4917-8ecb-435e907bec6f', 'Orhan Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f284a58-aa53-4917-8ecb-435e907bec6f', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f284a58-aa53-4917-8ecb-435e907bec6f', 'II. Mehmed', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3c070a48-fe9e-47cc-8bd8-72058714655c', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'kolay'::difficulty_level, 'Bursa''nın fethedilerek başkent yapıldığı, ilk düzenli ordu (Yaya-Müsellem) ve ilk medresenin (İznik) kurulduğu dönem hangi padişaha aittir?', 'Orhan Bey dönemindeki kurumsallaşma adımlarını bilir.', 'Orhan Bey döneminde Bursa fethedilmiş, ilk düzenli ordu kurulmuş ve İznik''te ilk medrese açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3c070a48-fe9e-47cc-8bd8-72058714655c', 'Orhan Bey', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3c070a48-fe9e-47cc-8bd8-72058714655c', 'Osman Bey', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3c070a48-fe9e-47cc-8bd8-72058714655c', 'I. Murad', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3c070a48-fe9e-47cc-8bd8-72058714655c', 'Yıldırım Bayezid', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8994eae8-e204-4da7-aec3-f5843988caf9', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'orta'::difficulty_level, 'Yıldırım Bayezid''in Timur''a yenilerek esir düştüğü ve Anadolu Türk siyasi birliğinin bozulmasına yol açan savaş aşağıdakilerden hangisidir?', 'Ankara Savaşı''nın Osmanlı kuruluş dönemine etkisini kavrar.', '1402 Ankara Savaşı''nda Yıldırım Bayezid Timur''a yenilmiş ve esir düşmüş, bu durum Fetret Devri''ne zemin hazırlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8994eae8-e204-4da7-aec3-f5843988caf9', 'Ankara Savaşı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8994eae8-e204-4da7-aec3-f5843988caf9', 'Niğbolu Savaşı', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8994eae8-e204-4da7-aec3-f5843988caf9', 'Kosova Savaşı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8994eae8-e204-4da7-aec3-f5843988caf9', 'Varna Savaşı', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('952591c5-a3e3-49b7-8403-77e53242688c', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi I. Murad (Hüdavendigar) döneminde gerçekleşen gelişmelerden biridir?', 'I. Murad dönemi kurumsal ve askeri gelişmelerini diğer padişahlar dönemindeki gelişmelerden ayırt eder.', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması I. Murad dönemine aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('952591c5-a3e3-49b7-8403-77e53242688c', 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('952591c5-a3e3-49b7-8403-77e53242688c', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('952591c5-a3e3-49b7-8403-77e53242688c', 'Ankara Savaşı''nın kaybedilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('952591c5-a3e3-49b7-8403-77e53242688c', 'Bursa''nın fethedilmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('415d0749-abc0-411b-b9b1-5cecae3a77bc', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'zor'::difficulty_level, 'Fetret Devri''ni sona erdirerek Osmanlı siyasi birliğini yeniden sağlayan ve bu nedenle "ikinci kurucu" olarak da anılan padişah kimdir?', 'Fetret Devri''nin sona eriş sürecini ve bu süreçteki padişahın rolünü analiz eder.', 'Çelebi Mehmed (I. Mehmed), şehzadeler arası taht mücadelelerini sona erdirerek devletin siyasi birliğini yeniden sağlamış ve bu nedenle ikinci kurucu olarak anılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('415d0749-abc0-411b-b9b1-5cecae3a77bc', 'Çelebi Mehmed (I. Mehmed)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('415d0749-abc0-411b-b9b1-5cecae3a77bc', 'II. Murad', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('415d0749-abc0-411b-b9b1-5cecae3a77bc', 'Yıldırım Bayezid', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('415d0749-abc0-411b-b9b1-5cecae3a77bc', 'Orhan Bey', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4c60ef20-797f-455f-81cd-a5fa3e2baad5', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?', 'Millî Mücadele''nin başlangıç tarihini bilir.', 'Mustafa Kemal, 19 Mayıs 1919''da Samsun''a çıkarak Millî Mücadele''nin fiilen başlamasını sağlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4c60ef20-797f-455f-81cd-a5fa3e2baad5', '19 Mayıs 1919', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4c60ef20-797f-455f-81cd-a5fa3e2baad5', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4c60ef20-797f-455f-81cd-a5fa3e2baad5', '30 Ekim 1918', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4c60ef20-797f-455f-81cd-a5fa3e2baad5', '29 Ekim 1923', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7888e3ea-04c3-41bc-8add-2abb8b2f92c0', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?', 'TBMM''nin açılış tarihini ve önemini bilir.', 'TBMM, İstanbul''un işgali üzerine 23 Nisan 1920''de Ankara''da açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7888e3ea-04c3-41bc-8add-2abb8b2f92c0', '23 Nisan 1920', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7888e3ea-04c3-41bc-8add-2abb8b2f92c0', '19 Mayıs 1919', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7888e3ea-04c3-41bc-8add-2abb8b2f92c0', '4 Eylül 1919', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7888e3ea-04c3-41bc-8add-2abb8b2f92c0', '16 Mart 1920', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8bab3949-49c9-45cf-ae00-a6aeb2dab012', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?', 'Amasya Genelgesi''nin içeriğini ve önemini kavrar.', 'Bu ifade, 22 Haziran 1919''da yayımlanan Amasya Genelgesi''nde yer almaktadır ve genelge Millî Mücadele''nin ilk yazılı belgesi kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bab3949-49c9-45cf-ae00-a6aeb2dab012', 'Amasya Genelgesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bab3949-49c9-45cf-ae00-a6aeb2dab012', 'Erzurum Kongresi kararları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bab3949-49c9-45cf-ae00-a6aeb2dab012', 'Sivas Kongresi kararları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8bab3949-49c9-45cf-ae00-a6aeb2dab012', 'Misak-ı Millî', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c131bcd9-1c67-481e-ba8e-c582e65426f1', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?', 'Batı Cephesi''ndeki muharebelerin kronolojik sırasını ve önemini bilir.', 'Sakarya Meydan Muharebesi, Ağustos-Eylül 1921''de kazanılmış ve Yunan ilerleyişini durdurarak Türk ordusunun taarruz gücüne geçmesinde dönüm noktası olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c131bcd9-1c67-481e-ba8e-c582e65426f1', 'Sakarya Meydan Muharebesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c131bcd9-1c67-481e-ba8e-c582e65426f1', 'I. İnönü Muharebesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c131bcd9-1c67-481e-ba8e-c582e65426f1', 'Büyük Taarruz', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c131bcd9-1c67-481e-ba8e-c582e65426f1', 'II. İnönü Muharebesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6eb51f8d-ed4c-4c31-bcc1-fd3736584634', '091291bb-a136-48e2-94b1-8d12631be6ad', 'zor'::difficulty_level, 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?', 'Kurtuluş Savaşı cephelerini ve mücadele edilen devletleri doğru eşleştirir.', 'Antep, Maraş ve Urfa, Güney Cephesi''nde Fransızlara karşı verilen direnişin öne çıktığı yerlerdir; Sakarya, İnönü ve Dumlupınar ise Batı Cephesi''nde Yunanlılara karşı yaşanan muharebe yerleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6eb51f8d-ed4c-4c31-bcc1-fd3736584634', 'Antep, Maraş, Urfa', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6eb51f8d-ed4c-4c31-bcc1-fd3736584634', 'Sakarya, İnönü, Dumlupınar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6eb51f8d-ed4c-4c31-bcc1-fd3736584634', 'Gümrü, Kars, Sarıkamış', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6eb51f8d-ed4c-4c31-bcc1-fd3736584634', 'İzmir, Bursa, Eskişehir', false, 3);
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b9fc305b-6936-465a-b1a3-0bd0978adf5b', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'kolay'::difficulty_level, 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?', 'Cumhuriyetin ilan tarihini bilir.', 'Türkiye Cumhuriyeti, 29 Ekim 1923 tarihinde ilan edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9fc305b-6936-465a-b1a3-0bd0978adf5b', '29 Ekim 1923', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9fc305b-6936-465a-b1a3-0bd0978adf5b', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9fc305b-6936-465a-b1a3-0bd0978adf5b', '1 Kasım 1922', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9fc305b-6936-465a-b1a3-0bd0978adf5b', '3 Mart 1924', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('fa4bed04-4cc0-41ac-81d6-12e9f82c7107', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'kolay'::difficulty_level, 'Osmanlı hanedanının siyasi yetkisinin sona erdirildiği saltanatın kaldırılması hangi tarihte gerçekleşmiştir?', 'Saltanatın kaldırılış tarihini ve önemini bilir.', 'Saltanat, 1 Kasım 1922 tarihinde TBMM kararıyla kaldırılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa4bed04-4cc0-41ac-81d6-12e9f82c7107', '1 Kasım 1922', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa4bed04-4cc0-41ac-81d6-12e9f82c7107', '29 Ekim 1923', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa4bed04-4cc0-41ac-81d6-12e9f82c7107', '3 Mart 1924', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('fa4bed04-4cc0-41ac-81d6-12e9f82c7107', '17 Şubat 1926', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('530bd0a4-cd46-4b87-a965-0c50f06e1d69', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'orta'::difficulty_level, 'Halifeliğin kaldırılması ile eğitimde birliği sağlayan Tevhid-i Tedrisat Kanunu''nun kabulü, 1924 yılında hangi tarihte aynı gün gerçekleşmiştir?', 'Halifeliğin kaldırılması ve Tevhid-i Tedrisat Kanunu''nun tarihini ve ilişkisini bilir.', 'Halifelik ile Tevhid-i Tedrisat Kanunu, aynı gün olan 3 Mart 1924''te kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('530bd0a4-cd46-4b87-a965-0c50f06e1d69', '3 Mart', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('530bd0a4-cd46-4b87-a965-0c50f06e1d69', '1 Kasım', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('530bd0a4-cd46-4b87-a965-0c50f06e1d69', '25 Kasım', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('530bd0a4-cd46-4b87-a965-0c50f06e1d69', '17 Şubat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7403d698-674d-436f-8cb3-a478fb46249d', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'orta'::difficulty_level, 'Türk kadınına milletvekili seçme ve seçilme hakkının tanındığı yıl aşağıdakilerden hangisidir?', 'Kadınlara tanınan siyasi hakların tarihsel sürecini bilir.', 'Kadınlara milletvekili seçme ve seçilme hakkı 1934 yılında tanınmıştır; 1930 yılında ise yalnızca belediye seçimlerinde seçme hakkı verilmişti.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7403d698-674d-436f-8cb3-a478fb46249d', '1934', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7403d698-674d-436f-8cb3-a478fb46249d', '1930', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7403d698-674d-436f-8cb3-a478fb46249d', '1926', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7403d698-674d-436f-8cb3-a478fb46249d', '1928', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8eb09468-1ea6-4a9a-8b64-18402941527e', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'zor'::difficulty_level, 'Aşağıdaki inkılaplardan hangisi kronolojik olarak diğerlerinden daha sonra gerçekleşmiştir?', 'Cumhuriyet dönemi inkılaplarını kronolojik sıraya göre değerlendirir.', 'Soyadı Kanunu 1934 yılında kabul edilmiş olup, Medeni Kanun (1926), Harf İnkılabı (1928) ve Şapka Kanunu''ndan (1925) daha sonraki bir tarihte gerçekleşmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8eb09468-1ea6-4a9a-8b64-18402941527e', 'Soyadı Kanunu (1934)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8eb09468-1ea6-4a9a-8b64-18402941527e', 'Medeni Kanun''un kabulü (1926)', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8eb09468-1ea6-4a9a-8b64-18402941527e', 'Harf İnkılabı (1928)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8eb09468-1ea6-4a9a-8b64-18402941527e', 'Şapka Kanunu (1925)', false, 3);

commit;
