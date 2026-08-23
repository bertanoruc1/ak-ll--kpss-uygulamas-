-- KPSS Türkçe: 7 ana konu için tam kapsamlı içerik (özet, ders notu, örnek soru)
-- ve her konu için 4'er soru + 5'er seçenek. Var olan 6 konu (Ses Bilgisi, Yazım
-- Kuralları, Noktalama İşaretleri, Sözcükte Anlam, Cümlede Anlam, Paragraf)
-- topic_contents UPSERT ile zenginleştiriliyor; eksik olan konu (Anlatım
-- Bozuklukları) yeni topic olarak ekleniyor.

insert into topic_contents (topic_id, summary, content_md, example_question) values ('ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'Büyük ve küçük ünlü uyumu, ünsüz yumuşaması/sertleşmesi, ünsüz benzeşmesi, kaynaştırma harfleri ve ulama konunun temelini oluşturur. ÖSYM bu konuda genellikle ''istisna'' kelimeleri (kardeş, elma, hangi, şişman gibi kurallara uymayan Türkçe veya yabancı kökenli sözcükler) üzerinden çeldirici üretir.', '## Büyük Ünlü Uyumu (Kalınlık-İncelik Uyumu)
Bir sözcüğün ilk hecesindeki ünlü kalınsa (a, ı, o, u) sonraki hecelerdeki ünlüler de kalın; ilk hece incese (e, i, ö, ü) sonraki ünlüler de ince olmalıdır. Örnek: ''kalemlik'' (hepsi ince) kurala uyar; ''anne'', ''kardeş'', ''elma'' gibi sözcükler bu kurala UYMAZ ama Türkçe kökenlidir — bunlar zamanla ses değişimine uğramış istisnalardır.

## Küçük Ünlü Uyumu (Düzlük-Yuvarlaklık Uyumu)
Düz ünlüden (a, e, ı, i) sonra düz; yuvarlak ünlüden (o, ö, u, ü) sonra ya dar-yuvarlak (u, ü) ya da düz-geniş (a, e) ünlü gelir. Yuvarlak ünlüden sonra GENİŞ-YUVARLAK (o, ö) ünlü gelemez; bu yüzden ''radyo-''nun çekimi ''radyoyu'' değil sondaki ''o'' korunarak ''radyoyu'' olur ama örneğin ''sonuç'' kelimesinde küçük ünlü uyumu bozulur çünkü ''u''dan sonra ''u'' değil ''a'' gelmiştir; bu istisnadır.

## Ünsüz Yumuşaması (Değişmesi)
Sert ünsüzle (p, ç, t, k) biten bir sözcük ünlüyle başlayan ek aldığında bu ünsüzler yumuşayarak b, c, d, g/ğ''ye dönüşür: kitap→kitabı, ağaç→ağacı, kanat→kanadı, çocuk→çocuğu. Tek heceli sözcüklerde (ат→atı değil at→atı; ''saat'', ''millet'' gibi bazı istisnalar hariç), özel adlarda (kesme işaretinden sonra: Ahmet''i değil Ahmed''i YAZILMAZ, yumuşama sadece söylenişte olur) bu kural işlemeyebilir.

## Ünsüz Benzeşmesi (Sertleşmesi)
Sert ünsüzle (f, s, t, k, ç, ş, h, p — ''fıstıkçı şahap'' ile ezberlenir) biten bir sözcüğe c, d, g ile başlayan bir ek geldiğinde bu ekin ünsüzü sertleşerek ç, t, k''ye dönüşür: kitap+cı→kitapçı, ağaç+da→ağaçta, kız+gil→kızgil (istisna, gil eki sertleşmez).

## Kaynaştırma Harfleri ve Ulama
Ünlüyle biten bir sözcüğe ünlüyle başlayan ek geldiğinde araya y, n, s, ş kaynaştırma harflerinden biri girer: kapı+ı→kapıyı, araba+ın→arabanın. Ulama ise yazıda değil KONUŞMADA görülen bir ses olayıdır: ünsüzle biten bir sözcükten sonra ünlüyle başlayan sözcük geldiğinde aradaki ünsüz bir sonraki sözcüğün ünlüsüne bağlanarak okunur (örnek: ''gel_iyor'' değil ''yaz aylarında'' ifadesi ''ya-za-yın-da'' gibi okunur).

## Kritik Hap Notlar
- Büyük ünlü uyumuna Türkçe kökenli olsa da uymayan sözcükler: anne, kardeş, elma, hangi, şişman, dahi, hani — ÖSYM''nin en sevdiği tuzak grubu.
- Küçük ünlü uyumu istisnası: yabancı kökenli sözcükler (radyo, viraj) ve bazı Türkçe sözcükler (avuç, konut, sonuç, buçuk).
- Ünsüz yumuşaması, TEK HECELİ sözcüklerde genelde işlemez: kaç→kaçı (yumuşamaz), suç→suçu (yumuşamaz); ama ''ağaç'' iki heceli olduğu için yumuşar: ağacı.
- Özel adlarda yumuşama SÖYLENİŞTE olur, YAZIDA kesme işaretinden sonraki ek orijinal hâliyle yazılır: ''Zonguldak''ı'' (yumuşamış hâliyle değil, ''Zonguldağı'' değil ''Zonguldak''ı'' yazılır — söylenişte ''Zonguldağı'' denir).
- Ulama YALNIZCA konuşma/okuma sırasında oluşan bir ses olayıdır, yazım kurallarını hiçbir şekilde etkilemez.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Büyük ünlü uyumu kuralı ve en sık çıkan istisna kelimeler (anne, kardeş, elma, hangi).
- [05:00 - 12:00] Küçük ünlü uyumu ve yabancı kökenli istisnalar.
- [12:00 - 20:00] Ünsüz yumuşaması ile ünsüz benzeşmesi (sertleşmesi) arasındaki fark, örneklerle.
- [20:00 - Bitiş] Kaynaştırma harfleri, ulama ve ÖSYM''nin bu konudaki klasik çeldirici kalıpları.', '''Bu sokak(taki) evlerin çoğu eski.'' cümlesindeki parantez içi ek için aşağıdakilerden hangisi söylenebilir?
A) Ünsüz yumuşamasına örnektir B) Ünsüz benzeşmesine (sertleşmesine) örnektir C) Kaynaştırma harfi içerir D) Büyük ünlü uyumuna aykırıdır E) Ulama örneğidir
Doğru Cevap: B — ''sokak'' sert ünsüzle (k) bittiği için ekin başındaki ''d'' sertleşerek ''t''ye dönüşmüştür (sokak+da değil sokak+ta/sokaktaki).') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'kolay'::difficulty_level, 'Aşağıdaki sözcüklerden hangisi büyük ünlü uyumu kuralına UYMAZ?', 'Büyük ünlü uyumu istisnalarını tanır.', '''Kardeş'' sözcüğünde ilk hece kalın ünlü (a) taşırken ikinci hecede ince ünlü (e) bulunur; bu, büyük ünlü uyumuna aykırı, Türkçe kökenli fakat zamanla ses değişimine uğramış klasik bir istisnadır (B doğru). Diğer seçeneklerdeki ''kalemlik'', ''gözlükçü'', ''öğretmen'' ve ''bilgisayar'' sözcüklerinin her biri kendi içinde tutarlı biçimde ya tamamen ince ya tamamen kalın ünlülerden oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'kalemlik', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'kardeş', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'gözlükçü', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'öğretmen', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a1ba6479-ee60-450d-8683-88bc61c06a58', 'bilgisayar', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'orta'::difficulty_level, '''Kitap-çı, ağaç-tan, sokak-ta'' örneklerinde görülen ses olayı aşağıdakilerden hangisidir?', 'Ünsüz benzeşmesini (sertleşmesini) tanır.', 'Sert ünsüzle (p, ç, k) biten sözcüklere c, d, g ile başlayan ekler geldiğinde bu eklerin ünsüzleri sertleşerek ç, t, k''ye dönüşür; bu olay ÜNSÜZ BENZEŞMESİ (sertleşmesi) olarak adlandırılır (E doğru). Ünsüz yumuşaması (A) bunun tam tersi yönde işleyen, sert ünsüzlerin yumuşadığı bir olaydır. Ulama (B) sadece konuşmada görülür, yazımı etkilemez. Kaynaştırma (C) ünlüyle biten sözcüklerde görülür. Büyük ünlü uyumu (D) bu örneklerle ilgisizdir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'Ünsüz yumuşaması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'Ulama', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'Kaynaştırma', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'Büyük ünlü uyumu', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d8e967da-98d8-4482-a723-7beaf85e6d94', 'Ünsüz benzeşmesi (sertleşmesi)', true, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'orta'::difficulty_level, 'Aşağıdaki sözcüklerden hangisinde ünsüz yumuşaması GÖRÜLMEZ?', 'Ünsüz yumuşamasının işlemediği durumları (tek heceli sözcükler) ayırt eder.', '''Suç'' tek heceli bir sözcüktür ve tek heceli sözcüklerde ünsüz yumuşaması genellikle işlemez: suç+u → suçu (yumuşamaz), ''suçu'' olarak kalır (D doğru — yumuşama görülmez). ''Kitap'' (kitabı), ''ağaç'' (ağacı), ''kanat'' (kanadı) ve ''çocuk'' (çocuğu) sözcükleri ise iki heceli olduğu için ünlüyle başlayan ek aldıklarında düzenli biçimde yumuşarlar.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'kitap (kitabı)', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'ağaç (ağacı)', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'kanat (kanadı)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'suç (suçu)', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4673cee6-1dab-4c0e-b1f4-b603c0f8e5ab', 'çocuk (çocuğu)', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'ffe5c195-5fea-45a3-9030-58f122e0e1ee', 'zor'::difficulty_level, 'Ulama ile ilgili aşağıdaki yargılardan hangisi doğrudur?', 'Ulamanın yazım kurallarıyla ilişkisini değerlendirir.', 'Ulama, ünsüzle biten bir sözcükten sonra ünlüyle başlayan sözcük geldiğinde ortaya çıkan ve yalnızca söyleyişte (okuyuşta) gerçekleşen bir ses olayıdır; yazım kurallarını hiçbir biçimde etkilemez, sözcükler ayrı yazılmaya devam eder (C doğru). A yanlıştır, ulama yazıda gösterilmez. B yanlıştır, ulama ünsüz benzeşmesiyle karıştırılmamalıdır, farklı bir olaydır. D yanlıştır, ulama yalnızca konuşma dilinde/okuyuşta ortaya çıkar. E yanlıştır, ulama iki ayrı sözcük arasında oluşur, tek sözcük içinde değil.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'Ulama, kelimelerin birleşik yazılmasını gerektirir', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'Ulama ile ünsüz benzeşmesi aynı ses olayıdır', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'Ulama yalnızca söyleyişte gerçekleşir, yazımı etkilemez', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'Ulama yazı dilinde de mutlaka gösterilmelidir', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('90cb17f7-f70e-4a69-8200-5a10603fc15a', 'Ulama, tek bir sözcüğün hecelerinde meydana gelen bir olaydır', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('9683464a-e0ce-493b-ae60-58c924e2ae5c', 'Büyük harflerin kullanımı, birleşik sözcüklerin yazımı, ''-de/-ki'' bağlaç mı ek mi olduğunun ayırt edilmesi, sayıların ve kısaltmaların yazımı bu konunun ÖSYM''de en sık sorulan alt başlıklarıdır. Bağlaç olan ''de'' HER ZAMAN ayrı yazılır, ek olan ''-de'' bitişik yazılır kuralı sınavın klasik ayracıdır.', '## Bağlaç ''de'' ile Hâl Eki ''-de'' Ayrımı
Bağlaç olan ''de'' cümleden çıkarıldığında anlam bozulmaz ve HER ZAMAN ayrı yazılır: ''Ben de geldim'' (çıkarılabilir: ''Ben geldim''). Hâl eki olan ''-de'' ise bulunma durumu bildirir ve sözcüğe bitişik yazılır: ''Evde kaldım'' (çıkarılamaz, ''Ev kaldım'' anlamsız olur).

## Bağlaç ''ki'' ile İlgi Eki ''-ki'' Ayrımı
Bağlaç olan ''ki'' her zaman ayrı yazılır: ''Duydum ki gelmişsin.'' İlgi eki olan ''-ki'' ise bitişik yazılır ve genellikle zaman/yer bildiren sözcüklere gelir: ''akşamki, yarınki, ondaki, benimki.'' İstisna: ''hâlbuki, mademki, sanki, oysaki, belki'' kalıplaşmış bitişik yazılan bağlaçlardır.

## Büyük Harflerin Kullanımı
Cümle başları, özel adlar (kişi, yer, millet, kurum adları), unvanlarla kullanılan özel adlar (Atatürk, Mustafa Kemal Paşa), gezegen/yıldız adları cümle içinde astronomi terimi olarak kullanılmadıkça büyük yazılır. Özel ada gelen çekim ekleri kesme işaretiyle ayrılır: ''Türkiye''den, Ali''nin.''

## Birleşik Sözcüklerin Yazımı
Anlam kayması olan birleşik sözcükler bitişik yazılır (aslanağzı=çiçek adı; ayrı yazılsa ''aslanın ağzı'' anlamına gelirdi). Kuruluş adları, ikilemeler (''aşağı yukarı'', ''gide gide'') genelde ayrı yazılır. ''-r, -ar/-er, -maz/-mez'' olumlu-olumsuz sıfat fiillerinin kalıplaştığı birleşik sözcükler bitişik yazılır: ''çekyat, dedikodu, unutkan.''

## Sayıların ve Kısaltmaların Yazımı
Sayılar metin içinde yazıyla yazılır (üç, on beş) ancak saat, tarih, para tutarı gibi durumlarda rakamla yazılabilir. Kısaltmalarda okunuşa göre ünlü uyumu uygulanır: ''TBMM''de, TDK''nin, cm''yi.''

## Kritik Hap Notlar
- Bağlaç ''de/da'' cümleden çıkarılınca anlam bozulmuyorsa AYRI yazılır: ''Sen de gel.''
- Hâl eki ''-de/-da'' bulunma bildirir, çıkarılınca anlam bozulur, BİTİŞİK yazılır: ''Okulda kaldım.''
- ''ki'' bağlacı ayrı yazılır (sanki, mademki, hâlbuki, oysaki, belki hariç — bunlar istisna, bitişik ve kalıplaşmıştır).
- Kesme işareti özel adlara gelen çekim eklerinden önce kullanılır: ''İstanbul''a, Ahmet''in''; ancak özel ad cins isme dönüşmüşse kesme kullanılmaz: ''bordo, camii'' gibi.
- Pekiştirmeli ikilemeler (bata çıka, güle güle) ve sıfat tekrarları genelde ayrı yazılır; asıl anlamından uzaklaşan kalıcı birleşikler (bitişik) bitişik yazılır.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Bağlaç ''de/da'' ile hâl eki ''-de/-da'' ayrımı, cümleden çıkarma testiyle.
- [05:00 - 12:00] Bağlaç ''ki'' ile ilgi eki ''-ki'' ayrımı ve istisna kalıplaşmış sözcükler.
- [12:00 - 20:00] Büyük harf kuralları, kesme işaretinin özel adlarda kullanımı, birleşik sözcükler.
- [20:00 - Bitiş] Sayı ve kısaltma yazımında ÖSYM''nin sevdiği tuzak örnekler.', '''Yarın ki toplantıya sen de katılacak mısın?'' cümlesindeki yazım yanlışı aşağıdakilerden hangisidir?
A) ''Yarınki'' bitişik yazılmalıydı B) ''sen de'' bitişik yazılmalıydı C) Cümle sonunda nokta olmalıydı D) ''toplantıya'' yanlış çekimlenmiş E) Yazım yanlışı yoktur
Doğru Cevap: A — ''yarınki'' zaman bildiren ilgi eki ''-ki'' aldığı için bitişik yazılmalıdır; ''sen de'' ise bağlaç olduğu ve cümleden çıkarılabildiği için doğru biçimde ayrı yazılmıştır.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''de/da'' bağlacının yazımı YANLIŞTIR?', 'Bağlaç ''de/da'' ile hâl ekini ayırt eder.', '''Bende bu kitaptan var'' cümlesinde ''bende'' bitişik yazılmış ama buradaki ''de'' bir bağlaçtır ve ''Ben de bu kitaptan var(ım)'' biçiminde cümleden çıkarılabildiği için AYRI yazılmalıydı: ''Ben de bu kitaptan var'' (C doğru, yanlış olan cümle). Diğer seçeneklerdeki ''evde'' (hâl eki, bitişik doğru), ''sen de'' (bağlaç, ayrı doğru), ''kalemde'' (hâl eki, bitişik doğru) ve ''o da'' (bağlaç, ayrı doğru) yazımları kurala uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', 'Kalemim çantada, evde değil.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', 'Sen de bizimle gelir misin?', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', 'Bende bu kitaptan var.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', 'Kalemim çantada duruyor.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54bf2306-e57e-4465-b9fc-6a4842a1796a', 'O da bizimle geldi.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'orta'::difficulty_level, 'Aşağıdaki sözcüklerden hangisinde ''-ki'' eki YANLIŞ yazılmıştır?', 'Bağlaç ''ki'' ile ilgi eki ''-ki'' ayrımını uygular.', '''Akşam ki'' zaman bildiren bir ilgi eki taşıdığı için BİTİŞİK yazılmalıdır: ''akşamki'' (C doğru, yanlış olan). ''Onunki'' (ilgi eki, bitişik doğru), ''sanki'' (kalıplaşmış bağlaç, bitişik doğru), ''demek ki'' (bağlaç, ayrı doğru) ve ''yarınki'' (ilgi eki, bitişik doğru) yazımları kurala uygundur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', 'Bu çanta onunki değil.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', 'Sanki hiç tanışmamışız gibi davrandı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', 'Akşam ki haberlerde bu konu geçti.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', 'Demek ki haklıymışsın.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('58d739a1-58cd-4f07-9a8f-d0e44bf187c2', 'Yarınki sınav çok önemli.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük harf kullanımıyla ilgili bir yanlışlık YOKTUR?', 'Özel adların ve unvanların büyük harfle yazımını uygular.', '''Mustafa Kemal Atatürk''ün'' ifadesinde hem kişi adı hem de özel ada gelen ek kesme işaretiyle doğru ayrılmıştır (E doğru). A''da ''türkiye'' özel ad olduğu için büyük yazılmalıydı. B''de ''ayşe Öğretmen'' ifadesinde ''Ayşe'' büyük harfle başlamalıydı. C''de mevsim adı olan ''ilkbahar'' özel ad olmadığı için zaten küçük yazılması doğrudur ama seçenekte özel ad gibi büyük yazılmış olması yanlıştır. D''de ''dünya'' gezegen anlamında kullanıldığında büyük yazılması gerekirken küçük yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', 'türkiye, dünyanın en güzel ülkelerinden biridir.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', 'ayşe Öğretmen bize matematik anlatıyor.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', 'İlkbahar mevsiminde çiçekler açar, İlkbahar güzeldir.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', 'Bilim insanları dünya''nın yaşına dair yeni veriler buldu.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('54ea4be9-ace1-463a-af68-eb3906b1f18b', 'Mustafa Kemal Atatürk''ün fikirleri hâlâ geçerlidir.', true, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', '9683464a-e0ce-493b-ae60-58c924e2ae5c', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı vardır?', 'Kesme işareti ve birleşik sözcük yazım kurallarını bütüncül değerlendirir.', '''Aslan ağzı'' burada bir çiçek türünü (aslanağzı) değil gerçekten aslanın ağzını kastediyorsa ayrı yazılması doğrudur; ancak soruda çiçek adı kastedildiği hâlde ayrı yazılmışsa bu bir yazım yanlışıdır (B doğru, yanlış olan cümle — çiçek adı anlamında ''aslanağzı'' bitişik yazılmalıydı). A''da ''İstanbul''da'' özel ada gelen hâl eki doğru kesmeyle ayrılmıştır. C''de ''gide gide'' ikilemesi doğru biçimde ayrı yazılmıştır. D''de ''TBMM''de'' kısaltmaya gelen ek doğru kesmeyle ayrılmıştır. E''de ''çekyat'' kalıplaşmış birleşik sözcük olarak doğru bitişik yazılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', 'İstanbul''da yaşamak pahalı bir hâl aldı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', 'Bahçede sarı aslan ağzı çiçekleri açmıştı.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', 'Gide gide bir handa mola verdiler.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', 'Bu teklif TBMM''de görüşülecek.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5e35004-938b-4b8c-ba5f-159e078c95be', 'Salonumuzdaki çekyat çok rahat.', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'Virgülün sıralama, ara söz ve bağlaç öncesi/sonrası kullanımı, iki noktanın örnekleme ve açıklama işlevi, kısa çizginin ekleme yerine kullanımı ile noktalı virgülün eş değer cümleleri ayırma işlevi bu konunun en sık sorulan alt başlıklarıdır.', '## Virgül (,)
Sıralı öğeleri (eş görevli sözcük, sözcük grubu, cümle) birbirinden ayırmak için kullanılır: ''Kalem, defter ve silgi aldım.'' Cümle içindeki ARA SÖZLERİ (açıklayıcı, tamamlayıcı bilgi) ayırmak için kullanılır: ''Bu kitap, en sevdiğim roman, tekrar basıldı.'' Uzun cümlelerde ÖZNEDEN sonra konursa özneyi vurgulamak için kullanılabilir. Bağlaçlardan önce KULLANILMAZ (ve, veya, ile, ki, fakat gibi bağlaçlardan önce virgül konmaz) ancak sıralı cümlelerde tekrar eden bağlaçlardan önce konulabilir: ''Ne yağmur yağdı, ne kar.''

## Noktalı Virgül (;)
Ögeleri arasında virgül bulunan sıralamaları birbirinden ayırmak için kullanılır: ''Sınıfta Ali, Ayşe, Mehmet; öğretmenler odasında ise Ahmet Bey vardı.'' Anlamca ilgili ama bağlaçla bağlanmamış iki cümle arasında da kullanılabilir: ''Vakit geç oldu; herkes evine gitti.''

## İki Nokta (:)
Kendisinden sonra örnek, açıklama veya sıralama gelecek cümlelerin sonuna konur: ''Şu şehirleri gezdim: İstanbul, İzmir, Ankara.'' Ayrıca doğrudan aktarılan alıntı sözlerden önce kullanılır: ''Atatürk şöyle demiştir: ...''

## Kısa Çizgi (-) ve Uzun Çizgi (—)
Kısa çizgi, satır sonunda bölünen kelimeleri, ekleri kök sözcüğe bağlarken (ör. ''Türkiye''de -ki gibi durumlarda değil, gramer örneklerinde) ve sayı/ad aralıklarını göstermede kullanılır (''1920-1923''). Uzun çizgi ise konuşma metinlerinde konuşmacı değişimini gösterir.

## Tırnak İşareti (" ") ve Kesme İşareti ('')
Başkasından aktarılan sözler ve özel olarak vurgulanmak istenen ifadeler tırnak içine alınır. Kesme işareti ise yukarıdaki Yazım Kuralları konusunda ele alındığı gibi özel adlara gelen çekim eklerini ayırmak için kullanılır; cins isme dönüşmüş özel adlarda kesme KULLANILMAZ (''adaptör, jaguar'' gibi örnekler artık cins isimdir).

## Kritik Hap Notlar
- Bağlaçlardan (ve, ile, ki, veya) önce ASLA virgül konmaz; bu ÖSYM''nin en klasik tuzağıdır.
- Ara sözler (cümledeki ekleme/açıklama niteliğindeki bölümler) virgülle İKİ TARAFTAN da ayrılır, tek taraflı değil.
- Noktalı virgül, kendi içinde virgül geçen sıralamaları ayırmak için kullanılır — sıradan sıralamalarda kullanılmaz.
- İki nokta, örnekleme/açıklama/aktarma öncesinde kullanılır; cümlenin ortasında keyfi biçimde kullanılamaz.
- Kesme işareti, YALNIZCA özel ada gelen ekten önce kullanılır; cins isme dönüşen özel adlarda (kot pantolon, jaguar, sabun köpüğü gibi anlam kayması yaşamış sözcüklerde) kesme kullanılmaz.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Virgülün sıralama ve ara söz kullanımı, bağlaç öncesi virgül yasağı.
- [05:00 - 12:00] Noktalı virgül ile iki noktanın işlevsel farkı.
- [12:00 - 20:00] Kısa çizgi, uzun çizgi ve tırnak işaretinin kullanım alanları.
- [20:00 - Bitiş] ÖSYM''nin en sık sorduğu noktalama tuzakları ve çözümlü örnekler.', '''Bu evi; babam, dedem ve ben birlikte yaptık.'' cümlesindeki noktalama kullanımı için ne söylenebilir?
A) Doğru kullanılmıştır çünkü sıralamada virgül geçtiği için noktalı virgül gerekir B) Yanlıştır, burada noktalı virgül yerine virgül kullanılmalıydı çünkü sıralama tek düzeydir C) İki nokta kullanılmalıydı D) Tırnak işareti eksiktir E) Kısa çizgi kullanılmalıydı
Doğru Cevap: B — Noktalı virgül, İÇİNDE virgül geçen sıralamaları birbirinden ayırmak için kullanılır; burada tek düzeyli basit bir sıralama olduğu için sadece virgül yeterlidir, noktalı virgül fazladan ve yanlış kullanılmıştır.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde virgül YANLIŞ kullanılmıştır?', 'Virgülün bağlaçlarla ilişkisini bilir.', '''Ali, ve Ayşe okula gitti.'' cümlesinde ''ve'' bağlacından önce virgül konmuştur; bağlaçlardan önce virgül KULLANILMAZ, bu nedenle yanlıştır (B doğru, yanlış olan cümle). A''daki sıralama virgülü, C''deki ara söz virgülü, D''deki sıralama virgülü ve E''deki özne vurgusu virgülü doğru kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', 'Defter, kalem ve silgi aldım.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', 'Ali, ve Ayşe okula gitti.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', 'Bu kitap, en sevdiğim roman, yeniden basıldı.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', 'Ne kar yağdı, ne yağmur.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c07318c6-01e4-4c09-90c6-25f2e16a5a0d', 'Ben, bu işi bitirene kadar uyumayacağım.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('295fb975-596c-4448-9165-6562237e95e0', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalı virgül (;) doğru ve yerinde kullanılmıştır?', 'Noktalı virgülün, içinde virgül geçen sıralamaları ayırma işlevini uygular.', '''Toplantıya Ali, Veli, Ayşe; öğretmenler odasından da Mehmet Bey katıldı.'' cümlesinde ilk grup kendi içinde virgülle sıralandığı için bu grupla ikinci grubu ayırmak amacıyla noktalı virgül doğru kullanılmıştır (C doğru). Diğer seçeneklerde basit sıralamalarda gereksiz yere noktalı virgül kullanılmış ya da hiç sıralama yokken kullanılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('295fb975-596c-4448-9165-6562237e95e0', 'Kalem; defter aldım.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('295fb975-596c-4448-9165-6562237e95e0', 'Bugün hava çok güzel; dedi.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('295fb975-596c-4448-9165-6562237e95e0', 'Toplantıya Ali, Veli, Ayşe; öğretmenler odasından da Mehmet Bey katıldı.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('295fb975-596c-4448-9165-6562237e95e0', 'Sabah erken kalktım; kahvaltı yaptım; işe gittim.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('295fb975-596c-4448-9165-6562237e95e0', 'Okula gitti; geldi.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') YANLIŞ kullanılmıştır?', 'Kesme işaretinin özel ad-cins isim ayrımındaki kullanımını uygular.', '''Jaguar''ı çok severim, hızlı gider.'' cümlesinde araba markası özel ad olarak değil bir araba türünü (cins isim gibi) genel anlamda kastediyorsa kesme kullanılmamalıydı; ancak burada gerçek marka adı özel ad olarak kullanıldığı için kesme kullanımı normalde doğru olurdu — DOĞRU YANIT ise B''deki ''Kot pantolonun''u yıkadım'' cümlesidir çünkü ''kot'' artık cins isme dönüşmüş bir sözcüktür ve özel ad değildir, bu yüzden kesme kullanılmamalıdır; cümlede ''kot''un kesmeyle yazılmamış olması ZATEN doğrudur, dolayısıyla yanlış kullanım A''dadır: özel ada dönüşmemiş ''sabun köpüğü'' gibi bir cins isme kesme uygulanmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', 'Bu sabun''un köpüğü çok bol.', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', 'Ahmet''in evi çok uzakta.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', 'Türkiye''nin başkenti Ankara''dır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', 'İstanbul''a yarın gideceğim.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('634e4f38-e234-4a71-ba8f-0f692c5f89d8', 'Kitabın kapağında Mehmet''in resmi vardı.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('45ace92a-3414-4d0a-9f14-176a753863bb', '4d4e66fa-6b06-4194-a222-0ed30c0edd1b', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde iki nokta (:) kullanımı yerindedir?', 'İki noktanın örnekleme/açıklama işlevini değerlendirir.', '''Çantamda şunlar vardı: kalem, defter, silgi.'' cümlesinde iki nokta, kendisinden sonra gelen örnekleme/sıralamayı tanıtmak için doğru biçimde kullanılmıştır (D doğru). Diğer seçeneklerde iki nokta, herhangi bir örnekleme veya açıklama işlevi taşımadan cümlenin ortasına keyfi olarak yerleştirilmiştir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('45ace92a-3414-4d0a-9f14-176a753863bb', 'Bugün: hava çok güzeldi.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('45ace92a-3414-4d0a-9f14-176a753863bb', 'Ali eve: geldi.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('45ace92a-3414-4d0a-9f14-176a753863bb', 'Öğretmen: sınıfa girdi.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('45ace92a-3414-4d0a-9f14-176a753863bb', 'Çantamda şunlar vardı: kalem, defter, silgi.', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('45ace92a-3414-4d0a-9f14-176a753863bb', 'Kitabı: okudum ve beğendim.', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('d36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'Gerçek-mecaz-yan-terim anlam ayrımı, eş anlamlılık ve karşıt anlamlılık, deyimlerin ve atasözlerinin yorumlanması, ikilemeler bu konunun temel yapı taşlarıdır. ÖSYM genellikle bir cümledeki altı çizili sözcüğün hangi anlamda kullanıldığını, aynı anlamın geçtiği başka bir cümleyi bulmayı sorar.', '## Gerçek (Temel) Anlam
Bir sözcüğün akla ilk gelen, sözlükteki ilk karşılığı olan anlamıdır: ''Masanın ayağı kırıldı.'' cümlesinde ''ayak'' gerçek anlamda (organ) değil burada YAN anlamda kullanılmıştır aslında — dikkat: gerçek anlam insan/hayvan bacağının ucundaki uzuv anlamıdır.

## Mecaz Anlam
Sözcüğün gerçek anlamından tamamen uzaklaşarak benzetme yoluyla kazandığı yeni anlamdır: ''Bu adam çok soğuk biri.'' cümlesinde ''soğuk'' sıcaklık anlamında değil, ''sevgisiz, mesafeli'' anlamında kullanılmıştır; bu mecaz anlamdır.

## Yan Anlam
Sözcüğün gerçek anlamıyla biçim veya işlev benzerliği kurularak kazandığı, gerçek anlamdan tamamen kopmayan anlamdır: ''Masanın ayağı, şişenin ağzı, iğnenin gözü'' örnekleri yan anlama örnektir — burada hâlâ kısmi bir benzerlik (konum, işlev) korunur, mecazdaki gibi tam bir kopuş yoktur.

## Terim Anlam
Bir sözcüğün belirli bir bilim, sanat veya meslek dalında kazandığı özel anlamdır: ''Basınç'' fizikte, ''özne'' dilbilgisinde, ''faiz'' ekonomide birer terim anlamdır.

## Eş Anlamlılık (Anlamdaşlık) ve Karşıt Anlamlılık (Zıt Anlamlılık)
Yazılışları farklı, anlamları aynı veya çok yakın olan sözcükler eş anlamlıdır: ''kara-siyah, dünya-cihan.'' Anlamca birbirinin tam tersini karşılayan sözcükler karşıt anlamlıdır: ''gece-gündüz, ileri-geri.'' Not: Öz Türkçe bir sözcükle onun yabancı kökenli karşılığı da eş anlamlı sayılır: ''yanıt-cevap.''

## Deyimler ve Atasözleri
Deyimler, en az iki sözcükten oluşan, kalıplaşmış ve genellikle mecaz anlam taşıyan söz gruplarıdır: ''kulak asmamak, dört gözle beklemek.'' Atasözleri ise deneyimlere dayanan, öğüt/genel geçer yargı bildiren, EYLEM ZAMANI (geniş zaman) kalıplaşmış cümlelerdir: ''Damlaya damlaya göl olur.'' Ayırt edici fark: deyimler cümle içinde çekimlenerek kullanılabilir, atasözlerinin biçimi genelde SABİTTİR.

## Kritik Hap Notlar
- Mecaz anlamda sözcük gerçek anlamından TAMAMEN kopar; yan anlamda kısmi bir benzerlik (biçim/işlev) hâlâ korunur — bu ikisi ÖSYM''nin en sık karıştırdığı ayrımdır.
- Terim anlam, sözcüğün bir MESLEK/BİLİM DALI içindeki özel anlamıdır; bağlamdan (fizik, dilbilgisi, ekonomi gibi) hemen tanınır.
- Eş anlamlı sözcüklerin bir cümlede birbirinin yerine konması anlamı bozmaz; karşıt anlamlılar birbirinin YERİNE ASLA konamaz.
- Atasözleri kalıplaşmıştır, çekime uğramaz; deyimler ise cümle içinde özne-zaman-kişiye göre çekimlenebilir (''kulağı çınlamak'' → ''kulağım çınlıyor'').
- Bir sözün atasözü mü deyim mi olduğunu ayırmada kalıp cümle+öğüt/genel yargı içermesi atasözünü; sadece anlamlı bir kalıp söz olması ise deyimi işaret eder.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Gerçek-mecaz-yan-terim anlam ayrımı, örneklerle.
- [05:00 - 12:00] Eş anlamlılık ve karşıt anlamlılık, öz Türkçe-yabancı kökenli eş anlamlı çiftler.
- [12:00 - 20:00] Deyim-atasözü ayrımı, kalıplaşma ve çekim farkları.
- [20:00 - Bitiş] ÖSYM''nin sözcükte anlam sorularındaki klasik çeldirici teknikleri.', '''Bu haberi duyunca yüreği ağzına geldi.'' cümlesindeki altı çizili söz grubunun kullanım özelliği için ne söylenebilir?
A) Terim anlamda kullanılmıştır B) Gerçek anlamda kullanılmıştır C) Bir deyimdir, mecaz anlam taşır D) Bir atasözüdür E) Yan anlamda kullanılmıştır
Doğru Cevap: C — ''Yüreği ağzına gelmek'', gerçek anlamından tamamen kopan, ''çok korkmak/heyecanlanmak'' anlamına gelen kalıplaşmış bir deyimdir.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'kolay'::difficulty_level, '''Bardağın ağzı çok dar, su dökerken dikkat et.'' cümlesindeki altı çizili ''ağız'' sözcüğü hangi anlamda kullanılmıştır?', 'Yan anlamı tanır.', '''Ağız'' burada bir kabın açık kısmı anlamında kullanılmıştır; gerçek anlamıyla (insan/hayvan ağzı) biçimce/konumca bir benzerlik taşıdığı için bu YAN anlamdır (D doğru). Mecaz (A) olsaydı gerçek anlamdan tam bir kopuş olurdu. Terim (B) burada söz konusu değildir, belirli bir bilim dalına özgü değildir. Gerçek anlam (C) insan/hayvan ağzını karşılar, burada o değildir. Eş anlam (E) bu soruda ilgisizdir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'Mecaz anlamda', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'Terim anlamda', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'Gerçek anlamda', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'Yan anlamda', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d497a13f-90ea-49d0-b57e-c290c2803caa', 'Eş anlamda', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde altı çizili sözcük mecaz anlamda kullanılmıştır?', 'Mecaz anlamı gerçek/yan anlamdan ayırt eder.', '''Bu adamın sözleri çok ağır geldi bana.'' cümlesinde ''ağır'' sözcüğü fiziksel bir ağırlık değil, ''incitici, kırıcı'' anlamında kullanılmıştır; gerçek anlamdan (kilo/ağırlık) tamamen koptuğu için MECAZDIR (C doğru). Diğer seçeneklerdeki ''ağır'' (yük - gerçek anlam), ''tatlı'' (yiyecek - gerçek anlam), ''soğuk'' (hava - gerçek anlam) ve ''yüksek'' (bina - gerçek anlam) kullanımları gerçek anlamdadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'Çantası çok ağırdı, taşıyamadı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'Bu tatlı çok şekerliydi.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'Bu adamın sözleri çok ağır geldi bana.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'Dışarısı bugün çok soğuktu.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('625dd64e-0fc1-4834-9cef-9bd685918aa9', 'Bu bina çok yüksek.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'orta'::difficulty_level, 'Aşağıdakilerden hangisi bir atasözüdür, deyim DEĞİLDİR?', 'Atasözü ile deyimi ayırt eder.', '''Ağaç yaşken eğilir.'' kalıplaşmış, genel geçer bir öğüt/yargı bildiren ve çekime uğramayan bir ATASÖZÜDÜR (B doğru). ''Kulak asmamak'', ''gözden düşmek'', ''dile düşmek'' ve ''ağzından kaçırmak'' ifadeleri ise cümle içinde özneye göre çekimlenebilen deyimlerdir (''kulak asmıyor, gözden düştüm'' gibi).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'Kulak asmamak', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'Ağaç yaşken eğilir.', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'Gözden düşmek', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'Dile düşmek', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('9db6470d-8817-4402-a6a0-20a38437acc5', 'Ağzından kaçırmak', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'd36b15a7-95b8-4c4e-bf33-8e2737e8099e', 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde altı çizili sözcük terim anlamda kullanılmıştır?', 'Terim anlamı bağlamdan tanır.', '''Bu cümlenin öznesi belirsizdir.'' cümlesinde ''özne'' sözcüğü dilbilgisi biliminin bir terimi olarak kullanılmıştır; bu TERİM anlamdır (E doğru). Diğer seçeneklerdeki ''yüz'' (organ - gerçek anlam), ''kırık'' (durum - gerçek/yan anlam), ''akış'' (mecaz - hayatın akışı) ve ''ışık'' (gerçek anlam - lamba ışığı) terim anlam taşımaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'Yüzünü yıkadı ve dışarı çıktı.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'Bacağı kırık olduğu için yürüyemiyordu.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'Hayatın akışına kapılıp gitti.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'Lambanın ışığı çok güçlüydü.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('14ce1c9c-99d0-4240-9d10-456a72d289ee', 'Bu cümlenin öznesi belirsizdir.', true, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('eb6df17f-05d4-49df-b626-ba5d585672a9', 'Öznel-nesnel cümle ayrımı, neden-sonuç/amaç-sonuç/koşul-sonuç ilişkileri, karşılaştırma ve varsayım cümleleri bu konunun temel alt başlıklarıdır. ÖSYM bu konuda genellikle bir cümlenin hangi anlam ilişkisini (örneğin hem neden hem karşılaştırma) TAŞIMADIĞINI sormayı sever.', '## Öznel Cümle - Nesnel Cümle
Nesnel (objektif) cümle, kişiden kişiye değişmeyen, kanıtlanabilir, ölçülebilir bir bilgi verir: ''Ankara, Türkiye''nin başkentidir.'' Öznel (sübjektif) cümle ise kişisel yorum, beğeni veya duygu içerir, kişiden kişiye değişebilir: ''Bu, gördüğüm en güzel film.'' Bir cümlede yargı bildiren sıfatlar (güzel, başarılı, kötü, harika) genelde öznelliğin işaretidir.

## Neden-Sonuç İlişkisi
Bir cümlede bir yargının başka bir yargının GERÇEKLEŞME SEBEBİ olduğu ilişkidir: ''Yağmur yağdığı için yollar kaydı.'' Genelde ''-dığı için, -den dolayı, -diğinden'' ekleriyle kurulur.

## Amaç-Sonuç İlişkisi
Bir eylemin hangi AMAÇLA yapıldığını bildiren ilişkidir: ''Sınavı kazanmak için çok çalıştı.'' Neden-sonuçtan farkı, burada bilinçli bir istek/amaç söz konusudur, otomatik bir sebep-sonuç değil.

## Koşul (Şart) İlişkisi
Bir yargının gerçekleşmesinin başka bir yargının gerçekleşmesine BAĞLI olduğunu bildirir: ''Çalışırsan başarırsın.'' ''-sa/-se'' şart eki veya ''ise'' ile kurulur.

## Karşılaştırma
İki veya daha fazla varlık/durum arasında ÜSTÜNLÜK, BENZERLİK veya FARK bildiren cümlelerdir: ''Bu kitap, diğerinden daha ilginç.'' Karşılaştırma bildiren cümlede mutlaka en az iki öge kıyaslanmalıdır; bir cümlede sadece bir şeyin niteliği anlatılıyorsa bu karşılaştırma DEĞİLDİR.

## Varsayım (Sayma) Cümlesi
Henüz gerçekleşmemiş ama gerçekleşmiş GİBİ kabul edilen bir durumu anlatan cümlelerdir: ''Diyelim ki sınavı kazandın, sonra ne yapacaksın?'' ''Varsayalım, tut ki, diyelim ki'' kalıplarıyla tanınır.

## Kritik Hap Notlar
- Neden-sonuç ilişkisinde SEBEP otomatik/istemsizdir (yağmur yağdı, yol kaydı); amaç-sonuçta ise BİLİNÇLİ bir istek vardır (çalıştı çünkü kazanmak İSTİYORDU).
- Karşılaştırma cümlesinde MUTLAKA iki unsur kıyaslanır (''daha, kadar, göre'' sözcükleri genelde işaretidir); tek bir nitelik anlatımı karşılaştırma sayılmaz.
- Öznel cümlede kişisel yargı/beğeni sıfatları (güzel, başarılı, ilginç) bulunur; nesnel cümlede sayısal veri veya genel kabul görmüş bilgi bulunur.
- Bir cümle birden fazla anlam ilişkisini AYNI ANDA taşıyabilir (örneğin hem öznel hem karşılaştırma); ÖSYM soruları genelde ''bu cümlede ... yoktur'' şeklinde bir ilişkinin EKSİKLİĞİNİ sorar.
- Koşul cümlesindeki ''-se/-sa'' eki bazen dilek (temenni) bildirebilir, şart bildirmeyebilir: ''Keşke gelseydi.'' — bu şart değil DİLEK cümlesidir.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Öznel-nesnel cümle ayrımı ve tanıma teknikleri.
- [05:00 - 12:00] Neden-sonuç ile amaç-sonuç ilişkisinin karşılaştırılması.
- [12:00 - 20:00] Koşul, karşılaştırma ve varsayım cümleleri.
- [20:00 - Bitiş] Bir cümlede birden fazla anlam ilişkisinin bir arada bulunması ve ÖSYM''nin ''bu ilişki yoktur'' tarzı soruları.', '''Erken kalktığım için kahvaltı yapacak vaktim oldu, bu da günü daha enerjik geçirmemi sağladı.'' cümlesinde aşağıdaki anlam ilişkilerinden hangisi YOKTUR?
A) Neden-sonuç B) Karşılaştırma C) Öznellik unsuru D) Amaç-sonuç E) Zaman
Doğru Cevap: B — Cümlede erken kalkma-kahvaltı yapma arasında neden-sonuç, kahvaltı-enerjik geçirme arasında da neden-sonuç ilişkisi vardır; ancak herhangi iki unsur arasında bir KIYASLAMA (karşılaştırma) yapılmamıştır.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisi nesnel bir yargı bildirir?', 'Nesnel cümleyi öznel cümleden ayırt eder.', '''Su, 100 derecede kaynar.'' ifadesi kişiden kişiye değişmeyen, bilimsel olarak kanıtlanmış bir bilgidir; bu NESNEL bir cümledir (D doğru). Diğer seçeneklerdeki ''en güzel, en iyi, çok sıkıcı, harika'' gibi ifadeler kişisel yargı ve beğeni içerdiği için ÖZNELDİR.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'Bence bu, yılın en güzel filmiydi.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'Bu roman, okuduğum en iyi kitaptı.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'Su, 100 derecede kaynar.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'Bu yemek çok sıkıcı bir tada sahipti.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('979feead-d50e-4cd1-9700-de2ae78fa930', 'Konser harika geçti, herkes çok eğlendi.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'orta'::difficulty_level, '''Yarın erken kalkacağım ki treni kaçırmayayım.'' cümlesindeki anlam ilişkisi aşağıdakilerden hangisidir?', 'Amaç-sonuç ilişkisini tanır.', 'Cümlede erken kalkma eylemi, treni kaçırmamak BİLİNÇLİ AMACIYLA yapılmaktadır; bu AMAÇ-SONUÇ ilişkisidir (B doğru). Neden-sonuç (A) olması için otomatik/istemsiz bir sebep-sonuç ilişkisi gerekirdi. Koşul (C), karşılaştırma (D) ve varsayım (E) bu cümlede bulunmamaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'Neden-sonuç', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'Amaç-sonuç', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'Koşul (şart)', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'Karşılaştırma', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('c3bf51e5-3558-449e-9fdd-bc285bec78c1', 'Varsayım', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde karşılaştırma anlamı vardır?', 'Karşılaştırma cümlesini tanır.', '''Bu sınav, geçen seneki sınavdan daha zordu.'' cümlesinde iki farklı sınav birbirine kıyaslanarak zorluk açısından karşılaştırılmıştır (C doğru). Diğer seçeneklerde tek bir durum anlatılmakta, herhangi bir kıyaslama yapılmamaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'Bu sınav çok zordu.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'Sınava erken gittim.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'Bu sınav, geçen seneki sınavdan daha zordu.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'Sınav saat 10''da başladı.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e457aef5-296e-474b-98f4-44ff239242b7', 'Sınav sonuçları yarın açıklanacak.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'eb6df17f-05d4-49df-b626-ba5d585672a9', 'zor'::difficulty_level, '''Sınava çalışmadığı hâlde başarılı oldu.'' cümlesiyle ilgili aşağıdaki yargılardan hangisi doğrudur?', 'Beklenti (karşıtlık) ilişkisini diğer anlam ilişkilerinden ayırt eder.', 'Cümlede ''çalışmadığı hâlde'' ifadesi normalde beklenen sonucun (başarısız olma) TERSİNİN gerçekleştiğini bildirir; bu bir BEKLENTİYE AYKIRILIK (karşıtlık) ilişkisidir, neden-sonuç değildir çünkü burada sebep sonucu doğurmamış tam tersine bir durum ortaya çıkmıştır (D doğru). A yanlıştır, bu cümlede olağan bir neden-sonuç ilişkisi yoktur, tam tersi bir durum vardır. B yanlıştır, amaç bildiren bir ifade yoktur. C yanlıştır, herhangi bir kıyaslama söz konusu değildir. E yanlıştır, koşul bildiren bir ''-se/-sa'' eki bulunmamaktadır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'Cümlede olağan bir neden-sonuç ilişkisi vardır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'Cümlede amaç-sonuç ilişkisi vardır.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'Cümlede karşılaştırma anlamı vardır.', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'Cümlede beklentiye aykırılık (karşıtlık) anlamı vardır.', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('05a6c627-7be9-4d98-a553-616c9ef18b7b', 'Cümlede koşul (şart) anlamı vardır.', false, 4);

insert into topic_contents (topic_id, summary, content_md, example_question) values ('f884a167-9e40-4c5c-bc29-810eb13f200e', 'Paragrafın ana düşüncesi ile yardımcı düşüncelerin ayrımı, paragrafta anlatım biçimleri (öyküleyici, betimleyici, açıklayıcı, tartışmacı), paragraf tamamlama ve akışı bozan cümleyi bulma bu konunun ÖSYM''de en çok soru getiren alt başlıklarıdır.', '## Ana Düşünce ve Yardımcı Düşünce
Ana düşünce, paragrafın YAZILMA AMACINI, yazarın asıl anlatmak istediği tek ve en genel yargıyı ifade eder. Yardımcı düşünceler ise bu ana düşünceyi DESTEKLEYEN, örnekleyen veya açıklayan tali fikirlerdir. Ana düşünce genelde paragrafın başında (tümdengelim) veya sonunda (tümevarım) yer alır; ortada bulunması daha az sıklıktadır.

## Paragrafta Anlatım Biçimleri
Öyküleyici anlatımda bir olay, kişi ve zaman/mekân içinde aktarılır. Betimleyici (tasvir edici) anlatımda beş duyuya hitap eden ayrıntılarla bir varlık/mekân okurun gözünde canlandırılır. Açıklayıcı anlatımda bilgi verme amacı öne çıkar, nesnel bir dil kullanılır. Tartışmacı anlatımda yazar bir görüşü savunur veya çürütür, iki görüş karşılaştırılır.

## Paragraf Tamamlama
Paragrafın başına veya sonuna gelecek cümleyi bulma sorularında bağlaçlar (ama, çünkü, bu yüzden), zamirler (bu, şu, o) ve paragrafın genel akışı/konusu en önemli ipuçlarıdır. Tamamlayıcı cümle, önceki/sonraki cümleyle anlam ve biçim (zaman, kişi) uyumu göstermelidir.

## Paragrafı İkiye Bölme
Bir paragrafta konu değişikliği olduğu noktadan paragraf ikiye bölünebilir; bu noktayı bulmak için konudaki ANİ GEÇİŞ veya yeni bir alt başlığın başlangıcı aranır.

## Akışı Bozan Cümle
Paragrafın genel konusuyla İLGİSİZ bilgi veren veya anlam bakımından ana fikri desteklemeyen cümle akışı bozan cümledir. Bu cümle çoğunlukla konudan sapma, gereksiz bir ayrıntı veya çelişen bir yargı içerir.

## Kritik Hap Notlar
- Ana düşünceyi bulmak için paragrafın başındaki ve sonundaki cümlelere özellikle dikkat edilmeli; genellikle bu ikisinden biri ana fikri taşır.
- Örnek/istatistik/tarih içeren cümleler genelde YARDIMCI düşüncedir, ana düşünce DEĞİLDİR — ÖSYM bu ayrımı sıkça test eder.
- Paragraf tamamlama sorularında ilk bakılması gereken şey zamirler (bu, şu, bunlar) ve bağlaçlardır (ama, fakat, bu nedenle) — bunlar önceki cümleyle bağlantıyı gösterir.
- Akışı bozan cümleyi bulurken ''konudan sapma var mı?'' sorusu sorulmalı; sadece ÜSLUP farkı akışı bozmaz, KONU farkı bozar.
- Öyküleyici anlatımda mutlaka bir olay örgüsü ve zaman/mekân bulunur; sadece bir yerin tasviri yapılıyorsa bu betimleyicidir, öyküleyici değildir.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Ana düşünce ile yardımcı düşüncenin ayrımı, tümdengelim/tümevarım paragraf yapıları.
- [05:00 - 12:00] Paragrafta anlatım biçimleri (öyküleyici, betimleyici, açıklayıcı, tartışmacı).
- [12:00 - 20:00] Paragraf tamamlama teknikleri: zamir ve bağlaç ipuçları.
- [20:00 - Bitiş] Akışı bozan cümleyi bulma stratejileri ve çözümlü örnekler.', '(I) Kitap okumak, insan zihnini pek çok yönden geliştirir. (II) Özellikle roman okumak empati kurma becerisini artırır. (III) Bilim insanları son yıllarda bu konuda çok sayıda araştırma yapmıştır. (IV) Benim en sevdiğim yazar Orhan Pamuk''tur. (V) Kurgusal metinler, başka insanların bakış açısını anlamamıza yardımcı olur.
Bu parçada numaralanmış cümlelerden hangisi akışı bozmaktadır?
A) I B) II C) III D) IV E) V
Doğru Cevap: D — Paragrafın geneli kitap okumanın zihinsel faydalarından bahsederken IV. cümle yazarın kişisel bir tercihini belirtir; bu, konudan tamamen sapan, akışı bozan bir cümledir.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'kolay'::difficulty_level, 'Bir paragrafta ana düşünce ile ilgili aşağıdakilerden hangisi YANLIŞTIR?', 'Ana düşüncenin temel özelliklerini bilir.', 'Bir paragrafta genellikle sadece BİR ana düşünce bulunur; birden fazla ana düşünce olması paragrafın bütünlüğünü bozar (C doğru, yanlış olan yargı budur). A, B, D ve E''deki yargılar (ana düşüncenin genelde başta/sonda bulunması, yardımcı düşüncelerce desteklenmesi, paragrafın amacını yansıtması) doğrudur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'Ana düşünce genellikle paragrafın başında veya sonunda yer alır.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'Ana düşünce, yardımcı düşüncelerle desteklenir.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'Bir paragrafta birden fazla ana düşünce bulunabilir.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'Ana düşünce, paragrafın yazılış amacını yansıtır.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('5c415d13-4506-41bc-9a5e-a063b094e30b', 'Örnekler ve sayısal veriler genelde yardımcı düşüncedir.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'orta'::difficulty_level, '''Dağın eteklerinde uzanan köy, sabah sisiyle örtülüydü; damlardan tüten dumanlar, soğuk havada beyaza karışıyordu.'' cümlesi hangi anlatım biçimine örnektir?', 'Betimleyici anlatımı tanır.', 'Cümlede bir olay örgüsü yoktur, bir mekân beş duyuya (görme) hitap eden ayrıntılarla tasvir edilmektedir; bu BETİMLEYİCİ (tasvir edici) anlatımdır (B doğru). Öyküleyici (A) olması için bir olay ve zaman akışı gerekirdi. Açıklayıcı (C) bilgi verme amacı taşımaz burada. Tartışmacı (D) bir görüş savunmaz. Emredici (E) bir buyruk içermez.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'Öyküleyici anlatım', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'Betimleyici anlatım', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'Açıklayıcı anlatım', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'Tartışmacı anlatım', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('e2c41052-4ae4-488d-8c9e-dd961e75b27e', 'Emredici anlatım', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'orta'::difficulty_level, 'Paragraf tamamlama sorularında aşağıdaki ipuçlarından hangisine öncelikle dikkat edilmelidir?', 'Paragraf tamamlama stratejilerini bilir.', 'Paragrafın başına/sonuna gelecek cümleyi bulurken önceki veya sonraki cümleyle bağlantı kuran zamirler (''bu, şu, bunlar'') ve bağlaçlar (''ama, çünkü, bu yüzden'') en güçlü ipucudur; bunlar cümleler arası anlam köprüsünü gösterir (C doğru). Diğer seçenekler (cümle uzunluğu, yazım hataları, noktalama sayısı, kelime sayısı) tamamlama sorularında belirleyici bir kriter değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'Cümlenin uzunluğu', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'Cümledeki yazım hatalarının sayısı', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'Zamirler ve bağlaçların kullanımı', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'Cümledeki noktalama işareti sayısı', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('739d1198-2436-4435-87b0-db5d53f16a60', 'Cümlede geçen kelime sayısı', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'f884a167-9e40-4c5c-bc29-810eb13f200e', 'zor'::difficulty_level, '(I) Türkiye''de organik tarım son yıllarda hızla yaygınlaşıyor. (II) Kimyasal gübre kullanılmadan yapılan bu tarım, toprağın uzun vadeli verimliliğini korur. (III) Organik ürünler genellikle daha pahalıya satılır. (IV) Ancak tüketiciler sağlıklı beslenme kaygısıyla bu ürünlere yöneliyor. (V) Kayseri, elma üretiminde Türkiye''nin en önemli illerinden biridir.
Bu parçada akışı bozan cümle hangisidir?', 'Akışı bozan cümleyi tespit eder.', 'Paragrafın geneli organik tarımın yaygınlaşması ve tüketici tercihleri üzerineyken V. cümle doğrudan ilgisiz biçimde bir ilin elma üretimindeki önemine değinir; bu konudan tamamen kopan, akışı bozan bir cümledir (E doğru). I, II, III ve IV. cümleler organik tarım konusuyla doğrudan ilgilidir ve paragrafın akışını sürdürür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'I', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'II', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'III', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'IV', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a7a2dc53-de32-4287-a885-72c3b0bbbbc7', 'V', true, 4);

insert into topics (id, subject_id, name, slug, kazanim_text, weight, order_index) values ('cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', '2896ce30-ac01-43c8-bfc6-aeecd9b0c63c', 'Anlatım Bozuklukları', 'anlatim-bozukluklari', 'Cümlelerdeki anlam (mantık) ve yapı (bilgi/dilbilgisi) kaynaklı anlatım bozukluklarını tespit eder.', 1.0, 7);
insert into topic_contents (topic_id, summary, content_md, example_question) values ('cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', 'Anlatım bozuklukları anlamdan (mantık hatası, gereksiz sözcük, çelişki) ve yapıdan (özne-yüklem uyumsuzluğu, ek eksikliği, çatı uyumsuzluğu) kaynaklanan iki ana grupta incelenir. ÖSYM bu konuda genellikle bir cümlede birden fazla hata türünü aynı anda test eder.', '## Anlamdan Kaynaklanan Anlatım Bozuklukları
Gereksiz sözcük kullanımı: Aynı anlama gelen iki sözcüğün yan yana kullanılmasıdır: ''Yalnızca sadece bunu istiyorum.'' (yalnızca ve sadece aynı anlamda, biri fazladır). Çelişen sözlerin bir arada kullanılması: ''Yaklaşık tam 100 kişi geldi.'' (yaklaşık ve tam birbiriyle çelişir). Anlam belirsizliği: ''Ali''nin arkadaşı ve kardeşi geldi.'' cümlesinde kaç kişinin geldiği belirsizdir. Mantık (neden-sonuç) hatası: ''Çok çalıştığı için sınavı kaybetti.'' cümlesi mantıksal olarak çelişkilidir çünkü çok çalışmak normalde başarıyı getirir.

## Yapıdan (Bilgi/Dilbilgisi) Kaynaklanan Anlatım Bozuklukları
Özne-yüklem uyumsuzluğu: Özne çoğul cansız varlıklardan oluşuyorsa yüklem TEKİL olmalıdır: ''Kitaplar rafa kondu'' (doğru), ''Kitaplar rafa kondular'' (yanlış). Ek eksikliği: Ortak kullanılan bir öge, ekleri farklı iki sözcüğe bağlandığında her ikisi için de doğru ek kullanılmalıdır: ''Bahçeye ve eve girdi.'' (doğru), ''Bahçeye ve eve girdi'' cümlesinde ek doğruysa sorun yok, ancak ''Kitabı okudu ve masaya koydu'' gibi yapılarda nesne-yüklem uyumu her ikisi için kontrol edilmelidir. Çatı (öznesi/nesnesi belirsiz fiil) uyumsuzluğu: Bir cümlede sıralı fiillerin çatısı (etken-edilgen) FARKLI olduğunda anlam bozulur: ''Kapıyı açtı ve içeri girildi.'' (açtı=etken, girildi=edilgen; özneler uyuşmuyor, yanlış). Tamlama eksikliği/yanlışlığı: Bir isim tamlamasının unsurlarından biri eksik veya yanlış eklenmiş olabilir: ''Ahmet''in ve Mehmet arabası'' (Mehmet''in olmalıydı, tamlama eki eksik).

## Gereksiz Yardımcı Fiil / Sözcük Kullanımı
Türkçe kökenli bir fiil varken onun yerine gereksiz biçimde ''etmek/yapmak/olmak'' ile kurulan yapı kullanılması da bir anlatım bozukluğu sayılabilir: ''Bahsedecek oldu'' yerine sade ''(bahsetti)'' yeterlidir; fazladan yapılan ekleme gereksiz uzatma sayılır.

## Kritik Hap Notlar
- Gereksiz sözcük hatasını bulmak için cümleden şüphelenilen sözcüğü çıkarıp anlamın bozulup bozulmadığına bakılır; anlam bozulmuyorsa o sözcük gereksizdir.
- Özne-yüklem uyumunda: ÇOĞUL CANSIZ özne + TEKİL yüklem kuralı unutulmamalı (''Ağaçlar sallandı'' doğru, ''Ağaçlar sallandılar'' yanlış); ancak özne insan ise çoğul yüklem de kullanılabilir (''Öğrenciler geldiler'' de kabul edilir, esas kural CANSIZ varlıklar içindir.
- Çatı uyumsuzluğunda sıralı/bağlı cümlelerde ORTAK ÖZNE veya ORTAK NESNE varsa, her iki fiilin de bu ortak ögeyle çatı bakımından uyumlu olması gerekir.
- Anlam belirsizliği genelde tamlama (''Ali''nin arkadaşı ve kardeşi'') veya sıralama (''İki genç kız'') yapılarında ortaya çıkar; kaç kişi/nesne olduğu net değilse belirsizlik vardır.
- Bir cümlede AYNI ANDA hem anlam hem yapı kaynaklı hata bulunabilir; ÖSYM soruları genelde ''bu cümledeki anlatım bozukluğunun nedeni aşağıdakilerden hangisidir'' şeklinde nedeni sorar, sadece hatayı değil.

## Video Ders Takip Rehberi
- [00:00 - 05:00] Anlamdan kaynaklanan anlatım bozuklukları: gereksiz sözcük, çelişen sözler, mantık hatası.
- [05:00 - 12:00] Yapıdan kaynaklanan anlatım bozuklukları: özne-yüklem uyumsuzluğu, ek eksikliği.
- [12:00 - 20:00] Çatı uyumsuzluğu ve tamlama hataları, örneklerle çözüm.
- [20:00 - Bitiş] ÖSYM''nin bir cümlede birden fazla hata türünü test ettiği karma sorular.', '''Sınıftaki öğrenciler ödevlerini yaptı ve dışarı çıktılar.'' cümlesindeki anlatım bozukluğunun nedeni nedir?
A) Gereksiz sözcük kullanımı B) Özne-yüklem uyumsuzluğu C) Anlam belirsizliği D) Çelişen sözlerin bir aradalığı E) Tamlama eksikliği
Doğru Cevap: B — Cümlede aynı özneye bağlı iki yüklemden biri tekil (''yaptı'') diğeri çoğul (''çıktılar'') çekimlenmiştir; bu tutarsızlık özne-yüklem uyumsuzluğuna örnektir.') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', 'kolay'::difficulty_level, '''Yaklaşık tam elli kişi toplantıya katıldı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Çelişen sözlerin bir aradalığından kaynaklanan bozukluğu tespit eder.', '''Yaklaşık'' belirsizlik, ''tam'' ise kesinlik bildirir; bu iki sözcük birbiriyle ÇELİŞİR, ikisinin bir arada kullanılması anlatım bozukluğuna yol açar (D doğru). Gereksiz sözcük (A) burada iki farklı anlam çelişkisi olduğu için tam olarak bu değildir aslında bu da bir tür fazlalıktır ama temel neden çelişkidir. Özne-yüklem uyumsuzluğu (B), anlam belirsizliği (C) ve tamlama eksikliği (E) bu cümlede söz konusu değildir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'Gereksiz sözcük kullanımı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'Özne-yüklem uyumsuzluğu', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'Anlam belirsizliği', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'Çelişen sözlerin bir arada kullanılması', true, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('a3f1a4f7-f766-4244-914d-6a287232b6e0', 'Tamlama eksikliği', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu YOKTUR?', 'Kurallara uygun kurulmuş cümleyi ayırt eder.', '''Ağaçlar rüzgârda sallandı.'' cümlesinde çoğul cansız özne (''ağaçlar'') tekil yüklemle (''sallandı'') doğru biçimde uyumludur, herhangi bir hata yoktur (C doğru). A''da ''yalnızca sadece'' gereksiz sözcük tekrarıdır. B''de ''yaklaşık tam'' çelişkilidir. D''de ''Ali''nin arkadaşı ve kardeşi'' ifadesinde kaç kişi olduğu belirsizdir. E''de ''kapıyı açtı ve girildi'' çatı uyumsuzluğu içerir (etken-edilgen karışımı).');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'Yalnızca sadece bunu istiyorum.', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'Yaklaşık tam elli kişi geldi.', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'Ağaçlar rüzgârda sallandı.', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'Ali''nin arkadaşı ve kardeşi bize geldi.', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ee384249-4b09-4b72-9620-89c93a5028ee', 'Kapıyı açtı ve içeri girildi.', false, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('f891d845-b42c-4118-9149-6c66032db45b', 'cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', 'orta'::difficulty_level, '''Kapıyı açtı ve odaya girildi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Çatı (etken-edilgen) uyumsuzluğunu tespit eder.', 'Cümlede ''açtı'' etken çatılı bir fiil iken ''girildi'' edilgen çatılıdır; sıralı fiillerin öznesi aynı olması gerekirken çatı farklılığı bu uyumu bozmuştur, bu bir ÇATI UYUMSUZLUĞUDUR (E doğru). Diğer seçeneklerdeki gereksiz sözcük (A), anlam belirsizliği (B), tamlama eksikliği (C) ve çelişen sözler (D) bu cümledeki hatayı açıklamaz.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f891d845-b42c-4118-9149-6c66032db45b', 'Gereksiz sözcük kullanımı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f891d845-b42c-4118-9149-6c66032db45b', 'Anlam belirsizliği', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f891d845-b42c-4118-9149-6c66032db45b', 'Tamlama eksikliği', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f891d845-b42c-4118-9149-6c66032db45b', 'Çelişen sözlerin bir aradalığı', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('f891d845-b42c-4118-9149-6c66032db45b', 'Çatı (etken-edilgen) uyumsuzluğu', true, 4);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'cb8b9cfd-ad14-4b82-bfca-b8476e6dfae4', 'zor'::difficulty_level, '''Öğrencilerin çoğu sınava hazırlıksız girdiği için başarılı oldu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Mantık (neden-sonuç) hatasını tespit eder.', 'Cümlede ''hazırlıksız girmek'' ile ''başarılı olmak'' arasında mantıksal bir çelişki vardır; normalde hazırlıksız girilen bir sınavda başarısızlık beklenir, cümledeki neden-sonuç ilişkisi MANTIK DIŞIDIR (B doğru). Gereksiz sözcük (A), özne-yüklem uyumsuzluğu (C), çatı uyumsuzluğu (D) ve tamlama eksikliği (E) bu cümlede söz konusu değildir; cümlenin dilbilgisi açısından yapısı doğrudur, sorun tamamen mantık/anlam düzeyindedir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'Gereksiz sözcük kullanımı', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'Neden-sonuç ilişkisinde mantık hatası', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'Özne-yüklem uyumsuzluğu', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'Çatı (etken-edilgen) uyumsuzluğu', false, 3);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('963dd6d4-b2b5-4a87-8468-185dff3f5fc0', 'Tamlama eksikliği', false, 4);

