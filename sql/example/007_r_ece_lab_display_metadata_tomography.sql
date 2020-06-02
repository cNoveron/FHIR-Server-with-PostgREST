drop function if exists r_ece_lab_display_metadata_tomography;
 
create or replace function r_ece_lab_display_metadata_tomography(subject_id varchar)
	returns table(issued text)
as $$ 
	select resource->>'issued' from diagnosticreport 
	where resource->'code'->'coding'->0->>'code' = '72230-6'
	and resource->'subject'->>'id' = subject_id
$$ language sql;

--select * from r_ece_lab_display_metadata_tomography('29981aba-7c8a-4ad2-b3d3-483f9ad45533');
