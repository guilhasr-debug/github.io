create table if not exists public.memories (
  slot text primary key,
  caption text not null default '',
  image_path text not null,
  updated_at timestamptz not null default now()
);

alter table public.memories enable row level security;

drop policy if exists "Public can read memories" on public.memories;
create policy "Public can read memories" on public.memories for select to anon using (true);

drop policy if exists "Public can add memories" on public.memories;
create policy "Public can add memories" on public.memories for insert to anon
with check (slot in ('memory-1','memory-2'));

drop policy if exists "Public can update memories" on public.memories;
create policy "Public can update memories" on public.memories for update to anon
using (slot in ('memory-1','memory-2'))
with check (slot in ('memory-1','memory-2'));

drop policy if exists "Public can delete memories" on public.memories;
create policy "Public can delete memories" on public.memories for delete to anon
using (slot in ('memory-1','memory-2'));
