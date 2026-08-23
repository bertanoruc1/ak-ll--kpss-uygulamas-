begin;
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