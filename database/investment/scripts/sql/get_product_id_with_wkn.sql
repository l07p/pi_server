-- FUNCTION: public.get_product_id_with_wkn(text)

-- DROP FUNCTION public.get_product_id_with_wkn(text);

CREATE OR REPLACE FUNCTION public.get_product_id_with_wkn(
	p_wkn text,
	OUT p_id integer)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
SELECT id FROM products WHERE wkn = p_wkn INTO p_id;

END;
$BODY$;

ALTER FUNCTION public.get_product_id_with_wkn(text)
    OWNER TO pi;

COMMENT ON FUNCTION public.get_product_id_with_wkn(text)
    IS 'return product id with input wkn';