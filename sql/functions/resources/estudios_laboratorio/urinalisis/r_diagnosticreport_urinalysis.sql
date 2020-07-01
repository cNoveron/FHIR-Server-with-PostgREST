drop function if exists r_diagnosticreport_urinalysis;

create or replace function r_diagnosticreport_urinalysis(
	subject_id text
)
returns table(
	issued_date text,
	category_name text,
	diagnosticreport_name text
)
as $$
	select
		resource ->> 'issued',
		resource #>> '{category,0,coding,0,display}',
		resource #>> '{code,coding,0,display}'
	from diagnosticreport
	where (
		resource #>> '{code,coding,0,code}' = '72230-6'
		and
		resource #>> '{subject,id}' = subject_id
	);
$$ language sql;