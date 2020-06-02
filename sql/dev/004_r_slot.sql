drop function if exists r_slot;
 
create or replace function r_slot(_id varchar)
	returns table(slot_id jsonb, start jsonb) 
as $$ 
	select resource->'id', resource->'start' from slot 
	where resource->'schedule'->>'id'=_id;
$$ language sql;

-- select * from r_slot('0963458975');
