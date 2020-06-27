do language plpgsql
$body$
declare
   l_old_schema name = 'old_schema';
   l_new_schema name = 'new_schema';
   l_sql text;
begin
  for l_sql in
    select
        format('alter table %i.%i set schema %i', n.nspname, c.relname, l_new_schema)
      from pg_class c
      join pg_namespace n on n.oid = c.relnamespace
      where
        n.nspname = l_old_schema and
        c.relkind = 'r'
  loop
    raise notice 'appliying %', l_sql;
    execute l_sql;
  end loop;
end;
$body$;
