begin;
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3f709eb9-4090-4371-a74d-8c1a951eab3c', '73d24254-55ed-43ae-8627-1456e48059b4', 'kolay'::difficulty_level, 'Türkiye''nin üç tarafının denizlerle çevrili olması, aşağıdaki konum türlerinden hangisine örnektir?', 'Matematik konum ile özel konum kavramlarını ayırt edebilme.', 'Denizlerle çevrili olma, komşu ülkeler ve ulaşım yolları gibi özellikler özel (coğrafi) konumun kapsamına girer; enlem-boylam gibi ölçülebilir değerler ise matematik konuma aittir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f709eb9-4090-4371-a74d-8c1a951eab3c', 'Matematik konum', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f709eb9-4090-4371-a74d-8c1a951eab3c', 'Özel konum', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f709eb9-4090-4371-a74d-8c1a951eab3c', 'Astronomik konum', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3f709eb9-4090-4371-a74d-8c1a951eab3c', 'Mutlak konum', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('aa357273-48b2-425f-bb83-1c34e57fc14f', '73d24254-55ed-43ae-8627-1456e48059b4', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin matematik konumunun bir sonucu değildir?', 'Matematik konumun sonuçlarını özel konumun sonuçlarından ayırt edebilme.', 'Kıtalar arası transit ticaret, Türkiye''nin özel (coğrafi) konumunun bir sonucudur; enlem-boylama bağlı sonuçlar arasında yer almaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa357273-48b2-425f-bb83-1c34e57fc14f', 'Dört mevsimin belirgin biçimde yaşanması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa357273-48b2-425f-bb83-1c34e57fc14f', 'Doğu ile batı arasında yerel saat farkının olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa357273-48b2-425f-bb83-1c34e57fc14f', 'Farklı kıtalar arasında transit ticaret yapılması', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('aa357273-48b2-425f-bb83-1c34e57fc14f', 'Güneş ışınlarının geliş açısının mevsimlere göre değişmesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bf9ba061-9181-4739-8e65-2fb28a01c314', '73d24254-55ed-43ae-8627-1456e48059b4', 'orta'::difficulty_level, 'Türkiye, boylamlar üzerinde doğuda Iğdır''dan batıda Gökçeada''ya kadar yaklaşık 19 derecelik bir açı genişliğine sahiptir. Bu durumun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Boylam farkının yerel saat ve gün doğumu-batımı üzerindeki etkisini kavrayabilme.', 'Boylam farkı arttıkça yerel saat farkı da artar; Dünya batıdan doğuya döndüğü için doğudaki yerler güneşi daha erken karşılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf9ba061-9181-4739-8e65-2fb28a01c314', 'Ülkenin tamamında bitki örtüsü aynıdır', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf9ba061-9181-4739-8e65-2fb28a01c314', 'Doğudaki iller, batıdaki illere göre güneşi daha erken karşılar', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf9ba061-9181-4739-8e65-2fb28a01c314', 'Ülkenin dört tarafı denizlerle çevrilidir', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bf9ba061-9181-4739-8e65-2fb28a01c314', 'Yıl boyunca gece-gündüz süreleri hep eşittir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('89a4da03-1443-456e-992e-59f229d4b7d9', '73d24254-55ed-43ae-8627-1456e48059b4', 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası aşağıdaki illerden hangisinde yer alır?', 'Türkiye''nin uç noktalarını bilme.', 'Türkiye''nin en doğu noktası Iğdır ilinde yer alır; Sinop en kuzey, Hatay en güney, Çanakkale (Gökçeada) ise en batı noktasını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('89a4da03-1443-456e-992e-59f229d4b7d9', 'Hatay', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('89a4da03-1443-456e-992e-59f229d4b7d9', 'Sinop', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('89a4da03-1443-456e-992e-59f229d4b7d9', 'Iğdır', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('89a4da03-1443-456e-992e-59f229d4b7d9', 'Çanakkale', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ddd32768-052c-48ef-ad9c-0e4d319024e0', '73d24254-55ed-43ae-8627-1456e48059b4', 'zor'::difficulty_level, 'Türkiye''de saatler ülke genelinde tek bir resmi saat dilimine göre ayarlanmasına rağmen, Karadeniz kıyısında güneş henüz doğarken Doğu Anadolu''nun doğu kesiminde güneş çoktan doğmuş ve gökyüzünde belirgin biçimde yükselmiş olabilir. Bu durumun temel nedeni aşağıdakilerden hangisidir?', 'Boylam genişliğinin yerel güneş konumu üzerindeki etkisini analiz edebilme.', 'Bu fark, Türkiye''nin doğu-batı doğrultusunda geniş bir boylam aralığına yayılmış olmasından (matematik konum) kaynaklanır; deniz kıyısı, kıta geçişi gibi özel konum unsurları bu durumun nedeni değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ddd32768-052c-48ef-ad9c-0e4d319024e0', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ddd32768-052c-48ef-ad9c-0e4d319024e0', 'Türkiye''nin farklı boylamlar üzerinde geniş bir alana yayılmış olması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ddd32768-052c-48ef-ad9c-0e4d319024e0', 'Türkiye''nin Asya ile Avrupa arasında bir geçiş bölgesinde bulunması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ddd32768-052c-48ef-ad9c-0e4d319024e0', 'Türkiye''nin dağlık ve engebeli bir yapıya sahip olması', false, 3);
commit;