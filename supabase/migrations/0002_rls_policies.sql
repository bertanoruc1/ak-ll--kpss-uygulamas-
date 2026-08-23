-- RLS Politikaları

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists(select 1 from profiles where id = auth.uid() and role = 'admin');
$$;

revoke execute on function public.is_admin() from public;
grant execute on function public.is_admin() to authenticated, anon;

-- ================= profiles / students =================
alter table profiles enable row level security;
create policy "own profile" on profiles for select using (id = auth.uid() or is_admin());
create policy "own profile update" on profiles for update using (id = auth.uid() or is_admin());
create policy "admin manage profiles" on profiles for all using (is_admin()) with check (is_admin());

alter table students enable row level security;
create policy "own student" on students for select using (user_id = auth.uid() or is_admin());
create policy "own student write" on students for update using (user_id = auth.uid() or is_admin());
create policy "own student insert" on students for insert with check (user_id = auth.uid() or is_admin());
create policy "admin manage students" on students for delete using (is_admin());

-- ================= exams / curriculum (canlı, herkese açık okunur) =================
alter table exams enable row level security;
create policy "read exams" on exams for select using (auth.role() = 'authenticated');
create policy "admin write exams" on exams for insert with check (is_admin());
create policy "admin update exams" on exams for update using (is_admin()) with check (is_admin());
create policy "admin delete exams" on exams for delete using (is_admin());

alter table exam_change_log enable row level security;
create policy "read exam_change_log" on exam_change_log for select using (auth.role() = 'authenticated');
create policy "admin write exam_change_log" on exam_change_log for all using (is_admin()) with check (is_admin());

alter table subjects enable row level security;
create policy "read subjects" on subjects for select using (auth.role() = 'authenticated');
create policy "admin write subjects" on subjects for insert with check (is_admin());
create policy "admin update subjects" on subjects for update using (is_admin()) with check (is_admin());
create policy "admin delete subjects" on subjects for delete using (is_admin());

alter table topics enable row level security;
create policy "read topics" on topics for select using (auth.role() = 'authenticated');
create policy "admin write topics" on topics for insert with check (is_admin());
create policy "admin update topics" on topics for update using (is_admin()) with check (is_admin());
create policy "admin delete topics" on topics for delete using (is_admin());

alter table topic_contents enable row level security;
create policy "read topic_contents" on topic_contents for select using (auth.role() = 'authenticated');
create policy "admin write topic_contents" on topic_contents for all using (is_admin()) with check (is_admin());

alter table curriculum_change_log enable row level security;
create policy "read curriculum_change_log" on curriculum_change_log for select using (auth.role() = 'authenticated');
create policy "admin write curriculum_change_log" on curriculum_change_log for all using (is_admin()) with check (is_admin());

alter table user_subjects enable row level security;
create policy "own user_subjects" on user_subjects for all using (user_id = auth.uid() or is_admin()) with check (user_id = auth.uid() or is_admin());

-- ================= sorular =================
-- questions: metin okunabilir (spoiler risk düşük), question_choices (is_correct içerir)
-- öğrenciye DOĞRUDAN açılmaz — yalnızca RPC (get_next_question) üzerinden, is_correct
-- alanı çıkarılmış biçimde sunulur. Bu, istemcinin doğrudan sorgu ile doğru cevabı
-- görmesini engeller.
alter table questions enable row level security;
create policy "read questions" on questions for select using (auth.role() = 'authenticated');
create policy "admin write questions" on questions for insert with check (is_admin());
create policy "admin update questions" on questions for update using (is_admin()) with check (is_admin());
create policy "admin delete questions" on questions for delete using (is_admin());

alter table question_choices enable row level security;
create policy "admin only choices" on question_choices for select using (is_admin());
create policy "admin write choices" on question_choices for insert with check (is_admin());
create policy "admin update choices" on question_choices for update using (is_admin()) with check (is_admin());
create policy "admin delete choices" on question_choices for delete using (is_admin());

-- ================= öğrenme / performans =================
alter table user_answers enable row level security;
create policy "own user_answers" on user_answers for select using (user_id = auth.uid() or is_admin());
create policy "admin manage user_answers" on user_answers for all using (is_admin()) with check (is_admin());

