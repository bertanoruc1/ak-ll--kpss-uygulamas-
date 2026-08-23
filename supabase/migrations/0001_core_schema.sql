-- KPSS Akıllı Öğrenci Platformu — Çekirdek Şema
-- Bkz. ARCHITECTURE.md

create extension if not exists pgcrypto;

-- ============ ENUMS ============
create type app_role as enum ('student','admin');
create type exam_type as enum ('kpss_lisans','kpss_onlisans','kpss_ortaogretim','dhbt','diger');
create type difficulty_level as enum ('kolay','orta','zor');
create type learning_level as enum ('baslangic','gelistirilmeli','orta','iyi','cok_iyi');
create type topic_status as enum ('active','icerik_bekliyor','kaldirildi');
create type repetition_status as enum ('pending','completed','failed');
create type session_type as enum ('konu_ogrenme','soru_cozme','tekrar','mola');
create type session_status as enum ('planned','done','skipped');
create type news_category as enum ('osym','kpss','basvuru','sinav_takvimi','kilavuz','sonuc','tercih','yerlestirme','mufredat','ders','genel_egitim','onemli_duyuru');
create type source_trust as enum ('resmi','destekleyici');
create type source_type as enum ('osym','meb','destekleyici');
create type sync_status as enum ('no_change','changed','error','pending_review');
create type ai_content_status as enum ('ai_generated','approved','rejected','published');
create type ai_content_type as enum ('flashcard','question','summary');
create type curriculum_change_type as enum ('added','removed','renamed','kazanim_changed','weight_changed');
create type applied_by_type as enum ('sync_engine','admin');
create type notification_event_type as enum (
  'NEW_OFFICIAL_NEWS','EXAM_DATE_CHANGED','APPLICATION_STARTED',
  'APPLICATION_DEADLINE_APPROACHING','EXAM_DATE_APPROACHING','CURRICULUM_CHANGED',
  'NEW_TOPIC_ADDED','STUDY_TIME','MISSED_STUDY','REVIEW_DUE'
);
create type notification_priority as enum ('kritik','onemli','normal','dusuk');

-- ============ KİMLİK ============
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role app_role not null default 'student',
  full_name text,
  email text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table students (
  user_id uuid primary key references profiles(id) on delete cascade,
  exam_type exam_type not null default 'kpss_lisans',
  target_score numeric(6,2),
  daily_study_minutes int not null default 120,
  preferred_start_time time not null default '19:00',
  preferred_end_time time not null default '21:00',
  notification_frequency text not null default 'normal',
  onboarding_completed boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ============ SINAV TAKVİMİ (canlı, versiyonlu) ============
create table exams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  exam_type exam_type not null,
  exam_date date,
  application_start date,
  application_end date,
  late_application_date date,
  result_date date,
  source text,
  source_url text,
  last_verified_at timestamptz,
  confidence numeric(3,2) not null default 1.0,
  version int not null default 1,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table exam_change_log (
  id uuid primary key default gen_random_uuid(),
  exam_id uuid not null references exams(id) on delete cascade,
  field_name text not null,
  old_value text,
  new_value text,
  source text,
  source_url text,
  detected_at timestamptz not null default now(),
  confidence numeric(3,2) not null default 1.0,
  applied_by applied_by_type not null default 'admin'
);

-- ============ MÜFREDAT (canlı, versiyonlu) ============
create table subjects (
  id uuid primary key default gen_random_uuid(),
  exam_type exam_type not null,
  name text not null,
  slug text not null,
  description text,
  icon text not null default '📘',
  color text not null default '#6366f1',
  weight numeric(4,2) not null default 1.0,
  order_index int not null default 0,
  unique(exam_type, slug)
);

create table topics (
  id uuid primary key default gen_random_uuid(),
  subject_id uuid not null references subjects(id) on delete cascade,
  parent_id uuid references topics(id) on delete cascade,
  name text not null,
  slug text not null,
  description text,
  kazanim_text text,
  status topic_status not null default 'active',
  weight numeric(4,2) not null default 1.0,
  version int not null default 1,
  order_index int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique(subject_id, parent_id, slug)
);

create table topic_contents (
  topic_id uuid primary key references topics(id) on delete cascade,
  summary text,
  content_md text,
  example_question text,
  video_url text
);

create table curriculum_change_log (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid references topics(id) on delete cascade,
  change_type curriculum_change_type not null,
  old_value text,
  new_value text,
  source text,
  source_url text,
  detected_at timestamptz not null default now(),
  confidence numeric(3,2) not null default 1.0,
  applied_by applied_by_type not null default 'admin'
);

create table user_subjects (
  user_id uuid not null references students(user_id) on delete cascade,
  subject_id uuid not null references subjects(id) on delete cascade,
  primary key (user_id, subject_id)
);

-- ============ SORULAR ============
create table questions (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references topics(id) on delete cascade,
  difficulty difficulty_level not null default 'orta',
  question_text text not null,
  image_url text,
  kazanim text,
  kaynak text,
  explanation text,
  detailed_solution text,
  video_solution_url text,
  created_at timestamptz not null default now()
);

create table question_choices (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references questions(id) on delete cascade,
  choice_text text not null,
  is_correct boolean not null default false,
  order_index int not null default 0
);

-- ============ ÖĞRENME / PERFORMANS ============
create table user_answers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  question_id uuid not null references questions(id) on delete cascade,
  choice_id uuid references question_choices(id),
  is_correct boolean not null,
  time_spent_seconds int not null default 0,
  answered_at timestamptz not null default now()
);

