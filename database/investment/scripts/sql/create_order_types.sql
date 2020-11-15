-- Table: public.order_types

-- DROP TABLE public.order_types;

CREATE TABLE public.order_types
(
    id integer NOT NULL DEFAULT nextval('order_types_id_seq'::regclass),
    type character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT order_types_pkey PRIMARY KEY (id),
    CONSTRAINT unique_order_type UNIQUE (type)
)

TABLESPACE pg_default;

ALTER TABLE public.order_types
    OWNER to pi;

COMMENT ON TABLE public.order_types
    IS 'ETF, Convertible bonds and so on';