alter table mistakes enable row level security;
create policy "own mistakes" on mistakes for select using (user_id = auth.uid() or is_admin());
create policy "admin manage mistakes" on mistakes for all using (is_admin()) with check (is_admin());

alter table topic_progress enable row level security;
create policy "own topic_progress" on topic_progress for select using (user_id = auth.uid() or is_admin());
create policy "admin manage topic_progress" on topic_progress for all using (is_admin()) with check (is_admin());

alter table repetitions enable row level security;
create policy "own repetitions" on repetitions for select using (user_id = auth.uid() or is_admin());
create policy "admin manage repetitions" on repetitions for all using (is_admin()) with check (is_admin());

alter table algorithm_weights enable row level security;
create policy "read algorithm_weights" on algorithm_weights for select using (auth.role() = 'authenticated');
create policy "admin write algorithm_weights" on algorithm_weights for all using (is_admin()) with check (is_admin());

-- ================= haber motoru / veri kaynakları =================
alter table data_sources enable row level security;
create policy "admin only data_sources" on data_sources for all using (is_admin()) with check (is_admin());

alter table sync_log enable row level security;
create policy "admin only sync_log" on sync_log for all using (is_admin()) with check (is_admin());

alter table news_items enable row level security;
create policy "read news_items" on news_items for select using (auth.role() = 'authenticated');
create policy "admin write news_items" on news_items for insert with check (is_admin());
create policy "admin update news_items" on news_items for update using (is_admin()) with check (is_admin());
create policy "admin delete news_items" on news_items for delete using (is_admin());

alter table ai_content_queue enable row level security;
create policy "admin only ai_content_queue" on ai_content_queue for all using (is_admin()) with check (is_admin());

-- ================= event / bildirim =================
alter table system_events enable row level security;
create policy "admin only system_events" on system_events for all using (is_admin()) with check (is_admin());

alter table notifications enable row level security;
create policy "own notifications" on notifications for select using (user_id = auth.uid() or is_admin());
create policy "own notifications update" on notifications for update using (user_id = auth.uid() or is_admin());
create policy "admin manage notifications" on notifications for insert with check (is_admin());
create policy "admin delete notifications" on notifications for delete using (is_admin());

-- ================= çalışma planı =================
alter table study_plans enable row level security;
create policy "own study_plans" on study_plans for select using (user_id = auth.uid() or is_admin());
create policy "admin manage study_plans" on study_plans for all using (is_admin()) with check (is_admin());

alter table study_sessions enable row level security;
create policy "own study_sessions" on study_sessions for select using (
  exists (select 1 from study_plans sp where sp.id = study_plan_id and (sp.user_id = auth.uid() or is_admin()))
);
create policy "own study_sessions update" on study_sessions for update using (
  exists (select 1 from study_plans sp where sp.id = study_plan_id and (sp.user_id = auth.uid() or is_admin()))
);
create policy "admin manage study_sessions" on study_sessions for insert with check (is_admin());
create policy "admin delete study_sessions" on study_sessions for delete using (is_admin());

-- ================= oyunlaştırma =================
alter table user_gamification enable row level security;
create policy "own user_gamification" on user_gamification for select using (user_id = auth.uid() or is_admin());
create policy "admin manage user_gamification" on user_gamification for all using (is_admin()) with check (is_admin());

alter table achievements enable row level security;
create policy "read achievements" on achievements for select using (auth.role() = 'authenticated');
create policy "admin write achievements" on achievements for all using (is_admin()) with check (is_admin());

alter table user_achievements enable row level security;
create policy "own user_achievements" on user_achievements for select using (user_id = auth.uid() or is_admin());
create policy "admin manage user_achievements" on user_achievements for all using (is_admin()) with check (is_admin());

-- ================= AI / audit =================
alter table ai_interactions enable row level security;
create policy "own ai_interactions" on ai_interactions for select using (user_id = auth.uid() or is_admin());
create policy "admin manage ai_interactions" on ai_interactions for all using (is_admin()) with check (is_admin());

alter table admin_audit_log enable row level security;
create policy "admin only admin_audit_log" on admin_audit_log for all using (is_admin()) with check (is_admin());
