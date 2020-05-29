drop function if exists get_id_from_diagnosticreport;
 
create or replace function get_id_from_diagnosticreport(code varchar)
returns setof jsonb as
$$
select resource->'id' from diagnosticreport
where (resource->'category'->0->'coding'->0->>'code' = code);
$$ language sql;
