drop function if exists r_diagnosticreport_blood_count;

create or replace function r_diagnosticreport_blood_count(subject_id varchar)
	returns table(issued text)
as $$
	select
		resource->>'issued'
	from diagnosticreport
	where (
		resource->'code'->'coding'->0->>'code' = '58410-2'
		and
		resource->'subject'->>'id' = subject_id
	);
$$ language sql;

--select * from r_diagnosticreport_blood_count('29981aba-7c8a-4ad2-b3d3-483f9ad45533');
