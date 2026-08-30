-- AI Asistanı'nı ikinci kez genişletir. Kullanıcı gerçek bir LLM'e bağlanmak
-- yerine ("API anahtarı gerekmez") kural tabanlı motorun GENİŞLETİLMESİNİ
-- seçti. Bu migration üç şeyi hedefler:
--
-- 1) BELİRLİ KALIPLARDAN ÇIKMA: önceki sürüm yalnızca konu/ders ADLARI için
--    yazım hatası toleranslı (trigram) eşleşme yapıyordu; niyet anahtar
--    kelimeleri (ör. "motivasyon", "başarı") hâlâ birebir `like` ile
--    aranıyordu, yani "motivasyn", "motivasyona ihtyacm var" gibi yazım
--    hatalarında hiçbir niyete düşmüyordu. Şimdi mesajdaki her kelime,
--    bilinen niyet anahtar kelimeleriyle trigram benzerliğine göre
--    karşılaştırılıyor ve yeterince benzeyen bir kelime bulunursa mesaj o
--    anahtar kelimeyle ZENGİNLEŞTİRİLİYOR — böylece aşağıdaki `like` tabanlı
--    dallar hâlâ çalışıyor ama artık yazım hatalarına karşı da dayanıklı.
--
-- 2) SABİT YANIT METİNLERİNİN ÇEŞİTLENDİRİLMESİ: en sık tetiklenen niyetler
--    (selamlaşma, teşekkür, motivasyon, yardım, varsayılan yanıt) artık tek
--    bir sabit cümle yerine birkaç varyanttan birini döndürüyor
--    (pick_ai_variant()), seçim kullanıcı+gün bazında kararlı (aynı gün aynı
--    kullanıcıya aynı varyant döner, ertesi gün değişebilir) — rastgele
--    ama tutarsız/kekeleyen bir his vermez.
--
-- 3) YENİ NİYETLER: haftalık özet, ders bazında en zayıf olduğun ders
--    (konu değil), kaç konu "iyi" seviyeye ulaştı, güne göre çalışma saati
--    tavsiyesi, ve rastgele/ilginç bilgi (zayıf bir konudan kısa bir özet).
--
-- Önceki 15 niyetin TAMAMI korunur, davranışları değişmez (yalnızca metin
-- varyantları eklenir); yeni niyetler mevcutlarla çakışmayacak şekilde
-- ayrı anahtar kelimelerle eklenir.

begin;

-- ============ pick_ai_variant: kararlı-ama-çeşitli metin seçimi ============
create or replace function public.pick_ai_variant(p_variants text[], p_seed text)
returns text
language sql
immutable
as $$
  select p_variants[1 + (abs(hashtext(coalesce(p_seed, ''))) % greatest(array_length(p_variants, 1), 1))];
$$;

grant execute on function public.pick_ai_variant(text[], text) to authenticated;

