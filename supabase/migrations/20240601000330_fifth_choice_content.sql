-- Mevcut soru bankasındaki sorular gerçek KPSS formatından farklı olarak
-- 4 şıkla (A-D) girilmişti; gerçek KPSS sınavı her zaman 5 şıklıdır (A-E).
-- Bu migration, şu an tam olarak 4 şıkkı olan her soruya -- konusuyla tutarlı,
-- kesinlikle yanlış -- 5. bir çeldirici ekler. question_text + doğru şık metni
-- eşleşmesiyle hedefleniyor (id ile değil): böylece aynı içeriğin kpss_onlisans/
-- kpss_ortaogretim için 20240601000170'te oluşturulan kopyaları ve ileride
-- 20240601000300'deki dinamik konu-kopyalama mantığıyla oluşabilecek kopyalar
-- da otomatik olarak kapsanır -- id'leri production veritabanında farklı olsa bile.
-- order_index, mevcut en yüksek order_index + 1 olarak dinamik hesaplanır (bazı
-- eski satırlar 0-3, bazıları 1-4 kullanıyor). Sorgu yalnızca ŞU AN tam 4 şıkkı
-- olan sorulara dokunduğu için migration idempotent'tir (tekrar çalıştırılsa da
-- ikinci kez eklemez).

