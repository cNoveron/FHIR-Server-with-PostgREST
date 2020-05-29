drop function if exists r_ece_lab_display_metadata;
 
create or replace function r_ece_lab_display_metadata(
	code varchar,
	subject_id varchar
)
	returns table(issued text)
as $$ 
	select resource->>'issued' from diagnosticreport 
	where resource->'code'->'coding'->0->>'code' = code
	and resource->'subject'->>'id' = subject_id
$$ language sql;


--select * from r_ece_lab_display_metadata('57698-3', 'd3af67c9-0c02-45f2-bc91-fea45af3ee83');