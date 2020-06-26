drop function if exists r_practitioners_by_serviceType;

create or replace function r_practitioners_by_serviceType(
    serviceType_code text
)
returns table(
    practitioner_id text,
    practitioner_name jsonb,
    practitioner_specialty text,
    practitioner_telecom jsonb
)
as $$
	select
		resource ->> 'id',
		resource #> '{name,0}',
		resource #>> '{specialty,0,coding,0,display}',
		resource #> '{telecom}'
	from practitioner
    where (
		practitioner.resource ->> 'id' in(
            select
                resource ->> 'id'
            from schedule
            where(
                schedule.resource @> ('{"serviceType":[{"coding":[{"code":"'||serviceType_code||'"}]}]}')::jsonb
            )
		)
    );
$$ language sql;