create table mistakes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  question_id uuid not null references questions(id) on delete cascade,
  topic_id uuid not null references topics(id) on delete cascade,
  resolved boolean not null default false,
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

create table topic_progress (
  user_id uuid not null references students(user_id) on delete cascade,
  topic_id uuid not null references topics(id) on delete cascade,
  self_assessed boolean not null default false,
  knowledge_score numeric(5,2) not null default 0,
  learning_level learning_level not null default 'baslangic',
  total_questions int not null default 0,
  correct_count int not null default 0,
  wrong_count int not null default 0,
  last_10_correct int not null default 0,
  last_10_total int not null default 0,
  avg_time_seconds numeric(6,2) not null default 0,
  last_test_score numeric(5,2),
  video_interactions int not null default 0,
  review_stage int not null default 0,
  next_review_at date,
  last_studied_at timestamptz,
  updated_at timestamptz not null default now(),
  primary key (user_id, topic_id)
);

create table repetitions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  topic_id uuid not null references topics(id) on delete cascade,
  stage int not null default 1,
  scheduled_for date not null,
  status repetition_status not null default 'pending',
  completed_at timestamptz
);

create table algorithm_weights (
  key text primary key,
  weight numeric(4,3) not null,
  description text
);

-- ============ HABER MOTORU ============
create table data_sources (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  url text not null,
  source_type source_type not null,
  check_frequency_minutes int not null default 360,
  last_checked_at timestamptz,
  last_status sync_status,
  last_content_hash text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

create table sync_log (
  id uuid primary key default gen_random_uuid(),
  source_id uuid not null references data_sources(id) on delete cascade,
  checked_at timestamptz not null default now(),
  status sync_status not null,
  new_hash text,
  diff_summary text,
  confidence numeric(3,2)
);

create table news_items (
  id uuid primary key default gen_random_uuid(),
  category news_category not null,
  title text not null,
  summary text,
  body text,
  source text,
  source_url text,
  source_trust source_trust not null default 'resmi',
  is_learning_content boolean not null default false,
  related_exam_id uuid references exams(id),
  published_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table ai_content_queue (
  id uuid primary key default gen_random_uuid(),
  source_news_id uuid references news_items(id) on delete set null,
  content_type ai_content_type not null,
  draft_content jsonb not null,
  status ai_content_status not null default 'ai_generated',
  reviewed_by uuid references profiles(id),
  reviewed_at timestamptz,
  created_at timestamptz not null default now()
);

-- ============ EVENT / BİLDİRİM ============
create table system_events (
  id uuid primary key default gen_random_uuid(),
  event_type notification_event_type not null,
  payload jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  processed_at timestamptz
);

create table notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  event_type notification_event_type not null,
  priority notification_priority not null default 'normal',
  title text not null,
  body text,
  related_id uuid,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

-- ============ ÇALIŞMA PLANI ============
create table study_plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  plan_date date not null,
  learn_ratio numeric(3,2) not null default 0.4,
  practice_ratio numeric(3,2) not null default 0.4,
  review_ratio numeric(3,2) not null default 0.2,
  total_minutes int not null default 0,
  created_at timestamptz not null default now(),
  unique(user_id, plan_date)
);

create table study_sessions (
  id uuid primary key default gen_random_uuid(),
  study_plan_id uuid not null references study_plans(id) on delete cascade,
  subject_id uuid references subjects(id),
  topic_id uuid references topics(id),
  session_type session_type not null,
  planned_start time,
  planned_end time,
  duration_minutes int not null default 40,
  status session_status not null default 'planned',
  actual_minutes int,
  question_target int,
  order_index int not null default 0
);

-- ============ OYUNLAŞTIRMA ============
create table user_gamification (
  user_id uuid primary key references students(user_id) on delete cascade,
  xp int not null default 0,
  level int not null default 1,
  current_streak int not null default 0,
  longest_streak int not null default 0,
  last_activity_date date
);

create table achievements (
  id uuid primary key default gen_random_uuid(),
  code text unique not null,
  name text not null,
  description text,
  icon text not null default '🏆'
);

create table user_achievements (
  user_id uuid not null references students(user_id) on delete cascade,
  achievement_id uuid not null references achievements(id) on delete cascade,
  earned_at timestamptz not null default now(),
  primary key (user_id, achievement_id)
);

-- ============ AI ASİSTAN LOG ============
create table ai_interactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references students(user_id) on delete cascade,
  message text not null,
  response text not null,
  created_at timestamptz not null default now()
);

-- ============ ADMIN AUDIT ============
create table admin_audit_log (
  id uuid primary key default gen_random_uuid(),
  actor uuid references profiles(id),
  actor_type applied_by_type not null default 'admin',
  action text not null,
  table_name text,
  record_id uuid,
  old_data jsonb,
  new_data jsonb,
  created_at timestamptz not null default now()
);

-- ============ INDEXES ============
create index on topics(subject_id);
create index on topics(parent_id);
create index on questions(topic_id);
create index on question_choices(question_id);
create index on user_answers(user_id);
create index on user_answers(question_id);
create index on mistakes(user_id, resolved);
create index on topic_progress(user_id);
create index on repetitions(user_id, status, scheduled_for);
create index on news_items(category, published_at desc);
create index on news_items(published_at desc);
create index on notifications(user_id, is_read, created_at desc);
create index on study_sessions(study_plan_id);
create index on sync_log(source_id, checked_at desc);
create index on exam_change_log(exam_id, detected_at desc);
create index on curriculum_change_log(topic_id, detected_at desc);
create index on admin_audit_log(created_at desc);
