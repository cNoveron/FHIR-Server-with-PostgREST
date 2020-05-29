drop function if exists r_consultations;
 
create or replace function r_consultations(_id varchar)
	returns table(slot_id jsonb, start jsonb) 
as $$ 
	select resource->'id',resource->'start' from appointment 
	where resource->'slot'->>'id'=_id;
$$ language sql;

-- select * from r_consultations('0963458975');
