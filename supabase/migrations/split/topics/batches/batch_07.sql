begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('f046e8ff-0d47-47fa-add9-45a27a151b63', 'Hukuk kuralının tanımı, yaptırım türleri, hukukun kaynakları ile hak ve görev kavramlarının temel ilkelerini kapsar.', '## Hukuk Kuralı Nedir?
Hukuk kuralı, toplum halinde yaşayan bireylerin ilişkilerini düzenleyen, genel, soyut ve sürekli nitelikte olan; uyulmaması durumunda devlet gücü tarafından desteklenen bir yaptırıma bağlanan davranış kurallarıdır. Hukuk kuralını ahlak, din ve görgü gibi diğer toplumsal düzen kurallarından ayıran en belirgin özellik, devlet organları eliyle uygulanan **maddi yaptırıma** sahip olmasıdır.

## Yaptırım Türleri
Hukuk kurallarına aykırı davranışlar çeşitli yaptırımlarla karşılanır:
- **Ceza:** Suç niteliğindeki fiillere uygulanan hapis veya adli para cezası gibi yaptırımlardır.
- **Cebri icra (cebren yerine getirme):** Borcunu yerine getirmeyen kişinin edimini devlet gücüyle zorla yerine getirtmesidir.
- **Tazminat:** Bir kişinin hukuka aykırı fiiliyle başkasına verdiği zararı giderme yükümlülüğüdür.
- **İptal / Butlan (hükümsüzlük):** Kanunda aranan şekil veya esas şartlarına uyulmadan yapılan işlemlerin hukuken geçersiz sayılmasıdır.

## Hukukun Kaynakları
Hukukun kaynakları asli ve yardımcı kaynaklar olarak ikiye ayrılır:
- **Asli kaynaklar (yazılı):** Anayasa, kanun, cumhurbaşkanlığı kararnamesi, yönetmelik gibi yetkili organlarca yazılı şekilde konulan kurallardır.
- **Asli kaynaklar (yazısız):** Örf ve adet hukuku, toplumda uzun süredir uygulanan ve bağlayıcı olduğuna inanılan kurallardır.
- **Yardımcı kaynaklar:** Doktrin (bilimsel görüşler) ve yargısal içtihatlar, hukuk kurallarının yorumlanmasında hâkime ve hukukçulara yol gösterir; doğrudan bağlayıcı asli kaynak değildir.

## Hak ve Görev
**Hak**, hukuk düzeni tarafından bir kişiye tanınan ve korunan menfaat veya yetkidir. **Görev (borç/yükümlülük)** ise bir kişinin başka bir kişi veya devlete karşı yerine getirmek zorunda olduğu davranıştır. Hak ve görev kavramları birbirini tamamlar niteliktedir: bir kişinin hakkı, çoğunlukla başka bir kişi için buna karşılık gelen bir görev doğurur. Örneğin alacaklının alacak hakkı, borçlu için borcu ödeme görevini doğurur.', 'Hukuk kurallarını ahlak kurallarından ayıran temel özellik aşağıdakilerden hangisidir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('761891f6-d14e-4412-ae3f-c9496be69d3d', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'kolay'::difficulty_level, 'Hukuk kurallarını diğer toplumsal düzen kurallarından (ahlak, din, görgü) ayıran en temel özellik nedir?', 'Hukuk kuralını diğer toplumsal düzen kurallarından ayıran temel özelliği kavrar.', 'Hukuk kuralı, ahlak ve görgü kuralları gibi diğer toplumsal düzen kurallarından farklı olarak devlet gücüyle desteklenen bir yaptırıma sahiptir; bu nedenle uyulmaması halinde devlet organları tarafından zorla uygulanabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('761891f6-d14e-4412-ae3f-c9496be69d3d', 'Yazılı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('761891f6-d14e-4412-ae3f-c9496be69d3d', 'Herkes tarafından bilinmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('761891f6-d14e-4412-ae3f-c9496be69d3d', 'Devlet gücüyle desteklenen yaptırıma sahip olması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('761891f6-d14e-4412-ae3f-c9496be69d3d', 'Değişmez olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8ce2d31a-0483-430b-bf0b-a3efb9b83db0', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi hukuk kurallarının yaptırım türlerinden biri değildir?', 'Hukuk kurallarının yaptırım türlerini ayırt eder.', 'Vicdan azabı, ahlak kurallarının manevi yaptırımıdır; ceza, cebri icra ve tazminat ise hukuk kurallarının yaptırım türleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8ce2d31a-0483-430b-bf0b-a3efb9b83db0', 'Ceza', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8ce2d31a-0483-430b-bf0b-a3efb9b83db0', 'Vicdan azabı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8ce2d31a-0483-430b-bf0b-a3efb9b83db0', 'Cebri icra', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8ce2d31a-0483-430b-bf0b-a3efb9b83db0', 'Tazminat', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('67333877-de26-4b09-8875-4aa7c14da950', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'orta'::difficulty_level, 'Bir sözleşmenin kanunda öngörülen şekil şartına uyulmadan yapılması durumunda ortaya çıkan yaptırım türü aşağıdakilerden hangisidir?', 'Şekil şartına aykırılığın hukuki sonucunu açıklar.', 'Kanunda öngörülen şekil şartına uyulmadan yapılan hukuki işlemler hukuken geçersiz sayılır; bu yaptırım türüne butlan (kesin hükümsüzlük) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('67333877-de26-4b09-8875-4aa7c14da950', 'Cebri icra', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('67333877-de26-4b09-8875-4aa7c14da950', 'Tazminat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('67333877-de26-4b09-8875-4aa7c14da950', 'İptal edilebilirlik/Butlan (hükümsüzlük)', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('67333877-de26-4b09-8875-4aa7c14da950', 'Hapis cezası', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('35ea0cf9-ad7f-4d1a-8b54-436b66935a38', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'orta'::difficulty_level, 'Hukukun yazılı asli kaynakları arasında aşağıdakilerden hangisi yer almaz?', 'Hukukun yazılı ve yazısız asli kaynaklarını ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan asli bir kaynaktır; Anayasa, kanun ve yönetmelik ise yazılı asli kaynaklar arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35ea0cf9-ad7f-4d1a-8b54-436b66935a38', 'Anayasa', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35ea0cf9-ad7f-4d1a-8b54-436b66935a38', 'Örf ve adet hukuku', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35ea0cf9-ad7f-4d1a-8b54-436b66935a38', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35ea0cf9-ad7f-4d1a-8b54-436b66935a38', 'Yönetmelik', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4327deb7-f9d6-42f2-aaf8-fbb0995878b9', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'zor'::difficulty_level, '"Hak" ve "görev" kavramları arasındaki ilişki açısından aşağıdaki ifadelerden hangisi doğrudur?', 'Hak ve görev kavramları arasındaki karşılıklı ilişkiyi kavrar.', 'Hukuk düzeninde bir kişiye tanınan hak, genellikle karşı tarafta buna tekabül eden bir görev veya yükümlülük doğurur; örneğin alacak hakkı borçlu için ödeme görevi yaratır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4327deb7-f9d6-42f2-aaf8-fbb0995878b9', 'Hak, kişiye tanınan hukuki korumadan bağımsız bir yetkidir; görev ile ilişkisi yoktur', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4327deb7-f9d6-42f2-aaf8-fbb0995878b9', 'Görev, yalnızca kamu hukuku ilişkilerinde ortaya çıkan bir kavramdır', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4327deb7-f9d6-42f2-aaf8-fbb0995878b9', 'Bir kişinin sahip olduğu hak, genellikle başka bir kişi için buna karşılık gelen bir görev/yükümlülük doğurur', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4327deb7-f9d6-42f2-aaf8-fbb0995878b9', 'Hak ve görev kavramları sadece anayasa hukukunda kullanılır', false, 3);
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
insert into topic_contents (topic_id, summary, content_md, example_question) values ('37c6d817-c011-4012-9f18-b651bf8b022e', 'TBMM, Cumhurbaşkanlığı ve yargı organlarının genel yapısını, temel görevlerini ve kuvvetler ayrılığı ilkesini özetler.', '## Yasama Organı: TBMM
Türkiye Büyük Millet Meclisi (TBMM), yasama yetkisini kullanan tek organdır. Milletvekilleri genel oyla ve belirli aralıklarla yapılan seçimlerle halk tarafından seçilir. TBMM''nin başlıca görevleri şunlardır:
- Kanun yapmak, değiştirmek ve yürürlükten kaldırmak
- Bütçe ve kesin hesap kanun tekliflerini görüşüp kabul etmek
- Yürütme organını denetlemek (soru, meclis araştırması, genel görüşme gibi araçlarla)
- Milletlerarası antlaşmaların onaylanmasını uygun bulmak

## Yürütme Organı: Cumhurbaşkanlığı
Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetki ve görevi **Cumhurbaşkanı** tarafından kullanılır. Cumhurbaşkanı halk tarafından doğrudan seçilir; devletin başıdır ve aynı zamanda yürütmenin başıdır. Cumhurbaşkanı yardımcıları ve bakanlar, Cumhurbaşkanı tarafından atanır ve yürütme faaliyetlerinin yürütülmesinde ona yardımcı olur. Yürütmenin başlıca görevleri arasında kanunları uygulamak, cumhurbaşkanlığı kararnamesi çıkarmak, dış politikayı yürütmek ve ülkeyi idare etmek yer alır.

## Yargı Organı: Mahkemeler
Yargı yetkisi, Türk Milleti adına **bağımsız ve tarafsız mahkemeler** tarafından kullanılır. Hâkimler, görevlerinde bağımsızdır ve hâkimlik teminatına sahiptir; bu sayede yürütme ve yasamanın etkisinden korunurlar. Türkiye''de görev alanına göre çeşitli yüksek yargı organları bulunur:
- **Anayasa Mahkemesi:** Kanunların Anayasa''ya uygunluğunu denetler.
- **Yargıtay:** Adli yargının en üst denetim merciidir.
- **Danıştay:** İdari yargının en üst denetim merciidir.
- **Sayıştay:** Kamu kaynaklarının kullanımını denetler.

## Kuvvetler Ayrılığı İlkesi
Yasama, yürütme ve yargı yetkilerinin farklı organlarca kullanılması, gücün tek elde toplanmasını önlemeyi ve organlar arasında karşılıklı denetim sağlamayı amaçlayan **kuvvetler ayrılığı ilkesi**nin bir gereğidir. Bu ilke, hukuk devletinin ve demokratik yönetimin temel güvencelerinden biridir.', 'Türkiye''de yürütme yetkisinin kullanılmasına ilişkin aşağıdaki ifadelerden hangisi Cumhurbaşkanlığı Hükümet Sistemi''ne uygundur?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('430f028b-635d-47c4-8e5a-88fd58c2f474', '37c6d817-c011-4012-9f18-b651bf8b022e', 'kolay'::difficulty_level, 'Türkiye''de yasama yetkisi hangi organa aittir?', 'Yasama organını ve yetkisinin kime ait olduğunu bilir.', 'Yasama yetkisi Türk Milleti adına Türkiye Büyük Millet Meclisi tarafından kullanılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430f028b-635d-47c4-8e5a-88fd58c2f474', 'Cumhurbaşkanlığı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430f028b-635d-47c4-8e5a-88fd58c2f474', 'Yargıtay', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430f028b-635d-47c4-8e5a-88fd58c2f474', 'Türkiye Büyük Millet Meclisi', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430f028b-635d-47c4-8e5a-88fd58c2f474', 'Bakanlar Kurulu', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('52cecddd-9737-4e2b-a669-c866d6ad0a3b', '37c6d817-c011-4012-9f18-b651bf8b022e', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi yargı organının temel işlevidir?', 'Yargı organının temel işlevini açıklar.', 'Yargı organının temel işlevi, taraflar arasındaki hukuki uyuşmazlıkları bağımsız ve tarafsız mahkemeler eliyle çözüme kavuşturmaktır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('52cecddd-9737-4e2b-a669-c866d6ad0a3b', 'Kanun yapmak', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('52cecddd-9737-4e2b-a669-c866d6ad0a3b', 'Bütçeyi hazırlamak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('52cecddd-9737-4e2b-a669-c866d6ad0a3b', 'Uyuşmazlıkları bağımsız ve tarafsız biçimde çözüme kavuşturmak', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('52cecddd-9737-4e2b-a669-c866d6ad0a3b', 'Milletlerarası antlaşma imzalamak', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0daf17a3-1d1b-4c48-af34-8c3f483c0fee', '37c6d817-c011-4012-9f18-b651bf8b022e', 'orta'::difficulty_level, 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisi kime aittir?', 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisinin kullanımını bilir.', 'Cumhurbaşkanlığı Hükümet Sistemi''nde başbakanlık makamı kaldırılmış olup yürütme yetkisi Cumhurbaşkanı tarafından kullanılmaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0daf17a3-1d1b-4c48-af34-8c3f483c0fee', 'TBMM Başkanına', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0daf17a3-1d1b-4c48-af34-8c3f483c0fee', 'Başbakana', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0daf17a3-1d1b-4c48-af34-8c3f483c0fee', 'Anayasa Mahkemesi Başkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0daf17a3-1d1b-4c48-af34-8c3f483c0fee', 'Cumhurbaşkanına', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bd87361c-5934-48eb-965e-bb7276d75d55', '37c6d817-c011-4012-9f18-b651bf8b022e', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''deki yüksek yargı organlarından biridir?', 'Türkiye''deki yüksek yargı organlarını tanır.', 'Danıştay, idari yargının en üst denetim mercii olan yüksek bir yargı organıdır; diğer seçenekler yargı organı değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bd87361c-5934-48eb-965e-bb7276d75d55', 'TBMM Başkanlık Divanı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bd87361c-5934-48eb-965e-bb7276d75d55', 'Milli Güvenlik Kurulu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bd87361c-5934-48eb-965e-bb7276d75d55', 'Danıştay', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bd87361c-5934-48eb-965e-bb7276d75d55', 'Cumhurbaşkanlığı Kabinesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('50944ce1-74ab-487c-b604-46e9f41e5fbc', '37c6d817-c011-4012-9f18-b651bf8b022e', 'zor'::difficulty_level, 'Kuvvetler ayrılığı ilkesi bağlamında yasama, yürütme ve yargı organlarının birbirleriyle ilişkisi hakkında aşağıdakilerden hangisi doğrudur?', 'Kuvvetler ayrılığı ilkesinin amacını ve işleyişini kavrar.', 'Kuvvetler ayrılığı ilkesi, gücün tek bir organda toplanmasını önlemek amacıyla yasama, yürütme ve yargı arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür; organlar arasında tam bir kopukluk anlamına gelmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('50944ce1-74ab-487c-b604-46e9f41e5fbc', 'Kuvvetler ayrılığı, organların birbirinden tamamen kopuk ve hiçbir denetim ilişkisi bulunmadığı anlamına gelir', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('50944ce1-74ab-487c-b604-46e9f41e5fbc', 'Kuvvetler ayrılığı ilkesi yalnızca yasama ve yürütme arasındaki ilişkiyi düzenler, yargıyı kapsamaz', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('50944ce1-74ab-487c-b604-46e9f41e5fbc', 'Kuvvetler ayrılığı, güç yoğunlaşmasını önlemek amacıyla organlar arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('50944ce1-74ab-487c-b604-46e9f41e5fbc', 'Kuvvetler ayrılığı ilkesine göre yargı organı yasama organına bağlı çalışır', false, 3);
commit;
