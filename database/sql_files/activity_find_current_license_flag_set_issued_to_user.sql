-- FUNCTION: public.activity_find_current_license_flag_set_issued_to_user(integer, text)

DROP FUNCTION IF EXISTS public.activity_find_current_license_flag_set_issued_to_user(integer, text);

CREATE OR REPLACE FUNCTION public.activity_find_current_license_flag_set_issued_to_user(
	p_user_id integer,
	p_user_email text DEFAULT ''::text)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_id integer;
    v_txt text;

BEGIN
    v_id := p_user_id;
    v_txt := p_user_email;
  
    /* if p_user_id > 0, find the latest issued flagset with largest id, returns issuedID*/
    IF v_id > 0 THEN
        SELECT license_flag_set_issued_id
          FROM view_find_license_flag_set_issued_to_user
          WHERE user_id = v_id
          ORDER BY license_flag_set_issued_id DESC LIMIT 1 INTO v_id;
    ELSE
      IF v_txt <> '' THEN
        SELECT id 
          FROM tbl_users
          WHERE email_address = v_txt
          ORDER BY id DESC LIMIT 1 INTO v_id;

          IF v_id > 0 THEN
            SELECT license_flag_set_issued_id
              FROM view_find_license_flag_set_issued_to_user
              WHERE user_id = v_id
              ORDER BY license_flag_set_issued_id DESC LIMIT 1 INTO v_id;
          END IF;
          
      END IF;
    END IF;

  RETURN v_id;
END;
$BODY$;

ALTER FUNCTION public.activity_find_current_license_flag_set_issued_to_user(integer, text)
    OWNER TO postgres;

COMMENT ON FUNCTION public.activity_find_current_license_flag_set_issued_to_user(integer, text)
    IS 'Current active license. if there are more than one, the longest one is selected';
