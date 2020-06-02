drop function if exists r_diagnosticreport_blood_count;

create or replace function r_diagnosticreport_blood_count(
	subject_id varchar
)
returns table(
	issued_date text,
	category_name_1 text,
	category_name_2 text
)
as $$
	select
		resource ->> 'issued',
		resource #>> '{category,0,coding,0,display}',
		resource #>> '{category,0,coding,1,display}'
	from diagnosticreport
	where (
		resource #>> '{code,coding,0,code}' = '58410-2'
		and
		resource #>> '{subject,id}' = subject_id
	);
$$ language sql;

--select * from r_diagnosticreport_blood_count('29981aba-7c8a-4ad2-b3d3-483f9ad45533');
