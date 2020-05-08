CREATE OR REPLACE FUNCTION public.check_user() RETURNS void AS $$
BEGIN
  IF current_user = 'anonuser' THEN
    RAISE EXCEPTION 'Sin permisos'
      USING HINT = 'No puedes acceder con el usuario anónimo.';
  END IF;
END
$$ LANGUAGE plpgsql;
