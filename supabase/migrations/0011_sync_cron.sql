-- pg_cron + pg_net ile Data Sync Engine'in periyodik tetiklenmesi.
-- Anon key burada kasıtlı kullanılır: zaten istemci koduna gömülü, gizli değildir;
-- gerçek yetkilendirme Edge Function içinde SUPABASE_SERVICE_ROLE_KEY ile yapılır.

create extension if not exists pg_cron with schema extensions;
create extension if not exists pg_net with schema extensions;

select cron.schedule(
  'kpss-sync-engine-every-30min',
  '*/30 * * * *',
  $$
  select net.http_post(
    url := 'https://anhoaebychqnjyfcarxr.supabase.co/functions/v1/sync-engine',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFuaG9hZWJ5Y2hxbmp5ZmNhcnhyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODcyNDYzODAsImV4cCI6MjEwMjgyMjM4MH0.Ja_YMUMU-7gJZw0bdTqA1UiCDXcJdVtuyIpo6aYQ6gY'
    ),
    body := '{}'::jsonb
  );
  $$
);
