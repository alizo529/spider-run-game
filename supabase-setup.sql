-- Run this once in Supabase Dashboard > SQL Editor.
create table if not exists public.scores (
  id bigint generated always as identity primary key,
  player_name text not null check (char_length(player_name) between 1 and 16),
  score integer not null check (score >= 0 and score <= 10000000),
  created_at timestamptz not null default now()
);

alter table public.scores enable row level security;

create policy "Anyone can read scores"
on public.scores for select to anon using (true);

create policy "Anyone can submit a score"
on public.scores for insert to anon with check (
  char_length(player_name) between 1 and 16 and score between 0 and 10000000
);
