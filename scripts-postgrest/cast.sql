create or replace function tsrange_to_json(tsrange) returns json as $$
  select json_build_object(
    'lower', lower($1)
  , 'upper', upper($1)
  , 'lower_inc', lower_inc($1)
  , 'upper_inc', upper_inc($1)
  );
$$ language sql;

create cast (tsrange as json) with function tsrange_to_json(tsrange) as assignment;

-- drop cast (tsrange as json);
-- drop function tsrange_to_json;