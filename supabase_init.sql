create extension if not exists "pgcrypto";

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  full_name text,
  email text unique,
  avatar_url text,
  role text not null default 'enthusiast' check (role in ('enthusiast','professional','admin')),
  bio text,
  phone text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.salons (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles(id) on delete cascade,
  name text not null,
  description text,
  address text,
  city text,
  district text,
  latitude double precision,
  longitude double precision,
  contact_phone text,
  cover_image_url text,
  is_verified boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.posts (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles(id) on delete cascade,
  salon_id uuid references public.salons(id) on delete set null,
  caption text,
  media_url text not null,
  media_type text not null default 'video' check (media_type in ('video','image')),
  visibility text not null default 'public' check (visibility in ('public','followers','private')),
  like_count integer not null default 0,
  comment_count integer not null default 0,
  view_count integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.post_likes (
  post_id uuid not null references public.posts(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, user_id)
);

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.profiles(id) on delete cascade,
  salon_id uuid not null references public.salons(id) on delete cascade,
  service_name text not null,
  notes text,
  start_time timestamptz not null,
  end_time timestamptz,
  status text not null default 'pending' check (status in ('pending','confirmed','completed','cancelled')),
  total_amount numeric(12,2),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.conversations (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now()
);

create table if not exists public.conversation_participants (
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null references public.profiles(id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (conversation_id, user_id)
);

create table if not exists public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  sender_id uuid not null references public.profiles(id) on delete cascade,
  content text,
  media_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  type text not null,
  title text not null,
  body text,
  data jsonb not null default '{}'::jsonb,
  is_read boolean not null default false,
  created_at timestamptz not null default now()
);

create index if not exists idx_salons_owner_id on public.salons(owner_id);
create index if not exists idx_posts_author_id on public.posts(author_id);
create index if not exists idx_posts_created_at on public.posts(created_at desc);
create index if not exists idx_bookings_customer_id on public.bookings(customer_id);
create index if not exists idx_bookings_salon_id on public.bookings(salon_id);
create index if not exists idx_messages_conversation_id on public.messages(conversation_id);
create index if not exists idx_notifications_user_id on public.notifications(user_id);

alter table public.profiles enable row level security;
alter table public.salons enable row level security;
alter table public.posts enable row level security;
alter table public.post_likes enable row level security;
alter table public.bookings enable row level security;
alter table public.conversations enable row level security;
alter table public.conversation_participants enable row level security;
alter table public.messages enable row level security;
alter table public.notifications enable row level security;

drop policy if exists profiles_select_all on public.profiles;
create policy profiles_select_all on public.profiles for select using (true);
drop policy if exists profiles_insert_self on public.profiles;
create policy profiles_insert_self on public.profiles for insert with check (auth.uid() = id);
drop policy if exists profiles_update_self on public.profiles;
create policy profiles_update_self on public.profiles for update using (auth.uid() = id);

drop policy if exists salons_select_all on public.salons;
create policy salons_select_all on public.salons for select using (true);
drop policy if exists salons_insert_owner on public.salons;
create policy salons_insert_owner on public.salons for insert with check (auth.uid() = owner_id);
drop policy if exists salons_update_owner on public.salons;
create policy salons_update_owner on public.salons for update using (auth.uid() = owner_id);

drop policy if exists posts_select_all on public.posts;
create policy posts_select_all on public.posts for select using (visibility = 'public' or auth.uid() = author_id);
drop policy if exists posts_insert_author on public.posts;
create policy posts_insert_author on public.posts for insert with check (auth.uid() = author_id);
drop policy if exists posts_update_author on public.posts;
create policy posts_update_author on public.posts for update using (auth.uid() = author_id);

drop policy if exists post_likes_select_all on public.post_likes;
create policy post_likes_select_all on public.post_likes for select using (true);
drop policy if exists post_likes_insert_self on public.post_likes;
create policy post_likes_insert_self on public.post_likes for insert with check (auth.uid() = user_id);
drop policy if exists post_likes_delete_self on public.post_likes;
create policy post_likes_delete_self on public.post_likes for delete using (auth.uid() = user_id);

drop policy if exists bookings_select_related on public.bookings;
create policy bookings_select_related on public.bookings for select using (
  auth.uid() = customer_id
  or exists (select 1 from public.salons s where s.id = salon_id and s.owner_id = auth.uid())
);
drop policy if exists bookings_insert_customer on public.bookings;
create policy bookings_insert_customer on public.bookings for insert with check (auth.uid() = customer_id);
drop policy if exists bookings_update_related on public.bookings;
create policy bookings_update_related on public.bookings for update using (
  auth.uid() = customer_id
  or exists (select 1 from public.salons s where s.id = salon_id and s.owner_id = auth.uid())
);

drop policy if exists conversations_select_participant on public.conversations;
create policy conversations_select_participant on public.conversations for select using (
  exists (
    select 1 from public.conversation_participants cp
    where cp.conversation_id = id and cp.user_id = auth.uid()
  )
);

drop policy if exists conversation_participants_select_self on public.conversation_participants;
create policy conversation_participants_select_self on public.conversation_participants for select using (auth.uid() = user_id);
drop policy if exists conversation_participants_insert_self on public.conversation_participants;
create policy conversation_participants_insert_self on public.conversation_participants for insert with check (auth.uid() = user_id);

drop policy if exists messages_select_participant on public.messages;
create policy messages_select_participant on public.messages for select using (
  exists (
    select 1 from public.conversation_participants cp
    where cp.conversation_id = conversation_id and cp.user_id = auth.uid()
  )
);
drop policy if exists messages_insert_sender on public.messages;
create policy messages_insert_sender on public.messages for insert with check (
  auth.uid() = sender_id
  and exists (
    select 1 from public.conversation_participants cp
    where cp.conversation_id = conversation_id and cp.user_id = auth.uid()
  )
);

drop policy if exists notifications_select_self on public.notifications;
create policy notifications_select_self on public.notifications for select using (auth.uid() = user_id);
drop policy if exists notifications_update_self on public.notifications;
create policy notifications_update_self on public.notifications for update using (auth.uid() = user_id);
