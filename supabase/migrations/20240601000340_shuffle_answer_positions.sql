-- Soru bankasındaki doğru cevaplar şıklar arasında dengesiz dağılmıştı: 619
-- sorunun büyük bir kısmında doğru cevap hep A (ilk şık) konumundaydı (ör.
-- 20240601000330 öncesi, statik dosyalardaki 576 sorunun 259'unda doğru
-- cevap A idi — bu da dikkatli çalışmayan bir öğrencinin "hep A'yı işaretle"
-- gibi bir kısayolla şansını artırmasına yol açabilirdi, gerçek KPSS'te böyle
-- bir örüntü yoktur). Bu migration, her sorunun 5 şıkkının order_index'ini
-- rastgele karıştırarak doğru cevabın konumunu A-E arasında dengeli hale
-- getirir; şık METİNLERİNE veya id'lerine dokunmaz, sadece gösterim sırasını
-- değiştirir. get_next_question zaten order_index'e göre sıralı döndürdüğü
-- için (bkz. 20240601000290) bu, pratikte "karıştırılmış" bir gösterim sırası
-- sağlar.
--
-- Bilerek idempotent OLARAK TASARLANMADI: her çalıştırıldığında yeniden
-- karıştırır. Bu sorun değil — Supabase migration'ları normal şartlarda tek
-- seferlik uygulanır (supabase_migrations.schema_migrations tablosunda takip
-- edilir), tekrar karıştırılması da herhangi bir veri kaybına yol açmaz.

do $$
declare
  v_q record;
  v_choice_ids uuid[];
  v_shuffled uuid[];
  i int;
begin
  for v_q in select id from questions loop
    select array_agg(id order by order_index) into v_choice_ids
    from question_choices where question_id = v_q.id;

    if v_choice_ids is null or array_length(v_choice_ids, 1) < 2 then
      continue;
    end if;

    select array_agg(x order by random()) into v_shuffled
    from unnest(v_choice_ids) as x;

    for i in 1..array_length(v_shuffled, 1) loop
      update question_choices set order_index = i - 1 where id = v_shuffled[i];
    end loop;
  end loop;
end $$;
