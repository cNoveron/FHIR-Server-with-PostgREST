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