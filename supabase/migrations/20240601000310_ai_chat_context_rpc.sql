-- Yeni yapay zeka sohbet asistanı (supabase/functions/ai-chat) için tek
-- eksik parça: get_homepage() zaten sınav geri sayımı, seri, XP, seviye,
-- başarı oranı ve bugünün önceliğini döndürüyor — ama en zayıf/en güçlü
-- konuyu döndürmüyor. Bu, ai-chat'in gerçek verilere dayanarak (uydurmadan)
-- "en zayıf konun ne" gibi sorulara cevap verebilmesi için gereken tek yeni
-- RPC. SECURITY DEFINER + auth.uid() ile kullanıcı sadece KENDİ verisini
-- görür (aynı mevcut desen: bkz. get_my_achievements).

begin;

create or replace function public.get_ai_weak_strong_topics()
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'weakest', (
      select jsonb_build_object('topic', t.name, 'subject', s.name, 'score', tp.knowledge_score)
      from topic_progress tp
      join topics t on t.id = tp.topic_id
      join subjects s on s.id = t.subject_id
      where tp.user_id = auth.uid() and tp.total_questions > 0
      order by tp.knowledge_score asc
      limit 1
    ),
    'strongest', (
      select jsonb_build_object('topic', t.name, 'subject', s.name, 'score', tp.knowledge_score)
      from topic_progress tp
      join topics t on t.id = tp.topic_id
      join subjects s on s.id = t.subject_id
      where tp.user_id = auth.uid() and tp.total_questions > 0
      order by tp.knowledge_score desc
      limit 1
    )
  );
$$;

revoke execute on function public.get_ai_weak_strong_topics() from public, anon;
grant execute on function public.get_ai_weak_strong_topics() to authenticated;

commit;
