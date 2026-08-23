begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'Ünlü ve ünsüz uyumu, ünsüz yumuşaması/sertleşmesi, ünlü düşmesi ve kaynaştırma ünsüzleri gibi ses olaylarını kapsayan bu konu, Türkçenin ses bilgisi kurallarını örneklerle açıklar.', '## Büyük Ünlü Uyumu (Kalınlık-İncelik Uyumu)
Türkçe kökenli bir kelimenin ilk hecesinde kalın ünlü (a, ı, o, u) varsa sonraki hecelerde de kalın ünlü bulunur; ilk hecede ince ünlü (e, i, ö, ü) varsa sonraki hecelerde de ince ünlü bulunur. Örneğin ''kalemlik'' kelimesindeki ''kalem'' kökü Arapça kökenli olduğu için bu kurala aykırıdır (a-e). ''Kalem, hangi, elma, anne'' gibi bazı yabancı kökenli ya da kalıplaşmış kelimeler bu kuralın istisnasıdır.

## Küçük Ünlü Uyumu (Düzlük-Yuvarlaklık Uyumu)
Düz ünlülerden (a, e, ı, i) sonra düz ünlü gelir. Yuvarlak ünlülerden (o, ö, u, ü) sonra ise ya düz-geniş (a, e) ya da dar-yuvarlak (u, ü) ünlü gelir. ''Doktor, otobüs, radyo'' gibi yabancı kökenli kelimeler bu kurala da aykırıdır çünkü yuvarlak bir ünlüden sonra yine geniş-yuvarlak (o, ö) bir ünlü gelmiştir.

## Ünsüz Benzeşmesi (Sertleşme)
Sert ünsüzle (ç, f, h, k, p, s, ş, t = ''fıstıkçı şahap'') biten bir kelimeye yumuşak ünsüzle başlayan bir ek gelirse, ekin başındaki ünsüz sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta, iş+ci → işçi.

## Ünsüz Yumuşaması
p, ç, t, k ile biten bir kelime ünlüyle başlayan bir ek aldığında bu ünsüzler yumuşayarak sırasıyla b, c, d, ğ/g''ye dönüşür: kitap→kitabı, ağaç→ağacı, at→adı, çocuk→çocuğu.

## Ünlü Düşmesi (Hece Düşmesi)
İkinci hecesinde dar ünlü (ı, i, u, ü) bulunan bazı iki heceli kelimeler ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: burun→burnu, ağız→ağzı, akıl→aklı, oğul→oğlu, şehir→şehri.

