-- Supabase, public şemasında oluşturulan her fonksiyona varsayılan olarak anon/authenticated/
-- service_role için DOĞRUDAN (PUBLIC üzerinden değil) EXECUTE izni veriyor. 0008 migration'ı
-- yalnızca PUBLIC'ten revoke etmişti; advisor kontrolünde anon'un hâlâ doğrudan izni olduğu
-- görüldü. Burada anon'dan açıkça kaldırıyoruz.

revoke execute on function public.submit_answer(uuid, uuid, int) from anon;
revoke execute on function public.mark_topic_understood(uuid) from anon;
revoke execute on function public.complete_repetition(uuid, boolean) from anon;
revoke execute on function public.get_next_question(uuid) from anon;
revoke execute on function public.mark_video_watched(uuid) from anon;
revoke execute on function public.submit_mini_test(uuid, jsonb) from anon;
revoke execute on function public.generate_study_plan(date, int) from anon;
revoke execute on function public.reschedule_missed_study(date) from anon;
revoke execute on function public.get_today_priority() from anon;
revoke execute on function public.get_homepage() from anon;
revoke execute on function public.get_analytics() from anon;
revoke execute on function public.mark_notification_read(uuid) from anon;
revoke execute on function public.mark_all_notifications_read() from anon;
revoke execute on function public.ai_assistant_ask(text) from anon;
revoke execute on function public.replan_due_to_event(uuid) from anon;
revoke execute on function public.record_sync_check(uuid, sync_status, text, text, numeric) from anon;
revoke execute on function public.apply_exam_field_change(uuid, text, text, text, text, numeric, applied_by_type) from anon;
revoke execute on function public.apply_curriculum_change(curriculum_change_type, uuid, uuid, text, text, text, numeric, text, text, numeric, applied_by_type) from anon;
revoke execute on function public.generate_ai_draft_from_news(uuid, ai_content_type) from anon;
revoke execute on function public.approve_ai_content(uuid) from anon;
revoke execute on function public.reject_ai_content(uuid) from anon;

-- İç yardımcılar için de anon/authenticated'den doğrudan izinleri temizle (0008 sadece PUBLIC'i kapsıyordu).
revoke execute on function public.touch_streak(uuid) from anon, authenticated;
revoke execute on function public.add_xp(uuid, int) from anon, authenticated;
revoke execute on function public.check_achievements(uuid) from anon, authenticated;
revoke execute on function public.recalc_topic_progress(uuid, uuid) from anon, authenticated;
revoke execute on function public.handle_new_user() from anon, authenticated;
revoke execute on function public.notify_user(uuid, notification_event_type, notification_priority, text, text, uuid, text, text) from anon, authenticated;
revoke execute on function public.log_system_event(notification_event_type, jsonb) from anon, authenticated;
