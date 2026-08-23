-- Bu script'i kurulum-01/02/03/04'ten SONRA çalıştırın; mevcut 105 soruya ek olarak
-- var olan 21 konunun her birine 2'şer YENİ, özgün soru ekler (toplam 42 yeni soru).
-- Idempotent değildir: yalnızca BİR KEZ çalıştırın (tekrar çalıştırırsanız sorular
-- ikinci kez eklenir).

begin;

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('0cd8120f-5d35-48ac-a206-6ceb8c23536a', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'kolay'::difficulty_level, '"Gitti + i" birleşiminde olduğu gibi düz-dar bir ünlüyle biten fiil kök/gövdesine "-yor" eki geldiğinde hangi ses olayı görülür?', 'Ünlü daralmasını fark eder.', '"Bekle-" gibi geniş ünlüyle (e, a) biten fiillere "-yor" eki geldiğinde son hecedeki geniş ünlü daralarak "i, ı, u, ü"ye dönüşür: bekle-yor → bekliyor. Bu olaya ünlü daralması denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd8120f-5d35-48ac-a206-6ceb8c23536a', 'bekliyor', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd8120f-5d35-48ac-a206-6ceb8c23536a', 'geliyor', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd8120f-5d35-48ac-a206-6ceb8c23536a', 'biliyor', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('0cd8120f-5d35-48ac-a206-6ceb8c23536a', 'gidiyor', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4cc721f3-e056-422d-bb2b-685b233826e7', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'orta'::difficulty_level, '"Kitap+cı" birleşiminde görüldüğü gibi, sert ünsüzle biten bir kelimeye yumuşak ünsüzle başlayan bir ek geldiğinde ekin ünsüzünün sertleşmesine ne ad verilir?', 'Ünsüz benzeşmesi (sertleşme) kuralını tanır.', '"Fıstıkçı şahap" sözündeki sert ünsüzlerden (ç, f, h, k, p, s, ş, t) biriyle biten bir kelimeye "c, d, g" gibi yumuşak bir ünsüzle başlayan ek gelirse, ekin ünsüzü sertleşir: kitap+cı → kitapçı, ağaç+da → ağaçta. Bu ses olayına ünsüz benzeşmesi (sertleşmesi) denir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cc721f3-e056-422d-bb2b-685b233826e7', 'Ünsüz benzeşmesi (sertleşme)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cc721f3-e056-422d-bb2b-685b233826e7', 'Ünsüz yumuşaması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cc721f3-e056-422d-bb2b-685b233826e7', 'Ünlü düşmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4cc721f3-e056-422d-bb2b-685b233826e7', 'Kaynaştırma', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9ea9f7d0-0e92-4cf9-a400-d566e83b750b', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harflerin kullanımıyla ilgili bir yazım yanlışı vardır?', 'Özel isimlerde büyük harf kullanımını uygular.', 'Ay ve mevsim adları özel isim olmadığı için büyük harfle başlamaz; "Mayıs" değil "mayıs" yazılmalıdır. Diğer seçeneklerde büyük harf kullanımı kurallara uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea9f7d0-0e92-4cf9-a400-d566e83b750b', 'Okullar Mayıs ayında tatile girecek.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea9f7d0-0e92-4cf9-a400-d566e83b750b', 'Ahmet Bey toplantıya geç kaldı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea9f7d0-0e92-4cf9-a400-d566e83b750b', 'Türkiye Cumhuriyeti 1923''te kuruldu.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9ea9f7d0-0e92-4cf9-a400-d566e83b750b', 'Anadolu''nun ortasında küçük bir köy vardı.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b91b6239-a84a-4c65-8c8f-141d27e866b7', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'orta'::difficulty_level, '"de/da" bağlacının yazımıyla ilgili aşağıdaki cümlelerin hangisinde bir yazım yanlışı yapılmıştır?', 'Bağlaç "de/da" ile bulunma hâli ekini ayırt eder.', '"Bu da" cümlesinde "da" bir bağlaç olup ayrı yazılmalıdır: "O da geldi." "Odada" örneğinde ise "-da" bulunma hâli eki olduğu için bitişik yazılır. "Sende" örneğinde "-de" bulunma eki olduğundan bitişik doğru bir kullanımdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b91b6239-a84a-4c65-8c8f-141d27e866b7', 'Ali de bize katıldı ama o da geç kaldı.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b91b6239-a84a-4c65-8c8f-141d27e866b7', 'Kitap masadaydı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b91b6239-a84a-4c65-8c8f-141d27e866b7', 'Sende kalsın bu anahtar.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b91b6239-a84a-4c65-8c8f-141d27e866b7', 'O da bizimle gelecek.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('bfa0b194-68d8-4eba-a64e-7494510014eb', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmamıştır?', 'Kesme işaretinin özel isimlerde ve eklerde kullanımını uygular.', 'Kurum, kuruluş ve kısaltmalara gelen ekler kesme işaretiyle ayrılmaz: "TBMM''de" değil, kısaltmalar zaten büyük harfle yazıldığından ek kesmeyle ayrılır — asıl yanlış "Türkiye''nin" gibi doğru kullanımların yanında "okulun" gibi cins isimlere kesme eklenmesidir; "Okul''un bahçesi" yanlıştır çünkü "okul" özel isim değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bfa0b194-68d8-4eba-a64e-7494510014eb', 'Okul''un bahçesi çok güzeldi.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bfa0b194-68d8-4eba-a64e-7494510014eb', 'Ankara''ya yarın gideceğiz.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bfa0b194-68d8-4eba-a64e-7494510014eb', 'TBMM''de önemli bir görüşme yapıldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('bfa0b194-68d8-4eba-a64e-7494510014eb', 'Atatürk''ün ilkeleri hâlâ geçerlidir.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('b600e80d-6841-42b9-8bfb-0fe6b9a2dd67', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'orta'::difficulty_level, '"Kardeşim  gel buraya  dedi." cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri gelmelidir?', 'Doğrudan aktarılan cümlelerde noktalama işaretlerini doğru kullanır.', 'Doğrudan aktarılan (tırnak içine alınan) cümleden önce iki nokta, aktarılan cümlenin sonunda ise tırnak içinde uygun noktalama kullanılır: Kardeşim: "Gel buraya." dedi.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b600e80d-6841-42b9-8bfb-0fe6b9a2dd67', ': " ... ."', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b600e80d-6841-42b9-8bfb-0fe6b9a2dd67', ', " ... "', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b600e80d-6841-42b9-8bfb-0fe6b9a2dd67', '; " ... "', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('b600e80d-6841-42b9-8bfb-0fe6b9a2dd67', '... " ... "', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('96b554f4-5e05-4c4f-b253-05cfed5a9ae6', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'kolay'::difficulty_level, '"Yüreği dağ gibi" ifadesindeki "dağ" sözcüğü hangi anlamda kullanılmıştır?', 'Mecaz anlamı gerçek anlamdan ayırt eder.', '"Dağ" sözcüğü burada gerçek anlamından (yeryüzü şekli) uzaklaşarak "büyük, cesur" anlamında mecaz olarak kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('96b554f4-5e05-4c4f-b253-05cfed5a9ae6', 'Mecaz anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('96b554f4-5e05-4c4f-b253-05cfed5a9ae6', 'Gerçek anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('96b554f4-5e05-4c4f-b253-05cfed5a9ae6', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('96b554f4-5e05-4c4f-b253-05cfed5a9ae6', 'Yan anlam', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('06f7c050-1f45-418c-9123-1895bbce3a1c', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'orta'::difficulty_level, '"Bu kumaşın ''eli'' çok yumuşak." cümlesindeki altı çizili sözcük hangi anlam ilişkisiyle kullanılmıştır?', 'Yan anlamı ayırt eder.', '"El" sözcüğü asıl anlamıyla (vücut organı) değil, kumaşın dokusunu/tuşesini belirtmek için "yan anlam" olarak kullanılmıştır; sözcüğün gerçek anlamıyla bağlantısı hâlâ hissedilir, bu da onu mecazdan ayırır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06f7c050-1f45-418c-9123-1895bbce3a1c', 'Yan anlam', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06f7c050-1f45-418c-9123-1895bbce3a1c', 'Mecaz anlam', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06f7c050-1f45-418c-9123-1895bbce3a1c', 'Terim anlam', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('06f7c050-1f45-418c-9123-1895bbce3a1c', 'Gerçek anlam', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('df77428f-dbb5-4209-b668-00c409726693', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'kolay'::difficulty_level, '"Yağmur yağarsa pikniğe gitmeyeceğiz." cümlesi anlamca hangi tür bir cümledir?', 'Koşul (şart) anlamı taşıyan cümleleri tanır.', 'Cümlede "-arsa/-erse" koşul ekiyle kurulmuş bir şart cümlesi vardır; bir eylemin gerçekleşmesi başka bir duruma bağlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('df77428f-dbb5-4209-b668-00c409726693', 'Koşul (şart) cümlesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('df77428f-dbb5-4209-b668-00c409726693', 'Amaç cümlesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('df77428f-dbb5-4209-b668-00c409726693', 'Sebep-sonuç cümlesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('df77428f-dbb5-4209-b668-00c409726693', 'Karşılaştırma cümlesi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a87d7098-53d2-498b-b01b-9f22aa69889a', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'orta'::difficulty_level, '"Herkes onun başarılı olacağını biliyordu, o da bunu biliyordu ama yine de denemekten korkuyordu." cümlesinde hangi anlam ilişkisi vardır?', 'Karşıtlık (zıtlık) anlamı taşıyan cümleleri çözümler.', '"Ama" bağlacı ile cümlede beklenenin aksine bir durum (bilmesine rağmen korkma) anlatılmıştır; bu da karşıtlık/zıtlık ilişkisini gösterir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a87d7098-53d2-498b-b01b-9f22aa69889a', 'Karşıtlık ilişkisi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a87d7098-53d2-498b-b01b-9f22aa69889a', 'Neden-sonuç ilişkisi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a87d7098-53d2-498b-b01b-9f22aa69889a', 'Amaç-sonuç ilişkisi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a87d7098-53d2-498b-b01b-9f22aa69889a', 'Koşul ilişkisi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e987008f-6b5b-45b3-8c97-76f78580345c', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'orta'::difficulty_level, 'Bir paragrafın giriş cümlesi genellikle hangi özelliği taşır?', 'Paragrafın giriş cümlesinin işlevini bilir.', 'Giriş cümlesi, paragrafın konusunu ortaya koyar ve okuyucuyu paragrafın devamına hazırlar; genellikle kendinden önceki bir bağlama ihtiyaç duymadan anlaşılabilir, bağlaçla başlamaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e987008f-6b5b-45b3-8c97-76f78580345c', 'Paragrafın konusunu tanıtır ve tek başına anlaşılır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e987008f-6b5b-45b3-8c97-76f78580345c', 'Mutlaka bir örnekle başlar.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e987008f-6b5b-45b3-8c97-76f78580345c', 'Bağlaçla başlar ve önceki paragrafa bağlıdır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e987008f-6b5b-45b3-8c97-76f78580345c', 'Yalnızca yazarın kişisel görüşünü içerir.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3b521a53-65b3-4d69-899e-ddf852ae2d2a', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'zor'::difficulty_level, '"Bu görüşe katılmıyorum. Çünkü..." ifadesiyle başlayan bir paragraf parçası, paragrafın hangi bölümünde yer alamaz?', 'Paragrafın bölümlerini (giriş-gelişme-sonuç) ayırt eder.', '"Bu görüşe katılmıyorum" ifadesi önceki bir görüşe atıfta bulunduğu için bağlama ihtiyaç duyar; bu nedenle paragrafın kendi başına anlaşılması gereken giriş (ilk) cümlesi olamaz, gelişme ya da sonuç bölümünde yer alabilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b521a53-65b3-4d69-899e-ddf852ae2d2a', 'Giriş (ilk cümle)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b521a53-65b3-4d69-899e-ddf852ae2d2a', 'Gelişme bölümü', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b521a53-65b3-4d69-899e-ddf852ae2d2a', 'Sonuç bölümü', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b521a53-65b3-4d69-899e-ddf852ae2d2a', 'Paragrafın ortası', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('05e1154e-0b2b-4a65-9778-109c66fe41d5', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'kolay'::difficulty_level, '18 − (6 − 2) × 3 işleminin sonucu kaçtır?', 'İşlem önceliğini karmaşık ifadelerde uygular.', 'Önce parantez içi işlem yapılır: 6 − 2 = 4. Sonra çarpma yapılır: 4 × 3 = 12. Son olarak çıkarma yapılır: 18 − 12 = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05e1154e-0b2b-4a65-9778-109c66fe41d5', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05e1154e-0b2b-4a65-9778-109c66fe41d5', '12', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05e1154e-0b2b-4a65-9778-109c66fe41d5', '18', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05e1154e-0b2b-4a65-9778-109c66fe41d5', '4', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e189246a-3ee1-4e11-95c2-b20b08ff61a7', '9c8a78d2-c1a7-46f2-9f24-d94b5d9c6d2f', 'orta'::difficulty_level, 'Bir sayının 4 katının 7 fazlası, aynı sayının 2 katının 19 fazlasına eşittir. Bu sayı kaçtır?', 'Sözel ifadeyi denkleme çevirip çözer.', '4x + 7 = 2x + 19 → 4x − 2x = 19 − 7 → 2x = 12 → x = 6.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e189246a-3ee1-4e11-95c2-b20b08ff61a7', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e189246a-3ee1-4e11-95c2-b20b08ff61a7', '4', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e189246a-3ee1-4e11-95c2-b20b08ff61a7', '8', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e189246a-3ee1-4e11-95c2-b20b08ff61a7', '12', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ca8d089f-1b4c-4059-92dc-93661df1ede2', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'kolay'::difficulty_level, '648 sayısı aşağıdaki sayılardan hangisine tam bölünmez?', 'Bölünebilme kurallarını uygular.', '648 sayısının rakamları toplamı 6+4+8=18 olup 9''a bölünür, dolayısıyla 648, 9''a tam bölünür. Ancak 648, 5''e bölünmez çünkü son rakamı 0 veya 5 değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca8d089f-1b4c-4059-92dc-93661df1ede2', '5', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca8d089f-1b4c-4059-92dc-93661df1ede2', '2', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca8d089f-1b4c-4059-92dc-93661df1ede2', '3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ca8d089f-1b4c-4059-92dc-93661df1ede2', '9', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9a9abd7e-2ece-4d9b-904d-9c54129848fd', 'd795c6f3-3a19-4f95-9919-007a184ced02', 'orta'::difficulty_level, '48 ile 60 sayılarının OBEB''i (en büyük ortak böleni) kaçtır?', 'OBEB hesaplama becerisini uygular.', '48 = 2⁴×3, 60 = 2²×3×5. Ortak asal çarpanların en küçük üsleri alınır: 2²×3 = 12. OBEB = 12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a9abd7e-2ece-4d9b-904d-9c54129848fd', '12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a9abd7e-2ece-4d9b-904d-9c54129848fd', '6', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a9abd7e-2ece-4d9b-904d-9c54129848fd', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9a9abd7e-2ece-4d9b-904d-9c54129848fd', '4', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('430402dc-fae3-41a9-b0a5-8870a27bedf8', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'kolay'::difficulty_level, 'Üç basamaklı "7a5" sayısı 9''a tam bölünebildiğine göre a rakamı kaç olabilir?', 'Basamak değeri ile bölünebilme kurallarını birlikte kullanır.', '9''a bölünebilme için rakamlar toplamının 9''a bölünmesi gerekir: 7+a+5 = 12+a. 12+a değerinin 9''a bölünmesi için a=6 olmalıdır (12+6=18).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430402dc-fae3-41a9-b0a5-8870a27bedf8', '6', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430402dc-fae3-41a9-b0a5-8870a27bedf8', '3', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430402dc-fae3-41a9-b0a5-8870a27bedf8', '9', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('430402dc-fae3-41a9-b0a5-8870a27bedf8', '2', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('567d7645-5a23-4d1c-9b4c-2c5265b5a5e0', '52e4adee-4581-449e-bf2d-39847a1ff32a', 'zor'::difficulty_level, 'İki basamaklı bir sayının rakamları toplamı 11''dir. Rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 45 fazladır. Buna göre ilk sayı kaçtır?', 'Basamak değeri problemlerini denklem kurarak çözer.', 'Sayı 10a+b, rakamları toplamı a+b=11. Yer değiştirmiş hâli 10b+a olup (10b+a)-(10a+b)=45 → 9(b-a)=45 → b-a=5. a+b=11 ve b-a=5 denklemlerinden b=8, a=3 bulunur. İlk sayı 38''dir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('567d7645-5a23-4d1c-9b4c-2c5265b5a5e0', '38', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('567d7645-5a23-4d1c-9b4c-2c5265b5a5e0', '29', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('567d7645-5a23-4d1c-9b4c-2c5265b5a5e0', '47', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('567d7645-5a23-4d1c-9b4c-2c5265b5a5e0', '56', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('969138ad-1a53-4128-a1a2-38989167d399', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'kolay'::difficulty_level, '3/4 + 1/6 işleminin sonucu kaçtır?', 'Rasyonel sayılarla toplama işlemi yapar.', 'Paydalar eşitlenir (OKEK=12): 3/4=9/12, 1/6=2/12. Toplam: 9/12+2/12=11/12.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('969138ad-1a53-4128-a1a2-38989167d399', '11/12', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('969138ad-1a53-4128-a1a2-38989167d399', '4/10', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('969138ad-1a53-4128-a1a2-38989167d399', '5/6', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('969138ad-1a53-4128-a1a2-38989167d399', '7/12', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4eef90ea-25ff-4352-9196-bbfd09d138d3', '37efade7-3bb5-42a9-9e22-8fcd6c0006b7', 'orta'::difficulty_level, '(2/3) ÷ (4/9) işleminin sonucu kaçtır?', 'Rasyonel sayılarla bölme işlemi yapar.', 'Bölme işleminde ikinci kesirin tersiyle çarpılır: (2/3) × (9/4) = 18/12 = 3/2.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4eef90ea-25ff-4352-9196-bbfd09d138d3', '3/2', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4eef90ea-25ff-4352-9196-bbfd09d138d3', '8/27', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4eef90ea-25ff-4352-9196-bbfd09d138d3', '2/3', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4eef90ea-25ff-4352-9196-bbfd09d138d3', '9/8', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5d4263cf-7c03-40e1-a820-1aba7dcbcc3d', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'orta'::difficulty_level, 'Bir havuzu bir musluk tek başına 6 saatte, başka bir musluk tek başına 3 saatte doldurabiliyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?', 'İşçi-havuz problemlerini oran-orantı ile çözer.', 'Birinci musluk saatte havuzun 1/6''sını, ikinci musluk 1/3''ünü doldurur. Birlikte: 1/6+1/3=1/6+2/6=3/6=1/2. Havuzun yarısı 1 saatte dolduğuna göre tamamı 2 saatte dolar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d4263cf-7c03-40e1-a820-1aba7dcbcc3d', '2 saat', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d4263cf-7c03-40e1-a820-1aba7dcbcc3d', '3 saat', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d4263cf-7c03-40e1-a820-1aba7dcbcc3d', '4,5 saat', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5d4263cf-7c03-40e1-a820-1aba7dcbcc3d', '1,5 saat', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c87529ae-33b3-40dd-9e1f-f1acaea4970e', 'f609f88b-2d72-42bc-bdb7-549657da2fd0', 'zor'::difficulty_level, 'Ali''nin yaşı, kardeşinin yaşının 2 katından 3 fazladır. İki kardeşin yaşları toplamı 30 olduğuna göre Ali kaç yaşındadır?', 'Yaş problemlerini denklem kurarak çözer.', 'Kardeşin yaşı x, Ali''nin yaşı 2x+3 olsun. x + 2x + 3 = 30 → 3x = 27 → x = 9. Ali''nin yaşı = 2(9)+3 = 21.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c87529ae-33b3-40dd-9e1f-f1acaea4970e', '21', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c87529ae-33b3-40dd-9e1f-f1acaea4970e', '18', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c87529ae-33b3-40dd-9e1f-f1acaea4970e', '24', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c87529ae-33b3-40dd-9e1f-f1acaea4970e', '19', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('37abd111-49c0-4449-983c-4a48702f8435', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'kolay'::difficulty_level, 'İlk Türk devletlerinde "kurultay" adı verilen meclisin temel işlevi nedir?', 'İlk Türk devletlerindeki yönetim yapılarını bilir.', 'Kurultay, devlet işlerinin (savaş, barış, hukuk vb.) görüşülüp karara bağlandığı, hakan başkanlığında toplanan danışma meclisidir; Türklerde ilk demokratik yönetim uygulamalarından biri sayılır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37abd111-49c0-4449-983c-4a48702f8435', 'Devlet işlerinin görüşülüp karara bağlandığı meclis olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37abd111-49c0-4449-983c-4a48702f8435', 'Sadece dini törenlerin yapıldığı yer olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37abd111-49c0-4449-983c-4a48702f8435', 'Yalnızca ticaretin düzenlendiği kurum olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('37abd111-49c0-4449-983c-4a48702f8435', 'Ordunun eğitim aldığı okul olması', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a8ec7357-0c0b-4deb-9112-23c22d3cdd8d', 'c876132a-c63c-4a00-bc2b-f40f32d682d6', 'orta'::difficulty_level, 'Orhun Abideleri (Göktürk Kitabeleri) tarih açısından neden önemlidir?', 'Yazılı ilk Türkçe kaynakların önemini kavrar.', 'Orhun Abideleri, Türk adının geçtiği ve Türkçenin bilinen ilk yazılı metinlerini içeren, Göktürk Devleti dönemine ait tarihî kaynaklardır; bu yönüyle Türk tarihi ve dili için birinci elden bir belgedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8ec7357-0c0b-4deb-9112-23c22d3cdd8d', 'Türk adının geçtiği bilinen ilk yazılı Türkçe metinler olmaları', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8ec7357-0c0b-4deb-9112-23c22d3cdd8d', 'İslamiyet''in kabulünü anlatmaları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8ec7357-0c0b-4deb-9112-23c22d3cdd8d', 'Osmanlı dönemine ait olmaları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a8ec7357-0c0b-4deb-9112-23c22d3cdd8d', 'Sadece ticaret anlaşmalarını içermeleri', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5c475a49-37fb-4f26-86cd-2b0954b57ba8', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'kolay'::difficulty_level, 'Osmanlı Devleti''nde "İskân Politikası" hangi amaçla uygulanmıştır?', 'Osmanlı''nın kuruluş dönemi fetih ve yerleşim politikalarını bilir.', 'İskân politikası, fethedilen yerlere Anadolu''dan Türkmen aileler yerleştirilerek buraların Türkleştirilmesi ve devlet otoritesinin kalıcı hâle getirilmesi amacıyla uygulanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c475a49-37fb-4f26-86cd-2b0954b57ba8', 'Fethedilen bölgeleri Türkleştirmek ve otoriteyi kalıcı kılmak', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c475a49-37fb-4f26-86cd-2b0954b57ba8', 'Sadece vergi gelirlerini artırmak', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c475a49-37fb-4f26-86cd-2b0954b57ba8', 'Ordunun beslenmesini kolaylaştırmak', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c475a49-37fb-4f26-86cd-2b0954b57ba8', 'Yalnızca göçebe hayatı özendirmek', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f910b1a8-f235-4a2c-922e-235f1c5086db', '145d44b3-a8e7-430f-8778-71fb8929a97d', 'orta'::difficulty_level, 'I. Kosova Savaşı''nın (1389) sonuçlarından biri aşağıdakilerden hangisidir?', 'Osmanlı''nın Balkanlardaki fetihlerinin sonuçlarını bilir.', 'I. Kosova Savaşı sonucunda Sırp Krallığı Osmanlı''ya bağlı bir vasal (tabi) devlet hâline gelmiş, Osmanlı''nın Balkanlardaki hâkimiyeti pekişmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f910b1a8-f235-4a2c-922e-235f1c5086db', 'Sırbistan''ın Osmanlı''ya bağlı bir devlet hâline gelmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f910b1a8-f235-4a2c-922e-235f1c5086db', 'İstanbul''un fethedilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f910b1a8-f235-4a2c-922e-235f1c5086db', 'Anadolu Türk birliğinin sağlanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f910b1a8-f235-4a2c-922e-235f1c5086db', 'Osmanlı Devleti''nin yıkılması', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f20c49da-bc83-4dd8-8f2b-42c91dedd90e', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Kurtuluş Savaşı''nda "Kongreler Dönemi" hangi cepheyle ilgilidir?', 'Kurtuluş Savaşı sürecindeki siyasi örgütlenme aşamalarını bilir.', 'Kongreler Dönemi (Erzurum ve Sivas Kongreleri gibi) askerî değil siyasi/örgütlenme sürecidir; millî iradenin ortaya konması ve Millî Mücadele''nin teşkilatlandırılması amaçlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f20c49da-bc83-4dd8-8f2b-42c91dedd90e', 'Siyasi cephe (örgütlenme süreci)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f20c49da-bc83-4dd8-8f2b-42c91dedd90e', 'Doğu Cephesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f20c49da-bc83-4dd8-8f2b-42c91dedd90e', 'Güney Cephesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f20c49da-bc83-4dd8-8f2b-42c91dedd90e', 'Batı Cephesi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('3b0f2baa-6979-4aa6-a9af-cd22cff98970', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, 'Sakarya Meydan Muharebesi''nin en önemli sonucu aşağıdakilerden hangisidir?', 'Kurtuluş Savaşı''ndaki dönüm noktası muharebeleri ve sonuçlarını bilir.', 'Sakarya Meydan Muharebesi''nin kazanılmasıyla Türk ordusu taarruz gücüne sahip olduğunu göstermiş, Mustafa Kemal''e TBMM tarafından "Gazilik" unvanı ve "Mareşallik" rütbesi verilmiştir; savaşın gidişatı Türk lehine dönmüştür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b0f2baa-6979-4aa6-a9af-cd22cff98970', 'Savaşın gidişatının Türk lehine dönmesi ve Mustafa Kemal''e Mareşallik unvanının verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b0f2baa-6979-4aa6-a9af-cd22cff98970', 'İstanbul''un işgalden kurtarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b0f2baa-6979-4aa6-a9af-cd22cff98970', 'Lozan Antlaşması''nın imzalanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('3b0f2baa-6979-4aa6-a9af-cd22cff98970', 'Saltanatın kaldırılması', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('cc83af50-1334-4fa7-ba5f-b089bdfafcda', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi Atatürk''ün "halkçılık" ilkesiyle doğrudan ilişkilidir?', 'Atatürk ilkelerini örneklerle ilişkilendirir.', 'Halkçılık ilkesi, kanun önünde herkesin eşit olmasını ve egemenliğin kayıtsız şartsız millete ait olmasını öngörür; bu ilkeyle doğrudan ilişkili uygulama sınıf/zümre ayrıcalıklarının kaldırılmasıdır (soyadı kanunu, saltanatın kaldırılması gibi eşitlikçi düzenlemeler).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc83af50-1334-4fa7-ba5f-b089bdfafcda', 'Saltanatın kaldırılarak egemenliğin millete verilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc83af50-1334-4fa7-ba5f-b089bdfafcda', 'Kabotaj Kanunu''nun çıkarılması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc83af50-1334-4fa7-ba5f-b089bdfafcda', 'Tevhid-i Tedrisat Kanunu''nun çıkarılması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('cc83af50-1334-4fa7-ba5f-b089bdfafcda', 'Yeni Türk harflerinin kabulü', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5eb19acc-a186-47ad-8f6b-6288d4688f9b', '3c087fbc-2d70-4b75-880e-8e2f9e4475fb', 'orta'::difficulty_level, '1926''da kabul edilen Türk Medeni Kanunu ile aşağıdakilerden hangisi sağlanmıştır?', 'Hukuk alanındaki inkılapların sonuçlarını bilir.', 'Türk Medeni Kanunu ile tek eşlilik esası getirilmiş, kadın-erkek eşitliği hukuki olarak güçlendirilmiş (miras, boşanma, şahitlik gibi haklarda) ve laik hukuk düzenine geçiş tamamlanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb19acc-a186-47ad-8f6b-6288d4688f9b', 'Kadın-erkek eşitliğinin hukuki güvenceye kavuşturulması ve tek eşliliğin getirilmesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb19acc-a186-47ad-8f6b-6288d4688f9b', 'Çok eşliliğin yasal hâle getirilmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb19acc-a186-47ad-8f6b-6288d4688f9b', 'Şeriat mahkemelerinin güçlendirilmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5eb19acc-a186-47ad-8f6b-6288d4688f9b', 'Yalnızca ticaret hukukunun düzenlenmesi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('59245948-9f04-4590-85c1-90c3cc993b5b', '73d24254-55ed-43ae-8627-1456e48059b4', 'kolay'::difficulty_level, 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?', 'Matematik konumun sonuçlarını yorumlar.', 'Türkiye, Kuzey Yarım Küre ve Doğu Yarım Küre''de yer aldığından yerel saat farkı doğu-batı yönünde değişir; matematik konum, saat farkları, mevsimlerin yaşanışı ve gün uzunluğu değişimi gibi sonuçlar doğurur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('59245948-9f04-4590-85c1-90c3cc993b5b', 'Doğuda güneş daha erken doğar, batıda daha geç doğar.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('59245948-9f04-4590-85c1-90c3cc993b5b', 'Dört mevsim tam olarak aynı sürede yaşanır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('59245948-9f04-4590-85c1-90c3cc993b5b', 'İklim çeşitliliği yalnızca özel konumla açıklanır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('59245948-9f04-4590-85c1-90c3cc993b5b', 'Komşu ülke sayısı matematik konumun sonucudur.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c00b92e9-fc0e-412d-a937-abecd7b6ce5c', '73d24254-55ed-43ae-8627-1456e48059b4', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi Türkiye''nin özel (coğrafi) konumunun sonuçlarından biridir?', 'Özel konumun matematik konumdan farkını ve sonuçlarını ayırt eder.', 'Özel konum; komşularla ilişkiler, ulaşım, ticaret yolları üzerinde bulunma, jeopolitik önem gibi beşerî-ekonomik sonuçları kapsar. Üç tarafının denizlerle çevrili olması ve önemli boğazlara sahip olması, Türkiye''yi transit ticaret açısından önemli kılar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c00b92e9-fc0e-412d-a937-abecd7b6ce5c', 'Önemli boğazlara sahip olması nedeniyle transit ticarette avantajlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c00b92e9-fc0e-412d-a937-abecd7b6ce5c', 'Yerel saat farkının bulunması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c00b92e9-fc0e-412d-a937-abecd7b6ce5c', 'Güneş ışınlarının açısının mevsime göre değişmesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c00b92e9-fc0e-412d-a937-abecd7b6ce5c', 'Gece-gündüz sürelerinin mevsimlere göre değişmesi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('47648c5e-7d9f-4210-bf14-c672047160b7', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'kolay'::difficulty_level, 'Karadeniz Bölgesi''nde görülen iklim tipinin en belirgin özelliği nedir?', 'Türkiye''deki iklim tiplerinin özelliklerini bilir.', 'Karadeniz iklimi, her mevsim yağışlı olması ve yıllık yağış miktarının fazla olmasıyla karakterizedir; yazlar diğer bölgelere göre serin, kışlar ise ılıman geçer.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47648c5e-7d9f-4210-bf14-c672047160b7', 'Her mevsim yağışlı olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47648c5e-7d9f-4210-bf14-c672047160b7', 'Yazların çok kurak geçmesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47648c5e-7d9f-4210-bf14-c672047160b7', 'Kışların en sert şekilde yaşanması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('47648c5e-7d9f-4210-bf14-c672047160b7', 'Yıl boyunca yağış görülmemesi', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ea11a340-28bb-4650-ac62-ad5c35e4b17a', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde karasal iklimin görülmesinin temel nedeni aşağıdakilerden hangisidir?', 'İklim tiplerinin oluşumunda etkili coğrafi faktörleri açıklar.', 'İç Anadolu, kıyıdan uzak ve dağlarla çevrili bir konumda olduğundan nemli deniz havasından yeterince yararlanamaz; bu nedenle yazları sıcak ve kurak, kışları soğuk ve kar yağışlı karasal iklim görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ea11a340-28bb-4650-ac62-ad5c35e4b17a', 'Denizden uzak ve dağlarla çevrili bir konumda bulunması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ea11a340-28bb-4650-ac62-ad5c35e4b17a', 'Deniz seviyesine çok yakın olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ea11a340-28bb-4650-ac62-ad5c35e4b17a', 'Yıl boyunca nemli hava kütlelerinin etkisinde kalması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ea11a340-28bb-4650-ac62-ad5c35e4b17a', 'Ekvatora çok yakın bir enlemde bulunması', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('6309f211-e9a6-41a3-af0c-28fe947368bd', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'kolay'::difficulty_level, 'Türkiye''de nüfusun kıyı bölgelerde iç kesimlere göre daha yoğun olmasının temel nedeni aşağıdakilerden hangisidir?', 'Nüfus dağılışını etkileyen doğal ve beşerî faktörleri açıklar.', 'Kıyı bölgelerde iklim koşullarının daha elverişli olması, tarım, sanayi ve ticaret imkânlarının fazlalığı ile ulaşım kolaylığı nüfusun bu bölgelerde yoğunlaşmasına neden olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6309f211-e9a6-41a3-af0c-28fe947368bd', 'İklim ve ekonomik imkânların daha elverişli olması', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6309f211-e9a6-41a3-af0c-28fe947368bd', 'Yükseltinin fazla olması', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6309f211-e9a6-41a3-af0c-28fe947368bd', 'Tarım alanlarının kıyıda hiç bulunmaması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('6309f211-e9a6-41a3-af0c-28fe947368bd', 'Deprem riskinin kıyıda daha az olması', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('35293839-b7a7-4501-b1c5-1c23ae4a48fb', '6b76a27b-b27e-4065-8325-d027f3f3377a', 'orta'::difficulty_level, 'Bir bölgede engebeli arazi yapısı, nüfus yoğunluğunu genellikle nasıl etkiler?', 'Yer şekillerinin nüfus dağılışına etkisini yorumlar.', 'Engebeli/dağlık araziler tarım, sanayi ve ulaşım açısından elverişsiz olduğundan bu tür bölgelerde yerleşme ve nüfus yoğunluğu düşük olma eğilimindedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35293839-b7a7-4501-b1c5-1c23ae4a48fb', 'Nüfus yoğunluğunu azaltır.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35293839-b7a7-4501-b1c5-1c23ae4a48fb', 'Nüfus yoğunluğunu artırır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35293839-b7a7-4501-b1c5-1c23ae4a48fb', 'Nüfus dağılışını hiç etkilemez.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('35293839-b7a7-4501-b1c5-1c23ae4a48fb', 'Yalnızca kentleşmeyi hızlandırır.', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('88ed3dd8-984e-4e57-aafc-d8dcfbe73aa5', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'kolay'::difficulty_level, 'Yazılı olmayan, toplumda uzun süre uygulanarak yerleşmiş kurallara ne ad verilir?', 'Hukukun kaynaklarını (yazılı-yazısız) ayırt eder.', 'Örf ve adet hukuku, yazılı olmayan ancak toplum tarafından benimsenip uzun süre uygulanan kurallardan oluşur ve hukukun yazısız kaynaklarından biridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88ed3dd8-984e-4e57-aafc-d8dcfbe73aa5', 'Örf ve adet hukuku', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88ed3dd8-984e-4e57-aafc-d8dcfbe73aa5', 'Anayasa', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88ed3dd8-984e-4e57-aafc-d8dcfbe73aa5', 'Kanun', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('88ed3dd8-984e-4e57-aafc-d8dcfbe73aa5', 'Tüzük', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9bdb4cd2-91bb-43c8-8ea8-c2e33da87da6', 'f046e8ff-0d47-47fa-add9-45a27a151b63', 'orta'::difficulty_level, 'Bir hukuk kuralına uyulmadığında devlet gücüyle uygulanan yaptırıma ne ad verilir?', 'Hukuk kurallarının yaptırım unsurunu tanır.', 'Yaptırım (müeyyide), bir hukuk kuralına uyulmaması durumunda devletin zor kullanma gücüyle uyguladığı sonuçtur (ceza, tazminat vb.) ve hukuk kurallarını ahlaki/dini kurallardan ayıran temel özelliktir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bdb4cd2-91bb-43c8-8ea8-c2e33da87da6', 'Yaptırım (müeyyide)', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bdb4cd2-91bb-43c8-8ea8-c2e33da87da6', 'Örf', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bdb4cd2-91bb-43c8-8ea8-c2e33da87da6', 'Teamül', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9bdb4cd2-91bb-43c8-8ea8-c2e33da87da6', 'Doktrin', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('11b22b34-faeb-4e27-9bb1-5fbdd5f6e7e0', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'kolay'::difficulty_level, '1982 Anayasası''na göre egemenlik kayıtsız şartsız kime aittir?', 'Anayasa''nın temel ilkelerinden egemenlik kavramını bilir.', '1982 Anayasası''nın 6. maddesine göre egemenlik, kayıtsız şartsız Türk Milletine aittir; millet bu yetkisini yetkili organlar eliyle kullanır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11b22b34-faeb-4e27-9bb1-5fbdd5f6e7e0', 'Türk Milletine', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11b22b34-faeb-4e27-9bb1-5fbdd5f6e7e0', 'TBMM''ye', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11b22b34-faeb-4e27-9bb1-5fbdd5f6e7e0', 'Cumhurbaşkanına', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('11b22b34-faeb-4e27-9bb1-5fbdd5f6e7e0', 'Anayasa Mahkemesine', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('34f91c2d-0714-4767-ada1-38a6e955e8f3', '86ae4cc1-2323-4a43-8448-b1fa4daf514e', 'orta'::difficulty_level, 'Anayasa değişikliği teklifi TBMM''de en az kaç üyenin yazılı teklifiyle yapılabilir?', 'Anayasa değişikliği usulünü bilir.', 'Anayasanın değiştirilmesi, TBMM üye tam sayısının en az üçte biri tarafından yazılı olarak teklif edilebilir (600 üyeli Meclis''te bu sayı 200''dür).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('34f91c2d-0714-4767-ada1-38a6e955e8f3', 'Üye tam sayısının en az üçte biri', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('34f91c2d-0714-4767-ada1-38a6e955e8f3', 'Üye tam sayısının salt çoğunluğu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('34f91c2d-0714-4767-ada1-38a6e955e8f3', 'Üye tam sayısının tamamı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('34f91c2d-0714-4767-ada1-38a6e955e8f3', 'Sadece hükümet üyeleri', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('2df32997-2dfc-43f2-8dc8-2dbc1705267a', '37c6d817-c011-4012-9f18-b651bf8b022e', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) devletin hangi temel organını oluşturur?', 'Kuvvetler ayrılığı ilkesindeki organları ayırt eder.', 'TBMM, kanun yapma, değiştirme ve kaldırma yetkisine sahip olduğu için yasama organını oluşturur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2df32997-2dfc-43f2-8dc8-2dbc1705267a', 'Yasama', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2df32997-2dfc-43f2-8dc8-2dbc1705267a', 'Yürütme', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2df32997-2dfc-43f2-8dc8-2dbc1705267a', 'Yargı', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('2df32997-2dfc-43f2-8dc8-2dbc1705267a', 'Denetleme', false, 3);

insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4a26dfd4-320c-405b-96f2-ab44c2f59ce5', '37c6d817-c011-4012-9f18-b651bf8b022e', 'orta'::difficulty_level, 'Türkiye''de yargı bağımsızlığı ilkesi temel olarak neyi ifade eder?', 'Yargı organının işleyiş ilkelerini bilir.', 'Yargı bağımsızlığı, mahkemelerin hiçbir organ, makam veya kişinin emir ve talimatı olmaksızın, yalnızca Anayasa''ya, kanuna ve hukuka uygun olarak vicdani kanaatlerine göre karar vermesini ifade eder.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a26dfd4-320c-405b-96f2-ab44c2f59ce5', 'Mahkemelerin hiçbir etki altında kalmadan bağımsız karar vermesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a26dfd4-320c-405b-96f2-ab44c2f59ce5', 'Yargı kararlarının yürütme tarafından onaylanması gerekliliği', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a26dfd4-320c-405b-96f2-ab44c2f59ce5', 'Hâkimlerin yasama organına bağlı çalışması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4a26dfd4-320c-405b-96f2-ab44c2f59ce5', 'Mahkeme kararlarının Cumhurbaşkanı onayına tabi olması', false, 3);

commit;

-- Kontrol:
select count(*) as toplam_soru from questions;