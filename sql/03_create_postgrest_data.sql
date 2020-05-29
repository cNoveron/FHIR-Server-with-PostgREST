-- Create anon_web user
do
$do$
begin
   if not exists (
      select
      from pg_catalog.pg_roles
      where rolname = 'web_anon') then
      create role web_anon nologin;
   end if;
end
$do$;

grant usage on schema public to web_anon;

-- Create authenticator user
do
$do$
begin
   if not exists (
      select
      from pg_catalog.pg_roles
      where rolname = 'authenticator') then
      create role authenticator login password 'd3s4rr0ll0';
   end if;
end
$do$;

grant web_anon to authenticator;