-- drop function if exists r_consultations;

-- create or replace function r_consultations(_id varchar)
-- 	returns table(slot_id jsonb, start jsonb)
-- as $$
-- 	-- select resource->'id',resource->'start' from appointment
-- 	-- where resource->'slot'->>'id'=_id;
	select
		resource -> 'id',
		resource -> 'start'
	from
		appointment,
		jsonb_array_elements(resource -> 'slot') slot
	where(
		slot ->> 'id' in(
			select
				resource ->> 'id'
			from
				slot
			where(
				resource -> 'schedule' ->> 'id' in(
					select
						resource ->> 'id'
					from
						schedule,
						jsonb_array_elements(resource -> 'actor') actor
					where(
						actor ->> 'id' = '1'
					)
				)
			)
		)
	);
-- $$ language sql;

select resource->'id' from appointment
where resource -> 'slot' @> '[{"id": "010639847"}]';

select
  jsonb_array_elements(resource -> 'name')
from patient;
-- select * from r_consultations('0963458975');

select
  value->>'id'
from appointment, jsonb_array_elements(resource -> 'slot');

select
  resource ->> 'id' as schedule_id,
  value ->> 'id' as actor_id
from schedule,
  jsonb_array_elements(resource -> 'actor') actor
where(actor ->> 'id' = '1');
