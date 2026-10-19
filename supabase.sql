-- Catat Laba: jalankan sekali di Supabase > SQL Editor.
-- Memakai prefix pb_ supaya tidak bentrok dengan tabel lain di project existing.

create table if not exists public.pb_stores (
  id uuid primary key default gen_random_uuid(),
  name text not null check (length(trim(name)) > 0),
  created_at timestamptz not null default now()
);

create table if not exists public.pb_transactions (
  id uuid primary key default gen_random_uuid(),
  store_id uuid not null references public.pb_stores(id) on delete cascade,
  date date not null,
  type text not null check (type in ('in','out')),
  amount bigint not null check (amount > 0),
  description text not null,
  category text not null,
  method text,
  created_at timestamptz not null default now()
);

create index if not exists pb_transactions_store_date on public.pb_transactions (store_id, date);

alter table public.pb_stores enable row level security;
alter table public.pb_transactions enable row level security;

-- Tanpa login: siapa pun yang punya URL + key aplikasi bisa baca/tulis tabel ini.
drop policy if exists pb_stores_open on public.pb_stores;
create policy pb_stores_open on public.pb_stores
  for all to anon, authenticated using (true) with check (true);

drop policy if exists pb_transactions_open on public.pb_transactions;
create policy pb_transactions_open on public.pb_transactions
  for all to anon, authenticated using (true) with check (true);
