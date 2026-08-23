begin;
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?', 'İlk Türk devletlerinden Asya Hun Devleti''nin özelliklerini kavrar.', 'Asya Hun Devleti, Mete Han döneminde onlu sistem ordu teşkilatıyla güçlenmiş ve bilinen ilk teşkilatlı Türk devleti kabul edilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Asya Hun Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Uygur Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2fe7a76d-5f65-42ab-aebe-7102647a9d38', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?', 'Göktürk Devleti''nin kuruluşu ve kurucusunu bilir.', 'Göktürk Devleti 552 yılında Bumin Kağan tarafından kurulmuş olup Türk adını taşıyan ilk devlettir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Bumin Kağan', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Mete Han', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Attila', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2d388ff6-f191-4651-944e-e985a18c5ffe', 'Bilge Kağan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yerleşik yaşam ve kültürel özelliklerini ayırt eder.', 'Uygurlar, Mani dinini kabul ederek yerleşik hayata geçmiş ve kağıt-matbaayı kullanan ilk Türk devleti olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Uygur Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Göktürk Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Asya Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bf126b6-6ee4-44a7-af26-3fff04bbc324', 'Avrupa Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?', 'Orhun Yazıtları''nın hangi devlete ait olduğunu ve önemini bilir.', 'Orhun Yazıtları (Göktürk Abideleri), Göktürk Devleti dönemine ait olup Türkçenin bilinen ilk yazılı metinleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Göktürk Devleti', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Uygur Devleti', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Avrupa Hun Devleti', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d096d9e8-d5e5-4d30-8cdc-2b8eda8eaef0', 'Asya Hun Devleti', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'zor'::difficulty_level, '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?', 'Kavimler Göçü''nün Türk tarihiyle bağlantısını ve Avrupa tarihine etkisini analiz eder.', 'Asya Hun Devleti''nin Çin baskısıyla zayıflaması sonucu Hun boylarının batıya yönelmesi, Kavimler Göçü''nü başlatan temel gelişmedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Göktürklerin Doğu ve Batı olarak ikiye ayrılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Uygurların Moğolistan''daki hakimiyetini kaybetmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11a5f49c-f566-4066-a3ba-01f03f7ccb46', 'Bumin Kağan''ın Göktürk Devleti''ni kurması', false, 3);
commit;