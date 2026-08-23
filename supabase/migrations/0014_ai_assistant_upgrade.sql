-- AI Asistanı büyük ölçüde genişletir: artık sadece birebir konu adı yazınca değil,
-- konudan/dersten bahseden HERHANGİ bir cümlede, Türkçe karakter farklılıklarında
-- (İ/ı, ş/s, ğ/g, ü/u, ö/o, ç/c) ve çok daha fazla niyet (motivasyon, başarı oranı,
-- seviye/XP, sınav geri sayımı, çalışma tavsiyesi, ders bazlı durum, plan özeti,
-- selamlaşma vb.) için anlamlı, veriye dayalı yanıt üretir. Bu script'i kurulum-01/02/03
-- çalıştırıldıktan SONRA çalıştırın; birden fazla kez çalıştırmak güvenlidir.

begin;

-- 1) Türkçe karakter normalizasyonu — mesaj ve konu/ders adlarını karşılaştırmadan
--    önce ortak bir forma indirger (büyük/küçük harf + Türkçe'ye özgü harfler).
create or replace function public.normalize_tr(p_text text)
returns text
language sql
immutable
set search_path = public
as $$
  select translate(lower(coalesce(p_text, '')),
    'çğıöşüâîûÇĞİÖŞÜ',
    'cgiosuaiucgiosu');
$$;

grant execute on function public.normalize_tr(text) to authenticated, anon;

-- 2) ai_assistant_ask'ı çok daha zengin bir niyet kümesiyle yeniden yaz.
create or replace function public.ai_assistant_ask(p_message text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_msg text := normalize_tr(p_message);
  v_name text;
  v_topic record;
  v_subject record;
  v_mistake record;
  v_mistake_count int;
  v_weak_topic_name text; v_weak_subject_name text;
  v_exam_type exam_type;
  v_exam_days int; v_exam_name text;
  v_response text;
  v_success numeric; v_total_answers int;
  v_streak int; v_xp int; v_level int;
  v_today_total int; v_today_done int;
  v_news_title text;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select p.full_name, s.exam_type into v_name, v_exam_type
  from profiles p join students s on s.user_id = p.id where p.id = v_uid;

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
  elsif v_msg like '%ne calis%' or v_msg like '%bugun%' or v_msg like '%plan%' or v_msg like '%program%' then
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
      v_response := format('Bugünkü planında %s görevden %s tanesini tamamladın. Devam etmek için Ana Sayfa''daki "Bugünün Programı" listesine bak.%s',
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
    select e.exam_date - current_date, e.name, e.exam_date into v_exam_days, v_exam_name, v_exam_days
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
    v_response := format('Şu an seviye %s''desin, %s XP''in ve %s günlük çalışma serin var. Her gün en az bir konu çözerek serini koru! 🔥', coalesce(v_level,1), coalesce(v_xp,0), coalesce(v_streak,0));

  -- ============ 8) Motivasyon / moral ============
  elsif v_msg like '%motiv%' or v_msg like '%bikt%' or v_msg like '%yorul%' or v_msg like '%yapamiyo%' or v_msg like '%zor geliyo%' or v_msg like '%moral%' then
    select current_streak into v_streak from user_gamification where user_id = v_uid;
    v_response := format('Anlıyorum, bazen zor gelebilir. %sŞimdi küçük bir adım at: 5-10 soruluk kısa bir tur bile ilerleme sayılır. Sen yapabilirsin! 💪',
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

  -- ============ 11) Selamlaşma / küçük sohbet ============
  elsif v_msg like '%merhaba%' or v_msg like '%selam%' or v_msg like '%nasilsin%' or v_msg like '%gunaydin%' or v_msg like '%iyi aksam%' then
    v_response := format('Merhaba%s! Sana çalışma programın, konuların ve performansın hakkında yardımcı olabilirim. Bir konu adı yazabilir, "bugün ne çalışmalıyım" ya da "en zayıf konum ne" diyebilirsin.',
      case when v_name is not null and v_name <> '' then ', ' || v_name else '' end);

  -- ============ 12) Teşekkür ============
  elsif v_msg like '%tesekkur%' or v_msg like '%sagol%' or v_msg like '%eyval%' then
    v_response := 'Rica ederim! Başka bir sorun olursa buradayım. 🙌';

  else
    -- Akıllı varsayılan: sabit metin yerine kullanıcının en zayıf konusunu önererek yanıt ver.
    select t.name into v_weak_topic_name
    from topic_progress tp join topics t on t.id = tp.topic_id join subjects s on s.id = t.subject_id
    where tp.user_id = v_uid and s.exam_type = v_exam_type
    order by tp.knowledge_score asc limit 1;

    if v_weak_topic_name is not null then
      v_response := format('Tam anlayamadım ama sana yine de yardımcı olayım: en zayıf konun "%s" görünüyor, oradan devam edebilirsin. İstersen bir konu adı, "bugün ne çalışmalıyım", "başarı oranım", "seviyem" ya da "motivasyon" gibi bir şey de sorabilirsin.', v_weak_topic_name);
    else
      v_response := 'Tam anlayamadım. Bana bir konu/ders adı ("Matematik nasılım?"), "bugün ne çalışmalıyım", "son yanlışımı açıkla", "başarı oranım", "seviyem" ya da "motivasyona ihtiyacım var" gibi bir şey sorabilirsin.';
    end if;
  end if;

  insert into ai_interactions (user_id, message, response) values (v_uid, p_message, v_response);
  return jsonb_build_object('response', v_response);
end;
$$;

revoke execute on function public.ai_assistant_ask(text) from public, anon;
grant execute on function public.ai_assistant_ask(text) to authenticated;

commit;