begin;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'arkadaşlar', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki kelimelerden hangisi büyük ünlü uyumuna (kalınlık-incelik uyumuna) aykırıdır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'kalemlik'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'yataktan', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki kelimelerin hangisinde ünsüz yumuşaması (p, ç, t, k seslerinin yumuşaması) görülür?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'ağacı'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Akşam olunca herkes evine döndü.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde ünlü düşmesi (hece düşmesi) örneği vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Burnu kanayan çocuğu hemen hastaneye götürdüler.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'bahçede', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki kelimelerin hangisinde kaynaştırma ünsüzü kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'kapıyı'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'kalem', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki kelimelerden hangisi küçük ünlü uyumuna (düzlük-yuvarlaklık uyumuna) aykırıdır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'doktor'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Masada duran kitabı hemen aldım.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde ''de'' bağlaç olarak kullanılmış, bu nedenle ayrı yazılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'O da bizimle gelmek istedi.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bendeki kitaplar çok eskiydi.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde ''ki'' bağlaç olarak kullanılmış ve bu nedenle ayrı yazılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Biliyordum ki bu iş kolay olmayacaktı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Ondaki değişikliği hemen fark ettim.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Yarın ki sınava çalışmalıyım.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Marmara Bölgesi''nde kış mevsimi çok yağışlı geçer.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde büyük harf kullanımıyla ilgili bir yanlışlık vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bu yıl İlkbahar çok erken geldi.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Herkez bu haberi duyunca çok şaşırdı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir yazım yanlışı yoktur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sen de mi bu işe karıştın?'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Öğrenci''nin çantası sırada unutulmuş.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ahmet''in kitabını dün akşam okudum.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Çarşıdan elma, armut ve muz, şeftali aldı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde virgül (,) doğru bir yerde kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Çarşıdan elma, armut, muz ve şeftali aldı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Sabah: erken kalkıp koşuya çıktım.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde iki nokta (:) doğru kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Kırtasiyeden şunları aldım: kalem, silgi, defter.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Sabah; erkenden kalkıp işe gittim.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde noktalı virgül (;) doğru kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sınıfta Ali, Veli, Ayşe; bahçede ise Mehmet, Fatma vardı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Ali''ye; İzmir''den gelen paketi; hemen verdim.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde noktalama işaretlerinin tamamı doğru kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Öğretmenimiz: ''Yarın sınav var.'' dedi.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bavul çok ağır olduğu için taşıyamadım.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde ''ağır'' sözcüğü mecaz anlamda kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sınav soruları oldukça ağırdı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'hızlı - yavaş', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki kelime çiftlerinden hangisi eş anlamlıdır (anlamdaştır)?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'kara - siyah'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Sınav sonuçları eli kulağında, aylar sonra açıklanacak.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''Eli kulağında'' deyimi aşağıdaki cümlelerin hangisinde doğru kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Proje eli kulağında, birkaç güne kadar tamamlanmış olacak.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yüzünü yıkayıp aynaya baktı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde ''yüz'' sözcüğü diğerlerinden farklı bir anlamda (sesteş olarak) kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Denizde saatlerce yüzdü.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Dişinin kökü iltihaplanmıştı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''Kök'' sözcüğü aşağıdaki cümlelerin hangisinde terim anlamda (dil bilgisi terimi olarak) kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bu kelimenin kökü Arapçadır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yazarın üslubu bence oldukça akıcıydı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisi nesnel bir yargı bildirmektedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Roman, 320 sayfadan oluşmaktadır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Çocuklar bahçede oyun oynadı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bu haber beni hem çok sevindirdi hem de mutlu etti.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Akşam yemeğini birlikte yediler.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Belki de bu sınavı kesinlikle kazanacak.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Hava soğuduğu için kalın bir mont giydi.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Param olmadığı için kitabı alamadım ama yine de aldım.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Çocuklar parkta koşarak oynadı.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ali ve babasının arabası kaza yaptı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kararların büyüklüğü, alınan sürenin uzunluğuna göre belirlenir.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''İnsanlar günlük hayatlarında birçok karar verir. Bu kararların bazıları küçük, bazıları ise hayatı derinden etkileyecek kadar büyüktür. Küçük kararlar genellikle anlık düşünülüp hızla alınırken büyük kararlar için uzun süre düşünülür, çevredeki insanların fikirleri alınır. Çünkü büyük kararların sonuçları, kişinin hayatını uzun yıllar etkileyebilir.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Büyük kararlar, sonuçlarının kalıcı etkisi nedeniyle daha dikkatli ve uzun düşünülerek alınmalıdır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'yalnızca çocuklar kitap okumalıdır.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''Kitap okumak, insanın hayal gücünü geliştirir, kelime dağarcığını zenginleştirir ve empati kurma becerisini artırır. Ayrıca düzenli kitap okuyan bireylerin analitik düşünme yetenekleri de gelişir. Bu nedenle ______'' Bu parçada boş bırakılan yere aşağıdakilerden hangisi getirilmelidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'çocuklara küçük yaştan itibaren kitap okuma alışkanlığı kazandırılmalıdır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Dikey ormanlar, betonlaşmanın tek çözümüdür.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''Şehirlerin hızla büyümesiyle birlikte yeşil alanlar giderek azalmaktadır. Betonlaşan kentlerde hava kalitesi düşmekte, sıcaklık artışları daha belirgin hissedilmektedir. Bununla birlikte bazı belediyeler, çatı bahçeleri ve dikey ormanlar gibi projelerle bu soruna çözüm aramaktadır. Ancak bu çabalar, kaybedilen yeşil alanların yerini tam olarak dolduramamaktadır.'' Bu parçanın ana düşüncesi aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Kentleşmeyle azalan yeşil alanların yerini, alınan önlemler yeterince dolduramamaktadır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bilim kurgu romanları, gerçek bilimsel verilere dayanır.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''______ Bu tür kitaplar, karmaşık bilimsel kavramları sade bir dille anlatarak okurun ilgisini çeker. Yazar, günlük hayattan örnekler kullanarak konuyu somutlaştırır. Böylece bilim, sadece uzmanların değil herkesin anlayabileceği bir alan hâline gelir.'' Bu parçanın başına aşağıdaki cümlelerden hangisi getirilmelidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Popüler bilim kitapları, bilimi geniş kitlelere ulaştırmayı amaçlayan eserlerdir.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bir eserin izleyici üzerindeki etkisi, teknik kusursuzluktan bağımsız olabilir.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '''Bir sanat eserinin değeri, yalnızca teknik ustalıkla ölçülemez. Tuval üzerine ustaca işlenmiş bir tablo, izleyicide hiçbir duygu uyandırmıyorsa amacına ulaşamamış demektir. Oysa bazen çok basit çizgilerle oluşturulmuş bir eser, izleyicisini derinden etkileyebilir, onu düşünmeye sevk edebilir. Bu nedenle sanatı değerlendirirken teknik beceri kadar, eserin izleyicide bıraktığı etkiye de bakmak gerekir.'' Bu parçadan aşağıdaki yargılardan hangisine ulaşılamaz?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sanat eserlerinin değeri, yalnızca sanatçının ününe göre belirlenir.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '6', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '12 + 3 × 4 − 6 işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '18'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '8', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '-5, -8, -3, 2 tam sayılarından hangisi en küçüktür?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '-8'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '-90', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '(−3) × (4 − 7) + (−2) × 5 işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '-1'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '8', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir sayının 3 fazlasının 2 katı, aynı sayının 5 eksiğinin 3 katına eşittir. Bu sayı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '21'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '31', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Ali''nin yaşının 2 katının 5 fazlası, Ayşe''nin yaşının 3 katının 7 eksiğine eşittir. Ayşe 20 yaşında olduğuna göre Ali kaç yaşındadır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '24'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '343', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki sayılardan hangisi 9 ile tam bölünür? 342, 245, 368, 451'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '342'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '2134', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki sayılardan hangisi 4 ile tam bölünür? 1234, 1416, 2350, 3115'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '1416'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '192', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '48 ve 60 sayılarının EBOB''u kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '12'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '16', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir sayı hem 6 hem de 8 ile tam bölünmektedir. Bu sayı en az kaç olabilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '24'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '5', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'EBOB''u 8, EKOK''u 240 olan iki sayıdan biri 40 olduğuna göre diğer sayı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '48'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '400', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '347 sayısında 4 rakamının basamak değeri kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '40'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '19', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '2856 sayısının rakamları toplamı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '21'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '1097', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Üç basamaklı en büyük tek sayı ile üç basamaklı en küçük çift sayının toplamı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '1099'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '80', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Rakamları farklı olan iki basamaklı en büyük sayı ile rakamları farklı olan iki basamaklı en küçük sayının farkı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '88'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '39', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'İki basamaklı bir sayının rakamları toplamı 12''dir. Bu sayının rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 18 fazla olduğuna göre ilk sayı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '57'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '7.5', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '3/4 kesrinin ondalık gösterimi nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '0.75'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '2/25', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '2/5 + 1/5 işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '3/5'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '2/3 < 1/2 < 3/5', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1/2, 3/5, 2/3 kesirlerinin küçükten büyüğe doğru sıralanışı hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '1/2 < 3/5 < 2/3'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '3/50', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '0,6 ondalık sayısının kesir olarak en sade hali nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '3/5'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '29/30', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '(2/3 + 1/6) ÷ (5/9) işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '3/2'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '500', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '250''nin %20''si kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '50'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '22%', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir tüccar 80 TL''ye aldığı malı 100 TL''ye satıyor. Kâr yüzdesi kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '25%'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '24', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir babanın yaşı, oğlunun yaşının 3 katından 5 fazladır. Baba ile oğlunun yaşları toplamı 53 olduğuna göre oğlunun yaşı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '12'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '12', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir havuzu tek başına A musluğu 6 saatte, B musluğu 12 saatte dolduruyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '4'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '24', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'İki şehir arası uzaklık 360 km''dir. Bir araç A şehrinden B şehrine 90 km/sa hızla, başka bir araç aynı anda B şehrinden A şehrine 60 km/sa hızla hareket ediyor. Bu iki araç kaç saat sonra karşılaşır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '2.4'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Karahanlı Devleti', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Mete Han döneminde en güçlü dönemini yaşayan ve bilinen ilk teşkilatlı Türk devleti kabul edilen devlet aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Asya Hun Devleti'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'İstemi Yabgu', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Türk" adını taşıyan ilk devlet olan Göktürk Devleti''ni 552 yılında kim kurmuştur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bumin Kağan'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Karluk Devleti', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Yerleşik hayata geçen, Mani dinini benimseyen ve kağıt-matbaayı kullanan ilk Türk devleti aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Uygur Devleti'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Karahanlı Devleti', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bilge Kağan, Kül Tigin ve Vezir Tonyukuk adına dikilen, Türk adının geçtiği ilk yazılı belgeler olan Orhun Yazıtları hangi Türk devletine aittir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Göktürk Devleti'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Türgiş Kağanlığı''nın Orta Asya''da hakimiyet kurması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '375 yılında başlayan ve Roma İmparatorluğu''nun ikiye ayrılmasına, ardından Batı Roma''nın yıkılmasına zemin hazırlayan Kavimler Göçü''nün temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Asya Hun Devleti''nin zayıflaması sonucu Hunların batıya doğru ilerlemesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Ertuğrul Gazi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Osmanlı Devleti''nin kuruluş tarihi olarak kabul edilen 1299 yılında beyliği kuran kişi kimdir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Osman Bey'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Süleyman Paşa', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bursa''nın fethedilerek başkent yapıldığı, ilk düzenli ordu (Yaya-Müsellem) ve ilk medresenin (İznik) kurulduğu dönem hangi padişaha aittir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Orhan Bey'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Çaldıran Savaşı', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Yıldırım Bayezid''in Timur''a yenilerek esir düştüğü ve Anadolu Türk siyasi birliğinin bozulmasına yol açan savaş aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ankara Savaşı'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Niğbolu Savaşı''nın kazanılması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi I. Murad (Hüdavendigar) döneminde gerçekleşen gelişmelerden biridir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Yeniçeri Ocağı''nın kurulması ve Edirne''nin başkent yapılması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Musa Çelebi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Fetret Devri''ni sona erdirerek Osmanlı siyasi birliğini yeniden sağlayan ve bu nedenle "ikinci kurucu" olarak da anılan padişah kimdir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Çelebi Mehmed (I. Mehmed)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '15 Mayıs 1919', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '19 Mayıs 1919'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '10 Ağustos 1920', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '23 Nisan 1920'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Havza Genelgesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Amasya Genelgesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kütahya-Eskişehir Muharebeleri', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sakarya Meydan Muharebesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Erzurum, Sivas, Trabzon', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Antep, Maraş, Urfa'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '20 Nisan 1924', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye Cumhuriyeti hangi tarihte ilan edilmiştir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '29 Ekim 1923'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '24 Temmuz 1923', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Osmanlı hanedanının siyasi yetkisinin sona erdirildiği saltanatın kaldırılması hangi tarihte gerçekleşmiştir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '1 Kasım 1922'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '20 Nisan', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Halifeliğin kaldırılması ile eğitimde birliği sağlayan Tevhid-i Tedrisat Kanunu''nun kabulü, 1924 yılında hangi tarihte aynı gün gerçekleşmiştir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '3 Mart'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '1923', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türk kadınına milletvekili seçme ve seçilme hakkının tanındığı yıl aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '1934'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Tevhid-i Tedrisat Kanunu (1924)', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki inkılaplardan hangisi kronolojik olarak diğerlerinden daha sonra gerçekleşmiştir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Soyadı Kanunu (1934)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Göreceli konum', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''nin üç tarafının denizlerle çevrili olması, aşağıdaki konum türlerinden hangisine örnektir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Özel konum'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yıl içinde gündüzlerin geceden uzun sürebilmesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Türkiye''nin matematik konumunun bir sonucu değildir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Farklı kıtalar arasında transit ticaret yapılması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Türkiye''nin tüm illerinde yerel saatin birbirinin tamamen aynı olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye, boylamlar üzerinde doğuda Iğdır''dan batıda Gökçeada''ya kadar yaklaşık 19 derecelik bir açı genişliğine sahiptir. Bu durumun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Doğudaki iller, batıdaki illere göre güneşi daha erken karşılar'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kars', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''nin en doğu noktası aşağıdaki illerden hangisinde yer alır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Iğdır'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Türkiye''nin ortalama yükseltisinin fazla olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de saatler ülke genelinde tek bir resmi saat dilimine göre ayarlanmasına rağmen, Karadeniz kıyısında güneş henüz doğarken Doğu Anadolu''nun doğu kesiminde güneş çoktan doğmuş ve gökyüzünde belirgin biçimde yükselmiş olabilir. Bu durumun temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Türkiye''nin farklı boylamlar üzerinde geniş bir alana yayılmış olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Step (bozkır) iklimi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Yazların sıcak ve kurak, kışların ise ılık ve yağışlı geçtiği iklim tipi aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Akdeniz iklimi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Marmara Bölgesi kıyıları', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de her mevsim yağış alan ve yıllık yağış miktarı en fazla olan iklim tipi aşağıdaki bölgelerin hangisinde görülür?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Karadeniz Bölgesi kıyıları'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Rüzgarların yıl boyunca hep aynı yönden esmesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de kıyı kesimlerinden iç kesimlere gidildikçe iklimin kısa mesafede belirgin biçimde değişmesinin temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Dağların kıyıya paralel uzanarak deniz etkisinin iç kesimlere sokulmasını engellemesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Trabzon', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki illerden hangisinde yaz ile kış arasındaki sıcaklık farkının en fazla olması beklenir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Erzurum'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Rize''nin daha güney, Erzurum''un daha kuzey enlemlerinde yer alması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Enlemleri birbirine yakın olmasına karşın Rize ile Erzurum arasında kış sıcaklıkları bakımından büyük fark bulunmasının temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Rize''nin denize kıyısının olması, Erzurum''un ise yüksek ve karasal bir konumda bulunması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Çarşamba Ovası', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Türkiye''de nüfusun seyrek olduğu alanlara örnektir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Doğu Anadolu''nun yüksek platoları'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Oba', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi kırsal yerleşme tiplerinden biri değildir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Metropol'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bitki örtüsü', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Türkiye''de nüfus dağılışını etkileyen beşeri (insan kaynaklı) faktörlerden biridir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sanayileşme ve ekonomik faaliyetler'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bölgede nüfusun çok az olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Karadeniz Bölgesi''nin kırsal kesimlerinde evlerin genellikle birbirinden uzak ve dağınık şekilde kurulmasının temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bölgenin engebeli olması nedeniyle her ailenin kendi arazisine ve su kaynağına yakın yerleşmesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bölgenin çok engebeli bir yer şekline sahip olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Kurak bir iklim bölgesinde, su kaynaklarının sınırlı sayıda kaynak veya kuyu etrafında toplandığı bir yerleşim alanında evlerin sık ve bir arada (toplu) kurulmuş olması aşağıdakilerden hangisiyle açıklanabilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sınırlı su kaynağının ortak kullanılması ve güvenlik ihtiyacının yerleşmeyi bir arada tutması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Uyulmaması halinde yalnızca manevi bir kınamayla karşılaşılması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Hukuk kurallarını diğer toplumsal düzen kurallarından (ahlak, din, görgü) ayıran en temel özellik nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Devlet gücüyle desteklenen yaptırıma sahip olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yokluk (muamelenin hiç doğmamış sayılması)', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi hukuk kurallarının yaptırım türlerinden biri değildir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Vicdan azabı'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'İptal edilebilirlik (muamelenin geçersiz kılınabilmesi)', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir sözleşmenin kanunda öngörülen şekil şartına uyulmadan yapılması durumunda ortaya çıkan yaptırım türü aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'İptal edilebilirlik/Butlan (hükümsüzlük)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Cumhurbaşkanlığı kararnamesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Hukukun yazılı asli kaynakları arasında aşağıdakilerden hangisi yer almaz?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Örf ve adet hukuku'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Hak ve görev kavramları birbirinin tam zıttıdır ve aynı hukuki ilişkide bir arada bulunamaz', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Hak" ve "görev" kavramları arasındaki ilişki açısından aşağıdaki ifadelerden hangisi doğrudur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bir kişinin sahip olduğu hak, genellikle başka bir kişi için buna karşılık gelen bir görev/yükümlülük doğurur'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Teokrasi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1982 Anayasası''na göre Türkiye Devleti''nin şekli nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Cumhuriyet'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Demokratik devlet', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi 1982 Anayasası''nda Cumhuriyetin nitelikleri arasında sayılan temel ilkelerden biri değildir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Tek parti yönetimi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Başlangıç kısmı, Anayasa değişikliği usulüne tabi olmaksızın TBMM İçtüzüğü ile değiştirilebilir', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1982 Anayasası''nın Başlangıç kısmı hakkında aşağıdakilerden hangisi doğrudur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Başlangıç kısmı, Anayasa''nın ayrılmaz bir parçasını oluşturur ve Anayasa metnine dahildir'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Temel hak ve özgürlüklerin sınırlandırılma usulünü', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Anayasa''da yer alan "değiştirilemez ve değiştirilmesi teklif dahi edilemez" hükümler esas olarak neyi korumayı amaçlar?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Devletin temel niteliklerini (Cumhuriyet, devletin şekli, temel unsurları)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bu hükümler uluslararası bir antlaşma hükmüyle değiştirilebilir', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1982 Anayasası''nın "değiştirilemeyecek hükümler" ile ilgili düzenlemesi hakkında aşağıdakilerden hangisi doğrudur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Bu hükümlerin sadece değiştirilmesi değil, değiştirilmesinin teklif edilmesi dahi yasaktır'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Anayasa Mahkemesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de yasama yetkisi hangi organa aittir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Türkiye Büyük Millet Meclisi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kamu politikalarını belirlemek', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi yargı organının temel işlevidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Uyuşmazlıkları bağımsız ve tarafsız biçimde çözüme kavuşturmak'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Cumhurbaşkanı Yardımcısına', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Cumhurbaşkanlığı Hükümet Sistemi''nde yürütme yetkisi kime aittir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Cumhurbaşkanına'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Hâkimler ve Savcılar Kurulu (HSK)', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Türkiye''deki yüksek yargı organlarından biridir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Danıştay'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kuvvetler ayrılığı, yürütme organının yasama organını her zaman feshedebileceği anlamına gelir', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Kuvvetler ayrılığı ilkesi bağlamında yasama, yürütme ve yargı organlarının birbirleriyle ilişkisi hakkında aşağıdakilerden hangisi doğrudur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Kuvvetler ayrılığı, güç yoğunlaşmasını önlemek amacıyla organlar arasında yetki paylaşımı ve karşılıklı denetim mekanizmaları öngörür'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'okuyor', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Gitti + i" birleşiminde olduğu gibi düz-dar bir ünlüyle biten fiil kök/gövdesine "-yor" eki geldiğinde hangi ses olayı görülür?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'bekliyor'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Büyük ünlü uyumu', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Kitap+cı" birleşiminde görüldüğü gibi, sert ünsüzle biten bir kelimeye yumuşak ünsüzle başlayan bir ek geldiğinde ekin ünsüzünün sertleşmesine ne ad verilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ünsüz benzeşmesi (sertleşme)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bu yaz İzmir''e tatile gideceğiz.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde büyük harflerin kullanımıyla ilgili bir yazım yanlışı vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Okullar Mayıs ayında tatile girecek.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bunu da düşünmemiz gerekiyor.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"de/da" bağlacının yazımıyla ilgili aşağıdaki cümlelerin hangisinde bir yazım yanlışı yapılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ali de bize katıldı ama o da geç kaldı.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Fenerbahçe''nin maçı bu akşam oynanacak.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdaki cümlelerin hangisinde kesme işareti ('') doğru kullanılmamıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Okul''un bahçesi çok güzeldi.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '- " ... "', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Kardeşim  gel buraya  dedi." cümlesinde boş bırakılan yerlere sırasıyla hangi noktalama işaretleri gelmelidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = ': " ... ."'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Argo anlam', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Yüreği dağ gibi" ifadesindeki "dağ" sözcüğü hangi anlamda kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Mecaz anlam'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Deyim anlamı', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Bu kumaşın ''eli'' çok yumuşak." cümlesindeki altı çizili sözcük hangi anlam ilişkisiyle kullanılmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Yan anlam'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Zaman cümlesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Yağmur yağarsa pikniğe gitmeyeceğiz." cümlesi anlamca hangi tür bir cümledir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Koşul (şart) cümlesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Benzerlik ilişkisi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Herkes onun başarılı olacağını biliyordu, o da bunu biliyordu ama yine de denemekten korkuyordu." cümlesinde hangi anlam ilişkisi vardır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Karşıtlık ilişkisi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Konuyu ayrıntılarıyla açıklayarak sonuçlandırır.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir paragrafın giriş cümlesi genellikle hangi özelliği taşır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Paragrafın konusunu tanıtır ve tek başına anlaşılır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'İlk cümleden hemen sonraki cümle', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '"Bu görüşe katılmıyorum. Çünkü..." ifadesiyle başlayan bir paragraf parçası, paragrafın hangi bölümünde yer alamaz?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Giriş (ilk cümle)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '30', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '18 − (6 − 2) × 3 işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '6'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '13', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir sayının 4 katının 7 fazlası, aynı sayının 2 katının 19 fazlasına eşittir. Bu sayı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '6'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '6', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '648 sayısı aşağıdaki sayılardan hangisine tam bölünmez?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '5'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '20', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '48 ile 60 sayılarının OBEB''i (en büyük ortak böleni) kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '12'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '4', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Üç basamaklı "7a5" sayısı 9''a tam bölünebildiğine göre a rakamı kaç olabilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '6'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '83', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'İki basamaklı bir sayının rakamları toplamı 11''dir. Rakamları yer değiştirdiğinde elde edilen sayı, ilk sayıdan 45 fazladır. Buna göre ilk sayı kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '38'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '5/12', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '3/4 + 1/6 işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '11/12'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '10/9', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '(2/3) ÷ (4/9) işleminin sonucu kaçtır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '3/2'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '2,5 saat', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir havuzu bir musluk tek başına 6 saatte, başka bir musluk tek başına 3 saatte doldurabiliyor. İki musluk birlikte açılırsa havuz kaç saatte dolar?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '2 saat'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '23', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Ali''nin yaşı, kardeşinin yaşının 2 katından 3 fazladır. İki kardeşin yaşları toplamı 30 olduğuna göre Ali kaç yaşındadır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '21'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Sadece yabancı elçilerin kabul edildiği yer olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'İlk Türk devletlerinde "kurultay" adı verilen meclisin temel işlevi nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Devlet işlerinin görüşülüp karara bağlandığı meclis olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Uygur alfabesiyle yazılmış olmaları', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Orhun Abideleri (Göktürk Kitabeleri) tarih açısından neden önemlidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Türk adının geçtiği bilinen ilk yazılı Türkçe metinler olmaları'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Fetihlerde ele geçirilen ganimetleri paylaştırmak', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Osmanlı Devleti''nde "İskân Politikası" hangi amaçla uygulanmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Fethedilen bölgeleri Türkleştirmek ve otoriteyi kalıcı kılmak'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Bulgar Krallığı''nın Osmanlı egemenliğine girmesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'I. Kosova Savaşı''nın (1389) sonuçlarından biri aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Sırbistan''ın Osmanlı''ya bağlı bir devlet hâline gelmesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kafkas Cephesi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Kurtuluş Savaşı''nda "Kongreler Dönemi" hangi cepheyle ilgilidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Siyasi cephe (örgütlenme süreci)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Mudanya Ateşkes Antlaşması''nın imzalanması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Sakarya Meydan Muharebesi''nin en önemli sonucu aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Savaşın gidişatının Türk lehine dönmesi ve Mustafa Kemal''e Mareşallik unvanının verilmesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Aşar vergisinin kaldırılması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Atatürk''ün "halkçılık" ilkesiyle doğrudan ilişkilidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Saltanatın kaldırılarak egemenliğin millete verilmesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kadınlara seçme ve seçilme hakkının tanınması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1926''da kabul edilen Türk Medeni Kanunu ile aşağıdakilerden hangisi sağlanmıştır?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Kadın-erkek eşitliğinin hukuki güvenceye kavuşturulması ve tek eşliliğin getirilmesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yerel saat farkının yalnızca kış aylarında ortaya çıkması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''nin matematik konumunun bir sonucu olarak aşağıdakilerden hangisi söylenebilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Doğuda güneş daha erken doğar, batıda daha geç doğar.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Dört mevsimin belirgin biçimde yaşanması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Aşağıdakilerden hangisi Türkiye''nin özel (coğrafi) konumunun sonuçlarından biridir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Önemli boğazlara sahip olması nedeniyle transit ticarette avantajlı olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yaz ve kış sıcaklıkları arasındaki farkın çok fazla olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Karadeniz Bölgesi''nde görülen iklim tipinin en belirgin özelliği nedir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Her mevsim yağışlı olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yükseltisinin çok düşük olması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'İç Anadolu Bölgesi''nde karasal iklimin görülmesinin temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Denizden uzak ve dağlarla çevrili bir konumda bulunması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Kıyı kesimlerde su kaynaklarının bulunmaması', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de nüfusun kıyı bölgelerde iç kesimlere göre daha yoğun olmasının temel nedeni aşağıdakilerden hangisidir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'İklim ve ekonomik imkânların daha elverişli olması'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yalnızca tarımsal nüfusu artırır.', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir bölgede engebeli arazi yapısı, nüfus yoğunluğunu genellikle nasıl etkiler?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Nüfus yoğunluğunu azaltır.'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yönetmelik', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Yazılı olmayan, toplumda uzun süre uygulanarak yerleşmiş kurallara ne ad verilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Örf ve adet hukuku'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'İçtihat', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir hukuk kuralına uyulmadığında devlet gücüyle uygulanan yaptırıma ne ad verilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Yaptırım (müeyyide)'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Yürütme organına', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = '1982 Anayasası''na göre egemenlik kayıtsız şartsız kime aittir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Türk Milletine'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Üye tam sayısının en az beşte biri', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Anayasa değişikliği teklifi TBMM''de en az kaç üyenin yazılı teklifiyle yapılabilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Üye tam sayısının en az üçte biri'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Danışma', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye Büyük Millet Meclisi (TBMM) devletin hangi temel organını oluşturur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Yasama'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Hâkimlerin verdiği kararların TBMM tarafından denetlenmesi gerekliliği', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Türkiye''de yargı bağımsızlığı ilkesi temel olarak neyi ifade eder?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Mahkemelerin hiçbir etki altında kalmadan bağımsız karar vermesi'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

commit;
-- 20240601000100_seed_data.sql'deki "select ... from topics t join subjects s"
-- kalıbıyla eklenen 3 örnek soru, farklı bir insert biçimi kullandığı için
-- yukarıdaki otomatik ayrıştırmaya dahil edilmemişti; aynı question_text +
-- doğru şık eşleştirme mantığıyla elle ekleniyor.
begin;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '40', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Yaşları toplamı 45 olan bir baba ile oğlunun 5 yıl önceki yaşları toplamı 35 ise, babanın şu anki yaşı kaçtır? (Baba oğuldan 25 yaş büyüktür.)'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '35'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, '640 TL', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir malın alış fiyatı 500 TL''dir. %20 kârla satılırsa satış fiyatı kaç TL olur?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = '600 TL'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

insert into question_choices (question_id, choice_text, is_correct, order_index)
select q.id, 'Anlatım biçimi', false,
  coalesce((select max(qc.order_index) from question_choices qc where qc.question_id = q.id), -1) + 1
from questions q
where q.question_text = 'Bir paragrafta yazarın asıl anlatmak istediği düşünceye ne ad verilir?'
  and exists (
    select 1 from question_choices cc
    where cc.question_id = q.id and cc.is_correct = true and cc.choice_text = 'Ana düşünce'
  )
  and (select count(*) from question_choices qc2 where qc2.question_id = q.id) = 4;

commit;
