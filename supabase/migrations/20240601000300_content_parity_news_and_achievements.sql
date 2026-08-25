-- Bu migration dört şeyi bir araya getiriyor:
--   1) İÇERİK PARİTESİ: Ön Lisans ve Ortaöğretim KPSS'te Vatandaşlık ve
--      Coğrafya derslerinde Lisans'a göre eksik olan 2'şer konuyu (zaten
--      Lisans'ta var olan, doğrulanmış içerik + soru bankasıyla birlikte)
--      bu iki sınav türüne de kopyalar. Kaynak: aynı platformdaki mevcut
--      Lisans içeriği (yeniden yazılmadı, doğrudan kopyalandı — bu yüzden
--      yanlış/halüsinasyon bilgi riski yok).
--   2) HABERLER: yukarıdaki içerik eklemelerini duyuran "ders" kategorisi
--      haberler + ilgili sınav türündeki öğrencilere mevcut NEW_TOPIC_ADDED
--      bildirim altyapısı (log_system_event + replan_due_to_event) üzerinden
--      bildirim gönderilmesi.
--      NOT: "kitap/kaynak indirim kampanyası" haberi İSTENDİ ama EKLENMEDİ —
--      web'de gerçek yayınevi kaynaklarını araştırdım, sadece üçüncü parti
--      kupon-toplama sitelerinde (kuponla.com vb.) doğrulanamayan, sık
--      değişen iddialar bulabildim. Öğrencilere güvenilir olmayan/eskimiş
--      bir indirim iddiasını "haber" gibi sunmak yanıltıcı olurdu, bu yüzden
--      uydurmadım. Bunun yerine `news_category` enum'ına 'kaynak_kampanya'
--      değerini (ve arayüz etiketini/rengini) EKLEDİM — gerçek, doğrulanmış
--      bir kampanya bilgisi verilirse (yayınevi adı, indirim oranı, geçerlilik
--      tarihi, kaynak linki) tek satır INSERT ile hemen yayınlanabilir.
--   3) BAŞARI ROZETLERİ ARAYÜZE ÇIKARILDI: `achievements`/`user_achievements`
--      tabloları ve `check_achievements()` fonksiyonu ÖNCEDEN VARDI ve
--      arka planda rozetleri sessizce veriyordu — ama hiçbir sayfa bunu
--      göstermiyordu, kullanıcı rozet kazandığını hiç fark etmiyordu. Şimdi:
--      (a) yeni bir rozet kazanıldığında uygulama içi 🔔 bildirimi gönderiliyor
--          (yeni ACHIEVEMENT_UNLOCKED bildirim türü),
--      (b) yeni `get_my_achievements()` RPC'si tüm rozetleri (kazanılmış/
--          kazanılmamış olarak işaretlenmiş) döndürüyor — profile.js bunu
--          "🏆 Rozetlerim" bölümünde gösteriyor.
--      Bu, "öğrenci sıkılmasın" isteğinin somut, veri destekli bir karşılığı:
--      zaten var olan ama görünmeyen bir oyunlaştırma sistemini görünür kıldı.
--   4) "Sorular" sekmesinin kaldırılması: bu ÖNCEKİ migration'da (000290)
--      ve nav.js/topic.js değişiklikleriyle zaten yapıldı — bu migration'da
--      tekrar bir şey yapmaya gerek yok. Eğer sitede hâlâ "Sorular" görünüyorsa
--      bunun nedeni değişikliklerin henüz `git push` + Vercel deploy ile
--      canlıya alınmamış olmasıdır (bkz. sohbetteki açıklama).

alter type news_category add value if not exists 'kaynak_kampanya';
alter type notification_event_type add value if not exists 'ACHIEVEMENT_UNLOCKED';

begin;

-- ============================================================
-- 1) İçerik paritesi: Vatandaşlık + Coğrafya (Lisans → Ön Lisans/Ortaöğretim)
-- ============================================================
do $$
declare
  v_pair record;
  v_target_exam exam_type;
  v_src_subject_id uuid;
  v_src_topic_id uuid;
  v_target_subject_id uuid;
  v_new_topic_id uuid;
  v_q record;
  v_new_question_id uuid;
  v_event_id uuid;
