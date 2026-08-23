begin;
-- ===== cografya =====
insert into topic_contents (topic_id, summary, content_md, example_question) values ('73d24254-55ed-43ae-8627-1456e48059b4', 'Türkiye''nin matematik (mutlak) konumu enlem-boylam değerleriyle, özel (coğrafi) konumu ise komşuları, denizlerle ilişkisi ve kıtalar arasındaki yeriyle tanımlanır; bu iki konum türü ülkenin iklim, ulaşım ve jeopolitik özelliklerini şekillendirir.', '## Matematik (Mutlak) Konum
- Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer alır.
- Yaklaşık 36°-42° kuzey enlemleri ile 26°-45° doğu boylamları arasında bulunur.
- Orta Kuşak''ta (kuzey ılıman kuşak) yer aldığından yıl içinde dört mevsim belirgin biçimde yaşanır.
- Boylamlar arasındaki yaklaşık 19 derecelik açı farkı, doğu ile batı arasında yerel saatte belirgin bir farka (yaklaşık 76 dakika) yol açar; bu nedenle güneş doğuda batıya göre daha erken doğar.
- Uç noktalar: en kuzeyde Sinop (İnceburun), en güneyde Hatay, en doğuda Iğdır, en batıda Gökçeada (Çanakkale).

## Özel (Coğrafi) Konum
- Üç tarafı denizlerle (Karadeniz, Ege Denizi, Akdeniz) çevrilidir.
- İstanbul ve Çanakkale Boğazları aracılığıyla Asya ile Avrupa kıtaları arasında bir geçiş/köprü konumundadır.
- Enerji kaynakları bakımından zengin Orta Doğu ve Hazar-Orta Asya bölgeleri ile Avrupa arasında transit güzergâh üzerindedir.
- Farklı basınç sistemlerinin ve hava kütlelerinin etkisi altında kalması, iklim ve bitki örtüsü çeşitliliğine zemin hazırlar.
- Levha sınırlarına yakın konumu nedeniyle diri fay hatları üzerinde yer alır ve deprem riski taşır.

## Matematik Konumun Sonuçları
- Mevsimlerin belirgin biçimde yaşanması ve gün uzunluğunun mevsimlere göre değişmesi.
- Güneş ışınlarının geliş açısının enlemlere ve mevsimlere göre farklılaşması.
- Doğu-batı yönünde yerel saat farkının bulunması.

## Özel Konumun Sonuçları
- Ticaret ve ulaşım açısından önemli bir kavşak noktası olması.
- Kültürel çeşitlilik, tarihi zenginlik ve yüksek turizm potansiyeli.
- Jeopolitik ve stratejik önemin fazla olması.
- İklim ve doğal bitki örtüsü çeşitliliğine bağlı tarımsal ürün çeşitliliği.', 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi gösterilebilir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ffaa6552-d2fb-41b9-9210-503da2338ecf', '73d24254-55ed-43ae-8627-1456e48059b4', 'kolay'::difficulty_level, 'Türkiye''nin üç tarafının denizlerle çevrili olması, aşağıdaki konum türlerinden hangisine örnektir?', 'Matematik konum ile özel konum kavramlarını ayırt edebilme.', 'Denizlerle çevrili olma, komşu ülkeler ve ulaşım yolları gibi özellikler özel (coğrafi) konumun kapsamına girer; enlem-boylam gibi ölçülebilir değerler ise matematik konuma aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ffaa6552-d2fb-41b9-9210-503da2338ecf', 'Matematik konum', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ffaa6552-d2fb-41b9-9210-503da2338ecf', 'Özel konum', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ffaa6552-d2fb-41b9-9210-503da2338ecf', 'Astronomik konum', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ffaa6552-d2fb-41b9-9210-503da2338ecf', 'Mutlak konum', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('36d64af7-c7f6-46d8-9670-5deacdd8cce7', '73d24254-55ed-43ae-8627-1456e48059b4', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin matematik konumunun bir sonucu değildir?', 'Matematik konumun sonuçlarını özel konumun sonuçlarından ayırt edebilme.', 'Kıtalar arası transit ticaret, Türkiye''nin özel (coğrafi) konumunun bir sonucudur; enlem-boylama bağlı sonuçlar arasında yer almaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36d64af7-c7f6-46d8-9670-5deacdd8cce7', 'Dört mevsimin belirgin biçimde yaşanması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36d64af7-c7f6-46d8-9670-5deacdd8cce7', 'Doğu ile batı arasında yerel saat farkının olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36d64af7-c7f6-46d8-9670-5deacdd8cce7', 'Farklı kıtalar arasında transit ticaret yapılması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('36d64af7-c7f6-46d8-9670-5deacdd8cce7', 'Güneş ışınlarının geliş açısının mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d736e945-09d0-4151-b36f-2a50911c6c5f', '73d24254-55ed-43ae-8627-1456e48059b4', 'orta'::difficulty_level, 'Türkiye, boylamlar üzerinde doğuda Iğdır''dan batıda Gökçeada''ya kadar yaklaşık 19 derecelik bir açı genişliğine sahiptir. Bu durumun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Boylam farkının yerel saat ve gün doğumu-batımı üzerindeki etkisini kavrayabilme.', 'Boylam farkı arttıkça yerel saat farkı da artar; Dünya batıdan doğuya döndüğü için doğudaki yerler güneşi daha erken karşılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d736e945-09d0-4151-b36f-2a50911c6c5f', 'Ülkenin tamamında bitki örtüsü aynıdır', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d736e945-09d0-4151-b36f-2a50911c6c5f', 'Doğudaki iller, batıdaki illere göre güneşi daha erken karşılar', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d736e945-09d0-4151-b36f-2a50911c6c5f', 'Ülkenin dört tarafı denizlerle çevrilidir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d736e945-09d0-4151-b36f-2a50911c6c5f', 'Yıl boyunca gece-gündüz süreleri hep eşittir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('54d556ba-3824-4105-a9dc-81f5abc73f48', '73d24254-55ed-43ae-8627-1456e48059b4', 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası aşağıdaki illerden hangisinde yer alır?', 'Türkiye''nin uç noktalarını bilme.', 'Türkiye''nin en doğu noktası Iğdır ilinde yer alır; Sinop en kuzey, Hatay en güney, Çanakkale (Gökçeada) ise en batı noktasını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54d556ba-3824-4105-a9dc-81f5abc73f48', 'Hatay', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54d556ba-3824-4105-a9dc-81f5abc73f48', 'Sinop', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54d556ba-3824-4105-a9dc-81f5abc73f48', 'Iğdır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54d556ba-3824-4105-a9dc-81f5abc73f48', 'Çanakkale', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7b06b349-5f8a-4313-9f20-4f4c631caf5d', '73d24254-55ed-43ae-8627-1456e48059b4', 'zor'::difficulty_level, 'Türkiye''de saatler ülke genelinde tek bir resmi saat dilimine göre ayarlanmasına rağmen, Karadeniz kıyısında güneş henüz doğarken Doğu Anadolu''nun doğu kesiminde güneş çoktan doğmuş ve gökyüzünde belirgin biçimde yükselmiş olabilir. Bu durumun temel nedeni aşağıdakilerden hangisidir?', 'Boylam genişliğinin yerel güneş konumu üzerindeki etkisini analiz edebilme.', 'Bu fark, Türkiye''nin doğu-batı doğrultusunda geniş bir boylam aralığına yayılmış olmasından (matematik konum) kaynaklanır; deniz kıyısı, kıta geçişi gibi özel konum unsurları bu durumun nedeni değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b06b349-5f8a-4313-9f20-4f4c631caf5d', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b06b349-5f8a-4313-9f20-4f4c631caf5d', 'Türkiye''nin farklı boylamlar üzerinde geniş bir alana yayılmış olması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b06b349-5f8a-4313-9f20-4f4c631caf5d', 'Türkiye''nin Asya ile Avrupa arasında bir geçiş bölgesinde bulunması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7b06b349-5f8a-4313-9f20-4f4c631caf5d', 'Türkiye''nin dağlık ve engebeli bir yapıya sahip olması', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('f4bdef2c-d148-4d88-832f-731b8e3d122c', 'Türkiye''de yer şekilleri, denize yakınlık ve enlem gibi faktörlerin etkisiyle Akdeniz, Karadeniz, Marmara (geçiş) ve karasal iklim olmak üzere birbirinden belirgin biçimde farklı iklim tipleri görülür.', '## Türkiye''de Görülen İklim Tipleri

### Akdeniz İklimi
- Akdeniz ve Ege kıyı şeridinde görülür.
- Yazlar sıcak ve kurak, kışlar ılık ve yağışlı geçer.
- Yağışlar çoğunlukla kış aylarında düşer.

### Karadeniz İklimi
- Karadeniz kıyı şeridi boyunca görülür.
- Her mevsim yağışlıdır; yazlar serin, kıyı kesiminde kışlar diğer iç bölgelere göre daha ılımandır.
- Yıllık yağış miktarı ve yağış düzenliliği bakımından Türkiye''nin en yağışlı iklim tipidir.

### Marmara (Geçiş) İklimi
- Marmara Bölgesi''nin büyük bölümünde görülür.
- Karadeniz iklimi ile Akdeniz iklimi arasında geçiş özellikleri taşır; her mevsim yağış görülmekle birlikte yazın yağış azalır.

### Karasal İklim
- İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun büyük bölümünde ve iç kesimlerde görülür.
- Yazlar sıcak ve kurak, kışlar soğuk ve kar yağışlı geçer.
- Yıllık ve günlük sıcaklık farkı fazladır, yıllık yağış miktarı azdır.
- Doğu Anadolu''da yükseltinin fazla olması nedeniyle kışlar daha sert ve uzun geçer.

## İklim Dağılışını Etkileyen Faktörler
- **Enlem:** Güneye gidildikçe sıcaklık genel olarak artar.
- **Yükselti:** Yükseldikçe sıcaklık düşer; bu nedenle iç ve yüksek kesimlerde kışlar daha soğuk geçer.
- **Denize yakınlık/uzaklık:** Kıyı kesimlerde deniz etkisiyle sıcaklık farkları azalır; iç kesimlerde karasallık artar.
- **Dağların uzanış doğrultusu:** Kıyıya paralel uzanan Karadeniz ve Toros Dağları, deniz etkisinin iç kesimlere sokulmasını engeller; bu yüzden kıyıdan iç kesimlere geçişte iklim kısa mesafede belirgin biçimde değişebilir.
- **Bakı (yön):** Güneye bakan yamaçlar daha fazla güneş ışını alır.', 'Aşağıdaki iklim tiplerinden hangisi her mevsim yağışlı olması bakımından diğerlerinden ayrılır?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('83d5a27e-6ad0-431e-aa95-f7919edc2e7c', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'kolay'::difficulty_level, 'Yazların sıcak ve kurak, kışların ise ılık ve yağışlı geçtiği iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin temel özelliklerini tanıyabilme.', 'Yazın sıcak-kurak, kışın ılık-yağışlı geçmesi Akdeniz ikliminin temel özelliğidir; bu iklim Akdeniz ve Ege kıyılarında görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83d5a27e-6ad0-431e-aa95-f7919edc2e7c', 'Karadeniz iklimi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83d5a27e-6ad0-431e-aa95-f7919edc2e7c', 'Akdeniz iklimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83d5a27e-6ad0-431e-aa95-f7919edc2e7c', 'Karasal iklim', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('83d5a27e-6ad0-431e-aa95-f7919edc2e7c', 'Marmara iklimi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8a4193b5-a866-47eb-9d0f-ecc1593dfb9c', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'kolay'::difficulty_level, 'Türkiye''de her mevsim yağış alan ve yıllık yağış miktarı en fazla olan iklim tipi aşağıdaki bölgelerin hangisinde görülür?', 'İklim tiplerinin bölgesel dağılışını bilme.', 'Karadeniz iklimi her mevsim yağışlı olup Türkiye''nin en yağışlı iklim tipidir ve Karadeniz kıyı şeridinde görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8a4193b5-a866-47eb-9d0f-ecc1593dfb9c', 'İç Anadolu Bölgesi''nin iç kesimleri', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8a4193b5-a866-47eb-9d0f-ecc1593dfb9c', 'Karadeniz Bölgesi kıyıları', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8a4193b5-a866-47eb-9d0f-ecc1593dfb9c', 'Akdeniz Bölgesi kıyıları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8a4193b5-a866-47eb-9d0f-ecc1593dfb9c', 'Doğu Anadolu Bölgesi''nin yüksek kesimleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('1bf67546-caf8-4263-bba5-8391f46d86dd', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'orta'::difficulty_level, 'Türkiye''de kıyı kesimlerinden iç kesimlere gidildikçe iklimin kısa mesafede belirgin biçimde değişmesinin temel nedeni aşağıdakilerden hangisidir?', 'Yer şekillerinin iklim üzerindeki etkisini kavrayabilme.', 'Karadeniz ve Toros Dağları kıyıya paralel uzandığından denizden gelen nemli hava kütlelerinin iç kesimlere ulaşmasını engeller; bu nedenle kıyı ile iç kesim arasında kısa mesafede belirgin iklim farklılıkları oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1bf67546-caf8-4263-bba5-8391f46d86dd', 'Enlem farkının fazla olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1bf67546-caf8-4263-bba5-8391f46d86dd', 'Dağların kıyıya paralel uzanarak deniz etkisinin iç kesimlere sokulmasını engellemesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1bf67546-caf8-4263-bba5-8391f46d86dd', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('1bf67546-caf8-4263-bba5-8391f46d86dd', 'Yıllık güneşlenme süresinin her yerde aynı olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('77cf0443-7468-4d04-8a59-0dba8eab0cec', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'orta'::difficulty_level, 'Aşağıdaki illerden hangisinde yaz ile kış arasındaki sıcaklık farkının en fazla olması beklenir?', 'Karasallığın sıcaklık farkına etkisini örnekle ilişkilendirebilme.', 'Erzurum, denizden uzak ve yüksek bir iç kesimde yer aldığından karasal iklimin etkisiyle yaz-kış sıcaklık farkı diğer kıyı kentlerine göre daha fazladır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('77cf0443-7468-4d04-8a59-0dba8eab0cec', 'Antalya', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('77cf0443-7468-4d04-8a59-0dba8eab0cec', 'Rize', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('77cf0443-7468-4d04-8a59-0dba8eab0cec', 'Erzurum', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('77cf0443-7468-4d04-8a59-0dba8eab0cec', 'İzmir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('eaf0e5e2-e5dc-41c6-adab-04bb0c7e9658', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'zor'::difficulty_level, 'Enlemleri birbirine yakın olmasına karşın Rize ile Erzurum arasında kış sıcaklıkları bakımından büyük fark bulunmasının temel nedeni aşağıdakilerden hangisidir?', 'Denizellik-karasallık ve yükseltinin sıcaklık üzerindeki birlikte etkisini analiz edebilme.', 'Rize kıyıda yer aldığından denizin ılımanlaştırıcı etkisi altındadır; Erzurum ise hem yüksek hem de karasal bir iç kesimde bulunduğundan kışları çok daha soğuk geçer. İki merkezin enlemleri birbirine yakın olsa da belirleyici olan denize yakınlık ve yükselti farkıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eaf0e5e2-e5dc-41c6-adab-04bb0c7e9658', 'İki merkezin farklı boylamlarda yer alması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eaf0e5e2-e5dc-41c6-adab-04bb0c7e9658', 'Rize''nin denize kıyısının olması, Erzurum''un ise yüksek ve karasal bir konumda bulunması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eaf0e5e2-e5dc-41c6-adab-04bb0c7e9658', 'Rize''de yağışın yalnızca kış mevsiminde düşmesi, Erzurum''da hiç yağış düşmemesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('eaf0e5e2-e5dc-41c6-adab-04bb0c7e9658', 'Erzurum''un güneşten daha fazla ışın alması', false, 3);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('6b76a27b-b27e-4065-8325-d027f3f3377a', 'Türkiye''de nüfus dağılışı yer şekilleri, iklim ve ekonomik faaliyetler gibi doğal ve beşeri faktörlere bağlı olarak kıyı ve ova kesimlerinde yoğunlaşırken; yerleşme dokusu ise su kaynağı ve iklim koşullarına göre toplu veya dağınık biçimde şekillenir.', '## Nüfus Dağılışını Etkileyen Faktörler

### Doğal (Fiziki) Faktörler
- **Yer şekilleri:** Dağlık ve engebeli alanlarda nüfus seyrek, ova ve düzlüklerde nüfus yoğundur.
- **İklim:** Elverişli/ılıman iklim koşullarının görüldüğü kıyı bölgelerinde nüfus daha yoğundur; sert karasal iklimin görüldüğü yüksek platolarda nüfus seyrektir.
- **Su kaynakları:** Akarsu vadileri ve ovalar gibi su kaynağına yakın alanlarda yerleşim ve tarım kolaylaştığından nüfus yoğunlaşır.
- **Toprak verimliliği:** Çukurova, Gediz ve Büyük Menderes ovaları gibi verimli tarım alanlarında nüfus yoğundur.

### Beşeri ve Ekonomik Faktörler
- **Ekonomik faaliyetler:** Sanayi, ticaret ve hizmet sektörünün geliştiği kentlerde nüfus yoğunlaşır.
- **Ulaşım:** Ulaşım olanaklarının geliştiği bölgelerde yerleşim ve nüfus artar.
- **Tarihi ve kültürel etkenler:** Tarih boyunca yerleşime elverişli, güvenli bölgeler daha yoğun nüfuslanmıştır.
- **Kentleşme:** Sanayileşme ve iş imkânlarına bağlı göç, büyük kentlerdeki nüfus oranını artırmıştır.

## Türkiye''de Nüfusun Dağılışı
- Kıyı bölgeleri (özellikle Marmara, Ege ve Akdeniz kıyıları) ile büyük ovalar nüfus bakımından yoğundur.
- Doğu Anadolu''nun yüksek ve engebeli kesimleri, iklim koşullarının elverişsizliği ve tarım alanlarının kısıtlı olması nedeniyle seyrek nüfusludur.
- Nüfusun büyük bölümü kentlerde yaşamaktadır; kırsal nüfus oranı zamanla azalmıştır.

## Yerleşme Tipleri

### Kırsal Yerleşme
- Ekonomik faaliyeti büyük ölçüde tarım ve hayvancılığa dayanan, nüfus ve yapı yoğunluğu şehirlere göre az olan yerleşmelerdir (köy, mezra, kom, yayla gibi).

### Kentsel (Şehirsel) Yerleşme
- Nüfusu kalabalık, ekonomik faaliyetleri sanayi, ticaret ve hizmet sektörüne dayanan yerleşmelerdir.

### Yerleşme Dokusuna Göre Sınıflandırma
- **Toplu (kümeleşmiş) yerleşme:** Su kaynaklarının sınırlı, güvenlik ihtiyacının ön planda olduğu kurak/yarı kurak bölgelerde evler bir arada ve sık dokulu kurulur (örn. İç Anadolu, Güneydoğu Anadolu).
- **Dağınık yerleşme:** Su kaynaklarının bol olduğu nemli ve yağışlı bölgelerde her hane kendi arazisine ve su kaynağına yakın, birbirinden uzak konumlanır (örn. Karadeniz Bölgesi''nin kırsal kesimleri).', 'Türkiye''de kırsal yerleşmelerin dağınık ya da toplu doku göstermesinde en belirleyici etken aşağıdakilerden hangisidir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('65f58d1c-7997-4036-8a10-2b4b11623c34', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfusun seyrek olduğu alanlara örnektir?', 'Nüfusun seyrek olduğu alanları örnekle ilişkilendirebilme.', 'Doğu Anadolu''nun yüksek ve engebeli platoları, sert iklim koşulları ve sınırlı tarım alanları nedeniyle Türkiye''nin en seyrek nüfuslu bölgelerindendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65f58d1c-7997-4036-8a10-2b4b11623c34', 'Çukurova Ovası', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65f58d1c-7997-4036-8a10-2b4b11623c34', 'Marmara kıyıları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65f58d1c-7997-4036-8a10-2b4b11623c34', 'Doğu Anadolu''nun yüksek platoları', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('65f58d1c-7997-4036-8a10-2b4b11623c34', 'Ege kıyı ovaları', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7df89d6c-ac6f-46f3-b3ea-6fb98dce19c3', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi kırsal yerleşme tiplerinden biri değildir?', 'Kırsal ve kentsel yerleşme tiplerini ayırt edebilme.', 'Metropol, nüfusu ve ekonomik faaliyetleri bakımından büyük bir kentsel yerleşmeyi ifade eder; köy, mezra ve yayla ise kırsal yerleşme tipleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df89d6c-ac6f-46f3-b3ea-6fb98dce19c3', 'Köy', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df89d6c-ac6f-46f3-b3ea-6fb98dce19c3', 'Mezra', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df89d6c-ac6f-46f3-b3ea-6fb98dce19c3', 'Yayla', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7df89d6c-ac6f-46f3-b3ea-6fb98dce19c3', 'Metropol', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('dcdfa799-4132-42b1-aa2b-2f3cd35828be', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfus dağılışını etkileyen beşeri (insan kaynaklı) faktörlerden biridir?', 'Nüfus dağılışını etkileyen doğal ve beşeri faktörleri ayırt edebilme.', 'Sanayileşme ve ekonomik faaliyetler insan kaynaklı (beşeri) bir faktördür; yükselti, iklim ve yer şekilleri ise doğal (fiziki) faktörler arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcdfa799-4132-42b1-aa2b-2f3cd35828be', 'Yükselti', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcdfa799-4132-42b1-aa2b-2f3cd35828be', 'Sanayileşme ve ekonomik faaliyetler', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcdfa799-4132-42b1-aa2b-2f3cd35828be', 'İklim koşulları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('dcdfa799-4132-42b1-aa2b-2f3cd35828be', 'Yer şekilleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('86404123-4812-4b3d-be02-a63ca04cea6a', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'orta'::difficulty_level, 'Karadeniz Bölgesi''nin kırsal kesimlerinde evlerin genellikle birbirinden uzak ve dağınık şekilde kurulmasının temel nedeni aşağıdakilerden hangisidir?', 'Doğal koşulların yerleşme dokusuna etkisini analiz edebilme.', 'Karadeniz Bölgesi''nde yağış ve su kaynağı bolluğu ile engebeli arazi yapısı, ailelerin kendi tarım arazilerine ve su kaynaklarına yakın yerleşmesine yol açar; bu da dağınık yerleşme dokusunu oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('86404123-4812-4b3d-be02-a63ca04cea6a', 'Bölgede su kaynaklarının kısıtlı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('86404123-4812-4b3d-be02-a63ca04cea6a', 'Bölgenin engebeli olması nedeniyle her ailenin kendi arazisine ve su kaynağına yakın yerleşmesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('86404123-4812-4b3d-be02-a63ca04cea6a', 'Bölgede güvenlik kaygısının fazla olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('86404123-4812-4b3d-be02-a63ca04cea6a', 'Bölgede tarım alanlarının bulunmaması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3636c438-384b-412b-8ed7-a83283f69b7b', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'zor'::difficulty_level, 'Kurak bir iklim bölgesinde, su kaynaklarının sınırlı sayıda kaynak veya kuyu etrafında toplandığı bir yerleşim alanında evlerin sık ve bir arada (toplu) kurulmuş olması aşağıdakilerden hangisiyle açıklanabilir?', 'Toplu yerleşmenin oluşum nedenlerini kurak iklim koşullarıyla ilişkilendirerek analiz edebilme.', 'Kurak bölgelerde su kaynağı sınırlı olduğundan halk bu kaynaklara yakın ve bir arada yerleşir; ayrıca güvenlik ihtiyacı da toplu yerleşme dokusunu güçlendiren bir etkendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3636c438-384b-412b-8ed7-a83283f69b7b', 'Halkın tamamının aynı ekonomik faaliyetle uğraşması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3636c438-384b-412b-8ed7-a83283f69b7b', 'Sınırlı su kaynağının ortak kullanılması ve güvenlik ihtiyacının yerleşmeyi bir arada tutması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3636c438-384b-412b-8ed7-a83283f69b7b', 'Bölgenin deniz kıyısında yer alması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3636c438-384b-412b-8ed7-a83283f69b7b', 'Bölgede yağışın her mevsim düzenli olması', false, 3);

commit;