## Kaynaştırma Ünsüzleri
Ünlüyle biten bir kelime ünlüyle başlayan bir ek aldığında, iki ünlünün yan yana gelmesini önlemek için araya ''y, ş, s, n'' kaynaştırma ünsüzlerinden biri girer: kapı+ı→kapıyı, iki+er→ikişer, araba+ın→arabasının, kapı+ın→kapının.', 'Örnek: ''Ağacın gölgesinde otururken kitabını okudu.'' cümlesinde hangi kelimede ünsüz yumuşaması görülür?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e9fdb675-f729-47d1-bbe5-047d3406e6ec', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi büyük ünlü uyumuna (kalınlık-incelik uyumuna) aykırıdır?', 'Büyük ünlü uyumu kuralını kelimeler üzerinde uygular.', '''Kalem'' kökü Arapça kökenli olup ilk hecesinde kalın ünlü (a), ikinci hecesinde ince ünlü (e) bulunur; bu nedenle kelime büyük ünlü uyumuna aykırıdır. Diğer seçeneklerdeki kelimelerin tüm heceleri ya kalın ya da ince ünlülerden oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9fdb675-f729-47d1-bbe5-047d3406e6ec', 'kalemlik', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9fdb675-f729-47d1-bbe5-047d3406e6ec', 'yapraklar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9fdb675-f729-47d1-bbe5-047d3406e6ec', 'sevgili', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e9fdb675-f729-47d1-bbe5-047d3406e6ec', 'doğrular', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f744278c-84a8-4419-a9d8-6c69c733e255', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'kolay'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde ünsüz yumuşaması (p, ç, t, k seslerinin yumuşaması) görülür?', 'Ünsüz yumuşaması kuralını örneklerde tespit eder.', '''Ağaç'' kökündeki sert ünsüz ''ç'', ünlüyle başlayan iyelik eki ''-ı'' aldığında yumuşayarak ''c''ye dönüşmüş ve ''ağacı'' biçimini almıştır. Diğer seçeneklerde ünsüzle başlayan ekler geldiği için yumuşama gerçekleşmez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f744278c-84a8-4419-a9d8-6c69c733e255', 'kitaptan', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f744278c-84a8-4419-a9d8-6c69c733e255', 'ağacı', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f744278c-84a8-4419-a9d8-6c69c733e255', 'sokakta', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f744278c-84a8-4419-a9d8-6c69c733e255', 'çocuktan', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ab315d8b-0a48-4cdc-9f81-e85cc3a5ae69', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlü düşmesi (hece düşmesi) örneği vardır?', 'Ünlü düşmesi kuralının işlediği kelimeleri cümlede belirler.', '''Burun'' kelimesi ünlüyle başlayan iyelik eki ''-u'' aldığında ikinci hecesindeki dar ünlü ''u'' düşerek ''burnu'' biçimini almıştır. Diğer cümlelerdeki kelimelerde böyle bir ses düşmesi yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab315d8b-0a48-4cdc-9f81-e85cc3a5ae69', 'Burnu kanayan çocuğu hemen hastaneye götürdüler.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab315d8b-0a48-4cdc-9f81-e85cc3a5ae69', 'Bahçedeki güller sabaha karşı açmıştı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab315d8b-0a48-4cdc-9f81-e85cc3a5ae69', 'Kitapları düzenli bir şekilde masaya bıraktı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ab315d8b-0a48-4cdc-9f81-e85cc3a5ae69', 'Sınavdan beklediğinden yüksek bir not aldı.', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5ec0d4c4-9a8c-4ec2-85bc-c086b0a9cabc', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'orta'::difficulty_level, 'Aşağıdaki kelimelerin hangisinde kaynaştırma ünsüzü kullanılmıştır?', 'Kaynaştırma ünsüzlerinin kullanıldığı kelimeleri ayırt eder.', 'Ünlüyle biten ''kapı'' kelimesi ünlüyle başlayan ''-ı'' ekini aldığında iki ünlünün yan yana gelmesini önlemek için araya ''y'' kaynaştırma ünsüzü girmiş ve ''kapıyı'' biçimi oluşmuştur. Diğer seçeneklerdeki ekler ünsüzle başladığı için kaynaştırma ünsüzüne gerek yoktur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ec0d4c4-9a8c-4ec2-85bc-c086b0a9cabc', 'kapıyı', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ec0d4c4-9a8c-4ec2-85bc-c086b0a9cabc', 'evden', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ec0d4c4-9a8c-4ec2-85bc-c086b0a9cabc', 'kitaplar', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5ec0d4c4-9a8c-4ec2-85bc-c086b0a9cabc', 'sokakta', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d3de15ed-b24b-4b2d-90e1-5ba7856525af', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'zor'::difficulty_level, 'Aşağıdaki kelimelerden hangisi küçük ünlü uyumuna (düzlük-yuvarlaklık uyumuna) aykırıdır?', 'Küçük ünlü uyumu kuralını ileri düzeyde uygular.', 'Yuvarlak bir ünlüden (o) sonra ancak düz-geniş (a, e) ya da dar-yuvarlak (u, ü) bir ünlü gelebilir; ''doktor'' kelimesinde ise yuvarlak ''o'' ünlüsünden sonra yine geniş-yuvarlak ''o'' geldiği için kural bozulmuştur. Diğer kelimelerin tamamı küçük ünlü uyumuna uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3de15ed-b24b-4b2d-90e1-5ba7856525af', 'doktor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3de15ed-b24b-4b2d-90e1-5ba7856525af', 'kuzu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3de15ed-b24b-4b2d-90e1-5ba7856525af', 'çocuk', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d3de15ed-b24b-4b2d-90e1-5ba7856525af', 'balık', false, 3);
commit;