begin
  -- Bu oturum için: sistem olaylarını (NEW_TOPIC_ADDED) service_role gibi
  -- işleyebilmek adına geçici olarak rolü ayarlıyoruz (yalnızca bu transaction
  -- içinde geçerli — is_local=true — commit'ten sonra sıfırlanır).
  perform set_config('request.jwt.claim.role', 'service_role', true);

  for v_pair in
    select * from (values
      ('Vatandaşlık', 'Temel Hak ve Özgürlükler', 4),
      ('Vatandaşlık', 'Uluslararası Kuruluşlar', 5),
      ('Coğrafya', 'Türkiye''nin Yerşekilleri', 4),
      ('Coğrafya', 'Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)', 5)
    ) as p(subject_name, topic_name, new_order)
  loop
    select t.id, t.subject_id into v_src_topic_id, v_src_subject_id
    from topics t
    join subjects s on s.id = t.subject_id
    where s.exam_type = 'kpss_lisans' and s.name = v_pair.subject_name and t.name = v_pair.topic_name;

    if v_src_topic_id is null then
      raise notice 'Kaynak konu bulunamadı, atlanıyor: % / %', v_pair.subject_name, v_pair.topic_name;
      continue;
    end if;

    foreach v_target_exam in array array['kpss_onlisans', 'kpss_ortaogretim']::exam_type[]
    loop
      select id into v_target_subject_id
      from subjects where exam_type = v_target_exam and name = v_pair.subject_name;

      if v_target_subject_id is null then
        raise notice 'Hedef ders bulunamadı, atlanıyor: % (%)', v_pair.subject_name, v_target_exam;
        continue;
      end if;

      -- İdempotency: bu konu bu derste zaten varsa tekrar kopyalama.
      perform 1 from topics where subject_id = v_target_subject_id and name = v_pair.topic_name;
      if found then
        continue;
      end if;

      insert into topics (subject_id, parent_id, name, slug, description, kazanim_text, status, weight, order_index)
      select v_target_subject_id, null, name, slug, description, kazanim_text, status, weight, v_pair.new_order
      from topics where id = v_src_topic_id
      returning id into v_new_topic_id;

      insert into topic_contents (topic_id, summary, content_md, example_question, video_url)
      select v_new_topic_id, summary, content_md, example_question, video_url
      from topic_contents where topic_id = v_src_topic_id;

      for v_q in select * from questions where topic_id = v_src_topic_id loop
        insert into questions (
          topic_id, difficulty, question_text, image_url, kazanim, kaynak,
          explanation, detailed_solution, video_solution_url
        ) values (
          v_new_topic_id, v_q.difficulty, v_q.question_text, v_q.image_url, v_q.kazanim, v_q.kaynak,
          v_q.explanation, v_q.detailed_solution, v_q.video_solution_url
        )
        returning id into v_new_question_id;

        insert into question_choices (question_id, choice_text, is_correct, order_index)
        select v_new_question_id, choice_text, is_correct, order_index
        from question_choices where question_id = v_q.id;
      end loop;

      -- Mevcut bildirim altyapısını kullan: ilgili sınav türündeki tüm
      -- öğrencilere "yeni konu eklendi" bildirimi (bkz. 20240601000070).
      v_event_id := log_system_event('NEW_TOPIC_ADDED', jsonb_build_object(
        'topic_id', v_new_topic_id,
        'message', format('%s dersine yeni konu eklendi: %s', v_pair.subject_name, v_pair.topic_name)
      ));
      perform replan_due_to_event(v_event_id);
    end loop;
  end loop;
end $$;

-- ============================================================
-- 2) Haberler: içerik eklemelerini duyur
-- ============================================================
insert into news_items (category, title, summary, source, source_trust, is_learning_content, exam_type, published_at)
select * from (values
(
  'ders'::news_category,
  'Ön Lisans KPSS: Vatandaşlık ve Coğrafya derslerine yeni konular eklendi',
  'Vatandaşlık dersine "Temel Hak ve Özgürlükler" ile "Uluslararası Kuruluşlar"; Coğrafya dersine "Türkiye''nin Yerşekilleri" ile "Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)" konuları — konu anlatımı ve soru bankasıyla birlikte — eklendi. Dersler bölümünden hemen çalışmaya başlayabilirsin.',
  'KPSS Akıllı', 'destekleyici'::source_trust, false, 'kpss_onlisans'::exam_type, now()
),
(
  'ders'::news_category,
  'Ortaöğretim KPSS: Vatandaşlık ve Coğrafya derslerine yeni konular eklendi',
  'Vatandaşlık dersine "Temel Hak ve Özgürlükler" ile "Uluslararası Kuruluşlar"; Coğrafya dersine "Türkiye''nin Yerşekilleri" ile "Ekonomik Coğrafya (Tarım, Sanayi, Ulaşım)" konuları — konu anlatımı ve soru bankasıyla birlikte — eklendi. Dersler bölümünden hemen çalışmaya başlayabilirsin.',
  'KPSS Akıllı', 'destekleyici'::source_trust, false, 'kpss_ortaogretim'::exam_type, now()
)
) as v(category, title, summary, source, source_trust, is_learning_content, exam_type, published_at)
where not exists (
  select 1 from news_items ni where ni.title = v.title and ni.exam_type = v.exam_type
);

