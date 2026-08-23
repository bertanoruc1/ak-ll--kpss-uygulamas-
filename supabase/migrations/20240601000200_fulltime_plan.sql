-- "Bugünkü planı oluştur": günün planı, seçilen Başlangıç/Bitiş saat
-- aralığını GERÇEKTEN kullanan, tam kapsamlı bir program üretsin.
--
-- KÖK NEDEN #1: generate_study_plan, students.preferred_end_time (v_end)
-- değerini SELECT ile okuyor ama hiçbir yerde kullanmıyordu — programın
-- toplam süresi tamamen ayrı, students.daily_study_minutes alanından
-- geliyordu (varsayılan 120 dk). Kullanıcı arayüzden geniş bir saat
-- aralığı seçse bile ("saat sadece belirli saatler tek var" şikayeti) plan
-- yalnızca o 120 dk'lık (2-3 blok) dar pencereyle sınırlı kalıyordu.
--
-- KÖK NEDEN #2: %20-30'luk "tekrar" (review) bütçesi, o gün için vadesi
-- gelen tekrar (repetition) yoksa sessizce ÇÖPE gidiyordu — öğrenme
-- bütçesinin aksine pratik bölümüne devredilmiyordu. Bu da yeni/az
-- kullanıcılarda planın gereğinden kısa görünmesine katkı sağlıyordu.
--
-- KÖK NEDEN #3: öğrenme/pratik döngüleri, uygun konu listesi tükenince
-- (ör. az konulu bir ders) süre bütçesi hâlâ dolu olsa bile duruyordu —
-- yani geniş bir saat aralığı bile, konu sayısı azsa erken kesiliyordu.
--
-- ÇÖZÜM: toplam süre artık ÖNCELİKLE (Bitiş Saati - Başlangıç Saati)
-- penceresinden hesaplanıyor (gece yarısını geçen aralıklar da destekleniyor,
-- 30dk-12sa arası mantıklı bir aralıkla sınırlandırılıyor); kullanılmayan
-- tekrar bütçesi pratik bölümüne devrediliyor; öğrenme/pratik döngüleri artık
-- bütçe bitene kadar konu listesini gerekirse baştan tekrar ederek (spaced
-- practice, en fazla 6 tur) dolduruyor — böylece seçilen saat aralığı GERÇEKTEN
-- baştan sona, tam kapsamlı şekilde dolduruluyor.

