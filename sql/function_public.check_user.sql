create or replace function public.check_user() returns void as $$
begin
  if current_user = 'anonuser' then
    raise exception 'sin permisos'
      using hint = 'no puedes acceder con el usuario anónimo.';
  end if;
end
$$ language plpgsql;
