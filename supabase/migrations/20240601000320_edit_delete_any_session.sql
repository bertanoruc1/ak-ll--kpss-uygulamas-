-- "Bugünün Programı" listesindeki HERHANGİ bir görevi (otomatik olarak
-- generate_study_plan tarafından oluşturulmuş olsun ya da elle eklenmiş
-- olsun) düzenleyebilme/silebilme.
--
-- ÖNCEDEN: sadece is_manual=true olan görevler silinebiliyordu
-- (delete_manual_session, bkz. 20240601000290) ve hiçbir görev için
-- düzenleme yolu yoktu. Kullanıcı otomatik oluşturulan tek bir görevin
-- saatini/dersini düzeltmek istediğinde tek çaresi "Saatleri Ayarla" ile
-- generate_study_plan'i yeniden çağırmaktı — bu da o günün TÜM programını
-- (manuel eklenen görevler dahil, bkz. generate_study_plan içindeki
-- "delete from study_sessions where study_plan_id = v_plan_id") sıfırdan
-- oluşturup siliyordu. Bu migration, tek bir görevi yerinde düzenleme/silme
-- imkanı ekliyor; delete_manual_session eski davranışıyla (yalnızca manuel
-- görevler) geriye dönük uyumluluk için olduğu gibi bırakıldı, ama frontend
-- artık delete_study_session'ı kullanıyor.

create or replace function public.update_study_session(
  p_session_id uuid,
  p_subject_id uuid,
  p_topic_id uuid,
  p_session_type session_type,
  p_planned_start time,
  p_planned_end time,
  p_question_target int default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_plan_id uuid;
  v_old_minutes int;
  v_new_minutes int;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;
  if p_planned_start is null or p_planned_end is null then
    raise exception 'Başlangıç ve bitiş saati zorunludur';
  end if;
  if p_planned_end <= p_planned_start then
    raise exception 'Bitiş saati başlangıç saatinden sonra olmalı';
  end if;

  if p_topic_id is not null then
    perform 1 from topics t where t.id = p_topic_id and t.subject_id = p_subject_id;
    if not found then
      raise exception 'Geçersiz konu/ders eşleşmesi';
    end if;
  end if;

  select ss.study_plan_id, ss.duration_minutes into v_plan_id, v_old_minutes
  from study_sessions ss
  join study_plans sp on sp.id = ss.study_plan_id
  where ss.id = p_session_id and sp.user_id = v_uid;

  if v_plan_id is null then
    raise exception 'Görev bulunamadı veya düzenleme yetkiniz yok';
  end if;

  v_new_minutes := greatest(1, (extract(epoch from (p_planned_end - p_planned_start)) / 60)::int);

  update study_sessions set
    subject_id = p_subject_id,
    topic_id = p_topic_id,
    session_type = p_session_type,
    planned_start = p_planned_start,
    planned_end = p_planned_end,
    duration_minutes = v_new_minutes,
    question_target = p_question_target
  where id = p_session_id;

  -- Görev süresi değiştiyse günün toplam dakikasını da farkla güncelle
  -- (create_manual_session'daki total_minutes artırma mantığıyla tutarlı).
  update study_plans set total_minutes = greatest(0, total_minutes - v_old_minutes + v_new_minutes)
  where id = v_plan_id;

  return jsonb_build_object('session_id', p_session_id, 'plan_id', v_plan_id);
end;
$$;

grant execute on function public.update_study_session(uuid, uuid, uuid, session_type, time, time, int) to authenticated;

create or replace function public.delete_study_session(p_session_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid := auth.uid();
  v_minutes int;
  v_plan_id uuid;
begin
  if v_uid is null then raise exception 'unauthorized'; end if;

  select ss.duration_minutes, ss.study_plan_id into v_minutes, v_plan_id
  from study_sessions ss
  join study_plans sp on sp.id = ss.study_plan_id
  where ss.id = p_session_id and sp.user_id = v_uid;

  if v_plan_id is null then
    raise exception 'Görev bulunamadı veya silme yetkiniz yok';
  end if;

  delete from study_sessions where id = p_session_id;
  update study_plans set total_minutes = greatest(0, total_minutes - v_minutes) where id = v_plan_id;

  return jsonb_build_object('plan_id', v_plan_id);
end;
$$;

grant execute on function public.delete_study_session(uuid) to authenticated;
