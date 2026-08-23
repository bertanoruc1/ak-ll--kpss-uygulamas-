begin;
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b9157940-3f2d-41e2-bbf6-ec287c209fbc', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfusun seyrek olduğu alanlara örnektir?', 'Nüfusun seyrek olduğu alanları örnekle ilişkilendirebilme.', 'Doğu Anadolu''nun yüksek ve engebeli platoları, sert iklim koşulları ve sınırlı tarım alanları nedeniyle Türkiye''nin en seyrek nüfuslu bölgelerindendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9157940-3f2d-41e2-bbf6-ec287c209fbc', 'Çukurova Ovası', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9157940-3f2d-41e2-bbf6-ec287c209fbc', 'Marmara kıyıları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9157940-3f2d-41e2-bbf6-ec287c209fbc', 'Doğu Anadolu''nun yüksek platoları', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b9157940-3f2d-41e2-bbf6-ec287c209fbc', 'Ege kıyı ovaları', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('162af787-c154-4a0a-affc-f52dc66fdda7', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi kırsal yerleşme tiplerinden biri değildir?', 'Kırsal ve kentsel yerleşme tiplerini ayırt edebilme.', 'Metropol, nüfusu ve ekonomik faaliyetleri bakımından büyük bir kentsel yerleşmeyi ifade eder; köy, mezra ve yayla ise kırsal yerleşme tipleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('162af787-c154-4a0a-affc-f52dc66fdda7', 'Köy', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('162af787-c154-4a0a-affc-f52dc66fdda7', 'Mezra', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('162af787-c154-4a0a-affc-f52dc66fdda7', 'Yayla', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('162af787-c154-4a0a-affc-f52dc66fdda7', 'Metropol', true, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d80295ea-6916-436e-8df8-5ee9af21c520', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''de nüfus dağılışını etkileyen beşeri (insan kaynaklı) faktörlerden biridir?', 'Nüfus dağılışını etkileyen doğal ve beşeri faktörleri ayırt edebilme.', 'Sanayileşme ve ekonomik faaliyetler insan kaynaklı (beşeri) bir faktördür; yükselti, iklim ve yer şekilleri ise doğal (fiziki) faktörler arasında yer alır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d80295ea-6916-436e-8df8-5ee9af21c520', 'Yükselti', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d80295ea-6916-436e-8df8-5ee9af21c520', 'Sanayileşme ve ekonomik faaliyetler', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d80295ea-6916-436e-8df8-5ee9af21c520', 'İklim koşulları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d80295ea-6916-436e-8df8-5ee9af21c520', 'Yer şekilleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('57a8e27e-862c-4fe3-ad49-18410db63d42', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'orta'::difficulty_level, 'Karadeniz Bölgesi''nin kırsal kesimlerinde evlerin genellikle birbirinden uzak ve dağınık şekilde kurulmasının temel nedeni aşağıdakilerden hangisidir?', 'Doğal koşulların yerleşme dokusuna etkisini analiz edebilme.', 'Karadeniz Bölgesi''nde yağış ve su kaynağı bolluğu ile engebeli arazi yapısı, ailelerin kendi tarım arazilerine ve su kaynaklarına yakın yerleşmesine yol açar; bu da dağınık yerleşme dokusunu oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57a8e27e-862c-4fe3-ad49-18410db63d42', 'Bölgede su kaynaklarının kısıtlı olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57a8e27e-862c-4fe3-ad49-18410db63d42', 'Bölgenin engebeli olması nedeniyle her ailenin kendi arazisine ve su kaynağına yakın yerleşmesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57a8e27e-862c-4fe3-ad49-18410db63d42', 'Bölgede güvenlik kaygısının fazla olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('57a8e27e-862c-4fe3-ad49-18410db63d42', 'Bölgede tarım alanlarının bulunmaması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3ce81cbe-a1b2-4f88-b788-b960c23752cd', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'zor'::difficulty_level, 'Kurak bir iklim bölgesinde, su kaynaklarının sınırlı sayıda kaynak veya kuyu etrafında toplandığı bir yerleşim alanında evlerin sık ve bir arada (toplu) kurulmuş olması aşağıdakilerden hangisiyle açıklanabilir?', 'Toplu yerleşmenin oluşum nedenlerini kurak iklim koşullarıyla ilişkilendirerek analiz edebilme.', 'Kurak bölgelerde su kaynağı sınırlı olduğundan halk bu kaynaklara yakın ve bir arada yerleşir; ayrıca güvenlik ihtiyacı da toplu yerleşme dokusunu güçlendiren bir etkendir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3ce81cbe-a1b2-4f88-b788-b960c23752cd', 'Halkın tamamının aynı ekonomik faaliyetle uğraşması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3ce81cbe-a1b2-4f88-b788-b960c23752cd', 'Sınırlı su kaynağının ortak kullanılması ve güvenlik ihtiyacının yerleşmeyi bir arada tutması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3ce81cbe-a1b2-4f88-b788-b960c23752cd', 'Bölgenin deniz kıyısında yer alması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3ce81cbe-a1b2-4f88-b788-b960c23752cd', 'Bölgede yağışın her mevsim düzenli olması', false, 3);
commit;