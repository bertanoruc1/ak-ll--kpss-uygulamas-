-- Fonksiyon izinlerinin sertleştirilmesi: PUBLIC varsayılan EXECUTE yetkisini kaldırıp
-- yalnızca gerekli role'lere açıkça izin ver (bilinen Postgres/Supabase tuzağı: PUBLIC
-- grant'i anon/authenticated'den ayrı ayrı revoke etmek yeterli değildir).

-- İç yardımcı fonksiyonlar — doğrudan istemciden çağrılmamalı
revoke execute on function public.touch_streak(uuid) from public, anon, authenticated;
revoke execute on function public.add_xp(uuid, int) from public, anon, authenticated;
revoke execute on function public.check_achievements(uuid) from public, anon, authenticated;
revoke execute on function public.recalc_topic_progress(uuid, uuid) from public, anon, authenticated;
revoke execute on function public.handle_new_user() from public, anon, authenticated;
revoke execute on function public.notify_user(uuid, notification_event_type, notification_priority, text, text, uuid, text, text) from public, anon, authenticated;
revoke execute on function public.log_system_event(notification_event_type, jsonb) from public, anon, authenticated;

-- Öğrenci tarafı RPC'ler — yalnızca authenticated
revoke execute on function public.submit_answer(uuid, uuid, int) from public;
grant execute on function public.submit_answer(uuid, uuid, int) to authenticated;

revoke execute on function public.mark_topic_understood(uuid) from public;
grant execute on function public.mark_topic_understood(uuid) to authenticated;

revoke execute on function public.complete_repetition(uuid, boolean) from public;
grant execute on function public.complete_repetition(uuid, boolean) to authenticated;

revoke execute on function public.get_next_question(uuid) from public;
grant execute on function public.get_next_question(uuid) to authenticated;

revoke execute on function public.mark_video_watched(uuid) from public;
grant execute on function public.mark_video_watched(uuid) to authenticated;

revoke execute on function public.submit_mini_test(uuid, jsonb) from public;
grant execute on function public.submit_mini_test(uuid, jsonb) to authenticated;

revoke execute on function public.generate_study_plan(date, int) from public;
grant execute on function public.generate_study_plan(date, int) to authenticated;

revoke execute on function public.reschedule_missed_study(date) from public;
grant execute on function public.reschedule_missed_study(date) to authenticated;

revoke execute on function public.get_today_priority() from public;
grant execute on function public.get_today_priority() to authenticated;

revoke execute on function public.get_homepage() from public;
grant execute on function public.get_homepage() to authenticated;

revoke execute on function public.get_analytics() from public;
grant execute on function public.get_analytics() to authenticated;

revoke execute on function public.mark_notification_read(uuid) from public;
grant execute on function public.mark_notification_read(uuid) to authenticated;

revoke execute on function public.mark_all_notifications_read() from public;
grant execute on function public.mark_all_notifications_read() to authenticated;

revoke execute on function public.ai_assistant_ask(text) from public;
grant execute on function public.ai_assistant_ask(text) to authenticated;

-- Admin / sync-engine RPC'leri — body içinde is_admin()/service_role kontrolü var,
-- ayrıca PUBLIC/anon'dan da kaldırılır.
revoke execute on function public.replan_due_to_event(uuid) from public, anon;
grant execute on function public.replan_due_to_event(uuid) to authenticated, service_role;

revoke execute on function public.record_sync_check(uuid, sync_status, text, text, numeric) from public, anon;
grant execute on function public.record_sync_check(uuid, sync_status, text, text, numeric) to authenticated, service_role;

revoke execute on function public.apply_exam_field_change(uuid, text, text, text, text, numeric, applied_by_type) from public, anon;
grant execute on function public.apply_exam_field_change(uuid, text, text, text, text, numeric, applied_by_type) to authenticated, service_role;

revoke execute on function public.apply_curriculum_change(curriculum_change_type, uuid, uuid, text, text, text, numeric, text, text, numeric, applied_by_type) from public, anon;
grant execute on function public.apply_curriculum_change(curriculum_change_type, uuid, uuid, text, text, text, numeric, text, text, numeric, applied_by_type) to authenticated, service_role;

revoke execute on function public.generate_ai_draft_from_news(uuid, ai_content_type) from public, anon;
grant execute on function public.generate_ai_draft_from_news(uuid, ai_content_type) to authenticated;

revoke execute on function public.approve_ai_content(uuid) from public, anon;
grant execute on function public.approve_ai_content(uuid) to authenticated;

revoke execute on function public.reject_ai_content(uuid) from public, anon;
grant execute on function public.reject_ai_content(uuid) to authenticated;

-- score_to_level: saf/deterministik, zararsız — authenticated + anon okunabilir kalabilir.
alter function public.score_to_level(numeric) set search_path = public;
