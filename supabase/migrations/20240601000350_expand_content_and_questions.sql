-- Her KPSS dersinin konu içeriğini genişletir (yeni ## alt başlıklar) ve
-- her konuya 5'er yeni, özgün soru ekler (27 kpss_lisans konusunun her biri
-- için, ve isim eşleşen kpss_onlisans/kpss_ortaogretim konularına da aynı
-- eklemenin/soruların kopyalanması — 20240601000170'in statik sınav-türü
-- kopyalama örüntüsüyle tutarlı).
--
-- ÖNEMLİ: kpss_onlisans/kpss_ortaogretim konuları 20240601000300'ün dinamik
-- çalışma-zamanı döngüsüyle (id sütunu belirtilmeden, yani gen_random_uuid()
-- ile) oluşturulur — bu yüzden bu konuların id'leri ortamdan ortama FARKLIDIR
-- ve migration dosyasında sabit (hardcoded) UUID olarak KULLANILAMAZ. Bunun
-- yerine her hedef, (ders adı, konu adı, exam_type) ÜÇLÜSÜYLE ÇALIŞMA ZAMANINDA
-- eşleştirilir; eşleşme yoksa (İlk Türk-İslam Devletleri / Tarih ve Anlatım
-- Bozuklukları / Türkçe gibi onlisans/ortaogretim karşılığı olmayan birkaç
-- konuda olduğu gibi) o hedef için hiçbir şey eklenmez, hata da verilmez.
--
-- Her yeni sorunun 5 şıkkının DOĞRU CEVAP KONUMU programatik olarak rastgele
-- atanmıştır (20240601000340'taki dengeleme mantığıyla tutarlı, A şıkkında
-- yığılma olmaması için) — LLM çıktısında doğru şık her zaman ilk sıradaydı,
-- burada gerçek order_index'e yazılırken karıştırılıyor.
--
-- İçerik eklemeleri content_md'ye idempotent şekilde eklenir (eklenecek metnin
-- ilk satırı zaten mevcutsa tekrar eklenmez). Soru eklemeleri idempotenttir
-- (aynı topic + question_text zaten varsa atlanır).

-- ============ Türkçe ============
-- konu: Ses Bilgisi (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Ünlü Düşmesi (Hece Düşmesi)
İki heceli olup ikinci hecesinde dar bir ünlü (ı, i, u, ü) bulunan bazı Türkçe sözcükler, ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: "burun" → "burnu", "ağız" → "ağzı", "oğul" → "oğlu", "gönül" → "gönlü". Aynı olay bazı sözcüklerin isimden fiil türetiminde de görülür: "koku" → "kokla-", "sarı" → "sarar-". Bu ses olayına "hece düşmesi" de denir çünkü dar ünlünün düşmesiyle sözcüğün hece sayısı azalır.

## Ünlü Türemesi ve Ünsüz Türemesi
Kimi sözcükler pekiştirilirken veya bazı eklerle genişlerken ses türemesi görülür. Pekiştirme sırasında ünsüz türemesi yaşanır: "sap-a-sağlam", "düp-e-düz" örneklerinde araya "p" sesi girer. "Etmek, olmak" yardımcı fiilleriyle birleşen bazı sözcüklerde ise ünlü düşmesiyle birlikte ünsüz ikizleşmesi görülür: "his+etmek" → "hissetmek", "af+etmek" → "affetmek". Bu tür birleşmelerde son sesteki ünsüz ikizleşir ve yazıda da bu şekilde gösterilir.

## Çözümlü Örnek
**Soru:** "Doktor, hastanın nabzına baktıktan sonra reçeteyi yazdı." cümlesindeki sözcüklerden hangisinde ünlü düşmesi vardır?
**Çözüm:** "Nabız" sözcüğü ünlüyle başlayan bir ek aldığında ("nabzına") ikinci hecesindeki dar ünlü "ı" düşer: nabız+ı+n+a → nabzına. Bu, klasik bir ünlü düşmesi örneğidir; "doktor" ve "reçete" sözcüklerinde böyle bir ses olayı yaşanmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1)
  and tc.content_md not like '%## Ünlü Düşmesi (Hece Düşmesi)%';

-- konu: Ses Bilgisi (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Ünlü Düşmesi (Hece Düşmesi)
İki heceli olup ikinci hecesinde dar bir ünlü (ı, i, u, ü) bulunan bazı Türkçe sözcükler, ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: "burun" → "burnu", "ağız" → "ağzı", "oğul" → "oğlu", "gönül" → "gönlü". Aynı olay bazı sözcüklerin isimden fiil türetiminde de görülür: "koku" → "kokla-", "sarı" → "sarar-". Bu ses olayına "hece düşmesi" de denir çünkü dar ünlünün düşmesiyle sözcüğün hece sayısı azalır.

## Ünlü Türemesi ve Ünsüz Türemesi
Kimi sözcükler pekiştirilirken veya bazı eklerle genişlerken ses türemesi görülür. Pekiştirme sırasında ünsüz türemesi yaşanır: "sap-a-sağlam", "düp-e-düz" örneklerinde araya "p" sesi girer. "Etmek, olmak" yardımcı fiilleriyle birleşen bazı sözcüklerde ise ünlü düşmesiyle birlikte ünsüz ikizleşmesi görülür: "his+etmek" → "hissetmek", "af+etmek" → "affetmek". Bu tür birleşmelerde son sesteki ünsüz ikizleşir ve yazıda da bu şekilde gösterilir.

## Çözümlü Örnek
**Soru:** "Doktor, hastanın nabzına baktıktan sonra reçeteyi yazdı." cümlesindeki sözcüklerden hangisinde ünlü düşmesi vardır?
**Çözüm:** "Nabız" sözcüğü ünlüyle başlayan bir ek aldığında ("nabzına") ikinci hecesindeki dar ünlü "ı" düşer: nabız+ı+n+a → nabzına. Bu, klasik bir ünlü düşmesi örneğidir; "doktor" ve "reçete" sözcüklerinde böyle bir ses olayı yaşanmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1)
  and tc.content_md not like '%## Ünlü Düşmesi (Hece Düşmesi)%';

-- konu: Ses Bilgisi (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Ünlü Düşmesi (Hece Düşmesi)
İki heceli olup ikinci hecesinde dar bir ünlü (ı, i, u, ü) bulunan bazı Türkçe sözcükler, ünlüyle başlayan bir ek aldığında bu dar ünlü düşer: "burun" → "burnu", "ağız" → "ağzı", "oğul" → "oğlu", "gönül" → "gönlü". Aynı olay bazı sözcüklerin isimden fiil türetiminde de görülür: "koku" → "kokla-", "sarı" → "sarar-". Bu ses olayına "hece düşmesi" de denir çünkü dar ünlünün düşmesiyle sözcüğün hece sayısı azalır.

## Ünlü Türemesi ve Ünsüz Türemesi
Kimi sözcükler pekiştirilirken veya bazı eklerle genişlerken ses türemesi görülür. Pekiştirme sırasında ünsüz türemesi yaşanır: "sap-a-sağlam", "düp-e-düz" örneklerinde araya "p" sesi girer. "Etmek, olmak" yardımcı fiilleriyle birleşen bazı sözcüklerde ise ünlü düşmesiyle birlikte ünsüz ikizleşmesi görülür: "his+etmek" → "hissetmek", "af+etmek" → "affetmek". Bu tür birleşmelerde son sesteki ünsüz ikizleşir ve yazıda da bu şekilde gösterilir.

## Çözümlü Örnek
**Soru:** "Doktor, hastanın nabzına baktıktan sonra reçeteyi yazdı." cümlesindeki sözcüklerden hangisinde ünlü düşmesi vardır?
**Çözüm:** "Nabız" sözcüğü ünlüyle başlayan bir ek aldığında ("nabzına") ikinci hecesindeki dar ünlü "ı" düşer: nabız+ı+n+a → nabzına. Bu, klasik bir ünlü düşmesi örneğidir; "doktor" ve "reçete" sözcüklerinde böyle bir ses olayı yaşanmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1)
  and tc.content_md not like '%## Ünlü Düşmesi (Hece Düşmesi)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?', 'Ünlü düşmesine uğrayan sözcükleri diğer sözcüklerden ayırt eder.', '"Omuz" sözcüğü ünlüyle başlayan ek aldığında ikinci hecesindeki dar ünlü düşer: omuz+u → omzu. Diğer sözcüklerde (kitap, deniz, kalem, masa) böyle bir düşme yaşanmaz; en fazla yumuşama veya kaynaştırma görülür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('omuz', true, 0),
  ('kitap', false, 1),
  ('deniz', false, 3),
  ('kalem', false, 2),
  ('masa', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?', 'Ünlü düşmesine uğrayan sözcükleri diğer sözcüklerden ayırt eder.', '"Omuz" sözcüğü ünlüyle başlayan ek aldığında ikinci hecesindeki dar ünlü düşer: omuz+u → omzu. Diğer sözcüklerde (kitap, deniz, kalem, masa) böyle bir düşme yaşanmaz; en fazla yumuşama veya kaynaştırma görülür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('omuz', true, 0),
  ('kitap', false, 1),
  ('deniz', false, 3),
  ('kalem', false, 2),
  ('masa', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?', 'Ünlü düşmesine uğrayan sözcükleri diğer sözcüklerden ayırt eder.', '"Omuz" sözcüğü ünlüyle başlayan ek aldığında ikinci hecesindeki dar ünlü düşer: omuz+u → omzu. Diğer sözcüklerde (kitap, deniz, kalem, masa) böyle bir düşme yaşanmaz; en fazla yumuşama veya kaynaştırma görülür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kelimelerden hangisi ünlüyle başlayan bir ek aldığında ünlü düşmesine (hece düşmesine) uğrar?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('omuz', true, 0),
  ('kitap', false, 1),
  ('deniz', false, 3),
  ('kalem', false, 2),
  ('masa', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?', 'Yardımcı fiille kurulan birleşik fiillerdeki ünsüz ikizleşmesini tanır.', '"His" sözcüğü "etmek" ile birleşirken ünsüz ikizleşmesi yaşanır ve "hissetmek" biçiminde yazılır; bu, Türkçede yardımcı fiille kurulan bazı birleşik fiillerde görülen özel bir ses olayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünsüz ikizleşmesi olur, doğru yazım ''hissetmek''tir.', true, 2),
  ('Ünlü türemesi olur, doğru yazım ''hisetmek''tir.', false, 4),
  ('Ünsüz benzeşmesi olur, doğru yazım ''histetmek''tir.', false, 3),
  ('Herhangi bir ses olayı olmaz, ''hisetmek'' yazılır.', false, 1),
  ('Ünlü düşmesi olur, doğru yazım ''hsetmek''tir.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?', 'Yardımcı fiille kurulan birleşik fiillerdeki ünsüz ikizleşmesini tanır.', '"His" sözcüğü "etmek" ile birleşirken ünsüz ikizleşmesi yaşanır ve "hissetmek" biçiminde yazılır; bu, Türkçede yardımcı fiille kurulan bazı birleşik fiillerde görülen özel bir ses olayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünsüz ikizleşmesi olur, doğru yazım ''hissetmek''tir.', true, 2),
  ('Ünlü türemesi olur, doğru yazım ''hisetmek''tir.', false, 4),
  ('Ünsüz benzeşmesi olur, doğru yazım ''histetmek''tir.', false, 3),
  ('Herhangi bir ses olayı olmaz, ''hisetmek'' yazılır.', false, 1),
  ('Ünlü düşmesi olur, doğru yazım ''hsetmek''tir.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?', 'Yardımcı fiille kurulan birleşik fiillerdeki ünsüz ikizleşmesini tanır.', '"His" sözcüğü "etmek" ile birleşirken ünsüz ikizleşmesi yaşanır ve "hissetmek" biçiminde yazılır; bu, Türkçede yardımcı fiille kurulan bazı birleşik fiillerde görülen özel bir ses olayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''His'' sözcüğü ''-etmek'' yardımcı fiiliyle birleşirken hangi ses olayı meydana gelir ve doğru yazımı nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünsüz ikizleşmesi olur, doğru yazım ''hissetmek''tir.', true, 2),
  ('Ünlü türemesi olur, doğru yazım ''hisetmek''tir.', false, 4),
  ('Ünsüz benzeşmesi olur, doğru yazım ''histetmek''tir.', false, 3),
  ('Herhangi bir ses olayı olmaz, ''hisetmek'' yazılır.', false, 1),
  ('Ünlü düşmesi olur, doğru yazım ''hsetmek''tir.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?', 'Bir cümle içinde geçen sözcükteki ses olayını tespit eder.', '"Ağzını" sözcüğü, "ağız" kelimesinin ünlüyle başlayan ek almasıyla ikinci hecedeki dar ünlünün düşmesi sonucu oluşmuştur; bu klasik bir ünlü düşmesi (hece düşmesi) örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünlü düşmesi (hece düşmesi)', true, 2),
  ('Ünsüz yumuşaması', false, 1),
  ('Ünsüz benzeşmesi', false, 3),
  ('Kaynaştırma', false, 0),
  ('Ulama', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?', 'Bir cümle içinde geçen sözcükteki ses olayını tespit eder.', '"Ağzını" sözcüğü, "ağız" kelimesinin ünlüyle başlayan ek almasıyla ikinci hecedeki dar ünlünün düşmesi sonucu oluşmuştur; bu klasik bir ünlü düşmesi (hece düşmesi) örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünlü düşmesi (hece düşmesi)', true, 2),
  ('Ünsüz yumuşaması', false, 1),
  ('Ünsüz benzeşmesi', false, 3),
  ('Kaynaştırma', false, 0),
  ('Ulama', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?', 'Bir cümle içinde geçen sözcükteki ses olayını tespit eder.', '"Ağzını" sözcüğü, "ağız" kelimesinin ünlüyle başlayan ek almasıyla ikinci hecedeki dar ünlünün düşmesi sonucu oluşmuştur; bu klasik bir ünlü düşmesi (hece düşmesi) örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Yorgun ağzını zar zor açıp bize gülümsedi.'' cümlesindeki ''ağzını'' sözcüğünde görülen ses olayı aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ünlü düşmesi (hece düşmesi)', true, 2),
  ('Ünsüz yumuşaması', false, 1),
  ('Ünsüz benzeşmesi', false, 3),
  ('Kaynaştırma', false, 0),
  ('Ulama', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?', 'Ünsüz benzeşmesi kuralını somut örnekler üzerinde uygular.', '"Sokak" sert ünsüzle (k) biter; kendisine gelen "-de" eki bu nedenle sertleşerek "-ta" biçimini alır ve "sokakta" ünsüz benzeşmesine örnektir. "Kitabı" ünsüz yumuşamasına, diğer seçenekler ise farklı ya da hiçbir ses olayına örnek değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('sokak + ta → sokakta', true, 1),
  ('kitap + ı → kitabı', false, 0),
  ('ev + de → evde', false, 4),
  ('araba + da → arabada', false, 2),
  ('gül + den → gülden', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?', 'Ünsüz benzeşmesi kuralını somut örnekler üzerinde uygular.', '"Sokak" sert ünsüzle (k) biter; kendisine gelen "-de" eki bu nedenle sertleşerek "-ta" biçimini alır ve "sokakta" ünsüz benzeşmesine örnektir. "Kitabı" ünsüz yumuşamasına, diğer seçenekler ise farklı ya da hiçbir ses olayına örnek değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('sokak + ta → sokakta', true, 1),
  ('kitap + ı → kitabı', false, 0),
  ('ev + de → evde', false, 4),
  ('araba + da → arabada', false, 2),
  ('gül + den → gülden', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?', 'Ünsüz benzeşmesi kuralını somut örnekler üzerinde uygular.', '"Sokak" sert ünsüzle (k) biter; kendisine gelen "-de" eki bu nedenle sertleşerek "-ta" biçimini alır ve "sokakta" ünsüz benzeşmesine örnektir. "Kitabı" ünsüz yumuşamasına, diğer seçenekler ise farklı ya da hiçbir ses olayına örnek değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Ünsüz benzeşmesi, sert ünsüzle biten bir sözcüğe c, d, g ile başlayan bir ekin gelmesi durumunda bu ek ünsüzünün sertleşmesidir. Buna göre aşağıdaki kelimelerin hangisinde ünsüz benzeşmesi örneği vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('sokak + ta → sokakta', true, 1),
  ('kitap + ı → kitabı', false, 0),
  ('ev + de → evde', false, 4),
  ('araba + da → arabada', false, 2),
  ('gül + den → gülden', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?', 'Büyük ünlü uyumunun Türkçe kökenli istisna sözcüklerini metin içinde fark eder.', '"Kardeş" ve "hangi" sözcükleri Türkçe kökenli olmalarına rağmen tarihsel ses değişimleri sonucu büyük ünlü uyumuna uymayan istisna sözcüklerdir; diğer cümlelerdeki sözcüklerin tamamı kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kardeşimle hangi filme gideceğimizi henüz konuşmadık.', true, 1),
  ('Öğrenciler sınav sonuçlarını sabırsızlıkla bekliyordu.', false, 4),
  ('Bahçedeki güller sabah erkenden açmıştı.', false, 0),
  ('Kitaplarını düzenli bir şekilde rafa yerleştirdi.', false, 2),
  ('Yeni aldığı arabayı herkese gösteriyordu.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?', 'Büyük ünlü uyumunun Türkçe kökenli istisna sözcüklerini metin içinde fark eder.', '"Kardeş" ve "hangi" sözcükleri Türkçe kökenli olmalarına rağmen tarihsel ses değişimleri sonucu büyük ünlü uyumuna uymayan istisna sözcüklerdir; diğer cümlelerdeki sözcüklerin tamamı kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kardeşimle hangi filme gideceğimizi henüz konuşmadık.', true, 1),
  ('Öğrenciler sınav sonuçlarını sabırsızlıkla bekliyordu.', false, 4),
  ('Bahçedeki güller sabah erkenden açmıştı.', false, 0),
  ('Kitaplarını düzenli bir şekilde rafa yerleştirdi.', false, 2),
  ('Yeni aldığı arabayı herkese gösteriyordu.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Ses Bilgisi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?', 'Büyük ünlü uyumunun Türkçe kökenli istisna sözcüklerini metin içinde fark eder.', '"Kardeş" ve "hangi" sözcükleri Türkçe kökenli olmalarına rağmen tarihsel ses değişimleri sonucu büyük ünlü uyumuna uymayan istisna sözcüklerdir; diğer cümlelerdeki sözcüklerin tamamı kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde büyük ünlü uyumuna, Türkçe kökenli olduğu hâlde uymayan bir sözcük kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kardeşimle hangi filme gideceğimizi henüz konuşmadık.', true, 1),
  ('Öğrenciler sınav sonuçlarını sabırsızlıkla bekliyordu.', false, 4),
  ('Bahçedeki güller sabah erkenden açmıştı.', false, 0),
  ('Kitaplarını düzenli bir şekilde rafa yerleştirdi.', false, 2),
  ('Yeni aldığı arabayı herkese gösteriyordu.', false, 3)
) as v(choice_text, is_correct, order_index);

-- konu: Yazım Kuralları (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Soru Eki ''mı/mi/mu/mü''nün Yazımı
Soru eki, kendisinden önceki sözcükten HER ZAMAN ayrı yazılır: "Geldin mi?", "Bunu biliyor musun?" Şahıs eki aldığında da ayrılığını korur: "Çalışkan mısın?" Yalnızca soru ekinden sonra gelen bildirme/şahıs ekleri kendisine bitişik yazılır: "mısın, misin, musun, müsün." Soru eki hiçbir durumda kendisinden önceki sözcüğe bitişik yazılmaz; ÖSYM bu ekin yanlışlıkla bitişik yazıldığı veya ünlü uyumuna aykırı kullanıldığı cümleleri sıkça tuzak olarak kullanır.

## Pekiştirme Sıfatlarının Yazımı
Sözcüğün ilk hecesi alınıp araya m, p, r, s ünsüzlerinden biri getirilerek yapılan pekiştirmeli sıfatlar bitişik yazılır ve arada tire kullanılmaz: "masmavi, güpgüzel, tertemiz, kapkara, sımsıcak, dosdoğru." Hangi pekiştirme ünsüzünün kullanılacağı sözcüğün son sesine ve söyleyiş geleneğine bağlıdır, bu nedenle bu tür sözcükler genellikle ezbere bilinmesi gereken kalıplardır.

| Sözcük | Pekiştirmeli Biçim | Pekiştirme Ünsüzü |
|---|---|---|
| temiz | tertemiz | r |
| mavi | masmavi | m |
| güzel | güpgüzel | p |
| sıcak | sımsıcak | m |
| doğru | dosdoğru | s |'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1)
  and tc.content_md not like '%## Soru Eki ''mı/mi/mu/mü''nün Yazımı%';

-- konu: Yazım Kuralları (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Soru Eki ''mı/mi/mu/mü''nün Yazımı
Soru eki, kendisinden önceki sözcükten HER ZAMAN ayrı yazılır: "Geldin mi?", "Bunu biliyor musun?" Şahıs eki aldığında da ayrılığını korur: "Çalışkan mısın?" Yalnızca soru ekinden sonra gelen bildirme/şahıs ekleri kendisine bitişik yazılır: "mısın, misin, musun, müsün." Soru eki hiçbir durumda kendisinden önceki sözcüğe bitişik yazılmaz; ÖSYM bu ekin yanlışlıkla bitişik yazıldığı veya ünlü uyumuna aykırı kullanıldığı cümleleri sıkça tuzak olarak kullanır.

## Pekiştirme Sıfatlarının Yazımı
Sözcüğün ilk hecesi alınıp araya m, p, r, s ünsüzlerinden biri getirilerek yapılan pekiştirmeli sıfatlar bitişik yazılır ve arada tire kullanılmaz: "masmavi, güpgüzel, tertemiz, kapkara, sımsıcak, dosdoğru." Hangi pekiştirme ünsüzünün kullanılacağı sözcüğün son sesine ve söyleyiş geleneğine bağlıdır, bu nedenle bu tür sözcükler genellikle ezbere bilinmesi gereken kalıplardır.

| Sözcük | Pekiştirmeli Biçim | Pekiştirme Ünsüzü |
|---|---|---|
| temiz | tertemiz | r |
| mavi | masmavi | m |
| güzel | güpgüzel | p |
| sıcak | sımsıcak | m |
| doğru | dosdoğru | s |'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1)
  and tc.content_md not like '%## Soru Eki ''mı/mi/mu/mü''nün Yazımı%';

-- konu: Yazım Kuralları (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Soru Eki ''mı/mi/mu/mü''nün Yazımı
Soru eki, kendisinden önceki sözcükten HER ZAMAN ayrı yazılır: "Geldin mi?", "Bunu biliyor musun?" Şahıs eki aldığında da ayrılığını korur: "Çalışkan mısın?" Yalnızca soru ekinden sonra gelen bildirme/şahıs ekleri kendisine bitişik yazılır: "mısın, misin, musun, müsün." Soru eki hiçbir durumda kendisinden önceki sözcüğe bitişik yazılmaz; ÖSYM bu ekin yanlışlıkla bitişik yazıldığı veya ünlü uyumuna aykırı kullanıldığı cümleleri sıkça tuzak olarak kullanır.

## Pekiştirme Sıfatlarının Yazımı
Sözcüğün ilk hecesi alınıp araya m, p, r, s ünsüzlerinden biri getirilerek yapılan pekiştirmeli sıfatlar bitişik yazılır ve arada tire kullanılmaz: "masmavi, güpgüzel, tertemiz, kapkara, sımsıcak, dosdoğru." Hangi pekiştirme ünsüzünün kullanılacağı sözcüğün son sesine ve söyleyiş geleneğine bağlıdır, bu nedenle bu tür sözcükler genellikle ezbere bilinmesi gereken kalıplardır.

| Sözcük | Pekiştirmeli Biçim | Pekiştirme Ünsüzü |
|---|---|---|
| temiz | tertemiz | r |
| mavi | masmavi | m |
| güzel | güpgüzel | p |
| sıcak | sımsıcak | m |
| doğru | dosdoğru | s |'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1)
  and tc.content_md not like '%## Soru Eki ''mı/mi/mu/mü''nün Yazımı%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?', 'Soru ekinin her zaman ayrı yazıldığını ve ünlü uyumuna uyduğunu bilir.', '"Hazırlandın" sözcüğü kalın bir ünlüyle (ı) bittiği için soru eki de kalın biçimde "mı" olarak ve ayrı yazılmalıdır: "hazırlandın mı?" Diğer seçeneklerde ya bitişik yazım ya da ünlü uyumsuzluğu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu sınava yeterince hazırlandın mı?', true, 3),
  ('Bu sınava yeterince hazırlandınmı?', false, 1),
  ('Bu sınava yeterince hazırlandın mi?', false, 0),
  ('Bu sınava yeterince hazırlandımı?', false, 4),
  ('Bu sınava yeterince hazırlandın-mı?', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?', 'Soru ekinin her zaman ayrı yazıldığını ve ünlü uyumuna uyduğunu bilir.', '"Hazırlandın" sözcüğü kalın bir ünlüyle (ı) bittiği için soru eki de kalın biçimde "mı" olarak ve ayrı yazılmalıdır: "hazırlandın mı?" Diğer seçeneklerde ya bitişik yazım ya da ünlü uyumsuzluğu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu sınava yeterince hazırlandın mı?', true, 3),
  ('Bu sınava yeterince hazırlandınmı?', false, 1),
  ('Bu sınava yeterince hazırlandın mi?', false, 0),
  ('Bu sınava yeterince hazırlandımı?', false, 4),
  ('Bu sınava yeterince hazırlandın-mı?', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?', 'Soru ekinin her zaman ayrı yazıldığını ve ünlü uyumuna uyduğunu bilir.', '"Hazırlandın" sözcüğü kalın bir ünlüyle (ı) bittiği için soru eki de kalın biçimde "mı" olarak ve ayrı yazılmalıdır: "hazırlandın mı?" Diğer seçeneklerde ya bitişik yazım ya da ünlü uyumsuzluğu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde soru eki doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu sınava yeterince hazırlandın mı?', true, 3),
  ('Bu sınava yeterince hazırlandınmı?', false, 1),
  ('Bu sınava yeterince hazırlandın mi?', false, 0),
  ('Bu sınava yeterince hazırlandımı?', false, 4),
  ('Bu sınava yeterince hazırlandın-mı?', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?', 'Pekiştirmeli sıfatların bitişik ve tiresiz yazıldığını uygular.', '"Tertemiz" sözcüğü, "temiz" kelimesinin ilk hecesi alınıp araya pekiştirme ünsüzü "r" getirilerek oluşturulmuş, bitişik ve tire kullanılmadan yazılan doğru bir pekiştirme örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('tertemiz', true, 2),
  ('temtemiz', false, 4),
  ('ter-temiz', false, 1),
  ('tertemizce', false, 0),
  ('tap temiz', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?', 'Pekiştirmeli sıfatların bitişik ve tiresiz yazıldığını uygular.', '"Tertemiz" sözcüğü, "temiz" kelimesinin ilk hecesi alınıp araya pekiştirme ünsüzü "r" getirilerek oluşturulmuş, bitişik ve tire kullanılmadan yazılan doğru bir pekiştirme örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('tertemiz', true, 2),
  ('temtemiz', false, 4),
  ('ter-temiz', false, 1),
  ('tertemizce', false, 0),
  ('tap temiz', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?', 'Pekiştirmeli sıfatların bitişik ve tiresiz yazıldığını uygular.', '"Tertemiz" sözcüğü, "temiz" kelimesinin ilk hecesi alınıp araya pekiştirme ünsüzü "r" getirilerek oluşturulmuş, bitişik ve tire kullanılmadan yazılan doğru bir pekiştirme örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki pekiştirmeli sözcüklerden hangisi doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('tertemiz', true, 2),
  ('temtemiz', false, 4),
  ('ter-temiz', false, 1),
  ('tertemizce', false, 0),
  ('tap temiz', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?', 'Gün adlarının büyük/küçük harf kullanımı kuralını uygular.', '"Pazartesi" sözcüğü burada özel bir gün/etkinlik adı olarak değil, sıradan bir gün adı olarak kullanıldığından küçük harfle "pazartesi" yazılmalıydı; büyük harfle yazılması bir yazım yanlışıdır. Diğer cümlelerde herhangi bir yazım hatası yoktur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Toplantı bu hafta Pazartesi günü yapılacak.', true, 1),
  ('Öğretmenimiz konuyu çok net anlattı.', false, 0),
  ('Kardeşim İstanbul''da üniversite okuyor.', false, 3),
  ('Yarınki sınav için erkenden çalışmaya başladım.', false, 2),
  ('Sen de mi bu maça gideceksin?', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?', 'Gün adlarının büyük/küçük harf kullanımı kuralını uygular.', '"Pazartesi" sözcüğü burada özel bir gün/etkinlik adı olarak değil, sıradan bir gün adı olarak kullanıldığından küçük harfle "pazartesi" yazılmalıydı; büyük harfle yazılması bir yazım yanlışıdır. Diğer cümlelerde herhangi bir yazım hatası yoktur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Toplantı bu hafta Pazartesi günü yapılacak.', true, 1),
  ('Öğretmenimiz konuyu çok net anlattı.', false, 0),
  ('Kardeşim İstanbul''da üniversite okuyor.', false, 3),
  ('Yarınki sınav için erkenden çalışmaya başladım.', false, 2),
  ('Sen de mi bu maça gideceksin?', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?', 'Gün adlarının büyük/küçük harf kullanımı kuralını uygular.', '"Pazartesi" sözcüğü burada özel bir gün/etkinlik adı olarak değil, sıradan bir gün adı olarak kullanıldığından küçük harfle "pazartesi" yazılmalıydı; büyük harfle yazılması bir yazım yanlışıdır. Diğer cümlelerde herhangi bir yazım hatası yoktur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde gün adının büyük/küçük harf kullanımıyla ilgili bir yazım yanlışı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Toplantı bu hafta Pazartesi günü yapılacak.', true, 1),
  ('Öğretmenimiz konuyu çok net anlattı.', false, 0),
  ('Kardeşim İstanbul''da üniversite okuyor.', false, 3),
  ('Yarınki sınav için erkenden çalışmaya başladım.', false, 2),
  ('Sen de mi bu maça gideceksin?', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?', 'Kısaltmalara gelen eklerin okunuşa göre ünlü uyumuna uyduğunu bilir.', '"TBMM" kısaltmasının okunuşundaki son ses "em" ince bir sesle biter, bu nedenle kendisine gelen ek de ince ünlülü olarak "-nin" biçiminde yazılır: "TBMM''nin." Diğer seçeneklerde kısaltmalara gelen eklerde ünlü uyumu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin açılışı her yıl coşkuyla kutlanır.', true, 3),
  ('TBMM''ın açılışı her yıl coşkuyla kutlanır.', false, 0),
  ('ABD''nın başkenti Washington''dır.', false, 2),
  ('TDK''dan aldığım bilgiye göre bu kelime Türkçe kökenlidir.', false, 4),
  ('cm''yı ölçü birimi olarak kullandık.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?', 'Kısaltmalara gelen eklerin okunuşa göre ünlü uyumuna uyduğunu bilir.', '"TBMM" kısaltmasının okunuşundaki son ses "em" ince bir sesle biter, bu nedenle kendisine gelen ek de ince ünlülü olarak "-nin" biçiminde yazılır: "TBMM''nin." Diğer seçeneklerde kısaltmalara gelen eklerde ünlü uyumu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin açılışı her yıl coşkuyla kutlanır.', true, 3),
  ('TBMM''ın açılışı her yıl coşkuyla kutlanır.', false, 0),
  ('ABD''nın başkenti Washington''dır.', false, 2),
  ('TDK''dan aldığım bilgiye göre bu kelime Türkçe kökenlidir.', false, 4),
  ('cm''yı ölçü birimi olarak kullandık.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?', 'Kısaltmalara gelen eklerin okunuşa göre ünlü uyumuna uyduğunu bilir.', '"TBMM" kısaltmasının okunuşundaki son ses "em" ince bir sesle biter, bu nedenle kendisine gelen ek de ince ünlülü olarak "-nin" biçiminde yazılır: "TBMM''nin." Diğer seçeneklerde kısaltmalara gelen eklerde ünlü uyumu hatası vardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde kısaltmaya getirilen ek doğru yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin açılışı her yıl coşkuyla kutlanır.', true, 3),
  ('TBMM''ın açılışı her yıl coşkuyla kutlanır.', false, 0),
  ('ABD''nın başkenti Washington''dır.', false, 2),
  ('TDK''dan aldığım bilgiye göre bu kelime Türkçe kökenlidir.', false, 4),
  ('cm''yı ölçü birimi olarak kullandık.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?', 'Anlam kayması yaşayan kalıcı birleşik sözcükleri ayırt eder.', '"Gülkurusu" bir renk adı olarak kalıcı, kalıplaşmış bir birleşik sözcüktür ve bitişik yazılması gerekir; cümlede "gül kurusu" biçiminde ayrı yazılması bir yazım yanlışıdır. Diğer cümlelerdeki ayrı yazımlar kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bahçedeki gül kurusu renkli çiçekler dikkatimi çekti.', true, 4),
  ('Bu konuda bir aşağı bir yukarı dolaşıp durdu.', false, 1),
  ('Anlaşmazlığı gidermek için iki taraf da masaya oturdu.', false, 2),
  ('Bu proje hakkında bilgi almak istiyorum.', false, 0),
  ('Kardeşim geçen yıl bir hayli başarılı oldu.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?', 'Anlam kayması yaşayan kalıcı birleşik sözcükleri ayırt eder.', '"Gülkurusu" bir renk adı olarak kalıcı, kalıplaşmış bir birleşik sözcüktür ve bitişik yazılması gerekir; cümlede "gül kurusu" biçiminde ayrı yazılması bir yazım yanlışıdır. Diğer cümlelerdeki ayrı yazımlar kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bahçedeki gül kurusu renkli çiçekler dikkatimi çekti.', true, 4),
  ('Bu konuda bir aşağı bir yukarı dolaşıp durdu.', false, 1),
  ('Anlaşmazlığı gidermek için iki taraf da masaya oturdu.', false, 2),
  ('Bu proje hakkında bilgi almak istiyorum.', false, 0),
  ('Kardeşim geçen yıl bir hayli başarılı oldu.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Yazım Kuralları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?', 'Anlam kayması yaşayan kalıcı birleşik sözcükleri ayırt eder.', '"Gülkurusu" bir renk adı olarak kalıcı, kalıplaşmış bir birleşik sözcüktür ve bitişik yazılması gerekir; cümlede "gül kurusu" biçiminde ayrı yazılması bir yazım yanlışıdır. Diğer cümlelerdeki ayrı yazımlar kurala uygundur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde birleşik yazılması gereken bir sözcük yanlışlıkla ayrı yazılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bahçedeki gül kurusu renkli çiçekler dikkatimi çekti.', true, 4),
  ('Bu konuda bir aşağı bir yukarı dolaşıp durdu.', false, 1),
  ('Anlaşmazlığı gidermek için iki taraf da masaya oturdu.', false, 2),
  ('Bu proje hakkında bilgi almak istiyorum.', false, 0),
  ('Kardeşim geçen yıl bir hayli başarılı oldu.', false, 3)
) as v(choice_text, is_correct, order_index);

-- konu: Noktalama İşaretleri (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Parantez / Ayraç ( )
Cümlenin dış yapısına dâhil olmayan ama açıklayıcı ek bilgi taşıyan ifadeler parantez içine alınır: "Yunus Emre (1240-1320), Anadolu''da yaşamış bir halk ozanıdır." Tiyatro metinlerinde kişilerin hareketlerini belirtmek için de parantez kullanılır. Bir cümlede parantez içindeki bilgi çıkarılsa da cümlenin ana yapısı bozulmaz — bu, parantezin ayırt edici özelliğidir; virgülle ayrılan ara sözden farkı, parantez içeriğinin çoğunlukla sayısal/tarihsel ek bilgi niteliğinde olmasıdır.

## Ünlem (!) ve Soru İşaretinin (?) Özel Kullanımları
Ünlem işareti yalnızca sevinç, korku, şaşkınlık gibi güçlü duygu bildiren cümle ve seslenme sözlerinden sonra konur: "Aman, dikkat et!" Bir cümlede soru anlamı, soru eki veya soru sözcüğü olmadan sadece tonlamayla sağlanıyorsa da soru işareti kullanılır: "Sen bunu yaptın, öyle mi?" Söylenişi kesin olmayan tarih veya sayılardan sonra parantez içinde soru işareti kullanılması da bir noktalama inceliğidir: "Yunus Emre (1240 (?)-1320)."'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1)
  and tc.content_md not like '%## Parantez / Ayraç ( )%';

-- konu: Noktalama İşaretleri (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Parantez / Ayraç ( )
Cümlenin dış yapısına dâhil olmayan ama açıklayıcı ek bilgi taşıyan ifadeler parantez içine alınır: "Yunus Emre (1240-1320), Anadolu''da yaşamış bir halk ozanıdır." Tiyatro metinlerinde kişilerin hareketlerini belirtmek için de parantez kullanılır. Bir cümlede parantez içindeki bilgi çıkarılsa da cümlenin ana yapısı bozulmaz — bu, parantezin ayırt edici özelliğidir; virgülle ayrılan ara sözden farkı, parantez içeriğinin çoğunlukla sayısal/tarihsel ek bilgi niteliğinde olmasıdır.

## Ünlem (!) ve Soru İşaretinin (?) Özel Kullanımları
Ünlem işareti yalnızca sevinç, korku, şaşkınlık gibi güçlü duygu bildiren cümle ve seslenme sözlerinden sonra konur: "Aman, dikkat et!" Bir cümlede soru anlamı, soru eki veya soru sözcüğü olmadan sadece tonlamayla sağlanıyorsa da soru işareti kullanılır: "Sen bunu yaptın, öyle mi?" Söylenişi kesin olmayan tarih veya sayılardan sonra parantez içinde soru işareti kullanılması da bir noktalama inceliğidir: "Yunus Emre (1240 (?)-1320)."'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1)
  and tc.content_md not like '%## Parantez / Ayraç ( )%';

-- konu: Noktalama İşaretleri (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Parantez / Ayraç ( )
Cümlenin dış yapısına dâhil olmayan ama açıklayıcı ek bilgi taşıyan ifadeler parantez içine alınır: "Yunus Emre (1240-1320), Anadolu''da yaşamış bir halk ozanıdır." Tiyatro metinlerinde kişilerin hareketlerini belirtmek için de parantez kullanılır. Bir cümlede parantez içindeki bilgi çıkarılsa da cümlenin ana yapısı bozulmaz — bu, parantezin ayırt edici özelliğidir; virgülle ayrılan ara sözden farkı, parantez içeriğinin çoğunlukla sayısal/tarihsel ek bilgi niteliğinde olmasıdır.

## Ünlem (!) ve Soru İşaretinin (?) Özel Kullanımları
Ünlem işareti yalnızca sevinç, korku, şaşkınlık gibi güçlü duygu bildiren cümle ve seslenme sözlerinden sonra konur: "Aman, dikkat et!" Bir cümlede soru anlamı, soru eki veya soru sözcüğü olmadan sadece tonlamayla sağlanıyorsa da soru işareti kullanılır: "Sen bunu yaptın, öyle mi?" Söylenişi kesin olmayan tarih veya sayılardan sonra parantez içinde soru işareti kullanılması da bir noktalama inceliğidir: "Yunus Emre (1240 (?)-1320)."'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1)
  and tc.content_md not like '%## Parantez / Ayraç ( )%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?', 'Parantezin ek bilgi verme işlevini tanır.', 'Mevlana''nın doğum-ölüm tarihleri, cümlenin ana yapısına dâhil olmayan ek bir bilgi olduğu için parantez içinde verilmiştir; bu, parantezin tipik ve doğru kullanım örneğidir. Diğer seçeneklerde parantez gereksiz veya cümlenin anlamını bozacak biçimde kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevlana (1207-1273), tasavvuf edebiyatının en önemli isimlerinden biridir.', true, 0),
  ('Bu kitabı (çok sevdim) arkadaşıma hediye ettim.', false, 1),
  ('(Yarın) erken kalkmam gerekiyor.', false, 3),
  ('Öğretmenimiz (bize) ödev verdi.', false, 4),
  ('Kitabı (dün) okumaya başladım.', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?', 'Parantezin ek bilgi verme işlevini tanır.', 'Mevlana''nın doğum-ölüm tarihleri, cümlenin ana yapısına dâhil olmayan ek bir bilgi olduğu için parantez içinde verilmiştir; bu, parantezin tipik ve doğru kullanım örneğidir. Diğer seçeneklerde parantez gereksiz veya cümlenin anlamını bozacak biçimde kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevlana (1207-1273), tasavvuf edebiyatının en önemli isimlerinden biridir.', true, 0),
  ('Bu kitabı (çok sevdim) arkadaşıma hediye ettim.', false, 1),
  ('(Yarın) erken kalkmam gerekiyor.', false, 3),
  ('Öğretmenimiz (bize) ödev verdi.', false, 4),
  ('Kitabı (dün) okumaya başladım.', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?', 'Parantezin ek bilgi verme işlevini tanır.', 'Mevlana''nın doğum-ölüm tarihleri, cümlenin ana yapısına dâhil olmayan ek bir bilgi olduğu için parantez içinde verilmiştir; bu, parantezin tipik ve doğru kullanım örneğidir. Diğer seçeneklerde parantez gereksiz veya cümlenin anlamını bozacak biçimde kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde parantez ( ) doğru kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevlana (1207-1273), tasavvuf edebiyatının en önemli isimlerinden biridir.', true, 0),
  ('Bu kitabı (çok sevdim) arkadaşıma hediye ettim.', false, 1),
  ('(Yarın) erken kalkmam gerekiyor.', false, 3),
  ('Öğretmenimiz (bize) ödev verdi.', false, 4),
  ('Kitabı (dün) okumaya başladım.', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?', 'Ünlem işaretinin güçlü duygu bildiren cümlelerde kullanıldığını uygular.', '"Aman dikkat et, düşeceksin!" cümlesi tehlike karşısında duyulan güçlü bir kaygı/uyarı duygusu taşıdığı için ünlem işaretiyle bitirilmesi doğrudur. Diğer cümleler sıradan bildirim niteliğinde olduğundan ünlem işaretine ihtiyaç duymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Aman dikkat et, düşeceksin!', true, 1),
  ('Bugün hava çok güzel!', false, 0),
  ('Kitabı masaya bıraktım!', false, 3),
  ('Yarın okula gideceğim!', false, 4),
  ('Bu sorunun cevabını biliyorum!', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?', 'Ünlem işaretinin güçlü duygu bildiren cümlelerde kullanıldığını uygular.', '"Aman dikkat et, düşeceksin!" cümlesi tehlike karşısında duyulan güçlü bir kaygı/uyarı duygusu taşıdığı için ünlem işaretiyle bitirilmesi doğrudur. Diğer cümleler sıradan bildirim niteliğinde olduğundan ünlem işaretine ihtiyaç duymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Aman dikkat et, düşeceksin!', true, 1),
  ('Bugün hava çok güzel!', false, 0),
  ('Kitabı masaya bıraktım!', false, 3),
  ('Yarın okula gideceğim!', false, 4),
  ('Bu sorunun cevabını biliyorum!', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?', 'Ünlem işaretinin güçlü duygu bildiren cümlelerde kullanıldığını uygular.', '"Aman dikkat et, düşeceksin!" cümlesi tehlike karşısında duyulan güçlü bir kaygı/uyarı duygusu taşıdığı için ünlem işaretiyle bitirilmesi doğrudur. Diğer cümleler sıradan bildirim niteliğinde olduğundan ünlem işaretine ihtiyaç duymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ünlem işareti (!) yerinde kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Aman dikkat et, düşeceksin!', true, 1),
  ('Bugün hava çok güzel!', false, 0),
  ('Kitabı masaya bıraktım!', false, 3),
  ('Yarın okula gideceğim!', false, 4),
  ('Bu sorunun cevabını biliyorum!', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?', 'Doğrudan aktarılan sözlerde iki nokta ve tırnak işaretinin birlikte kullanımını uygular.', 'Öğretmenin söylediği söz doğrudan aktarıldığı için önce iki nokta konur, ardından aktarılan söz tırnak içine alınır: "Bugün sınav yapacağız" dedi. Bu, alıntı sözlerin noktalanmasındaki standart kuraldır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('iki nokta (:) — tırnak işareti (" ")', true, 4),
  ('virgül (,) — nokta (.)', false, 3),
  ('noktalı virgül (;) — ünlem (!)', false, 0),
  ('kısa çizgi (-) — soru işareti (?)', false, 1),
  ('parantez (( )) — iki nokta (:)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?', 'Doğrudan aktarılan sözlerde iki nokta ve tırnak işaretinin birlikte kullanımını uygular.', 'Öğretmenin söylediği söz doğrudan aktarıldığı için önce iki nokta konur, ardından aktarılan söz tırnak içine alınır: "Bugün sınav yapacağız" dedi. Bu, alıntı sözlerin noktalanmasındaki standart kuraldır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('iki nokta (:) — tırnak işareti (" ")', true, 4),
  ('virgül (,) — nokta (.)', false, 3),
  ('noktalı virgül (;) — ünlem (!)', false, 0),
  ('kısa çizgi (-) — soru işareti (?)', false, 1),
  ('parantez (( )) — iki nokta (:)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?', 'Doğrudan aktarılan sözlerde iki nokta ve tırnak işaretinin birlikte kullanımını uygular.', 'Öğretmenin söylediği söz doğrudan aktarıldığı için önce iki nokta konur, ardından aktarılan söz tırnak içine alınır: "Bugün sınav yapacağız" dedi. Bu, alıntı sözlerin noktalanmasındaki standart kuraldır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Öğretmen sınıfa girer girmez ___ Bugün sınav yapacağız ___ dedi.'' cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri getirilmelidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('iki nokta (:) — tırnak işareti (" ")', true, 4),
  ('virgül (,) — nokta (.)', false, 3),
  ('noktalı virgül (;) — ünlem (!)', false, 0),
  ('kısa çizgi (-) — soru işareti (?)', false, 1),
  ('parantez (( )) — iki nokta (:)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?', 'Parantez kullanımını tanımından hareketle örnek üzerinde tespit eder.', '"1985 yılında" bilgisi, cümlenin temel yargısını (romanın ilgi görmesini) bozmadan çıkarılabilecek ek bir bilgi olduğu için parantez içine alınabilir; bu, tanımdaki "çıkarıldığında cümlenin bozulmaması" ölçütüne tam olarak uyar. Diğer seçeneklerdeki ifadeler cümlenin ana ögesidir ve bu tanıma uymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Roman, 1985 yılında (ilk baskı tarihi) büyük ilgi görmüştü.', true, 4),
  ('Ben de (gelmek) istiyorum aslında.', false, 2),
  ('Kitabı (okuduğum) için çok mutluyum.', false, 0),
  ('Bu iş (bence) çok zor.', false, 1),
  ('Yarın (erken) kalkacağım.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?', 'Parantez kullanımını tanımından hareketle örnek üzerinde tespit eder.', '"1985 yılında" bilgisi, cümlenin temel yargısını (romanın ilgi görmesini) bozmadan çıkarılabilecek ek bir bilgi olduğu için parantez içine alınabilir; bu, tanımdaki "çıkarıldığında cümlenin bozulmaması" ölçütüne tam olarak uyar. Diğer seçeneklerdeki ifadeler cümlenin ana ögesidir ve bu tanıma uymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Roman, 1985 yılında (ilk baskı tarihi) büyük ilgi görmüştü.', true, 4),
  ('Ben de (gelmek) istiyorum aslında.', false, 2),
  ('Kitabı (okuduğum) için çok mutluyum.', false, 0),
  ('Bu iş (bence) çok zor.', false, 1),
  ('Yarın (erken) kalkacağım.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?', 'Parantez kullanımını tanımından hareketle örnek üzerinde tespit eder.', '"1985 yılında" bilgisi, cümlenin temel yargısını (romanın ilgi görmesini) bozmadan çıkarılabilecek ek bir bilgi olduğu için parantez içine alınabilir; bu, tanımdaki "çıkarıldığında cümlenin bozulmaması" ölçütüne tam olarak uyar. Diğer seçeneklerdeki ifadeler cümlenin ana ögesidir ve bu tanıma uymaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cümle içinde ek bilgi niteliğindeki bir ifade çıkarıldığında cümlenin temel anlamı bozulmuyorsa bu ifade parantez içine alınabilir. Buna göre aşağıdaki cümlelerin hangisinde bu tanıma uygun bir kullanım vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Roman, 1985 yılında (ilk baskı tarihi) büyük ilgi görmüştü.', true, 4),
  ('Ben de (gelmek) istiyorum aslında.', false, 2),
  ('Kitabı (okuduğum) için çok mutluyum.', false, 0),
  ('Bu iş (bence) çok zor.', false, 1),
  ('Yarın (erken) kalkacağım.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?', 'Parantez ve virgülün bir arada kullanımındaki gereksiz noktalama hatalarını ayırt eder.', '"Necip Fazıl (1904-1983) şiirlerinde..." cümlesinde parantez doğru yerde ve gereksiz noktalama işareti kullanılmadan yazılmıştır. Diğer seçeneklerde parantezden önce/sonra gereksiz virgül veya yanlış noktalı virgül kullanılarak noktalama yanlışı yapılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Necip Fazıl (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', true, 0),
  ('Necip Fazıl, (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 3),
  ('Necip Fazıl 1904-1983, şiirlerinde derin bir iç hesaplaşma sergiler.', false, 4),
  ('Necip Fazıl; (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 1),
  ('Necip Fazıl (1904-1983), şiirlerinde derin bir iç hesaplaşma sergiler.', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?', 'Parantez ve virgülün bir arada kullanımındaki gereksiz noktalama hatalarını ayırt eder.', '"Necip Fazıl (1904-1983) şiirlerinde..." cümlesinde parantez doğru yerde ve gereksiz noktalama işareti kullanılmadan yazılmıştır. Diğer seçeneklerde parantezden önce/sonra gereksiz virgül veya yanlış noktalı virgül kullanılarak noktalama yanlışı yapılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Necip Fazıl (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', true, 0),
  ('Necip Fazıl, (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 3),
  ('Necip Fazıl 1904-1983, şiirlerinde derin bir iç hesaplaşma sergiler.', false, 4),
  ('Necip Fazıl; (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 1),
  ('Necip Fazıl (1904-1983), şiirlerinde derin bir iç hesaplaşma sergiler.', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Noktalama İşaretleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?', 'Parantez ve virgülün bir arada kullanımındaki gereksiz noktalama hatalarını ayırt eder.', '"Necip Fazıl (1904-1983) şiirlerinde..." cümlesinde parantez doğru yerde ve gereksiz noktalama işareti kullanılmadan yazılmıştır. Diğer seçeneklerde parantezden önce/sonra gereksiz virgül veya yanlış noktalı virgül kullanılarak noktalama yanlışı yapılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin kullanımıyla ilgili bir yanlışlık yoktur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Necip Fazıl (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', true, 0),
  ('Necip Fazıl, (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 3),
  ('Necip Fazıl 1904-1983, şiirlerinde derin bir iç hesaplaşma sergiler.', false, 4),
  ('Necip Fazıl; (1904-1983) şiirlerinde derin bir iç hesaplaşma sergiler.', false, 1),
  ('Necip Fazıl (1904-1983), şiirlerinde derin bir iç hesaplaşma sergiler.', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: Sözcükte Anlam (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sesteş (Eş Sesli) Sözcükler
Yazılışları ve okunuşları aynı olduğu hâlde anlamları tamamen farklı olan sözcüklere sesteş (eş sesli) denir: "Yüzünde bir gülümseme vardı." (yüz = surat) ile "Nehirde saatlerce yüzdü." (yüz = suda ilerlemek) cümlelerindeki "yüz" sözcükleri birbiriyle anlamca hiçbir ortaklık taşımaz; bu nedenle eş anlamlılıktan farklı olarak sesteşlik, anlam benzerliği değil yalnızca SES benzerliği içerir. Sesteş sözcükler arasında köken bakımından da bir bağ yoktur — bu da onları yan anlamdan ayıran temel özelliktir.

## Genel Anlam - Özel Anlam
Bir sözcük, kapsadığı varlık ya da kavram sayısı bakımından geniş bir alanı işaret ediyorsa genel anlamlı; belirli, sınırlı bir kavramı işaret ediyorsa özel anlamlıdır: "Çiçek" sözcüğü genel anlamlıyken "gül, karanfil, lale" özel anlamlıdır. Bir cümlede sözcükler genelden özele veya özelden genele doğru sıralanarak anlam ilişkisi kurulabilir: "Meyve, sebze ve özellikle elma bu bölgede bol yetişir." cümlesinde "meyve" genel, "elma" özel anlamlıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1)
  and tc.content_md not like '%## Sesteş (Eş Sesli) Sözcükler%';

-- konu: Sözcükte Anlam (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sesteş (Eş Sesli) Sözcükler
Yazılışları ve okunuşları aynı olduğu hâlde anlamları tamamen farklı olan sözcüklere sesteş (eş sesli) denir: "Yüzünde bir gülümseme vardı." (yüz = surat) ile "Nehirde saatlerce yüzdü." (yüz = suda ilerlemek) cümlelerindeki "yüz" sözcükleri birbiriyle anlamca hiçbir ortaklık taşımaz; bu nedenle eş anlamlılıktan farklı olarak sesteşlik, anlam benzerliği değil yalnızca SES benzerliği içerir. Sesteş sözcükler arasında köken bakımından da bir bağ yoktur — bu da onları yan anlamdan ayıran temel özelliktir.

## Genel Anlam - Özel Anlam
Bir sözcük, kapsadığı varlık ya da kavram sayısı bakımından geniş bir alanı işaret ediyorsa genel anlamlı; belirli, sınırlı bir kavramı işaret ediyorsa özel anlamlıdır: "Çiçek" sözcüğü genel anlamlıyken "gül, karanfil, lale" özel anlamlıdır. Bir cümlede sözcükler genelden özele veya özelden genele doğru sıralanarak anlam ilişkisi kurulabilir: "Meyve, sebze ve özellikle elma bu bölgede bol yetişir." cümlesinde "meyve" genel, "elma" özel anlamlıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1)
  and tc.content_md not like '%## Sesteş (Eş Sesli) Sözcükler%';

-- konu: Sözcükte Anlam (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sesteş (Eş Sesli) Sözcükler
Yazılışları ve okunuşları aynı olduğu hâlde anlamları tamamen farklı olan sözcüklere sesteş (eş sesli) denir: "Yüzünde bir gülümseme vardı." (yüz = surat) ile "Nehirde saatlerce yüzdü." (yüz = suda ilerlemek) cümlelerindeki "yüz" sözcükleri birbiriyle anlamca hiçbir ortaklık taşımaz; bu nedenle eş anlamlılıktan farklı olarak sesteşlik, anlam benzerliği değil yalnızca SES benzerliği içerir. Sesteş sözcükler arasında köken bakımından da bir bağ yoktur — bu da onları yan anlamdan ayıran temel özelliktir.

## Genel Anlam - Özel Anlam
Bir sözcük, kapsadığı varlık ya da kavram sayısı bakımından geniş bir alanı işaret ediyorsa genel anlamlı; belirli, sınırlı bir kavramı işaret ediyorsa özel anlamlıdır: "Çiçek" sözcüğü genel anlamlıyken "gül, karanfil, lale" özel anlamlıdır. Bir cümlede sözcükler genelden özele veya özelden genele doğru sıralanarak anlam ilişkisi kurulabilir: "Meyve, sebze ve özellikle elma bu bölgede bol yetişir." cümlesinde "meyve" genel, "elma" özel anlamlıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1)
  and tc.content_md not like '%## Sesteş (Eş Sesli) Sözcükler%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?', 'Sesteş sözcükleri metin içindeki kullanımlarından ayırt eder.', '"Bana kısa bir not yaz" cümlesindeki "yaz" bir eylemi (yazmak) karşılarken diğer üç cümledeki "yaz" mevsim anlamındadır; yazılışı aynı ama anlamı tamamen farklı olduğu için bu bir sesteşlik örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bana kısa bir not yaz, unutmayayım.', true, 0),
  ('Yaz tatilinde deniz kenarına gideceğiz.', false, 2),
  ('Bu yıl yaz çok sıcak geçti.', false, 1),
  ('Yaz aylarında şehir kalabalıklaşır.', false, 4),
  ('Yaz mevsiminin sonunda okullar açılır.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?', 'Sesteş sözcükleri metin içindeki kullanımlarından ayırt eder.', '"Bana kısa bir not yaz" cümlesindeki "yaz" bir eylemi (yazmak) karşılarken diğer üç cümledeki "yaz" mevsim anlamındadır; yazılışı aynı ama anlamı tamamen farklı olduğu için bu bir sesteşlik örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bana kısa bir not yaz, unutmayayım.', true, 0),
  ('Yaz tatilinde deniz kenarına gideceğiz.', false, 2),
  ('Bu yıl yaz çok sıcak geçti.', false, 1),
  ('Yaz aylarında şehir kalabalıklaşır.', false, 4),
  ('Yaz mevsiminin sonunda okullar açılır.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?', 'Sesteş sözcükleri metin içindeki kullanımlarından ayırt eder.', '"Bana kısa bir not yaz" cümlesindeki "yaz" bir eylemi (yazmak) karşılarken diğer üç cümledeki "yaz" mevsim anlamındadır; yazılışı aynı ama anlamı tamamen farklı olduğu için bu bir sesteşlik örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde ''yaz'' sözcüğü, diğer üç cümledekinden farklı bir anlamda (sesteş olarak) kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bana kısa bir not yaz, unutmayayım.', true, 0),
  ('Yaz tatilinde deniz kenarına gideceğiz.', false, 2),
  ('Bu yıl yaz çok sıcak geçti.', false, 1),
  ('Yaz aylarında şehir kalabalıklaşır.', false, 4),
  ('Yaz mevsiminin sonunda okullar açılır.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?', 'Genel anlamlı sözcükle özel anlamlı sözcükler arasındaki ilişkiyi kurar.', '"Meyve" sözcüğü elma, armut, çilek gibi birçok türü kapsayan geniş kapsamlı (genel anlamlı) bir sözcükken diğer üçü onun özel örnekleridir. Diğer seçeneklerde ilk sözcük değil, gruptaki başka bir sözcük genel anlamlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Meyve - elma - armut - çilek', true, 4),
  ('Elma - meyve - armut - çilek', false, 0),
  ('Kırmızı - renk - mavi - sarı', false, 3),
  ('Gül - çiçek - lale - karanfil', false, 1),
  ('Kedi - hayvan - köpek - kuş', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?', 'Genel anlamlı sözcükle özel anlamlı sözcükler arasındaki ilişkiyi kurar.', '"Meyve" sözcüğü elma, armut, çilek gibi birçok türü kapsayan geniş kapsamlı (genel anlamlı) bir sözcükken diğer üçü onun özel örnekleridir. Diğer seçeneklerde ilk sözcük değil, gruptaki başka bir sözcük genel anlamlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Meyve - elma - armut - çilek', true, 4),
  ('Elma - meyve - armut - çilek', false, 0),
  ('Kırmızı - renk - mavi - sarı', false, 3),
  ('Gül - çiçek - lale - karanfil', false, 1),
  ('Kedi - hayvan - köpek - kuş', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?', 'Genel anlamlı sözcükle özel anlamlı sözcükler arasındaki ilişkiyi kurar.', '"Meyve" sözcüğü elma, armut, çilek gibi birçok türü kapsayan geniş kapsamlı (genel anlamlı) bir sözcükken diğer üçü onun özel örnekleridir. Diğer seçeneklerde ilk sözcük değil, gruptaki başka bir sözcük genel anlamlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Kapsamı geniş, birçok varlığı veya kavramı içine alan sözcüklere genel anlamlı sözcük denir. Buna göre aşağıdaki sözcük gruplarının hangisinde ilk sözcük diğerlerine göre genel anlamlıdır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Meyve - elma - armut - çilek', true, 4),
  ('Elma - meyve - armut - çilek', false, 0),
  ('Kırmızı - renk - mavi - sarı', false, 3),
  ('Gül - çiçek - lale - karanfil', false, 1),
  ('Kedi - hayvan - köpek - kuş', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?', 'Yan anlamı, biçim/işlev benzerliği üzerinden gerçek ve mecaz anlamdan ayırt eder.', '"Göz" burada bitkinin sürgün verecek tomurcuk kısmını karşılar; bu, görme organıyla biçim/işlev bakımından kısmi bir benzerlik taşıdığı için yan anlam örneğidir, mecaz anlamdaki gibi tam bir kopuş söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yan anlamda (bitkinin sürgün verecek tomurcuk kısmı)', true, 2),
  ('Gerçek anlamda (görme organı)', false, 3),
  ('Mecaz anlamda (dikkat, itina)', false, 0),
  ('Terim anlamda (fizik terimi)', false, 1),
  ('Sesteş kullanımda', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?', 'Yan anlamı, biçim/işlev benzerliği üzerinden gerçek ve mecaz anlamdan ayırt eder.', '"Göz" burada bitkinin sürgün verecek tomurcuk kısmını karşılar; bu, görme organıyla biçim/işlev bakımından kısmi bir benzerlik taşıdığı için yan anlam örneğidir, mecaz anlamdaki gibi tam bir kopuş söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yan anlamda (bitkinin sürgün verecek tomurcuk kısmı)', true, 2),
  ('Gerçek anlamda (görme organı)', false, 3),
  ('Mecaz anlamda (dikkat, itina)', false, 0),
  ('Terim anlamda (fizik terimi)', false, 1),
  ('Sesteş kullanımda', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?', 'Yan anlamı, biçim/işlev benzerliği üzerinden gerçek ve mecaz anlamdan ayırt eder.', '"Göz" burada bitkinin sürgün verecek tomurcuk kısmını karşılar; bu, görme organıyla biçim/işlev bakımından kısmi bir benzerlik taşıdığı için yan anlam örneğidir, mecaz anlamdaki gibi tam bir kopuş söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bahçıvan, fidanın gözünü dikkatle budadı.'' cümlesindeki ''göz'' sözcüğü hangi anlamda kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yan anlamda (bitkinin sürgün verecek tomurcuk kısmı)', true, 2),
  ('Gerçek anlamda (görme organı)', false, 3),
  ('Mecaz anlamda (dikkat, itina)', false, 0),
  ('Terim anlamda (fizik terimi)', false, 1),
  ('Sesteş kullanımda', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?', 'Atasözünün kalıplaşmış ve öğüt bildiren yapısını deyimden ayırt eder.', '"Damlaya damlaya göl olur." kalıplaşmış, öğüt niteliğinde bir yargı bildiren ve çekime uğramayan bir sözdür; bu özellikleriyle atasözüdür. Diğer seçenekler cümle içinde çekimlenebilen kalıplaşmış söz grupları oldukları için deyimdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damlaya damlaya göl olur.', true, 2),
  ('Kulak asmamak', false, 1),
  ('Dört gözle beklemek', false, 4),
  ('Göz kulak olmak', false, 3),
  ('Kafayı yemek', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?', 'Atasözünün kalıplaşmış ve öğüt bildiren yapısını deyimden ayırt eder.', '"Damlaya damlaya göl olur." kalıplaşmış, öğüt niteliğinde bir yargı bildiren ve çekime uğramayan bir sözdür; bu özellikleriyle atasözüdür. Diğer seçenekler cümle içinde çekimlenebilen kalıplaşmış söz grupları oldukları için deyimdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damlaya damlaya göl olur.', true, 2),
  ('Kulak asmamak', false, 1),
  ('Dört gözle beklemek', false, 4),
  ('Göz kulak olmak', false, 3),
  ('Kafayı yemek', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?', 'Atasözünün kalıplaşmış ve öğüt bildiren yapısını deyimden ayırt eder.', '"Damlaya damlaya göl olur." kalıplaşmış, öğüt niteliğinde bir yargı bildiren ve çekime uğramayan bir sözdür; bu özellikleriyle atasözüdür. Diğer seçenekler cümle içinde çekimlenebilen kalıplaşmış söz grupları oldukları için deyimdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi bir deyim değil, bir atasözüdür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damlaya damlaya göl olur.', true, 2),
  ('Kulak asmamak', false, 1),
  ('Dört gözle beklemek', false, 4),
  ('Göz kulak olmak', false, 3),
  ('Kafayı yemek', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?', 'Aynı sözcüğün farklı cümlelerdeki yan anlam kullanımlarını karşılaştırır.', '"Kapının kanadı" ifadesindeki "kanat", kuşun kanadıyla biçim ve konum bakımından kısmi bir benzerlik taşıyarak yan anlam kazanmıştır; sorudaki "ordunun kanadı" da aynı yan anlam ilişkisiyle kurulmuştur. Diğer seçeneklerde "kanat" ya gerçek ya da mecaz anlamda kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kapının sol kanadı rüzgârdan hızla çarpıp kapandı.', true, 3),
  ('Kartal, kanatlarını açarak gökyüzünde süzülüyordu.', false, 2),
  ('Bu haber onu çok üzdü, kanatları kırılmış gibi hissetti.', false, 1),
  ('Uçağın kanadında küçük bir arıza tespit edildi.', false, 4),
  ('Kelebek kanatlarını yavaşça açtı.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?', 'Aynı sözcüğün farklı cümlelerdeki yan anlam kullanımlarını karşılaştırır.', '"Kapının kanadı" ifadesindeki "kanat", kuşun kanadıyla biçim ve konum bakımından kısmi bir benzerlik taşıyarak yan anlam kazanmıştır; sorudaki "ordunun kanadı" da aynı yan anlam ilişkisiyle kurulmuştur. Diğer seçeneklerde "kanat" ya gerçek ya da mecaz anlamda kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kapının sol kanadı rüzgârdan hızla çarpıp kapandı.', true, 3),
  ('Kartal, kanatlarını açarak gökyüzünde süzülüyordu.', false, 2),
  ('Bu haber onu çok üzdü, kanatları kırılmış gibi hissetti.', false, 1),
  ('Uçağın kanadında küçük bir arıza tespit edildi.', false, 4),
  ('Kelebek kanatlarını yavaşça açtı.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Sözcükte Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?', 'Aynı sözcüğün farklı cümlelerdeki yan anlam kullanımlarını karşılaştırır.', '"Kapının kanadı" ifadesindeki "kanat", kuşun kanadıyla biçim ve konum bakımından kısmi bir benzerlik taşıyarak yan anlam kazanmıştır; sorudaki "ordunun kanadı" da aynı yan anlam ilişkisiyle kurulmuştur. Diğer seçeneklerde "kanat" ya gerçek ya da mecaz anlamda kullanılmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ordunun sağ kanadı düşman hattını yararak ilerledi.'' cümlesindeki ''kanat'' sözcüğüyle aynı anlam özelliğini taşıyan kullanım aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kapının sol kanadı rüzgârdan hızla çarpıp kapandı.', true, 3),
  ('Kartal, kanatlarını açarak gökyüzünde süzülüyordu.', false, 2),
  ('Bu haber onu çok üzdü, kanatları kırılmış gibi hissetti.', false, 1),
  ('Uçağın kanadında küçük bir arıza tespit edildi.', false, 4),
  ('Kelebek kanatlarını yavaşça açtı.', false, 0)
) as v(choice_text, is_correct, order_index);

-- konu: Cümlede Anlam (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler
Bir cümle, bir durumun gerçekleşme ihtimalinden bahsediyor ama kesin bir yargı bildirmiyorsa olasılık cümlesidir: "Bu akşam yağmur yağabilir." Genellikle "-ebilir, galiba, sanırım, belki" gibi sözcük ve eklerle kurulur. Kesinlik bildiren cümlede ise yargı şüpheye yer bırakmayacak biçimde kesin ifade edilir: "Su, 0 derecede donar." Bu iki cümle türü arasındaki fark, ÖSYM''nin sıkça "bu cümle kesinlik mi olasılık mı bildirir" sorusuyla test ettiği bir ayrımdır.

## Beklenti (Umulanın Aksi) İlişkisi
Bir cümlede, beklenen bir sonucun gerçekleşmediği veya beklentinin tam tersinin ortaya çıktığı anlatılıyorsa bu, beklenti (karşıtlık) ilişkisi taşıyan bir cümledir: "Çok çalıştı ama sınavı geçemedi." Bu ilişki genellikle "ama, fakat, oysa, ancak, buna rağmen" gibi bağlaçlarla kurulur ve cümlede iki yargı arasında ters bir orantı bulunur. Neden-sonuç ilişkisinden farkı, burada yargılar arasında beklenen bir uyum değil, beklenmeyen bir çelişki söz konusudur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1)
  and tc.content_md not like '%## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler%';

-- konu: Cümlede Anlam (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler
Bir cümle, bir durumun gerçekleşme ihtimalinden bahsediyor ama kesin bir yargı bildirmiyorsa olasılık cümlesidir: "Bu akşam yağmur yağabilir." Genellikle "-ebilir, galiba, sanırım, belki" gibi sözcük ve eklerle kurulur. Kesinlik bildiren cümlede ise yargı şüpheye yer bırakmayacak biçimde kesin ifade edilir: "Su, 0 derecede donar." Bu iki cümle türü arasındaki fark, ÖSYM''nin sıkça "bu cümle kesinlik mi olasılık mı bildirir" sorusuyla test ettiği bir ayrımdır.

## Beklenti (Umulanın Aksi) İlişkisi
Bir cümlede, beklenen bir sonucun gerçekleşmediği veya beklentinin tam tersinin ortaya çıktığı anlatılıyorsa bu, beklenti (karşıtlık) ilişkisi taşıyan bir cümledir: "Çok çalıştı ama sınavı geçemedi." Bu ilişki genellikle "ama, fakat, oysa, ancak, buna rağmen" gibi bağlaçlarla kurulur ve cümlede iki yargı arasında ters bir orantı bulunur. Neden-sonuç ilişkisinden farkı, burada yargılar arasında beklenen bir uyum değil, beklenmeyen bir çelişki söz konusudur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1)
  and tc.content_md not like '%## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler%';

-- konu: Cümlede Anlam (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler
Bir cümle, bir durumun gerçekleşme ihtimalinden bahsediyor ama kesin bir yargı bildirmiyorsa olasılık cümlesidir: "Bu akşam yağmur yağabilir." Genellikle "-ebilir, galiba, sanırım, belki" gibi sözcük ve eklerle kurulur. Kesinlik bildiren cümlede ise yargı şüpheye yer bırakmayacak biçimde kesin ifade edilir: "Su, 0 derecede donar." Bu iki cümle türü arasındaki fark, ÖSYM''nin sıkça "bu cümle kesinlik mi olasılık mı bildirir" sorusuyla test ettiği bir ayrımdır.

## Beklenti (Umulanın Aksi) İlişkisi
Bir cümlede, beklenen bir sonucun gerçekleşmediği veya beklentinin tam tersinin ortaya çıktığı anlatılıyorsa bu, beklenti (karşıtlık) ilişkisi taşıyan bir cümledir: "Çok çalıştı ama sınavı geçemedi." Bu ilişki genellikle "ama, fakat, oysa, ancak, buna rağmen" gibi bağlaçlarla kurulur ve cümlede iki yargı arasında ters bir orantı bulunur. Neden-sonuç ilişkisinden farkı, burada yargılar arasında beklenen bir uyum değil, beklenmeyen bir çelişki söz konusudur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1)
  and tc.content_md not like '%## Olasılık (İhtimal) ve Kesinlik Bildiren Cümleler%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?', 'Olasılık bildiren cümleleri kesinlik bildiren cümlelerden ayırt eder.', '"Serinleyebilir" ifadesindeki "-ebilir" eki kesin olmayan bir ihtimali bildirdiği için bu cümle olasılık cümlesidir. Diğer seçenekler ise kanıtlanabilir, kesin bilgiler içerir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu akşam hava biraz serinleyebilir.', true, 4),
  ('Su, deniz seviyesinde 100 derecede kaynar.', false, 0),
  ('Ankara, Türkiye''nin başkentidir.', false, 2),
  ('Bu kitap 1985 yılında yayımlanmıştır.', false, 3),
  ('Dünya, Güneş''in etrafında döner.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?', 'Olasılık bildiren cümleleri kesinlik bildiren cümlelerden ayırt eder.', '"Serinleyebilir" ifadesindeki "-ebilir" eki kesin olmayan bir ihtimali bildirdiği için bu cümle olasılık cümlesidir. Diğer seçenekler ise kanıtlanabilir, kesin bilgiler içerir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu akşam hava biraz serinleyebilir.', true, 4),
  ('Su, deniz seviyesinde 100 derecede kaynar.', false, 0),
  ('Ankara, Türkiye''nin başkentidir.', false, 2),
  ('Bu kitap 1985 yılında yayımlanmıştır.', false, 3),
  ('Dünya, Güneş''in etrafında döner.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?', 'Olasılık bildiren cümleleri kesinlik bildiren cümlelerden ayırt eder.', '"Serinleyebilir" ifadesindeki "-ebilir" eki kesin olmayan bir ihtimali bildirdiği için bu cümle olasılık cümlesidir. Diğer seçenekler ise kanıtlanabilir, kesin bilgiler içerir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisi bir olasılık (ihtimal) bildirmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bu akşam hava biraz serinleyebilir.', true, 4),
  ('Su, deniz seviyesinde 100 derecede kaynar.', false, 0),
  ('Ankara, Türkiye''nin başkentidir.', false, 2),
  ('Bu kitap 1985 yılında yayımlanmıştır.', false, 3),
  ('Dünya, Güneş''in etrafında döner.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?', 'Kesinlik bildiren cümleyi olasılık ifadelerinden ayırt eder.', '"Demir, suya göre daha yoğun bir maddedir." bilimsel ve değişmez bir gerçeği kesin bir dille ifade eder. Diğer seçeneklerdeki "sanırım, belki, galiba" gibi ifadeler cümleye kesinlik değil olasılık anlamı katar.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Demir, suya göre daha yoğun bir maddedir.', true, 4),
  ('Sanırım yarın işe geç kalacağım.', false, 3),
  ('Belki bu proje zamanında bitmez.', false, 1),
  ('Galiba bu sınavı kazanamayacağım.', false, 2),
  ('Belki de haklısın, düşünmem lazım.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?', 'Kesinlik bildiren cümleyi olasılık ifadelerinden ayırt eder.', '"Demir, suya göre daha yoğun bir maddedir." bilimsel ve değişmez bir gerçeği kesin bir dille ifade eder. Diğer seçeneklerdeki "sanırım, belki, galiba" gibi ifadeler cümleye kesinlik değil olasılık anlamı katar.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Demir, suya göre daha yoğun bir maddedir.', true, 4),
  ('Sanırım yarın işe geç kalacağım.', false, 3),
  ('Belki bu proje zamanında bitmez.', false, 1),
  ('Galiba bu sınavı kazanamayacağım.', false, 2),
  ('Belki de haklısın, düşünmem lazım.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?', 'Kesinlik bildiren cümleyi olasılık ifadelerinden ayırt eder.', '"Demir, suya göre daha yoğun bir maddedir." bilimsel ve değişmez bir gerçeği kesin bir dille ifade eder. Diğer seçeneklerdeki "sanırım, belki, galiba" gibi ifadeler cümleye kesinlik değil olasılık anlamı katar.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerden hangisinde kesinlik bildiren bir yargı vardır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Demir, suya göre daha yoğun bir maddedir.', true, 4),
  ('Sanırım yarın işe geç kalacağım.', false, 3),
  ('Belki bu proje zamanında bitmez.', false, 1),
  ('Galiba bu sınavı kazanamayacağım.', false, 2),
  ('Belki de haklısın, düşünmem lazım.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?', 'Beklenti (umulanın aksi) ilişkisini bağlaçlar üzerinden tespit eder.', 'Cümlede kişinin büyük çaba göstermesine rağmen beklediği sonucu alamaması anlatılmaktadır; "buna rağmen" bağlacı da bu ters orantıyı açıkça vurgular. Bu, beklenti (umulanın aksi) ilişkisine örnektir; neden-sonuç ilişkisinde olduğu gibi beklenen bir sonuç ortaya çıkmamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi/karşıtlık) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 4),
  ('Amaç-sonuç ilişkisi', false, 1),
  ('Koşul ilişkisi', false, 0),
  ('Karşılaştırma ilişkisi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?', 'Beklenti (umulanın aksi) ilişkisini bağlaçlar üzerinden tespit eder.', 'Cümlede kişinin büyük çaba göstermesine rağmen beklediği sonucu alamaması anlatılmaktadır; "buna rağmen" bağlacı da bu ters orantıyı açıkça vurgular. Bu, beklenti (umulanın aksi) ilişkisine örnektir; neden-sonuç ilişkisinde olduğu gibi beklenen bir sonuç ortaya çıkmamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi/karşıtlık) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 4),
  ('Amaç-sonuç ilişkisi', false, 1),
  ('Koşul ilişkisi', false, 0),
  ('Karşılaştırma ilişkisi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?', 'Beklenti (umulanın aksi) ilişkisini bağlaçlar üzerinden tespit eder.', 'Cümlede kişinin büyük çaba göstermesine rağmen beklediği sonucu alamaması anlatılmaktadır; "buna rağmen" bağlacı da bu ters orantıyı açıkça vurgular. Bu, beklenti (umulanın aksi) ilişkisine örnektir; neden-sonuç ilişkisinde olduğu gibi beklenen bir sonuç ortaya çıkmamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Uzun süre antrenman yaptı, hatta diyetine bile çok dikkat etti; buna rağmen yarışmada beklediği dereceyi alamadı.'' cümlesinde hangi anlam ilişkisi söz konusudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi/karşıtlık) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 4),
  ('Amaç-sonuç ilişkisi', false, 1),
  ('Koşul ilişkisi', false, 0),
  ('Karşılaştırma ilişkisi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?', 'Koşul cümlesini tanımından hareketle örnek üzerinde tespit eder.', '"Erken kalkarsan işe yetişebilirsin" cümlesinde bir yargının (işe yetişme) gerçekleşmesi başka bir yargının (erken kalkma) gerçekleşmesine bağlanmıştır; bu da tam olarak koşul cümlesi tanımına uyar. Diğer seçenekler neden-sonuç, amaç veya beklenti ilişkisi taşır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erken kalkarsan trafiğe takılmadan işe yetişebilirsin.', true, 2),
  ('Erken kalktığı için trafiğe takılmadan işe yetişti.', false, 0),
  ('İşe yetişmek için erken kalktı.', false, 1),
  ('Erken kalktı ama yine de trafiğe takıldı.', false, 3),
  ('Erken kalkması, trafiğe takılmasından daha önemliydi.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?', 'Koşul cümlesini tanımından hareketle örnek üzerinde tespit eder.', '"Erken kalkarsan işe yetişebilirsin" cümlesinde bir yargının (işe yetişme) gerçekleşmesi başka bir yargının (erken kalkma) gerçekleşmesine bağlanmıştır; bu da tam olarak koşul cümlesi tanımına uyar. Diğer seçenekler neden-sonuç, amaç veya beklenti ilişkisi taşır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erken kalkarsan trafiğe takılmadan işe yetişebilirsin.', true, 2),
  ('Erken kalktığı için trafiğe takılmadan işe yetişti.', false, 0),
  ('İşe yetişmek için erken kalktı.', false, 1),
  ('Erken kalktı ama yine de trafiğe takıldı.', false, 3),
  ('Erken kalkması, trafiğe takılmasından daha önemliydi.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?', 'Koşul cümlesini tanımından hareketle örnek üzerinde tespit eder.', '"Erken kalkarsan işe yetişebilirsin" cümlesinde bir yargının (işe yetişme) gerçekleşmesi başka bir yargının (erken kalkma) gerçekleşmesine bağlanmıştır; bu da tam olarak koşul cümlesi tanımına uyar. Diğer seçenekler neden-sonuç, amaç veya beklenti ilişkisi taşır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir yargının gerçekleşmesi başka bir yargının gerçekleşmesine bağlıysa buna koşul (şart) cümlesi denir. Buna göre aşağıdaki cümlelerin hangisi bu tanıma örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erken kalkarsan trafiğe takılmadan işe yetişebilirsin.', true, 2),
  ('Erken kalktığı için trafiğe takılmadan işe yetişti.', false, 0),
  ('İşe yetişmek için erken kalktı.', false, 1),
  ('Erken kalktı ama yine de trafiğe takıldı.', false, 3),
  ('Erken kalkması, trafiğe takılmasından daha önemliydi.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?', 'Açık bir karşıtlık bağlacı olmadan da beklenti ilişkisini metinden çıkarır.', 'Cümlede çalışmayan kardeşin daha yüksek puan alması, olağan beklentinin (çok çalışanın daha başarılı olması) tam tersi bir durumu anlattığı için beklenti (umulanın aksi) ilişkisi söz konusudur; burada açık bir "ama/fakat" bağlacı olmasa da "ilginçtir ki" ifadesi bu karşıtlığı sezdirir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 3),
  ('Amaç-sonuç ilişkisi', false, 4),
  ('Koşul ilişkisi', false, 0),
  ('Öznel yargı bildirme', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?', 'Açık bir karşıtlık bağlacı olmadan da beklenti ilişkisini metinden çıkarır.', 'Cümlede çalışmayan kardeşin daha yüksek puan alması, olağan beklentinin (çok çalışanın daha başarılı olması) tam tersi bir durumu anlattığı için beklenti (umulanın aksi) ilişkisi söz konusudur; burada açık bir "ama/fakat" bağlacı olmasa da "ilginçtir ki" ifadesi bu karşıtlığı sezdirir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 3),
  ('Amaç-sonuç ilişkisi', false, 4),
  ('Koşul ilişkisi', false, 0),
  ('Öznel yargı bildirme', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Cümlede Anlam' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?', 'Açık bir karşıtlık bağlacı olmadan da beklenti ilişkisini metinden çıkarır.', 'Cümlede çalışmayan kardeşin daha yüksek puan alması, olağan beklentinin (çok çalışanın daha başarılı olması) tam tersi bir durumu anlattığı için beklenti (umulanın aksi) ilişkisi söz konusudur; burada açık bir "ama/fakat" bağlacı olmasa da "ilginçtir ki" ifadesi bu karşıtlığı sezdirir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''İki kardeşten biri sınava son ana kadar çalışırken diğeri hiç çalışmadı; ilginçtir ki çalışmayan kardeş daha yüksek puan aldı.'' Bu cümlede vurgulanan temel anlam ilişkisi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Beklenti (umulanın aksi) ilişkisi', true, 2),
  ('Neden-sonuç ilişkisi', false, 3),
  ('Amaç-sonuç ilişkisi', false, 4),
  ('Koşul ilişkisi', false, 0),
  ('Öznel yargı bildirme', false, 1)
) as v(choice_text, is_correct, order_index);

-- konu: Paragraf (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Düşünceyi Geliştirme Yolları
Bir paragrafta yazar, ana düşüncesini okura kanıtlamak veya inandırmak için çeşitli düşünceyi geliştirme yollarına başvurur. Tanımlama, bir kavramın "nedir" sorusuna cevap vererek açıklanmasıdır. Örnekleme, soyut bir yargıyı somut bir örnekle desteklemektir. Karşılaştırma, iki kavram veya durum arasındaki benzerlik/farkın ortaya konmasıdır. Tanık gösterme, konuyla ilgili alanında otorite kabul edilen bir kişinin sözüne başvurmaktır. Sayısal verilerden yararlanma ise istatistik, yüzde veya rakamlarla yargıyı somutlaştırmaktır. Bir paragrafta genellikle birden fazla düşünceyi geliştirme yolu bir arada kullanılabilir; ÖSYM bu yolları paragraftan ayırt etmeyi sıkça sorar.

## Paragrafın Giriş-Gelişme-Sonuç Yapısı
Uzun bir metin giriş, gelişme ve sonuç paragraflarından oluşur. Giriş paragrafı konuyu tanıtır ve okurun dikkatini çeker; genellikle ana düşünceye dair bir ipucu barındırır ama ana düşünceyi tam olarak açıklamaz. Gelişme paragrafı/paragrafları, konuyu örnekler, kanıtlar ve ayrıntılarla derinleştirir. Sonuç paragrafı ise anlatılanları özetler veya bir yargıya bağlar; genellikle "sonuç olarak, kısacası, özetle, bu nedenle" gibi bağlayıcı ifadelerle başlar. Bir paragrafın metnin giriş, gelişme ya da sonuç bölümüne ait olup olmadığı, kullanılan bağlayıcı sözcüklerden ve verdiği bilginin niteliğinden (tanıtıcı mı, ayrıntılandırıcı mı, özetleyici mi) anlaşılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1)
  and tc.content_md not like '%## Düşünceyi Geliştirme Yolları%';

-- konu: Paragraf (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Düşünceyi Geliştirme Yolları
Bir paragrafta yazar, ana düşüncesini okura kanıtlamak veya inandırmak için çeşitli düşünceyi geliştirme yollarına başvurur. Tanımlama, bir kavramın "nedir" sorusuna cevap vererek açıklanmasıdır. Örnekleme, soyut bir yargıyı somut bir örnekle desteklemektir. Karşılaştırma, iki kavram veya durum arasındaki benzerlik/farkın ortaya konmasıdır. Tanık gösterme, konuyla ilgili alanında otorite kabul edilen bir kişinin sözüne başvurmaktır. Sayısal verilerden yararlanma ise istatistik, yüzde veya rakamlarla yargıyı somutlaştırmaktır. Bir paragrafta genellikle birden fazla düşünceyi geliştirme yolu bir arada kullanılabilir; ÖSYM bu yolları paragraftan ayırt etmeyi sıkça sorar.

## Paragrafın Giriş-Gelişme-Sonuç Yapısı
Uzun bir metin giriş, gelişme ve sonuç paragraflarından oluşur. Giriş paragrafı konuyu tanıtır ve okurun dikkatini çeker; genellikle ana düşünceye dair bir ipucu barındırır ama ana düşünceyi tam olarak açıklamaz. Gelişme paragrafı/paragrafları, konuyu örnekler, kanıtlar ve ayrıntılarla derinleştirir. Sonuç paragrafı ise anlatılanları özetler veya bir yargıya bağlar; genellikle "sonuç olarak, kısacası, özetle, bu nedenle" gibi bağlayıcı ifadelerle başlar. Bir paragrafın metnin giriş, gelişme ya da sonuç bölümüne ait olup olmadığı, kullanılan bağlayıcı sözcüklerden ve verdiği bilginin niteliğinden (tanıtıcı mı, ayrıntılandırıcı mı, özetleyici mi) anlaşılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1)
  and tc.content_md not like '%## Düşünceyi Geliştirme Yolları%';

-- konu: Paragraf (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Düşünceyi Geliştirme Yolları
Bir paragrafta yazar, ana düşüncesini okura kanıtlamak veya inandırmak için çeşitli düşünceyi geliştirme yollarına başvurur. Tanımlama, bir kavramın "nedir" sorusuna cevap vererek açıklanmasıdır. Örnekleme, soyut bir yargıyı somut bir örnekle desteklemektir. Karşılaştırma, iki kavram veya durum arasındaki benzerlik/farkın ortaya konmasıdır. Tanık gösterme, konuyla ilgili alanında otorite kabul edilen bir kişinin sözüne başvurmaktır. Sayısal verilerden yararlanma ise istatistik, yüzde veya rakamlarla yargıyı somutlaştırmaktır. Bir paragrafta genellikle birden fazla düşünceyi geliştirme yolu bir arada kullanılabilir; ÖSYM bu yolları paragraftan ayırt etmeyi sıkça sorar.

## Paragrafın Giriş-Gelişme-Sonuç Yapısı
Uzun bir metin giriş, gelişme ve sonuç paragraflarından oluşur. Giriş paragrafı konuyu tanıtır ve okurun dikkatini çeker; genellikle ana düşünceye dair bir ipucu barındırır ama ana düşünceyi tam olarak açıklamaz. Gelişme paragrafı/paragrafları, konuyu örnekler, kanıtlar ve ayrıntılarla derinleştirir. Sonuç paragrafı ise anlatılanları özetler veya bir yargıya bağlar; genellikle "sonuç olarak, kısacası, özetle, bu nedenle" gibi bağlayıcı ifadelerle başlar. Bir paragrafın metnin giriş, gelişme ya da sonuç bölümüne ait olup olmadığı, kullanılan bağlayıcı sözcüklerden ve verdiği bilginin niteliğinden (tanıtıcı mı, ayrıntılandırıcı mı, özetleyici mi) anlaşılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1)
  and tc.content_md not like '%## Düşünceyi Geliştirme Yolları%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?', 'Tanık gösterme yoluyla düşünceyi geliştirme tekniğini tanır.', 'Cümlede Einstein gibi alanında otorite kabul edilen bir kişinin sözüne başvurularak yargı desteklenmiştir; bu, tanık gösterme yoluyla düşünceyi geliştirmenin tipik bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tanık gösterme', true, 4),
  ('Örnekleme', false, 2),
  ('Karşılaştırma', false, 0),
  ('Sayısal verilerden yararlanma', false, 3),
  ('Tanımlama', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?', 'Tanık gösterme yoluyla düşünceyi geliştirme tekniğini tanır.', 'Cümlede Einstein gibi alanında otorite kabul edilen bir kişinin sözüne başvurularak yargı desteklenmiştir; bu, tanık gösterme yoluyla düşünceyi geliştirmenin tipik bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tanık gösterme', true, 4),
  ('Örnekleme', false, 2),
  ('Karşılaştırma', false, 0),
  ('Sayısal verilerden yararlanma', false, 3),
  ('Tanımlama', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?', 'Tanık gösterme yoluyla düşünceyi geliştirme tekniğini tanır.', 'Cümlede Einstein gibi alanında otorite kabul edilen bir kişinin sözüne başvurularak yargı desteklenmiştir; bu, tanık gösterme yoluyla düşünceyi geliştirmenin tipik bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Ünlü bilim insanı Einstein''ın da belirttiği gibi, hayal gücü bilgiden daha önemlidir.'' cümlesinde hangi düşünceyi geliştirme yolu kullanılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tanık gösterme', true, 4),
  ('Örnekleme', false, 2),
  ('Karşılaştırma', false, 0),
  ('Sayısal verilerden yararlanma', false, 3),
  ('Tanımlama', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?', 'Giriş ve sonuç paragraflarına özgü bağlayıcı ifadeleri ayırt eder.', '"Öncelikle şunu belirtmek gerekir ki" ifadesi bir konuyu yeni tanıtmaya, yani giriş paragrafına uygun bir bağlayıcıdır; "sonuç olarak, kısacası, özetle, bütün bunlardan yola çıkarak" gibi ifadeler ise toparlayıcı nitelikleriyle sonuç paragrafında kullanılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Öncelikle şunu belirtmek gerekir ki', true, 0),
  ('Sonuç olarak', false, 1),
  ('Kısacası', false, 3),
  ('Özetle', false, 4),
  ('Bütün bunlardan yola çıkarak', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?', 'Giriş ve sonuç paragraflarına özgü bağlayıcı ifadeleri ayırt eder.', '"Öncelikle şunu belirtmek gerekir ki" ifadesi bir konuyu yeni tanıtmaya, yani giriş paragrafına uygun bir bağlayıcıdır; "sonuç olarak, kısacası, özetle, bütün bunlardan yola çıkarak" gibi ifadeler ise toparlayıcı nitelikleriyle sonuç paragrafında kullanılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Öncelikle şunu belirtmek gerekir ki', true, 0),
  ('Sonuç olarak', false, 1),
  ('Kısacası', false, 3),
  ('Özetle', false, 4),
  ('Bütün bunlardan yola çıkarak', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?', 'Giriş ve sonuç paragraflarına özgü bağlayıcı ifadeleri ayırt eder.', '"Öncelikle şunu belirtmek gerekir ki" ifadesi bir konuyu yeni tanıtmaya, yani giriş paragrafına uygun bir bağlayıcıdır; "sonuç olarak, kısacası, özetle, bütün bunlardan yola çıkarak" gibi ifadeler ise toparlayıcı nitelikleriyle sonuç paragrafında kullanılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki ifadelerden hangisi bir metnin sonuç paragrafında kullanılması beklenen bir bağlayıcı değildir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Öncelikle şunu belirtmek gerekir ki', true, 0),
  ('Sonuç olarak', false, 1),
  ('Kısacası', false, 3),
  ('Özetle', false, 4),
  ('Bütün bunlardan yola çıkarak', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?', 'Sayısal verilerden yararlanma tekniğini örnek üzerinde tespit eder.', 'Cümlede yenilenebilir enerji yatırımlarındaki artış "%40" gibi somut bir rakamla ifade edilmiştir; bu, sayısal verilerden yararlanma yoluyla düşünceyi geliştirmenin açık bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sayısal verilerden yararlanma', true, 0),
  ('Tanık gösterme', false, 3),
  ('Tanımlama', false, 4),
  ('Örnekleme', false, 1),
  ('Karşılaştırma', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?', 'Sayısal verilerden yararlanma tekniğini örnek üzerinde tespit eder.', 'Cümlede yenilenebilir enerji yatırımlarındaki artış "%40" gibi somut bir rakamla ifade edilmiştir; bu, sayısal verilerden yararlanma yoluyla düşünceyi geliştirmenin açık bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sayısal verilerden yararlanma', true, 0),
  ('Tanık gösterme', false, 3),
  ('Tanımlama', false, 4),
  ('Örnekleme', false, 1),
  ('Karşılaştırma', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?', 'Sayısal verilerden yararlanma tekniğini örnek üzerinde tespit eder.', 'Cümlede yenilenebilir enerji yatırımlarındaki artış "%40" gibi somut bir rakamla ifade edilmiştir; bu, sayısal verilerden yararlanma yoluyla düşünceyi geliştirmenin açık bir örneğidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Türkiye''de son on yılda yenilenebilir enerji yatırımları %40 oranında artmıştır.'' cümlesinde ana düşünce hangi düşünceyi geliştirme yoluyla desteklenmektedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sayısal verilerden yararlanma', true, 0),
  ('Tanık gösterme', false, 3),
  ('Tanımlama', false, 4),
  ('Örnekleme', false, 1),
  ('Karşılaştırma', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?', 'Giriş paragrafının işlevini gelişme paragrafından ayırt eder.', 'Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işlemek gelişme paragrafının işlevidir; giriş paragrafı konuyu tanıtır ve dikkat çeker ama henüz ayrıntıya girmez. Diğer seçenekler giriş paragrafının doğru özellikleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işler.', true, 0),
  ('Okurun ilgisini çekecek bir üslupla konuyu tanıtır.', false, 4),
  ('Ana düşünceye dair bir ipucu verebilir ama konuyu tam açmaz.', false, 2),
  ('Metnin genel çerçevesini belirler.', false, 3),
  ('Kısa ve dikkat çekici olabilir.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?', 'Giriş paragrafının işlevini gelişme paragrafından ayırt eder.', 'Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işlemek gelişme paragrafının işlevidir; giriş paragrafı konuyu tanıtır ve dikkat çeker ama henüz ayrıntıya girmez. Diğer seçenekler giriş paragrafının doğru özellikleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işler.', true, 0),
  ('Okurun ilgisini çekecek bir üslupla konuyu tanıtır.', false, 4),
  ('Ana düşünceye dair bir ipucu verebilir ama konuyu tam açmaz.', false, 2),
  ('Metnin genel çerçevesini belirler.', false, 3),
  ('Kısa ve dikkat çekici olabilir.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?', 'Giriş paragrafının işlevini gelişme paragrafından ayırt eder.', 'Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işlemek gelişme paragrafının işlevidir; giriş paragrafı konuyu tanıtır ve dikkat çeker ama henüz ayrıntıya girmez. Diğer seçenekler giriş paragrafının doğru özellikleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir metnin giriş paragrafı için aşağıdaki özelliklerden hangisi söylenemez?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Konuyu ayrıntılı örnek ve kanıtlarla derinlemesine işler.', true, 0),
  ('Okurun ilgisini çekecek bir üslupla konuyu tanıtır.', false, 4),
  ('Ana düşünceye dair bir ipucu verebilir ama konuyu tam açmaz.', false, 2),
  ('Metnin genel çerçevesini belirler.', false, 3),
  ('Kısa ve dikkat çekici olabilir.', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?', 'Bir paragraftaki sonuç cümlesini işlevi bakımından diğer cümlelerden ayırt eder.', 'Son cümle "sonuç olarak" bağlacıyla başlayarak önceki cümlelerde anlatılan bilgileri genel bir yargıda toplamaktadır; bu, klasik bir sonuç cümlesi işlevidir ve metnin akışını bozmaz, konuyu ilk kez tanıtmaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Önceki cümlelerde anlatılanları genel bir yargıyla toparlayan sonuç cümlesi olma', true, 3),
  ('Konuyu ilk kez okura tanıtan giriş cümlesi olma', false, 0),
  ('Ana düşünceyi örnekle somutlaştıran cümle olma', false, 4),
  ('Karşıt bir görüşü ortaya koyan cümle olma', false, 1),
  ('Konudan sapan, akışı bozan cümle olma', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?', 'Bir paragraftaki sonuç cümlesini işlevi bakımından diğer cümlelerden ayırt eder.', 'Son cümle "sonuç olarak" bağlacıyla başlayarak önceki cümlelerde anlatılan bilgileri genel bir yargıda toplamaktadır; bu, klasik bir sonuç cümlesi işlevidir ve metnin akışını bozmaz, konuyu ilk kez tanıtmaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Önceki cümlelerde anlatılanları genel bir yargıyla toparlayan sonuç cümlesi olma', true, 3),
  ('Konuyu ilk kez okura tanıtan giriş cümlesi olma', false, 0),
  ('Ana düşünceyi örnekle somutlaştıran cümle olma', false, 4),
  ('Karşıt bir görüşü ortaya koyan cümle olma', false, 1),
  ('Konudan sapan, akışı bozan cümle olma', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Paragraf' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?', 'Bir paragraftaki sonuç cümlesini işlevi bakımından diğer cümlelerden ayırt eder.', 'Son cümle "sonuç olarak" bağlacıyla başlayarak önceki cümlelerde anlatılan bilgileri genel bir yargıda toplamaktadır; bu, klasik bir sonuç cümlesi işlevidir ve metnin akışını bozmaz, konuyu ilk kez tanıtmaz.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Şehir içi ulaşımda toplu taşımanın payının artırılması, hem trafik yoğunluğunu azaltır hem de karbon salımını düşürür. Bisiklet yollarının yaygınlaştırılması da bu amaca katkı sağlar. Sonuç olarak, sürdürülebilir bir kent ulaşımı için toplu taşıma ve alternatif ulaşım yöntemlerine yatırım kaçınılmazdır.'' Bu parçadaki son cümlenin metindeki işlevi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Önceki cümlelerde anlatılanları genel bir yargıyla toparlayan sonuç cümlesi olma', true, 3),
  ('Konuyu ilk kez okura tanıtan giriş cümlesi olma', false, 0),
  ('Ana düşünceyi örnekle somutlaştıran cümle olma', false, 4),
  ('Karşıt bir görüşü ortaya koyan cümle olma', false, 1),
  ('Konudan sapan, akışı bozan cümle olma', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: Anlatım Bozuklukları (Türkçe / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Nesne / Tümleç Düşüklüğü
Bir cümlede yükleme bağlı olması gereken nesne, dolaylı tümleç veya zarf tümleci eksik bırakıldığında anlatım bozukluğu oluşur: ''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesinde ''geliştirilmeli'' fiilinin nesnesi belirtilmemiştir (neyin geliştirileceği belirsizdir); doğrusu ''Bu projeye hem daha fazla emek verilmeli hem de büyük bir bütçe ayrılmalı.'' gibi düzeltilmelidir. Bu hata, özellikle sıralı fiillerin ortak bir tümleci paylaştığı ama bu tümlecin her iki fiille de uyuşmadığı cümlelerde ortaya çıkar; her fiilin gerektirdiği tümleç ayrı ayrı kontrol edilmelidir.

## Sözcük Sırası (Devrik Anlatım) Kaynaklı Bozukluk
Türkçede kurallı cümlede öğeler genellikle özne-tümleç-yüklem sırasını izler; bu sıranın değişmesi tek başına her zaman bir hata sayılmaz. Ancak bilgilendirici metinlerde bazı sözcüklerin (özellikle ''sadece, yalnız, bile, hatta'' gibi sınırlayıcı sözcüklerin) yanlış yere konması anlam kaymasına ya da belirsizliğe yol açabilir: ''Sadece ben bu kitabı okudum.'' ile ''Ben sadece bu kitabı okudum.'' cümleleri farklı anlamlar taşır çünkü ''sadece'' sözcüğünün cümledeki yeri değiştikçe vurguladığı öge de değişir. Bu tür sözcük sırası kaynaklı anlam belirsizlikleri, ÖSYM''nin ''anlam belirsizliği'' başlığı altında değerlendirdiği sorulardandır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1)
  and tc.content_md not like '%## Nesne / Tümleç Düşüklüğü%';

-- konu: Anlatım Bozuklukları (Türkçe / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Nesne / Tümleç Düşüklüğü
Bir cümlede yükleme bağlı olması gereken nesne, dolaylı tümleç veya zarf tümleci eksik bırakıldığında anlatım bozukluğu oluşur: ''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesinde ''geliştirilmeli'' fiilinin nesnesi belirtilmemiştir (neyin geliştirileceği belirsizdir); doğrusu ''Bu projeye hem daha fazla emek verilmeli hem de büyük bir bütçe ayrılmalı.'' gibi düzeltilmelidir. Bu hata, özellikle sıralı fiillerin ortak bir tümleci paylaştığı ama bu tümlecin her iki fiille de uyuşmadığı cümlelerde ortaya çıkar; her fiilin gerektirdiği tümleç ayrı ayrı kontrol edilmelidir.

## Sözcük Sırası (Devrik Anlatım) Kaynaklı Bozukluk
Türkçede kurallı cümlede öğeler genellikle özne-tümleç-yüklem sırasını izler; bu sıranın değişmesi tek başına her zaman bir hata sayılmaz. Ancak bilgilendirici metinlerde bazı sözcüklerin (özellikle ''sadece, yalnız, bile, hatta'' gibi sınırlayıcı sözcüklerin) yanlış yere konması anlam kaymasına ya da belirsizliğe yol açabilir: ''Sadece ben bu kitabı okudum.'' ile ''Ben sadece bu kitabı okudum.'' cümleleri farklı anlamlar taşır çünkü ''sadece'' sözcüğünün cümledeki yeri değiştikçe vurguladığı öge de değişir. Bu tür sözcük sırası kaynaklı anlam belirsizlikleri, ÖSYM''nin ''anlam belirsizliği'' başlığı altında değerlendirdiği sorulardandır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1)
  and tc.content_md not like '%## Nesne / Tümleç Düşüklüğü%';

-- konu: Anlatım Bozuklukları (Türkçe / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Nesne / Tümleç Düşüklüğü
Bir cümlede yükleme bağlı olması gereken nesne, dolaylı tümleç veya zarf tümleci eksik bırakıldığında anlatım bozukluğu oluşur: ''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesinde ''geliştirilmeli'' fiilinin nesnesi belirtilmemiştir (neyin geliştirileceği belirsizdir); doğrusu ''Bu projeye hem daha fazla emek verilmeli hem de büyük bir bütçe ayrılmalı.'' gibi düzeltilmelidir. Bu hata, özellikle sıralı fiillerin ortak bir tümleci paylaştığı ama bu tümlecin her iki fiille de uyuşmadığı cümlelerde ortaya çıkar; her fiilin gerektirdiği tümleç ayrı ayrı kontrol edilmelidir.

## Sözcük Sırası (Devrik Anlatım) Kaynaklı Bozukluk
Türkçede kurallı cümlede öğeler genellikle özne-tümleç-yüklem sırasını izler; bu sıranın değişmesi tek başına her zaman bir hata sayılmaz. Ancak bilgilendirici metinlerde bazı sözcüklerin (özellikle ''sadece, yalnız, bile, hatta'' gibi sınırlayıcı sözcüklerin) yanlış yere konması anlam kaymasına ya da belirsizliğe yol açabilir: ''Sadece ben bu kitabı okudum.'' ile ''Ben sadece bu kitabı okudum.'' cümleleri farklı anlamlar taşır çünkü ''sadece'' sözcüğünün cümledeki yeri değiştikçe vurguladığı öge de değişir. Bu tür sözcük sırası kaynaklı anlam belirsizlikleri, ÖSYM''nin ''anlam belirsizliği'' başlığı altında değerlendirdiği sorulardandır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1)
  and tc.content_md not like '%## Nesne / Tümleç Düşüklüğü%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Sıralı fiillerin ortak tümlecinin her ikisiyle de uyuşması gerektiğini kavrar.', 'Cümlede ''geliştirilmeli'' fiilinin nesnesi eksik bırakılmıştır, yani neyin geliştirileceği belirtilmemiştir; bu bir nesne (tümleç) düşüklüğüdür. Cümlede özne-yüklem uyumsuzluğu, çelişen sözler veya gereksiz bir sözcük kullanımı söz konusu olmadığından diğer seçenekler yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Nesne (tümleç) eksikliği', true, 1),
  ('Özne-yüklem uyumsuzluğu', false, 0),
  ('Çelişen sözlerin bir arada kullanılması', false, 4),
  ('Gereksiz sözcük kullanımı', false, 3),
  ('Çatı (etken-edilgen) uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Sıralı fiillerin ortak tümlecinin her ikisiyle de uyuşması gerektiğini kavrar.', 'Cümlede ''geliştirilmeli'' fiilinin nesnesi eksik bırakılmıştır, yani neyin geliştirileceği belirtilmemiştir; bu bir nesne (tümleç) düşüklüğüdür. Cümlede özne-yüklem uyumsuzluğu, çelişen sözler veya gereksiz bir sözcük kullanımı söz konusu olmadığından diğer seçenekler yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Nesne (tümleç) eksikliği', true, 1),
  ('Özne-yüklem uyumsuzluğu', false, 0),
  ('Çelişen sözlerin bir arada kullanılması', false, 4),
  ('Gereksiz sözcük kullanımı', false, 3),
  ('Çatı (etken-edilgen) uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Sıralı fiillerin ortak tümlecinin her ikisiyle de uyuşması gerektiğini kavrar.', 'Cümlede ''geliştirilmeli'' fiilinin nesnesi eksik bırakılmıştır, yani neyin geliştirileceği belirtilmemiştir; bu bir nesne (tümleç) düşüklüğüdür. Cümlede özne-yüklem uyumsuzluğu, çelişen sözler veya gereksiz bir sözcük kullanımı söz konusu olmadığından diğer seçenekler yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Bu proje hem geliştirilmeli hem de büyük bir bütçe ayrılmalı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Nesne (tümleç) eksikliği', true, 1),
  ('Özne-yüklem uyumsuzluğu', false, 0),
  ('Çelişen sözlerin bir arada kullanılması', false, 4),
  ('Gereksiz sözcük kullanımı', false, 3),
  ('Çatı (etken-edilgen) uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Aynı anlama gelen sözcüklerin bir arada kullanılmasından kaynaklanan gereksiz sözcük hatasını tespit eder.', 'Cümlede ''son bir kez daha'' ifadesiyle ''tekrar'' sözcüğü aynı anlamı (yeniden yapma) taşıdığından bir arada kullanılmaları gereksizdir; bu bir gereksiz sözcük kullanımı hatasıdır. Cümlede bir çelişki, uyumsuzluk veya eksiklik değil, anlamca fazlalık söz konusudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gereksiz sözcük kullanımı', true, 1),
  ('Anlam belirsizliği', false, 4),
  ('Özne-yüklem uyumsuzluğu', false, 3),
  ('Tamlama eksikliği', false, 0),
  ('Çatı uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Aynı anlama gelen sözcüklerin bir arada kullanılmasından kaynaklanan gereksiz sözcük hatasını tespit eder.', 'Cümlede ''son bir kez daha'' ifadesiyle ''tekrar'' sözcüğü aynı anlamı (yeniden yapma) taşıdığından bir arada kullanılmaları gereksizdir; bu bir gereksiz sözcük kullanımı hatasıdır. Cümlede bir çelişki, uyumsuzluk veya eksiklik değil, anlamca fazlalık söz konusudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gereksiz sözcük kullanımı', true, 1),
  ('Anlam belirsizliği', false, 4),
  ('Özne-yüklem uyumsuzluğu', false, 3),
  ('Tamlama eksikliği', false, 0),
  ('Çatı uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Aynı anlama gelen sözcüklerin bir arada kullanılmasından kaynaklanan gereksiz sözcük hatasını tespit eder.', 'Cümlede ''son bir kez daha'' ifadesiyle ''tekrar'' sözcüğü aynı anlamı (yeniden yapma) taşıdığından bir arada kullanılmaları gereksizdir; bu bir gereksiz sözcük kullanımı hatasıdır. Cümlede bir çelişki, uyumsuzluk veya eksiklik değil, anlamca fazlalık söz konusudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sınava son bir kez daha tekrar çalıştı.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gereksiz sözcük kullanımı', true, 1),
  ('Anlam belirsizliği', false, 4),
  ('Özne-yüklem uyumsuzluğu', false, 3),
  ('Tamlama eksikliği', false, 0),
  ('Çatı uyumsuzluğu', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Ortak tamlayanı paylaşan tamlamalarda eksik bırakılan tamlanma ekini fark eder.', 'Cümlede ''okulun'' tamlayanı yalnızca ''bahçesi'' ile tamlama kurmuş, ''sınıflar'' sözcüğüne bağlanmamıştır; doğrusu ''okulun bahçesi ve sınıfları temizlendi'' biçiminde olmalıydı. Bu, tamlama eksikliğinden kaynaklanan bir anlatım bozukluğudur, cümlede özne-yüklem uyumsuzluğu veya çelişen sözler bulunmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamlama eksikliği', true, 3),
  ('Özne-yüklem uyumsuzluğu', false, 4),
  ('Çelişen sözlerin bir aradalığı', false, 0),
  ('Gereksiz sözcük kullanımı', false, 1),
  ('Neden-sonuç ilişkisinde mantık hatası', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Ortak tamlayanı paylaşan tamlamalarda eksik bırakılan tamlanma ekini fark eder.', 'Cümlede ''okulun'' tamlayanı yalnızca ''bahçesi'' ile tamlama kurmuş, ''sınıflar'' sözcüğüne bağlanmamıştır; doğrusu ''okulun bahçesi ve sınıfları temizlendi'' biçiminde olmalıydı. Bu, tamlama eksikliğinden kaynaklanan bir anlatım bozukluğudur, cümlede özne-yüklem uyumsuzluğu veya çelişen sözler bulunmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamlama eksikliği', true, 3),
  ('Özne-yüklem uyumsuzluğu', false, 4),
  ('Çelişen sözlerin bir aradalığı', false, 0),
  ('Gereksiz sözcük kullanımı', false, 1),
  ('Neden-sonuç ilişkisinde mantık hatası', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', 'Ortak tamlayanı paylaşan tamlamalarda eksik bırakılan tamlanma ekini fark eder.', 'Cümlede ''okulun'' tamlayanı yalnızca ''bahçesi'' ile tamlama kurmuş, ''sınıflar'' sözcüğüne bağlanmamıştır; doğrusu ''okulun bahçesi ve sınıfları temizlendi'' biçiminde olmalıydı. Bu, tamlama eksikliğinden kaynaklanan bir anlatım bozukluğudur, cümlede özne-yüklem uyumsuzluğu veya çelişen sözler bulunmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Okulun bahçesi ve sınıflar temizlendi.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamlama eksikliği', true, 3),
  ('Özne-yüklem uyumsuzluğu', false, 4),
  ('Çelişen sözlerin bir aradalığı', false, 0),
  ('Gereksiz sözcük kullanımı', false, 1),
  ('Neden-sonuç ilişkisinde mantık hatası', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?', 'Sınırlayıcı sözcüklerin cümledeki yerinin anlamı değiştirebileceğini fark eder.', '''Yalnız Ali bu soruyu doğru cevapladı.'' cümlesinde ''yalnız'' sözcüğünün yeri nedeniyle cümle hem ''soruyu doğru cevaplayan tek kişinin Ali olduğu'' hem de ''Ali''nin bu soruyu tek başına, yardım almadan cevapladığı'' biçiminde iki farklı anlaşılabilir. Diğer seçeneklerde sözcük sırasından kaynaklanan böyle bir belirsizlik bulunmamaktadır, anlam açıktır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yalnız Ali bu soruyu doğru cevapladı.', true, 2),
  ('Ali, bu soruyu tek başına doğru cevapladı.', false, 3),
  ('Sınavdaki sorular oldukça zordu.', false, 1),
  ('Öğrenciler soruları dikkatle okudu.', false, 0),
  ('Sınıfta yalnızca beş öğrenci vardı.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?', 'Sınırlayıcı sözcüklerin cümledeki yerinin anlamı değiştirebileceğini fark eder.', '''Yalnız Ali bu soruyu doğru cevapladı.'' cümlesinde ''yalnız'' sözcüğünün yeri nedeniyle cümle hem ''soruyu doğru cevaplayan tek kişinin Ali olduğu'' hem de ''Ali''nin bu soruyu tek başına, yardım almadan cevapladığı'' biçiminde iki farklı anlaşılabilir. Diğer seçeneklerde sözcük sırasından kaynaklanan böyle bir belirsizlik bulunmamaktadır, anlam açıktır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yalnız Ali bu soruyu doğru cevapladı.', true, 2),
  ('Ali, bu soruyu tek başına doğru cevapladı.', false, 3),
  ('Sınavdaki sorular oldukça zordu.', false, 1),
  ('Öğrenciler soruları dikkatle okudu.', false, 0),
  ('Sınıfta yalnızca beş öğrenci vardı.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?', 'Sınırlayıcı sözcüklerin cümledeki yerinin anlamı değiştirebileceğini fark eder.', '''Yalnız Ali bu soruyu doğru cevapladı.'' cümlesinde ''yalnız'' sözcüğünün yeri nedeniyle cümle hem ''soruyu doğru cevaplayan tek kişinin Ali olduğu'' hem de ''Ali''nin bu soruyu tek başına, yardım almadan cevapladığı'' biçiminde iki farklı anlaşılabilir. Diğer seçeneklerde sözcük sırasından kaynaklanan böyle bir belirsizlik bulunmamaktadır, anlam açıktır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki cümlelerin hangisinde sözcüklerin cümledeki yeri nedeniyle bir anlam belirsizliği oluşmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yalnız Ali bu soruyu doğru cevapladı.', true, 2),
  ('Ali, bu soruyu tek başına doğru cevapladı.', false, 3),
  ('Sınavdaki sorular oldukça zordu.', false, 1),
  ('Öğrenciler soruları dikkatle okudu.', false, 0),
  ('Sınıfta yalnızca beş öğrenci vardı.', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', '''Hem...hem de'' bağlacıyla bağlanan yargıların özne bakımından uyumlu olması gerektiğini kavrar.', '''Hem...hem de'' bağlacı, öznesi ve yüklemi birbiriyle uyumlu iki yargıyı bağlamalıdır; ancak burada ''çocuklar yorulmuş'' yargısının öznesi çocuklar iken ''akşam olmuştu'' yargısının öznesi vakit/hava durumudur. Farklı öznelere ait bu iki yargının aynı bağlaçla bağlanması anlatımı bozmuştur; cümlede tamlama eksikliği, gereksiz sözcük veya çelişen sözler söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Farklı öznelere ait yargıların ''hem...hem de'' bağlacıyla hatalı bağlanması', true, 1),
  ('Gereksiz sözcük kullanımı', false, 0),
  ('Tamlama eksikliği', false, 2),
  ('Çelişen sözlerin bir aradalığı', false, 3),
  ('Anlam belirsizliği', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', '''Hem...hem de'' bağlacıyla bağlanan yargıların özne bakımından uyumlu olması gerektiğini kavrar.', '''Hem...hem de'' bağlacı, öznesi ve yüklemi birbiriyle uyumlu iki yargıyı bağlamalıdır; ancak burada ''çocuklar yorulmuş'' yargısının öznesi çocuklar iken ''akşam olmuştu'' yargısının öznesi vakit/hava durumudur. Farklı öznelere ait bu iki yargının aynı bağlaçla bağlanması anlatımı bozmuştur; cümlede tamlama eksikliği, gereksiz sözcük veya çelişen sözler söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Farklı öznelere ait yargıların ''hem...hem de'' bağlacıyla hatalı bağlanması', true, 1),
  ('Gereksiz sözcük kullanımı', false, 0),
  ('Tamlama eksikliği', false, 2),
  ('Çelişen sözlerin bir aradalığı', false, 3),
  ('Anlam belirsizliği', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Türkçe' and t.name = 'Anlatım Bozuklukları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?', '''Hem...hem de'' bağlacıyla bağlanan yargıların özne bakımından uyumlu olması gerektiğini kavrar.', '''Hem...hem de'' bağlacı, öznesi ve yüklemi birbiriyle uyumlu iki yargıyı bağlamalıdır; ancak burada ''çocuklar yorulmuş'' yargısının öznesi çocuklar iken ''akşam olmuştu'' yargısının öznesi vakit/hava durumudur. Farklı öznelere ait bu iki yargının aynı bağlaçla bağlanması anlatımı bozmuştur; cümlede tamlama eksikliği, gereksiz sözcük veya çelişen sözler söz konusu değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '''Sokakta oynayan çocuklar hem yorulmuş hem de akşam olmuştu.'' cümlesindeki anlatım bozukluğunun nedeni nedir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Farklı öznelere ait yargıların ''hem...hem de'' bağlacıyla hatalı bağlanması', true, 1),
  ('Gereksiz sözcük kullanımı', false, 0),
  ('Tamlama eksikliği', false, 2),
  ('Çelişen sözlerin bir aradalığı', false, 3),
  ('Anlam belirsizliği', false, 4)
) as v(choice_text, is_correct, order_index);

-- ============ Matematik ============
-- konu: Temel Kavramlar (Matematik / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tek-Çift Sayılarla İşlem Kuralları (Parite)
İki sayının toplamının, farkının ve çarpımının tek mi çift mi olacağını hızlıca belirlemek KPSS''de zaman kazandırır: Çift+Çift=Çift, Tek+Tek=Çift, Çift+Tek=Tek (toplama ve çıkarmada aynı kural geçerlidir). Çarpımda ise sonucun çift olması için çarpanlardan EN AZ BİRİNİN çift olması yeterlidir; bir çarpımın tek çıkabilmesi için TÜM çarpanların tek olması gerekir. Sık yapılan hata: "iki tek sayının çarpımı çift olur" sanılmasıdır — oysa tek×tek=tek''tir (örneğin 3×5=15, tek sonuç verir). Bu kural, uzun çarpım/toplam zincirlerinin sonucunun tek mi çift mi olacağını tek tek hesap yapmadan söylemeyi sağlar.

## Mutlak Değerli Denklemlerin Çözümü
|x − a| = b biçimindeki denklemlerde (b ≥ 0), mutlak değer içindeki ifade b''ye VEYA −b''ye eşit olabileceğinden iki ayrı denklem yazılmalıdır: x − a = b veya x − a = −b. Örnek: |x − 4| = 6 denkleminde x − 4 = 6 → x = 10 veya x − 4 = −6 → x = −2 bulunur; yani denklemin İKİ çözümü vardır. Sık yapılan hata, yalnızca pozitif kökü bulup negatif kökü unutmaktır — soru "x''in alabileceği değerlerin toplamı/çarpımı" şeklinde sorulduğunda bu unutma doğrudan yanlış sonuca götürür (doğru toplam burada 10 + (−2) = 8''dir).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1)
  and tc.content_md not like '%## Tek-Çift Sayılarla İşlem Kuralları (Parite)%';

-- konu: Temel Kavramlar (Matematik / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tek-Çift Sayılarla İşlem Kuralları (Parite)
İki sayının toplamının, farkının ve çarpımının tek mi çift mi olacağını hızlıca belirlemek KPSS''de zaman kazandırır: Çift+Çift=Çift, Tek+Tek=Çift, Çift+Tek=Tek (toplama ve çıkarmada aynı kural geçerlidir). Çarpımda ise sonucun çift olması için çarpanlardan EN AZ BİRİNİN çift olması yeterlidir; bir çarpımın tek çıkabilmesi için TÜM çarpanların tek olması gerekir. Sık yapılan hata: "iki tek sayının çarpımı çift olur" sanılmasıdır — oysa tek×tek=tek''tir (örneğin 3×5=15, tek sonuç verir). Bu kural, uzun çarpım/toplam zincirlerinin sonucunun tek mi çift mi olacağını tek tek hesap yapmadan söylemeyi sağlar.

## Mutlak Değerli Denklemlerin Çözümü
|x − a| = b biçimindeki denklemlerde (b ≥ 0), mutlak değer içindeki ifade b''ye VEYA −b''ye eşit olabileceğinden iki ayrı denklem yazılmalıdır: x − a = b veya x − a = −b. Örnek: |x − 4| = 6 denkleminde x − 4 = 6 → x = 10 veya x − 4 = −6 → x = −2 bulunur; yani denklemin İKİ çözümü vardır. Sık yapılan hata, yalnızca pozitif kökü bulup negatif kökü unutmaktır — soru "x''in alabileceği değerlerin toplamı/çarpımı" şeklinde sorulduğunda bu unutma doğrudan yanlış sonuca götürür (doğru toplam burada 10 + (−2) = 8''dir).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1)
  and tc.content_md not like '%## Tek-Çift Sayılarla İşlem Kuralları (Parite)%';

-- konu: Temel Kavramlar (Matematik / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tek-Çift Sayılarla İşlem Kuralları (Parite)
İki sayının toplamının, farkının ve çarpımının tek mi çift mi olacağını hızlıca belirlemek KPSS''de zaman kazandırır: Çift+Çift=Çift, Tek+Tek=Çift, Çift+Tek=Tek (toplama ve çıkarmada aynı kural geçerlidir). Çarpımda ise sonucun çift olması için çarpanlardan EN AZ BİRİNİN çift olması yeterlidir; bir çarpımın tek çıkabilmesi için TÜM çarpanların tek olması gerekir. Sık yapılan hata: "iki tek sayının çarpımı çift olur" sanılmasıdır — oysa tek×tek=tek''tir (örneğin 3×5=15, tek sonuç verir). Bu kural, uzun çarpım/toplam zincirlerinin sonucunun tek mi çift mi olacağını tek tek hesap yapmadan söylemeyi sağlar.

## Mutlak Değerli Denklemlerin Çözümü
|x − a| = b biçimindeki denklemlerde (b ≥ 0), mutlak değer içindeki ifade b''ye VEYA −b''ye eşit olabileceğinden iki ayrı denklem yazılmalıdır: x − a = b veya x − a = −b. Örnek: |x − 4| = 6 denkleminde x − 4 = 6 → x = 10 veya x − 4 = −6 → x = −2 bulunur; yani denklemin İKİ çözümü vardır. Sık yapılan hata, yalnızca pozitif kökü bulup negatif kökü unutmaktır — soru "x''in alabileceği değerlerin toplamı/çarpımı" şeklinde sorulduğunda bu unutma doğrudan yanlış sonuca götürür (doğru toplam burada 10 + (−2) = 8''dir).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1)
  and tc.content_md not like '%## Tek-Çift Sayılarla İşlem Kuralları (Parite)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5! − 3! işleminin sonucu kaçtır?', 'Faktöriyel kavramını tanır ve faktöriyelli ifadelerde işlem yapar.', '5! = 1×2×3×4×5 = 120 ve 3! = 1×2×3 = 6''dır. 120 − 6 = 114 bulunur. Dikkat: (5−3)! = 2! = 2 şeklinde bir sadeleştirme YAPILAMAZ, önce her faktöriyel ayrı ayrı hesaplanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5! − 3! işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('114', true, 3),
  ('117', false, 4),
  ('2', false, 1),
  ('14', false, 0),
  ('24', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5! − 3! işleminin sonucu kaçtır?', 'Faktöriyel kavramını tanır ve faktöriyelli ifadelerde işlem yapar.', '5! = 1×2×3×4×5 = 120 ve 3! = 1×2×3 = 6''dır. 120 − 6 = 114 bulunur. Dikkat: (5−3)! = 2! = 2 şeklinde bir sadeleştirme YAPILAMAZ, önce her faktöriyel ayrı ayrı hesaplanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5! − 3! işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('114', true, 3),
  ('117', false, 4),
  ('2', false, 1),
  ('14', false, 0),
  ('24', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5! − 3! işleminin sonucu kaçtır?', 'Faktöriyel kavramını tanır ve faktöriyelli ifadelerde işlem yapar.', '5! = 1×2×3×4×5 = 120 ve 3! = 1×2×3 = 6''dır. 120 − 6 = 114 bulunur. Dikkat: (5−3)! = 2! = 2 şeklinde bir sadeleştirme YAPILAMAZ, önce her faktöriyel ayrı ayrı hesaplanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5! − 3! işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('114', true, 3),
  ('117', false, 4),
  ('2', false, 1),
  ('14', false, 0),
  ('24', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?', 'Asal sayı tanımını kullanarak belirli bir aralıktaki asal sayıları belirler.', '50''den küçük en küçük asal sayı 2''dir (1 asal değildir). 50''den küçük en büyük asal sayı 47''dir (49 = 7×7 olduğundan asal değildir). Fark: 47 − 2 = 45''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45', true, 0),
  ('47', false, 4),
  ('46', false, 2),
  ('44', false, 3),
  ('48', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?', 'Asal sayı tanımını kullanarak belirli bir aralıktaki asal sayıları belirler.', '50''den küçük en küçük asal sayı 2''dir (1 asal değildir). 50''den küçük en büyük asal sayı 47''dir (49 = 7×7 olduğundan asal değildir). Fark: 47 − 2 = 45''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45', true, 0),
  ('47', false, 4),
  ('46', false, 2),
  ('44', false, 3),
  ('48', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?', 'Asal sayı tanımını kullanarak belirli bir aralıktaki asal sayıları belirler.', '50''den küçük en küçük asal sayı 2''dir (1 asal değildir). 50''den küçük en büyük asal sayı 47''dir (49 = 7×7 olduğundan asal değildir). Fark: 47 − 2 = 45''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '50''den küçük asal sayılardan en büyüğü ile en küçüğü arasındaki fark kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45', true, 0),
  ('47', false, 4),
  ('46', false, 2),
  ('44', false, 3),
  ('48', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?', 'Mutlak değerli bir denklemin iki köküne birden ulaşarak istenen ifadeyi hesaplar.', '2x − 5 = 9 ⟹ 2x = 14 ⟹ x = 7. 2x − 5 = −9 ⟹ 2x = −4 ⟹ x = −2. İki kökün toplamı: 7 + (−2) = 5''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 4),
  ('7', false, 2),
  ('-2', false, 0),
  ('0', false, 3),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?', 'Mutlak değerli bir denklemin iki köküne birden ulaşarak istenen ifadeyi hesaplar.', '2x − 5 = 9 ⟹ 2x = 14 ⟹ x = 7. 2x − 5 = −9 ⟹ 2x = −4 ⟹ x = −2. İki kökün toplamı: 7 + (−2) = 5''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 4),
  ('7', false, 2),
  ('-2', false, 0),
  ('0', false, 3),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?', 'Mutlak değerli bir denklemin iki köküne birden ulaşarak istenen ifadeyi hesaplar.', '2x − 5 = 9 ⟹ 2x = 14 ⟹ x = 7. 2x − 5 = −9 ⟹ 2x = −4 ⟹ x = −2. İki kökün toplamı: 7 + (−2) = 5''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '|2x − 5| = 9 denklemini sağlayan x değerlerinin toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 4),
  ('7', false, 2),
  ('-2', false, 0),
  ('0', false, 3),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?', 'EBOB ile EKOK arasındaki EBOB×EKOK = a×b özdeşliğini problemde uygular.', 'EBOB × EKOK = İki sayının çarpımı özdeşliğinden 6 × EKOK = 180 yazılır. Buradan EKOK = 180 ÷ 6 = 30 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('30', true, 1),
  ('1080', false, 2),
  ('186', false, 4),
  ('174', false, 3),
  ('36', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?', 'EBOB ile EKOK arasındaki EBOB×EKOK = a×b özdeşliğini problemde uygular.', 'EBOB × EKOK = İki sayının çarpımı özdeşliğinden 6 × EKOK = 180 yazılır. Buradan EKOK = 180 ÷ 6 = 30 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('30', true, 1),
  ('1080', false, 2),
  ('186', false, 4),
  ('174', false, 3),
  ('36', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?', 'EBOB ile EKOK arasındaki EBOB×EKOK = a×b özdeşliğini problemde uygular.', 'EBOB × EKOK = İki sayının çarpımı özdeşliğinden 6 × EKOK = 180 yazılır. Buradan EKOK = 180 ÷ 6 = 30 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki pozitif tam sayının çarpımı 180, bu iki sayının EBOB''u 6 olduğuna göre EKOK''u kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('30', true, 1),
  ('1080', false, 2),
  ('186', false, 4),
  ('174', false, 3),
  ('36', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?', 'Asal sayı özelliklerini ve sabit toplamlı iki sayının çarpımının en büyük olduğu durumu birlikte değerlendirir.', 'Toplamı 60 olan asal çift sayı ikilileri arasında (7,53), (13,47), (17,43), (19,41), (23,37), (29,31) bulunur. Sabit toplamlı iki sayının çarpımı, sayılar birbirine ne kadar yakınsa o kadar büyük olur; bu yüzden en yakın çift olan 29 ve 31 seçilir: 29 × 31 = 899.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('899', true, 2),
  ('851', false, 0),
  ('779', false, 3),
  ('900', false, 1),
  ('731', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?', 'Asal sayı özelliklerini ve sabit toplamlı iki sayının çarpımının en büyük olduğu durumu birlikte değerlendirir.', 'Toplamı 60 olan asal çift sayı ikilileri arasında (7,53), (13,47), (17,43), (19,41), (23,37), (29,31) bulunur. Sabit toplamlı iki sayının çarpımı, sayılar birbirine ne kadar yakınsa o kadar büyük olur; bu yüzden en yakın çift olan 29 ve 31 seçilir: 29 × 31 = 899.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('899', true, 2),
  ('851', false, 0),
  ('779', false, 3),
  ('900', false, 1),
  ('731', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Temel Kavramlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?', 'Asal sayı özelliklerini ve sabit toplamlı iki sayının çarpımının en büyük olduğu durumu birlikte değerlendirir.', 'Toplamı 60 olan asal çift sayı ikilileri arasında (7,53), (13,47), (17,43), (19,41), (23,37), (29,31) bulunur. Sabit toplamlı iki sayının çarpımı, sayılar birbirine ne kadar yakınsa o kadar büyük olur; bu yüzden en yakın çift olan 29 ve 31 seçilir: 29 × 31 = 899.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Toplamları 60 olan iki asal sayının çarpımı en fazla kaç olabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('899', true, 2),
  ('851', false, 0),
  ('779', false, 3),
  ('900', false, 1),
  ('731', false, 4)
) as v(choice_text, is_correct, order_index);

-- konu: Bölme ve Bölünebilme (Matematik / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme
7 ile bölünebilme kuralı diğerlerine göre daha karmaşıktır: sayının birler basamağı atılır, kalan kısımdan atılan basamağın 2 katı çıkarılır; sonuç 7''ye bölünüyorsa (ya da 0 ise) sayı da 7 ile tam bölünür (gerekirse işlem tekrarlanır). Örnek: 133 → birler basamağı 3 atılır, kalan 13''ten 3×2=6 çıkarılır: 13−6=7, 7''ye bölündüğü için 133 de 7''ye tam bölünür. 12, 15, 25 gibi ASAL OLMAYAN sayılarla bölünebilme kontrol edilirken, o sayı ARALARINDA ASAL iki çarpanına ayrılır ve sayının HER İKİ çarpanla da bölünüp bölünmediğine bakılır: 12 ile bölünebilme için hem 3 hem 4 ile (12=3×4), 15 ile bölünebilme için hem 3 hem 5 ile bölünebilme birlikte kontrol edilir.

## Bölenlerin Toplamı Formülü ve Kalanlı İşlem Kısayolu
Bölen SAYISI formülü (x+1)(y+1)(z+1)''den farklı olarak, bir N = a^x × b^y × ... sayısının pozitif bölenlerinin TOPLAMI [(a^(x+1)−1)/(a−1)] × [(b^(y+1)−1)/(b−1)] × ... formülüyle bulunur. Örneğin 12 = 2²×3¹ için bölenler toplamı = (2³−1)/(2−1) × (3²−1)/(3−1) = 7×4 = 28''dir (kontrol: 1+2+3+4+6+12=28). Ayrıca birden fazla sayının toplamının/çarpımının bir B sayısına bölümündeki kalanını bulmak için, önce her sayının B''ye göre kalanı ayrı ayrı bulunur, sonra bu kalanlar toplanır/çarpılır ve yeniden B''ye bölünerek nihai kalana ulaşılır; büyük sayılarla doğrudan işlem yapmaya gerek kalmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1)
  and tc.content_md not like '%## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme%';

-- konu: Bölme ve Bölünebilme (Matematik / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme
7 ile bölünebilme kuralı diğerlerine göre daha karmaşıktır: sayının birler basamağı atılır, kalan kısımdan atılan basamağın 2 katı çıkarılır; sonuç 7''ye bölünüyorsa (ya da 0 ise) sayı da 7 ile tam bölünür (gerekirse işlem tekrarlanır). Örnek: 133 → birler basamağı 3 atılır, kalan 13''ten 3×2=6 çıkarılır: 13−6=7, 7''ye bölündüğü için 133 de 7''ye tam bölünür. 12, 15, 25 gibi ASAL OLMAYAN sayılarla bölünebilme kontrol edilirken, o sayı ARALARINDA ASAL iki çarpanına ayrılır ve sayının HER İKİ çarpanla da bölünüp bölünmediğine bakılır: 12 ile bölünebilme için hem 3 hem 4 ile (12=3×4), 15 ile bölünebilme için hem 3 hem 5 ile bölünebilme birlikte kontrol edilir.

## Bölenlerin Toplamı Formülü ve Kalanlı İşlem Kısayolu
Bölen SAYISI formülü (x+1)(y+1)(z+1)''den farklı olarak, bir N = a^x × b^y × ... sayısının pozitif bölenlerinin TOPLAMI [(a^(x+1)−1)/(a−1)] × [(b^(y+1)−1)/(b−1)] × ... formülüyle bulunur. Örneğin 12 = 2²×3¹ için bölenler toplamı = (2³−1)/(2−1) × (3²−1)/(3−1) = 7×4 = 28''dir (kontrol: 1+2+3+4+6+12=28). Ayrıca birden fazla sayının toplamının/çarpımının bir B sayısına bölümündeki kalanını bulmak için, önce her sayının B''ye göre kalanı ayrı ayrı bulunur, sonra bu kalanlar toplanır/çarpılır ve yeniden B''ye bölünerek nihai kalana ulaşılır; büyük sayılarla doğrudan işlem yapmaya gerek kalmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1)
  and tc.content_md not like '%## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme%';

-- konu: Bölme ve Bölünebilme (Matematik / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme
7 ile bölünebilme kuralı diğerlerine göre daha karmaşıktır: sayının birler basamağı atılır, kalan kısımdan atılan basamağın 2 katı çıkarılır; sonuç 7''ye bölünüyorsa (ya da 0 ise) sayı da 7 ile tam bölünür (gerekirse işlem tekrarlanır). Örnek: 133 → birler basamağı 3 atılır, kalan 13''ten 3×2=6 çıkarılır: 13−6=7, 7''ye bölündüğü için 133 de 7''ye tam bölünür. 12, 15, 25 gibi ASAL OLMAYAN sayılarla bölünebilme kontrol edilirken, o sayı ARALARINDA ASAL iki çarpanına ayrılır ve sayının HER İKİ çarpanla da bölünüp bölünmediğine bakılır: 12 ile bölünebilme için hem 3 hem 4 ile (12=3×4), 15 ile bölünebilme için hem 3 hem 5 ile bölünebilme birlikte kontrol edilir.

## Bölenlerin Toplamı Formülü ve Kalanlı İşlem Kısayolu
Bölen SAYISI formülü (x+1)(y+1)(z+1)''den farklı olarak, bir N = a^x × b^y × ... sayısının pozitif bölenlerinin TOPLAMI [(a^(x+1)−1)/(a−1)] × [(b^(y+1)−1)/(b−1)] × ... formülüyle bulunur. Örneğin 12 = 2²×3¹ için bölenler toplamı = (2³−1)/(2−1) × (3²−1)/(3−1) = 7×4 = 28''dir (kontrol: 1+2+3+4+6+12=28). Ayrıca birden fazla sayının toplamının/çarpımının bir B sayısına bölümündeki kalanını bulmak için, önce her sayının B''ye göre kalanı ayrı ayrı bulunur, sonra bu kalanlar toplanır/çarpılır ve yeniden B''ye bölünerek nihai kalana ulaşılır; büyük sayılarla doğrudan işlem yapmaya gerek kalmaz.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1)
  and tc.content_md not like '%## 7 ile Bölünebilme Kuralı ve Bileşik Sayılarla (12, 15, 25...) Bölünebilme%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?', '7 ile bölünebilme kuralını uygular.', '637 sayısında birler basamağı (7) atılır: kalan 63. Atılan basamağın 2 katı olan 14, 63''ten çıkarılır: 63−14=49, 49 ise 7''ye tam bölünür. Dolayısıyla 637 de 7''ye tam bölünür (637=7×91). Diğer seçeneklerdeki 9, 11, 6 ve 8 ile bölünmez.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7', true, 4),
  ('9', false, 3),
  ('11', false, 1),
  ('6', false, 2),
  ('8', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?', '7 ile bölünebilme kuralını uygular.', '637 sayısında birler basamağı (7) atılır: kalan 63. Atılan basamağın 2 katı olan 14, 63''ten çıkarılır: 63−14=49, 49 ise 7''ye tam bölünür. Dolayısıyla 637 de 7''ye tam bölünür (637=7×91). Diğer seçeneklerdeki 9, 11, 6 ve 8 ile bölünmez.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7', true, 4),
  ('9', false, 3),
  ('11', false, 1),
  ('6', false, 2),
  ('8', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?', '7 ile bölünebilme kuralını uygular.', '637 sayısında birler basamağı (7) atılır: kalan 63. Atılan basamağın 2 katı olan 14, 63''ten çıkarılır: 63−14=49, 49 ise 7''ye tam bölünür. Dolayısıyla 637 de 7''ye tam bölünür (637=7×91). Diğer seçeneklerdeki 9, 11, 6 ve 8 ile bölünmez.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '637 sayısı aşağıdaki sayılardan hangisi ile tam bölünür?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7', true, 4),
  ('9', false, 3),
  ('11', false, 1),
  ('6', false, 2),
  ('8', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?', 'Bölme algoritmasını (Bölünen = Bölen × Bölüm + Kalan) kullanarak bölüneni bulur.', 'Bölme algoritması A = B×Ç + K formülüyle yazılır: A = 8×15 + 5 = 120 + 5 = 125. Kalanın (5) bölenden (8) küçük olması koşulu da sağlanmaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('125', true, 3),
  ('120', false, 2),
  ('160', false, 4),
  ('28', false, 0),
  ('115', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?', 'Bölme algoritmasını (Bölünen = Bölen × Bölüm + Kalan) kullanarak bölüneni bulur.', 'Bölme algoritması A = B×Ç + K formülüyle yazılır: A = 8×15 + 5 = 120 + 5 = 125. Kalanın (5) bölenden (8) küçük olması koşulu da sağlanmaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('125', true, 3),
  ('120', false, 2),
  ('160', false, 4),
  ('28', false, 0),
  ('115', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?', 'Bölme algoritmasını (Bölünen = Bölen × Bölüm + Kalan) kullanarak bölüneni bulur.', 'Bölme algoritması A = B×Ç + K formülüyle yazılır: A = 8×15 + 5 = 120 + 5 = 125. Kalanın (5) bölenden (8) küçük olması koşulu da sağlanmaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'A sayısı 8''e bölündüğünde bölüm 15, kalan 5 oluyor. Buna göre A kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('125', true, 3),
  ('120', false, 2),
  ('160', false, 4),
  ('28', false, 0),
  ('115', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?', 'Bileşik bir sayı ile (12=3×4) bölünebilme kuralını, iki asal çarpanın kuralını birlikte sağlayarak uygular.', '12=3×4 olduğundan sayı hem 3 hem 4 ile bölünmelidir. 4 ile bölünme için son iki basamak "A6"nın 4''e bölünmesi gerekir; bu A∈{1,3,5,7,9} için sağlanır. 3 ile bölünme için rakamlar toplamı 13+A''nın 3''e bölünmesi gerekir; bu A∈{2,5,8} için sağlanır. İki koşulu birden sağlayan tek değer A=5''tir (sayı 2556, 2556÷12=213).'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 2),
  ('1', false, 0),
  ('3', false, 4),
  ('2', false, 3),
  ('8', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?', 'Bileşik bir sayı ile (12=3×4) bölünebilme kuralını, iki asal çarpanın kuralını birlikte sağlayarak uygular.', '12=3×4 olduğundan sayı hem 3 hem 4 ile bölünmelidir. 4 ile bölünme için son iki basamak "A6"nın 4''e bölünmesi gerekir; bu A∈{1,3,5,7,9} için sağlanır. 3 ile bölünme için rakamlar toplamı 13+A''nın 3''e bölünmesi gerekir; bu A∈{2,5,8} için sağlanır. İki koşulu birden sağlayan tek değer A=5''tir (sayı 2556, 2556÷12=213).'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 2),
  ('1', false, 0),
  ('3', false, 4),
  ('2', false, 3),
  ('8', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?', 'Bileşik bir sayı ile (12=3×4) bölünebilme kuralını, iki asal çarpanın kuralını birlikte sağlayarak uygular.', '12=3×4 olduğundan sayı hem 3 hem 4 ile bölünmelidir. 4 ile bölünme için son iki basamak "A6"nın 4''e bölünmesi gerekir; bu A∈{1,3,5,7,9} için sağlanır. 3 ile bölünme için rakamlar toplamı 13+A''nın 3''e bölünmesi gerekir; bu A∈{2,5,8} için sağlanır. İki koşulu birden sağlayan tek değer A=5''tir (sayı 2556, 2556÷12=213).'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '4 basamaklı 25A6 sayısı 12 ile tam bölünüyor. Buna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5', true, 2),
  ('1', false, 0),
  ('3', false, 4),
  ('2', false, 3),
  ('8', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?', 'Asal çarpanlara ayırma yoluyla bir sayının pozitif bölen sayısını (x+1)(y+1)(z+1) formülüyle bulur.', '252 sayısı asal çarpanlarına ayrıldığında 252 = 2² × 3² × 7¹ elde edilir. Bölen sayısı formülü (x+1)(y+1)(z+1) uygulanırsa: (2+1)(2+1)(1+1) = 3×3×2 = 18 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('18', true, 3),
  ('9', false, 1),
  ('12', false, 4),
  ('24', false, 2),
  ('6', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?', 'Asal çarpanlara ayırma yoluyla bir sayının pozitif bölen sayısını (x+1)(y+1)(z+1) formülüyle bulur.', '252 sayısı asal çarpanlarına ayrıldığında 252 = 2² × 3² × 7¹ elde edilir. Bölen sayısı formülü (x+1)(y+1)(z+1) uygulanırsa: (2+1)(2+1)(1+1) = 3×3×2 = 18 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('18', true, 3),
  ('9', false, 1),
  ('12', false, 4),
  ('24', false, 2),
  ('6', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?', 'Asal çarpanlara ayırma yoluyla bir sayının pozitif bölen sayısını (x+1)(y+1)(z+1) formülüyle bulur.', '252 sayısı asal çarpanlarına ayrıldığında 252 = 2² × 3² × 7¹ elde edilir. Bölen sayısı formülü (x+1)(y+1)(z+1) uygulanırsa: (2+1)(2+1)(1+1) = 3×3×2 = 18 bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '252 sayısının pozitif tam bölenlerinin sayısı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('18', true, 3),
  ('9', false, 1),
  ('12', false, 4),
  ('24', false, 2),
  ('6', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?', 'Çarpımın kalanını, her çarpanın kalanları üzerinden bulma kısayolunu uygular.', '37''nin 5''e bölümünden kalan 2, 48''in kalanı 3, 59''un kalanı 4''tür. Bu kalanların çarpımı 2×3×4=24''tür. 24''ün 5''e bölümünden kalan ise 4''tür; bu, doğrudan büyük çarpımı hesaplamaya gerek kalmadan sonuca ulaştırır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('4', true, 0),
  ('24', false, 2),
  ('9', false, 3),
  ('1', false, 1),
  ('0', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?', 'Çarpımın kalanını, her çarpanın kalanları üzerinden bulma kısayolunu uygular.', '37''nin 5''e bölümünden kalan 2, 48''in kalanı 3, 59''un kalanı 4''tür. Bu kalanların çarpımı 2×3×4=24''tür. 24''ün 5''e bölümünden kalan ise 4''tür; bu, doğrudan büyük çarpımı hesaplamaya gerek kalmadan sonuca ulaştırır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('4', true, 0),
  ('24', false, 2),
  ('9', false, 3),
  ('1', false, 1),
  ('0', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Bölme ve Bölünebilme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?', 'Çarpımın kalanını, her çarpanın kalanları üzerinden bulma kısayolunu uygular.', '37''nin 5''e bölümünden kalan 2, 48''in kalanı 3, 59''un kalanı 4''tür. Bu kalanların çarpımı 2×3×4=24''tür. 24''ün 5''e bölümünden kalan ise 4''tür; bu, doğrudan büyük çarpımı hesaplamaya gerek kalmadan sonuca ulaştırır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '37 × 48 × 59 çarpımının 5''e bölümünden kalan kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('4', true, 0),
  ('24', false, 2),
  ('9', false, 3),
  ('1', false, 1),
  ('0', false, 4)
) as v(choice_text, is_correct, order_index);

-- konu: Sayı Basamakları (Matematik / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü
İki basamaklı bir sayı "ab" biçiminde yazıldığında (a onlar basamağı, b birler basamağı), bu sayının değeri cebirsel olarak 10a+b şeklinde ifade edilir. Üç basamaklı "abc" sayısı ise 100a+10b+c olarak yazılır. Bu gösterim, basamaklar arası ilişkili problemleri denklemle çözmenin temelidir. Rakamları yer değiştirilen iki basamaklı bir sayı ile orijinal sayı arasındaki fark her zaman 9''un katıdır: "ab" sayısı (10a+b) ile yer değiştirmiş hâli "ba" (10b+a) arasındaki fark (10a+b)−(10b+a) = 9(a−b) formülüyle bulunur; yani fark, basamaklar arasındaki farkın 9 katına eşittir.

## Çözümlü Örnek: Rakam Yer Değiştirme Farkı
İki basamaklı bir sayının onlar basamağı, birler basamağından 4 fazladır. Rakamlar yer değiştirdiğinde elde edilen yeni sayı ile eski sayı arasındaki fark kaçtır? Formülden fark = 9×(a−b) = 9×4 = 36 bulunur. Bu kısayol, her seferinde iki sayıyı ayrı ayrı yazıp çıkarma işlemi yapmak yerine doğrudan sonuca ulaştırır ve sınavda önemli ölçüde zaman kazandırır; üç basamaklı sayılarda benzer mantıkla ABC ile CBA arasındaki fark 99×(A−C) formülüyle bulunabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1)
  and tc.content_md not like '%## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü%';

-- konu: Sayı Basamakları (Matematik / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü
İki basamaklı bir sayı "ab" biçiminde yazıldığında (a onlar basamağı, b birler basamağı), bu sayının değeri cebirsel olarak 10a+b şeklinde ifade edilir. Üç basamaklı "abc" sayısı ise 100a+10b+c olarak yazılır. Bu gösterim, basamaklar arası ilişkili problemleri denklemle çözmenin temelidir. Rakamları yer değiştirilen iki basamaklı bir sayı ile orijinal sayı arasındaki fark her zaman 9''un katıdır: "ab" sayısı (10a+b) ile yer değiştirmiş hâli "ba" (10b+a) arasındaki fark (10a+b)−(10b+a) = 9(a−b) formülüyle bulunur; yani fark, basamaklar arasındaki farkın 9 katına eşittir.

## Çözümlü Örnek: Rakam Yer Değiştirme Farkı
İki basamaklı bir sayının onlar basamağı, birler basamağından 4 fazladır. Rakamlar yer değiştirdiğinde elde edilen yeni sayı ile eski sayı arasındaki fark kaçtır? Formülden fark = 9×(a−b) = 9×4 = 36 bulunur. Bu kısayol, her seferinde iki sayıyı ayrı ayrı yazıp çıkarma işlemi yapmak yerine doğrudan sonuca ulaştırır ve sınavda önemli ölçüde zaman kazandırır; üç basamaklı sayılarda benzer mantıkla ABC ile CBA arasındaki fark 99×(A−C) formülüyle bulunabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1)
  and tc.content_md not like '%## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü%';

-- konu: Sayı Basamakları (Matematik / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü
İki basamaklı bir sayı "ab" biçiminde yazıldığında (a onlar basamağı, b birler basamağı), bu sayının değeri cebirsel olarak 10a+b şeklinde ifade edilir. Üç basamaklı "abc" sayısı ise 100a+10b+c olarak yazılır. Bu gösterim, basamaklar arası ilişkili problemleri denklemle çözmenin temelidir. Rakamları yer değiştirilen iki basamaklı bir sayı ile orijinal sayı arasındaki fark her zaman 9''un katıdır: "ab" sayısı (10a+b) ile yer değiştirmiş hâli "ba" (10b+a) arasındaki fark (10a+b)−(10b+a) = 9(a−b) formülüyle bulunur; yani fark, basamaklar arasındaki farkın 9 katına eşittir.

## Çözümlü Örnek: Rakam Yer Değiştirme Farkı
İki basamaklı bir sayının onlar basamağı, birler basamağından 4 fazladır. Rakamlar yer değiştirdiğinde elde edilen yeni sayı ile eski sayı arasındaki fark kaçtır? Formülden fark = 9×(a−b) = 9×4 = 36 bulunur. Bu kısayol, her seferinde iki sayıyı ayrı ayrı yazıp çıkarma işlemi yapmak yerine doğrudan sonuca ulaştırır ve sınavda önemli ölçüde zaman kazandırır; üç basamaklı sayılarda benzer mantıkla ABC ile CBA arasındaki fark 99×(A−C) formülüyle bulunabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1)
  and tc.content_md not like '%## Sayının Cebirsel Gösterimi ve Rakam Yer Değiştirme Formülü%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?', 'Basamak değeri ile rakamlar toplamı kavramlarını ayırt eder.', 'Bir sayıdaki rakamların basamak değerleri toplamı her zaman sayının kendisine eşittir: 300+50+8=358. Bunu rakamların sayı değerleri toplamı olan 3+5+8=16 ile karıştırmamak gerekir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('358', true, 1),
  ('16', false, 4),
  ('300', false, 3),
  ('305', false, 2),
  ('800', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?', 'Basamak değeri ile rakamlar toplamı kavramlarını ayırt eder.', 'Bir sayıdaki rakamların basamak değerleri toplamı her zaman sayının kendisine eşittir: 300+50+8=358. Bunu rakamların sayı değerleri toplamı olan 3+5+8=16 ile karıştırmamak gerekir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('358', true, 1),
  ('16', false, 4),
  ('300', false, 3),
  ('305', false, 2),
  ('800', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?', 'Basamak değeri ile rakamlar toplamı kavramlarını ayırt eder.', 'Bir sayıdaki rakamların basamak değerleri toplamı her zaman sayının kendisine eşittir: 300+50+8=358. Bunu rakamların sayı değerleri toplamı olan 3+5+8=16 ile karıştırmamak gerekir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '358 sayısındaki rakamların basamak DEĞERLERİ toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('358', true, 1),
  ('16', false, 4),
  ('300', false, 3),
  ('305', false, 2),
  ('800', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?', 'Verilen rakamlarla en büyük ve en küçük sayıyı oluşturma tekniğini uygular.', 'En büyük sayı, rakamlar büyükten küçüğe sıralanarak elde edilir: 741. En küçük sayı, rakamlar küçükten büyüğe sıralanarak elde edilir: 147. Toplam: 741+147=888.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('888', true, 3),
  ('594', false, 0),
  ('812', false, 2),
  ('900', false, 1),
  ('684', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?', 'Verilen rakamlarla en büyük ve en küçük sayıyı oluşturma tekniğini uygular.', 'En büyük sayı, rakamlar büyükten küçüğe sıralanarak elde edilir: 741. En küçük sayı, rakamlar küçükten büyüğe sıralanarak elde edilir: 147. Toplam: 741+147=888.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('888', true, 3),
  ('594', false, 0),
  ('812', false, 2),
  ('900', false, 1),
  ('684', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?', 'Verilen rakamlarla en büyük ve en küçük sayıyı oluşturma tekniğini uygular.', 'En büyük sayı, rakamlar büyükten küçüğe sıralanarak elde edilir: 741. En küçük sayı, rakamlar küçükten büyüğe sıralanarak elde edilir: 147. Toplam: 741+147=888.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1, 4, 7 rakamları (tekrarsız) kullanılarak yazılabilecek en büyük üç basamaklı sayı ile en küçük üç basamaklı sayının toplamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('888', true, 3),
  ('594', false, 0),
  ('812', false, 2),
  ('900', false, 1),
  ('684', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?', 'Basamaklar arası ilişkiyi denklemle ifade edip sayıyı bulur.', 'Onlar basamağı a, birler basamağı b=2a olsun. a+b=12 ⟹ a+2a=12 ⟹ 3a=12 ⟹ a=4, b=8. Sayının kendisi 10a+b = 40+8 = 48''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('48', true, 1),
  ('84', false, 0),
  ('66', false, 4),
  ('36', false, 3),
  ('28', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?', 'Basamaklar arası ilişkiyi denklemle ifade edip sayıyı bulur.', 'Onlar basamağı a, birler basamağı b=2a olsun. a+b=12 ⟹ a+2a=12 ⟹ 3a=12 ⟹ a=4, b=8. Sayının kendisi 10a+b = 40+8 = 48''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('48', true, 1),
  ('84', false, 0),
  ('66', false, 4),
  ('36', false, 3),
  ('28', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?', 'Basamaklar arası ilişkiyi denklemle ifade edip sayıyı bulur.', 'Onlar basamağı a, birler basamağı b=2a olsun. a+b=12 ⟹ a+2a=12 ⟹ 3a=12 ⟹ a=4, b=8. Sayının kendisi 10a+b = 40+8 = 48''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İki basamaklı bir sayının birler basamağı, onlar basamağının 2 katıdır. Bu sayının rakamları toplamı 12 olduğuna göre sayının kendisi kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('48', true, 1),
  ('84', false, 0),
  ('66', false, 4),
  ('36', false, 3),
  ('28', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?', 'Basamak değeri, rakam tekrarı ve bölünebilme kısıtlarını birlikte değerlendirerek sayı oluşturur.', '5 ile bölünen sayının son rakamı 0 veya 5 olmalıdır. 100''den başlayarak kontrol edilirse 100 ve 110''da rakam tekrarı vardır; 120 geçerli olsa da (0 veya 5 ile bitip rakamları farklı) ondan küçük olan 105 (1, 0, 5 rakamları farklı, 5 ile biter) koşulu sağlayan en küçük sayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('105', true, 0),
  ('100', false, 4),
  ('120', false, 1),
  ('150', false, 2),
  ('110', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?', 'Basamak değeri, rakam tekrarı ve bölünebilme kısıtlarını birlikte değerlendirerek sayı oluşturur.', '5 ile bölünen sayının son rakamı 0 veya 5 olmalıdır. 100''den başlayarak kontrol edilirse 100 ve 110''da rakam tekrarı vardır; 120 geçerli olsa da (0 veya 5 ile bitip rakamları farklı) ondan küçük olan 105 (1, 0, 5 rakamları farklı, 5 ile biter) koşulu sağlayan en küçük sayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('105', true, 0),
  ('100', false, 4),
  ('120', false, 1),
  ('150', false, 2),
  ('110', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?', 'Basamak değeri, rakam tekrarı ve bölünebilme kısıtlarını birlikte değerlendirerek sayı oluşturur.', '5 ile bölünen sayının son rakamı 0 veya 5 olmalıdır. 100''den başlayarak kontrol edilirse 100 ve 110''da rakam tekrarı vardır; 120 geçerli olsa da (0 veya 5 ile bitip rakamları farklı) ondan küçük olan 105 (1, 0, 5 rakamları farklı, 5 ile biter) koşulu sağlayan en küçük sayıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Rakamları birbirinden farklı, 5 ile tam bölünen üç basamaklı en küçük sayı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('105', true, 0),
  ('100', false, 4),
  ('120', false, 1),
  ('150', false, 2),
  ('110', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?', 'Üç basamaklı sayılarda rakam yer değiştirme farkı formülünü (99×(A−C)) ek bir orana bağlı olarak kullanır.', 'ABC−CBA farkı 99×(A−C) formülüyle bulunur: 99×(A−C)=594 ⟹ A−C=6. Ayrıca A=3C verildiğinden 3C−C=6 ⟹ 2C=6 ⟹ C=3, dolayısıyla A=3×3=9''dur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('9', true, 2),
  ('6', false, 4),
  ('3', false, 3),
  ('5', false, 1),
  ('2', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?', 'Üç basamaklı sayılarda rakam yer değiştirme farkı formülünü (99×(A−C)) ek bir orana bağlı olarak kullanır.', 'ABC−CBA farkı 99×(A−C) formülüyle bulunur: 99×(A−C)=594 ⟹ A−C=6. Ayrıca A=3C verildiğinden 3C−C=6 ⟹ 2C=6 ⟹ C=3, dolayısıyla A=3×3=9''dur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('9', true, 2),
  ('6', false, 4),
  ('3', false, 3),
  ('5', false, 1),
  ('2', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Sayı Basamakları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?', 'Üç basamaklı sayılarda rakam yer değiştirme farkı formülünü (99×(A−C)) ek bir orana bağlı olarak kullanır.', 'ABC−CBA farkı 99×(A−C) formülüyle bulunur: 99×(A−C)=594 ⟹ A−C=6. Ayrıca A=3C verildiğinden 3C−C=6 ⟹ 2C=6 ⟹ C=3, dolayısıyla A=3×3=9''dur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Üç basamaklı bir ABC sayısında A rakamı, C rakamının 3 katıdır. ABC sayısı ile rakamları ters çevrilmiş CBA sayısı arasındaki fark 594 olduğuna göre A rakamı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('9', true, 2),
  ('6', false, 4),
  ('3', false, 3),
  ('5', false, 1),
  ('2', false, 0)
) as v(choice_text, is_correct, order_index);

-- konu: Rasyonel Sayılar (Matematik / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm
Payı paydasından büyük olan kesirlere bileşik kesir denir; bu kesirler tam sayı + kesir biçiminde (tam sayılı kesir) yazılabilir. Bileşik kesri tam sayılı kesre çevirmek için pay paydaya bölünür: bölüm tam sayı kısmını, kalan ise yeni kesrin payını oluşturur (payda aynı kalır). Örnek: 17/5 kesrinde 17÷5 = 3 kalan 2 olduğundan 17/5 = 3 tam 2/5''tir. Tersi yönde, tam sayılı kesri bileşik kesre çevirmek için tam sayı payda ile çarpılıp paya eklenir: 3 tam 2/5 = (3×5+2)/5 = 17/5.

## Çapraz Çarpma ile Hızlı Karşılaştırma
İki kesri (a/b ve c/d; b,d>0) karşılaştırırken ortak paydaya getirmeden ÇAPRAZ ÇARPMA yöntemi kullanılabilir: a×d ile b×c çarpımları karşılaştırılır; a×d > b×c ise a/b > c/d''dir. Örnek: 5/7 ile 4/6 kesirlerini karşılaştırmak için 5×6=30 ile 7×4=28 çarpımlarına bakılır; 30>28 olduğundan 5/7 > 4/6''dır. SIK YAPILAN HATA: kesir toplama işleminde payda eşitlemeden doğrudan "pay payla, payda paydayla" toplanmasıdır (örneğin 1/2 + 1/3 = 2/5 gibi yanlış bir sonuca ulaşılması) — bu işlem kesinlikle yanlıştır, toplama ancak ortak paydaya getirildikten sonra yapılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1)
  and tc.content_md not like '%## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm%';

-- konu: Rasyonel Sayılar (Matematik / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm
Payı paydasından büyük olan kesirlere bileşik kesir denir; bu kesirler tam sayı + kesir biçiminde (tam sayılı kesir) yazılabilir. Bileşik kesri tam sayılı kesre çevirmek için pay paydaya bölünür: bölüm tam sayı kısmını, kalan ise yeni kesrin payını oluşturur (payda aynı kalır). Örnek: 17/5 kesrinde 17÷5 = 3 kalan 2 olduğundan 17/5 = 3 tam 2/5''tir. Tersi yönde, tam sayılı kesri bileşik kesre çevirmek için tam sayı payda ile çarpılıp paya eklenir: 3 tam 2/5 = (3×5+2)/5 = 17/5.

## Çapraz Çarpma ile Hızlı Karşılaştırma
İki kesri (a/b ve c/d; b,d>0) karşılaştırırken ortak paydaya getirmeden ÇAPRAZ ÇARPMA yöntemi kullanılabilir: a×d ile b×c çarpımları karşılaştırılır; a×d > b×c ise a/b > c/d''dir. Örnek: 5/7 ile 4/6 kesirlerini karşılaştırmak için 5×6=30 ile 7×4=28 çarpımlarına bakılır; 30>28 olduğundan 5/7 > 4/6''dır. SIK YAPILAN HATA: kesir toplama işleminde payda eşitlemeden doğrudan "pay payla, payda paydayla" toplanmasıdır (örneğin 1/2 + 1/3 = 2/5 gibi yanlış bir sonuca ulaşılması) — bu işlem kesinlikle yanlıştır, toplama ancak ortak paydaya getirildikten sonra yapılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1)
  and tc.content_md not like '%## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm%';

-- konu: Rasyonel Sayılar (Matematik / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm
Payı paydasından büyük olan kesirlere bileşik kesir denir; bu kesirler tam sayı + kesir biçiminde (tam sayılı kesir) yazılabilir. Bileşik kesri tam sayılı kesre çevirmek için pay paydaya bölünür: bölüm tam sayı kısmını, kalan ise yeni kesrin payını oluşturur (payda aynı kalır). Örnek: 17/5 kesrinde 17÷5 = 3 kalan 2 olduğundan 17/5 = 3 tam 2/5''tir. Tersi yönde, tam sayılı kesri bileşik kesre çevirmek için tam sayı payda ile çarpılıp paya eklenir: 3 tam 2/5 = (3×5+2)/5 = 17/5.

## Çapraz Çarpma ile Hızlı Karşılaştırma
İki kesri (a/b ve c/d; b,d>0) karşılaştırırken ortak paydaya getirmeden ÇAPRAZ ÇARPMA yöntemi kullanılabilir: a×d ile b×c çarpımları karşılaştırılır; a×d > b×c ise a/b > c/d''dir. Örnek: 5/7 ile 4/6 kesirlerini karşılaştırmak için 5×6=30 ile 7×4=28 çarpımlarına bakılır; 30>28 olduğundan 5/7 > 4/6''dır. SIK YAPILAN HATA: kesir toplama işleminde payda eşitlemeden doğrudan "pay payla, payda paydayla" toplanmasıdır (örneğin 1/2 + 1/3 = 2/5 gibi yanlış bir sonuca ulaşılması) — bu işlem kesinlikle yanlıştır, toplama ancak ortak paydaya getirildikten sonra yapılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1)
  and tc.content_md not like '%## Tam Sayılı (Bileşik) Kesirler ve Dönüşüm%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?', 'Bileşik kesri tam sayılı kesre dönüştürür.', '23, 6''ya bölündüğünde bölüm 3, kalan 5 elde edilir (6×3=18, 23−18=5). Bu nedenle 23/6 = 3 tam 5/6 biçiminde yazılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3 tam 5/6', true, 0),
  ('3 tam 6/5', false, 3),
  ('4 tam 1/6', false, 2),
  ('3 tam 4/6', false, 1),
  ('2 tam 11/6', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?', 'Bileşik kesri tam sayılı kesre dönüştürür.', '23, 6''ya bölündüğünde bölüm 3, kalan 5 elde edilir (6×3=18, 23−18=5). Bu nedenle 23/6 = 3 tam 5/6 biçiminde yazılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3 tam 5/6', true, 0),
  ('3 tam 6/5', false, 3),
  ('4 tam 1/6', false, 2),
  ('3 tam 4/6', false, 1),
  ('2 tam 11/6', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?', 'Bileşik kesri tam sayılı kesre dönüştürür.', '23, 6''ya bölündüğünde bölüm 3, kalan 5 elde edilir (6×3=18, 23−18=5). Bu nedenle 23/6 = 3 tam 5/6 biçiminde yazılır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '23/6 bileşik kesrinin tam sayılı kesir biçimi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3 tam 5/6', true, 0),
  ('3 tam 6/5', false, 3),
  ('4 tam 1/6', false, 2),
  ('3 tam 4/6', false, 1),
  ('2 tam 11/6', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5/8 ile 3/8 kesirlerinin farkı kaçtır?', 'Paydaları eşit kesirlerde çıkarma işlemi yapar ve sonucu sadeleştirir.', 'Paydalar eşit olduğundan sadece paylar çıkarılır: 5/8 − 3/8 = 2/8. Bu kesir 2''ye sadeleştirilirse 1/4 elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5/8 ile 3/8 kesirlerinin farkı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1/4', true, 0),
  ('1', false, 2),
  ('2/5', false, 1),
  ('5/3', false, 4),
  ('3/8', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5/8 ile 3/8 kesirlerinin farkı kaçtır?', 'Paydaları eşit kesirlerde çıkarma işlemi yapar ve sonucu sadeleştirir.', 'Paydalar eşit olduğundan sadece paylar çıkarılır: 5/8 − 3/8 = 2/8. Bu kesir 2''ye sadeleştirilirse 1/4 elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5/8 ile 3/8 kesirlerinin farkı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1/4', true, 0),
  ('1', false, 2),
  ('2/5', false, 1),
  ('5/3', false, 4),
  ('3/8', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '5/8 ile 3/8 kesirlerinin farkı kaçtır?', 'Paydaları eşit kesirlerde çıkarma işlemi yapar ve sonucu sadeleştirir.', 'Paydalar eşit olduğundan sadece paylar çıkarılır: 5/8 − 3/8 = 2/8. Bu kesir 2''ye sadeleştirilirse 1/4 elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '5/8 ile 3/8 kesirlerinin farkı kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1/4', true, 0),
  ('1', false, 2),
  ('2/5', false, 1),
  ('5/3', false, 4),
  ('3/8', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri ondalık karşılıklarına veya ortak paydaya çevirerek büyüklüklerine göre sıralar.', 'Kesirler ondalık sayıya çevrilirse: 7/9≈0,778; 5/6≈0,833; 11/12≈0,917. Bu değerler küçükten büyüğe sıralanırsa 7/9 < 5/6 < 11/12 sıralaması elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7/9 < 5/6 < 11/12', true, 0),
  ('5/6 < 7/9 < 11/12', false, 3),
  ('7/9 < 11/12 < 5/6', false, 4),
  ('11/12 < 5/6 < 7/9', false, 2),
  ('5/6 < 11/12 < 7/9', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri ondalık karşılıklarına veya ortak paydaya çevirerek büyüklüklerine göre sıralar.', 'Kesirler ondalık sayıya çevrilirse: 7/9≈0,778; 5/6≈0,833; 11/12≈0,917. Bu değerler küçükten büyüğe sıralanırsa 7/9 < 5/6 < 11/12 sıralaması elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7/9 < 5/6 < 11/12', true, 0),
  ('5/6 < 7/9 < 11/12', false, 3),
  ('7/9 < 11/12 < 5/6', false, 4),
  ('11/12 < 5/6 < 7/9', false, 2),
  ('5/6 < 11/12 < 7/9', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?', 'Kesirleri ondalık karşılıklarına veya ortak paydaya çevirerek büyüklüklerine göre sıralar.', 'Kesirler ondalık sayıya çevrilirse: 7/9≈0,778; 5/6≈0,833; 11/12≈0,917. Bu değerler küçükten büyüğe sıralanırsa 7/9 < 5/6 < 11/12 sıralaması elde edilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '7/9, 5/6, 11/12 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('7/9 < 5/6 < 11/12', true, 0),
  ('5/6 < 7/9 < 11/12', false, 3),
  ('7/9 < 11/12 < 5/6', false, 4),
  ('11/12 < 5/6 < 7/9', false, 2),
  ('5/6 < 11/12 < 7/9', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?', 'Bir sayının kesri verildiğinde sayının tamamını bulma problemini çözer.', '(3/8) × x = 15 denklemi kurulur. Buradan x = 15 ÷ (3/8) = 15 × (8/3) = 40 bulunur; sınıf mevcudu 40 kişidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('40', true, 3),
  ('45', false, 0),
  ('120', false, 4),
  ('25', false, 2),
  ('5', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?', 'Bir sayının kesri verildiğinde sayının tamamını bulma problemini çözer.', '(3/8) × x = 15 denklemi kurulur. Buradan x = 15 ÷ (3/8) = 15 × (8/3) = 40 bulunur; sınıf mevcudu 40 kişidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('40', true, 3),
  ('45', false, 0),
  ('120', false, 4),
  ('25', false, 2),
  ('5', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?', 'Bir sayının kesri verildiğinde sayının tamamını bulma problemini çözer.', '(3/8) × x = 15 denklemi kurulur. Buradan x = 15 ÷ (3/8) = 15 × (8/3) = 40 bulunur; sınıf mevcudu 40 kişidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir sınıftaki öğrencilerin 3/8''i kız öğrencidir. Kız öğrenci sayısı 15 olduğuna göre sınıf mevcudu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('40', true, 3),
  ('45', false, 0),
  ('120', false, 4),
  ('25', false, 2),
  ('5', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?', 'Tam sayılı kesir içeren karma çarpma-bölme-toplama işlemlerini işlem önceliğine göre yapar.', '1 tam 1/2 = 3/2 olduğundan ilk terim: (3/2)×(2/3) = 1. İkinci terim: (1/4)÷(1/2) = (1/4)×2 = 1/2. Bu iki sonuç toplanır: 1 + 1/2 = 3/2.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3/2', true, 3),
  ('1', false, 0),
  ('1/2', false, 4),
  ('9/8', false, 2),
  ('7/4', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?', 'Tam sayılı kesir içeren karma çarpma-bölme-toplama işlemlerini işlem önceliğine göre yapar.', '1 tam 1/2 = 3/2 olduğundan ilk terim: (3/2)×(2/3) = 1. İkinci terim: (1/4)÷(1/2) = (1/4)×2 = 1/2. Bu iki sonuç toplanır: 1 + 1/2 = 3/2.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3/2', true, 3),
  ('1', false, 0),
  ('1/2', false, 4),
  ('9/8', false, 2),
  ('7/4', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Rasyonel Sayılar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?', 'Tam sayılı kesir içeren karma çarpma-bölme-toplama işlemlerini işlem önceliğine göre yapar.', '1 tam 1/2 = 3/2 olduğundan ilk terim: (3/2)×(2/3) = 1. İkinci terim: (1/4)÷(1/2) = (1/4)×2 = 1/2. Bu iki sonuç toplanır: 1 + 1/2 = 3/2.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '(1 tam 1/2) × (2/3) + (1/4) ÷ (1/2) işleminin sonucu kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('3/2', true, 3),
  ('1', false, 0),
  ('1/2', false, 4),
  ('9/8', false, 2),
  ('7/4', false, 1)
) as v(choice_text, is_correct, order_index);

-- konu: Problemler (Matematik / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karışım (Alaşım) Problemleri
Karışım problemlerinde farklı yüzdelerde (veya fiyatlarda) iki maddenin belirli miktarlarda karıştırılmasıyla oluşan yeni karışımın yüzdesi (veya fiyatı) hesaplanır. Temel yöntem: her maddenin miktarı ile o maddenin yüzdesinin (fiyatının) çarpımları toplanır ve bu toplam, toplam miktara bölünür — yani AĞIRLIKLI ORTALAMA alınır. Örneğin %20 tuz oranına sahip 3 kg su ile %50 tuz oranına sahip 2 kg su karıştırıldığında karışımın tuz oranı: (3×20+2×50)/(3+2) = (60+100)/5 = %32 olur. SIK YAPILAN HATA: iki yüzdenin basit aritmetik ortalamasını almaktır (%20 ve %50''nin ortalaması %35 gibi) — bu ancak miktarlar EŞİT olduğunda doğrudur, miktarlar farklıysa AĞIRLIKLI ortalama kullanılmalıdır.

## Ortalama (Aritmetik Ortalama) İçeren Problemler
n tane sayının aritmetik ortalaması, bu sayıların toplamının n''e bölünmesiyle bulunur: Ortalama = Toplam/n, dolayısıyla Toplam = Ortalama × n bağıntısı problem çözümünde sıkça ters yönde kullanılır. "Bir öğrencinin 4 sınav notunun ortalaması 70''tir, 5. sınavdan kaç alırsa ortalaması 75 olur?" tarzı sorularda önce mevcut toplam (4×70=280) bulunur, hedeflenen toplam (5×75=375) hesaplanır ve farkları (375−280=95) alınarak 5. sınav notu bulunur. Bu "toplamı sabitleyip hedef toplamdan çıkarma" yöntemi ortalama problemlerinin standart çözüm kısayoludur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1)
  and tc.content_md not like '%## Karışım (Alaşım) Problemleri%';

-- konu: Problemler (Matematik / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karışım (Alaşım) Problemleri
Karışım problemlerinde farklı yüzdelerde (veya fiyatlarda) iki maddenin belirli miktarlarda karıştırılmasıyla oluşan yeni karışımın yüzdesi (veya fiyatı) hesaplanır. Temel yöntem: her maddenin miktarı ile o maddenin yüzdesinin (fiyatının) çarpımları toplanır ve bu toplam, toplam miktara bölünür — yani AĞIRLIKLI ORTALAMA alınır. Örneğin %20 tuz oranına sahip 3 kg su ile %50 tuz oranına sahip 2 kg su karıştırıldığında karışımın tuz oranı: (3×20+2×50)/(3+2) = (60+100)/5 = %32 olur. SIK YAPILAN HATA: iki yüzdenin basit aritmetik ortalamasını almaktır (%20 ve %50''nin ortalaması %35 gibi) — bu ancak miktarlar EŞİT olduğunda doğrudur, miktarlar farklıysa AĞIRLIKLI ortalama kullanılmalıdır.

## Ortalama (Aritmetik Ortalama) İçeren Problemler
n tane sayının aritmetik ortalaması, bu sayıların toplamının n''e bölünmesiyle bulunur: Ortalama = Toplam/n, dolayısıyla Toplam = Ortalama × n bağıntısı problem çözümünde sıkça ters yönde kullanılır. "Bir öğrencinin 4 sınav notunun ortalaması 70''tir, 5. sınavdan kaç alırsa ortalaması 75 olur?" tarzı sorularda önce mevcut toplam (4×70=280) bulunur, hedeflenen toplam (5×75=375) hesaplanır ve farkları (375−280=95) alınarak 5. sınav notu bulunur. Bu "toplamı sabitleyip hedef toplamdan çıkarma" yöntemi ortalama problemlerinin standart çözüm kısayoludur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1)
  and tc.content_md not like '%## Karışım (Alaşım) Problemleri%';

-- konu: Problemler (Matematik / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karışım (Alaşım) Problemleri
Karışım problemlerinde farklı yüzdelerde (veya fiyatlarda) iki maddenin belirli miktarlarda karıştırılmasıyla oluşan yeni karışımın yüzdesi (veya fiyatı) hesaplanır. Temel yöntem: her maddenin miktarı ile o maddenin yüzdesinin (fiyatının) çarpımları toplanır ve bu toplam, toplam miktara bölünür — yani AĞIRLIKLI ORTALAMA alınır. Örneğin %20 tuz oranına sahip 3 kg su ile %50 tuz oranına sahip 2 kg su karıştırıldığında karışımın tuz oranı: (3×20+2×50)/(3+2) = (60+100)/5 = %32 olur. SIK YAPILAN HATA: iki yüzdenin basit aritmetik ortalamasını almaktır (%20 ve %50''nin ortalaması %35 gibi) — bu ancak miktarlar EŞİT olduğunda doğrudur, miktarlar farklıysa AĞIRLIKLI ortalama kullanılmalıdır.

## Ortalama (Aritmetik Ortalama) İçeren Problemler
n tane sayının aritmetik ortalaması, bu sayıların toplamının n''e bölünmesiyle bulunur: Ortalama = Toplam/n, dolayısıyla Toplam = Ortalama × n bağıntısı problem çözümünde sıkça ters yönde kullanılır. "Bir öğrencinin 4 sınav notunun ortalaması 70''tir, 5. sınavdan kaç alırsa ortalaması 75 olur?" tarzı sorularda önce mevcut toplam (4×70=280) bulunur, hedeflenen toplam (5×75=375) hesaplanır ve farkları (375−280=95) alınarak 5. sınav notu bulunur. Bu "toplamı sabitleyip hedef toplamdan çıkarma" yöntemi ortalama problemlerinin standart çözüm kısayoludur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1)
  and tc.content_md not like '%## Karışım (Alaşım) Problemleri%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?', 'Toplam = Ortalama × n bağıntısını kullanarak yeni ortalamayı hesaplar.', 'İlk 3 sınavın toplamı 3×60=180''dir. 4. sınav notu eklenince toplam 180+80=260 olur. 4 sınavın ortalaması ise 260÷4=65''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('65', true, 0),
  ('70', false, 2),
  ('260', false, 1),
  ('60', false, 3),
  ('50', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?', 'Toplam = Ortalama × n bağıntısını kullanarak yeni ortalamayı hesaplar.', 'İlk 3 sınavın toplamı 3×60=180''dir. 4. sınav notu eklenince toplam 180+80=260 olur. 4 sınavın ortalaması ise 260÷4=65''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('65', true, 0),
  ('70', false, 2),
  ('260', false, 1),
  ('60', false, 3),
  ('50', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?', 'Toplam = Ortalama × n bağıntısını kullanarak yeni ortalamayı hesaplar.', 'İlk 3 sınavın toplamı 3×60=180''dir. 4. sınav notu eklenince toplam 180+80=260 olur. 4 sınavın ortalaması ise 260÷4=65''tir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir öğrencinin 3 sınav notunun ortalaması 60''tır. 4. sınavdan 80 aldığına göre 4 sınavın ortalaması kaç olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('65', true, 0),
  ('70', false, 2),
  ('260', false, 1),
  ('60', false, 3),
  ('50', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?', 'Farklı miktar ve oranlardaki iki karışımın birleştirilmesiyle oluşan yeni oranı ağırlıklı ortalama ile hesaplar.', 'Karışımdaki toplam tuz miktarı (4×10)+(6×30) = 40+180 = 220''dir. Toplam miktar 4+6=10 kg olduğundan yeni oran 220÷10 = %22''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('22', true, 0),
  ('20', false, 2),
  ('18', false, 1),
  ('40', false, 4),
  ('16', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?', 'Farklı miktar ve oranlardaki iki karışımın birleştirilmesiyle oluşan yeni oranı ağırlıklı ortalama ile hesaplar.', 'Karışımdaki toplam tuz miktarı (4×10)+(6×30) = 40+180 = 220''dir. Toplam miktar 4+6=10 kg olduğundan yeni oran 220÷10 = %22''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('22', true, 0),
  ('20', false, 2),
  ('18', false, 1),
  ('40', false, 4),
  ('16', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?', 'Farklı miktar ve oranlardaki iki karışımın birleştirilmesiyle oluşan yeni oranı ağırlıklı ortalama ile hesaplar.', 'Karışımdaki toplam tuz miktarı (4×10)+(6×30) = 40+180 = 220''dir. Toplam miktar 4+6=10 kg olduğundan yeni oran 220÷10 = %22''dir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '%10 tuz oranına sahip 4 kg su ile %30 tuz oranına sahip 6 kg su karıştırılıyor. Elde edilen karışımın tuz oranı yüzde kaçtır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('22', true, 0),
  ('20', false, 2),
  ('18', false, 1),
  ('40', false, 4),
  ('16', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?', 'Aynı yönde hareket eden iki aracın yetişme süresini hız farkı yöntemiyle bulur.', 'İlk araç 2 saatte 80×2=160 km yol almış, ikinci araca göre bu kadar öndedir. Aynı yönde hareket edildiğinden hız farkı kullanılır: 100−80=20 km/sa. Yetişme süresi = 160÷20 = 8 saattir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('8', true, 2),
  ('2', false, 3),
  ('16', false, 4),
  ('4', false, 0),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?', 'Aynı yönde hareket eden iki aracın yetişme süresini hız farkı yöntemiyle bulur.', 'İlk araç 2 saatte 80×2=160 km yol almış, ikinci araca göre bu kadar öndedir. Aynı yönde hareket edildiğinden hız farkı kullanılır: 100−80=20 km/sa. Yetişme süresi = 160÷20 = 8 saattir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('8', true, 2),
  ('2', false, 3),
  ('16', false, 4),
  ('4', false, 0),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?', 'Aynı yönde hareket eden iki aracın yetişme süresini hız farkı yöntemiyle bulur.', 'İlk araç 2 saatte 80×2=160 km yol almış, ikinci araca göre bu kadar öndedir. Aynı yönde hareket edildiğinden hız farkı kullanılır: 100−80=20 km/sa. Yetişme süresi = 160÷20 = 8 saattir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir araç saatte 80 km hızla yola çıkıyor. Ondan 2 saat sonra aynı noktadan aynı yönde saatte 100 km hızla ikinci bir araç yola çıkıyor. İkinci araç, birinciye kaç saat sonra (kendi yola çıkışından itibaren) yetişir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('8', true, 2),
  ('2', false, 3),
  ('16', false, 4),
  ('4', false, 0),
  ('10', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?', 'Ardışık yüzde değişimlerinde çarpanları sırayla uygulayarak son fiyatı bulur.', 'Önce %30 kârla satış fiyatı: 500×1,30=650 TL. Ardından bu fiyat üzerinden %10 indirim uygulanır: 650×0,90=585 TL. Yüzdeler doğrudan toplanıp çıkarılamaz (%30−%10=%20 gibi bir işlem yanlıştır); her adım bir önceki sonuç üzerinden çarpanla uygulanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('585', true, 1),
  ('600', false, 3),
  ('500', false, 4),
  ('650', false, 0),
  ('715', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?', 'Ardışık yüzde değişimlerinde çarpanları sırayla uygulayarak son fiyatı bulur.', 'Önce %30 kârla satış fiyatı: 500×1,30=650 TL. Ardından bu fiyat üzerinden %10 indirim uygulanır: 650×0,90=585 TL. Yüzdeler doğrudan toplanıp çıkarılamaz (%30−%10=%20 gibi bir işlem yanlıştır); her adım bir önceki sonuç üzerinden çarpanla uygulanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('585', true, 1),
  ('600', false, 3),
  ('500', false, 4),
  ('650', false, 0),
  ('715', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?', 'Ardışık yüzde değişimlerinde çarpanları sırayla uygulayarak son fiyatı bulur.', 'Önce %30 kârla satış fiyatı: 500×1,30=650 TL. Ardından bu fiyat üzerinden %10 indirim uygulanır: 650×0,90=585 TL. Yüzdeler doğrudan toplanıp çıkarılamaz (%30−%10=%20 gibi bir işlem yanlıştır); her adım bir önceki sonuç üzerinden çarpanla uygulanmalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '500 TL''ye alınan bir ürün önce %30 kârla satılıyor, ardından bu satış fiyatı üzerinden %10 indirim yapılarak yeniden satılıyor. Bu ürünün son satış fiyatı kaç TL''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('585', true, 1),
  ('600', false, 3),
  ('500', false, 4),
  ('650', false, 0),
  ('715', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?', 'Birlikte başlayıp bir işçinin yarıda ayrıldığı işçi/havuz problemlerinde kalan işi hesaplayarak toplam süreyi bulur.', 'A''nın günlük iş oranı 1/12, B''ninki 1/8''dir. 3 gün birlikte çalışıldığında yapılan iş: 3×(1/12+1/8)=3×(5/24)=15/24=5/8''dir. Kalan iş 1−5/8=3/8''dir. B bu kalanı tek başına (3/8)÷(1/8)=3 günde bitirir. Toplam süre, A''nın çalıştığı 3 gün ile B''nin yalnız çalıştığı 3 günün toplamı olan 6 gündür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('6', true, 4),
  ('8', false, 0),
  ('3', false, 1),
  ('9', false, 3),
  ('5', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?', 'Birlikte başlayıp bir işçinin yarıda ayrıldığı işçi/havuz problemlerinde kalan işi hesaplayarak toplam süreyi bulur.', 'A''nın günlük iş oranı 1/12, B''ninki 1/8''dir. 3 gün birlikte çalışıldığında yapılan iş: 3×(1/12+1/8)=3×(5/24)=15/24=5/8''dir. Kalan iş 1−5/8=3/8''dir. B bu kalanı tek başına (3/8)÷(1/8)=3 günde bitirir. Toplam süre, A''nın çalıştığı 3 gün ile B''nin yalnız çalıştığı 3 günün toplamı olan 6 gündür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('6', true, 4),
  ('8', false, 0),
  ('3', false, 1),
  ('9', false, 3),
  ('5', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Matematik' and t.name = 'Problemler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?', 'Birlikte başlayıp bir işçinin yarıda ayrıldığı işçi/havuz problemlerinde kalan işi hesaplayarak toplam süreyi bulur.', 'A''nın günlük iş oranı 1/12, B''ninki 1/8''dir. 3 gün birlikte çalışıldığında yapılan iş: 3×(1/12+1/8)=3×(5/24)=15/24=5/8''dir. Kalan iş 1−5/8=3/8''dir. B bu kalanı tek başına (3/8)÷(1/8)=3 günde bitirir. Toplam süre, A''nın çalıştığı 3 gün ile B''nin yalnız çalıştığı 3 günün toplamı olan 6 gündür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir işi A işçisi tek başına 12 günde, B işçisi tek başına 8 günde bitirebiliyor. İkisi birlikte işe başlıyor, ancak A işçisi 3 gün çalıştıktan sonra ayrılıyor ve işin geri kalanını B tek başına bitiriyor. İş toplamda kaç günde bitmiş olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('6', true, 4),
  ('8', false, 0),
  ('3', false, 1),
  ('9', false, 3),
  ('5', false, 2)
) as v(choice_text, is_correct, order_index);

-- ============ Tarih ============
-- konu: İlk Türk Devletleri (Tarih / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti
Mete Han''ın ölümünün ardından tahta geçen hükümdarlar döneminde Çin, Hun birliğini doğrudan savaşla değil "denge siyaseti" ile zayıflatmaya çalışmıştır: Hun beylerine unvan ve hediyeler vererek onları birbirine düşürmüş, Çinli prensesleri Hun hükümdarlarıyla evlendirerek akrabalık bağı kurmuş ve böylece Hunları içeriden bölmeyi amaçlamıştır. Bu baskılar sonucunda Asya Hun Devleti MÖ 58''de Doğu Hun ve Batı Hun olmak üzere ikiye ayrılmıştır; Doğu Hunları zamanla Çin''in etki alanına girerken, Batı Hunları bağımsızlığını bir süre daha korumuştur. Bu tarih, yüzyıllar sonra Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle sıklıkla karıştırılır; oysa aralarında yaklaşık 400 yıllık bir fark vardır ve iki olay birbirinden tamamen bağımsızdır. Ayrıca Mete Han''ın Orta Asya''daki fütuhatı sırasında batıya sürdüğü Yüeçiler (Yuezhi), zamanla Orta Asya''da Kuşan İmparatorluğu''nun temellerini atmıştır; bu da Hun baskısının yalnızca Çin sınırında değil, Orta Asya''nın siyasi haritasında da kalıcı sonuçlar doğurduğunu gösterir.

## Uygur Alfabesi ve Yazılı Kültürün Mirası
Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir; bu yazı sistemi taşlara oyularak yazılan Göktürk alfabesinden farklı olarak kağıda yazılmaya ve matbaa ile çoğaltılmaya elverişliydi. Bu teknik avantaj, Budist ve Maniheist dini metinlerin hızla çoğaltılıp yaygınlaştırılmasını kolaylaştırmış; Uygurlar bu sayede Türk tarihinde matbaayı kullanan ilk topluluk olarak da anılır. Uygur Devleti 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmasına rağmen, Uygur alfabesi devletin siyasi varlığından çok daha uzun ömürlü olmuştur: Cengiz Han döneminde Moğollar, ardından Karahanlılar ve Timur İmparatorluğu bu alfabeyi resmi yazışmalarında kullanmaya devam etmiştir. Yıkılışın ardından Turfan ve Kansu bölgesine yerleşen Uygurlar, yüksek okuryazarlık düzeyleri sayesinde daha sonra Moğol İmparatorluğu''nun idari ve mali kadrolarında kâtip ve memur olarak istihdam edilmiş, bu konumlarıyla Moğol bürokrasisinin şekillenmesine katkı sağlamışlardır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1)
  and tc.content_md not like '%## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti%';

-- konu: İlk Türk Devletleri (Tarih / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti
Mete Han''ın ölümünün ardından tahta geçen hükümdarlar döneminde Çin, Hun birliğini doğrudan savaşla değil "denge siyaseti" ile zayıflatmaya çalışmıştır: Hun beylerine unvan ve hediyeler vererek onları birbirine düşürmüş, Çinli prensesleri Hun hükümdarlarıyla evlendirerek akrabalık bağı kurmuş ve böylece Hunları içeriden bölmeyi amaçlamıştır. Bu baskılar sonucunda Asya Hun Devleti MÖ 58''de Doğu Hun ve Batı Hun olmak üzere ikiye ayrılmıştır; Doğu Hunları zamanla Çin''in etki alanına girerken, Batı Hunları bağımsızlığını bir süre daha korumuştur. Bu tarih, yüzyıllar sonra Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle sıklıkla karıştırılır; oysa aralarında yaklaşık 400 yıllık bir fark vardır ve iki olay birbirinden tamamen bağımsızdır. Ayrıca Mete Han''ın Orta Asya''daki fütuhatı sırasında batıya sürdüğü Yüeçiler (Yuezhi), zamanla Orta Asya''da Kuşan İmparatorluğu''nun temellerini atmıştır; bu da Hun baskısının yalnızca Çin sınırında değil, Orta Asya''nın siyasi haritasında da kalıcı sonuçlar doğurduğunu gösterir.

## Uygur Alfabesi ve Yazılı Kültürün Mirası
Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir; bu yazı sistemi taşlara oyularak yazılan Göktürk alfabesinden farklı olarak kağıda yazılmaya ve matbaa ile çoğaltılmaya elverişliydi. Bu teknik avantaj, Budist ve Maniheist dini metinlerin hızla çoğaltılıp yaygınlaştırılmasını kolaylaştırmış; Uygurlar bu sayede Türk tarihinde matbaayı kullanan ilk topluluk olarak da anılır. Uygur Devleti 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmasına rağmen, Uygur alfabesi devletin siyasi varlığından çok daha uzun ömürlü olmuştur: Cengiz Han döneminde Moğollar, ardından Karahanlılar ve Timur İmparatorluğu bu alfabeyi resmi yazışmalarında kullanmaya devam etmiştir. Yıkılışın ardından Turfan ve Kansu bölgesine yerleşen Uygurlar, yüksek okuryazarlık düzeyleri sayesinde daha sonra Moğol İmparatorluğu''nun idari ve mali kadrolarında kâtip ve memur olarak istihdam edilmiş, bu konumlarıyla Moğol bürokrasisinin şekillenmesine katkı sağlamışlardır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1)
  and tc.content_md not like '%## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti%';

-- konu: İlk Türk Devletleri (Tarih / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti
Mete Han''ın ölümünün ardından tahta geçen hükümdarlar döneminde Çin, Hun birliğini doğrudan savaşla değil "denge siyaseti" ile zayıflatmaya çalışmıştır: Hun beylerine unvan ve hediyeler vererek onları birbirine düşürmüş, Çinli prensesleri Hun hükümdarlarıyla evlendirerek akrabalık bağı kurmuş ve böylece Hunları içeriden bölmeyi amaçlamıştır. Bu baskılar sonucunda Asya Hun Devleti MÖ 58''de Doğu Hun ve Batı Hun olmak üzere ikiye ayrılmıştır; Doğu Hunları zamanla Çin''in etki alanına girerken, Batı Hunları bağımsızlığını bir süre daha korumuştur. Bu tarih, yüzyıllar sonra Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle sıklıkla karıştırılır; oysa aralarında yaklaşık 400 yıllık bir fark vardır ve iki olay birbirinden tamamen bağımsızdır. Ayrıca Mete Han''ın Orta Asya''daki fütuhatı sırasında batıya sürdüğü Yüeçiler (Yuezhi), zamanla Orta Asya''da Kuşan İmparatorluğu''nun temellerini atmıştır; bu da Hun baskısının yalnızca Çin sınırında değil, Orta Asya''nın siyasi haritasında da kalıcı sonuçlar doğurduğunu gösterir.

## Uygur Alfabesi ve Yazılı Kültürün Mirası
Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir; bu yazı sistemi taşlara oyularak yazılan Göktürk alfabesinden farklı olarak kağıda yazılmaya ve matbaa ile çoğaltılmaya elverişliydi. Bu teknik avantaj, Budist ve Maniheist dini metinlerin hızla çoğaltılıp yaygınlaştırılmasını kolaylaştırmış; Uygurlar bu sayede Türk tarihinde matbaayı kullanan ilk topluluk olarak da anılır. Uygur Devleti 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmasına rağmen, Uygur alfabesi devletin siyasi varlığından çok daha uzun ömürlü olmuştur: Cengiz Han döneminde Moğollar, ardından Karahanlılar ve Timur İmparatorluğu bu alfabeyi resmi yazışmalarında kullanmaya devam etmiştir. Yıkılışın ardından Turfan ve Kansu bölgesine yerleşen Uygurlar, yüksek okuryazarlık düzeyleri sayesinde daha sonra Moğol İmparatorluğu''nun idari ve mali kadrolarında kâtip ve memur olarak istihdam edilmiş, bu konumlarıyla Moğol bürokrasisinin şekillenmesine katkı sağlamışlardır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1)
  and tc.content_md not like '%## Asya Hun Devleti''nin İkiye Ayrılması ve Çin Siyaseti%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yıkılış sürecini ve sonuçlarını bilir.', 'Uygur Devleti, 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmıştır. Yıkılışın ardından Uygurların bir bölümü Doğu Türkistan (Turfan) ve Kansu bölgesine göç ederek buralarda küçük beylikler kurmuş ve yerleşik kültürlerini sürdürmüştür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Uygur Devleti', true, 1),
  ('Göktürk Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 4),
  ('Asya Hun Devleti', false, 2),
  ('Karahanlı Devleti', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yıkılış sürecini ve sonuçlarını bilir.', 'Uygur Devleti, 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmıştır. Yıkılışın ardından Uygurların bir bölümü Doğu Türkistan (Turfan) ve Kansu bölgesine göç ederek buralarda küçük beylikler kurmuş ve yerleşik kültürlerini sürdürmüştür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Uygur Devleti', true, 1),
  ('Göktürk Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 4),
  ('Asya Hun Devleti', false, 2),
  ('Karahanlı Devleti', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?', 'Uygur Devleti''nin yıkılış sürecini ve sonuçlarını bilir.', 'Uygur Devleti, 840 yılında kuzeyden gelen Kırgızların saldırıları sonucu yıkılmıştır. Yıkılışın ardından Uygurların bir bölümü Doğu Türkistan (Turfan) ve Kansu bölgesine göç ederek buralarda küçük beylikler kurmuş ve yerleşik kültürlerini sürdürmüştür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '840 yılında Kırgızlar tarafından yıkılan, bu yıkılıştan sonra bir kısmı Doğu Türkistan ve Kansu bölgesine göç eden Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Uygur Devleti', true, 1),
  ('Göktürk Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 4),
  ('Asya Hun Devleti', false, 2),
  ('Karahanlı Devleti', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?', 'Göktürk Devleti''nin Türk tarihindeki yerinin ve öneminin farkında olur.', 'Göktürk Devleti, 552 yılında Bumin Kağan tarafından kurulmuş ve ''Türk'' adını resmi devlet adı olarak kullanan ilk Türk devletidir. ''Türk'' kelimesinin ''güçlü, kuvvetli, türeyen, olgunluk çağı'' gibi anlamlara geldiği kabul edilmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göktürk Devleti', true, 4),
  ('Büyük Hun İmparatorluğu', false, 1),
  ('Uygur Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 3),
  ('Karahanlı Devleti', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?', 'Göktürk Devleti''nin Türk tarihindeki yerinin ve öneminin farkında olur.', 'Göktürk Devleti, 552 yılında Bumin Kağan tarafından kurulmuş ve ''Türk'' adını resmi devlet adı olarak kullanan ilk Türk devletidir. ''Türk'' kelimesinin ''güçlü, kuvvetli, türeyen, olgunluk çağı'' gibi anlamlara geldiği kabul edilmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göktürk Devleti', true, 4),
  ('Büyük Hun İmparatorluğu', false, 1),
  ('Uygur Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 3),
  ('Karahanlı Devleti', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?', 'Göktürk Devleti''nin Türk tarihindeki yerinin ve öneminin farkında olur.', 'Göktürk Devleti, 552 yılında Bumin Kağan tarafından kurulmuş ve ''Türk'' adını resmi devlet adı olarak kullanan ilk Türk devletidir. ''Türk'' kelimesinin ''güçlü, kuvvetli, türeyen, olgunluk çağı'' gibi anlamlara geldiği kabul edilmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Türk" adını resmi devlet adı olarak kullanan, bu unvanın ''güçlü, kuvvetli'' anlamına geldiği kabul edilen ilk Türk devleti aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göktürk Devleti', true, 4),
  ('Büyük Hun İmparatorluğu', false, 1),
  ('Uygur Devleti', false, 0),
  ('Avrupa Hun Devleti', false, 3),
  ('Karahanlı Devleti', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?', 'İslamiyet öncesi Türk devletlerinin kronolojisini ve birbirine karıştırılan olayları ayırt eder.', 'Asya (Büyük) Hun Devleti, Mete Han sonrası dönemde Çin''in beylikler arası çekişmeyi körükleyen siyaseti sonucunda MÖ 58 yılında Doğu ve Batı Hun olarak ikiye ayrılmıştır. Bu tarih, Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('MÖ 58', true, 3),
  ('MS 375', false, 1),
  ('MÖ 209', false, 2),
  ('MS 552', false, 4),
  ('MS 840', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?', 'İslamiyet öncesi Türk devletlerinin kronolojisini ve birbirine karıştırılan olayları ayırt eder.', 'Asya (Büyük) Hun Devleti, Mete Han sonrası dönemde Çin''in beylikler arası çekişmeyi körükleyen siyaseti sonucunda MÖ 58 yılında Doğu ve Batı Hun olarak ikiye ayrılmıştır. Bu tarih, Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('MÖ 58', true, 3),
  ('MS 375', false, 1),
  ('MÖ 209', false, 2),
  ('MS 552', false, 4),
  ('MS 840', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?', 'İslamiyet öncesi Türk devletlerinin kronolojisini ve birbirine karıştırılan olayları ayırt eder.', 'Asya (Büyük) Hun Devleti, Mete Han sonrası dönemde Çin''in beylikler arası çekişmeyi körükleyen siyaseti sonucunda MÖ 58 yılında Doğu ve Batı Hun olarak ikiye ayrılmıştır. Bu tarih, Avrupa Hunlarının Kavimler Göçü''nü başlattığı MS 375 tarihiyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Asya Hun Devleti''nin Çin''in denge siyaseti sonucunda Doğu Hun ve Batı Hun olarak ikiye ayrılması hangi tarihte gerçekleşmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('MÖ 58', true, 3),
  ('MS 375', false, 1),
  ('MÖ 209', false, 2),
  ('MS 552', false, 4),
  ('MS 840', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?', 'Uygur Devleti''nin kültürel-yazılı mirasının sonraki Türk-İslam ve Moğol devletlerine etkisini bilir.', 'Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir. Bu alfabe, taşa oyularak yazılan Göktürk (runik) alfabesinden farklı olarak kağıda yazıma uygundu ve devletin yıkılışından sonra da başka devletlerce kullanılmaya devam etmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Soğd alfabesi', true, 0),
  ('Arap alfabesi', false, 1),
  ('Grek (Yunan) alfabesi', false, 4),
  ('Göktürk (runik) alfabesi', false, 3),
  ('Brahmi alfabesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?', 'Uygur Devleti''nin kültürel-yazılı mirasının sonraki Türk-İslam ve Moğol devletlerine etkisini bilir.', 'Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir. Bu alfabe, taşa oyularak yazılan Göktürk (runik) alfabesinden farklı olarak kağıda yazıma uygundu ve devletin yıkılışından sonra da başka devletlerce kullanılmaya devam etmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Soğd alfabesi', true, 0),
  ('Arap alfabesi', false, 1),
  ('Grek (Yunan) alfabesi', false, 4),
  ('Göktürk (runik) alfabesi', false, 3),
  ('Brahmi alfabesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?', 'Uygur Devleti''nin kültürel-yazılı mirasının sonraki Türk-İslam ve Moğol devletlerine etkisini bilir.', 'Uygurlar, İpek Yolu üzerindeki ticari ve dini ilişkiler sayesinde tanıdıkları Soğd alfabesinden hareketle kendi alfabelerini geliştirmişlerdir. Bu alfabe, taşa oyularak yazılan Göktürk (runik) alfabesinden farklı olarak kağıda yazıma uygundu ve devletin yıkılışından sonra da başka devletlerce kullanılmaya devam etmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Uygur Devleti''nde kullanılan ve sonraları Cengiz Han döneminde Moğollar ile Karahanlılar ve Timur İmparatorluğu tarafından da benimsenen Uygur alfabesi hangi alfabeden geliştirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Soğd alfabesi', true, 0),
  ('Arap alfabesi', false, 1),
  ('Grek (Yunan) alfabesi', false, 4),
  ('Göktürk (runik) alfabesi', false, 3),
  ('Brahmi alfabesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?', 'Orhun Anıtları''nın içerik ve yazım özellikleri arasındaki farkları ayırt eder.', 'Orhun Yazıtları; Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilmiştir. Bilge Kağan ve Kül Tigin yazıtları kağan ağzından/devlet adına kaleme alınmışken, Tonyukuk Yazıtı Bilge Tonyukuk''un bizzat kendi ağzından, kendi başarılarını ve devlete verdiği öğütleri anlattığı özgün bir metindir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bilge Tonyukuk', true, 1),
  ('Bilge Kağan', false, 4),
  ('Kül Tigin', false, 2),
  ('Bumin Kağan', false, 3),
  ('Mukan Kağan', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?', 'Orhun Anıtları''nın içerik ve yazım özellikleri arasındaki farkları ayırt eder.', 'Orhun Yazıtları; Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilmiştir. Bilge Kağan ve Kül Tigin yazıtları kağan ağzından/devlet adına kaleme alınmışken, Tonyukuk Yazıtı Bilge Tonyukuk''un bizzat kendi ağzından, kendi başarılarını ve devlete verdiği öğütleri anlattığı özgün bir metindir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bilge Tonyukuk', true, 1),
  ('Bilge Kağan', false, 4),
  ('Kül Tigin', false, 2),
  ('Bumin Kağan', false, 3),
  ('Mukan Kağan', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?', 'Orhun Anıtları''nın içerik ve yazım özellikleri arasındaki farkları ayırt eder.', 'Orhun Yazıtları; Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilmiştir. Bilge Kağan ve Kül Tigin yazıtları kağan ağzından/devlet adına kaleme alınmışken, Tonyukuk Yazıtı Bilge Tonyukuk''un bizzat kendi ağzından, kendi başarılarını ve devlete verdiği öğütleri anlattığı özgün bir metindir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Orhun Yazıtları''nı oluşturan üç yazıttan biri olan ve bizzat kendi ağzından, birinci tekil şahıs anlatımıyla yazdırılmış olması yönüyle diğer ikisinden ayrılan yazıt hangi devlet adamına aittir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bilge Tonyukuk', true, 1),
  ('Bilge Kağan', false, 4),
  ('Kül Tigin', false, 2),
  ('Bumin Kağan', false, 3),
  ('Mukan Kağan', false, 0)
) as v(choice_text, is_correct, order_index);

-- konu: Osmanlı Kuruluş Dönemi (Tarih / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları
Yıldırım Bayezıd döneminde, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla Macar Kralı Sigismund önderliğinde Fransız, Alman ve Venedik güçlerinin de katıldığı büyük bir Haçlı ordusu toplanmış, ancak bu ordu 1396''da Niğbolu''da ağır bir yenilgiye uğratılmıştır. Bu, Osmanlı''ya karşı düzenlenen ilk büyük uluslararası Haçlı seferi olması bakımından önemlidir ve bu zaferle Bayezıd''ın "hızlı hareket eden" anlamındaki "Yıldırım" lakabı Avrupa''da da tanınır hâle gelmiştir. Yıldırım Bayezıd, aynı dönemde İstanbul''u kuşatan ilk Osmanlı padişahı olmuş, ancak kuşatma Timur tehlikesi nedeniyle (1402 Ankara Savaşı öncesinde) kaldırılmak zorunda kalınmıştır; İstanbul''un fethi ancak yaklaşık yarım yüzyıl sonra, 1453''te II. Mehmed ile gerçekleşecektir.

## Edirne''nin Başkent Oluşu ve Pençik-Devşirme Farkı
I. Murad döneminde fethedilen Edirne, kısa süre sonra Bursa''dan sonra Osmanlı''nın ikinci başkenti yapılmıştır; bu, devletin ağırlık merkezinin Rumeli''ye kaydığının ve artık bir Balkan-Anadolu devleti hâline geldiğinin açık bir göstergesidir. I. Murad, İslam dünyasında yaygın olan "sultan" unvanı yerine Farsça kökenli "Hüdavendigâr" unvanını kullanmıştır; bu unvan halifeden alınmamış, doğrudan Osmanlı hanedanı tarafından benimsenmiştir. I. Murad döneminde 1364''te kazanılan Sırpsındığı Savaşı, Osmanlı''nın Balkanlarda bir Haçlı-Sırp-Macar ittifakına karşı kazandığı ilk büyük zaferdir ve devletin Rumeli''deki kalıcılığını pekiştirerek 1389 I. Kosova Savaşı''na giden sürecin başlangıcı sayılır. Aynı dönemde çıkarılan Pençik Kanunu ile savaş esirlerinin beşte biri (pençik) devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmıştır. Zamanla bu sistemin yerini, Hristiyan tebaanın belirli yaş aralığındaki erkek çocuklarının toplanmasına dayanan Devşirme sistemi almış; bu iki sistem birbirinin devamı niteliğinde olsa da kaynakları (savaş esiri / tebaa çocuğu) bakımından birbirinden ayrılır ve ÖSYM sorularında sıklıkla karıştırılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1)
  and tc.content_md not like '%## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları%';

-- konu: Osmanlı Kuruluş Dönemi (Tarih / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları
Yıldırım Bayezıd döneminde, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla Macar Kralı Sigismund önderliğinde Fransız, Alman ve Venedik güçlerinin de katıldığı büyük bir Haçlı ordusu toplanmış, ancak bu ordu 1396''da Niğbolu''da ağır bir yenilgiye uğratılmıştır. Bu, Osmanlı''ya karşı düzenlenen ilk büyük uluslararası Haçlı seferi olması bakımından önemlidir ve bu zaferle Bayezıd''ın "hızlı hareket eden" anlamındaki "Yıldırım" lakabı Avrupa''da da tanınır hâle gelmiştir. Yıldırım Bayezıd, aynı dönemde İstanbul''u kuşatan ilk Osmanlı padişahı olmuş, ancak kuşatma Timur tehlikesi nedeniyle (1402 Ankara Savaşı öncesinde) kaldırılmak zorunda kalınmıştır; İstanbul''un fethi ancak yaklaşık yarım yüzyıl sonra, 1453''te II. Mehmed ile gerçekleşecektir.

## Edirne''nin Başkent Oluşu ve Pençik-Devşirme Farkı
I. Murad döneminde fethedilen Edirne, kısa süre sonra Bursa''dan sonra Osmanlı''nın ikinci başkenti yapılmıştır; bu, devletin ağırlık merkezinin Rumeli''ye kaydığının ve artık bir Balkan-Anadolu devleti hâline geldiğinin açık bir göstergesidir. I. Murad, İslam dünyasında yaygın olan "sultan" unvanı yerine Farsça kökenli "Hüdavendigâr" unvanını kullanmıştır; bu unvan halifeden alınmamış, doğrudan Osmanlı hanedanı tarafından benimsenmiştir. I. Murad döneminde 1364''te kazanılan Sırpsındığı Savaşı, Osmanlı''nın Balkanlarda bir Haçlı-Sırp-Macar ittifakına karşı kazandığı ilk büyük zaferdir ve devletin Rumeli''deki kalıcılığını pekiştirerek 1389 I. Kosova Savaşı''na giden sürecin başlangıcı sayılır. Aynı dönemde çıkarılan Pençik Kanunu ile savaş esirlerinin beşte biri (pençik) devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmıştır. Zamanla bu sistemin yerini, Hristiyan tebaanın belirli yaş aralığındaki erkek çocuklarının toplanmasına dayanan Devşirme sistemi almış; bu iki sistem birbirinin devamı niteliğinde olsa da kaynakları (savaş esiri / tebaa çocuğu) bakımından birbirinden ayrılır ve ÖSYM sorularında sıklıkla karıştırılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1)
  and tc.content_md not like '%## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları%';

-- konu: Osmanlı Kuruluş Dönemi (Tarih / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları
Yıldırım Bayezıd döneminde, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla Macar Kralı Sigismund önderliğinde Fransız, Alman ve Venedik güçlerinin de katıldığı büyük bir Haçlı ordusu toplanmış, ancak bu ordu 1396''da Niğbolu''da ağır bir yenilgiye uğratılmıştır. Bu, Osmanlı''ya karşı düzenlenen ilk büyük uluslararası Haçlı seferi olması bakımından önemlidir ve bu zaferle Bayezıd''ın "hızlı hareket eden" anlamındaki "Yıldırım" lakabı Avrupa''da da tanınır hâle gelmiştir. Yıldırım Bayezıd, aynı dönemde İstanbul''u kuşatan ilk Osmanlı padişahı olmuş, ancak kuşatma Timur tehlikesi nedeniyle (1402 Ankara Savaşı öncesinde) kaldırılmak zorunda kalınmıştır; İstanbul''un fethi ancak yaklaşık yarım yüzyıl sonra, 1453''te II. Mehmed ile gerçekleşecektir.

## Edirne''nin Başkent Oluşu ve Pençik-Devşirme Farkı
I. Murad döneminde fethedilen Edirne, kısa süre sonra Bursa''dan sonra Osmanlı''nın ikinci başkenti yapılmıştır; bu, devletin ağırlık merkezinin Rumeli''ye kaydığının ve artık bir Balkan-Anadolu devleti hâline geldiğinin açık bir göstergesidir. I. Murad, İslam dünyasında yaygın olan "sultan" unvanı yerine Farsça kökenli "Hüdavendigâr" unvanını kullanmıştır; bu unvan halifeden alınmamış, doğrudan Osmanlı hanedanı tarafından benimsenmiştir. I. Murad döneminde 1364''te kazanılan Sırpsındığı Savaşı, Osmanlı''nın Balkanlarda bir Haçlı-Sırp-Macar ittifakına karşı kazandığı ilk büyük zaferdir ve devletin Rumeli''deki kalıcılığını pekiştirerek 1389 I. Kosova Savaşı''na giden sürecin başlangıcı sayılır. Aynı dönemde çıkarılan Pençik Kanunu ile savaş esirlerinin beşte biri (pençik) devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmıştır. Zamanla bu sistemin yerini, Hristiyan tebaanın belirli yaş aralığındaki erkek çocuklarının toplanmasına dayanan Devşirme sistemi almış; bu iki sistem birbirinin devamı niteliğinde olsa da kaynakları (savaş esiri / tebaa çocuğu) bakımından birbirinden ayrılır ve ÖSYM sorularında sıklıkla karıştırılır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1)
  and tc.content_md not like '%## Niğbolu Savaşı (1396) ve İstanbul Kuşatmaları%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?', 'Yıldırım Bayezıd döneminde Haçlılara karşı kazanılan zaferleri bilir.', '1396''da Niğbolu''da toplanan Haçlı ordusu, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla harekete geçmiş, ancak Yıldırım Bayezıd komutasındaki Osmanlı ordusu bu Haçlı ittifakını ağır bir yenilgiye uğratmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu Savaşı', true, 0),
  ('Ankara Savaşı', false, 2),
  ('I. Kosova Savaşı', false, 1),
  ('Varna Savaşı', false, 4),
  ('II. Kosova Savaşı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?', 'Yıldırım Bayezıd döneminde Haçlılara karşı kazanılan zaferleri bilir.', '1396''da Niğbolu''da toplanan Haçlı ordusu, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla harekete geçmiş, ancak Yıldırım Bayezıd komutasındaki Osmanlı ordusu bu Haçlı ittifakını ağır bir yenilgiye uğratmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu Savaşı', true, 0),
  ('Ankara Savaşı', false, 2),
  ('I. Kosova Savaşı', false, 1),
  ('Varna Savaşı', false, 4),
  ('II. Kosova Savaşı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?', 'Yıldırım Bayezıd döneminde Haçlılara karşı kazanılan zaferleri bilir.', '1396''da Niğbolu''da toplanan Haçlı ordusu, Osmanlı''nın Balkanlardaki ilerleyişini durdurmak amacıyla harekete geçmiş, ancak Yıldırım Bayezıd komutasındaki Osmanlı ordusu bu Haçlı ittifakını ağır bir yenilgiye uğratmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıldırım Bayezıd döneminde, Macar Kralı liderliğindeki Haçlı ordusuna karşı 1396 yılında kazanılan ve padişahın Avrupa''daki gücünü pekiştiren savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu Savaşı', true, 0),
  ('Ankara Savaşı', false, 2),
  ('I. Kosova Savaşı', false, 1),
  ('Varna Savaşı', false, 4),
  ('II. Kosova Savaşı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?', 'Osmanlı kuruluş dönemi başkentlerinin kronolojik sırasını bilir.', 'Osman Bey ve Orhan Bey dönemlerinde başkent önce Söğüt/Yenişehir, ardından Bursa (1326) olmuştur. I. Murad döneminde fethedilen Edirne ise devletin Rumeli''deki ağırlığının artmasıyla Bursa''dan sonraki ikinci başkent olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Edirne', true, 2),
  ('İznik', false, 4),
  ('Yenişehir', false, 0),
  ('Bilecik', false, 1),
  ('İstanbul', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?', 'Osmanlı kuruluş dönemi başkentlerinin kronolojik sırasını bilir.', 'Osman Bey ve Orhan Bey dönemlerinde başkent önce Söğüt/Yenişehir, ardından Bursa (1326) olmuştur. I. Murad döneminde fethedilen Edirne ise devletin Rumeli''deki ağırlığının artmasıyla Bursa''dan sonraki ikinci başkent olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Edirne', true, 2),
  ('İznik', false, 4),
  ('Yenişehir', false, 0),
  ('Bilecik', false, 1),
  ('İstanbul', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?', 'Osmanlı kuruluş dönemi başkentlerinin kronolojik sırasını bilir.', 'Osman Bey ve Orhan Bey dönemlerinde başkent önce Söğüt/Yenişehir, ardından Bursa (1326) olmuştur. I. Murad döneminde fethedilen Edirne ise devletin Rumeli''deki ağırlığının artmasıyla Bursa''dan sonraki ikinci başkent olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'I. Murad döneminde fethedilerek Bursa''dan sonra Osmanlı Devleti''nin ikinci başkenti yapılan şehir aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Edirne', true, 2),
  ('İznik', false, 4),
  ('Yenişehir', false, 0),
  ('Bilecik', false, 1),
  ('İstanbul', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?', 'Kapıkulu askeri sisteminin kaynağını oluşturan Pençik uygulamasının hangi döneme ait olduğunu bilir.', 'Pençik Kanunu, I. Murad döneminde Çandarlı Kara Halil''in önerisiyle çıkarılmış ve savaş esirlerinin beşte birinin devlete ait olmasını sağlayarak Kapıkulu Ocakları''nın asker ihtiyacının karşılanmasında ilk sistemli kaynağı oluşturmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I. Murad', true, 1),
  ('Orhan Bey', false, 2),
  ('Yıldırım Bayezıd', false, 0),
  ('II. Murad', false, 4),
  ('Osman Bey', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?', 'Kapıkulu askeri sisteminin kaynağını oluşturan Pençik uygulamasının hangi döneme ait olduğunu bilir.', 'Pençik Kanunu, I. Murad döneminde Çandarlı Kara Halil''in önerisiyle çıkarılmış ve savaş esirlerinin beşte birinin devlete ait olmasını sağlayarak Kapıkulu Ocakları''nın asker ihtiyacının karşılanmasında ilk sistemli kaynağı oluşturmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I. Murad', true, 1),
  ('Orhan Bey', false, 2),
  ('Yıldırım Bayezıd', false, 0),
  ('II. Murad', false, 4),
  ('Osman Bey', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?', 'Kapıkulu askeri sisteminin kaynağını oluşturan Pençik uygulamasının hangi döneme ait olduğunu bilir.', 'Pençik Kanunu, I. Murad döneminde Çandarlı Kara Halil''in önerisiyle çıkarılmış ve savaş esirlerinin beşte birinin devlete ait olmasını sağlayarak Kapıkulu Ocakları''nın asker ihtiyacının karşılanmasında ilk sistemli kaynağı oluşturmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Savaş esirlerinin beşte birinin devlete ayrılarak Kapıkulu Ocakları''na asker kaynağı sağlanmasını düzenleyen Pençik Kanunu hangi padişah döneminde çıkarılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I. Murad', true, 1),
  ('Orhan Bey', false, 2),
  ('Yıldırım Bayezıd', false, 0),
  ('II. Murad', false, 4),
  ('Osman Bey', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?', 'İstanbul''un fethine giden süreçteki ilk kuşatma girişimini ve nedenini bilir.', 'Yıldırım Bayezıd, Balkanlardaki başarılarının ardından İstanbul''u kuşatan ilk Osmanlı padişahı olmuştur; ancak doğuda büyüyen Timur tehdidi nedeniyle kuşatmayı kaldırarak ordusunu Ankara''ya yöneltmek zorunda kalmış, bu süreç 1402 Ankara Savaşı ile sonuçlanmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yıldırım Bayezıd', true, 1),
  ('I. Murad', false, 2),
  ('Çelebi Mehmed', false, 3),
  ('II. Murad', false, 4),
  ('Orhan Bey', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?', 'İstanbul''un fethine giden süreçteki ilk kuşatma girişimini ve nedenini bilir.', 'Yıldırım Bayezıd, Balkanlardaki başarılarının ardından İstanbul''u kuşatan ilk Osmanlı padişahı olmuştur; ancak doğuda büyüyen Timur tehdidi nedeniyle kuşatmayı kaldırarak ordusunu Ankara''ya yöneltmek zorunda kalmış, bu süreç 1402 Ankara Savaşı ile sonuçlanmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yıldırım Bayezıd', true, 1),
  ('I. Murad', false, 2),
  ('Çelebi Mehmed', false, 3),
  ('II. Murad', false, 4),
  ('Orhan Bey', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?', 'İstanbul''un fethine giden süreçteki ilk kuşatma girişimini ve nedenini bilir.', 'Yıldırım Bayezıd, Balkanlardaki başarılarının ardından İstanbul''u kuşatan ilk Osmanlı padişahı olmuştur; ancak doğuda büyüyen Timur tehdidi nedeniyle kuşatmayı kaldırarak ordusunu Ankara''ya yöneltmek zorunda kalmış, bu süreç 1402 Ankara Savaşı ile sonuçlanmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul''u kuşatan ilk Osmanlı padişahı olmasına rağmen, Timur tehlikesi nedeniyle kuşatmayı kaldırmak zorunda kalan padişah kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yıldırım Bayezıd', true, 1),
  ('I. Murad', false, 2),
  ('Çelebi Mehmed', false, 3),
  ('II. Murad', false, 4),
  ('Orhan Bey', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Yıldırım Bayezıd dönemindeki iki önemli savaşın niteliğini ve sonuçlarını ayırt eder.', 'Niğbolu Savaşı, Osmanlı''nın Hristiyan Haçlı ittifakına karşı Avrupa''da kazandığı bir zaferdir ve devletin gücünü artırmıştır. Ankara Savaşı ise Türk-İslam dünyasının kendi içindeki bir güç mücadelesidir; Osmanlı bu savaşta Timur''a yenilerek Fetret Devri''ne girmiştir, dolayısıyla iki savaş hem taraf hem sonuç bakımından tamamen farklıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu, Hristiyan Haçlı ittifakına karşı kazanılan bir zaferken; Ankara Savaşı, Timur''a karşı alınan bir yenilgidir ve Fetret Devri''ne yol açmıştır.', true, 2),
  ('Her iki savaş da Osmanlı''nın zaferiyle sonuçlanmıştır.', false, 4),
  ('Niğbolu Savaşı sonrasında Fetret Devri başlamıştır.', false, 0),
  ('Ankara Savaşı Haçlı ittifakına karşı kazanılmıştır.', false, 1),
  ('Niğbolu Savaşı Timur kuvvetlerine karşı kazanılmıştır.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Yıldırım Bayezıd dönemindeki iki önemli savaşın niteliğini ve sonuçlarını ayırt eder.', 'Niğbolu Savaşı, Osmanlı''nın Hristiyan Haçlı ittifakına karşı Avrupa''da kazandığı bir zaferdir ve devletin gücünü artırmıştır. Ankara Savaşı ise Türk-İslam dünyasının kendi içindeki bir güç mücadelesidir; Osmanlı bu savaşta Timur''a yenilerek Fetret Devri''ne girmiştir, dolayısıyla iki savaş hem taraf hem sonuç bakımından tamamen farklıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu, Hristiyan Haçlı ittifakına karşı kazanılan bir zaferken; Ankara Savaşı, Timur''a karşı alınan bir yenilgidir ve Fetret Devri''ne yol açmıştır.', true, 2),
  ('Her iki savaş da Osmanlı''nın zaferiyle sonuçlanmıştır.', false, 4),
  ('Niğbolu Savaşı sonrasında Fetret Devri başlamıştır.', false, 0),
  ('Ankara Savaşı Haçlı ittifakına karşı kazanılmıştır.', false, 1),
  ('Niğbolu Savaşı Timur kuvvetlerine karşı kazanılmıştır.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Osmanlı Kuruluş Dönemi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Yıldırım Bayezıd dönemindeki iki önemli savaşın niteliğini ve sonuçlarını ayırt eder.', 'Niğbolu Savaşı, Osmanlı''nın Hristiyan Haçlı ittifakına karşı Avrupa''da kazandığı bir zaferdir ve devletin gücünü artırmıştır. Ankara Savaşı ise Türk-İslam dünyasının kendi içindeki bir güç mücadelesidir; Osmanlı bu savaşta Timur''a yenilerek Fetret Devri''ne girmiştir, dolayısıyla iki savaş hem taraf hem sonuç bakımından tamamen farklıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Niğbolu Savaşı (1396) ile Ankara Savaşı (1402) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Niğbolu, Hristiyan Haçlı ittifakına karşı kazanılan bir zaferken; Ankara Savaşı, Timur''a karşı alınan bir yenilgidir ve Fetret Devri''ne yol açmıştır.', true, 2),
  ('Her iki savaş da Osmanlı''nın zaferiyle sonuçlanmıştır.', false, 4),
  ('Niğbolu Savaşı sonrasında Fetret Devri başlamıştır.', false, 0),
  ('Ankara Savaşı Haçlı ittifakına karşı kazanılmıştır.', false, 1),
  ('Niğbolu Savaşı Timur kuvvetlerine karşı kazanılmıştır.', false, 3)
) as v(choice_text, is_correct, order_index);

-- konu: Kurtuluş Savaşı (Tarih / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sevr Antlaşması (10 Ağustos 1920)
Mondros sonrası İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanan Sevr Antlaşması, Osmanlı topraklarını fiilen paylaştıran çok ağır şartlar içerir: kapitülasyonlar ağırlaştırılmış, Boğazlar uluslararası bir komisyona bırakılmış, Doğu Anadolu''da bağımsız bir Ermenistan ve özerk bir Kürdistan öngörülmüş, İzmir ve çevresi Yunanistan yönetimine bırakılmış, Antalya-Konya çevresi İtalya''ya, Adana çevresi Fransa''ya nüfuz bölgesi olarak ayrılmış, Osmanlı ordusu ise yaklaşık 50.700 kişilik bir jandarma gücüyle sınırlandırılmıştır. TBMM bu antlaşmayı tanımamış, imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunmuştur; bu nedenle Sevr hiçbir zaman yürürlüğe girmemiş ve Kurtuluş Savaşı''nın kazanılmasıyla fiilen geçersiz kalmıştır. Sevr, Lozan ile en sık karşılaştırılan antlaşmadır: Sevr TBMM''nin yokluğunda, tek taraflı olarak dayatılmışken; Lozan, TBMM''nin bizzat masada eşit bir taraf olarak yer aldığı, karşılıklı müzakere edilmiş bir antlaşmadır.

## TBMM''ye Karşı Çıkan İç İsyanlar
Millî Mücadele yalnızca dış düşmanlara karşı değil, İstanbul Hükümeti''nin ve bazı çevrelerin kışkırttığı iç isyanlara karşı da yürütülmüştür. Ahmet Anzavur İsyanı, Bolu-Düzce İsyanı, Konya Ayaklanması ve Millî Aşiret İsyanı gibi pek çok ayaklanma, TBMM''ye bağlı düzenli birlikler ve Kuvâ-yi Milliye tarafından bastırılmıştır; bu isyanların bastırılması, TBMM''nin kendi otoritesini önce iç cephede sağlamlaştırması anlamına gelir. Bu isyanların bastırılmasında öne çıkan Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı iken, düzenli ordunun kurulmasına ve kendi kuvvetlerinin bu orduya bağlanmasına karşı çıkarak 1920-1921''de bizzat TBMM''ye karşı isyan etmiş, yenilince de Yunanlılara sığınmıştır; bu olay, Millî Mücadele''nin tek düze bir birlik içinde değil, iç çekişmelerle de yürütüldüğünü gösteren çarpıcı bir örnektir. Bu isyanların çoğunluğu, TBMM''nin dış cephede savaşırken aynı anda iç güvenliği de sağlamak zorunda kaldığını açıkça ortaya koymuştur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1)
  and tc.content_md not like '%## Sevr Antlaşması (10 Ağustos 1920)%';

-- konu: Kurtuluş Savaşı (Tarih / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sevr Antlaşması (10 Ağustos 1920)
Mondros sonrası İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanan Sevr Antlaşması, Osmanlı topraklarını fiilen paylaştıran çok ağır şartlar içerir: kapitülasyonlar ağırlaştırılmış, Boğazlar uluslararası bir komisyona bırakılmış, Doğu Anadolu''da bağımsız bir Ermenistan ve özerk bir Kürdistan öngörülmüş, İzmir ve çevresi Yunanistan yönetimine bırakılmış, Antalya-Konya çevresi İtalya''ya, Adana çevresi Fransa''ya nüfuz bölgesi olarak ayrılmış, Osmanlı ordusu ise yaklaşık 50.700 kişilik bir jandarma gücüyle sınırlandırılmıştır. TBMM bu antlaşmayı tanımamış, imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunmuştur; bu nedenle Sevr hiçbir zaman yürürlüğe girmemiş ve Kurtuluş Savaşı''nın kazanılmasıyla fiilen geçersiz kalmıştır. Sevr, Lozan ile en sık karşılaştırılan antlaşmadır: Sevr TBMM''nin yokluğunda, tek taraflı olarak dayatılmışken; Lozan, TBMM''nin bizzat masada eşit bir taraf olarak yer aldığı, karşılıklı müzakere edilmiş bir antlaşmadır.

## TBMM''ye Karşı Çıkan İç İsyanlar
Millî Mücadele yalnızca dış düşmanlara karşı değil, İstanbul Hükümeti''nin ve bazı çevrelerin kışkırttığı iç isyanlara karşı da yürütülmüştür. Ahmet Anzavur İsyanı, Bolu-Düzce İsyanı, Konya Ayaklanması ve Millî Aşiret İsyanı gibi pek çok ayaklanma, TBMM''ye bağlı düzenli birlikler ve Kuvâ-yi Milliye tarafından bastırılmıştır; bu isyanların bastırılması, TBMM''nin kendi otoritesini önce iç cephede sağlamlaştırması anlamına gelir. Bu isyanların bastırılmasında öne çıkan Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı iken, düzenli ordunun kurulmasına ve kendi kuvvetlerinin bu orduya bağlanmasına karşı çıkarak 1920-1921''de bizzat TBMM''ye karşı isyan etmiş, yenilince de Yunanlılara sığınmıştır; bu olay, Millî Mücadele''nin tek düze bir birlik içinde değil, iç çekişmelerle de yürütüldüğünü gösteren çarpıcı bir örnektir. Bu isyanların çoğunluğu, TBMM''nin dış cephede savaşırken aynı anda iç güvenliği de sağlamak zorunda kaldığını açıkça ortaya koymuştur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1)
  and tc.content_md not like '%## Sevr Antlaşması (10 Ağustos 1920)%';

-- konu: Kurtuluş Savaşı (Tarih / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Sevr Antlaşması (10 Ağustos 1920)
Mondros sonrası İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanan Sevr Antlaşması, Osmanlı topraklarını fiilen paylaştıran çok ağır şartlar içerir: kapitülasyonlar ağırlaştırılmış, Boğazlar uluslararası bir komisyona bırakılmış, Doğu Anadolu''da bağımsız bir Ermenistan ve özerk bir Kürdistan öngörülmüş, İzmir ve çevresi Yunanistan yönetimine bırakılmış, Antalya-Konya çevresi İtalya''ya, Adana çevresi Fransa''ya nüfuz bölgesi olarak ayrılmış, Osmanlı ordusu ise yaklaşık 50.700 kişilik bir jandarma gücüyle sınırlandırılmıştır. TBMM bu antlaşmayı tanımamış, imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunmuştur; bu nedenle Sevr hiçbir zaman yürürlüğe girmemiş ve Kurtuluş Savaşı''nın kazanılmasıyla fiilen geçersiz kalmıştır. Sevr, Lozan ile en sık karşılaştırılan antlaşmadır: Sevr TBMM''nin yokluğunda, tek taraflı olarak dayatılmışken; Lozan, TBMM''nin bizzat masada eşit bir taraf olarak yer aldığı, karşılıklı müzakere edilmiş bir antlaşmadır.

## TBMM''ye Karşı Çıkan İç İsyanlar
Millî Mücadele yalnızca dış düşmanlara karşı değil, İstanbul Hükümeti''nin ve bazı çevrelerin kışkırttığı iç isyanlara karşı da yürütülmüştür. Ahmet Anzavur İsyanı, Bolu-Düzce İsyanı, Konya Ayaklanması ve Millî Aşiret İsyanı gibi pek çok ayaklanma, TBMM''ye bağlı düzenli birlikler ve Kuvâ-yi Milliye tarafından bastırılmıştır; bu isyanların bastırılması, TBMM''nin kendi otoritesini önce iç cephede sağlamlaştırması anlamına gelir. Bu isyanların bastırılmasında öne çıkan Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı iken, düzenli ordunun kurulmasına ve kendi kuvvetlerinin bu orduya bağlanmasına karşı çıkarak 1920-1921''de bizzat TBMM''ye karşı isyan etmiş, yenilince de Yunanlılara sığınmıştır; bu olay, Millî Mücadele''nin tek düze bir birlik içinde değil, iç çekişmelerle de yürütüldüğünü gösteren çarpıcı bir örnektir. Bu isyanların çoğunluğu, TBMM''nin dış cephede savaşırken aynı anda iç güvenliği de sağlamak zorunda kaldığını açıkça ortaya koymuştur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1)
  and tc.content_md not like '%## Sevr Antlaşması (10 Ağustos 1920)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?', 'Sevr Antlaşması''nı imzalayan hükümeti ve TBMM''nin buna karşı tutumunu bilir.', 'Sevr Antlaşması, 10 Ağustos 1920''de İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanmıştır. TBMM bu antlaşmayı tanımamış ve hiçbir zaman yürürlüğe girmemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damat Ferit Paşa Hükümeti (İstanbul Hükümeti)', true, 2),
  ('Mustafa Kemal Paşa''nın TBMM Hükümeti', false, 3),
  ('Tevfik Paşa Hükümeti', false, 0),
  ('Ahmet İzzet Paşa Hükümeti', false, 1),
  ('Refet Paşa Hükümeti', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?', 'Sevr Antlaşması''nı imzalayan hükümeti ve TBMM''nin buna karşı tutumunu bilir.', 'Sevr Antlaşması, 10 Ağustos 1920''de İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanmıştır. TBMM bu antlaşmayı tanımamış ve hiçbir zaman yürürlüğe girmemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damat Ferit Paşa Hükümeti (İstanbul Hükümeti)', true, 2),
  ('Mustafa Kemal Paşa''nın TBMM Hükümeti', false, 3),
  ('Tevfik Paşa Hükümeti', false, 0),
  ('Ahmet İzzet Paşa Hükümeti', false, 1),
  ('Refet Paşa Hükümeti', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?', 'Sevr Antlaşması''nı imzalayan hükümeti ve TBMM''nin buna karşı tutumunu bilir.', 'Sevr Antlaşması, 10 Ağustos 1920''de İtilaf Devletleri ile İstanbul Hükümeti (Sadrazam Damat Ferit Paşa) arasında imzalanmıştır. TBMM bu antlaşmayı tanımamış ve hiçbir zaman yürürlüğe girmemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması, Osmanlı Devleti adına hangi hükümet tarafından imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Damat Ferit Paşa Hükümeti (İstanbul Hükümeti)', true, 2),
  ('Mustafa Kemal Paşa''nın TBMM Hükümeti', false, 3),
  ('Tevfik Paşa Hükümeti', false, 0),
  ('Ahmet İzzet Paşa Hükümeti', false, 1),
  ('Refet Paşa Hükümeti', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?', 'Millî Mücadele döneminin önemli antlaşma tarihlerini bilir.', 'Sevr Antlaşması 10 Ağustos 1920''de imzalanmıştır. Bu tarih, Mondros Ateşkesi''nin (30 Ekim 1918) ve Lozan Antlaşması''nın (24 Temmuz 1923) tarihleriyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10 Ağustos 1920', true, 0),
  ('30 Ekim 1918', false, 4),
  ('24 Temmuz 1923', false, 3),
  ('16 Mart 1920', false, 1),
  ('11 Ekim 1922', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?', 'Millî Mücadele döneminin önemli antlaşma tarihlerini bilir.', 'Sevr Antlaşması 10 Ağustos 1920''de imzalanmıştır. Bu tarih, Mondros Ateşkesi''nin (30 Ekim 1918) ve Lozan Antlaşması''nın (24 Temmuz 1923) tarihleriyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10 Ağustos 1920', true, 0),
  ('30 Ekim 1918', false, 4),
  ('24 Temmuz 1923', false, 3),
  ('16 Mart 1920', false, 1),
  ('11 Ekim 1922', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?', 'Millî Mücadele döneminin önemli antlaşma tarihlerini bilir.', 'Sevr Antlaşması 10 Ağustos 1920''de imzalanmıştır. Bu tarih, Mondros Ateşkesi''nin (30 Ekim 1918) ve Lozan Antlaşması''nın (24 Temmuz 1923) tarihleriyle karıştırılmamalıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Osmanlı topraklarını parçalayan, Boğazları uluslararası bir komisyona bırakan ve Doğu Anadolu''da bağımsız bir Ermenistan öngören Sevr Antlaşması hangi tarihte imzalanmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10 Ağustos 1920', true, 0),
  ('30 Ekim 1918', false, 4),
  ('24 Temmuz 1923', false, 3),
  ('16 Mart 1920', false, 1),
  ('11 Ekim 1922', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?', 'Sevr Antlaşması''nın hukuki geçersizliğinin nedenini kavrar.', 'TBMM, Sevr''i imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunarak bu antlaşmayı tanımamıştır. Kurtuluş Savaşı''nın kazanılmasıyla Sevr''in öngördüğü düzenlemeler fiilen geçersiz kalmış, yerini Lozan Antlaşması almıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin bu antlaşmayı tanımaması ve Kurtuluş Savaşı sonucunda hükümlerinin fiilen geçersiz kalması', true, 3),
  ('İtilaf Devletlerinin antlaşmayı kendiliğinden iptal etmesi', false, 1),
  ('Mondros Ateşkesi''nin hâlâ yürürlükte olması', false, 2),
  ('Lozan Antlaşması''nın Sevr''den önce imzalanmış olması', false, 4),
  ('Wilson Prensipleri''nin antlaşmayı geçersiz kılması', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?', 'Sevr Antlaşması''nın hukuki geçersizliğinin nedenini kavrar.', 'TBMM, Sevr''i imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunarak bu antlaşmayı tanımamıştır. Kurtuluş Savaşı''nın kazanılmasıyla Sevr''in öngördüğü düzenlemeler fiilen geçersiz kalmış, yerini Lozan Antlaşması almıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin bu antlaşmayı tanımaması ve Kurtuluş Savaşı sonucunda hükümlerinin fiilen geçersiz kalması', true, 3),
  ('İtilaf Devletlerinin antlaşmayı kendiliğinden iptal etmesi', false, 1),
  ('Mondros Ateşkesi''nin hâlâ yürürlükte olması', false, 2),
  ('Lozan Antlaşması''nın Sevr''den önce imzalanmış olması', false, 4),
  ('Wilson Prensipleri''nin antlaşmayı geçersiz kılması', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?', 'Sevr Antlaşması''nın hukuki geçersizliğinin nedenini kavrar.', 'TBMM, Sevr''i imzalayan İstanbul Hükümeti''nin milleti temsil etme yetkisi olmadığını savunarak bu antlaşmayı tanımamıştır. Kurtuluş Savaşı''nın kazanılmasıyla Sevr''in öngördüğü düzenlemeler fiilen geçersiz kalmış, yerini Lozan Antlaşması almıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sevr Antlaşması''nın imzalanmasına rağmen hiçbir zaman yürürlüğe girmemesinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('TBMM''nin bu antlaşmayı tanımaması ve Kurtuluş Savaşı sonucunda hükümlerinin fiilen geçersiz kalması', true, 3),
  ('İtilaf Devletlerinin antlaşmayı kendiliğinden iptal etmesi', false, 1),
  ('Mondros Ateşkesi''nin hâlâ yürürlükte olması', false, 2),
  ('Lozan Antlaşması''nın Sevr''den önce imzalanmış olması', false, 4),
  ('Wilson Prensipleri''nin antlaşmayı geçersiz kılması', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?', 'Millî Mücadele''nin iç isyanlar boyutunu bilir.', 'Ahmet Anzavur İsyanı, İstanbul Hükümeti''nin kışkırtmasıyla Millî Mücadele''ye karşı çıkan iç isyanlardan biridir ve Kuvâ-yi Milliye ile düzenli birlikler tarafından bastırılmıştır. Şeyh Sait İsyanı, Menemen Olayı ve Dersim İsyanı ise Cumhuriyet''in ilanından sonraki döneme ait olaylardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ahmet Anzavur İsyanı', true, 4),
  ('Şeyh Sait İsyanı', false, 2),
  ('Menemen Olayı', false, 0),
  ('Dersim İsyanı', false, 1),
  ('Kubilay Olayı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?', 'Millî Mücadele''nin iç isyanlar boyutunu bilir.', 'Ahmet Anzavur İsyanı, İstanbul Hükümeti''nin kışkırtmasıyla Millî Mücadele''ye karşı çıkan iç isyanlardan biridir ve Kuvâ-yi Milliye ile düzenli birlikler tarafından bastırılmıştır. Şeyh Sait İsyanı, Menemen Olayı ve Dersim İsyanı ise Cumhuriyet''in ilanından sonraki döneme ait olaylardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ahmet Anzavur İsyanı', true, 4),
  ('Şeyh Sait İsyanı', false, 2),
  ('Menemen Olayı', false, 0),
  ('Dersim İsyanı', false, 1),
  ('Kubilay Olayı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?', 'Millî Mücadele''nin iç isyanlar boyutunu bilir.', 'Ahmet Anzavur İsyanı, İstanbul Hükümeti''nin kışkırtmasıyla Millî Mücadele''ye karşı çıkan iç isyanlardan biridir ve Kuvâ-yi Milliye ile düzenli birlikler tarafından bastırılmıştır. Şeyh Sait İsyanı, Menemen Olayı ve Dersim İsyanı ise Cumhuriyet''in ilanından sonraki döneme ait olaylardır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Millî Mücadele döneminde TBMM''ye karşı çıkan ve düzenli ordu birlikleri ile Kuvâ-yi Milliye tarafından bastırılan iç isyanlardan biri aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ahmet Anzavur İsyanı', true, 4),
  ('Şeyh Sait İsyanı', false, 2),
  ('Menemen Olayı', false, 0),
  ('Dersim İsyanı', false, 1),
  ('Kubilay Olayı', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?', 'Millî Mücadele döneminde TBMM saflarından ayrılan kişileri ve nedenlerini bilir.', 'Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı olarak iç isyanların bastırılmasında önemli rol oynamış, ancak düzenli ordunun kurulması ve kendi güçlerinin bu orduya bağlanması fikrine karşı çıkarak 1920-1921''de TBMM''ye isyan etmiş ve yenilince Yunanlılara sığınmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Çerkez Ethem', true, 4),
  ('Ali Fuat Paşa (Cebesoy)', false, 0),
  ('Refet Bey (Bele)', false, 1),
  ('Kazım Karabekir Paşa', false, 3),
  ('Fevzi Çakmak', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?', 'Millî Mücadele döneminde TBMM saflarından ayrılan kişileri ve nedenlerini bilir.', 'Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı olarak iç isyanların bastırılmasında önemli rol oynamış, ancak düzenli ordunun kurulması ve kendi güçlerinin bu orduya bağlanması fikrine karşı çıkarak 1920-1921''de TBMM''ye isyan etmiş ve yenilince Yunanlılara sığınmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Çerkez Ethem', true, 4),
  ('Ali Fuat Paşa (Cebesoy)', false, 0),
  ('Refet Bey (Bele)', false, 1),
  ('Kazım Karabekir Paşa', false, 3),
  ('Fevzi Çakmak', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'Kurtuluş Savaşı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?', 'Millî Mücadele döneminde TBMM saflarından ayrılan kişileri ve nedenlerini bilir.', 'Çerkez Ethem, TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin komutanı olarak iç isyanların bastırılmasında önemli rol oynamış, ancak düzenli ordunun kurulması ve kendi güçlerinin bu orduya bağlanması fikrine karşı çıkarak 1920-1921''de TBMM''ye isyan etmiş ve yenilince Yunanlılara sığınmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''ye bağlı Kuvâ-yi Seyyare birliklerinin başında iç isyanların bastırılmasında etkili olmuş, ancak düzenli ordunun kurulmasına karşı çıkarak daha sonra bizzat TBMM''ye karşı isyan edip Yunanlılara sığınmış kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Çerkez Ethem', true, 4),
  ('Ali Fuat Paşa (Cebesoy)', false, 0),
  ('Refet Bey (Bele)', false, 1),
  ('Kazım Karabekir Paşa', false, 3),
  ('Fevzi Çakmak', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: İnkılap Tarihi (Tarih / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Saltanatın Kaldırılması (1 Kasım 1922)
İtilaf Devletleri''nin Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet etmesi üzerine, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır. Bu kararla saltanat ve halifelik makamları birbirinden ayrılmış; son padişah VI. Mehmed Vahdettin bir İngiliz savaş gemisiyle ülkeyi terk etmiş, bu durum TBMM tarafından padişahlık makamının fiilen boşaltılması olarak yorumlanarak halifelik seçimi hızlandırılmıştır. TBMM, padişahlık yetkisi olmaksızın sadece halife unvanıyla Abdülmecid Efendi''yi seçmiştir. Böylece 623 yıllık Osmanlı hanedanının siyasi ve idari yetkisi sona ermiş, ancak halifelik kurumu 3 Mart 1924''e kadar (yaklaşık 16 ay) sembolik olarak varlığını sürdürmüştür; bu 16 aylık süreç, Cumhuriyetin ilanına (29 Ekim 1923) giden geçiş döneminin de bir parçasıdır.

## Atatürk İlkeleri (Altı Ok)
Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık olmak üzere altı temel ilke, inkılapların dayandığı düşünce sistemini oluşturur ve Cumhuriyet Halk Partisi''nin simgesi olan "altı ok" ile özdeşleşmiştir. Cumhuriyetçilik egemenliğin kayıtsız şartsız millete ait olmasını ve yönetim biçiminin cumhuriyet olmasını; Halkçılık kanun önünde eşitliği, sınıfsız ve imtiyazsız bir toplumu; Devletçilik ise ekonomide devletin düzenleyici ve gerektiğinde bizzat üretici rol üstlenmesini (örneğin 1930''larda kurulan Sümerbank gibi devlet iktisadi teşekkülleri aracılığıyla) ifade eder; Milliyetçilik Türk milletinin bütünlüğünü ve bağımsızlığını, İnkılapçılık ise yapılan reformların sürekli yenilenerek çağdaşlaşmanın devam ettirilmesi gerektiğini savunur. Altı ilke birbirinden bağımsız değil, birbirini tamamlayan bir bütün olarak değerlendirilir; örneğin Laiklik olmadan Halkçılık''ın öngördüğü hukuki eşitlik tam anlamıyla sağlanamaz. Bu ilkeler önce 1931''de Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek resmi devlet politikası hâline gelmiştir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1)
  and tc.content_md not like '%## Saltanatın Kaldırılması (1 Kasım 1922)%';

-- konu: İnkılap Tarihi (Tarih / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Saltanatın Kaldırılması (1 Kasım 1922)
İtilaf Devletleri''nin Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet etmesi üzerine, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır. Bu kararla saltanat ve halifelik makamları birbirinden ayrılmış; son padişah VI. Mehmed Vahdettin bir İngiliz savaş gemisiyle ülkeyi terk etmiş, bu durum TBMM tarafından padişahlık makamının fiilen boşaltılması olarak yorumlanarak halifelik seçimi hızlandırılmıştır. TBMM, padişahlık yetkisi olmaksızın sadece halife unvanıyla Abdülmecid Efendi''yi seçmiştir. Böylece 623 yıllık Osmanlı hanedanının siyasi ve idari yetkisi sona ermiş, ancak halifelik kurumu 3 Mart 1924''e kadar (yaklaşık 16 ay) sembolik olarak varlığını sürdürmüştür; bu 16 aylık süreç, Cumhuriyetin ilanına (29 Ekim 1923) giden geçiş döneminin de bir parçasıdır.

## Atatürk İlkeleri (Altı Ok)
Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık olmak üzere altı temel ilke, inkılapların dayandığı düşünce sistemini oluşturur ve Cumhuriyet Halk Partisi''nin simgesi olan "altı ok" ile özdeşleşmiştir. Cumhuriyetçilik egemenliğin kayıtsız şartsız millete ait olmasını ve yönetim biçiminin cumhuriyet olmasını; Halkçılık kanun önünde eşitliği, sınıfsız ve imtiyazsız bir toplumu; Devletçilik ise ekonomide devletin düzenleyici ve gerektiğinde bizzat üretici rol üstlenmesini (örneğin 1930''larda kurulan Sümerbank gibi devlet iktisadi teşekkülleri aracılığıyla) ifade eder; Milliyetçilik Türk milletinin bütünlüğünü ve bağımsızlığını, İnkılapçılık ise yapılan reformların sürekli yenilenerek çağdaşlaşmanın devam ettirilmesi gerektiğini savunur. Altı ilke birbirinden bağımsız değil, birbirini tamamlayan bir bütün olarak değerlendirilir; örneğin Laiklik olmadan Halkçılık''ın öngördüğü hukuki eşitlik tam anlamıyla sağlanamaz. Bu ilkeler önce 1931''de Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek resmi devlet politikası hâline gelmiştir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1)
  and tc.content_md not like '%## Saltanatın Kaldırılması (1 Kasım 1922)%';

-- konu: İnkılap Tarihi (Tarih / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Saltanatın Kaldırılması (1 Kasım 1922)
İtilaf Devletleri''nin Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet etmesi üzerine, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır. Bu kararla saltanat ve halifelik makamları birbirinden ayrılmış; son padişah VI. Mehmed Vahdettin bir İngiliz savaş gemisiyle ülkeyi terk etmiş, bu durum TBMM tarafından padişahlık makamının fiilen boşaltılması olarak yorumlanarak halifelik seçimi hızlandırılmıştır. TBMM, padişahlık yetkisi olmaksızın sadece halife unvanıyla Abdülmecid Efendi''yi seçmiştir. Böylece 623 yıllık Osmanlı hanedanının siyasi ve idari yetkisi sona ermiş, ancak halifelik kurumu 3 Mart 1924''e kadar (yaklaşık 16 ay) sembolik olarak varlığını sürdürmüştür; bu 16 aylık süreç, Cumhuriyetin ilanına (29 Ekim 1923) giden geçiş döneminin de bir parçasıdır.

## Atatürk İlkeleri (Altı Ok)
Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık olmak üzere altı temel ilke, inkılapların dayandığı düşünce sistemini oluşturur ve Cumhuriyet Halk Partisi''nin simgesi olan "altı ok" ile özdeşleşmiştir. Cumhuriyetçilik egemenliğin kayıtsız şartsız millete ait olmasını ve yönetim biçiminin cumhuriyet olmasını; Halkçılık kanun önünde eşitliği, sınıfsız ve imtiyazsız bir toplumu; Devletçilik ise ekonomide devletin düzenleyici ve gerektiğinde bizzat üretici rol üstlenmesini (örneğin 1930''larda kurulan Sümerbank gibi devlet iktisadi teşekkülleri aracılığıyla) ifade eder; Milliyetçilik Türk milletinin bütünlüğünü ve bağımsızlığını, İnkılapçılık ise yapılan reformların sürekli yenilenerek çağdaşlaşmanın devam ettirilmesi gerektiğini savunur. Altı ilke birbirinden bağımsız değil, birbirini tamamlayan bir bütün olarak değerlendirilir; örneğin Laiklik olmadan Halkçılık''ın öngördüğü hukuki eşitlik tam anlamıyla sağlanamaz. Bu ilkeler önce 1931''de Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek resmi devlet politikası hâline gelmiştir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1)
  and tc.content_md not like '%## Saltanatın Kaldırılması (1 Kasım 1922)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?', 'Saltanat ile halifelik makamlarının ayrılması sürecini bilir.', 'TBMM, 1 Kasım 1922''de saltanatı kaldırırken halifelik makamını geçici olarak korumuş ve son padişah VI. Mehmed Vahdettin''in ülkeyi terk etmesinin ardından Abdülmecid Efendi''yi yalnızca halife unvanıyla, padişahlık yetkisi olmaksızın seçmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Abdülmecid Efendi', true, 4),
  ('VI. Mehmed Vahdettin', false, 2),
  ('V. Mehmed Reşad', false, 1),
  ('Mustafa Kemal Atatürk', false, 0),
  ('İsmet İnönü', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?', 'Saltanat ile halifelik makamlarının ayrılması sürecini bilir.', 'TBMM, 1 Kasım 1922''de saltanatı kaldırırken halifelik makamını geçici olarak korumuş ve son padişah VI. Mehmed Vahdettin''in ülkeyi terk etmesinin ardından Abdülmecid Efendi''yi yalnızca halife unvanıyla, padişahlık yetkisi olmaksızın seçmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Abdülmecid Efendi', true, 4),
  ('VI. Mehmed Vahdettin', false, 2),
  ('V. Mehmed Reşad', false, 1),
  ('Mustafa Kemal Atatürk', false, 0),
  ('İsmet İnönü', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?', 'Saltanat ile halifelik makamlarının ayrılması sürecini bilir.', 'TBMM, 1 Kasım 1922''de saltanatı kaldırırken halifelik makamını geçici olarak korumuş ve son padişah VI. Mehmed Vahdettin''in ülkeyi terk etmesinin ardından Abdülmecid Efendi''yi yalnızca halife unvanıyla, padişahlık yetkisi olmaksızın seçmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Saltanatın kaldırılmasının ardından TBMM tarafından padişahlık yetkisi olmaksızın yalnızca halife unvanıyla seçilen kişi kimdir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Abdülmecid Efendi', true, 4),
  ('VI. Mehmed Vahdettin', false, 2),
  ('V. Mehmed Reşad', false, 1),
  ('Mustafa Kemal Atatürk', false, 0),
  ('İsmet İnönü', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?', 'Atatürk ilkelerini tanımlarıyla eşleştirir.', 'Laiklik ilkesi, din ile devlet işlerinin birbirinden ayrılmasını, devletin tüm din ve inançlara eşit mesafede durmasını ifade eder; halifeliğin kaldırılması ve Medeni Kanun''un kabulü gibi birçok inkılabın temel dayanağıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Laiklik', true, 0),
  ('Halkçılık', false, 2),
  ('Devletçilik', false, 3),
  ('Milliyetçilik', false, 1),
  ('İnkılapçılık', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?', 'Atatürk ilkelerini tanımlarıyla eşleştirir.', 'Laiklik ilkesi, din ile devlet işlerinin birbirinden ayrılmasını, devletin tüm din ve inançlara eşit mesafede durmasını ifade eder; halifeliğin kaldırılması ve Medeni Kanun''un kabulü gibi birçok inkılabın temel dayanağıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Laiklik', true, 0),
  ('Halkçılık', false, 2),
  ('Devletçilik', false, 3),
  ('Milliyetçilik', false, 1),
  ('İnkılapçılık', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?', 'Atatürk ilkelerini tanımlarıyla eşleştirir.', 'Laiklik ilkesi, din ile devlet işlerinin birbirinden ayrılmasını, devletin tüm din ve inançlara eşit mesafede durmasını ifade eder; halifeliğin kaldırılması ve Medeni Kanun''un kabulü gibi birçok inkılabın temel dayanağıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Atatürk ilkelerinden hangisi din işleri ile devlet işlerinin birbirinden ayrılmasını ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Laiklik', true, 0),
  ('Halkçılık', false, 2),
  ('Devletçilik', false, 3),
  ('Milliyetçilik', false, 1),
  ('İnkılapçılık', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?', 'Devletçilik ilkesinin ekonomi alanındaki uygulamalarını bilir.', 'Devletçilik ilkesi gereğince devlet, 1930''lu yıllarda ekonomide düzenleyici ve üretici bir rol üstlenmiş; bu doğrultuda Sümerbank gibi devlet iktisadi teşekkülleri kurularak sanayileşme devlet eliyle desteklenmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sümerbank', true, 4),
  ('Reji İdaresi', false, 2),
  ('Duyun-u Umumiye İdaresi', false, 1),
  ('Osmanlı Bankası', false, 0),
  ('Ziraat Bankası', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?', 'Devletçilik ilkesinin ekonomi alanındaki uygulamalarını bilir.', 'Devletçilik ilkesi gereğince devlet, 1930''lu yıllarda ekonomide düzenleyici ve üretici bir rol üstlenmiş; bu doğrultuda Sümerbank gibi devlet iktisadi teşekkülleri kurularak sanayileşme devlet eliyle desteklenmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sümerbank', true, 4),
  ('Reji İdaresi', false, 2),
  ('Duyun-u Umumiye İdaresi', false, 1),
  ('Osmanlı Bankası', false, 0),
  ('Ziraat Bankası', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?', 'Devletçilik ilkesinin ekonomi alanındaki uygulamalarını bilir.', 'Devletçilik ilkesi gereğince devlet, 1930''lu yıllarda ekonomide düzenleyici ve üretici bir rol üstlenmiş; bu doğrultuda Sümerbank gibi devlet iktisadi teşekkülleri kurularak sanayileşme devlet eliyle desteklenmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Devletçilik ilkesi doğrultusunda 1930''lu yıllarda sanayileşmeyi hızlandırmak amacıyla kurulan devlet iktisadi teşekküllerine örnek aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sümerbank', true, 4),
  ('Reji İdaresi', false, 2),
  ('Duyun-u Umumiye İdaresi', false, 1),
  ('Osmanlı Bankası', false, 0),
  ('Ziraat Bankası', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?', 'Saltanatın kaldırılmasına giden sürecin nedenini kavrar.', 'İtilaf Devletleri, Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet edince, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İtilaf Devletlerinin Lozan Konferansı''na hem İstanbul hem de Ankara hükümetini birlikte davet etmesi', true, 4),
  ('Halifeliğin kaldırılması', false, 2),
  ('Cumhuriyetin ilan edilmesi', false, 3),
  ('Sakarya Meydan Muharebesi''nin kazanılması', false, 1),
  ('Mustafa Kemal''in Başkomutan seçilmesi', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?', 'Saltanatın kaldırılmasına giden sürecin nedenini kavrar.', 'İtilaf Devletleri, Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet edince, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İtilaf Devletlerinin Lozan Konferansı''na hem İstanbul hem de Ankara hükümetini birlikte davet etmesi', true, 4),
  ('Halifeliğin kaldırılması', false, 2),
  ('Cumhuriyetin ilan edilmesi', false, 3),
  ('Sakarya Meydan Muharebesi''nin kazanılması', false, 1),
  ('Mustafa Kemal''in Başkomutan seçilmesi', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?', 'Saltanatın kaldırılmasına giden sürecin nedenini kavrar.', 'İtilaf Devletleri, Lozan Barış Konferansı''na hem İstanbul Hükümeti''ni hem de TBMM Hükümeti''ni birlikte davet edince, TBMM barış görüşmelerinde tek meşru muhatap olmak amacıyla 1 Kasım 1922''de saltanatı kaldırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM''nin saltanatı kaldırma kararını almasında etkili olan temel gelişme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İtilaf Devletlerinin Lozan Konferansı''na hem İstanbul hem de Ankara hükümetini birlikte davet etmesi', true, 4),
  ('Halifeliğin kaldırılması', false, 2),
  ('Cumhuriyetin ilan edilmesi', false, 3),
  ('Sakarya Meydan Muharebesi''nin kazanılması', false, 1),
  ('Mustafa Kemal''in Başkomutan seçilmesi', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?', 'Atatürk ilkelerinin anayasal süreçteki yerini kronolojik olarak bilir.', 'Altı ilke önce 1931 yılında Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek devlet politikası hâline gelmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1937', true, 1),
  ('1931', false, 4),
  ('1924', false, 0),
  ('1946', false, 3),
  ('1961', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?', 'Atatürk ilkelerinin anayasal süreçteki yerini kronolojik olarak bilir.', 'Altı ilke önce 1931 yılında Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek devlet politikası hâline gelmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1937', true, 1),
  ('1931', false, 4),
  ('1924', false, 0),
  ('1946', false, 3),
  ('1961', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İnkılap Tarihi' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?', 'Atatürk ilkelerinin anayasal süreçteki yerini kronolojik olarak bilir.', 'Altı ilke önce 1931 yılında Cumhuriyet Halk Partisi''nin parti programına girmiş, ardından 1937 yılında yapılan bir anayasa değişikliğiyle Türkiye Cumhuriyeti Anayasası''na eklenerek devlet politikası hâline gelmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyetçilik, Milliyetçilik, Halkçılık, Devletçilik, Laiklik ve İnkılapçılık ilkeleri (Altı Ok) ilk kez hangi yıl Türkiye Cumhuriyeti Anayasası''na eklenmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1937', true, 1),
  ('1931', false, 4),
  ('1924', false, 0),
  ('1946', false, 3),
  ('1961', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: İlk Türk-İslam Devletleri (Tarih / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması
Büyük Selçuklu Devleti, Sultan Sencer döneminde doğuda güçlenen ve Moğol kökenli olduğu düşünülen Karahitaylara karşı 1141''de Katvan''da ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki nüfuzunu büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamıştır. Katvan, Dandanakan Savaşı''nın (1040) tam tersi bir işlev görür: Dandanakan, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler üzerindeki zaferiyle devletin KURULUŞUNU sağlarken, Katvan yenilgisi Büyük Selçuklu''nun YIKILIŞ sürecini hızlandırmıştır. Bu süreçte Sultan Sencer''in 1157''de ölmesiyle Büyük Selçuklu Devleti fiilen sona ermiş, yerini Harzemşahlar, çeşitli atabeylikler (Musul, Şam, Fars atabeylikleri gibi) ve Anadolu''da Türkiye Selçukluları gibi bağımsız Türk-İslam devletlerine bırakmıştır.

## Miryokefalon Savaşı (1176)
Anadolu Selçuklu Devleti, II. Kılıçarslan döneminde Bizans İmparatoru I. Manuel Komnenos komutasındaki büyük ve donanımlı bir orduyu 1176''da Miryokefalon''da bozguna uğratmıştır. Bu zafer, Bizans''ın Anadolu''yu yeniden ele geçirme umudunu tamamen yitirmesine yol açmış ve Bizans''ı kalıcı bir savunma pozisyonuna itmiştir. Malazgirt Zaferi (1071) Anadolu''nun Türklere AÇILMASINI sağlarken, Miryokefalon Zaferi Anadolu''nun Türk yurdu oluşunu KESİNLEŞTİRMİŞTİR; bu ayrım -Malazgirt''in "kapı açma", Miryokefalon''un "kalıcılığı tescil etme" işlevi- ÖSYM''nin sıkça vurguladığı bir noktadır. İlginç biçimde, II. Kılıçarslan bu büyük zaferin ardından ülkesini oğulları arasında paylaştırmış; bu karar kısa vadede taht kavgalarına yol açarak devletin iç bütünlüğünü zayıflatmıştır. Savaş sonrasında İmparator Manuel Komnenos''un barış istemek zorunda kalması ve Bizans''ın bir daha Anadolu''yu geri alma girişiminde bulunamaması, Anadolu''daki güç dengesinin kalıcı olarak Türkler lehine döndüğünün açık bir göstergesidir. Bu nedenle Miryokefalon, askeri açıdan büyük bir zafer olmasına rağmen, siyasi sonuçları bakımından devlet için karışık bir miras bırakmıştır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1)
  and tc.content_md not like '%## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması%';

-- konu: İlk Türk-İslam Devletleri (Tarih / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması
Büyük Selçuklu Devleti, Sultan Sencer döneminde doğuda güçlenen ve Moğol kökenli olduğu düşünülen Karahitaylara karşı 1141''de Katvan''da ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki nüfuzunu büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamıştır. Katvan, Dandanakan Savaşı''nın (1040) tam tersi bir işlev görür: Dandanakan, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler üzerindeki zaferiyle devletin KURULUŞUNU sağlarken, Katvan yenilgisi Büyük Selçuklu''nun YIKILIŞ sürecini hızlandırmıştır. Bu süreçte Sultan Sencer''in 1157''de ölmesiyle Büyük Selçuklu Devleti fiilen sona ermiş, yerini Harzemşahlar, çeşitli atabeylikler (Musul, Şam, Fars atabeylikleri gibi) ve Anadolu''da Türkiye Selçukluları gibi bağımsız Türk-İslam devletlerine bırakmıştır.

## Miryokefalon Savaşı (1176)
Anadolu Selçuklu Devleti, II. Kılıçarslan döneminde Bizans İmparatoru I. Manuel Komnenos komutasındaki büyük ve donanımlı bir orduyu 1176''da Miryokefalon''da bozguna uğratmıştır. Bu zafer, Bizans''ın Anadolu''yu yeniden ele geçirme umudunu tamamen yitirmesine yol açmış ve Bizans''ı kalıcı bir savunma pozisyonuna itmiştir. Malazgirt Zaferi (1071) Anadolu''nun Türklere AÇILMASINI sağlarken, Miryokefalon Zaferi Anadolu''nun Türk yurdu oluşunu KESİNLEŞTİRMİŞTİR; bu ayrım -Malazgirt''in "kapı açma", Miryokefalon''un "kalıcılığı tescil etme" işlevi- ÖSYM''nin sıkça vurguladığı bir noktadır. İlginç biçimde, II. Kılıçarslan bu büyük zaferin ardından ülkesini oğulları arasında paylaştırmış; bu karar kısa vadede taht kavgalarına yol açarak devletin iç bütünlüğünü zayıflatmıştır. Savaş sonrasında İmparator Manuel Komnenos''un barış istemek zorunda kalması ve Bizans''ın bir daha Anadolu''yu geri alma girişiminde bulunamaması, Anadolu''daki güç dengesinin kalıcı olarak Türkler lehine döndüğünün açık bir göstergesidir. Bu nedenle Miryokefalon, askeri açıdan büyük bir zafer olmasına rağmen, siyasi sonuçları bakımından devlet için karışık bir miras bırakmıştır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1)
  and tc.content_md not like '%## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması%';

-- konu: İlk Türk-İslam Devletleri (Tarih / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması
Büyük Selçuklu Devleti, Sultan Sencer döneminde doğuda güçlenen ve Moğol kökenli olduğu düşünülen Karahitaylara karşı 1141''de Katvan''da ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki nüfuzunu büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamıştır. Katvan, Dandanakan Savaşı''nın (1040) tam tersi bir işlev görür: Dandanakan, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler üzerindeki zaferiyle devletin KURULUŞUNU sağlarken, Katvan yenilgisi Büyük Selçuklu''nun YIKILIŞ sürecini hızlandırmıştır. Bu süreçte Sultan Sencer''in 1157''de ölmesiyle Büyük Selçuklu Devleti fiilen sona ermiş, yerini Harzemşahlar, çeşitli atabeylikler (Musul, Şam, Fars atabeylikleri gibi) ve Anadolu''da Türkiye Selçukluları gibi bağımsız Türk-İslam devletlerine bırakmıştır.

## Miryokefalon Savaşı (1176)
Anadolu Selçuklu Devleti, II. Kılıçarslan döneminde Bizans İmparatoru I. Manuel Komnenos komutasındaki büyük ve donanımlı bir orduyu 1176''da Miryokefalon''da bozguna uğratmıştır. Bu zafer, Bizans''ın Anadolu''yu yeniden ele geçirme umudunu tamamen yitirmesine yol açmış ve Bizans''ı kalıcı bir savunma pozisyonuna itmiştir. Malazgirt Zaferi (1071) Anadolu''nun Türklere AÇILMASINI sağlarken, Miryokefalon Zaferi Anadolu''nun Türk yurdu oluşunu KESİNLEŞTİRMİŞTİR; bu ayrım -Malazgirt''in "kapı açma", Miryokefalon''un "kalıcılığı tescil etme" işlevi- ÖSYM''nin sıkça vurguladığı bir noktadır. İlginç biçimde, II. Kılıçarslan bu büyük zaferin ardından ülkesini oğulları arasında paylaştırmış; bu karar kısa vadede taht kavgalarına yol açarak devletin iç bütünlüğünü zayıflatmıştır. Savaş sonrasında İmparator Manuel Komnenos''un barış istemek zorunda kalması ve Bizans''ın bir daha Anadolu''yu geri alma girişiminde bulunamaması, Anadolu''daki güç dengesinin kalıcı olarak Türkler lehine döndüğünün açık bir göstergesidir. Bu nedenle Miryokefalon, askeri açıdan büyük bir zafer olmasına rağmen, siyasi sonuçları bakımından devlet için karışık bir miras bırakmıştır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1)
  and tc.content_md not like '%## Katvan Savaşı (1141) ve Büyük Selçuklu''nun Zayıflaması%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?', 'Büyük Selçuklu Devleti''nin zayıflama sürecindeki önemli savaşı bilir.', 'Katvan Savaşı, 1141 yılında Sultan Sencer komutasındaki Büyük Selçuklu ordusu ile Karahitaylar arasında yapılmış ve Selçuklular ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki otoritesinin sarsılmasına yol açmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Katvan Savaşı', true, 2),
  ('Dandanakan Savaşı', false, 3),
  ('Malazgirt Savaşı', false, 1),
  ('Miryokefalon Savaşı', false, 0),
  ('Kösedağ Savaşı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?', 'Büyük Selçuklu Devleti''nin zayıflama sürecindeki önemli savaşı bilir.', 'Katvan Savaşı, 1141 yılında Sultan Sencer komutasındaki Büyük Selçuklu ordusu ile Karahitaylar arasında yapılmış ve Selçuklular ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki otoritesinin sarsılmasına yol açmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Katvan Savaşı', true, 2),
  ('Dandanakan Savaşı', false, 3),
  ('Malazgirt Savaşı', false, 1),
  ('Miryokefalon Savaşı', false, 0),
  ('Kösedağ Savaşı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?', 'Büyük Selçuklu Devleti''nin zayıflama sürecindeki önemli savaşı bilir.', 'Katvan Savaşı, 1141 yılında Sultan Sencer komutasındaki Büyük Selçuklu ordusu ile Karahitaylar arasında yapılmış ve Selçuklular ağır bir yenilgiye uğramıştır. Bu yenilgi, devletin Orta Asya''daki otoritesinin sarsılmasına yol açmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1141 yılında Büyük Selçuklu Devleti ile Karahitaylar arasında yapılan ve Sultan Sencer''in ağır bir yenilgi aldığı savaş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Katvan Savaşı', true, 2),
  ('Dandanakan Savaşı', false, 3),
  ('Malazgirt Savaşı', false, 1),
  ('Miryokefalon Savaşı', false, 0),
  ('Kösedağ Savaşı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?', 'Miryokefalon Savaşı''nın taraflarını ve önemini bilir.', 'Miryokefalon Savaşı, 1176''da II. Kılıçarslan komutasındaki Anadolu Selçuklu ordusunun Bizans İmparatoru I. Manuel Komnenos''a karşı kazandığı büyük bir zaferdir ve Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Miryokefalon Savaşı', true, 4),
  ('Malazgirt Savaşı', false, 3),
  ('Katvan Savaşı', false, 1),
  ('Kösedağ Savaşı', false, 2),
  ('Dandanakan Savaşı', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?', 'Miryokefalon Savaşı''nın taraflarını ve önemini bilir.', 'Miryokefalon Savaşı, 1176''da II. Kılıçarslan komutasındaki Anadolu Selçuklu ordusunun Bizans İmparatoru I. Manuel Komnenos''a karşı kazandığı büyük bir zaferdir ve Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Miryokefalon Savaşı', true, 4),
  ('Malazgirt Savaşı', false, 3),
  ('Katvan Savaşı', false, 1),
  ('Kösedağ Savaşı', false, 2),
  ('Dandanakan Savaşı', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?', 'Miryokefalon Savaşı''nın taraflarını ve önemini bilir.', 'Miryokefalon Savaşı, 1176''da II. Kılıçarslan komutasındaki Anadolu Selçuklu ordusunun Bizans İmparatoru I. Manuel Komnenos''a karşı kazandığı büyük bir zaferdir ve Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anadolu Selçuklu Devleti''nin II. Kılıçarslan döneminde Bizans İmparatoru Manuel Komnenos''a karşı 1176''da kazandığı ve Bizans''ın Anadolu''yu geri alma umudunu bitiren zafer aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Miryokefalon Savaşı', true, 4),
  ('Malazgirt Savaşı', false, 3),
  ('Katvan Savaşı', false, 1),
  ('Kösedağ Savaşı', false, 2),
  ('Dandanakan Savaşı', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Anadolu''nun Türkleşme sürecindeki iki önemli zaferin işlevini ayırt eder.', 'Malazgirt Zaferi, Anadolu''nun kapılarının Türklere açılmasını sağlayan ilk dönüm noktasıyken; Miryokefalon Zaferi, Bizans''ın Anadolu''yu geri alma umudunu tamamen yitirmesine yol açarak Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Malazgirt Anadolu''nun kapılarını açarken, Miryokefalon Anadolu''nun Türklüğünü kesinleştirmiştir.', true, 1),
  ('Her iki savaş da Bizans''ın zaferiyle sonuçlanmıştır.', false, 3),
  ('Malazgirt, Karahitaylara karşı kazanılmıştır.', false, 4),
  ('Miryokefalon, Büyük Selçuklu Devleti tarafından kazanılmıştır.', false, 2),
  ('Malazgirt Zaferi Anadolu Selçuklu Devleti tarafından kazanılmıştır.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Anadolu''nun Türkleşme sürecindeki iki önemli zaferin işlevini ayırt eder.', 'Malazgirt Zaferi, Anadolu''nun kapılarının Türklere açılmasını sağlayan ilk dönüm noktasıyken; Miryokefalon Zaferi, Bizans''ın Anadolu''yu geri alma umudunu tamamen yitirmesine yol açarak Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Malazgirt Anadolu''nun kapılarını açarken, Miryokefalon Anadolu''nun Türklüğünü kesinleştirmiştir.', true, 1),
  ('Her iki savaş da Bizans''ın zaferiyle sonuçlanmıştır.', false, 3),
  ('Malazgirt, Karahitaylara karşı kazanılmıştır.', false, 4),
  ('Miryokefalon, Büyük Selçuklu Devleti tarafından kazanılmıştır.', false, 2),
  ('Malazgirt Zaferi Anadolu Selçuklu Devleti tarafından kazanılmıştır.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?', 'Anadolu''nun Türkleşme sürecindeki iki önemli zaferin işlevini ayırt eder.', 'Malazgirt Zaferi, Anadolu''nun kapılarının Türklere açılmasını sağlayan ilk dönüm noktasıyken; Miryokefalon Zaferi, Bizans''ın Anadolu''yu geri alma umudunu tamamen yitirmesine yol açarak Anadolu''nun Türk yurdu oluşunu kesinleştirmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Malazgirt Zaferi (1071) ile Miryokefalon Zaferi (1176) karşılaştırıldığında aşağıdaki yargılardan hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Malazgirt Anadolu''nun kapılarını açarken, Miryokefalon Anadolu''nun Türklüğünü kesinleştirmiştir.', true, 1),
  ('Her iki savaş da Bizans''ın zaferiyle sonuçlanmıştır.', false, 3),
  ('Malazgirt, Karahitaylara karşı kazanılmıştır.', false, 4),
  ('Miryokefalon, Büyük Selçuklu Devleti tarafından kazanılmıştır.', false, 2),
  ('Malazgirt Zaferi Anadolu Selçuklu Devleti tarafından kazanılmıştır.', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?', 'Katvan Savaşı''nın Büyük Selçuklu''nun dağılma sürecine etkisini bilir.', 'Katvan yenilgisi, Büyük Selçuklu Devleti''nin Orta Asya''daki otoritesini büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamış, devletin dağılma sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Harzemşahlar gibi bağlı beyliklerin bağımsızlığını ilan etmesi ve devletin dağılma sürecinin hızlanması', true, 2),
  ('Anadolu''nun Türklere açılması', false, 4),
  ('Devletin kuruluşunun tamamlanması', false, 1),
  ('Bağdat''ın halifelik baskısından kurtarılması', false, 0),
  ('Nizamiye Medreseleri''nin kurulması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?', 'Katvan Savaşı''nın Büyük Selçuklu''nun dağılma sürecine etkisini bilir.', 'Katvan yenilgisi, Büyük Selçuklu Devleti''nin Orta Asya''daki otoritesini büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamış, devletin dağılma sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Harzemşahlar gibi bağlı beyliklerin bağımsızlığını ilan etmesi ve devletin dağılma sürecinin hızlanması', true, 2),
  ('Anadolu''nun Türklere açılması', false, 4),
  ('Devletin kuruluşunun tamamlanması', false, 1),
  ('Bağdat''ın halifelik baskısından kurtarılması', false, 0),
  ('Nizamiye Medreseleri''nin kurulması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?', 'Katvan Savaşı''nın Büyük Selçuklu''nun dağılma sürecine etkisini bilir.', 'Katvan yenilgisi, Büyük Selçuklu Devleti''nin Orta Asya''daki otoritesini büyük ölçüde kaybetmesine ve kendisine bağlı Harzemşahlar gibi beyliklerin bağımsızlıklarını ilan etmesine zemin hazırlamış, devletin dağılma sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Katvan Savaşı''nın (1141) Büyük Selçuklu Devleti açısından en önemli sonucu aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Harzemşahlar gibi bağlı beyliklerin bağımsızlığını ilan etmesi ve devletin dağılma sürecinin hızlanması', true, 2),
  ('Anadolu''nun Türklere açılması', false, 4),
  ('Devletin kuruluşunun tamamlanması', false, 1),
  ('Bağdat''ın halifelik baskısından kurtarılması', false, 0),
  ('Nizamiye Medreseleri''nin kurulması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?', 'Büyük Selçuklu Devleti''nin kuruluş ve yıkılış sürecindeki iki savaşı karşılaştırır.', 'Dandanakan Savaşı, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler''e karşı kazandığı ve Büyük Selçuklu Devleti''nin kuruluşunu sağlayan zaferdir. Katvan Savaşı ise Sultan Sencer döneminde Karahitaylara karşı alınan bir yenilgidir ve devletin yıkılış sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Dandanakan, Selçukluların kuruluşunu sağlayan bir zaferken; Katvan, devletin yıkılış sürecini hızlandıran bir yenilgidir.', true, 0),
  ('Her iki savaş da Selçukluların zaferiyle sonuçlanmıştır.', false, 2),
  ('Dandanakan, Karahitaylara karşı kazanılmıştır.', false, 1),
  ('Katvan, Gaznelilere karşı kazanılmıştır.', false, 4),
  ('Her iki savaş da Anadolu''da gerçekleşmiştir.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?', 'Büyük Selçuklu Devleti''nin kuruluş ve yıkılış sürecindeki iki savaşı karşılaştırır.', 'Dandanakan Savaşı, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler''e karşı kazandığı ve Büyük Selçuklu Devleti''nin kuruluşunu sağlayan zaferdir. Katvan Savaşı ise Sultan Sencer döneminde Karahitaylara karşı alınan bir yenilgidir ve devletin yıkılış sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Dandanakan, Selçukluların kuruluşunu sağlayan bir zaferken; Katvan, devletin yıkılış sürecini hızlandıran bir yenilgidir.', true, 0),
  ('Her iki savaş da Selçukluların zaferiyle sonuçlanmıştır.', false, 2),
  ('Dandanakan, Karahitaylara karşı kazanılmıştır.', false, 1),
  ('Katvan, Gaznelilere karşı kazanılmıştır.', false, 4),
  ('Her iki savaş da Anadolu''da gerçekleşmiştir.', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Tarih' and t.name = 'İlk Türk-İslam Devletleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?', 'Büyük Selçuklu Devleti''nin kuruluş ve yıkılış sürecindeki iki savaşı karşılaştırır.', 'Dandanakan Savaşı, Tuğrul ve Çağrı Beyler önderliğindeki Selçukluların Gazneliler''e karşı kazandığı ve Büyük Selçuklu Devleti''nin kuruluşunu sağlayan zaferdir. Katvan Savaşı ise Sultan Sencer döneminde Karahitaylara karşı alınan bir yenilgidir ve devletin yıkılış sürecini hızlandırmıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dandanakan Savaşı (1040) ile Katvan Savaşı (1141) hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Dandanakan, Selçukluların kuruluşunu sağlayan bir zaferken; Katvan, devletin yıkılış sürecini hızlandıran bir yenilgidir.', true, 0),
  ('Her iki savaş da Selçukluların zaferiyle sonuçlanmıştır.', false, 2),
  ('Dandanakan, Karahitaylara karşı kazanılmıştır.', false, 1),
  ('Katvan, Gaznelilere karşı kazanılmıştır.', false, 4),
  ('Her iki savaş da Anadolu''da gerçekleşmiştir.', false, 3)
) as v(choice_text, is_correct, order_index);

-- ============ Coğrafya ============
-- konu: Türkiye'nin Yeri ve Konumu (Coğrafya / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Komşu Ülkeler ve Sınır Karşılaştırması
Türkiye kara sınırı boyunca sekiz ülkeyle komşudur: kuzeybatıda Yunanistan ve Bulgaristan, kuzeydoğuda Gürcistan, doğuda Ermenistan ve Nahçıvan Özerk Cumhuriyeti (Azerbaycan), yine doğuda İran, güneydoğuda Irak ve güneyde Suriye. Bu sekiz komşu arasında en uzun kara sınırı Suriye ile (yaklaşık 910 km), en kısa kara sınırı ise Nahçıvan (Azerbaycan) ile (yaklaşık 18 km) çizilmiştir. KPSS''de sık karıştırılan bir ayrıntı: Türkiye''nin Karadeniz''de kıyıdaş olduğu ülkeler (Gürcistan hariç Rusya, Ukrayna, Romanya, Bulgaristan) ile kara sınırı olan komşuları birbirine karıştırılmamalıdır — Rusya ve Ukrayna Türkiye''nin KARA komşusu değildir, yalnızca Karadeniz''i paylaştığı ülkelerdir.

## Montrö Boğazlar Sözleşmesi
Özel konumun sonuçlarından biri olan boğazların (İstanbul ve Çanakkale) hukuki statüsü, 1936 tarihli Montrö Boğazlar Sözleşmesi ile düzenlenir. Bu sözleşme Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır; barış zamanında ticaret gemilerine serbest geçiş hakkı verirken, savaş gemilerinin geçişini tonaj ve önceden bildirim süresi gibi kısıtlamalarla Türkiye''nin denetimine tabi tutar. Montrö, Türkiye''nin özel konumunun yalnızca coğrafi değil aynı zamanda uluslararası hukuki bir boyutu olduğunu gösteren somut bir örnektir. Sözleşmenin dikkat çekici bir ayrıntısı, savaş gemileri için Karadeniz''e kıyısı olan devletlerle kıyısı olmayan devletlere farklı tonaj ve bekleme süresi sınırları getirmesidir: kıyısı olmayan devletlerin savaş gemileri Karadeniz''de yalnızca sınırlı bir süre kalabilir ve toplam tonajları kısıtlıdır. Bu ayrım, güncel bölgesel gelişmelerde de sıkça gündeme gelir ve Türkiye''nin boğazlar üzerindeki denetim yetkisinin pratikteki karşılığını somutlaştırır.

## Yüzölçümü Büyüklüğü
Türkiye, yaklaşık 783.562 km²''lik yüzölçümüyle Avrupa kıtasının sayılı büyük ülkelerinden biridir. Bu geniş alan, hem matematik konumun (geniş enlem-boylam aralığı) hem de özel konumun (çeşitli iklim, bitki örtüsü ve yer şekli tiplerinin bir arada bulunması) sonuçlarının aynı ülke sınırları içinde gözlemlenebilmesine zemin hazırlar.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1)
  and tc.content_md not like '%## Komşu Ülkeler ve Sınır Karşılaştırması%';

-- konu: Türkiye'nin Yeri ve Konumu (Coğrafya / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Komşu Ülkeler ve Sınır Karşılaştırması
Türkiye kara sınırı boyunca sekiz ülkeyle komşudur: kuzeybatıda Yunanistan ve Bulgaristan, kuzeydoğuda Gürcistan, doğuda Ermenistan ve Nahçıvan Özerk Cumhuriyeti (Azerbaycan), yine doğuda İran, güneydoğuda Irak ve güneyde Suriye. Bu sekiz komşu arasında en uzun kara sınırı Suriye ile (yaklaşık 910 km), en kısa kara sınırı ise Nahçıvan (Azerbaycan) ile (yaklaşık 18 km) çizilmiştir. KPSS''de sık karıştırılan bir ayrıntı: Türkiye''nin Karadeniz''de kıyıdaş olduğu ülkeler (Gürcistan hariç Rusya, Ukrayna, Romanya, Bulgaristan) ile kara sınırı olan komşuları birbirine karıştırılmamalıdır — Rusya ve Ukrayna Türkiye''nin KARA komşusu değildir, yalnızca Karadeniz''i paylaştığı ülkelerdir.

## Montrö Boğazlar Sözleşmesi
Özel konumun sonuçlarından biri olan boğazların (İstanbul ve Çanakkale) hukuki statüsü, 1936 tarihli Montrö Boğazlar Sözleşmesi ile düzenlenir. Bu sözleşme Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır; barış zamanında ticaret gemilerine serbest geçiş hakkı verirken, savaş gemilerinin geçişini tonaj ve önceden bildirim süresi gibi kısıtlamalarla Türkiye''nin denetimine tabi tutar. Montrö, Türkiye''nin özel konumunun yalnızca coğrafi değil aynı zamanda uluslararası hukuki bir boyutu olduğunu gösteren somut bir örnektir. Sözleşmenin dikkat çekici bir ayrıntısı, savaş gemileri için Karadeniz''e kıyısı olan devletlerle kıyısı olmayan devletlere farklı tonaj ve bekleme süresi sınırları getirmesidir: kıyısı olmayan devletlerin savaş gemileri Karadeniz''de yalnızca sınırlı bir süre kalabilir ve toplam tonajları kısıtlıdır. Bu ayrım, güncel bölgesel gelişmelerde de sıkça gündeme gelir ve Türkiye''nin boğazlar üzerindeki denetim yetkisinin pratikteki karşılığını somutlaştırır.

## Yüzölçümü Büyüklüğü
Türkiye, yaklaşık 783.562 km²''lik yüzölçümüyle Avrupa kıtasının sayılı büyük ülkelerinden biridir. Bu geniş alan, hem matematik konumun (geniş enlem-boylam aralığı) hem de özel konumun (çeşitli iklim, bitki örtüsü ve yer şekli tiplerinin bir arada bulunması) sonuçlarının aynı ülke sınırları içinde gözlemlenebilmesine zemin hazırlar.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1)
  and tc.content_md not like '%## Komşu Ülkeler ve Sınır Karşılaştırması%';

-- konu: Türkiye'nin Yeri ve Konumu (Coğrafya / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Komşu Ülkeler ve Sınır Karşılaştırması
Türkiye kara sınırı boyunca sekiz ülkeyle komşudur: kuzeybatıda Yunanistan ve Bulgaristan, kuzeydoğuda Gürcistan, doğuda Ermenistan ve Nahçıvan Özerk Cumhuriyeti (Azerbaycan), yine doğuda İran, güneydoğuda Irak ve güneyde Suriye. Bu sekiz komşu arasında en uzun kara sınırı Suriye ile (yaklaşık 910 km), en kısa kara sınırı ise Nahçıvan (Azerbaycan) ile (yaklaşık 18 km) çizilmiştir. KPSS''de sık karıştırılan bir ayrıntı: Türkiye''nin Karadeniz''de kıyıdaş olduğu ülkeler (Gürcistan hariç Rusya, Ukrayna, Romanya, Bulgaristan) ile kara sınırı olan komşuları birbirine karıştırılmamalıdır — Rusya ve Ukrayna Türkiye''nin KARA komşusu değildir, yalnızca Karadeniz''i paylaştığı ülkelerdir.

## Montrö Boğazlar Sözleşmesi
Özel konumun sonuçlarından biri olan boğazların (İstanbul ve Çanakkale) hukuki statüsü, 1936 tarihli Montrö Boğazlar Sözleşmesi ile düzenlenir. Bu sözleşme Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır; barış zamanında ticaret gemilerine serbest geçiş hakkı verirken, savaş gemilerinin geçişini tonaj ve önceden bildirim süresi gibi kısıtlamalarla Türkiye''nin denetimine tabi tutar. Montrö, Türkiye''nin özel konumunun yalnızca coğrafi değil aynı zamanda uluslararası hukuki bir boyutu olduğunu gösteren somut bir örnektir. Sözleşmenin dikkat çekici bir ayrıntısı, savaş gemileri için Karadeniz''e kıyısı olan devletlerle kıyısı olmayan devletlere farklı tonaj ve bekleme süresi sınırları getirmesidir: kıyısı olmayan devletlerin savaş gemileri Karadeniz''de yalnızca sınırlı bir süre kalabilir ve toplam tonajları kısıtlıdır. Bu ayrım, güncel bölgesel gelişmelerde de sıkça gündeme gelir ve Türkiye''nin boğazlar üzerindeki denetim yetkisinin pratikteki karşılığını somutlaştırır.

## Yüzölçümü Büyüklüğü
Türkiye, yaklaşık 783.562 km²''lik yüzölçümüyle Avrupa kıtasının sayılı büyük ülkelerinden biridir. Bu geniş alan, hem matematik konumun (geniş enlem-boylam aralığı) hem de özel konumun (çeşitli iklim, bitki örtüsü ve yer şekli tiplerinin bir arada bulunması) sonuçlarının aynı ülke sınırları içinde gözlemlenebilmesine zemin hazırlar.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1)
  and tc.content_md not like '%## Komşu Ülkeler ve Sınır Karşılaştırması%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?', 'Türkiye''nin özel konumunun sonucu olan komşu ülkeleri doğru sayabilme.', 'Rusya, Türkiye ile yalnızca Karadeniz''i paylaşan bir ülkedir; aralarında kara sınırı bulunmaz. Türkiye''nin kara sınırı komşuları Yunanistan, Bulgaristan, Gürcistan, Ermenistan, Nahçıvan (Azerbaycan), İran, Irak ve Suriye''den ibarettir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Rusya', true, 1),
  ('Suriye', false, 3),
  ('İran', false, 0),
  ('Gürcistan', false, 2),
  ('Bulgaristan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?', 'Türkiye''nin özel konumunun sonucu olan komşu ülkeleri doğru sayabilme.', 'Rusya, Türkiye ile yalnızca Karadeniz''i paylaşan bir ülkedir; aralarında kara sınırı bulunmaz. Türkiye''nin kara sınırı komşuları Yunanistan, Bulgaristan, Gürcistan, Ermenistan, Nahçıvan (Azerbaycan), İran, Irak ve Suriye''den ibarettir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Rusya', true, 1),
  ('Suriye', false, 3),
  ('İran', false, 0),
  ('Gürcistan', false, 2),
  ('Bulgaristan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?', 'Türkiye''nin özel konumunun sonucu olan komşu ülkeleri doğru sayabilme.', 'Rusya, Türkiye ile yalnızca Karadeniz''i paylaşan bir ülkedir; aralarında kara sınırı bulunmaz. Türkiye''nin kara sınırı komşuları Yunanistan, Bulgaristan, Gürcistan, Ermenistan, Nahçıvan (Azerbaycan), İran, Irak ve Suriye''den ibarettir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı komşusu OLMAYAN ülke aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Rusya', true, 1),
  ('Suriye', false, 3),
  ('İran', false, 0),
  ('Gürcistan', false, 2),
  ('Bulgaristan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?', 'Özel konumun hukuki/uluslararası boyutunu (Montrö Sözleşmesi) bilme.', 'Montrö Boğazlar Sözleşmesi 1936''da imzalanmış olup Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır ve savaş/ticaret gemilerinin geçiş koşullarını düzenler. Lozan ve Sevr antlaşmaları farklı konuları (sınırlar, egemenlik) düzenleyen, boğazlarla doğrudan ilgili olmayan sözleşmelerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Montrö Boğazlar Sözleşmesi', true, 3),
  ('Lozan Antlaşması', false, 2),
  ('Sevr Antlaşması', false, 1),
  ('Ankara Antlaşması', false, 0),
  ('Paris Antlaşması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?', 'Özel konumun hukuki/uluslararası boyutunu (Montrö Sözleşmesi) bilme.', 'Montrö Boğazlar Sözleşmesi 1936''da imzalanmış olup Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır ve savaş/ticaret gemilerinin geçiş koşullarını düzenler. Lozan ve Sevr antlaşmaları farklı konuları (sınırlar, egemenlik) düzenleyen, boğazlarla doğrudan ilgili olmayan sözleşmelerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Montrö Boğazlar Sözleşmesi', true, 3),
  ('Lozan Antlaşması', false, 2),
  ('Sevr Antlaşması', false, 1),
  ('Ankara Antlaşması', false, 0),
  ('Paris Antlaşması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?', 'Özel konumun hukuki/uluslararası boyutunu (Montrö Sözleşmesi) bilme.', 'Montrö Boğazlar Sözleşmesi 1936''da imzalanmış olup Türkiye''ye boğazlar üzerinde tam egemenlik hakkı tanır ve savaş/ticaret gemilerinin geçiş koşullarını düzenler. Lozan ve Sevr antlaşmaları farklı konuları (sınırlar, egemenlik) düzenleyen, boğazlarla doğrudan ilgili olmayan sözleşmelerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İstanbul ve Çanakkale Boğazlarının hukuki statüsünü düzenleyen, Türkiye''ye boğazlar üzerinde egemenlik hakkı tanıyan ve 1936 yılında imzalanan uluslararası sözleşme aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Montrö Boğazlar Sözleşmesi', true, 3),
  ('Lozan Antlaşması', false, 2),
  ('Sevr Antlaşması', false, 1),
  ('Ankara Antlaşması', false, 0),
  ('Paris Antlaşması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?', 'Özel konumun sonucu olan sınır komşularını uzunluklarına göre karşılaştırabilme.', 'Türkiye''nin en uzun kara sınırı güneyde Suriye ile, en kısa kara sınırı ise doğuda Nahçıvan Özerk Cumhuriyeti (Azerbaycan) ile bulunmaktadır. Diğer seçeneklerdeki eşleştirmeler bu iki uç durumu yansıtmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Suriye – Nahçıvan (Azerbaycan)', true, 2),
  ('Irak – Yunanistan', false, 3),
  ('İran – Bulgaristan', false, 1),
  ('Suriye – İran', false, 0),
  ('Yunanistan – Gürcistan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?', 'Özel konumun sonucu olan sınır komşularını uzunluklarına göre karşılaştırabilme.', 'Türkiye''nin en uzun kara sınırı güneyde Suriye ile, en kısa kara sınırı ise doğuda Nahçıvan Özerk Cumhuriyeti (Azerbaycan) ile bulunmaktadır. Diğer seçeneklerdeki eşleştirmeler bu iki uç durumu yansıtmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Suriye – Nahçıvan (Azerbaycan)', true, 2),
  ('Irak – Yunanistan', false, 3),
  ('İran – Bulgaristan', false, 1),
  ('Suriye – İran', false, 0),
  ('Yunanistan – Gürcistan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?', 'Özel konumun sonucu olan sınır komşularını uzunluklarına göre karşılaştırabilme.', 'Türkiye''nin en uzun kara sınırı güneyde Suriye ile, en kısa kara sınırı ise doğuda Nahçıvan Özerk Cumhuriyeti (Azerbaycan) ile bulunmaktadır. Diğer seçeneklerdeki eşleştirmeler bu iki uç durumu yansıtmamaktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin kara sınırı en uzun olan komşusu ile en kısa olan komşusu aşağıdaki seçeneklerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Suriye – Nahçıvan (Azerbaycan)', true, 2),
  ('Irak – Yunanistan', false, 3),
  ('İran – Bulgaristan', false, 1),
  ('Suriye – İran', false, 0),
  ('Yunanistan – Gürcistan', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)', 'Matematik konumun sonucu olan yerel saat farkını boylam üzerinden hesaplayabilme.', '19 derecelik boylam farkı, 19x4=76 dakikalık (1 saat 16 dakika) bir yerel saat farkına karşılık gelir. Doğudaki yerler saati daha erken karşıladığı için batıdaki yer, doğudaki yerin saatinden 1 saat 16 dakika geridedir; bu nedenle en doğuda saat 12.00 iken en batıda yerel saat yaklaşık 10.44''tür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10.44', true, 4),
  ('11.00', false, 3),
  ('12.00', false, 0),
  ('13.16', false, 1),
  ('09.30', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)', 'Matematik konumun sonucu olan yerel saat farkını boylam üzerinden hesaplayabilme.', '19 derecelik boylam farkı, 19x4=76 dakikalık (1 saat 16 dakika) bir yerel saat farkına karşılık gelir. Doğudaki yerler saati daha erken karşıladığı için batıdaki yer, doğudaki yerin saatinden 1 saat 16 dakika geridedir; bu nedenle en doğuda saat 12.00 iken en batıda yerel saat yaklaşık 10.44''tür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10.44', true, 4),
  ('11.00', false, 3),
  ('12.00', false, 0),
  ('13.16', false, 1),
  ('09.30', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)', 'Matematik konumun sonucu olan yerel saat farkını boylam üzerinden hesaplayabilme.', '19 derecelik boylam farkı, 19x4=76 dakikalık (1 saat 16 dakika) bir yerel saat farkına karşılık gelir. Doğudaki yerler saati daha erken karşıladığı için batıdaki yer, doğudaki yerin saatinden 1 saat 16 dakika geridedir; bu nedenle en doğuda saat 12.00 iken en batıda yerel saat yaklaşık 10.44''tür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin en doğu noktası ile en batı noktası arasındaki boylam farkı yaklaşık 19 derecedir. Buna göre en doğudaki bir yerleşim yerinde yerel saat 12.00 iken en batıdaki bir yerleşim yerinde yerel saat yaklaşık kaçtır? (Her 15 derecelik boylam farkı 1 saatlik yerel saat farkına karşılık gelir.)'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('10.44', true, 4),
  ('11.00', false, 3),
  ('12.00', false, 0),
  ('13.16', false, 1),
  ('09.30', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?', 'Matematik konum ile özel konumun sonuçlarını ayırt edebilme (ileri düzey).', 'Boğazların uluslararası ticarette ve ulaşımda stratejik önem taşıması, Türkiye''nin yakın çevresiyle ilişkilerinden doğan bir sonuç olduğu için özel konumun sonucudur, matematik konumun değil. Diğer seçeneklerdeki eşleştirmeler (yerel saat-matematik konum, güneş ışını açısı-matematik konum, üç kıtaya yakınlık-özel konum, çok komşulu olma-özel konum) doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Boğazların uluslararası ticarette stratejik önem taşıması – Matematik konum', true, 0),
  ('Yerel saat farkının oluşması – Matematik konum', false, 1),
  ('Güneş ışınlarının geliş açısının mevsime göre değişmesi – Matematik konum', false, 4),
  ('Üç kıtaya yakın olunması – Özel konum', false, 3),
  ('Ülkenin çok sayıda komşuya sahip olması – Özel konum', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?', 'Matematik konum ile özel konumun sonuçlarını ayırt edebilme (ileri düzey).', 'Boğazların uluslararası ticarette ve ulaşımda stratejik önem taşıması, Türkiye''nin yakın çevresiyle ilişkilerinden doğan bir sonuç olduğu için özel konumun sonucudur, matematik konumun değil. Diğer seçeneklerdeki eşleştirmeler (yerel saat-matematik konum, güneş ışını açısı-matematik konum, üç kıtaya yakınlık-özel konum, çok komşulu olma-özel konum) doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Boğazların uluslararası ticarette stratejik önem taşıması – Matematik konum', true, 0),
  ('Yerel saat farkının oluşması – Matematik konum', false, 1),
  ('Güneş ışınlarının geliş açısının mevsime göre değişmesi – Matematik konum', false, 4),
  ('Üç kıtaya yakın olunması – Özel konum', false, 3),
  ('Ülkenin çok sayıda komşuya sahip olması – Özel konum', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yeri ve Konumu' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?', 'Matematik konum ile özel konumun sonuçlarını ayırt edebilme (ileri düzey).', 'Boğazların uluslararası ticarette ve ulaşımda stratejik önem taşıması, Türkiye''nin yakın çevresiyle ilişkilerinden doğan bir sonuç olduğu için özel konumun sonucudur, matematik konumun değil. Diğer seçeneklerdeki eşleştirmeler (yerel saat-matematik konum, güneş ışını açısı-matematik konum, üç kıtaya yakınlık-özel konum, çok komşulu olma-özel konum) doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki konum-sonuç eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Boğazların uluslararası ticarette stratejik önem taşıması – Matematik konum', true, 0),
  ('Yerel saat farkının oluşması – Matematik konum', false, 1),
  ('Güneş ışınlarının geliş açısının mevsime göre değişmesi – Matematik konum', false, 4),
  ('Üç kıtaya yakın olunması – Özel konum', false, 3),
  ('Ülkenin çok sayıda komşuya sahip olması – Özel konum', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: İklim (Coğrafya / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)
Akdeniz Bölgesi''nin kıyı şeridinde tipik Akdeniz iklimi görülürken, Toros Dağları''nın kuzeyinde kalan iç kesimlerde (Göller Yöresi — Isparta, Burdur, Eğirdir çevresi gibi) yükseltinin artmasıyla iklim belirgin biçimde karasallaşır: kışlar soğuk ve karlı geçer, yıllık sıcaklık farkı artar. Bu durum "bir yer, idari olarak Akdeniz Bölgesi sınırları içinde olduğu hâlde Akdeniz iklimi yaşamayabilir" ilkesinin klasik örneğidir; idari/coğrafi bölge sınırı ile iklim bölgesi sınırı HER ZAMAN örtüşmez.

## "Step" Kavramı: Bitki Örtüsü mü, İklim Tipi mi?
Sınavlarda sık karşılaşılan bir kavram kargaşası "step"in ne olduğudur: Step aslında bir BİTKİ ÖRTÜSÜ türüdür (kısa boylu, seyrek, kuraklığa dayanıklı otsu bitki topluluğu); "step iklimi" günlük dilde karasal iklimi anlatmak için kullanılsa da Türkiye''de görülen iklim tipinin bilimsel/resmî adı KARASAL İKLİM''dir, step ise bu iklimin doğal bitki örtüsüdür.

## Yıllık Yağış Miktarı: Somut Rakamlarla Karşılaştırma
Bölgeler arası yağış farkının büyüklüğünü somutlaştırmak faydalıdır: Rize ve çevresinde yıllık yağış miktarı 2000 mm''yi aşabilirken, İç Anadolu''nun Tuz Gölü çevresi ve Konya Ovası gibi çukur alanlarında bu miktar 300 mm''nin altına kadar düşebilir. Bu kata varan fark, Türkiye''nin küçük bir alanda ne denli büyük bir iklim çeşitliliğine sahip olduğunu gösteren somut bir kanıttır.

## Karadeniz İklimi İçinde Doğu-Batı Farkı
Karadeniz ikliminin kendi içinde de belirgin bir iç farklılaşma vardır: Doğu Karadeniz''de (Rize, Artvin çevresi) dağların kıyıya dik yaklaşması ve bakı etkisiyle yağış miktarı olağanüstü yüksekken, Batı Karadeniz''de (Sinop, Samsun çevresi) dağların kıyıya daha paralel uzanması nedeniyle yağış miktarı belirgin biçimde azalır; buna rağmen Batı Karadeniz de hâlâ her mevsim yağış alan, yaz kuraklığı yaşamayan bir iklim kuşağıdır. Bu ayrım, "Karadeniz ikliminin tamamı aynı miktarda yağış alır" gibi genellemeci ifadelerin yanlış olduğunu gösterir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1)
  and tc.content_md not like '%## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)%';

-- konu: İklim (Coğrafya / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)
Akdeniz Bölgesi''nin kıyı şeridinde tipik Akdeniz iklimi görülürken, Toros Dağları''nın kuzeyinde kalan iç kesimlerde (Göller Yöresi — Isparta, Burdur, Eğirdir çevresi gibi) yükseltinin artmasıyla iklim belirgin biçimde karasallaşır: kışlar soğuk ve karlı geçer, yıllık sıcaklık farkı artar. Bu durum "bir yer, idari olarak Akdeniz Bölgesi sınırları içinde olduğu hâlde Akdeniz iklimi yaşamayabilir" ilkesinin klasik örneğidir; idari/coğrafi bölge sınırı ile iklim bölgesi sınırı HER ZAMAN örtüşmez.

## "Step" Kavramı: Bitki Örtüsü mü, İklim Tipi mi?
Sınavlarda sık karşılaşılan bir kavram kargaşası "step"in ne olduğudur: Step aslında bir BİTKİ ÖRTÜSÜ türüdür (kısa boylu, seyrek, kuraklığa dayanıklı otsu bitki topluluğu); "step iklimi" günlük dilde karasal iklimi anlatmak için kullanılsa da Türkiye''de görülen iklim tipinin bilimsel/resmî adı KARASAL İKLİM''dir, step ise bu iklimin doğal bitki örtüsüdür.

## Yıllık Yağış Miktarı: Somut Rakamlarla Karşılaştırma
Bölgeler arası yağış farkının büyüklüğünü somutlaştırmak faydalıdır: Rize ve çevresinde yıllık yağış miktarı 2000 mm''yi aşabilirken, İç Anadolu''nun Tuz Gölü çevresi ve Konya Ovası gibi çukur alanlarında bu miktar 300 mm''nin altına kadar düşebilir. Bu kata varan fark, Türkiye''nin küçük bir alanda ne denli büyük bir iklim çeşitliliğine sahip olduğunu gösteren somut bir kanıttır.

## Karadeniz İklimi İçinde Doğu-Batı Farkı
Karadeniz ikliminin kendi içinde de belirgin bir iç farklılaşma vardır: Doğu Karadeniz''de (Rize, Artvin çevresi) dağların kıyıya dik yaklaşması ve bakı etkisiyle yağış miktarı olağanüstü yüksekken, Batı Karadeniz''de (Sinop, Samsun çevresi) dağların kıyıya daha paralel uzanması nedeniyle yağış miktarı belirgin biçimde azalır; buna rağmen Batı Karadeniz de hâlâ her mevsim yağış alan, yaz kuraklığı yaşamayan bir iklim kuşağıdır. Bu ayrım, "Karadeniz ikliminin tamamı aynı miktarda yağış alır" gibi genellemeci ifadelerin yanlış olduğunu gösterir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1)
  and tc.content_md not like '%## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)%';

-- konu: İklim (Coğrafya / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)
Akdeniz Bölgesi''nin kıyı şeridinde tipik Akdeniz iklimi görülürken, Toros Dağları''nın kuzeyinde kalan iç kesimlerde (Göller Yöresi — Isparta, Burdur, Eğirdir çevresi gibi) yükseltinin artmasıyla iklim belirgin biçimde karasallaşır: kışlar soğuk ve karlı geçer, yıllık sıcaklık farkı artar. Bu durum "bir yer, idari olarak Akdeniz Bölgesi sınırları içinde olduğu hâlde Akdeniz iklimi yaşamayabilir" ilkesinin klasik örneğidir; idari/coğrafi bölge sınırı ile iklim bölgesi sınırı HER ZAMAN örtüşmez.

## "Step" Kavramı: Bitki Örtüsü mü, İklim Tipi mi?
Sınavlarda sık karşılaşılan bir kavram kargaşası "step"in ne olduğudur: Step aslında bir BİTKİ ÖRTÜSÜ türüdür (kısa boylu, seyrek, kuraklığa dayanıklı otsu bitki topluluğu); "step iklimi" günlük dilde karasal iklimi anlatmak için kullanılsa da Türkiye''de görülen iklim tipinin bilimsel/resmî adı KARASAL İKLİM''dir, step ise bu iklimin doğal bitki örtüsüdür.

## Yıllık Yağış Miktarı: Somut Rakamlarla Karşılaştırma
Bölgeler arası yağış farkının büyüklüğünü somutlaştırmak faydalıdır: Rize ve çevresinde yıllık yağış miktarı 2000 mm''yi aşabilirken, İç Anadolu''nun Tuz Gölü çevresi ve Konya Ovası gibi çukur alanlarında bu miktar 300 mm''nin altına kadar düşebilir. Bu kata varan fark, Türkiye''nin küçük bir alanda ne denli büyük bir iklim çeşitliliğine sahip olduğunu gösteren somut bir kanıttır.

## Karadeniz İklimi İçinde Doğu-Batı Farkı
Karadeniz ikliminin kendi içinde de belirgin bir iç farklılaşma vardır: Doğu Karadeniz''de (Rize, Artvin çevresi) dağların kıyıya dik yaklaşması ve bakı etkisiyle yağış miktarı olağanüstü yüksekken, Batı Karadeniz''de (Sinop, Samsun çevresi) dağların kıyıya daha paralel uzanması nedeniyle yağış miktarı belirgin biçimde azalır; buna rağmen Batı Karadeniz de hâlâ her mevsim yağış alan, yaz kuraklığı yaşamayan bir iklim kuşağıdır. Bu ayrım, "Karadeniz ikliminin tamamı aynı miktarda yağış alır" gibi genellemeci ifadelerin yanlış olduğunu gösterir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1)
  and tc.content_md not like '%## Yükseltinin İklim Üzerindeki Değiştirici Etkisi (Akdeniz Bölgesi''nde Karasallaşma)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?', 'Karasal iklim ile doğal bitki örtüsü (step) arasındaki ilişkiyi bilme.', 'Karasal iklimin egemen olduğu İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun bazı kesimlerinde kısa boylu, seyrek ve kuraklığa dayanıklı otsu bitki örtüsü olan step görülür. Maki Akdeniz ikliminin, orman ise Karadeniz ikliminin tipik bitki örtüsüdür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Step', true, 3),
  ('Maki', false, 1),
  ('Gür orman', false, 2),
  ('Tundra', false, 0),
  ('Yağmur ormanı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?', 'Karasal iklim ile doğal bitki örtüsü (step) arasındaki ilişkiyi bilme.', 'Karasal iklimin egemen olduğu İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun bazı kesimlerinde kısa boylu, seyrek ve kuraklığa dayanıklı otsu bitki örtüsü olan step görülür. Maki Akdeniz ikliminin, orman ise Karadeniz ikliminin tipik bitki örtüsüdür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Step', true, 3),
  ('Maki', false, 1),
  ('Gür orman', false, 2),
  ('Tundra', false, 0),
  ('Yağmur ormanı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?', 'Karasal iklim ile doğal bitki örtüsü (step) arasındaki ilişkiyi bilme.', 'Karasal iklimin egemen olduğu İç Anadolu, Doğu Anadolu ve Güneydoğu Anadolu''nun bazı kesimlerinde kısa boylu, seyrek ve kuraklığa dayanıklı otsu bitki örtüsü olan step görülür. Maki Akdeniz ikliminin, orman ise Karadeniz ikliminin tipik bitki örtüsüdür.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de karasal iklimin görüldüğü alanlarda yaygın olan doğal bitki örtüsü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Step', true, 3),
  ('Maki', false, 1),
  ('Gür orman', false, 2),
  ('Tundra', false, 0),
  ('Yağmur ormanı', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin yağış rejimi özelliklerini ayırt edebilme.', 'Akdeniz ikliminde yağış büyük ölçüde kış mevsiminde düşer, yazlar ise sıcak ve kuraktır. Karadeniz ikliminde ise yaz kuraklığı görülmez, her mevsim yağış alınır; bu iki iklimin yağış rejimi birbirinin tersidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Akdeniz iklimi', true, 1),
  ('Karadeniz iklimi', false, 0),
  ('Karasal iklim', false, 2),
  ('Marmara (geçiş) iklimi', false, 4),
  ('Step iklimi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin yağış rejimi özelliklerini ayırt edebilme.', 'Akdeniz ikliminde yağış büyük ölçüde kış mevsiminde düşer, yazlar ise sıcak ve kuraktır. Karadeniz ikliminde ise yaz kuraklığı görülmez, her mevsim yağış alınır; bu iki iklimin yağış rejimi birbirinin tersidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Akdeniz iklimi', true, 1),
  ('Karadeniz iklimi', false, 0),
  ('Karasal iklim', false, 2),
  ('Marmara (geçiş) iklimi', false, 4),
  ('Step iklimi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?', 'İklim tiplerinin yağış rejimi özelliklerini ayırt edebilme.', 'Akdeniz ikliminde yağış büyük ölçüde kış mevsiminde düşer, yazlar ise sıcak ve kuraktır. Karadeniz ikliminde ise yaz kuraklığı görülmez, her mevsim yağış alınır; bu iki iklimin yağış rejimi birbirinin tersidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yıl içinde en fazla yağışı kış mevsiminde alan, yazları ise belirgin bir kuraklığın yaşandığı iklim tipi aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Akdeniz iklimi', true, 1),
  ('Karadeniz iklimi', false, 0),
  ('Karasal iklim', false, 2),
  ('Marmara (geçiş) iklimi', false, 4),
  ('Step iklimi', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?', 'Yükseltinin iklim üzerindeki değiştirici etkisini somut bir örnekle açıklayabilme.', 'Göller Yöresi (Isparta-Burdur-Eğirdir çevresi), idari olarak Akdeniz Bölgesi sınırları içinde yer almasına rağmen Toros Dağları''nın kuzeyinde ve yüksekte bulunduğu için tipik Akdeniz iklimi yerine karasal iklim özellikleri gösterir; kışları soğuk ve karlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göller Yöresi (Isparta-Burdur çevresi)', true, 0),
  ('Antalya kıyı ovası', false, 3),
  ('Çukurova', false, 4),
  ('Ege kıyı şeridi', false, 2),
  ('Doğu Karadeniz kıyı şeridi', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?', 'Yükseltinin iklim üzerindeki değiştirici etkisini somut bir örnekle açıklayabilme.', 'Göller Yöresi (Isparta-Burdur-Eğirdir çevresi), idari olarak Akdeniz Bölgesi sınırları içinde yer almasına rağmen Toros Dağları''nın kuzeyinde ve yüksekte bulunduğu için tipik Akdeniz iklimi yerine karasal iklim özellikleri gösterir; kışları soğuk ve karlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göller Yöresi (Isparta-Burdur çevresi)', true, 0),
  ('Antalya kıyı ovası', false, 3),
  ('Çukurova', false, 4),
  ('Ege kıyı şeridi', false, 2),
  ('Doğu Karadeniz kıyı şeridi', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?', 'Yükseltinin iklim üzerindeki değiştirici etkisini somut bir örnekle açıklayabilme.', 'Göller Yöresi (Isparta-Burdur-Eğirdir çevresi), idari olarak Akdeniz Bölgesi sınırları içinde yer almasına rağmen Toros Dağları''nın kuzeyinde ve yüksekte bulunduğu için tipik Akdeniz iklimi yerine karasal iklim özellikleri gösterir; kışları soğuk ve karlıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Akdeniz Bölgesi sınırları içinde yer almasına karşın Toros Dağları''nın kuzeyinde ve yüksekte kalması nedeniyle kışları soğuk ve karlı geçen, karasal iklim özellikleri gösteren yöre aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Göller Yöresi (Isparta-Burdur çevresi)', true, 0),
  ('Antalya kıyı ovası', false, 3),
  ('Çukurova', false, 4),
  ('Ege kıyı şeridi', false, 2),
  ('Doğu Karadeniz kıyı şeridi', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?', 'Türkiye''de yağış miktarının bölgesel dağılışını somut örneklerle bilme.', 'Doğu Karadeniz kıyıları (özellikle Rize çevresi) Türkiye''nin en fazla yağış alan yeridir; buna karşılık Tuz Gölü çevresi ve İç Anadolu''nun bazı çukur alanları, denizden uzaklık ve çevresinin dağlarla kuşatılmış olması nedeniyle en az yağış alan yerler arasındadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Doğu Karadeniz kıyıları – Tuz Gölü çevresi', true, 3),
  ('Ege kıyıları – Doğu Karadeniz kıyıları', false, 2),
  ('Marmara – İç Anadolu''nun kuzeyi', false, 4),
  ('Akdeniz kıyıları – Doğu Anadolu''nun yüksek kesimleri', false, 0),
  ('Trakya – Güneydoğu Anadolu''nun tamamı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?', 'Türkiye''de yağış miktarının bölgesel dağılışını somut örneklerle bilme.', 'Doğu Karadeniz kıyıları (özellikle Rize çevresi) Türkiye''nin en fazla yağış alan yeridir; buna karşılık Tuz Gölü çevresi ve İç Anadolu''nun bazı çukur alanları, denizden uzaklık ve çevresinin dağlarla kuşatılmış olması nedeniyle en az yağış alan yerler arasındadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Doğu Karadeniz kıyıları – Tuz Gölü çevresi', true, 3),
  ('Ege kıyıları – Doğu Karadeniz kıyıları', false, 2),
  ('Marmara – İç Anadolu''nun kuzeyi', false, 4),
  ('Akdeniz kıyıları – Doğu Anadolu''nun yüksek kesimleri', false, 0),
  ('Trakya – Güneydoğu Anadolu''nun tamamı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?', 'Türkiye''de yağış miktarının bölgesel dağılışını somut örneklerle bilme.', 'Doğu Karadeniz kıyıları (özellikle Rize çevresi) Türkiye''nin en fazla yağış alan yeridir; buna karşılık Tuz Gölü çevresi ve İç Anadolu''nun bazı çukur alanları, denizden uzaklık ve çevresinin dağlarla kuşatılmış olması nedeniyle en az yağış alan yerler arasındadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de yıllık yağış miktarının en fazla ve en az olduğu yerler aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Doğu Karadeniz kıyıları – Tuz Gölü çevresi', true, 3),
  ('Ege kıyıları – Doğu Karadeniz kıyıları', false, 2),
  ('Marmara – İç Anadolu''nun kuzeyi', false, 4),
  ('Akdeniz kıyıları – Doğu Anadolu''nun yüksek kesimleri', false, 0),
  ('Trakya – Güneydoğu Anadolu''nun tamamı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.', 'Step kavramının bitki örtüsü mü iklim tipi mi olduğunu ayırt edebilme (ileri düzey kavram ayrımı).', 'Step bir bitki örtüsü türüdür, Türkiye''de görülen iklim tipinin resmî/bilimsel adı karasal iklimdir; bu nedenle II ve III doğrudur. I ifadesi ise stepin bağımsız bir iklim tipi olduğunu iddia ettiği için yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 0),
  ('Yalnız I', false, 2),
  ('I ve II', false, 3),
  ('Yalnız III', false, 1),
  ('I, II ve III', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.', 'Step kavramının bitki örtüsü mü iklim tipi mi olduğunu ayırt edebilme (ileri düzey kavram ayrımı).', 'Step bir bitki örtüsü türüdür, Türkiye''de görülen iklim tipinin resmî/bilimsel adı karasal iklimdir; bu nedenle II ve III doğrudur. I ifadesi ise stepin bağımsız bir iklim tipi olduğunu iddia ettiği için yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 0),
  ('Yalnız I', false, 2),
  ('I ve II', false, 3),
  ('Yalnız III', false, 1),
  ('I, II ve III', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'İklim' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.', 'Step kavramının bitki örtüsü mü iklim tipi mi olduğunu ayırt edebilme (ileri düzey kavram ayrımı).', 'Step bir bitki örtüsü türüdür, Türkiye''de görülen iklim tipinin resmî/bilimsel adı karasal iklimdir; bu nedenle II ve III doğrudur. I ifadesi ise stepin bağımsız bir iklim tipi olduğunu iddia ettiği için yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de görülen iklim tipleri ve "step" kavramıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Step, Türkiye''de resmî iklim sınıflandırmasında bağımsız bir iklim tipinin adıdır.
II. Step, karasal iklimin egemen olduğu alanlarda yaygın olan doğal bitki örtüsüdür.
III. "Step iklimi" ifadesi günlük dilde karasal iklimi anlatmak için kullanılabilir; ancak bu, bilimsel sınıflandırmada resmî bir iklim tipi adı değildir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 0),
  ('Yalnız I', false, 2),
  ('I ve II', false, 3),
  ('Yalnız III', false, 1),
  ('I, II ve III', false, 4)
) as v(choice_text, is_correct, order_index);

-- konu: Nüfus ve Yerleşme (Coğrafya / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Göç Türleri ve Nüfus Hareketliliği
Nüfus dağılışını yalnızca "nerede yaşanıyor" değil, "nasıl hareket ediliyor" sorusu da şekillendirir. Türkiye''de iç göç temel olarak birkaç biçimde görülür: KALICI göç (kırsal alandan kente kalıcı yerleşme amacıyla yapılan, sanayileşme ve iş imkânlarının tetiklediği göç) ve MEVSİMLİK göç (tarım işçilerinin hasat dönemlerinde Çukurova gibi bölgelere, hayvancılıkla uğraşan ailelerin ise yazın yaylalara yaptığı göç). Ayrıca 1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik İŞÇİ GÖÇÜ, dış göçün tarihsel açıdan en bilinen örneğidir; bu göç dalgası gönderen bölgelerde nüfus kaybına yol açmıştır.

## Kentleşme (Şehirleşme) ve Nüfus Dağılışına Etkisi
Cumhuriyetin ilk yıllarında nüfusun büyük bölümü kırsalda yaşarken, sanayileşme ve tarımda makineleşmeyle (traktör kullanımının artması, insan gücüne duyulan ihtiyacın azalması) birlikte kırdan kente göç hızlanmış ve Türkiye günümüzde nüfusunun büyük çoğunluğu il/ilçe merkezlerinde yaşadığı bir ülke konumuna gelmiştir. Tarımda makineleşme, kırsal nüfusun kente yönelmesine neden olan başlıca beşerî "itici" etmenlerden biridir ve nüfus dağılışı sorularında sıkça "kırsal nüfusun azalma nedeni" olarak karşımıza çıkar.

## İtme-Çekme (Push-Pull) Kuramı ve Beyin Göçü
Göçün nedenlerini açıklamakta kullanılan itme-çekme kuramına göre, göç eden bölgede İTİCİ etmenler (işsizlik, düşük gelir, tarımsal verimsizlik, altyapı yetersizliği), göç edilen bölgede ise ÇEKİCİ etmenler (iş imkânı, eğitim, sağlık hizmeti, daha yüksek yaşam standardı) rol oynar. Bu kuramın özel bir örneği BEYİN GÖÇÜ''dür: üniversite mezunu veya uzmanlaşmış bireylerin daha iyi kariyer ve yaşam imkânları için yurt dışına göç etmesini ifade eder; bu, nitelikli iş gücü kaybı anlamına geldiği için gönderen ülke açısından nüfus politikaları bakımından olumsuz bir sonuçtur. Türkiye''de de özellikle mühendislik ve tıp gibi alanlarda yetişmiş genç nüfusun yurt dışına yönelmesi, son yıllarda kamuoyunda sıkça tartışılan bir beyin göçü örneğidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1)
  and tc.content_md not like '%## Göç Türleri ve Nüfus Hareketliliği%';

-- konu: Nüfus ve Yerleşme (Coğrafya / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Göç Türleri ve Nüfus Hareketliliği
Nüfus dağılışını yalnızca "nerede yaşanıyor" değil, "nasıl hareket ediliyor" sorusu da şekillendirir. Türkiye''de iç göç temel olarak birkaç biçimde görülür: KALICI göç (kırsal alandan kente kalıcı yerleşme amacıyla yapılan, sanayileşme ve iş imkânlarının tetiklediği göç) ve MEVSİMLİK göç (tarım işçilerinin hasat dönemlerinde Çukurova gibi bölgelere, hayvancılıkla uğraşan ailelerin ise yazın yaylalara yaptığı göç). Ayrıca 1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik İŞÇİ GÖÇÜ, dış göçün tarihsel açıdan en bilinen örneğidir; bu göç dalgası gönderen bölgelerde nüfus kaybına yol açmıştır.

## Kentleşme (Şehirleşme) ve Nüfus Dağılışına Etkisi
Cumhuriyetin ilk yıllarında nüfusun büyük bölümü kırsalda yaşarken, sanayileşme ve tarımda makineleşmeyle (traktör kullanımının artması, insan gücüne duyulan ihtiyacın azalması) birlikte kırdan kente göç hızlanmış ve Türkiye günümüzde nüfusunun büyük çoğunluğu il/ilçe merkezlerinde yaşadığı bir ülke konumuna gelmiştir. Tarımda makineleşme, kırsal nüfusun kente yönelmesine neden olan başlıca beşerî "itici" etmenlerden biridir ve nüfus dağılışı sorularında sıkça "kırsal nüfusun azalma nedeni" olarak karşımıza çıkar.

## İtme-Çekme (Push-Pull) Kuramı ve Beyin Göçü
Göçün nedenlerini açıklamakta kullanılan itme-çekme kuramına göre, göç eden bölgede İTİCİ etmenler (işsizlik, düşük gelir, tarımsal verimsizlik, altyapı yetersizliği), göç edilen bölgede ise ÇEKİCİ etmenler (iş imkânı, eğitim, sağlık hizmeti, daha yüksek yaşam standardı) rol oynar. Bu kuramın özel bir örneği BEYİN GÖÇÜ''dür: üniversite mezunu veya uzmanlaşmış bireylerin daha iyi kariyer ve yaşam imkânları için yurt dışına göç etmesini ifade eder; bu, nitelikli iş gücü kaybı anlamına geldiği için gönderen ülke açısından nüfus politikaları bakımından olumsuz bir sonuçtur. Türkiye''de de özellikle mühendislik ve tıp gibi alanlarda yetişmiş genç nüfusun yurt dışına yönelmesi, son yıllarda kamuoyunda sıkça tartışılan bir beyin göçü örneğidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1)
  and tc.content_md not like '%## Göç Türleri ve Nüfus Hareketliliği%';

-- konu: Nüfus ve Yerleşme (Coğrafya / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Göç Türleri ve Nüfus Hareketliliği
Nüfus dağılışını yalnızca "nerede yaşanıyor" değil, "nasıl hareket ediliyor" sorusu da şekillendirir. Türkiye''de iç göç temel olarak birkaç biçimde görülür: KALICI göç (kırsal alandan kente kalıcı yerleşme amacıyla yapılan, sanayileşme ve iş imkânlarının tetiklediği göç) ve MEVSİMLİK göç (tarım işçilerinin hasat dönemlerinde Çukurova gibi bölgelere, hayvancılıkla uğraşan ailelerin ise yazın yaylalara yaptığı göç). Ayrıca 1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik İŞÇİ GÖÇÜ, dış göçün tarihsel açıdan en bilinen örneğidir; bu göç dalgası gönderen bölgelerde nüfus kaybına yol açmıştır.

## Kentleşme (Şehirleşme) ve Nüfus Dağılışına Etkisi
Cumhuriyetin ilk yıllarında nüfusun büyük bölümü kırsalda yaşarken, sanayileşme ve tarımda makineleşmeyle (traktör kullanımının artması, insan gücüne duyulan ihtiyacın azalması) birlikte kırdan kente göç hızlanmış ve Türkiye günümüzde nüfusunun büyük çoğunluğu il/ilçe merkezlerinde yaşadığı bir ülke konumuna gelmiştir. Tarımda makineleşme, kırsal nüfusun kente yönelmesine neden olan başlıca beşerî "itici" etmenlerden biridir ve nüfus dağılışı sorularında sıkça "kırsal nüfusun azalma nedeni" olarak karşımıza çıkar.

## İtme-Çekme (Push-Pull) Kuramı ve Beyin Göçü
Göçün nedenlerini açıklamakta kullanılan itme-çekme kuramına göre, göç eden bölgede İTİCİ etmenler (işsizlik, düşük gelir, tarımsal verimsizlik, altyapı yetersizliği), göç edilen bölgede ise ÇEKİCİ etmenler (iş imkânı, eğitim, sağlık hizmeti, daha yüksek yaşam standardı) rol oynar. Bu kuramın özel bir örneği BEYİN GÖÇÜ''dür: üniversite mezunu veya uzmanlaşmış bireylerin daha iyi kariyer ve yaşam imkânları için yurt dışına göç etmesini ifade eder; bu, nitelikli iş gücü kaybı anlamına geldiği için gönderen ülke açısından nüfus politikaları bakımından olumsuz bir sonuçtur. Türkiye''de de özellikle mühendislik ve tıp gibi alanlarda yetişmiş genç nüfusun yurt dışına yönelmesi, son yıllarda kamuoyunda sıkça tartışılan bir beyin göçü örneğidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1)
  and tc.content_md not like '%## Göç Türleri ve Nüfus Hareketliliği%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?', 'Nüfus hareketliliği türlerini (mevsimlik göç) tanıyabilme.', 'Tarım işçilerinin hasat döneminde geçici olarak bir bölgeye gidip iş bittikten sonra geri dönmesi mevsimlik göçe örnektir. Kalıcı göçte kişi yeniden yerleştiği yerde sürekli yaşamaya devam eder; bu, mevsimlik göçten temel farkıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevsimlik göç', true, 0),
  ('Kalıcı göç', false, 3),
  ('Dış göç', false, 4),
  ('Beyin göçü', false, 2),
  ('Zorunlu göç', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?', 'Nüfus hareketliliği türlerini (mevsimlik göç) tanıyabilme.', 'Tarım işçilerinin hasat döneminde geçici olarak bir bölgeye gidip iş bittikten sonra geri dönmesi mevsimlik göçe örnektir. Kalıcı göçte kişi yeniden yerleştiği yerde sürekli yaşamaya devam eder; bu, mevsimlik göçten temel farkıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevsimlik göç', true, 0),
  ('Kalıcı göç', false, 3),
  ('Dış göç', false, 4),
  ('Beyin göçü', false, 2),
  ('Zorunlu göç', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?', 'Nüfus hareketliliği türlerini (mevsimlik göç) tanıyabilme.', 'Tarım işçilerinin hasat döneminde geçici olarak bir bölgeye gidip iş bittikten sonra geri dönmesi mevsimlik göçe örnektir. Kalıcı göçte kişi yeniden yerleştiği yerde sürekli yaşamaya devam eder; bu, mevsimlik göçten temel farkıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Tarım işçilerinin hasat dönemlerinde belirli bölgelere gidip iş bitince geri döndüğü, kalıcı olmayan nüfus hareketi aşağıdakilerden hangisiyle adlandırılır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Mevsimlik göç', true, 0),
  ('Kalıcı göç', false, 3),
  ('Dış göç', false, 4),
  ('Beyin göçü', false, 2),
  ('Zorunlu göç', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?', 'Türkiye''nin tarihsel dış göç hareketlerinin temel nedenini bilme.', '1960''lı yıllarda Türkiye''den Batı Avrupa''ya yönelen göç, öncelikle iş bulma ve daha yüksek gelir elde etme amacıyla gerçekleşen ekonomik bir göçtür; bu dönemde Almanya başta olmak üzere birçok Avrupa ülkesi işgücü ihtiyacını Türkiye''den karşılamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İşgücü/iş bulma amaçlı ekonomik göç', true, 1),
  ('Turizm amaçlı göç', false, 2),
  ('Eğitim amaçlı göç', false, 0),
  ('Siyasi mülteci göçü', false, 3),
  ('İklim değişikliği kaynaklı göç', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?', 'Türkiye''nin tarihsel dış göç hareketlerinin temel nedenini bilme.', '1960''lı yıllarda Türkiye''den Batı Avrupa''ya yönelen göç, öncelikle iş bulma ve daha yüksek gelir elde etme amacıyla gerçekleşen ekonomik bir göçtür; bu dönemde Almanya başta olmak üzere birçok Avrupa ülkesi işgücü ihtiyacını Türkiye''den karşılamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İşgücü/iş bulma amaçlı ekonomik göç', true, 1),
  ('Turizm amaçlı göç', false, 2),
  ('Eğitim amaçlı göç', false, 0),
  ('Siyasi mülteci göçü', false, 3),
  ('İklim değişikliği kaynaklı göç', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?', 'Türkiye''nin tarihsel dış göç hareketlerinin temel nedenini bilme.', '1960''lı yıllarda Türkiye''den Batı Avrupa''ya yönelen göç, öncelikle iş bulma ve daha yüksek gelir elde etme amacıyla gerçekleşen ekonomik bir göçtür; bu dönemde Almanya başta olmak üzere birçok Avrupa ülkesi işgücü ihtiyacını Türkiye''den karşılamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1960''lı yıllardan itibaren Türkiye''den başta Almanya olmak üzere Batı Avrupa ülkelerine yönelik dış göç hareketinin temel nedeni aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('İşgücü/iş bulma amaçlı ekonomik göç', true, 1),
  ('Turizm amaçlı göç', false, 2),
  ('Eğitim amaçlı göç', false, 0),
  ('Siyasi mülteci göçü', false, 3),
  ('İklim değişikliği kaynaklı göç', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?', 'Tarımda makineleşme ile kırdan kente göç arasındaki neden-sonuç ilişkisini kurabilme.', 'Tarımda makineleşme, tarımsal üretim için gereken insan gücü ihtiyacını azaltmış, bu da kırsalda iş bulamayan nüfusun kentlere göç etmesini hızlandırmıştır. Bu, kırdan kente göçü açıklayan başlıca beşerî etmenlerden biridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kırsal alanda tarımsal iş gücüne duyulan ihtiyacın azalmasıyla kentlere göçün hızlanması', true, 0),
  ('Kırsal nüfusun aniden tamamen yok olması', false, 4),
  ('Şehirlerde tarımsal üretimin başlaması', false, 1),
  ('Kırsal doğum oranlarının anında sıfıra düşmesi', false, 3),
  ('Kentlerden kırsala tersine göçün tetiklenmesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?', 'Tarımda makineleşme ile kırdan kente göç arasındaki neden-sonuç ilişkisini kurabilme.', 'Tarımda makineleşme, tarımsal üretim için gereken insan gücü ihtiyacını azaltmış, bu da kırsalda iş bulamayan nüfusun kentlere göç etmesini hızlandırmıştır. Bu, kırdan kente göçü açıklayan başlıca beşerî etmenlerden biridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kırsal alanda tarımsal iş gücüne duyulan ihtiyacın azalmasıyla kentlere göçün hızlanması', true, 0),
  ('Kırsal nüfusun aniden tamamen yok olması', false, 4),
  ('Şehirlerde tarımsal üretimin başlaması', false, 1),
  ('Kırsal doğum oranlarının anında sıfıra düşmesi', false, 3),
  ('Kentlerden kırsala tersine göçün tetiklenmesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?', 'Tarımda makineleşme ile kırdan kente göç arasındaki neden-sonuç ilişkisini kurabilme.', 'Tarımda makineleşme, tarımsal üretim için gereken insan gücü ihtiyacını azaltmış, bu da kırsalda iş bulamayan nüfusun kentlere göç etmesini hızlandırmıştır. Bu, kırdan kente göçü açıklayan başlıca beşerî etmenlerden biridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhuriyet döneminde tarımda makineleşmenin (traktör kullanımının) yaygınlaşması, kırsal nüfus üzerinde öncelikle aşağıdaki sonuçlardan hangisine yol açmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kırsal alanda tarımsal iş gücüne duyulan ihtiyacın azalmasıyla kentlere göçün hızlanması', true, 0),
  ('Kırsal nüfusun aniden tamamen yok olması', false, 4),
  ('Şehirlerde tarımsal üretimin başlaması', false, 1),
  ('Kırsal doğum oranlarının anında sıfıra düşmesi', false, 3),
  ('Kentlerden kırsala tersine göçün tetiklenmesi', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?', 'Aritmetik nüfus yoğunluğunu hesaplayabilme.', 'Aritmetik nüfus yoğunluğu, toplam nüfusun yüz ölçümüne bölünmesiyle bulunur: 1.000.000 / 5.000 = 200 kişi/km². Bu basit oran hesabı KPSS''de doğrudan sayısal sorular olarak karşımıza çıkabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('200', true, 0),
  ('500', false, 2),
  ('100', false, 1),
  ('50', false, 3),
  ('2000', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?', 'Aritmetik nüfus yoğunluğunu hesaplayabilme.', 'Aritmetik nüfus yoğunluğu, toplam nüfusun yüz ölçümüne bölünmesiyle bulunur: 1.000.000 / 5.000 = 200 kişi/km². Bu basit oran hesabı KPSS''de doğrudan sayısal sorular olarak karşımıza çıkabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('200', true, 0),
  ('500', false, 2),
  ('100', false, 1),
  ('50', false, 3),
  ('2000', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?', 'Aritmetik nüfus yoğunluğunu hesaplayabilme.', 'Aritmetik nüfus yoğunluğu, toplam nüfusun yüz ölçümüne bölünmesiyle bulunur: 1.000.000 / 5.000 = 200 kişi/km². Bu basit oran hesabı KPSS''de doğrudan sayısal sorular olarak karşımıza çıkabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yüz ölçümü 5.000 km² olan bir ilin nüfusu 1.000.000 kişi ise bu ilin aritmetik nüfus yoğunluğu kaç kişi/km²''dir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('200', true, 0),
  ('500', false, 2),
  ('100', false, 1),
  ('50', false, 3),
  ('2000', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.', 'Nüfus yoğunluğu, nüfus artış hızı ve göç kavramlarını bir arada değerlendirebilme (ileri düzey).', 'II ve III doğrudur: makineleşme göçü hızlandıran bir etmendir ve aritmetik nüfus yoğunluğu nüfus/alan formülüyle hesaplanır. I ifadesi yanlıştır çünkü nüfus yoğunluğu ile nüfus artış hızı birbirinden bağımsız kavramlardır; yoğun nüfuslu büyük şehirlerde artış hızı düşük olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 1),
  ('Yalnız I', false, 3),
  ('I ve II', false, 2),
  ('Yalnız III', false, 4),
  ('I, II ve III', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.', 'Nüfus yoğunluğu, nüfus artış hızı ve göç kavramlarını bir arada değerlendirebilme (ileri düzey).', 'II ve III doğrudur: makineleşme göçü hızlandıran bir etmendir ve aritmetik nüfus yoğunluğu nüfus/alan formülüyle hesaplanır. I ifadesi yanlıştır çünkü nüfus yoğunluğu ile nüfus artış hızı birbirinden bağımsız kavramlardır; yoğun nüfuslu büyük şehirlerde artış hızı düşük olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 1),
  ('Yalnız I', false, 3),
  ('I ve II', false, 2),
  ('Yalnız III', false, 4),
  ('I, II ve III', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Nüfus ve Yerleşme' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.', 'Nüfus yoğunluğu, nüfus artış hızı ve göç kavramlarını bir arada değerlendirebilme (ileri düzey).', 'II ve III doğrudur: makineleşme göçü hızlandıran bir etmendir ve aritmetik nüfus yoğunluğu nüfus/alan formülüyle hesaplanır. I ifadesi yanlıştır çünkü nüfus yoğunluğu ile nüfus artış hızı birbirinden bağımsız kavramlardır; yoğun nüfuslu büyük şehirlerde artış hızı düşük olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de nüfus dağılışıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Nüfus yoğunluğu fazla olan bir yerde nüfus artış hızı da mutlaka fazladır.
II. Tarımda makineleşme, kırsal nüfusun kentlere göçünü hızlandıran etmenlerden biridir.
III. Aritmetik nüfus yoğunluğu, bir alandaki toplam nüfusun o alanın yüz ölçümüne bölünmesiyle bulunur.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('II ve III', true, 1),
  ('Yalnız I', false, 3),
  ('I ve II', false, 2),
  ('Yalnız III', false, 4),
  ('I, II ve III', false, 0)
) as v(choice_text, is_correct, order_index);

-- konu: Türkiye'nin Yerşekilleri (Coğrafya / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karstik Yer Şekilleri
Türkiye''nin özellikle Akdeniz ve Toroslar çevresindeki kalkerli (kireçtaşlı) arazilerinde, suyun kayacı eritici etkisiyle KARSTİK yer şekilleri oluşur. Küçükten büyüğe: DOLİN (huni biçimli küçük çukurluklar), UVALA (birkaç dolinin birleşmesiyle oluşan daha büyük çukurluk), POLYE (tarıma elverişli karstik ovalar) ve OBRUK (tavanı çökmüş mağara/düden, İç Anadolu''da özellikle Konya-Karapınar çevresinde yaygın) belli başlı karstik şekillerdir. Ayrıca yer altı sularının kayayı eriterek oluşturduğu MAĞARALAR (Antalya''daki Damlataş ve Karain Mağarası gibi) ve sıcak su kaynaklarındaki kirecin çökelmesiyle oluşan TRAVERTENLER (Pamukkale-Denizli en bilinen örnektir) da karstik kökenli oluşumlar arasında sayılır.

## Dağların Oluşum Şekline Göre Sınıflandırılması
Türkiye''deki dağlar oluşum biçimlerine göre üçe ayrılır: KIVRIM DAĞLARI (Alp-Himalaya kıvrım kuşağının bir parçası olan Kuzey Anadolu Dağları ve Toroslar, yatay sıkışma sonucu oluşmuştur), VOLKANİK DAĞLAR (yer altındaki magmanın yüzeye çıkmasıyla oluşan, genellikle tek başına yükselen koni biçimli dağlar: Ağrı Dağı, Erciyes Dağı, Hasan Dağı, Nemrut Dağı) ve KIRIK (FAY) DAĞLARI (yer kabuğundaki kırılma-çökme hareketleriyle oluşan HORST''lar, örn. Bozdağlar ve Uludağ; bunların arasında kalan çöküntü alanlarına ise GRABEN denir, örn. Gediz ve Büyük Menderes grabenleri). Bu üçlü ayrım "hangi dağ nasıl oluşmuştur" tipi sorularda doğrudan kullanılır.

## Karstik Olmayan Bir Aşınım Şekli: Peri Bacaları
Karstik şekillerle sık karıştırılan ama oluşum mekanizması tamamen farklı bir yer şekli PERİ BACALARIDIR. Kapadokya (Nevşehir-Ürgüp-Göreme çevresi), volkanik kökenli olup farklı sertlikte tabakalar hâlinde üst üste birikmiş TÜF ve LAV tabakalarının, yağmur suyu ve rüzgârın FARKLI HIZDA AŞINDIRMASI sonucu bugünkü koni/şapka biçimli peri bacalarını oluşturmuştur. Peri bacaları KARSTİK bir oluşum değildir; kireçtaşının erimesiyle değil, volkanik malzemenin farklı direnç göstererek aşınmasıyla ortaya çıkar — bu ayrım, karstik şekillerle (dolin, obruk, traverten) karıştırılmaması gereken kritik bir noktadır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1)
  and tc.content_md not like '%## Karstik Yer Şekilleri%';

-- konu: Türkiye'nin Yerşekilleri (Coğrafya / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karstik Yer Şekilleri
Türkiye''nin özellikle Akdeniz ve Toroslar çevresindeki kalkerli (kireçtaşlı) arazilerinde, suyun kayacı eritici etkisiyle KARSTİK yer şekilleri oluşur. Küçükten büyüğe: DOLİN (huni biçimli küçük çukurluklar), UVALA (birkaç dolinin birleşmesiyle oluşan daha büyük çukurluk), POLYE (tarıma elverişli karstik ovalar) ve OBRUK (tavanı çökmüş mağara/düden, İç Anadolu''da özellikle Konya-Karapınar çevresinde yaygın) belli başlı karstik şekillerdir. Ayrıca yer altı sularının kayayı eriterek oluşturduğu MAĞARALAR (Antalya''daki Damlataş ve Karain Mağarası gibi) ve sıcak su kaynaklarındaki kirecin çökelmesiyle oluşan TRAVERTENLER (Pamukkale-Denizli en bilinen örnektir) da karstik kökenli oluşumlar arasında sayılır.

## Dağların Oluşum Şekline Göre Sınıflandırılması
Türkiye''deki dağlar oluşum biçimlerine göre üçe ayrılır: KIVRIM DAĞLARI (Alp-Himalaya kıvrım kuşağının bir parçası olan Kuzey Anadolu Dağları ve Toroslar, yatay sıkışma sonucu oluşmuştur), VOLKANİK DAĞLAR (yer altındaki magmanın yüzeye çıkmasıyla oluşan, genellikle tek başına yükselen koni biçimli dağlar: Ağrı Dağı, Erciyes Dağı, Hasan Dağı, Nemrut Dağı) ve KIRIK (FAY) DAĞLARI (yer kabuğundaki kırılma-çökme hareketleriyle oluşan HORST''lar, örn. Bozdağlar ve Uludağ; bunların arasında kalan çöküntü alanlarına ise GRABEN denir, örn. Gediz ve Büyük Menderes grabenleri). Bu üçlü ayrım "hangi dağ nasıl oluşmuştur" tipi sorularda doğrudan kullanılır.

## Karstik Olmayan Bir Aşınım Şekli: Peri Bacaları
Karstik şekillerle sık karıştırılan ama oluşum mekanizması tamamen farklı bir yer şekli PERİ BACALARIDIR. Kapadokya (Nevşehir-Ürgüp-Göreme çevresi), volkanik kökenli olup farklı sertlikte tabakalar hâlinde üst üste birikmiş TÜF ve LAV tabakalarının, yağmur suyu ve rüzgârın FARKLI HIZDA AŞINDIRMASI sonucu bugünkü koni/şapka biçimli peri bacalarını oluşturmuştur. Peri bacaları KARSTİK bir oluşum değildir; kireçtaşının erimesiyle değil, volkanik malzemenin farklı direnç göstererek aşınmasıyla ortaya çıkar — bu ayrım, karstik şekillerle (dolin, obruk, traverten) karıştırılmaması gereken kritik bir noktadır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1)
  and tc.content_md not like '%## Karstik Yer Şekilleri%';

-- konu: Türkiye'nin Yerşekilleri (Coğrafya / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Karstik Yer Şekilleri
Türkiye''nin özellikle Akdeniz ve Toroslar çevresindeki kalkerli (kireçtaşlı) arazilerinde, suyun kayacı eritici etkisiyle KARSTİK yer şekilleri oluşur. Küçükten büyüğe: DOLİN (huni biçimli küçük çukurluklar), UVALA (birkaç dolinin birleşmesiyle oluşan daha büyük çukurluk), POLYE (tarıma elverişli karstik ovalar) ve OBRUK (tavanı çökmüş mağara/düden, İç Anadolu''da özellikle Konya-Karapınar çevresinde yaygın) belli başlı karstik şekillerdir. Ayrıca yer altı sularının kayayı eriterek oluşturduğu MAĞARALAR (Antalya''daki Damlataş ve Karain Mağarası gibi) ve sıcak su kaynaklarındaki kirecin çökelmesiyle oluşan TRAVERTENLER (Pamukkale-Denizli en bilinen örnektir) da karstik kökenli oluşumlar arasında sayılır.

## Dağların Oluşum Şekline Göre Sınıflandırılması
Türkiye''deki dağlar oluşum biçimlerine göre üçe ayrılır: KIVRIM DAĞLARI (Alp-Himalaya kıvrım kuşağının bir parçası olan Kuzey Anadolu Dağları ve Toroslar, yatay sıkışma sonucu oluşmuştur), VOLKANİK DAĞLAR (yer altındaki magmanın yüzeye çıkmasıyla oluşan, genellikle tek başına yükselen koni biçimli dağlar: Ağrı Dağı, Erciyes Dağı, Hasan Dağı, Nemrut Dağı) ve KIRIK (FAY) DAĞLARI (yer kabuğundaki kırılma-çökme hareketleriyle oluşan HORST''lar, örn. Bozdağlar ve Uludağ; bunların arasında kalan çöküntü alanlarına ise GRABEN denir, örn. Gediz ve Büyük Menderes grabenleri). Bu üçlü ayrım "hangi dağ nasıl oluşmuştur" tipi sorularda doğrudan kullanılır.

## Karstik Olmayan Bir Aşınım Şekli: Peri Bacaları
Karstik şekillerle sık karıştırılan ama oluşum mekanizması tamamen farklı bir yer şekli PERİ BACALARIDIR. Kapadokya (Nevşehir-Ürgüp-Göreme çevresi), volkanik kökenli olup farklı sertlikte tabakalar hâlinde üst üste birikmiş TÜF ve LAV tabakalarının, yağmur suyu ve rüzgârın FARKLI HIZDA AŞINDIRMASI sonucu bugünkü koni/şapka biçimli peri bacalarını oluşturmuştur. Peri bacaları KARSTİK bir oluşum değildir; kireçtaşının erimesiyle değil, volkanik malzemenin farklı direnç göstererek aşınmasıyla ortaya çıkar — bu ayrım, karstik şekillerle (dolin, obruk, traverten) karıştırılmaması gereken kritik bir noktadır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1)
  and tc.content_md not like '%## Karstik Yer Şekilleri%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?', 'Dağları oluşum şekline göre (volkanik) sınıflandırabilme.', 'Erciyes Dağı, yer altındaki magmanın yüzeye çıkmasıyla oluşmuş volkanik bir dağdır. Toroslar ve Kuzey Anadolu Dağları kıvrım dağlarına, Bozdağlar ise kırık (horst) dağlara örnektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erciyes Dağı', true, 2),
  ('Toros Dağları', false, 0),
  ('Kaçkar Dağları', false, 1),
  ('Kuzey Anadolu Dağları', false, 3),
  ('Bozdağlar', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?', 'Dağları oluşum şekline göre (volkanik) sınıflandırabilme.', 'Erciyes Dağı, yer altındaki magmanın yüzeye çıkmasıyla oluşmuş volkanik bir dağdır. Toroslar ve Kuzey Anadolu Dağları kıvrım dağlarına, Bozdağlar ise kırık (horst) dağlara örnektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erciyes Dağı', true, 2),
  ('Toros Dağları', false, 0),
  ('Kaçkar Dağları', false, 1),
  ('Kuzey Anadolu Dağları', false, 3),
  ('Bozdağlar', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?', 'Dağları oluşum şekline göre (volkanik) sınıflandırabilme.', 'Erciyes Dağı, yer altındaki magmanın yüzeye çıkmasıyla oluşmuş volkanik bir dağdır. Toroslar ve Kuzey Anadolu Dağları kıvrım dağlarına, Bozdağlar ise kırık (horst) dağlara örnektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki dağlardan hangisi volkanik kökenlidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Erciyes Dağı', true, 2),
  ('Toros Dağları', false, 0),
  ('Kaçkar Dağları', false, 1),
  ('Kuzey Anadolu Dağları', false, 3),
  ('Bozdağlar', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden traverteni tanıyabilme.', 'Traverten, kireçli suların (özellikle sıcak su kaynaklarının) bünyesindeki kalsiyum karbonatın çökelmesiyle oluşan bir karstik şekildir; Pamukkale bu oluşumun Türkiye''deki en bilinen örneğidir. Dolin ve polye ise erime/çökme kökenli farklı karstik şekillerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Traverten', true, 3),
  ('Dolin', false, 2),
  ('Polye', false, 0),
  ('Moren', false, 4),
  ('Peribacası', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden traverteni tanıyabilme.', 'Traverten, kireçli suların (özellikle sıcak su kaynaklarının) bünyesindeki kalsiyum karbonatın çökelmesiyle oluşan bir karstik şekildir; Pamukkale bu oluşumun Türkiye''deki en bilinen örneğidir. Dolin ve polye ise erime/çökme kökenli farklı karstik şekillerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Traverten', true, 3),
  ('Dolin', false, 2),
  ('Polye', false, 0),
  ('Moren', false, 4),
  ('Peribacası', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden traverteni tanıyabilme.', 'Traverten, kireçli suların (özellikle sıcak su kaynaklarının) bünyesindeki kalsiyum karbonatın çökelmesiyle oluşan bir karstik şekildir; Pamukkale bu oluşumun Türkiye''deki en bilinen örneğidir. Dolin ve polye ise erime/çökme kökenli farklı karstik şekillerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sıcak su kaynaklarının bünyesindeki kirecin çökelmesiyle oluşan ve Pamukkale (Denizli) ile özdeşleşen karstik oluşum aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Traverten', true, 3),
  ('Dolin', false, 2),
  ('Polye', false, 0),
  ('Moren', false, 4),
  ('Peribacası', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?', 'Horst-graben yapısını ve bunun ova oluşumuyla ilişkisini açıklayabilme.', 'Yer kabuğundaki kırılma-çökme hareketleriyle aşağı çöken bloklara graben, bunların arasında yüksekte kalan bloklara ise horst denir. Gediz ve Büyük Menderes ovaları birer graben, aralarında kalan Bozdağlar gibi kütleler ise horsttur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Graben – Horst', true, 4),
  ('Polye – Dolin', false, 0),
  ('Obruk – Uvala', false, 3),
  ('Delta – Plato', false, 1),
  ('Peneplen – Moren', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?', 'Horst-graben yapısını ve bunun ova oluşumuyla ilişkisini açıklayabilme.', 'Yer kabuğundaki kırılma-çökme hareketleriyle aşağı çöken bloklara graben, bunların arasında yüksekte kalan bloklara ise horst denir. Gediz ve Büyük Menderes ovaları birer graben, aralarında kalan Bozdağlar gibi kütleler ise horsttur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Graben – Horst', true, 4),
  ('Polye – Dolin', false, 0),
  ('Obruk – Uvala', false, 3),
  ('Delta – Plato', false, 1),
  ('Peneplen – Moren', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?', 'Horst-graben yapısını ve bunun ova oluşumuyla ilişkisini açıklayabilme.', 'Yer kabuğundaki kırılma-çökme hareketleriyle aşağı çöken bloklara graben, bunların arasında yüksekte kalan bloklara ise horst denir. Gediz ve Büyük Menderes ovaları birer graben, aralarında kalan Bozdağlar gibi kütleler ise horsttur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Gediz ve Büyük Menderes ovalarının bulunduğu çöküntü alanlarına verilen isim ile bu ovaların arasında yükselen kütlelerin adı aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Graben – Horst', true, 4),
  ('Polye – Dolin', false, 0),
  ('Obruk – Uvala', false, 3),
  ('Delta – Plato', false, 1),
  ('Peneplen – Moren', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden obruğu ve güncel oluşum nedenini bilme.', 'Obruk, kalkerli arazilerde yer altı boşluklarının tavanının çökmesiyle oluşan derin çukurluklardır; İç Anadolu''da özellikle yer altı suyunun aşırı çekilmesiyle günümüzde sayısı artmaktadır. Traverten ve graben farklı oluşum mekanizmalarına sahip yer şekilleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Obruk', true, 4),
  ('Traverten', false, 2),
  ('Graben', false, 1),
  ('Peribacası', false, 0),
  ('Moren', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden obruğu ve güncel oluşum nedenini bilme.', 'Obruk, kalkerli arazilerde yer altı boşluklarının tavanının çökmesiyle oluşan derin çukurluklardır; İç Anadolu''da özellikle yer altı suyunun aşırı çekilmesiyle günümüzde sayısı artmaktadır. Traverten ve graben farklı oluşum mekanizmalarına sahip yer şekilleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Obruk', true, 4),
  ('Traverten', false, 2),
  ('Graben', false, 1),
  ('Peribacası', false, 0),
  ('Moren', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?', 'Karstik yer şekillerinden obruğu ve güncel oluşum nedenini bilme.', 'Obruk, kalkerli arazilerde yer altı boşluklarının tavanının çökmesiyle oluşan derin çukurluklardır; İç Anadolu''da özellikle yer altı suyunun aşırı çekilmesiyle günümüzde sayısı artmaktadır. Traverten ve graben farklı oluşum mekanizmalarına sahip yer şekilleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'İç Anadolu Bölgesi''nde, özellikle Konya ve Karapınar çevresinde yer altı su seviyesinin aşırı düşmesiyle sayısı artan, tavanı çökmüş mağara ya da düdenlere verilen ad aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Obruk', true, 4),
  ('Traverten', false, 2),
  ('Graben', false, 1),
  ('Peribacası', false, 0),
  ('Moren', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.', 'Dağların oluşum şekillerini (volkanik, kıvrım, kırık) bir arada değerlendirebilme (ileri düzey).', 'Her üç yargı da doğrudur: Ağrı ve Erciyes volkanik dağlara, Toroslar ile Kuzey Anadolu Dağları kıvrım dağlarına örnektir; horstlar arasında kalan çöküntü alanlarına da graben denir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I, II ve III', true, 2),
  ('Yalnız I', false, 0),
  ('I ve II', false, 3),
  ('II ve III', false, 4),
  ('Yalnız III', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.', 'Dağların oluşum şekillerini (volkanik, kıvrım, kırık) bir arada değerlendirebilme (ileri düzey).', 'Her üç yargı da doğrudur: Ağrı ve Erciyes volkanik dağlara, Toroslar ile Kuzey Anadolu Dağları kıvrım dağlarına örnektir; horstlar arasında kalan çöküntü alanlarına da graben denir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I, II ve III', true, 2),
  ('Yalnız I', false, 0),
  ('I ve II', false, 3),
  ('II ve III', false, 4),
  ('Yalnız III', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Türkiye''nin Yerşekilleri' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.', 'Dağların oluşum şekillerini (volkanik, kıvrım, kırık) bir arada değerlendirebilme (ileri düzey).', 'Her üç yargı da doğrudur: Ağrı ve Erciyes volkanik dağlara, Toroslar ile Kuzey Anadolu Dağları kıvrım dağlarına örnektir; horstlar arasında kalan çöküntü alanlarına da graben denir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''deki dağ oluşumlarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Ağrı Dağı ve Erciyes Dağı volkanik kökenli dağlardır.
II. Toroslar ve Kuzey Anadolu Dağları kıvrılma hareketleriyle oluşmuş dağlardır.
III. Horst adı verilen kütleler arasında kalan çöküntü alanlarına graben denir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I, II ve III', true, 2),
  ('Yalnız I', false, 0),
  ('I ve II', false, 3),
  ('II ve III', false, 4),
  ('Yalnız III', false, 1)
) as v(choice_text, is_correct, order_index);

-- konu: Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım) (Coğrafya / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yer Altı Kaynakları (Madencilik)
Türkiye, bazı madenler açısından dünya rezervleri içinde önemli bir paya sahiptir. En dikkat çekici örnek BOR MADENİ''dir: dünya bor rezervlerinin büyük bölümü Türkiye''de bulunur (başlıca Eskişehir-Kırka, Kütahya-Emet, Balıkesir-Bigadiç yatakları). Diğer önemli madenler: KROM (Elazığ-Guleman çevresi; çelik alaşımında kullanılır), DEMİR (Sivas-Divriği, Türkiye''nin en zengin demir yatağı), TAŞKÖMÜRÜ (yalnızca Zonguldak havzasında bulunur) ve LİNYİT (daha düşük kaliteli, termik santrallerde yakıt olarak kullanılan, ülke genelinde daha yaygın dağılmış bir kömür türüdür — Afşin-Elbistan, Soma gibi). Taşkömürü ile linyitin karıştırılması klasik bir ÖSYM tuzağıdır: taşkömürü TEK bir havzada yoğunlaşırken linyit yurdun pek çok yerinde dağınık biçimde bulunur.

## Enerji Kaynakları ve Barajlar
Türkiye akarsularının eğiminin fazla olması ülkeyi hidroelektrik enerji potansiyeli bakımından zengin kılar. Bu potansiyelin en yoğun kullanıldığı alan, GAP kapsamında Fırat ve Dicle nehirleri üzerine kurulan barajlardır (Atatürk Barajı en büyüklerinden biridir); bu barajlar hem enerji üretimi hem de sulama amacıyla kullanılır. Rüzgâr enerjisi potansiyeli en yüksek bölgeler, sürekli ve güçlü esen meltem rüzgârları nedeniyle Ege ve Marmara kıyılarıdır; güneş enerjisi potansiyeli en yüksek bölgeler ise güneşlenme süresinin uzun olduğu Güneydoğu Anadolu ve Akdeniz''dir.

## Petrol Üretimi ve Dışa Bağımlılık
Türkiye''nin sınırlı miktardaki petrol üretimi büyük ölçüde Güneydoğu Anadolu Bölgesi''nde (başta Batman, ayrıca Diyarbakır ve Adıyaman çevresi) gerçekleşir. Ancak bu üretim miktarı, ülkenin toplam petrol tüketim ihtiyacının küçük bir kısmını karşılamaktadır; bu nedenle Türkiye enerji kaynakları bakımından petrol ve doğal gazda büyük ölçüde dışa bağımlı bir ülkedir. Bu durum, ekonomik coğrafya sorularında Türkiye''nin enerji kaynakları içindeki "kendine yeterli olan-olmayan" kaynak ayrımını sorgulayan sorularda karşımıza çıkar (hidroelektrikte kendine yeterliliğe yakınken, petrol-doğal gazda ithalata bağımlıdır).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1)
  and tc.content_md not like '%## Yer Altı Kaynakları (Madencilik)%';

-- konu: Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım) (Coğrafya / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yer Altı Kaynakları (Madencilik)
Türkiye, bazı madenler açısından dünya rezervleri içinde önemli bir paya sahiptir. En dikkat çekici örnek BOR MADENİ''dir: dünya bor rezervlerinin büyük bölümü Türkiye''de bulunur (başlıca Eskişehir-Kırka, Kütahya-Emet, Balıkesir-Bigadiç yatakları). Diğer önemli madenler: KROM (Elazığ-Guleman çevresi; çelik alaşımında kullanılır), DEMİR (Sivas-Divriği, Türkiye''nin en zengin demir yatağı), TAŞKÖMÜRÜ (yalnızca Zonguldak havzasında bulunur) ve LİNYİT (daha düşük kaliteli, termik santrallerde yakıt olarak kullanılan, ülke genelinde daha yaygın dağılmış bir kömür türüdür — Afşin-Elbistan, Soma gibi). Taşkömürü ile linyitin karıştırılması klasik bir ÖSYM tuzağıdır: taşkömürü TEK bir havzada yoğunlaşırken linyit yurdun pek çok yerinde dağınık biçimde bulunur.

## Enerji Kaynakları ve Barajlar
Türkiye akarsularının eğiminin fazla olması ülkeyi hidroelektrik enerji potansiyeli bakımından zengin kılar. Bu potansiyelin en yoğun kullanıldığı alan, GAP kapsamında Fırat ve Dicle nehirleri üzerine kurulan barajlardır (Atatürk Barajı en büyüklerinden biridir); bu barajlar hem enerji üretimi hem de sulama amacıyla kullanılır. Rüzgâr enerjisi potansiyeli en yüksek bölgeler, sürekli ve güçlü esen meltem rüzgârları nedeniyle Ege ve Marmara kıyılarıdır; güneş enerjisi potansiyeli en yüksek bölgeler ise güneşlenme süresinin uzun olduğu Güneydoğu Anadolu ve Akdeniz''dir.

## Petrol Üretimi ve Dışa Bağımlılık
Türkiye''nin sınırlı miktardaki petrol üretimi büyük ölçüde Güneydoğu Anadolu Bölgesi''nde (başta Batman, ayrıca Diyarbakır ve Adıyaman çevresi) gerçekleşir. Ancak bu üretim miktarı, ülkenin toplam petrol tüketim ihtiyacının küçük bir kısmını karşılamaktadır; bu nedenle Türkiye enerji kaynakları bakımından petrol ve doğal gazda büyük ölçüde dışa bağımlı bir ülkedir. Bu durum, ekonomik coğrafya sorularında Türkiye''nin enerji kaynakları içindeki "kendine yeterli olan-olmayan" kaynak ayrımını sorgulayan sorularda karşımıza çıkar (hidroelektrikte kendine yeterliliğe yakınken, petrol-doğal gazda ithalata bağımlıdır).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1)
  and tc.content_md not like '%## Yer Altı Kaynakları (Madencilik)%';

-- konu: Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım) (Coğrafya / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Yer Altı Kaynakları (Madencilik)
Türkiye, bazı madenler açısından dünya rezervleri içinde önemli bir paya sahiptir. En dikkat çekici örnek BOR MADENİ''dir: dünya bor rezervlerinin büyük bölümü Türkiye''de bulunur (başlıca Eskişehir-Kırka, Kütahya-Emet, Balıkesir-Bigadiç yatakları). Diğer önemli madenler: KROM (Elazığ-Guleman çevresi; çelik alaşımında kullanılır), DEMİR (Sivas-Divriği, Türkiye''nin en zengin demir yatağı), TAŞKÖMÜRÜ (yalnızca Zonguldak havzasında bulunur) ve LİNYİT (daha düşük kaliteli, termik santrallerde yakıt olarak kullanılan, ülke genelinde daha yaygın dağılmış bir kömür türüdür — Afşin-Elbistan, Soma gibi). Taşkömürü ile linyitin karıştırılması klasik bir ÖSYM tuzağıdır: taşkömürü TEK bir havzada yoğunlaşırken linyit yurdun pek çok yerinde dağınık biçimde bulunur.

## Enerji Kaynakları ve Barajlar
Türkiye akarsularının eğiminin fazla olması ülkeyi hidroelektrik enerji potansiyeli bakımından zengin kılar. Bu potansiyelin en yoğun kullanıldığı alan, GAP kapsamında Fırat ve Dicle nehirleri üzerine kurulan barajlardır (Atatürk Barajı en büyüklerinden biridir); bu barajlar hem enerji üretimi hem de sulama amacıyla kullanılır. Rüzgâr enerjisi potansiyeli en yüksek bölgeler, sürekli ve güçlü esen meltem rüzgârları nedeniyle Ege ve Marmara kıyılarıdır; güneş enerjisi potansiyeli en yüksek bölgeler ise güneşlenme süresinin uzun olduğu Güneydoğu Anadolu ve Akdeniz''dir.

## Petrol Üretimi ve Dışa Bağımlılık
Türkiye''nin sınırlı miktardaki petrol üretimi büyük ölçüde Güneydoğu Anadolu Bölgesi''nde (başta Batman, ayrıca Diyarbakır ve Adıyaman çevresi) gerçekleşir. Ancak bu üretim miktarı, ülkenin toplam petrol tüketim ihtiyacının küçük bir kısmını karşılamaktadır; bu nedenle Türkiye enerji kaynakları bakımından petrol ve doğal gazda büyük ölçüde dışa bağımlı bir ülkedir. Bu durum, ekonomik coğrafya sorularında Türkiye''nin enerji kaynakları içindeki "kendine yeterli olan-olmayan" kaynak ayrımını sorgulayan sorularda karşımıza çıkar (hidroelektrikte kendine yeterliliğe yakınken, petrol-doğal gazda ithalata bağımlıdır).'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1)
  and tc.content_md not like '%## Yer Altı Kaynakları (Madencilik)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?', 'Türkiye''nin dünya rezervleri içindeki payının yüksek olduğu madeni (bor) bilme.', 'Bor madeni, dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir-Kırka, Kütahya-Emet ve Balıkesir-Bigadiç yataklarından çıkarılan stratejik bir madendir. Krom, bakır ve manganez farklı bölgelerde çıkarılan başka madenlerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bor', true, 2),
  ('Krom', false, 0),
  ('Bakır', false, 4),
  ('Taşkömürü', false, 3),
  ('Manganez', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?', 'Türkiye''nin dünya rezervleri içindeki payının yüksek olduğu madeni (bor) bilme.', 'Bor madeni, dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir-Kırka, Kütahya-Emet ve Balıkesir-Bigadiç yataklarından çıkarılan stratejik bir madendir. Krom, bakır ve manganez farklı bölgelerde çıkarılan başka madenlerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bor', true, 2),
  ('Krom', false, 0),
  ('Bakır', false, 4),
  ('Taşkömürü', false, 3),
  ('Manganez', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?', 'Türkiye''nin dünya rezervleri içindeki payının yüksek olduğu madeni (bor) bilme.', 'Bor madeni, dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir-Kırka, Kütahya-Emet ve Balıkesir-Bigadiç yataklarından çıkarılan stratejik bir madendir. Krom, bakır ve manganez farklı bölgelerde çıkarılan başka madenlerdir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Dünya rezervlerinin büyük bölümünün Türkiye''de bulunduğu, başlıca Eskişehir, Kütahya ve Balıkesir çevresinde çıkarılan maden aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bor', true, 2),
  ('Krom', false, 0),
  ('Bakır', false, 4),
  ('Taşkömürü', false, 3),
  ('Manganez', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?', 'Taşkömürünün Türkiye''deki tek üretim havzasını (Zonguldak) bilme.', 'Türkiye''de taşkömürü yalnızca Zonguldak havzasında bulunur ve çıkarılır; bu, taşkömürünü ülke genelinde dağınık olarak bulunan linyitten ayıran temel özelliktir. Afşin-Elbistan ve Soma linyit üretim merkezleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Zonguldak', true, 0),
  ('Muğla', false, 1),
  ('Kahramanmaraş (Afşin-Elbistan)', false, 2),
  ('Manisa (Soma)', false, 3),
  ('Sivas', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?', 'Taşkömürünün Türkiye''deki tek üretim havzasını (Zonguldak) bilme.', 'Türkiye''de taşkömürü yalnızca Zonguldak havzasında bulunur ve çıkarılır; bu, taşkömürünü ülke genelinde dağınık olarak bulunan linyitten ayıran temel özelliktir. Afşin-Elbistan ve Soma linyit üretim merkezleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Zonguldak', true, 0),
  ('Muğla', false, 1),
  ('Kahramanmaraş (Afşin-Elbistan)', false, 2),
  ('Manisa (Soma)', false, 3),
  ('Sivas', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?', 'Taşkömürünün Türkiye''deki tek üretim havzasını (Zonguldak) bilme.', 'Türkiye''de taşkömürü yalnızca Zonguldak havzasında bulunur ve çıkarılır; bu, taşkömürünü ülke genelinde dağınık olarak bulunan linyitten ayıran temel özelliktir. Afşin-Elbistan ve Soma linyit üretim merkezleridir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de taşkömürü yalnızca aşağıdaki illerin hangisinde çıkarılmaktadır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Zonguldak', true, 0),
  ('Muğla', false, 1),
  ('Kahramanmaraş (Afşin-Elbistan)', false, 2),
  ('Manisa (Soma)', false, 3),
  ('Sivas', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?', 'Linyit ve taşkömürünün dağılış ve kalite farkını ayırt edebilme.', 'Taşkömürü Türkiye''de yalnızca Zonguldak havzasında yoğunlaşırken linyit yurdun birçok yerinde (Afşin-Elbistan, Soma gibi) dağınık biçimde bulunur; ayrıca taşkömürü linyite göre daha yüksek kalorilidir, bu nedenle linyitin taşkömüründen kaliteli olduğu iddiası yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Taşkömürü yalnızca Zonguldak''ta yoğunlaşırken linyit yurdun birçok yerinde dağınık olarak bulunur', true, 3),
  ('Linyit taşkömüründen daha yüksek kalorilidir', false, 1),
  ('Taşkömürü termik santrallerde hiç kullanılmaz', false, 2),
  ('Linyit sadece Karadeniz Bölgesi''nde bulunur', false, 4),
  ('Taşkömürü ve linyit aynı madendir, sadece isimleri farklıdır', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?', 'Linyit ve taşkömürünün dağılış ve kalite farkını ayırt edebilme.', 'Taşkömürü Türkiye''de yalnızca Zonguldak havzasında yoğunlaşırken linyit yurdun birçok yerinde (Afşin-Elbistan, Soma gibi) dağınık biçimde bulunur; ayrıca taşkömürü linyite göre daha yüksek kalorilidir, bu nedenle linyitin taşkömüründen kaliteli olduğu iddiası yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Taşkömürü yalnızca Zonguldak''ta yoğunlaşırken linyit yurdun birçok yerinde dağınık olarak bulunur', true, 3),
  ('Linyit taşkömüründen daha yüksek kalorilidir', false, 1),
  ('Taşkömürü termik santrallerde hiç kullanılmaz', false, 2),
  ('Linyit sadece Karadeniz Bölgesi''nde bulunur', false, 4),
  ('Taşkömürü ve linyit aynı madendir, sadece isimleri farklıdır', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?', 'Linyit ve taşkömürünün dağılış ve kalite farkını ayırt edebilme.', 'Taşkömürü Türkiye''de yalnızca Zonguldak havzasında yoğunlaşırken linyit yurdun birçok yerinde (Afşin-Elbistan, Soma gibi) dağınık biçimde bulunur; ayrıca taşkömürü linyite göre daha yüksek kalorilidir, bu nedenle linyitin taşkömüründen kaliteli olduğu iddiası yanlıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Linyit ile taşkömürü arasındaki farkla ilgili aşağıdaki ifadelerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Taşkömürü yalnızca Zonguldak''ta yoğunlaşırken linyit yurdun birçok yerinde dağınık olarak bulunur', true, 3),
  ('Linyit taşkömüründen daha yüksek kalorilidir', false, 1),
  ('Taşkömürü termik santrallerde hiç kullanılmaz', false, 2),
  ('Linyit sadece Karadeniz Bölgesi''nde bulunur', false, 4),
  ('Taşkömürü ve linyit aynı madendir, sadece isimleri farklıdır', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?', 'GAP''ın enerji ve sulama amaçlarını, bölgeyle ilgisiz amaçlardan ayırt edebilme.', 'Güneydoğu Anadolu Bölgesi denize kıyısı olmayan bir bölgedir; bu nedenle kıyı balıkçılığını geliştirmek GAP''ın amaçları arasında yer almaz. GAP''ın temel amaçları arasında hidroelektrik enerji üretimi, sulu tarımın yaygınlaştırılması ve bölgesel kalkınma bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bölgede kıyı balıkçılığını geliştirmek', true, 1),
  ('Sulu tarım alanlarını genişletmek', false, 4),
  ('Hidroelektrik enerji üretmek', false, 2),
  ('Bölgesel kalkınmayı desteklemek', false, 0),
  ('Kuraklığın tarım üzerindeki olumsuz etkisini azaltmak', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?', 'GAP''ın enerji ve sulama amaçlarını, bölgeyle ilgisiz amaçlardan ayırt edebilme.', 'Güneydoğu Anadolu Bölgesi denize kıyısı olmayan bir bölgedir; bu nedenle kıyı balıkçılığını geliştirmek GAP''ın amaçları arasında yer almaz. GAP''ın temel amaçları arasında hidroelektrik enerji üretimi, sulu tarımın yaygınlaştırılması ve bölgesel kalkınma bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bölgede kıyı balıkçılığını geliştirmek', true, 1),
  ('Sulu tarım alanlarını genişletmek', false, 4),
  ('Hidroelektrik enerji üretmek', false, 2),
  ('Bölgesel kalkınmayı desteklemek', false, 0),
  ('Kuraklığın tarım üzerindeki olumsuz etkisini azaltmak', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?', 'GAP''ın enerji ve sulama amaçlarını, bölgeyle ilgisiz amaçlardan ayırt edebilme.', 'Güneydoğu Anadolu Bölgesi denize kıyısı olmayan bir bölgedir; bu nedenle kıyı balıkçılığını geliştirmek GAP''ın amaçları arasında yer almaz. GAP''ın temel amaçları arasında hidroelektrik enerji üretimi, sulu tarımın yaygınlaştırılması ve bölgesel kalkınma bulunur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'GAP (Güneydoğu Anadolu Projesi) kapsamında Fırat ve Dicle nehirleri üzerine barajlar inşa edilmesinin temel amaçları arasında aşağıdakilerden hangisi YOKTUR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Bölgede kıyı balıkçılığını geliştirmek', true, 1),
  ('Sulu tarım alanlarını genişletmek', false, 4),
  ('Hidroelektrik enerji üretmek', false, 2),
  ('Bölgesel kalkınmayı desteklemek', false, 0),
  ('Kuraklığın tarım üzerindeki olumsuz etkisini azaltmak', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.', 'Türkiye''nin maden ve enerji kaynaklarının bölgesel dağılışını bir arada değerlendirebilme (ileri düzey).', 'I ve II doğrudur: Türkiye dünya bor rezervlerinin büyük bölümüne sahiptir ve rüzgâr enerjisi potansiyeli Ege-Marmara kıyılarında yüksektir. III yanlıştır çünkü Doğu Karadeniz, bulutluluk oranının yüksek ve güneşlenme süresinin kısa olması nedeniyle güneş enerjisi potansiyeli en DÜŞÜK bölgeler arasındadır; güneş potansiyeli GAP ve Akdeniz''de en yüksektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I ve II', true, 1),
  ('Yalnız I', false, 0),
  ('II ve III', false, 4),
  ('I, II ve III', false, 2),
  ('Yalnız III', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.', 'Türkiye''nin maden ve enerji kaynaklarının bölgesel dağılışını bir arada değerlendirebilme (ileri düzey).', 'I ve II doğrudur: Türkiye dünya bor rezervlerinin büyük bölümüne sahiptir ve rüzgâr enerjisi potansiyeli Ege-Marmara kıyılarında yüksektir. III yanlıştır çünkü Doğu Karadeniz, bulutluluk oranının yüksek ve güneşlenme süresinin kısa olması nedeniyle güneş enerjisi potansiyeli en DÜŞÜK bölgeler arasındadır; güneş potansiyeli GAP ve Akdeniz''de en yüksektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I ve II', true, 1),
  ('Yalnız I', false, 0),
  ('II ve III', false, 4),
  ('I, II ve III', false, 2),
  ('Yalnız III', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Coğrafya' and t.name = 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.', 'Türkiye''nin maden ve enerji kaynaklarının bölgesel dağılışını bir arada değerlendirebilme (ileri düzey).', 'I ve II doğrudur: Türkiye dünya bor rezervlerinin büyük bölümüne sahiptir ve rüzgâr enerjisi potansiyeli Ege-Marmara kıyılarında yüksektir. III yanlıştır çünkü Doğu Karadeniz, bulutluluk oranının yüksek ve güneşlenme süresinin kısa olması nedeniyle güneş enerjisi potansiyeli en DÜŞÜK bölgeler arasındadır; güneş potansiyeli GAP ve Akdeniz''de en yüksektir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''nin yer altı ve enerji kaynaklarıyla ilgili aşağıdaki yargılardan hangileri doğrudur?
I. Türkiye, dünya bor rezervlerinin büyük bölümüne sahiptir.
II. Rüzgâr enerjisi potansiyeli en yüksek bölgeler arasında Ege ve Marmara kıyıları sayılabilir.
III. Güneş enerjisi potansiyeli, güneşlenme süresinin kısa olduğu Doğu Karadeniz''de en yüksektir.'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('I ve II', true, 1),
  ('Yalnız I', false, 0),
  ('II ve III', false, 4),
  ('I, II ve III', false, 2),
  ('Yalnız III', false, 3)
) as v(choice_text, is_correct, order_index);

-- ============ Vatandaşlık ============
-- konu: Temel Hukuk Kavramları (Vatandaşlık / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi
Kanunlar Resmî Gazete''de yayımlanır; metninde ayrı bir yürürlük tarihi gösterilmemişse, yayımını izleyen 45. günde kendiliğinden yürürlüğe girer (1322 sayılı Kanun m.3). Hukukun temel ilkelerinden biri olan "kanunların geriye yürümezliği" ilkesine göre bir kanun, yürürlüğe girmeden önceki olay ve ilişkilere uygulanmaz. Bu ilkenin en bilinen istisnası CEZA HUKUKUNDADIR: Türk Ceza Kanunu m.7 uyarınca, işlendiği zamanki kanuna göre suç sayılmayan bir fiilden dolayı kimseye ceza verilemez; sonradan yürürlüğe giren kanun failin LEHİNE hükümler içeriyorsa (cezayı kaldırıyor veya azaltıyorsa) geçmişe de uygulanır ("lehe kanunun geçmişe uygulanması" ilkesi).

## Hukuk Kurallarının Türlerine Göre Sınıflandırılması
Hukuk kuralları, kişilere tanıdığı serbestiye göre EMREDİCİ (buyurucu) ve TAMAMLAYICI-YORUMLAYICI (yedek) kurallar olarak ikiye ayrılır. Emredici kurallar, tarafların aksini kararlaştıramayacağı, kamu düzeniyle ilgili kurallardır (örn. evlenme yaşı, velayet hükümleri); ihlali kuralı geçersiz kılar. Tamamlayıcı kurallar ise taraflar sözleşmede aksini kararlaştırmadığı sürece uygulanan, kişilerin iradesine öncelik tanıyan kurallardır (örn. Borçlar Kanunu''ndaki birçok hüküm). ÖSYM bu ayrımı genellikle "taraflar aksini kararlaştırabilir mi?" sorusu üzerinden test eder: Cevap evet ise kural tamamlayıcı, hayır ise emredicidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1)
  and tc.content_md not like '%## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi%';

-- konu: Temel Hukuk Kavramları (Vatandaşlık / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi
Kanunlar Resmî Gazete''de yayımlanır; metninde ayrı bir yürürlük tarihi gösterilmemişse, yayımını izleyen 45. günde kendiliğinden yürürlüğe girer (1322 sayılı Kanun m.3). Hukukun temel ilkelerinden biri olan "kanunların geriye yürümezliği" ilkesine göre bir kanun, yürürlüğe girmeden önceki olay ve ilişkilere uygulanmaz. Bu ilkenin en bilinen istisnası CEZA HUKUKUNDADIR: Türk Ceza Kanunu m.7 uyarınca, işlendiği zamanki kanuna göre suç sayılmayan bir fiilden dolayı kimseye ceza verilemez; sonradan yürürlüğe giren kanun failin LEHİNE hükümler içeriyorsa (cezayı kaldırıyor veya azaltıyorsa) geçmişe de uygulanır ("lehe kanunun geçmişe uygulanması" ilkesi).

## Hukuk Kurallarının Türlerine Göre Sınıflandırılması
Hukuk kuralları, kişilere tanıdığı serbestiye göre EMREDİCİ (buyurucu) ve TAMAMLAYICI-YORUMLAYICI (yedek) kurallar olarak ikiye ayrılır. Emredici kurallar, tarafların aksini kararlaştıramayacağı, kamu düzeniyle ilgili kurallardır (örn. evlenme yaşı, velayet hükümleri); ihlali kuralı geçersiz kılar. Tamamlayıcı kurallar ise taraflar sözleşmede aksini kararlaştırmadığı sürece uygulanan, kişilerin iradesine öncelik tanıyan kurallardır (örn. Borçlar Kanunu''ndaki birçok hüküm). ÖSYM bu ayrımı genellikle "taraflar aksini kararlaştırabilir mi?" sorusu üzerinden test eder: Cevap evet ise kural tamamlayıcı, hayır ise emredicidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1)
  and tc.content_md not like '%## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi%';

-- konu: Temel Hukuk Kavramları (Vatandaşlık / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi
Kanunlar Resmî Gazete''de yayımlanır; metninde ayrı bir yürürlük tarihi gösterilmemişse, yayımını izleyen 45. günde kendiliğinden yürürlüğe girer (1322 sayılı Kanun m.3). Hukukun temel ilkelerinden biri olan "kanunların geriye yürümezliği" ilkesine göre bir kanun, yürürlüğe girmeden önceki olay ve ilişkilere uygulanmaz. Bu ilkenin en bilinen istisnası CEZA HUKUKUNDADIR: Türk Ceza Kanunu m.7 uyarınca, işlendiği zamanki kanuna göre suç sayılmayan bir fiilden dolayı kimseye ceza verilemez; sonradan yürürlüğe giren kanun failin LEHİNE hükümler içeriyorsa (cezayı kaldırıyor veya azaltıyorsa) geçmişe de uygulanır ("lehe kanunun geçmişe uygulanması" ilkesi).

## Hukuk Kurallarının Türlerine Göre Sınıflandırılması
Hukuk kuralları, kişilere tanıdığı serbestiye göre EMREDİCİ (buyurucu) ve TAMAMLAYICI-YORUMLAYICI (yedek) kurallar olarak ikiye ayrılır. Emredici kurallar, tarafların aksini kararlaştıramayacağı, kamu düzeniyle ilgili kurallardır (örn. evlenme yaşı, velayet hükümleri); ihlali kuralı geçersiz kılar. Tamamlayıcı kurallar ise taraflar sözleşmede aksini kararlaştırmadığı sürece uygulanan, kişilerin iradesine öncelik tanıyan kurallardır (örn. Borçlar Kanunu''ndaki birçok hüküm). ÖSYM bu ayrımı genellikle "taraflar aksini kararlaştırabilir mi?" sorusu üzerinden test eder: Cevap evet ise kural tamamlayıcı, hayır ise emredicidir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1)
  and tc.content_md not like '%## Kanunların Yürürlüğe Girmesi ve Geriye Yürümezlik İlkesi%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?', 'Kamu hukuku ile özel hukuk dallarını ayırt eder.', 'Medeni hukuk, kişiler arasındaki eşit taraflar ilişkisini düzenlediği için özel hukuk dalıdır. Ceza, idare, vergi ve anayasa hukuku ise devletin taraf olduğu ve üstünlük-eşitsizlik ilişkisinin bulunduğu kamu hukuku dallarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Medeni Hukuk', true, 2),
  ('Ceza Hukuku', false, 3),
  ('İdare Hukuku', false, 0),
  ('Vergi Hukuku', false, 1),
  ('Anayasa Hukuku', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?', 'Kamu hukuku ile özel hukuk dallarını ayırt eder.', 'Medeni hukuk, kişiler arasındaki eşit taraflar ilişkisini düzenlediği için özel hukuk dalıdır. Ceza, idare, vergi ve anayasa hukuku ise devletin taraf olduğu ve üstünlük-eşitsizlik ilişkisinin bulunduğu kamu hukuku dallarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Medeni Hukuk', true, 2),
  ('Ceza Hukuku', false, 3),
  ('İdare Hukuku', false, 0),
  ('Vergi Hukuku', false, 1),
  ('Anayasa Hukuku', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?', 'Kamu hukuku ile özel hukuk dallarını ayırt eder.', 'Medeni hukuk, kişiler arasındaki eşit taraflar ilişkisini düzenlediği için özel hukuk dalıdır. Ceza, idare, vergi ve anayasa hukuku ise devletin taraf olduğu ve üstünlük-eşitsizlik ilişkisinin bulunduğu kamu hukuku dallarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye''de hukuk dalları kamu hukuku ve özel hukuk olarak ikiye ayrılır. Aşağıdakilerden hangisi ÖZEL HUKUK dallarından biridir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Medeni Hukuk', true, 2),
  ('Ceza Hukuku', false, 3),
  ('İdare Hukuku', false, 0),
  ('Vergi Hukuku', false, 1),
  ('Anayasa Hukuku', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?', 'Normlar hiyerarşisinde kanun ile Cumhurbaşkanlığı kararnamesinin konumunu bilir.', 'Normlar hiyerarşisinde kanun, Cumhurbaşkanlığı kararnamesinden üstündür; bu nedenle çelişki halinde kanun hükmü uygulanır. Cumhurbaşkanlığı kararnameleri zaten kanunla düzenlenmiş bir konuda hüküm koyamaz ve kanunla çatıştığında kararname hükümsüz kalır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kanun hükmü uygulanır, çünkü kanun normlar hiyerarşisinde kararnameden üstündür', true, 1),
  ('Cumhurbaşkanlığı kararnamesi uygulanır çünkü daha güncel bir düzenlemedir', false, 3),
  ('İkisi de uygulanmaz, konu boşlukta kalır', false, 0),
  ('Hangisinin uygulanacağına Danıştay karar verir', false, 2),
  ('Cumhurbaşkanlığı kararnamesi kanunla eşdeğerdir, biri diğerini geçersiz kılamaz', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?', 'Normlar hiyerarşisinde kanun ile Cumhurbaşkanlığı kararnamesinin konumunu bilir.', 'Normlar hiyerarşisinde kanun, Cumhurbaşkanlığı kararnamesinden üstündür; bu nedenle çelişki halinde kanun hükmü uygulanır. Cumhurbaşkanlığı kararnameleri zaten kanunla düzenlenmiş bir konuda hüküm koyamaz ve kanunla çatıştığında kararname hükümsüz kalır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kanun hükmü uygulanır, çünkü kanun normlar hiyerarşisinde kararnameden üstündür', true, 1),
  ('Cumhurbaşkanlığı kararnamesi uygulanır çünkü daha güncel bir düzenlemedir', false, 3),
  ('İkisi de uygulanmaz, konu boşlukta kalır', false, 0),
  ('Hangisinin uygulanacağına Danıştay karar verir', false, 2),
  ('Cumhurbaşkanlığı kararnamesi kanunla eşdeğerdir, biri diğerini geçersiz kılamaz', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?', 'Normlar hiyerarşisinde kanun ile Cumhurbaşkanlığı kararnamesinin konumunu bilir.', 'Normlar hiyerarşisinde kanun, Cumhurbaşkanlığı kararnamesinden üstündür; bu nedenle çelişki halinde kanun hükmü uygulanır. Cumhurbaşkanlığı kararnameleri zaten kanunla düzenlenmiş bir konuda hüküm koyamaz ve kanunla çatıştığında kararname hükümsüz kalır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk hukukunda normlar hiyerarşisine göre bir kanun hükmü ile bir Cumhurbaşkanlığı kararnamesi hükmü çelişirse ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Kanun hükmü uygulanır, çünkü kanun normlar hiyerarşisinde kararnameden üstündür', true, 1),
  ('Cumhurbaşkanlığı kararnamesi uygulanır çünkü daha güncel bir düzenlemedir', false, 3),
  ('İkisi de uygulanmaz, konu boşlukta kalır', false, 0),
  ('Hangisinin uygulanacağına Danıştay karar verir', false, 2),
  ('Cumhurbaşkanlığı kararnamesi kanunla eşdeğerdir, biri diğerini geçersiz kılamaz', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?', 'Kanunların geriye yürümezliği ilkesinin ceza hukukundaki istisnasını (lehe kanun) açıklar.', 'Ceza hukukunda geçerli olan "lehe kanunun geçmişe uygulanması" ilkesi gereği, sonradan yürürlüğe giren ve failin lehine olan hüküm geçmiş fiillere de uygulanır. Bu durumda kişi cezalandırılamaz veya ceza sonradan getirilen lehe hükme göre uygulanır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sonradan yürürlüğe giren lehe hüküm geçmişe de uygulanır, kişi cezalandırılamaz', true, 0),
  ('Kanunların geriye yürümezliği ilkesi gereği eski kanun uygulanmaya devam eder', false, 3),
  ('Kişi işlendiği tarihteki kanuna göre yargılanır, yeni kanun hiç dikkate alınmaz', false, 2),
  ('Bu durumda ayrıca Anayasa Mahkemesi''nin karar vermesi gerekir', false, 1),
  ('Yeni kanun yalnızca ileride işlenecek fiiller için geçerlidir, geçmişe hiç etkisi yoktur', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?', 'Kanunların geriye yürümezliği ilkesinin ceza hukukundaki istisnasını (lehe kanun) açıklar.', 'Ceza hukukunda geçerli olan "lehe kanunun geçmişe uygulanması" ilkesi gereği, sonradan yürürlüğe giren ve failin lehine olan hüküm geçmiş fiillere de uygulanır. Bu durumda kişi cezalandırılamaz veya ceza sonradan getirilen lehe hükme göre uygulanır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sonradan yürürlüğe giren lehe hüküm geçmişe de uygulanır, kişi cezalandırılamaz', true, 0),
  ('Kanunların geriye yürümezliği ilkesi gereği eski kanun uygulanmaya devam eder', false, 3),
  ('Kişi işlendiği tarihteki kanuna göre yargılanır, yeni kanun hiç dikkate alınmaz', false, 2),
  ('Bu durumda ayrıca Anayasa Mahkemesi''nin karar vermesi gerekir', false, 1),
  ('Yeni kanun yalnızca ileride işlenecek fiiller için geçerlidir, geçmişe hiç etkisi yoktur', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?', 'Kanunların geriye yürümezliği ilkesinin ceza hukukundaki istisnasını (lehe kanun) açıklar.', 'Ceza hukukunda geçerli olan "lehe kanunun geçmişe uygulanması" ilkesi gereği, sonradan yürürlüğe giren ve failin lehine olan hüküm geçmiş fiillere de uygulanır. Bu durumda kişi cezalandırılamaz veya ceza sonradan getirilen lehe hükme göre uygulanır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türk Ceza Kanunu''na göre bir fiil işlendiği tarihte suç sayılmazken, sonradan yürürlüğe giren bir kanun bu fiili suç olmaktan çıkarmışsa ne olur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sonradan yürürlüğe giren lehe hüküm geçmişe de uygulanır, kişi cezalandırılamaz', true, 0),
  ('Kanunların geriye yürümezliği ilkesi gereği eski kanun uygulanmaya devam eder', false, 3),
  ('Kişi işlendiği tarihteki kanuna göre yargılanır, yeni kanun hiç dikkate alınmaz', false, 2),
  ('Bu durumda ayrıca Anayasa Mahkemesi''nin karar vermesi gerekir', false, 1),
  ('Yeni kanun yalnızca ileride işlenecek fiiller için geçerlidir, geçmişe hiç etkisi yoktur', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?', 'Emredici kurallar ile tamamlayıcı (yedek) kurallar arasındaki farkı bilir.', 'Tamamlayıcı (yedek) hukuk kuralları, tarafların iradesine öncelik tanır ve ancak taraflar sözleşmede aksini kararlaştırmamışsa uygulanır. Emredici kurallar ise kamu düzeniyle ilgili olup tarafların aksini kararlaştırması mümkün değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamamlayıcı (yedek) hukuk kuralları', true, 0),
  ('Emredici hukuk kuralları', false, 4),
  ('Örf ve adet kuralları', false, 3),
  ('Kamu düzeni kuralları', false, 2),
  ('Şekli hukuk kuralları', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?', 'Emredici kurallar ile tamamlayıcı (yedek) kurallar arasındaki farkı bilir.', 'Tamamlayıcı (yedek) hukuk kuralları, tarafların iradesine öncelik tanır ve ancak taraflar sözleşmede aksini kararlaştırmamışsa uygulanır. Emredici kurallar ise kamu düzeniyle ilgili olup tarafların aksini kararlaştırması mümkün değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamamlayıcı (yedek) hukuk kuralları', true, 0),
  ('Emredici hukuk kuralları', false, 4),
  ('Örf ve adet kuralları', false, 3),
  ('Kamu düzeni kuralları', false, 2),
  ('Şekli hukuk kuralları', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?', 'Emredici kurallar ile tamamlayıcı (yedek) kurallar arasındaki farkı bilir.', 'Tamamlayıcı (yedek) hukuk kuralları, tarafların iradesine öncelik tanır ve ancak taraflar sözleşmede aksini kararlaştırmamışsa uygulanır. Emredici kurallar ise kamu düzeniyle ilgili olup tarafların aksini kararlaştırması mümkün değildir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Sözleşme taraflarının aksini kararlaştırabildiği, kanunda taraflarca farklı bir düzenleme yapılmadığı sürece uygulanan hukuk kurallarına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Tamamlayıcı (yedek) hukuk kuralları', true, 0),
  ('Emredici hukuk kuralları', false, 4),
  ('Örf ve adet kuralları', false, 3),
  ('Kamu düzeni kuralları', false, 2),
  ('Şekli hukuk kuralları', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?', 'Kanunların yürürlüğe girme usulünü (45 gün kuralı) bilir.', '1322 sayılı Kanun uyarınca, metninde ayrı bir yürürlük tarihi belirtilmeyen kanunlar, Resmî Gazete''de yayımlandıkları tarihi izleyen 45. günde kendiliğinden yürürlüğe girer. Bu süre, kanunun toplum tarafından öğrenilmesi için tanınan bir uyum süresidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45 gün', true, 0),
  ('15 gün', false, 3),
  ('30 gün', false, 1),
  ('60 gün', false, 4),
  ('90 gün', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?', 'Kanunların yürürlüğe girme usulünü (45 gün kuralı) bilir.', '1322 sayılı Kanun uyarınca, metninde ayrı bir yürürlük tarihi belirtilmeyen kanunlar, Resmî Gazete''de yayımlandıkları tarihi izleyen 45. günde kendiliğinden yürürlüğe girer. Bu süre, kanunun toplum tarafından öğrenilmesi için tanınan bir uyum süresidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45 gün', true, 0),
  ('15 gün', false, 3),
  ('30 gün', false, 1),
  ('60 gün', false, 4),
  ('90 gün', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hukuk Kavramları' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?', 'Kanunların yürürlüğe girme usulünü (45 gün kuralı) bilir.', '1322 sayılı Kanun uyarınca, metninde ayrı bir yürürlük tarihi belirtilmeyen kanunlar, Resmî Gazete''de yayımlandıkları tarihi izleyen 45. günde kendiliğinden yürürlüğe girer. Bu süre, kanunun toplum tarafından öğrenilmesi için tanınan bir uyum süresidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Bir kanunda yürürlük tarihi ayrıca gösterilmemişse, bu kanun Resmî Gazete''de yayımlandıktan kaç gün sonra kendiliğinden yürürlüğe girer?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('45 gün', true, 0),
  ('15 gün', false, 3),
  ('30 gün', false, 1),
  ('60 gün', false, 4),
  ('90 gün', false, 2)
) as v(choice_text, is_correct, order_index);

-- konu: Anayasa (Vatandaşlık / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)
2010 yılında yapılan Anayasa değişikliğiyle (madde 148) getirilen bireysel başvuru yolu, herkese, Anayasada güvence altına alınmış temel hak ve özgürlüklerinden Avrupa İnsan Hakları Sözleşmesi kapsamındaki herhangi birinin kamu gücü tarafından İHLAL EDİLDİĞİ iddiasıyla Anayasa Mahkemesi''ne başvurma imkânı tanır. Bireysel başvuru yapılabilmesi için OLAĞAN KANUN YOLLARININ (diğer yargı mercilerinin) tüketilmiş olması şarttır; yani Anayasa Mahkemesi bu konuda ilk başvuru mercii değil, ikincil (tali) bir denetim mercidir. Yasama işlemleri (kanunlar) ile düzenleyici idari işlemler aleyhine doğrudan bireysel başvuru yapılamaz.

## Cumhurbaşkanının Cezai Sorumluluğu
Cumhurbaşkanının görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması, TBMM üye tam sayısının SALT ÇOĞUNLUĞUNUN (301 milletvekili) vereceği önergeyle istenebilir; soruşturma açılmasına üye tam sayısının 3/5 çoğunluğuyla (360 oy) karar verilir. Soruşturma sonunda üye tam sayısının 2/3 çoğunluğuyla (400 oy) Cumhurbaşkanının Yüce Divana sevkine karar verilebilir; Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir. Yüce Divana sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1)
  and tc.content_md not like '%## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)%';

-- konu: Anayasa (Vatandaşlık / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)
2010 yılında yapılan Anayasa değişikliğiyle (madde 148) getirilen bireysel başvuru yolu, herkese, Anayasada güvence altına alınmış temel hak ve özgürlüklerinden Avrupa İnsan Hakları Sözleşmesi kapsamındaki herhangi birinin kamu gücü tarafından İHLAL EDİLDİĞİ iddiasıyla Anayasa Mahkemesi''ne başvurma imkânı tanır. Bireysel başvuru yapılabilmesi için OLAĞAN KANUN YOLLARININ (diğer yargı mercilerinin) tüketilmiş olması şarttır; yani Anayasa Mahkemesi bu konuda ilk başvuru mercii değil, ikincil (tali) bir denetim mercidir. Yasama işlemleri (kanunlar) ile düzenleyici idari işlemler aleyhine doğrudan bireysel başvuru yapılamaz.

## Cumhurbaşkanının Cezai Sorumluluğu
Cumhurbaşkanının görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması, TBMM üye tam sayısının SALT ÇOĞUNLUĞUNUN (301 milletvekili) vereceği önergeyle istenebilir; soruşturma açılmasına üye tam sayısının 3/5 çoğunluğuyla (360 oy) karar verilir. Soruşturma sonunda üye tam sayısının 2/3 çoğunluğuyla (400 oy) Cumhurbaşkanının Yüce Divana sevkine karar verilebilir; Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir. Yüce Divana sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1)
  and tc.content_md not like '%## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)%';

-- konu: Anayasa (Vatandaşlık / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)
2010 yılında yapılan Anayasa değişikliğiyle (madde 148) getirilen bireysel başvuru yolu, herkese, Anayasada güvence altına alınmış temel hak ve özgürlüklerinden Avrupa İnsan Hakları Sözleşmesi kapsamındaki herhangi birinin kamu gücü tarafından İHLAL EDİLDİĞİ iddiasıyla Anayasa Mahkemesi''ne başvurma imkânı tanır. Bireysel başvuru yapılabilmesi için OLAĞAN KANUN YOLLARININ (diğer yargı mercilerinin) tüketilmiş olması şarttır; yani Anayasa Mahkemesi bu konuda ilk başvuru mercii değil, ikincil (tali) bir denetim mercidir. Yasama işlemleri (kanunlar) ile düzenleyici idari işlemler aleyhine doğrudan bireysel başvuru yapılamaz.

## Cumhurbaşkanının Cezai Sorumluluğu
Cumhurbaşkanının görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması, TBMM üye tam sayısının SALT ÇOĞUNLUĞUNUN (301 milletvekili) vereceği önergeyle istenebilir; soruşturma açılmasına üye tam sayısının 3/5 çoğunluğuyla (360 oy) karar verilir. Soruşturma sonunda üye tam sayısının 2/3 çoğunluğuyla (400 oy) Cumhurbaşkanının Yüce Divana sevkine karar verilebilir; Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir. Yüce Divana sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1)
  and tc.content_md not like '%## Anayasa Mahkemesi''ne Bireysel Başvuru (Anayasa Şikâyeti)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?', 'Bireysel başvuru kurumunun Anayasaya giriş tarihini bilir.', '2010 yılında yapılan halkoylamasıyla kabul edilen Anayasa değişikliğiyle madde 148''e eklenen bireysel başvuru yolu, 2012 yılından itibaren fiilen uygulanmaya başlamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('2010', true, 3),
  ('1982', false, 1),
  ('1995', false, 4),
  ('2001', false, 2),
  ('2017', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?', 'Bireysel başvuru kurumunun Anayasaya giriş tarihini bilir.', '2010 yılında yapılan halkoylamasıyla kabul edilen Anayasa değişikliğiyle madde 148''e eklenen bireysel başvuru yolu, 2012 yılından itibaren fiilen uygulanmaya başlamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('2010', true, 3),
  ('1982', false, 1),
  ('1995', false, 4),
  ('2001', false, 2),
  ('2017', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?', 'Bireysel başvuru kurumunun Anayasaya giriş tarihini bilir.', '2010 yılında yapılan halkoylamasıyla kabul edilen Anayasa değişikliğiyle madde 148''e eklenen bireysel başvuru yolu, 2012 yılından itibaren fiilen uygulanmaya başlamıştır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru hakkı hangi yılda yapılan Anayasa değişikliğiyle getirilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('2010', true, 3),
  ('1982', false, 1),
  ('1995', false, 4),
  ('2001', false, 2),
  ('2017', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?', 'Bireysel başvurunun ikincillik (tali) niteliğini açıklar.', 'Anayasa Mahkemesi bireysel başvuruda ilk derece mercii değildir; başvurucunun önce diğer yargı mercilerinde öngörülen olağan kanun yollarını tüketmiş olması gerekir. Bu şart, Anayasa Mahkemesinin ikincil (tali) denetim niteliğinin bir sonucudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Olağan kanun yollarının (diğer yargı mercilerinin) tüketilmiş olması', true, 1),
  ('Başvurucunun Türk vatandaşı olması', false, 3),
  ('Başvurunun mutlaka bir avukat aracılığıyla yapılması', false, 0),
  ('Başvurunun Cumhurbaşkanı onayından geçmesi', false, 4),
  ('Konunun önce TBMM Genel Kurulunda görüşülmüş olması', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?', 'Bireysel başvurunun ikincillik (tali) niteliğini açıklar.', 'Anayasa Mahkemesi bireysel başvuruda ilk derece mercii değildir; başvurucunun önce diğer yargı mercilerinde öngörülen olağan kanun yollarını tüketmiş olması gerekir. Bu şart, Anayasa Mahkemesinin ikincil (tali) denetim niteliğinin bir sonucudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Olağan kanun yollarının (diğer yargı mercilerinin) tüketilmiş olması', true, 1),
  ('Başvurucunun Türk vatandaşı olması', false, 3),
  ('Başvurunun mutlaka bir avukat aracılığıyla yapılması', false, 0),
  ('Başvurunun Cumhurbaşkanı onayından geçmesi', false, 4),
  ('Konunun önce TBMM Genel Kurulunda görüşülmüş olması', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?', 'Bireysel başvurunun ikincillik (tali) niteliğini açıklar.', 'Anayasa Mahkemesi bireysel başvuruda ilk derece mercii değildir; başvurucunun önce diğer yargı mercilerinde öngörülen olağan kanun yollarını tüketmiş olması gerekir. Bu şart, Anayasa Mahkemesinin ikincil (tali) denetim niteliğinin bir sonucudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesine bireysel başvuru yolunda bulunulabilmesi için aşağıdakilerden hangisi bir ön şarttır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Olağan kanun yollarının (diğer yargı mercilerinin) tüketilmiş olması', true, 1),
  ('Başvurucunun Türk vatandaşı olması', false, 3),
  ('Başvurunun mutlaka bir avukat aracılığıyla yapılması', false, 0),
  ('Başvurunun Cumhurbaşkanı onayından geçmesi', false, 4),
  ('Konunun önce TBMM Genel Kurulunda görüşülmüş olması', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?', 'Anayasa değişikliği teklifinin kabul çoğunluğuna göre Cumhurbaşkanının izleyeceği usulü açıklar.', '3/5 ile 2/3 arasındaki bir çoğunlukla kabul edilen değişiklikler için Cumhurbaşkanı, metni halkoylamasına sunabilir veya tekrar görüşülmek üzere TBMM''ye iade edebilir. 2/3 ve üzeri çoğunlukla kabul edilen değişiklikleri ise doğrudan onaylayabilir ya da yine halkoyuna sunabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Değişikliği halkoylamasına sunabilir veya tekrar görüşülmek üzere Meclise iade edebilir', true, 2),
  ('Değişikliği doğrudan yürürlüğe koymak zorundadır, başka seçeneği yoktur', false, 1),
  ('Değişikliği veto ederek tamamen ve kalıcı olarak iptal eder', false, 4),
  ('Anayasa Mahkemesi''ne doğrudan iptal davası açar', false, 0),
  ('Değişikliğin kabulü için ayrıca Yargıtay onayı ister', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?', 'Anayasa değişikliği teklifinin kabul çoğunluğuna göre Cumhurbaşkanının izleyeceği usulü açıklar.', '3/5 ile 2/3 arasındaki bir çoğunlukla kabul edilen değişiklikler için Cumhurbaşkanı, metni halkoylamasına sunabilir veya tekrar görüşülmek üzere TBMM''ye iade edebilir. 2/3 ve üzeri çoğunlukla kabul edilen değişiklikleri ise doğrudan onaylayabilir ya da yine halkoyuna sunabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Değişikliği halkoylamasına sunabilir veya tekrar görüşülmek üzere Meclise iade edebilir', true, 2),
  ('Değişikliği doğrudan yürürlüğe koymak zorundadır, başka seçeneği yoktur', false, 1),
  ('Değişikliği veto ederek tamamen ve kalıcı olarak iptal eder', false, 4),
  ('Anayasa Mahkemesi''ne doğrudan iptal davası açar', false, 0),
  ('Değişikliğin kabulü için ayrıca Yargıtay onayı ister', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?', 'Anayasa değişikliği teklifinin kabul çoğunluğuna göre Cumhurbaşkanının izleyeceği usulü açıklar.', '3/5 ile 2/3 arasındaki bir çoğunlukla kabul edilen değişiklikler için Cumhurbaşkanı, metni halkoylamasına sunabilir veya tekrar görüşülmek üzere TBMM''ye iade edebilir. 2/3 ve üzeri çoğunlukla kabul edilen değişiklikleri ise doğrudan onaylayabilir ya da yine halkoyuna sunabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1982 Anayasası''na göre bir anayasa değişikliği teklifi TBMM Genel Kurulunda 3/5 ile 2/3 arasında bir çoğunlukla (360-399 oy) kabul edilirse Cumhurbaşkanı ne yapabilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Değişikliği halkoylamasına sunabilir veya tekrar görüşülmek üzere Meclise iade edebilir', true, 2),
  ('Değişikliği doğrudan yürürlüğe koymak zorundadır, başka seçeneği yoktur', false, 1),
  ('Değişikliği veto ederek tamamen ve kalıcı olarak iptal eder', false, 4),
  ('Anayasa Mahkemesi''ne doğrudan iptal davası açar', false, 0),
  ('Değişikliğin kabulü için ayrıca Yargıtay onayı ister', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?', 'Cumhurbaşkanı hakkında Meclis soruşturması sürecindeki çoğunluk oranlarını bilir.', 'Meclis soruşturması açılması önergesi TBMM üye tam sayısının salt çoğunluğu, yani en az 301 milletvekili tarafından verilebilir. Bu önerge sonrasında soruşturma açılmasına ise üye tam sayısının 3/5''i (360 oy) ile karar verilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Salt çoğunluk (301 milletvekili)', true, 4),
  ('1/3 (200 milletvekili)', false, 0),
  ('3/5 (360 milletvekili)', false, 3),
  ('2/3 (400 milletvekili)', false, 1),
  ('4/5 (480 milletvekili)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?', 'Cumhurbaşkanı hakkında Meclis soruşturması sürecindeki çoğunluk oranlarını bilir.', 'Meclis soruşturması açılması önergesi TBMM üye tam sayısının salt çoğunluğu, yani en az 301 milletvekili tarafından verilebilir. Bu önerge sonrasında soruşturma açılmasına ise üye tam sayısının 3/5''i (360 oy) ile karar verilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Salt çoğunluk (301 milletvekili)', true, 4),
  ('1/3 (200 milletvekili)', false, 0),
  ('3/5 (360 milletvekili)', false, 3),
  ('2/3 (400 milletvekili)', false, 1),
  ('4/5 (480 milletvekili)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?', 'Cumhurbaşkanı hakkında Meclis soruşturması sürecindeki çoğunluk oranlarını bilir.', 'Meclis soruşturması açılması önergesi TBMM üye tam sayısının salt çoğunluğu, yani en az 301 milletvekili tarafından verilebilir. Bu önerge sonrasında soruşturma açılmasına ise üye tam sayısının 3/5''i (360 oy) ile karar verilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında görevle ilgili bir suç işlediği iddiasıyla Meclis soruşturması açılması önergesi, TBMM üye tam sayısının hangi oranıyla verilebilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Salt çoğunluk (301 milletvekili)', true, 4),
  ('1/3 (200 milletvekili)', false, 0),
  ('3/5 (360 milletvekili)', false, 3),
  ('2/3 (400 milletvekili)', false, 1),
  ('4/5 (480 milletvekili)', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?', 'Cumhurbaşkanının Yüce Divana sevk usulünü ve yetkili organı bilir.', 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir; Yüce Divana sevk kararı ise TBMM üye tam sayısının 2/3 çoğunluğuyla (400 oy) alınır. Sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Anayasa Mahkemesi - üye tam sayısının 2/3''ü (400 oy)', true, 0),
  ('Yargıtay - üye tam sayısının 3/5''i (360 oy)', false, 3),
  ('Danıştay - salt çoğunluk (301 oy)', false, 1),
  ('TBMM Genel Kurulu - üye tam sayısının 1/3''ü (200 oy)', false, 2),
  ('Hakimler ve Savcılar Kurulu - üye tam sayısının 2/3''ü (400 oy)', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?', 'Cumhurbaşkanının Yüce Divana sevk usulünü ve yetkili organı bilir.', 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir; Yüce Divana sevk kararı ise TBMM üye tam sayısının 2/3 çoğunluğuyla (400 oy) alınır. Sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Anayasa Mahkemesi - üye tam sayısının 2/3''ü (400 oy)', true, 0),
  ('Yargıtay - üye tam sayısının 3/5''i (360 oy)', false, 3),
  ('Danıştay - salt çoğunluk (301 oy)', false, 1),
  ('TBMM Genel Kurulu - üye tam sayısının 1/3''ü (200 oy)', false, 2),
  ('Hakimler ve Savcılar Kurulu - üye tam sayısının 2/3''ü (400 oy)', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Anayasa' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?', 'Cumhurbaşkanının Yüce Divana sevk usulünü ve yetkili organı bilir.', 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapma yetkisi Anayasa Mahkemesi''ne aittir; Yüce Divana sevk kararı ise TBMM üye tam sayısının 2/3 çoğunluğuyla (400 oy) alınır. Sevk kararı verilmesi halinde Cumhurbaşkanının görevi sona erer.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Cumhurbaşkanı hakkında Yüce Divan sıfatıyla yargılama yapmaya yetkili organ ve bu yargılamaya sevk kararının gerektirdiği çoğunluk aşağıdakilerin hangisinde doğru verilmiştir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Anayasa Mahkemesi - üye tam sayısının 2/3''ü (400 oy)', true, 0),
  ('Yargıtay - üye tam sayısının 3/5''i (360 oy)', false, 3),
  ('Danıştay - salt çoğunluk (301 oy)', false, 1),
  ('TBMM Genel Kurulu - üye tam sayısının 1/3''ü (200 oy)', false, 2),
  ('Hakimler ve Savcılar Kurulu - üye tam sayısının 2/3''ü (400 oy)', false, 4)
) as v(choice_text, is_correct, order_index);

-- konu: Yasama-Yürütme-Yargı (Vatandaşlık / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu
Anayasanın 83. maddesine göre TBMM üyeleri, Meclis çalışmalarındaki oy ve sözlerinden, Mecliste ileri sürdükleri düşüncelerden sorumlu tutulamaz (YASAMA SORUMSUZLUĞU); bu koruma MUTLAK ve süresizdir, milletvekilliği sona erse dahi geçerliliğini korur. Ayrıca seçimden önce veya sonra bir suç işlediği ileri sürülen milletvekili, Meclisin kararı olmadıkça tutulamaz, sorguya çekilemez, tutuklanamaz ve yargılanamaz (YASAMA DOKUNULMAZLIĞI); bu koruma GÖRECELİDİR, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Ağır cezayı gerektiren suçüstü hâli ile Anayasa''nın 14. maddesinde sayılan durumlar (devletin bütünlüğüne karşı suçlar vb.) bu dokunulmazlığın istisnalarını oluşturur.

## Meclisin Denetim Yolları ve Gensorunun Kaldırılması
2017 Anayasa değişikliğiyle, Bakanlar Kurulu''nun ve tek tek bakanların siyasi sorumluluğuna dayanan GENSORU (gensoru önergesi) mekanizması yürürlükten kaldırılmıştır; parlamenter sistemin bu klasik denetim aracı, yürütmenin tek başlı hâle geldiği Cumhurbaşkanlığı hükümet sisteminde artık bulunmamaktadır. Günümüzde TBMM''nin yürütmeyi denetleme araçları yazılı soru, Meclis araştırması, genel görüşme ve Cumhurbaşkanı yardımcıları ile bakanlar hakkında açılabilen Meclis soruşturmasıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1)
  and tc.content_md not like '%## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu%';

-- konu: Yasama-Yürütme-Yargı (Vatandaşlık / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu
Anayasanın 83. maddesine göre TBMM üyeleri, Meclis çalışmalarındaki oy ve sözlerinden, Mecliste ileri sürdükleri düşüncelerden sorumlu tutulamaz (YASAMA SORUMSUZLUĞU); bu koruma MUTLAK ve süresizdir, milletvekilliği sona erse dahi geçerliliğini korur. Ayrıca seçimden önce veya sonra bir suç işlediği ileri sürülen milletvekili, Meclisin kararı olmadıkça tutulamaz, sorguya çekilemez, tutuklanamaz ve yargılanamaz (YASAMA DOKUNULMAZLIĞI); bu koruma GÖRECELİDİR, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Ağır cezayı gerektiren suçüstü hâli ile Anayasa''nın 14. maddesinde sayılan durumlar (devletin bütünlüğüne karşı suçlar vb.) bu dokunulmazlığın istisnalarını oluşturur.

## Meclisin Denetim Yolları ve Gensorunun Kaldırılması
2017 Anayasa değişikliğiyle, Bakanlar Kurulu''nun ve tek tek bakanların siyasi sorumluluğuna dayanan GENSORU (gensoru önergesi) mekanizması yürürlükten kaldırılmıştır; parlamenter sistemin bu klasik denetim aracı, yürütmenin tek başlı hâle geldiği Cumhurbaşkanlığı hükümet sisteminde artık bulunmamaktadır. Günümüzde TBMM''nin yürütmeyi denetleme araçları yazılı soru, Meclis araştırması, genel görüşme ve Cumhurbaşkanı yardımcıları ile bakanlar hakkında açılabilen Meclis soruşturmasıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1)
  and tc.content_md not like '%## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu%';

-- konu: Yasama-Yürütme-Yargı (Vatandaşlık / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu
Anayasanın 83. maddesine göre TBMM üyeleri, Meclis çalışmalarındaki oy ve sözlerinden, Mecliste ileri sürdükleri düşüncelerden sorumlu tutulamaz (YASAMA SORUMSUZLUĞU); bu koruma MUTLAK ve süresizdir, milletvekilliği sona erse dahi geçerliliğini korur. Ayrıca seçimden önce veya sonra bir suç işlediği ileri sürülen milletvekili, Meclisin kararı olmadıkça tutulamaz, sorguya çekilemez, tutuklanamaz ve yargılanamaz (YASAMA DOKUNULMAZLIĞI); bu koruma GÖRECELİDİR, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Ağır cezayı gerektiren suçüstü hâli ile Anayasa''nın 14. maddesinde sayılan durumlar (devletin bütünlüğüne karşı suçlar vb.) bu dokunulmazlığın istisnalarını oluşturur.

## Meclisin Denetim Yolları ve Gensorunun Kaldırılması
2017 Anayasa değişikliğiyle, Bakanlar Kurulu''nun ve tek tek bakanların siyasi sorumluluğuna dayanan GENSORU (gensoru önergesi) mekanizması yürürlükten kaldırılmıştır; parlamenter sistemin bu klasik denetim aracı, yürütmenin tek başlı hâle geldiği Cumhurbaşkanlığı hükümet sisteminde artık bulunmamaktadır. Günümüzde TBMM''nin yürütmeyi denetleme araçları yazılı soru, Meclis araştırması, genel görüşme ve Cumhurbaşkanı yardımcıları ile bakanlar hakkında açılabilen Meclis soruşturmasıdır.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1)
  and tc.content_md not like '%## TBMM Üyelerinin Yasama Dokunulmazlığı ve Sorumsuzluğu%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'TBMM üyeleri kaç yıl için seçilir?', 'TBMM üyelerinin görev süresini bilir.', '2017 Anayasa değişikliğiyle milletvekili genel seçimleri dönemi 4 yıldan 5 yıla çıkarılmış ve Cumhurbaşkanlığı seçimiyle aynı güne getirilmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM üyeleri kaç yıl için seçilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5 yıl', true, 3),
  ('4 yıl', false, 4),
  ('6 yıl', false, 2),
  ('3 yıl', false, 0),
  ('7 yıl', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'TBMM üyeleri kaç yıl için seçilir?', 'TBMM üyelerinin görev süresini bilir.', '2017 Anayasa değişikliğiyle milletvekili genel seçimleri dönemi 4 yıldan 5 yıla çıkarılmış ve Cumhurbaşkanlığı seçimiyle aynı güne getirilmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM üyeleri kaç yıl için seçilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5 yıl', true, 3),
  ('4 yıl', false, 4),
  ('6 yıl', false, 2),
  ('3 yıl', false, 0),
  ('7 yıl', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'TBMM üyeleri kaç yıl için seçilir?', 'TBMM üyelerinin görev süresini bilir.', '2017 Anayasa değişikliğiyle milletvekili genel seçimleri dönemi 4 yıldan 5 yıla çıkarılmış ve Cumhurbaşkanlığı seçimiyle aynı güne getirilmiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'TBMM üyeleri kaç yıl için seçilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('5 yıl', true, 3),
  ('4 yıl', false, 4),
  ('6 yıl', false, 2),
  ('3 yıl', false, 0),
  ('7 yıl', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?', 'Yasama sorumsuzluğu kavramını tanımlar.', 'Yasama sorumsuzluğu, milletvekillerinin Meclis içindeki oy, söz ve düşüncelerinden dolayı hiçbir şekilde sorumlu tutulamamasını ifade eder ve milletvekilliği sona erse dahi geçerliliğini sürdüren mutlak bir korumadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yasama sorumsuzluğu', true, 2),
  ('Yasama dokunulmazlığı', false, 0),
  ('Siyasi bağışıklık', false, 3),
  ('Meclis muafiyeti', false, 4),
  ('Milletvekili ayrıcalığı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?', 'Yasama sorumsuzluğu kavramını tanımlar.', 'Yasama sorumsuzluğu, milletvekillerinin Meclis içindeki oy, söz ve düşüncelerinden dolayı hiçbir şekilde sorumlu tutulamamasını ifade eder ve milletvekilliği sona erse dahi geçerliliğini sürdüren mutlak bir korumadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yasama sorumsuzluğu', true, 2),
  ('Yasama dokunulmazlığı', false, 0),
  ('Siyasi bağışıklık', false, 3),
  ('Meclis muafiyeti', false, 4),
  ('Milletvekili ayrıcalığı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?', 'Yasama sorumsuzluğu kavramını tanımlar.', 'Yasama sorumsuzluğu, milletvekillerinin Meclis içindeki oy, söz ve düşüncelerinden dolayı hiçbir şekilde sorumlu tutulamamasını ifade eder ve milletvekilliği sona erse dahi geçerliliğini sürdüren mutlak bir korumadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Milletvekillerinin Meclis çalışmalarındaki oy ve sözlerinden dolayı sorumlu tutulamamasına ne ad verilir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yasama sorumsuzluğu', true, 2),
  ('Yasama dokunulmazlığı', false, 0),
  ('Siyasi bağışıklık', false, 3),
  ('Meclis muafiyeti', false, 4),
  ('Milletvekili ayrıcalığı', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?', 'Yasama dokunulmazlığı ile yasama sorumsuzluğu kavramlarını karşılaştırır.', 'Yasama sorumsuzluğu mutlak ve süreklidir, milletvekilliği bitse dahi geçerlidir; yasama dokunulmazlığı ise göreceli bir korumadır, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Bu iki kavramın karıştırılması ÖSYM''nin sık kullandığı bir çeldirici noktasıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sorumsuzluk mutlak ve süreklidir, dokunulmazlık ise Meclis kararıyla kaldırılabilen göreceli bir korumadır', true, 3),
  ('İkisi de aynı kapsamda olup birbirinin yerine kullanılabilir', false, 0),
  ('Dokunulmazlık mutlak ve süreklidir, sorumsuzluk ise Meclis kararıyla kaldırılabilir', false, 2),
  ('Sorumsuzluk yalnızca ceza davalarında, dokunulmazlık yalnızca hukuk davalarında geçerlidir', false, 4),
  ('Her ikisi de yalnızca milletvekilliği süresince değil, hayat boyu geçerlidir', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?', 'Yasama dokunulmazlığı ile yasama sorumsuzluğu kavramlarını karşılaştırır.', 'Yasama sorumsuzluğu mutlak ve süreklidir, milletvekilliği bitse dahi geçerlidir; yasama dokunulmazlığı ise göreceli bir korumadır, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Bu iki kavramın karıştırılması ÖSYM''nin sık kullandığı bir çeldirici noktasıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sorumsuzluk mutlak ve süreklidir, dokunulmazlık ise Meclis kararıyla kaldırılabilen göreceli bir korumadır', true, 3),
  ('İkisi de aynı kapsamda olup birbirinin yerine kullanılabilir', false, 0),
  ('Dokunulmazlık mutlak ve süreklidir, sorumsuzluk ise Meclis kararıyla kaldırılabilir', false, 2),
  ('Sorumsuzluk yalnızca ceza davalarında, dokunulmazlık yalnızca hukuk davalarında geçerlidir', false, 4),
  ('Her ikisi de yalnızca milletvekilliği süresince değil, hayat boyu geçerlidir', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?', 'Yasama dokunulmazlığı ile yasama sorumsuzluğu kavramlarını karşılaştırır.', 'Yasama sorumsuzluğu mutlak ve süreklidir, milletvekilliği bitse dahi geçerlidir; yasama dokunulmazlığı ise göreceli bir korumadır, Meclis kararıyla kaldırılabilir ve yalnızca görev süresiyle sınırlıdır. Bu iki kavramın karıştırılması ÖSYM''nin sık kullandığı bir çeldirici noktasıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Yasama dokunulmazlığı ile yasama sorumsuzluğu arasındaki fark hakkında aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sorumsuzluk mutlak ve süreklidir, dokunulmazlık ise Meclis kararıyla kaldırılabilen göreceli bir korumadır', true, 3),
  ('İkisi de aynı kapsamda olup birbirinin yerine kullanılabilir', false, 0),
  ('Dokunulmazlık mutlak ve süreklidir, sorumsuzluk ise Meclis kararıyla kaldırılabilir', false, 2),
  ('Sorumsuzluk yalnızca ceza davalarında, dokunulmazlık yalnızca hukuk davalarında geçerlidir', false, 4),
  ('Her ikisi de yalnızca milletvekilliği süresince değil, hayat boyu geçerlidir', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?', '2017 değişikliğiyle kaldırılan Meclis denetim aracını bilir.', 'Bakanlar Kurulu''nun ve bakanların siyasi sorumluluğuna dayanan gensoru mekanizması, yürütmenin tek başlı hale gelmesiyle 2017 değişikliğinde kaldırılmıştır. Yazılı soru, genel görüşme, Meclis araştırması ve Meclis soruşturması gibi denetim araçları yürürlükte kalmaya devam etmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gensoru', true, 0),
  ('Meclis araştırması', false, 3),
  ('Genel görüşme', false, 2),
  ('Yazılı soru', false, 1),
  ('Meclis soruşturması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?', '2017 değişikliğiyle kaldırılan Meclis denetim aracını bilir.', 'Bakanlar Kurulu''nun ve bakanların siyasi sorumluluğuna dayanan gensoru mekanizması, yürütmenin tek başlı hale gelmesiyle 2017 değişikliğinde kaldırılmıştır. Yazılı soru, genel görüşme, Meclis araştırması ve Meclis soruşturması gibi denetim araçları yürürlükte kalmaya devam etmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gensoru', true, 0),
  ('Meclis araştırması', false, 3),
  ('Genel görüşme', false, 2),
  ('Yazılı soru', false, 1),
  ('Meclis soruşturması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?', '2017 değişikliğiyle kaldırılan Meclis denetim aracını bilir.', 'Bakanlar Kurulu''nun ve bakanların siyasi sorumluluğuna dayanan gensoru mekanizması, yürütmenin tek başlı hale gelmesiyle 2017 değişikliğinde kaldırılmıştır. Yazılı soru, genel görüşme, Meclis araştırması ve Meclis soruşturması gibi denetim araçları yürürlükte kalmaya devam etmektedir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '2017 Anayasa değişikliğiyle aşağıdaki Meclis denetim araçlarından hangisi yürürlükten kaldırılmıştır?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Gensoru', true, 0),
  ('Meclis araştırması', false, 3),
  ('Genel görüşme', false, 2),
  ('Yazılı soru', false, 1),
  ('Meclis soruşturması', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Anayasa Mahkemesi kaç üyeden oluşur?', 'Anayasa Mahkemesinin üye sayısını bilir.', 'Anayasa Mahkemesi, 2017 Anayasa değişikliği ile üye sayısı 17''den 15''e indirilerek bugünkü hâliyle 15 üyeden oluşmaktadır. Bu, TBMM''nin ve yargı organlarının yapısına ilişkin sık sorulan güncel bir sayısal bilgidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesi kaç üyeden oluşur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('15', true, 4),
  ('11', false, 1),
  ('17', false, 2),
  ('19', false, 3),
  ('22', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Anayasa Mahkemesi kaç üyeden oluşur?', 'Anayasa Mahkemesinin üye sayısını bilir.', 'Anayasa Mahkemesi, 2017 Anayasa değişikliği ile üye sayısı 17''den 15''e indirilerek bugünkü hâliyle 15 üyeden oluşmaktadır. Bu, TBMM''nin ve yargı organlarının yapısına ilişkin sık sorulan güncel bir sayısal bilgidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesi kaç üyeden oluşur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('15', true, 4),
  ('11', false, 1),
  ('17', false, 2),
  ('19', false, 3),
  ('22', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Yasama-Yürütme-Yargı' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Anayasa Mahkemesi kaç üyeden oluşur?', 'Anayasa Mahkemesinin üye sayısını bilir.', 'Anayasa Mahkemesi, 2017 Anayasa değişikliği ile üye sayısı 17''den 15''e indirilerek bugünkü hâliyle 15 üyeden oluşmaktadır. Bu, TBMM''nin ve yargı organlarının yapısına ilişkin sık sorulan güncel bir sayısal bilgidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasa Mahkemesi kaç üyeden oluşur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('15', true, 4),
  ('11', false, 1),
  ('17', false, 2),
  ('19', false, 3),
  ('22', false, 0)
) as v(choice_text, is_correct, order_index);

-- konu: Temel Hak ve Özgürlükler (Vatandaşlık / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)
Anayasanın 10. maddesine göre herkes, dil, ırk, renk, cinsiyet, siyasi düşünce, felsefi inanç, din, mezhep ayrımı gözetilmeksizin kanun önünde EŞİTTİR. Ancak Anayasa doktrini ve Anayasa Mahkemesi içtihadı, kadınlar, çocuklar, yaşlılar, engelliler ile harp ve vazife şehitlerinin dul ve yetimleri gibi özel korunma ihtiyacı olan kesimler için alınacak tedbirlerin eşitlik ilkesine AYKIRI SAYILAMAYACAĞINI kabul eder; bu uygulamaya "POZİTİF AYRIMCILIK" (olumlu ayrımcılık) denir ve amacı biçimsel değil GERÇEK (maddi) eşitliği sağlamaktır.

## Yabancıların Temel Hak ve Hürriyetleri (Madde 16)
Anayasanın 16. maddesine göre temel hak ve hürriyetler, YABANCILAR için, milletlerarası hukuka uygun olarak KANUNLA sınırlanabilir. Bu düzenleme, vatandaşlar için madde 13''te öngörülen genel sınırlama rejiminden FARKLI ve daha GENİŞ bir sınırlama imkânı tanır; yani yabancıların hak ve özgürlükleri (örneğin mülkiyet edinme, seyahat, siyasi faaliyette bulunma gibi konularda), vatandaşlarınkine kıyasla kanun koyucu tarafından daha kolay sınırlandırılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1)
  and tc.content_md not like '%## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)%';

-- konu: Temel Hak ve Özgürlükler (Vatandaşlık / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)
Anayasanın 10. maddesine göre herkes, dil, ırk, renk, cinsiyet, siyasi düşünce, felsefi inanç, din, mezhep ayrımı gözetilmeksizin kanun önünde EŞİTTİR. Ancak Anayasa doktrini ve Anayasa Mahkemesi içtihadı, kadınlar, çocuklar, yaşlılar, engelliler ile harp ve vazife şehitlerinin dul ve yetimleri gibi özel korunma ihtiyacı olan kesimler için alınacak tedbirlerin eşitlik ilkesine AYKIRI SAYILAMAYACAĞINI kabul eder; bu uygulamaya "POZİTİF AYRIMCILIK" (olumlu ayrımcılık) denir ve amacı biçimsel değil GERÇEK (maddi) eşitliği sağlamaktır.

## Yabancıların Temel Hak ve Hürriyetleri (Madde 16)
Anayasanın 16. maddesine göre temel hak ve hürriyetler, YABANCILAR için, milletlerarası hukuka uygun olarak KANUNLA sınırlanabilir. Bu düzenleme, vatandaşlar için madde 13''te öngörülen genel sınırlama rejiminden FARKLI ve daha GENİŞ bir sınırlama imkânı tanır; yani yabancıların hak ve özgürlükleri (örneğin mülkiyet edinme, seyahat, siyasi faaliyette bulunma gibi konularda), vatandaşlarınkine kıyasla kanun koyucu tarafından daha kolay sınırlandırılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1)
  and tc.content_md not like '%## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)%';

-- konu: Temel Hak ve Özgürlükler (Vatandaşlık / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)
Anayasanın 10. maddesine göre herkes, dil, ırk, renk, cinsiyet, siyasi düşünce, felsefi inanç, din, mezhep ayrımı gözetilmeksizin kanun önünde EŞİTTİR. Ancak Anayasa doktrini ve Anayasa Mahkemesi içtihadı, kadınlar, çocuklar, yaşlılar, engelliler ile harp ve vazife şehitlerinin dul ve yetimleri gibi özel korunma ihtiyacı olan kesimler için alınacak tedbirlerin eşitlik ilkesine AYKIRI SAYILAMAYACAĞINI kabul eder; bu uygulamaya "POZİTİF AYRIMCILIK" (olumlu ayrımcılık) denir ve amacı biçimsel değil GERÇEK (maddi) eşitliği sağlamaktır.

## Yabancıların Temel Hak ve Hürriyetleri (Madde 16)
Anayasanın 16. maddesine göre temel hak ve hürriyetler, YABANCILAR için, milletlerarası hukuka uygun olarak KANUNLA sınırlanabilir. Bu düzenleme, vatandaşlar için madde 13''te öngörülen genel sınırlama rejiminden FARKLI ve daha GENİŞ bir sınırlama imkânı tanır; yani yabancıların hak ve özgürlükleri (örneğin mülkiyet edinme, seyahat, siyasi faaliyette bulunma gibi konularda), vatandaşlarınkine kıyasla kanun koyucu tarafından daha kolay sınırlandırılabilir.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1)
  and tc.content_md not like '%## Kanun Önünde Eşitlik İlkesi ve Pozitif Ayrımcılık (Madde 10)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?', 'Eşitlik ilkesi kapsamında pozitif ayrımcılık kavramını uygular.', 'Engelliler, çocuklar, yaşlılar gibi özel korunma ihtiyacı olan kesimler için alınan tedbirler, gerçek eşitliği sağlamayı amaçladığından eşitlik ilkesine aykırı sayılmaz; buna pozitif ayrımcılık denir. Din, siyasi görüş, doğum yeri veya cinsiyete dayalı ayrımcı uygulamalar ise Anayasa''nın 10. maddesine açıkça aykırıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Engelliler için toplu taşımada özel indirim ve erişim düzenlemeleri yapılması', true, 1),
  ('Belirli bir dine mensup kişilere farklı vergi oranı uygulanması', false, 0),
  ('Siyasi görüşe göre kamu hizmetine alımda farklı kriter uygulanması', false, 4),
  ('Belirli bir bölgede doğanlara farklı vatandaşlık statüsü tanınması', false, 2),
  ('Cinsiyete göre eğitim hakkının sınırlandırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?', 'Eşitlik ilkesi kapsamında pozitif ayrımcılık kavramını uygular.', 'Engelliler, çocuklar, yaşlılar gibi özel korunma ihtiyacı olan kesimler için alınan tedbirler, gerçek eşitliği sağlamayı amaçladığından eşitlik ilkesine aykırı sayılmaz; buna pozitif ayrımcılık denir. Din, siyasi görüş, doğum yeri veya cinsiyete dayalı ayrımcı uygulamalar ise Anayasa''nın 10. maddesine açıkça aykırıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Engelliler için toplu taşımada özel indirim ve erişim düzenlemeleri yapılması', true, 1),
  ('Belirli bir dine mensup kişilere farklı vergi oranı uygulanması', false, 0),
  ('Siyasi görüşe göre kamu hizmetine alımda farklı kriter uygulanması', false, 4),
  ('Belirli bir bölgede doğanlara farklı vatandaşlık statüsü tanınması', false, 2),
  ('Cinsiyete göre eğitim hakkının sınırlandırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?', 'Eşitlik ilkesi kapsamında pozitif ayrımcılık kavramını uygular.', 'Engelliler, çocuklar, yaşlılar gibi özel korunma ihtiyacı olan kesimler için alınan tedbirler, gerçek eşitliği sağlamayı amaçladığından eşitlik ilkesine aykırı sayılmaz; buna pozitif ayrımcılık denir. Din, siyasi görüş, doğum yeri veya cinsiyete dayalı ayrımcı uygulamalar ise Anayasa''nın 10. maddesine açıkça aykırıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 10. maddesinde düzenlenen "kanun önünde eşitlik" ilkesine göre aşağıdakilerden hangisi bu ilkeye AYKIRI DEĞİLDİR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Engelliler için toplu taşımada özel indirim ve erişim düzenlemeleri yapılması', true, 1),
  ('Belirli bir dine mensup kişilere farklı vergi oranı uygulanması', false, 0),
  ('Siyasi görüşe göre kamu hizmetine alımda farklı kriter uygulanması', false, 4),
  ('Belirli bir bölgede doğanlara farklı vatandaşlık statüsü tanınması', false, 2),
  ('Cinsiyete göre eğitim hakkının sınırlandırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?', 'Sosyal-ekonomik hakları kişi haklarından ayırt eder.', 'Sağlık hakkı, devletten aktif bir edimde (hizmet sunma) bulunmasını gerektiren sosyal ve ekonomik bir haktır. Seyahat özgürlüğü, konut dokunulmazlığı, din-vicdan özgürlüğü ve özel hayatın gizliliği ise devletten müdahale etmemesini isteyen birinci kuşak kişi haklarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sağlık hakkı', true, 1),
  ('Seyahat özgürlüğü', false, 2),
  ('Konut dokunulmazlığı', false, 0),
  ('Din ve vicdan özgürlüğü', false, 3),
  ('Özel hayatın gizliliği', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?', 'Sosyal-ekonomik hakları kişi haklarından ayırt eder.', 'Sağlık hakkı, devletten aktif bir edimde (hizmet sunma) bulunmasını gerektiren sosyal ve ekonomik bir haktır. Seyahat özgürlüğü, konut dokunulmazlığı, din-vicdan özgürlüğü ve özel hayatın gizliliği ise devletten müdahale etmemesini isteyen birinci kuşak kişi haklarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sağlık hakkı', true, 1),
  ('Seyahat özgürlüğü', false, 2),
  ('Konut dokunulmazlığı', false, 0),
  ('Din ve vicdan özgürlüğü', false, 3),
  ('Özel hayatın gizliliği', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?', 'Sosyal-ekonomik hakları kişi haklarından ayırt eder.', 'Sağlık hakkı, devletten aktif bir edimde (hizmet sunma) bulunmasını gerektiren sosyal ve ekonomik bir haktır. Seyahat özgürlüğü, konut dokunulmazlığı, din-vicdan özgürlüğü ve özel hayatın gizliliği ise devletten müdahale etmemesini isteyen birinci kuşak kişi haklarıdır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi sosyal ve ekonomik haklara (ikinci kuşak haklar) bir örnektir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Sağlık hakkı', true, 1),
  ('Seyahat özgürlüğü', false, 2),
  ('Konut dokunulmazlığı', false, 0),
  ('Din ve vicdan özgürlüğü', false, 3),
  ('Özel hayatın gizliliği', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?', 'Yabancıların hak ve hürriyetlerinin sınırlandırılma rejimini açıklar.', 'Madde 16''ya göre yabancıların temel hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu, vatandaşlar için öngörülen madde 13''teki genel rejime kıyasla daha geniş bir sınırlama imkânı sağlar. Yabancılar tamamen haksız bırakılmaz, ancak korumaları vatandaşlarınkinden daha dar olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yabancıların hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu sınırlama vatandaşlara göre daha geniş olabilir', true, 4),
  ('Yabancılar Türkiye''de hiçbir temel hak ve hürriyetten yararlanamaz', false, 2),
  ('Yabancıların hakları vatandaşlarla tamamen aynı şekilde, aynı sınırlarla korunur', false, 1),
  ('Yabancıların hakları yalnızca uluslararası mahkeme kararıyla sınırlanabilir', false, 0),
  ('Yabancıların temel hakları yalnızca Cumhurbaşkanlığı kararnamesiyle sınırlanabilir', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?', 'Yabancıların hak ve hürriyetlerinin sınırlandırılma rejimini açıklar.', 'Madde 16''ya göre yabancıların temel hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu, vatandaşlar için öngörülen madde 13''teki genel rejime kıyasla daha geniş bir sınırlama imkânı sağlar. Yabancılar tamamen haksız bırakılmaz, ancak korumaları vatandaşlarınkinden daha dar olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yabancıların hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu sınırlama vatandaşlara göre daha geniş olabilir', true, 4),
  ('Yabancılar Türkiye''de hiçbir temel hak ve hürriyetten yararlanamaz', false, 2),
  ('Yabancıların hakları vatandaşlarla tamamen aynı şekilde, aynı sınırlarla korunur', false, 1),
  ('Yabancıların hakları yalnızca uluslararası mahkeme kararıyla sınırlanabilir', false, 0),
  ('Yabancıların temel hakları yalnızca Cumhurbaşkanlığı kararnamesiyle sınırlanabilir', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?', 'Yabancıların hak ve hürriyetlerinin sınırlandırılma rejimini açıklar.', 'Madde 16''ya göre yabancıların temel hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu, vatandaşlar için öngörülen madde 13''teki genel rejime kıyasla daha geniş bir sınırlama imkânı sağlar. Yabancılar tamamen haksız bırakılmaz, ancak korumaları vatandaşlarınkinden daha dar olabilir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Anayasanın 16. maddesine göre yabancıların temel hak ve hürriyetleriyle ilgili aşağıdakilerden hangisi doğrudur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Yabancıların hak ve hürriyetleri, milletlerarası hukuka uygun olarak kanunla sınırlanabilir; bu sınırlama vatandaşlara göre daha geniş olabilir', true, 4),
  ('Yabancılar Türkiye''de hiçbir temel hak ve hürriyetten yararlanamaz', false, 2),
  ('Yabancıların hakları vatandaşlarla tamamen aynı şekilde, aynı sınırlarla korunur', false, 1),
  ('Yabancıların hakları yalnızca uluslararası mahkeme kararıyla sınırlanabilir', false, 0),
  ('Yabancıların temel hakları yalnızca Cumhurbaşkanlığı kararnamesiyle sınırlanabilir', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?', 'Pozitif ayrımcılık kavramını eşitlik ilkesi bağlamında tanımlar.', 'Pozitif ayrımcılık, kadın, çocuk, yaşlı, engelli gibi özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmamasını ifade eder; amaç biçimsel değil gerçek eşitliği sağlamaktır. Bu kavram, herhangi bir grubun ayrıcalıklı kılınması değil, dezavantajlı grupların dengelenmesidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmaması', true, 4),
  ('Belirli bir siyasi görüşe sahip kişilere kamu hizmetlerinde öncelik tanınması', false, 2),
  ('Kanun önünde eşitlik ilkesinin tamamen ortadan kaldırılması', false, 0),
  ('Yalnızca ekonomik açıdan güçlü kesimlere ek hak tanınması', false, 1),
  ('Vergi mükelleflerinin gelir düzeyine göre oy hakkının farklılaştırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?', 'Pozitif ayrımcılık kavramını eşitlik ilkesi bağlamında tanımlar.', 'Pozitif ayrımcılık, kadın, çocuk, yaşlı, engelli gibi özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmamasını ifade eder; amaç biçimsel değil gerçek eşitliği sağlamaktır. Bu kavram, herhangi bir grubun ayrıcalıklı kılınması değil, dezavantajlı grupların dengelenmesidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmaması', true, 4),
  ('Belirli bir siyasi görüşe sahip kişilere kamu hizmetlerinde öncelik tanınması', false, 2),
  ('Kanun önünde eşitlik ilkesinin tamamen ortadan kaldırılması', false, 0),
  ('Yalnızca ekonomik açıdan güçlü kesimlere ek hak tanınması', false, 1),
  ('Vergi mükelleflerinin gelir düzeyine göre oy hakkının farklılaştırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?', 'Pozitif ayrımcılık kavramını eşitlik ilkesi bağlamında tanımlar.', 'Pozitif ayrımcılık, kadın, çocuk, yaşlı, engelli gibi özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmamasını ifade eder; amaç biçimsel değil gerçek eşitliği sağlamaktır. Bu kavram, herhangi bir grubun ayrıcalıklı kılınması değil, dezavantajlı grupların dengelenmesidir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '"Pozitif ayrımcılık" (olumlu ayrımcılık) kavramı Anayasa hukukunda neyi ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Özel korunma ihtiyacı olan kesimler için alınan tedbirlerin eşitlik ilkesine aykırı sayılmaması', true, 4),
  ('Belirli bir siyasi görüşe sahip kişilere kamu hizmetlerinde öncelik tanınması', false, 2),
  ('Kanun önünde eşitlik ilkesinin tamamen ortadan kaldırılması', false, 0),
  ('Yalnızca ekonomik açıdan güçlü kesimlere ek hak tanınması', false, 1),
  ('Vergi mükelleflerinin gelir düzeyine göre oy hakkının farklılaştırılması', false, 3)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?', 'Vatandaşlara ve yabancılara uygulanan sınırlama rejimlerini karşılaştırır.', 'Madde 13, vatandaşların hak ve özgürlüklerinin kanunla ve ölçülülük ilkesine bağlı olarak sınırlanmasını düzenlerken; madde 16, yabancılar için milletlerarası hukuka uygunluk şartıyla daha esnek ve geniş bir sınırlama imkânı tanır. Bu fark, yabancıların hukuki statüsünün vatandaşlardan ayrıştığı önemli bir noktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Madde 16, yabancılar için vatandaşlara göre milletlerarası hukuka uygunluk şartıyla daha esnek/geniş bir sınırlama imkânı tanır', true, 3),
  ('Madde 16, yabancılara vatandaşlardan daha geniş hak güvencesi sağlar, sınırlama imkânı yoktur', false, 4),
  ('Madde 13 ve madde 16 birebir aynı sınırlama ölçütlerini öngörür, aralarında fark yoktur', false, 2),
  ('Madde 16, yabancıların haklarının yalnızca uluslararası antlaşmalarla sınırlanabileceğini, kanunun yetkisiz olduğunu öngörür', false, 0),
  ('Madde 13 yabancılara, madde 16 ise yalnızca vatandaşlara uygulanır', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?', 'Vatandaşlara ve yabancılara uygulanan sınırlama rejimlerini karşılaştırır.', 'Madde 13, vatandaşların hak ve özgürlüklerinin kanunla ve ölçülülük ilkesine bağlı olarak sınırlanmasını düzenlerken; madde 16, yabancılar için milletlerarası hukuka uygunluk şartıyla daha esnek ve geniş bir sınırlama imkânı tanır. Bu fark, yabancıların hukuki statüsünün vatandaşlardan ayrıştığı önemli bir noktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Madde 16, yabancılar için vatandaşlara göre milletlerarası hukuka uygunluk şartıyla daha esnek/geniş bir sınırlama imkânı tanır', true, 3),
  ('Madde 16, yabancılara vatandaşlardan daha geniş hak güvencesi sağlar, sınırlama imkânı yoktur', false, 4),
  ('Madde 13 ve madde 16 birebir aynı sınırlama ölçütlerini öngörür, aralarında fark yoktur', false, 2),
  ('Madde 16, yabancıların haklarının yalnızca uluslararası antlaşmalarla sınırlanabileceğini, kanunun yetkisiz olduğunu öngörür', false, 0),
  ('Madde 13 yabancılara, madde 16 ise yalnızca vatandaşlara uygulanır', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Temel Hak ve Özgürlükler' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?', 'Vatandaşlara ve yabancılara uygulanan sınırlama rejimlerini karşılaştırır.', 'Madde 13, vatandaşların hak ve özgürlüklerinin kanunla ve ölçülülük ilkesine bağlı olarak sınırlanmasını düzenlerken; madde 16, yabancılar için milletlerarası hukuka uygunluk şartıyla daha esnek ve geniş bir sınırlama imkânı tanır. Bu fark, yabancıların hukuki statüsünün vatandaşlardan ayrıştığı önemli bir noktadır.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdakilerden hangisi Anayasa''nın 13. maddesindeki genel sınırlama rejimi ile 16. maddesindeki yabancılara ilişkin sınırlama rejimi arasındaki farkı DOĞRU şekilde ifade eder?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Madde 16, yabancılar için vatandaşlara göre milletlerarası hukuka uygunluk şartıyla daha esnek/geniş bir sınırlama imkânı tanır', true, 3),
  ('Madde 16, yabancılara vatandaşlardan daha geniş hak güvencesi sağlar, sınırlama imkânı yoktur', false, 4),
  ('Madde 13 ve madde 16 birebir aynı sınırlama ölçütlerini öngörür, aralarında fark yoktur', false, 2),
  ('Madde 16, yabancıların haklarının yalnızca uluslararası antlaşmalarla sınırlanabileceğini, kanunun yetkisiz olduğunu öngörür', false, 0),
  ('Madde 13 yabancılara, madde 16 ise yalnızca vatandaşlara uygulanır', false, 1)
) as v(choice_text, is_correct, order_index);

-- konu: Uluslararası Kuruluşlar (Vatandaşlık / kpss_lisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)
1975 Helsinki Nihai Senedi ile "Avrupa Güvenlik ve İşbirliği Konferansı" (AGİK) adıyla kurulan, 1995''te AGİT adını alan örgüt, Avrupa''da güvenlik, insan hakları ve demokrasiyi geliştirmeyi amaçlayan, dünyanın en büyük bölgesel güvenlik örgütü kabul edilir; genel merkezi Viyana''dadır. Türkiye, örgütün KURUCU ÜYELERİNDEN biridir.

## Ekonomik İşbirliği Teşkilatı (EİT/ECO) ve D-8
Ekonomik İşbirliği Teşkilatı (ECO), 1985 yılında Türkiye, İran ve Pakistan tarafından, önceki RCD (Kalkınma İçin Bölgesel İşbirliği) örgütünün devamı niteliğinde kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla 10 üyeye genişlemiştir; genel merkezi Tahran''dadır. D-8 (Gelişen Sekiz Ülke) ise 1997''de Türkiye''nin ÖNCÜLÜĞÜNDE kurulmuş, Türkiye, Bangladeş, Endonezya, İran, Mısır, Malezya, Nijerya ve Pakistan''ı bir araya getiren, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini artırmayı amaçlayan bir platformdur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1)
  and tc.content_md not like '%## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)%';

-- konu: Uluslararası Kuruluşlar (Vatandaşlık / kpss_onlisans)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)
1975 Helsinki Nihai Senedi ile "Avrupa Güvenlik ve İşbirliği Konferansı" (AGİK) adıyla kurulan, 1995''te AGİT adını alan örgüt, Avrupa''da güvenlik, insan hakları ve demokrasiyi geliştirmeyi amaçlayan, dünyanın en büyük bölgesel güvenlik örgütü kabul edilir; genel merkezi Viyana''dadır. Türkiye, örgütün KURUCU ÜYELERİNDEN biridir.

## Ekonomik İşbirliği Teşkilatı (EİT/ECO) ve D-8
Ekonomik İşbirliği Teşkilatı (ECO), 1985 yılında Türkiye, İran ve Pakistan tarafından, önceki RCD (Kalkınma İçin Bölgesel İşbirliği) örgütünün devamı niteliğinde kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla 10 üyeye genişlemiştir; genel merkezi Tahran''dadır. D-8 (Gelişen Sekiz Ülke) ise 1997''de Türkiye''nin ÖNCÜLÜĞÜNDE kurulmuş, Türkiye, Bangladeş, Endonezya, İran, Mısır, Malezya, Nijerya ve Pakistan''ı bir araya getiren, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini artırmayı amaçlayan bir platformdur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1)
  and tc.content_md not like '%## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)%';

-- konu: Uluslararası Kuruluşlar (Vatandaşlık / kpss_ortaogretim)
update topic_contents tc
set content_md = tc.content_md || E'\n\n' || '## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)
1975 Helsinki Nihai Senedi ile "Avrupa Güvenlik ve İşbirliği Konferansı" (AGİK) adıyla kurulan, 1995''te AGİT adını alan örgüt, Avrupa''da güvenlik, insan hakları ve demokrasiyi geliştirmeyi amaçlayan, dünyanın en büyük bölgesel güvenlik örgütü kabul edilir; genel merkezi Viyana''dadır. Türkiye, örgütün KURUCU ÜYELERİNDEN biridir.

## Ekonomik İşbirliği Teşkilatı (EİT/ECO) ve D-8
Ekonomik İşbirliği Teşkilatı (ECO), 1985 yılında Türkiye, İran ve Pakistan tarafından, önceki RCD (Kalkınma İçin Bölgesel İşbirliği) örgütünün devamı niteliğinde kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla 10 üyeye genişlemiştir; genel merkezi Tahran''dadır. D-8 (Gelişen Sekiz Ülke) ise 1997''de Türkiye''nin ÖNCÜLÜĞÜNDE kurulmuş, Türkiye, Bangladeş, Endonezya, İran, Mısır, Malezya, Nijerya ve Pakistan''ı bir araya getiren, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini artırmayı amaçlayan bir platformdur.'
where tc.topic_id = (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1)
  and tc.content_md not like '%## AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)%';

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye NATO''ya hangi yıl üye olmuştur?', 'Türkiye''nin NATO''ya üyelik tarihini bilir.', 'NATO 1949''da kurulmuş, Türkiye ise Kore Savaşı''na asker göndermesinin ardından 1952 yılında NATO''ya üye olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye NATO''ya hangi yıl üye olmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1952', true, 1),
  ('1945', false, 4),
  ('1949', false, 3),
  ('1963', false, 0),
  ('1999', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye NATO''ya hangi yıl üye olmuştur?', 'Türkiye''nin NATO''ya üyelik tarihini bilir.', 'NATO 1949''da kurulmuş, Türkiye ise Kore Savaşı''na asker göndermesinin ardından 1952 yılında NATO''ya üye olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye NATO''ya hangi yıl üye olmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1952', true, 1),
  ('1945', false, 4),
  ('1949', false, 3),
  ('1963', false, 0),
  ('1999', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, 'Türkiye NATO''ya hangi yıl üye olmuştur?', 'Türkiye''nin NATO''ya üyelik tarihini bilir.', 'NATO 1949''da kurulmuş, Türkiye ise Kore Savaşı''na asker göndermesinin ardından 1952 yılında NATO''ya üye olmuştur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Türkiye NATO''ya hangi yıl üye olmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('1952', true, 1),
  ('1945', false, 4),
  ('1949', false, 3),
  ('1963', false, 0),
  ('1999', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?', 'AGİT''in kuruluşunu ve amacını bilir.', '1975''te AGİK (Avrupa Güvenlik ve İşbirliği Konferansı) adıyla kurulan örgüt, 1995''te AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı) adını almıştır. Türkiye bu örgütün kurucu üyelerindendir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)', true, 1),
  ('NATO', false, 4),
  ('Avrupa Konseyi', false, 2),
  ('Avrupa Birliği', false, 3),
  ('Birleşmiş Milletler', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?', 'AGİT''in kuruluşunu ve amacını bilir.', '1975''te AGİK (Avrupa Güvenlik ve İşbirliği Konferansı) adıyla kurulan örgüt, 1995''te AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı) adını almıştır. Türkiye bu örgütün kurucu üyelerindendir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)', true, 1),
  ('NATO', false, 4),
  ('Avrupa Konseyi', false, 2),
  ('Avrupa Birliği', false, 3),
  ('Birleşmiş Milletler', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'kolay'::difficulty_level, '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?', 'AGİT''in kuruluşunu ve amacını bilir.', '1975''te AGİK (Avrupa Güvenlik ve İşbirliği Konferansı) adıyla kurulan örgüt, 1995''te AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı) adını almıştır. Türkiye bu örgütün kurucu üyelerindendir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1975 Helsinki Nihai Senedi ile kurulan ve 1995''te bugünkü adını alan, Avrupa''da güvenlik ve insan haklarını geliştirmeyi amaçlayan kuruluş aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('AGİT (Avrupa Güvenlik ve İşbirliği Teşkilatı)', true, 1),
  ('NATO', false, 4),
  ('Avrupa Konseyi', false, 2),
  ('Avrupa Birliği', false, 3),
  ('Birleşmiş Milletler', false, 0)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?', 'EİT/ECO örgütünün kuruluşunu ve üyelerini bilir.', 'Ekonomik İşbirliği Teşkilatı (EİT/ECO), 1985''te Türkiye, İran ve Pakistan tarafından kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla genişlemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ekonomik İşbirliği Teşkilatı (EİT/ECO)', true, 1),
  ('Türk Devletleri Teşkilatı', false, 0),
  ('D-8', false, 4),
  ('İslam İşbirliği Teşkilatı', false, 3),
  ('Karadeniz Ekonomik İşbirliği Örgütü', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?', 'EİT/ECO örgütünün kuruluşunu ve üyelerini bilir.', 'Ekonomik İşbirliği Teşkilatı (EİT/ECO), 1985''te Türkiye, İran ve Pakistan tarafından kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla genişlemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ekonomik İşbirliği Teşkilatı (EİT/ECO)', true, 1),
  ('Türk Devletleri Teşkilatı', false, 0),
  ('D-8', false, 4),
  ('İslam İşbirliği Teşkilatı', false, 3),
  ('Karadeniz Ekonomik İşbirliği Örgütü', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?', 'EİT/ECO örgütünün kuruluşunu ve üyelerini bilir.', 'Ekonomik İşbirliği Teşkilatı (EİT/ECO), 1985''te Türkiye, İran ve Pakistan tarafından kurulmuş, sonradan Orta Asya Türk cumhuriyetleri ve Afganistan''ın katılımıyla genişlemiştir.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = '1985 yılında Türkiye, İran ve Pakistan tarafından kurulan, sonradan Orta Asya Türk cumhuriyetlerinin de katıldığı ekonomik iş birliği örgütü aşağıdakilerden hangisidir?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Ekonomik İşbirliği Teşkilatı (EİT/ECO)', true, 1),
  ('Türk Devletleri Teşkilatı', false, 0),
  ('D-8', false, 4),
  ('İslam İşbirliği Teşkilatı', false, 3),
  ('Karadeniz Ekonomik İşbirliği Örgütü', false, 2)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?', 'D-8 örgütünün kuruluş yılını ve öncüsünü bilir.', 'D-8, 1997 yılında Türkiye''nin öncülüğünde İstanbul''da kurulmuş, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini geliştirmeyi amaçlayan bir platformdur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Türkiye''nin öncülüğünde, 1997''de', true, 3),
  ('İran''ın öncülüğünde, 1985''te', false, 0),
  ('Mısır''ın öncülüğünde, 1990''da', false, 1),
  ('Malezya''nın öncülüğünde, 2001''de', false, 2),
  ('Pakistan''ın öncülüğünde, 1975''te', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?', 'D-8 örgütünün kuruluş yılını ve öncüsünü bilir.', 'D-8, 1997 yılında Türkiye''nin öncülüğünde İstanbul''da kurulmuş, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini geliştirmeyi amaçlayan bir platformdur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Türkiye''nin öncülüğünde, 1997''de', true, 3),
  ('İran''ın öncülüğünde, 1985''te', false, 0),
  ('Mısır''ın öncülüğünde, 1990''da', false, 1),
  ('Malezya''nın öncülüğünde, 2001''de', false, 2),
  ('Pakistan''ın öncülüğünde, 1975''te', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'orta'::difficulty_level, 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?', 'D-8 örgütünün kuruluş yılını ve öncüsünü bilir.', 'D-8, 1997 yılında Türkiye''nin öncülüğünde İstanbul''da kurulmuş, gelişmekte olan Müslüman ülkeler arasında ekonomik iş birliğini geliştirmeyi amaçlayan bir platformdur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'D-8 (Gelişen Sekiz Ülke) girişimi hangi ülkenin öncülüğünde, hangi yıl kurulmuştur?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('Türkiye''nin öncülüğünde, 1997''de', true, 3),
  ('İran''ın öncülüğünde, 1985''te', false, 0),
  ('Mısır''ın öncülüğünde, 1990''da', false, 1),
  ('Malezya''nın öncülüğünde, 2001''de', false, 2),
  ('Pakistan''ın öncülüğünde, 1975''te', false, 4)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_lisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?', 'Uluslararası kuruluşların kuruluş tarihlerini doğru şekilde ayırt eder.', 'D-8 aslında 1997''de kurulmuştur, 1985 yılı D-8''e değil Ekonomik İşbirliği Teşkilatı''nın (EİT/ECO) kuruluşuna aittir; bu nedenle bu eşleştirme yanlıştır. Diğer seçeneklerdeki BM (1945), NATO (1949), Avrupa Konseyi (1949) ve EİT (1985) eşleştirmeleri doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('D-8 – 1985', true, 0),
  ('Birleşmiş Milletler – 1945', false, 4),
  ('NATO – 1949', false, 3),
  ('Avrupa Konseyi – 1949', false, 2),
  ('Ekonomik İşbirliği Teşkilatı (EİT) – 1985', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_onlisans' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?', 'Uluslararası kuruluşların kuruluş tarihlerini doğru şekilde ayırt eder.', 'D-8 aslında 1997''de kurulmuştur, 1985 yılı D-8''e değil Ekonomik İşbirliği Teşkilatı''nın (EİT/ECO) kuruluşuna aittir; bu nedenle bu eşleştirme yanlıştır. Diğer seçeneklerdeki BM (1945), NATO (1949), Avrupa Konseyi (1949) ve EİT (1985) eşleştirmeleri doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('D-8 – 1985', true, 0),
  ('Birleşmiş Milletler – 1945', false, 4),
  ('NATO – 1949', false, 3),
  ('Avrupa Konseyi – 1949', false, 2),
  ('Ekonomik İşbirliği Teşkilatı (EİT) – 1985', false, 1)
) as v(choice_text, is_correct, order_index);

with target_topic as (
  select (select t.id from topics t join subjects s on s.id = t.subject_id where s.exam_type = 'kpss_ortaogretim' and s.name = 'Vatandaşlık' and t.name = 'Uluslararası Kuruluşlar' limit 1) as id
),
new_q as (
  insert into questions (topic_id, difficulty, question_text, kazanim, explanation)
  select tt.id, 'zor'::difficulty_level, 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?', 'Uluslararası kuruluşların kuruluş tarihlerini doğru şekilde ayırt eder.', 'D-8 aslında 1997''de kurulmuştur, 1985 yılı D-8''e değil Ekonomik İşbirliği Teşkilatı''nın (EİT/ECO) kuruluşuna aittir; bu nedenle bu eşleştirme yanlıştır. Diğer seçeneklerdeki BM (1945), NATO (1949), Avrupa Konseyi (1949) ve EİT (1985) eşleştirmeleri doğrudur.'
  from target_topic tt
  where tt.id is not null
    and not exists (
      select 1 from questions q2 where q2.topic_id = tt.id and q2.question_text = 'Aşağıdaki kuruluş - kuruluş yılı eşleştirmelerinden hangisi YANLIŞTIR?'
    )
  returning id
)
insert into question_choices (question_id, choice_text, is_correct, order_index)
select new_q.id, v.choice_text, v.is_correct, v.order_index
from new_q, (values
  ('D-8 – 1985', true, 0),
  ('Birleşmiş Milletler – 1945', false, 4),
  ('NATO – 1949', false, 3),
  ('Avrupa Konseyi – 1949', false, 2),
  ('Ekonomik İşbirliği Teşkilatı (EİT) – 1985', false, 1)
) as v(choice_text, is_correct, order_index);
