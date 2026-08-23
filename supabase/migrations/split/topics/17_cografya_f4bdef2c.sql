begin;
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
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ad4fc578-36e2-4810-896a-6a254abf5154', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'kolay'::difficulty_level, 'Yazların sıcak ve kurak, kışların ise ılık ve yağışlı geçtiği iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin temel özelliklerini tanıyabilme.', 'Yazın sıcak-kurak, kışın ılık-yağışlı geçmesi Akdeniz ikliminin temel özelliğidir; bu iklim Akdeniz ve Ege kıyılarında görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ad4fc578-36e2-4810-896a-6a254abf5154', 'Karadeniz iklimi', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ad4fc578-36e2-4810-896a-6a254abf5154', 'Akdeniz iklimi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ad4fc578-36e2-4810-896a-6a254abf5154', 'Karasal iklim', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ad4fc578-36e2-4810-896a-6a254abf5154', 'Marmara iklimi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4f8edbcc-232b-4522-8568-443e729ba35e', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'kolay'::difficulty_level, 'Türkiye''de her mevsim yağış alan ve yıllık yağış miktarı en fazla olan iklim tipi aşağıdaki bölgelerin hangisinde görülür?', 'İklim tiplerinin bölgesel dağılışını bilme.', 'Karadeniz iklimi her mevsim yağışlı olup Türkiye''nin en yağışlı iklim tipidir ve Karadeniz kıyı şeridinde görülür.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f8edbcc-232b-4522-8568-443e729ba35e', 'İç Anadolu Bölgesi''nin iç kesimleri', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f8edbcc-232b-4522-8568-443e729ba35e', 'Karadeniz Bölgesi kıyıları', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f8edbcc-232b-4522-8568-443e729ba35e', 'Akdeniz Bölgesi kıyıları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4f8edbcc-232b-4522-8568-443e729ba35e', 'Doğu Anadolu Bölgesi''nin yüksek kesimleri', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('8dc6772c-881f-40a6-9d6c-27cd18a689bf', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'orta'::difficulty_level, 'Türkiye''de kıyı kesimlerinden iç kesimlere gidildikçe iklimin kısa mesafede belirgin biçimde değişmesinin temel nedeni aşağıdakilerden hangisidir?', 'Yer şekillerinin iklim üzerindeki etkisini kavrayabilme.', 'Karadeniz ve Toros Dağları kıyıya paralel uzandığından denizden gelen nemli hava kütlelerinin iç kesimlere ulaşmasını engeller; bu nedenle kıyı ile iç kesim arasında kısa mesafede belirgin iklim farklılıkları oluşur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dc6772c-881f-40a6-9d6c-27cd18a689bf', 'Enlem farkının fazla olması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dc6772c-881f-40a6-9d6c-27cd18a689bf', 'Dağların kıyıya paralel uzanarak deniz etkisinin iç kesimlere sokulmasını engellemesi', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dc6772c-881f-40a6-9d6c-27cd18a689bf', 'Türkiye''nin üç tarafının denizlerle çevrili olması', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('8dc6772c-881f-40a6-9d6c-27cd18a689bf', 'Yıllık güneşlenme süresinin her yerde aynı olması', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('d5460c52-5857-4f88-8434-6ef2dae09a72', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'orta'::difficulty_level, 'Aşağıdaki illerden hangisinde yaz ile kış arasındaki sıcaklık farkının en fazla olması beklenir?', 'Karasallığın sıcaklık farkına etkisini örnekle ilişkilendirebilme.', 'Erzurum, denizden uzak ve yüksek bir iç kesimde yer aldığından karasal iklimin etkisiyle yaz-kış sıcaklık farkı diğer kıyı kentlerine göre daha fazladır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5460c52-5857-4f88-8434-6ef2dae09a72', 'Antalya', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5460c52-5857-4f88-8434-6ef2dae09a72', 'Rize', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5460c52-5857-4f88-8434-6ef2dae09a72', 'Erzurum', true, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('d5460c52-5857-4f88-8434-6ef2dae09a72', 'İzmir', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('ac96bb74-b6ab-425e-a313-7e494898f1df', 'f4bdef2c-d148-4d88-832f-731b8e3d122c', 'zor'::difficulty_level, 'Enlemleri birbirine yakın olmasına karşın Rize ile Erzurum arasında kış sıcaklıkları bakımından büyük fark bulunmasının temel nedeni aşağıdakilerden hangisidir?', 'Denizellik-karasallık ve yükseltinin sıcaklık üzerindeki birlikte etkisini analiz edebilme.', 'Rize kıyıda yer aldığından denizin ılımanlaştırıcı etkisi altındadır; Erzurum ise hem yüksek hem de karasal bir iç kesimde bulunduğundan kışları çok daha soğuk geçer. İki merkezin enlemleri birbirine yakın olsa da belirleyici olan denize yakınlık ve yükselti farkıdır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac96bb74-b6ab-425e-a313-7e494898f1df', 'İki merkezin farklı boylamlarda yer alması', false, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac96bb74-b6ab-425e-a313-7e494898f1df', 'Rize''nin denize kıyısının olması, Erzurum''un ise yüksek ve karasal bir konumda bulunması', true, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac96bb74-b6ab-425e-a313-7e494898f1df', 'Rize''de yağışın yalnızca kış mevsiminde düşmesi, Erzurum''da hiç yağış düşmemesi', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('ac96bb74-b6ab-425e-a313-7e494898f1df', 'Erzurum''un güneşten daha fazla ışın alması', false, 3);
commit;