-- ============================================================
-- 3) Rozetler (achievements) artık kazanıldığında bildirim gönderiyor
-- ============================================================
create or replace function public.check_achievements(p_user_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_total_answers int;
  v_streak int;
  v_ach record;
begin
  select count(*) into v_total_answers from user_answers where user_id = p_user_id;
  select current_streak into v_streak from user_gamification where user_id = p_user_id;

  for v_ach in
    select id, code, name, description from achievements
    where (code = 'ilk_soru' and v_total_answers = 1)
       or (code = 'yuz_soru' and v_total_answers = 100)
       or (code = 'bin_soru' and v_total_answers = 1000)
       or (code = 'yedi_gun_seri' and v_streak = 7)
       or (code = 'otuz_gun_seri' and v_streak = 30)
  loop
    insert into user_achievements (user_id, achievement_id)
    values (p_user_id, v_ach.id)
    on conflict do nothing;

    -- FOUND: INSERT en az bir satır eklediyse true, ON CONFLICT DO NOTHING
    -- yüzünden hiç eklenmediyse false olur — böylece bildirim SADECE
    -- rozet gerçekten YENİ kazanıldığında gönderilir (yerel testte
    -- doğrulandı: bkz. commit mesajı).
    if found then
      perform notify_user(
        p_user_id, 'ACHIEVEMENT_UNLOCKED', 'onemli',
        format('🏆 Yeni Rozet: %s', v_ach.name),
        coalesce(v_ach.description, 'Yeni bir rozet kazandın! Rozetlerini profilinden görebilirsin.')
      );
    end if;
  end loop;
end;
$$;

-- Öğrencinin tüm rozetlerini (kazanılmış/kazanılmamış) döndürür — profile.js
-- "🏆 Rozetlerim" bölümünde bunu kullanıyor.
create or replace function public.get_my_achievements()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(jsonb_agg(
    jsonb_build_object(
      'code', a.code,
      'name', a.name,
      'description', a.description,
      'earned', (ua.user_id is not null),
      'earned_at', ua.earned_at
    )
    order by (ua.user_id is not null) desc, ua.earned_at desc nulls last, a.name
  ), '[]'::jsonb)
  from achievements a
  left join user_achievements ua on ua.achievement_id = a.id and ua.user_id = auth.uid();
$$;

revoke execute on function public.get_my_achievements() from public, anon;
grant execute on function public.get_my_achievements() to authenticated;

commit;