create or replace function public.generate_study_plan(p_plan_date date default current_date, p_extra_minutes int default 0)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_exam_type exam_type;
  v_daily_minutes int; v_start time; v_end time;
  v_window_minutes int;
  v_exam_date date; v_days_left int;
  v_learn numeric; v_practice numeric; v_review numeric;
  v_frac numeric;
  v_total_minutes int;
  v_plan_id uuid;
  v_cursor time;
  v_order int := 0;
  v_learn_minutes int; v_practice_minutes int; v_review_minutes int;
  v_rep record;
  v_topic record;
  v_block_minutes int := 40;
  v_break_minutes int := 10;
  v_pass int;
  v_inserted_this_pass boolean;
  v_max_passes constant int := 6;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  perform public.ensure_student_profile(v_uid);

  select exam_type, daily_study_minutes, preferred_start_time, preferred_end_time
  into v_exam_type, v_daily_minutes, v_start, v_end
  from students where user_id = v_uid;

  -- ensure_student_profile'dan sonra bile satır yoksa (teorik olarak
  -- imkansız ama savunma amaçlı) makul varsayılanlarla devam et.
  v_exam_type := coalesce(v_exam_type, 'kpss_lisans');
  v_start := coalesce(v_start, '19:00');
  v_end := coalesce(v_end, '21:00');

  select exam_date into v_exam_date from exams
  where exam_type = v_exam_type and is_active = true and exam_date >= p_plan_date
  order by exam_date asc limit 1;

  if v_exam_date is null then
    v_days_left := null;
    v_learn := 0.40; v_practice := 0.40; v_review := 0.20;
  else
    v_days_left := v_exam_date - p_plan_date;
    if v_days_left >= 90 then
      v_learn := 0.60; v_practice := 0.25; v_review := 0.15;
    elsif v_days_left <= 7 then
      v_learn := 0.10; v_practice := 0.60; v_review := 0.30;
    elsif v_days_left <= 30 then
      v_frac := (30 - v_days_left) / 23.0;
      v_learn := 0.30 + (0.10 - 0.30) * v_frac;
      v_practice := 0.50 + (0.60 - 0.50) * v_frac;
      v_review := 0.20 + (0.30 - 0.20) * v_frac;
    else
      v_frac := (90 - v_days_left) / 60.0;
      v_learn := 0.60 + (0.30 - 0.60) * v_frac;
      v_practice := 0.25 + (0.50 - 0.25) * v_frac;
      v_review := 0.15 + (0.20 - 0.15) * v_frac;
    end if;
  end if;

  -- Toplam süre ARTIK ÖNCELİKLE seçilen saat aralığından geliyor — böylece
  -- kullanıcı arayüzde ne kadar geniş bir "Başlangıç–Bitiş Saati" seçerse,
  -- plan gerçekten o kadar dolduruluyor. daily_study_minutes yalnızca
  -- aralık hiç ayarlanmamışsa (teorik olarak imkansız, NOT NULL + varsayılan
  -- kolonlar) yedek olarak kullanılıyor.
  v_window_minutes := (extract(epoch from (v_end - v_start)) / 60)::int;
  if v_window_minutes <= 0 then
    v_window_minutes := v_window_minutes + 24 * 60; -- gece yarısını geçen aralık (ör. 22:00-01:00)
  end if;
  v_window_minutes := greatest(coalesce(v_window_minutes, v_daily_minutes, 120), 30);
  v_window_minutes := least(v_window_minutes, 720); -- mantıksız/aşırı uzun planları engelle (en fazla 12 saat)

  v_total_minutes := v_window_minutes + coalesce(p_extra_minutes, 0);

  insert into study_plans (user_id, plan_date, learn_ratio, practice_ratio, review_ratio, total_minutes)
  values (v_uid, p_plan_date, v_learn, v_practice, v_review, v_total_minutes)
  on conflict (user_id, plan_date) do update set
    learn_ratio = excluded.learn_ratio, practice_ratio = excluded.practice_ratio,
    review_ratio = excluded.review_ratio, total_minutes = excluded.total_minutes
  returning id into v_plan_id;

  delete from study_sessions where study_plan_id = v_plan_id;

  v_cursor := v_start;
  v_learn_minutes := round(v_total_minutes * v_learn);
  v_practice_minutes := round(v_total_minutes * v_practice);
  v_review_minutes := v_total_minutes - v_learn_minutes - v_practice_minutes;

  -- 1) Vadesi gelen tekrarlar (review_minutes içinden)
  for v_rep in
    select r.id as rep_id, r.topic_id, t.subject_id, t.name
    from repetitions r join topics t on t.id = r.topic_id
    where r.user_id = v_uid and r.status = 'pending' and r.scheduled_for <= p_plan_date
    order by r.scheduled_for asc
  loop
    exit when v_review_minutes < v_block_minutes;
    insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, question_target, order_index)
    values (v_plan_id, v_rep.subject_id, v_rep.topic_id, 'tekrar', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, 10, v_order);
    v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
    v_order := v_order + 1;
    v_review_minutes := v_review_minutes - v_block_minutes;
  end loop;

  -- 2) Zayıf / hiç çalışılmamış konular (learn_minutes içinden) — bütçe
  -- bitmeden konu listesi tükenirse (az konulu bir ders/sınav türü), en
  -- baştan tekrar dönerek (en fazla v_max_passes tur) saat aralığını GERÇEKTEN
  -- dolduruyoruz; konu listesi tamamen boşsa (0 sonuç) sonsuz döngüye
  -- girmeden hemen çıkıyoruz.
  v_pass := 0;
  loop
    v_pass := v_pass + 1;
    exit when v_learn_minutes < v_block_minutes or v_pass > v_max_passes;
    v_inserted_this_pass := false;
    for v_topic in
      select t.id as topic_id, t.subject_id
      from topics t
      join subjects s on s.id = t.subject_id
      left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
      where s.exam_type = v_exam_type and t.status = 'active' and t.parent_id is not null
        and (tp.knowledge_score is null or tp.knowledge_score < 60)
      order by coalesce(tp.knowledge_score, -1) asc, t.weight desc
    loop
      exit when v_learn_minutes < v_block_minutes;
      insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, order_index)
      values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'konu_ogrenme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, v_order);
      v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
      v_order := v_order + 1;
      v_learn_minutes := v_learn_minutes - v_block_minutes;
      v_inserted_this_pass := true;
    end loop;
    exit when not v_inserted_this_pass; -- uygun konu yoksa (0 satır) döngüden çık
  end loop;

  -- 3) Kalan süre + kullanılmayan öğrenme/tekrar süresi -> soru çözme
  -- (en zayıf konulardan, gerektiğinde tekrar turlarıyla). Önceden yalnızca
  -- öğrenme fazlası devrediliyordu; artık kullanılmayan tekrar (review)
  -- bütçesi de (ör. o gün vadesi gelen tekrar yoksa) boşa gitmek yerine
  -- pratiğe ekleniyor.
  v_practice_minutes := v_practice_minutes + greatest(v_learn_minutes, 0) + greatest(v_review_minutes, 0);
  v_pass := 0;
  loop
    v_pass := v_pass + 1;
    exit when v_practice_minutes < v_block_minutes or v_pass > v_max_passes;
    v_inserted_this_pass := false;
    for v_topic in
      select t.id as topic_id, t.subject_id
      from topics t
      join subjects s on s.id = t.subject_id
      left join topic_progress tp on tp.topic_id = t.id and tp.user_id = v_uid
      where s.exam_type = v_exam_type and t.status = 'active' and t.parent_id is not null
      order by coalesce(tp.knowledge_score, 0) asc
    loop
      exit when v_practice_minutes < v_block_minutes;
      insert into study_sessions (study_plan_id, subject_id, topic_id, session_type, planned_start, planned_end, duration_minutes, question_target, order_index)
      values (v_plan_id, v_topic.subject_id, v_topic.topic_id, 'soru_cozme', v_cursor, v_cursor + (v_block_minutes || ' minutes')::interval, v_block_minutes, 15, v_order);
      v_cursor := v_cursor + ((v_block_minutes + v_break_minutes) || ' minutes')::interval;
      v_order := v_order + 1;
      v_practice_minutes := v_practice_minutes - v_block_minutes;
      v_inserted_this_pass := true;
    end loop;
    exit when not v_inserted_this_pass;
  end loop;

  return jsonb_build_object('plan_id', v_plan_id, 'days_left', v_days_left, 'learn_ratio', v_learn, 'practice_ratio', v_practice, 'review_ratio', v_review, 'total_minutes', v_total_minutes);
end;
$$;
