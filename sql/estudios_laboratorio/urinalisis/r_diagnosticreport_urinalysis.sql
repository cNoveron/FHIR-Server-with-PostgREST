drop function if exists r_diagnosticreport_urinalysis;

create or replace function r_diagnosticreport_urinalysis(subject_id varchar)
	returns table(issued text)
as $$
	select
		resource->>'issued'
	from diagnosticreport
	where (
		resource->'code'->'coding'->0->>'code' = '24357-6'
		and
		resource->'subject'->>'id' = subject_id
	);
$$ language sql;

--select * from r_diagnosticreport_urinalysis('29981aba-7c8a-4ad2-b3d3-483f9ad45533');
