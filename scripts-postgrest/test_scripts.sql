select * from diagnosticreport;

select jsonb_object_keys(resource) from diagnosticreport;

select resource->'id' from diagnosticreport where (resource->'category'->0->'coding'->0->>'code' = '34117-2');

select * from get_id_from_diagnosticreport('34117-2');