-- ============ ai_assistant_ask v2 ============
create or replace function public.ai_assistant_ask(p_message text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
  v_uid uuid := auth.uid();
  v_msg text := normalize_tr(p_message);
  v_seed text;
  v_name text;
  v_topic record;
  v_subject record;
  v_mistake record;
  v_mistake_count int;
  v_weak_topic_name text; v_weak_subject_name text;
  v_strong_topic_name text;
  v_exam_type exam_type;
  v_exam_days int; v_exam_name text;
  v_response text;
  v_success numeric; v_total_answers int;
  v_streak int; v_xp int; v_level int;
  v_today_total int; v_today_done int;
  v_today_questions int;
  v_news_title text;
  v_week_total int; v_week_correct int; v_week_success numeric;
  v_weakest_subject_name text; v_weakest_subject_score numeric;
  v_topics_mastered int; v_topics_total int;
  v_hour int;
  v_fact_topic_name text; v_fact_summary text;
  -- niyet anahtar-kelime zenginleştirme
  v_kw record;
  v_word text;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select p.full_name, s.exam_type into v_name, v_exam_type
  from profiles p join students s on s.user_id = p.id where p.id = v_uid;

  v_seed := coalesce(v_uid::text, '') || current_date::text;

  -- ============ 0) Yazım hatası toleranslı NİYET zenginleştirme ============
  -- Aşağıdaki dallar hâlâ basit `like` araması yapıyor; burada mesajdaki her
  -- kelimeyi bilinen niyet anahtar kelimeleriyle trigram benzerliğine göre
  -- karşılaştırıp, yeterince benzeyenleri mesaja EKLİYORUZ. Böylece "motivasyn",
  -- "sinaava kac gun kaldi", "basari oranm" gibi yazım hataları da doğru dala düşer.
  for v_kw in
    select unnest(array[
      'yanlis','hata','bugun','plan','program','sinav','tarih','basari','performans',
      'oran','dogru','seviye','streak','motivasyon','tavsiye','ipucu','verimli',
      'haber','duyuru','guclu','yardim','merhaba','tesekkur','hafta','tamamla',
      'saat','bilgi','moral'
    ]) as kw
  loop
    if v_msg not like '%' || v_kw.kw || '%' then
      for v_word in select unnest(string_to_array(v_msg, ' ')) loop
        if length(v_word) >= 4 and similarity(v_word, v_kw.kw) > 0.5 then
          v_msg := v_msg || ' ' || v_kw.kw;
          exit;
        end if;
      end loop;
    end if;
  end loop;

  -- ============ 1) Belirli bir KONU'dan bahsediliyor mu? (iki yönlü, normalize edilmiş eşleşme) ============
  select t.id, t.name, tp.knowledge_score, s.name as subject_name into v_topic
  from topics t
  left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
  join subjects s on s.id = t.subject_id
  where s.exam_type = v_exam_type
    and not exists (select 1 from topics c where c.parent_id = t.id)
    and t.status = 'active'
    and (v_msg like '%' || normalize_tr(t.name) || '%' or normalize_tr(t.name) like '%' || v_msg || '%')
    and length(normalize_tr(t.name)) > 2
  order by length(normalize_tr(t.name)) desc
  limit 1;

  -- ============ 2) Belirli bir DERS'ten mi bahsediliyor? ============
  if v_topic.id is null then
    select s.id, s.name into v_subject
    from subjects s
    where s.exam_type = v_exam_type
      and (v_msg like '%' || normalize_tr(s.name) || '%' or normalize_tr(s.name) like '%' || v_msg || '%')
      and length(normalize_tr(s.name)) > 2
    order by length(normalize_tr(s.name)) desc
    limit 1;
  end if;

  -- ============ 1b/2b) Bulanık (yazım hatası toleranslı) eşleşme ============
  if v_topic.id is null and v_subject.id is null then
    select t.id, t.name, tp.knowledge_score, s.name as subject_name into v_topic
    from topics t
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    join subjects s on s.id = t.subject_id
    cross join lateral unnest(string_to_array(v_msg, ' ')) as w(word)
    where s.exam_type = v_exam_type
      and not exists (select 1 from topics c where c.parent_id = t.id)
      and t.status = 'active'
      and length(w.word) >= 4
      and similarity(normalize_tr(t.name), w.word) > 0.4
    order by similarity(normalize_tr(t.name), w.word) desc
    limit 1;

    if v_topic.id is null then
      select s.id, s.name into v_subject
      from subjects s
      cross join lateral unnest(string_to_array(v_msg, ' ')) as w(word)
      where s.exam_type = v_exam_type
        and length(w.word) >= 4
        and similarity(normalize_tr(s.name), w.word) > 0.4
      order by similarity(normalize_tr(s.name), w.word) desc
      limit 1;
    end if;
  end if;

  if v_topic.id is not null then
    if v_topic.knowledge_score is null or v_topic.knowledge_score < 40 then
      v_response := format('%s konusunda henüz güçlü değilsin (bilgi skoru: %%%s). Önce konu özetini ve örnek soruyu incele, sonra kolay seviyeden başlayarak soru çöz. İstersen "%s çalış" diyerek konuya gidebilirim.', v_topic.name, round(coalesce(v_topic.knowledge_score,0)), v_topic.name);
    elsif v_topic.knowledge_score < 70 then
      v_response := format('%s konusunda orta seviyedesin (bilgi skoru: %%%s). Yanlışlarını gözden geçirip orta zorlukta 15-20 soru çözmen iyi olur.', v_topic.name, round(v_topic.knowledge_score));
    else
      v_response := format('%s konusunda iyi durumdasın (bilgi skoru: %%%s). Bilgini pekiştirmek için zor sorularla ve zamanlı tekrarla devam et. 👏', v_topic.name, round(v_topic.knowledge_score));
    end if;

  elsif v_subject.id is not null then
    select t.name, tp.knowledge_score into v_weak_topic_name
    from topics t left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where t.subject_id = v_subject.id and t.status = 'active'
      and not exists (select 1 from topics c where c.parent_id = t.id)
    order by coalesce(tp.knowledge_score, -1) asc limit 1;

    select round(avg(coalesce(tp.knowledge_score,0)),1) into v_success
    from topics t left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where t.subject_id = v_subject.id and t.status = 'active'
      and not exists (select 1 from topics c where c.parent_id = t.id);

    if v_weak_topic_name is null then
      v_response := format('%s dersinde henüz veri yok, birkaç soru çözünce sana en zayıf konunu söyleyebilirim.', v_subject.name);
    else
      v_response := format('%s dersinde ortalama bilgi skorun %%%s. En çok "%s" konusuna zaman ayırmanı öneririm.', v_subject.name, coalesce(v_success,0), v_weak_topic_name);
    end if;

  -- ============ 3) Yanlışlar ============
  elsif v_msg like '%yanlis%' or v_msg like '%neden%' or v_msg like '%hata%' then
    select count(*) into v_mistake_count from mistakes where user_id = v_uid and resolved = false;
    select q.detailed_solution, q.question_text, t.name as topic_name into v_mistake
    from mistakes m join questions q on q.id = m.question_id join topics t on t.id = m.topic_id
    where m.user_id = v_uid order by m.created_at desc limit 1;

    if v_mistake.question_text is null then
      v_response := 'Henüz kayıtlı bir yanlışın yok — soru çözmeye başladığında burada analiz edebilirim.';
    else
      v_response := format('Son yanlışın "%s" konusundaydı. Açıklama: %s Şu anda çözülmemiş %s yanlışın var; "Yanlışlarım" sayfasından tek tek gözden geçirebilirsin.',
        v_mistake.topic_name, coalesce(v_mistake.detailed_solution, 'Detaylı çözüm henüz eklenmedi.'), coalesce(v_mistake_count,0));
    end if;

  -- ============ 4) Bugün / plan / ne çalışmalıyım ============
  elsif (v_msg like '%ne calis%' or v_msg like '%bugun%' or v_msg like '%plan%' or v_msg like '%program%')
    and v_msg not like '%kac soru%' and v_msg not like '%kac tane soru%'
    and v_msg not like '%hafta%' then
    select e.exam_date - current_date, e.name into v_exam_days, v_exam_name from exams e
    where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;

    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    select count(*) filter (where ss.status='done'), count(*) into v_today_done, v_today_total
    from study_plans sp join study_sessions ss on ss.study_plan_id = sp.id
    where sp.user_id = v_uid and sp.plan_date = current_date;

    if coalesce(v_today_total,0) > 0 then
      v_response := format('Bugünkü planında %s görevden %s tanesini tamamladın. Devam etmek için Ana Sayfa''daki "Bugünün Programı" listesine bak. İstersen oraya kendi görevini de ekleyebilirsin ("+ Görev Ekle").%s',
        v_today_total, coalesce(v_today_done,0),
        case when v_exam_days is not null then format(' Sınavına %s gün kaldı.', v_exam_days) else '' end);
    elsif v_weak_topic_name is null then
      v_response := 'Henüz yeterli veri yok. Birkaç soru çözünce sana en zayıf konunu önerebilirim. Ana sayfadan "Bugünkü Planı Oluştur" butonuna basarak da otomatik program alabilirsin.';
    else
      v_response := format('Henüz bugün için bir planın yok. Ana sayfadan "Bugünkü Planı Oluştur" butonuna basabilir ya da en zayıf konun olan "%s" ile başlayabilirsin.%s',
        v_weak_topic_name,
        case when v_exam_days is not null then format(' Sınavına %s gün kaldı.', v_exam_days) else '' end);
    end if;

  -- ============ 5) Sınav tarihi / geri sayım ============
  elsif v_msg like '%sinav%' or v_msg like '%kac gun%' or v_msg like '%tarih%' then
    select e.exam_date - current_date, e.name into v_exam_days, v_exam_name
    from exams e where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;
    if v_exam_days is null then
      v_response := 'Sınav takvimin için henüz doğrulanmış bir tarih yok. "Sınav Takvimi" sayfasından güncel durumu takip edebilirsin.';
    else
      v_response := format('Sınavına %s gün kaldı. Detaylar için "Sınav Takvimi" sayfasına göz atabilirsin.', v_exam_days);
    end if;

  -- ============ 6) Başarı oranı / performans ============
  elsif v_msg like '%basari%' or v_msg like '%performans%' or v_msg like '%oran%' or v_msg like '%dogru%' then
    select count(*), case when count(*)=0 then 0 else round((count(*) filter (where is_correct)::numeric/count(*))*100,1) end
    into v_total_answers, v_success
    from user_answers where user_id = v_uid;
    if coalesce(v_total_answers,0) = 0 then
      v_response := 'Henüz hiç soru çözmedin, bu yüzden başarı oranın yok. İlk 10 soruyu çözünce burada net bir yüzde görebileceksin.';
    else
      v_response := format('Şu ana kadar %s soru çözdün, genel başarı oranın %%%s. Detaylı kırılım için "Analiz" sayfasına bakabilirsin.', v_total_answers, v_success);
    end if;

  -- ============ 7) Seviye / XP / seri ============
  elsif v_msg like '%seviye%' or v_msg like '%xp%' or v_msg like '%seri%' or v_msg like '%streak%' or v_msg like '%rozet%' then
    select current_streak, xp, level into v_streak, v_xp, v_level from user_gamification where user_id = v_uid;
    v_response := format(
      pick_ai_variant(array[
        'Şu an seviye %1$s''desin, %2$s XP''in ve %3$s günlük çalışma serin var. Her gün en az bir konu çözerek serini koru! 🔥',
        'Durumun: seviye %1$s, %2$s XP, %3$s günlük seri. Bugün de birkaç soru çözersen seri devam eder. 🔥',
        'Seviye %1$s''desin ve %2$s XP topladın. %3$s günlük serin var — bozmadan devam! ⚡'
      ], v_seed),
      coalesce(v_level,1), coalesce(v_xp,0), coalesce(v_streak,0));

  -- ============ 8) Motivasyon / moral ============
  elsif v_msg like '%motiv%' or v_msg like '%bikt%' or v_msg like '%yorul%' or v_msg like '%yapamiyo%' or v_msg like '%zor geliyo%' or v_msg like '%moral%' then
    select current_streak into v_streak from user_gamification where user_id = v_uid;
    v_response := format(
      pick_ai_variant(array[
        'Anlıyorum, bazen zor gelebilir. %1$sŞimdi küçük bir adım at: 5-10 soruluk kısa bir tur bile ilerleme sayılır. Sen yapabilirsin! 💪',
        'Yorulman çok normal, herkes zaman zaman böyle hisseder. %1$sBüyük hedefi unut, sadece 5 soruluk kısa bir tur yap — devamı kendiliğinden gelir. 🌱',
        'Zor günler geçici, bıraktığın emek kalıcı. %1$sŞimdi tek yapman gereken küçük bir adım: birkaç soru çöz, gerisini sonra düşünürsün. 💪'
      ], v_seed),
      case when coalesce(v_streak,0) > 0 then format('%s gündür seriyi sürdürüyorsun, bu bile büyük bir başarı. ', v_streak) else '' end);

  -- ============ 9) Çalışma tavsiyesi ============
  elsif v_msg like '%tavsiye%' or v_msg like '%ipucu%' or v_msg like '%nasil calis%' or v_msg like '%verimli%' then
    select e.exam_date - current_date into v_exam_days from exams e
    where e.exam_type = v_exam_type and e.is_active = true and e.exam_date >= current_date
    order by e.exam_date asc limit 1;
    if v_exam_days is not null and v_exam_days <= 30 then
      v_response := 'Sınava az kaldığı için ağırlığı soru çözme ve tekrara ver: her gün 1 konu tekrarı + en az 30 soru + yanlış analizi ideal olur.';
    else
      v_response := 'Düzenli çalış: 40 dakikalık bloklar halinde çalış, aralarda 10 dakika mola ver (Pomodoro benzeri). Yeni konu öğrendikten sonra mutlaka aynı gün soru çözerek pekiştir.';
    end if;

  -- ============ 10) Haberler / duyurular ============
  elsif v_msg like '%haber%' or v_msg like '%duyuru%' or v_msg like '%guncel%' then
    select title into v_news_title from news_items where is_learning_content = false order by published_at desc limit 1;
    if v_news_title is null then
      v_response := 'Şu anda gösterilecek güncel bir haber yok.';
    else
      v_response := format('En son duyuru: "%s". Tüm haberler için "Haberler" sayfasına bakabilirsin.', v_news_title);
    end if;

  -- ============ 11) En güçlü olduğun konu ============
  elsif v_msg like '%en iyi%' or v_msg like '%en guclu%' or v_msg like '%guclu oldugum%' or v_msg like '%en basarili%' then
    select t.name, s.name into v_strong_topic_name, v_weak_subject_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type and tp.total_questions > 0
    order by tp.knowledge_score desc limit 1;
    if v_strong_topic_name is null then
      v_response := 'Henüz yeterli veri yok — birkaç soru çözünce en güçlü olduğun konuyu söyleyebilirim.';
    else
      v_response := format('En güçlü olduğun konu "%s" (%s dersi). Böyle devam! Bu konudaki bilgini zor sorularla pekiştirebilirsin. 👏', v_strong_topic_name, v_weak_subject_name);
    end if;

  -- ============ 12) Bugün kaç soru çözdüm ============
  elsif v_msg like '%bugun kac soru%' or v_msg like '%kac soru cozdum%' or v_msg like '%bugun kac tane soru%' then
    select count(*) into v_today_questions from user_answers
    where user_id = v_uid and answered_at >= date_trunc('day', now());
    v_response := format('Bugün %s soru çözdün. %s', coalesce(v_today_questions,0),
      case when coalesce(v_today_questions,0) = 0 then 'Hadi birkaç soruyla başla!' else 'Devam et, her soru seni sınava biraz daha hazırlıyor. 💪' end);

  -- ============ 13) YENİ: Haftalık özet ============
  elsif v_msg like '%hafta%' then
    select count(*), count(*) filter (where is_correct) into v_week_total, v_week_correct
    from user_answers where user_id = v_uid and answered_at >= now() - interval '7 days';
    v_week_success := case when coalesce(v_week_total,0) = 0 then null else round((v_week_correct::numeric / v_week_total) * 100, 1) end;
    if coalesce(v_week_total,0) = 0 then
      v_response := 'Bu hafta henüz soru çözmemişsin gibi görünüyor. Küçük bir turla başlayıp haftayı boş geçirmemek iyi olur.';
    else
      v_response := format('Bu hafta %s soru çözdün, başarı oranın %%%s. %s',
        v_week_total, v_week_success,
        case when v_week_success >= 70 then 'Gayet iyi gidiyorsun, böyle devam! 👏'
             when v_week_success >= 40 then 'Fena değil ama yanlışlarını gözden geçirmen faydalı olur.'
             else 'Bu hafta biraz zorlanmışsın gibi görünüyor — konu özetlerine tekrar göz atıp kolay seviyeden devam etmen iyi olabilir.' end);
    end if;

  -- ============ 14) YENİ: Hangi DERSTE en zayıfım (konu değil, ders bazında) ============
  elsif v_msg like '%hangi derste%' or v_msg like '%hangi ders%' or v_msg like '%en zayif ders%' or v_msg like '%zayif oldugum ders%' then
    select s.name, round(avg(coalesce(tp.knowledge_score,0)),1) into v_weakest_subject_name, v_weakest_subject_score
    from subjects s
    join topics t on t.subject_id = s.id and t.status = 'active' and not exists (select 1 from topics c where c.parent_id = t.id)
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    where s.exam_type = v_exam_type
    group by s.id, s.name
    having count(tp.topic_id) > 0
    order by avg(coalesce(tp.knowledge_score,0)) asc
    limit 1;
    if v_weakest_subject_name is null then
      v_response := 'Henüz derslere göre karşılaştırma yapacak kadar verin yok — birkaç konuda soru çözünce en zayıf dersini söyleyebilirim.';
    else
      v_response := format('Derslerin arasında en çok geride olduğun ders "%s" (ortalama bilgi skoru: %%%s). Bu haftaki çalışmanın ağırlığını buraya vermen iyi olur.', v_weakest_subject_name, coalesce(v_weakest_subject_score,0));
    end if;

  -- ============ 15) YENİ: Kaç konu tamamladım / iyi seviyeye ulaştı ============
  elsif v_msg like '%kac konu%' or v_msg like '%tamamla%' then
    select count(*) filter (where tp.knowledge_score >= 70), count(*)
    into v_topics_mastered, v_topics_total
    from topics t
    left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
    join subjects s on s.id = t.subject_id
    where s.exam_type = v_exam_type and t.status = 'active'
      and not exists (select 1 from topics c where c.parent_id = t.id);
    v_response := format('Toplam %s konudan %s tanesinde iyi seviyedesin (bilgi skoru %%70 ve üzeri). %s',
      coalesce(v_topics_total,0), coalesce(v_topics_mastered,0),
      case when coalesce(v_topics_mastered,0) = 0 then 'İlk konunu iyi seviyeye taşımak için bir konu seçip düzenli çalışmaya başlayabilirsin.'
           else 'Kalan konularda da aynı disiplinle devam edersen fark yaratırsın. 👏' end);

  -- ============ 16) YENİ: Çalışma saati / güne göre tavsiye ============
  elsif v_msg like '%hangi saat%' or v_msg like '%gunun hangi%' or v_msg like '%sabah mi%' or v_msg like '%ne zaman calismali%' then
    v_hour := extract(hour from now() at time zone 'Europe/Istanbul');
    if v_hour < 10 then
      v_response := 'Sabah saatleri genelde zihnin en taze olduğu zamandır — bugüne, en zor bulduğun konuyla başlamak için iyi bir fırsat.';
    elsif v_hour < 17 then
      v_response := 'Gün içi çalışma için uygun bir zaman: 40 dakikalık bloklar halinde çalışıp aralarda kısa molalar vermeyi dene.';
    elsif v_hour < 22 then
      v_response := 'Akşam saatlerinde ağır/yeni konu yerine, gün içinde çözdüğün soruların tekrarını ve yanlış analizini yapmak daha verimli olabilir.';
    else
      v_response := 'Geç saatlere kalmışsın — kısa bir tekrar yapıp erken dinlenmen, yarın daha verimli çalışman için daha iyi olabilir. 🌙';
    end if;

  -- ============ 17) YENİ: Rastgele / ilginç bilgi ============
  elsif v_msg like '%ilginc bilgi%' or v_msg like '%biliyor muydun%' or v_msg like '%rastgele bilgi%' or (v_msg like '%bilgi%' and v_msg not like '%bilgi skoru%') then
    select t.name, tc.summary into v_fact_topic_name, v_fact_summary
    from topic_progress tp
    join topics t on t.id = tp.topic_id
    join subjects s on s.id = t.subject_id
    join topic_contents tc on tc.topic_id = t.id
    where tp.user_id = v_uid and s.exam_type = v_exam_type and tc.summary is not null and length(tc.summary) > 0
    order by tp.knowledge_score asc
    limit 1;
    if v_fact_topic_name is null then
      select t.name, tc.summary into v_fact_topic_name, v_fact_summary
      from topics t join subjects s on s.id = t.subject_id join topic_contents tc on tc.topic_id = t.id
      where s.exam_type = v_exam_type and tc.summary is not null and length(tc.summary) > 0
      order by random() limit 1;
    end if;
    if v_fact_topic_name is null then
      v_response := 'Şu an paylaşacak kısa bir bilgi bulamadım, ama bir konu adı yazarsan sana o konu hakkında özet geçebilirim.';
    else
      v_response := format('"%s" konusundan kısa bir hatırlatma: %s', v_fact_topic_name, v_fact_summary);
    end if;

  -- ============ 18) Yardım / neler yapabilirsin ============
  elsif v_msg like '%yardim%' or v_msg like '%ne yapabilir%' or v_msg like '%neler sorabilir%' or v_msg like '%nasil kullan%' then
    v_response := pick_ai_variant(array[
      'Sana şunlarda yardımcı olabilirim: bir konu/ders adı yazarsan durumunu değerlendiririm ("Matematik nasılım?"), "bugün ne çalışmalıyım", "sınava kaç gün kaldı", "başarı oranım", "seviyem", "en güçlü konum", "hangi derste zayıfım", "bu hafta nasıldım", "kaç konu tamamladım", "bugün kaç soru çözdüm", "son yanlışımı açıkla" ya da "motivasyona ihtiyacım var" diyebilirsin. Serbest, doğal bir dille yazman yeterli — belirli kalıplara bağlı değilim.',
      'Neler sorabilirsin: bir konu ya da ders adı ("Tarih nasıl gidiyor?"), "bugünkü programım ne", "sınava kaç gün var", "başarı oranım", "seviyem/XP''im", "hangi derste geriyim", "bu hafta özetim", "ilginç bir bilgi ver" veya "moralim bozuk" gibi doğal cümleler kurabilirsin — kalıplara takılmadan, kendi cümlelerinle yazman yeterli.'
    ], v_seed);

  -- ============ 19) Selamlaşma / küçük sohbet ============
  elsif v_msg like '%merhaba%' or v_msg like '%selam%' or v_msg like '%nasilsin%' or v_msg like '%gunaydin%' or v_msg like '%iyi aksam%' then
    v_response := format(
      pick_ai_variant(array[
        'Merhaba%1$s! Sana çalışma programın, konuların ve performansın hakkında yardımcı olabilirim. Bir konu adı yazabilir, "bugün ne çalışmalıyım" ya da "en zayıf konum ne" diyebilirsin.',
        'Selam%1$s! Bugün nereden başlamak istersin? Bir ders/konu adı yazabilir ya da "bu hafta nasıldım" diyerek genel duruma bakabiliriz.',
        'Merhaba%1$s, hoş geldin. İstersen "bugün ne çalışmalıyım" diye sorabilir ya da doğrudan bir konu adı yazabilirsin.'
      ], v_seed),
      case when v_name is not null and v_name <> '' then ', ' || v_name else '' end);

  -- ============ 20) Teşekkür ============
  elsif v_msg like '%tesekkur%' or v_msg like '%sagol%' or v_msg like '%eyval%' then
    v_response := pick_ai_variant(array[
      'Rica ederim! Başka bir sorun olursa buradayım. 🙌',
      'Ne demek, her zaman buradayım. Başka bir konuda da yardımcı olabilirim. 🙌',
      'Rica ederim, iyi çalışmalar! İstediğin zaman tekrar sorabilirsin. 🙌'
    ], v_seed);

  else
    -- Akıllı varsayılan: sabit metin yerine kullanıcının en zayıf konusunu önererek yanıt ver.
    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    if v_weak_topic_name is not null then
      v_response := format(
        pick_ai_variant(array[
          'Tam anlayamadım ama sana yine de yardımcı olayım: en zayıf konun "%1$s" görünüyor, oradan devam edebilirsin. İstersen bir konu adı, "bugün ne çalışmalıyım", "başarı oranım", "seviyem", "en güçlü konum" ya da "motivasyon" gibi bir şey de sorabilirsin — ya da "yardım" yaz, neler sorabileceğini sıralayayım.',
          'Bunu tam çözemedim, ama madem buradayız: "%1$s" konusu senin için en öncelikli görünüyor. İstersen bunu çalışabilir, ya da "yardım" yazarak neler sorabileceğini görebilirsin.'
        ], v_seed),
        v_weak_topic_name);
    else
      v_response := 'Tam anlayamadım. Bana bir konu/ders adı ("Matematik nasılım?"), "bugün ne çalışmalıyım", "son yanlışımı açıkla", "başarı oranım", "seviyem" ya da "motivasyona ihtiyacım var" gibi bir şey sorabilirsin. "Yardım" yazarsan neler sorabileceğini sıralarım.';
    end if;
  end if;

  insert into ai_interactions (user_id, message, response) values (v_uid, p_message, v_response);
  return jsonb_build_object('response', v_response);
end;
$$;

revoke execute on function public.ai_assistant_ask(text) from public, anon;
grant execute on function public.ai_assistant_ask(text) to authenticated;

commit;
