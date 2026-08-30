-- =============================================
-- IPAG Website Database Schema
-- Run this in Supabase SQL Editor
-- =============================================


-- ─────────────────────────────────────────
-- PRODUCTIONS
-- ─────────────────────────────────────────
create table if not exists productions (
    id          uuid primary key default gen_random_uuid(),
    title       text not null,
    path        text not null unique,
    image       text,                  -- public URL or storage path
    description text,
    about       text,
    history     text,
    facts       jsonb default '[]',    -- [{ label, value }]
    credits     jsonb default '[]',    -- [{ role, name }]
    reviews     jsonb default '[]',    -- [{ quote, source }]
    videos      jsonb default '[]',    -- [{ id, title }]
    gallery     jsonb default '[]',    -- [url, url, ...]
    sort_order  integer default 0,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- ARTISTS
-- ─────────────────────────────────────────
create table if not exists artists (
    id          uuid primary key default gen_random_uuid(),
    name        text not null,
    role        text,
    note        text,
    photo       text,                  -- public URL or storage path
    type        text not null check (type in ('resident', 'apprentice')),
    sort_order  integer default 0,
    active      boolean default true,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- MILESTONES — awards
-- ─────────────────────────────────────────
create table if not exists awards (
    id          uuid primary key default gen_random_uuid(),
    year        text not null,
    title       text not null,
    detail      text,
    sort_order  integer default 0,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- MILESTONES — international representations
-- ─────────────────────────────────────────
create table if not exists representations (
    id          uuid primary key default gen_random_uuid(),
    year        text not null,
    event       text not null,
    sort_order  integer default 0,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- MILESTONES — play awards
-- ─────────────────────────────────────────
create table if not exists play_awards (
    id          uuid primary key default gen_random_uuid(),
    title       text not null,
    detail      text,
    sort_order  integer default 0,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- HISTORY timeline
-- ─────────────────────────────────────────
create table if not exists history_events (
    id          uuid primary key default gen_random_uuid(),
    year        text not null,
    title       text not null,
    description text,
    sort_order  integer default 0,
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- DIRECTOR bio
-- ─────────────────────────────────────────
create table if not exists director (
    id          uuid primary key default gen_random_uuid(),
    name        text not null,
    title       text,
    bio_col1    text,
    bio_col2    text,
    quote       text,
    photo       text,
    stat_productions  text default '50+',
    stat_books        text default '6',
    stat_years        text default '47',
    distinctions      jsonb default '[]',   -- [string, string, ...]
    created_at  timestamptz default now(),
    updated_at  timestamptz default now()
);

-- ─────────────────────────────────────────
-- PAGE CONTENT — flexible key/value store
-- for any text block on any page
-- ─────────────────────────────────────────
create table if not exists page_content (
    id          uuid primary key default gen_random_uuid(),
    page        text not null,         -- e.g. 'home', 'mission-vision', 'ipag-studies'
    key         text not null,         -- e.g. 'hero_title', 'intro_text'
    value       text,
    updated_at  timestamptz default now(),
    unique (page, key)
);

-- ─────────────────────────────────────────
-- SITE IMAGES — uploaded image library
-- ─────────────────────────────────────────
create table if not exists site_images (
    id          uuid primary key default gen_random_uuid(),
    filename    text not null,
    storage_path text not null,        -- path in Supabase Storage bucket
    public_url  text not null,
    alt_text    text,
    uploaded_at timestamptz default now()
);


-- =============================================
-- AUTO-UPDATE updated_at on every table
-- =============================================
create or replace function update_updated_at()
returns trigger as $$
begin
    new.updated_at = now();
    return new;
end;
$$ language plpgsql;

drop trigger if exists trg_productions_updated    on productions;
drop trigger if exists trg_artists_updated        on artists;
drop trigger if exists trg_awards_updated         on awards;
drop trigger if exists trg_representations_updated on representations;
drop trigger if exists trg_play_awards_updated    on play_awards;
drop trigger if exists trg_history_updated        on history_events;
drop trigger if exists trg_director_updated       on director;
drop trigger if exists trg_page_content_updated   on page_content;

create trigger trg_productions_updated
    before update on productions
    for each row execute function update_updated_at();

create trigger trg_artists_updated
    before update on artists
    for each row execute function update_updated_at();

create trigger trg_awards_updated
    before update on awards
    for each row execute function update_updated_at();

create trigger trg_representations_updated
    before update on representations
    for each row execute function update_updated_at();

create trigger trg_play_awards_updated
    before update on play_awards
    for each row execute function update_updated_at();

create trigger trg_history_updated
    before update on history_events
    for each row execute function update_updated_at();

create trigger trg_director_updated
    before update on director
    for each row execute function update_updated_at();

create trigger trg_page_content_updated
    before update on page_content
    for each row execute function update_updated_at();


-- =============================================
-- ROW LEVEL SECURITY
-- Public can read everything.
-- Only authenticated users (admins) can write.
-- =============================================
alter table productions       enable row level security;
alter table artists           enable row level security;
alter table awards            enable row level security;
alter table representations   enable row level security;
alter table play_awards       enable row level security;
alter table history_events    enable row level security;
alter table director          enable row level security;
alter table page_content      enable row level security;
alter table site_images       enable row level security;

-- Public read policies
do $$ begin
  create policy "Public read productions"     on productions     for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read artists"         on artists         for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read awards"          on awards          for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read representations" on representations for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read play_awards"     on play_awards     for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read history"         on history_events  for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read director"        on director        for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read page_content"    on page_content    for select using (true);
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Public read site_images"     on site_images     for select using (true);
exception when duplicate_object then null; end $$;

-- Authenticated write policies (admin only)
do $$ begin
  create policy "Auth write productions"     on productions     for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write artists"         on artists         for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write awards"          on awards          for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write representations" on representations for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write play_awards"     on play_awards     for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write history"         on history_events  for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write director"        on director        for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write page_content"    on page_content    for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;
do $$ begin
  create policy "Auth write site_images"     on site_images     for all using (auth.role() = 'authenticated');
exception when duplicate_object then null; end $$;


-- =============================================
-- STORAGE BUCKET for uploaded images
-- Run this separately if needed
-- =============================================
-- insert into storage.buckets (id, name, public)
-- values ('ipag-images', 'ipag-images', true);
