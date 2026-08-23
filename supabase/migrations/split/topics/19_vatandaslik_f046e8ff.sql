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
commit;