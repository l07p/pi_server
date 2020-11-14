--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: function_assign_account_product_to_order(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: pi
--

CREATE FUNCTION public.function_assign_account_product_to_order(p_account_id integer, p_product_id integer, p_order_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
	v_date timestamptz;
BEGIN
	SELECT date from orders WHERE id = p_order_id INTO v_date;
	
	INSERT INTO public.order_product_ref(
	order_id, product_id, date)
	VALUES (p_order_id, p_product_id, v_date);

	INSERT INTO public.account_order_ref(
	account_id, order_id, date)
	VALUES (p_account_id, p_order_id, v_date);
	
	RETURN p_order_id;
END;
$$;


ALTER FUNCTION public.function_assign_account_product_to_order(p_account_id integer, p_product_id integer, p_order_id integer) OWNER TO pi;

--
-- Name: FUNCTION function_assign_account_product_to_order(p_account_id integer, p_product_id integer, p_order_id integer); Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON FUNCTION public.function_assign_account_product_to_order(p_account_id integer, p_product_id integer, p_order_id integer) IS 'input account, product and order IDs
assign them to each other';


--
-- Name: function_get_order(double precision); Type: FUNCTION; Schema: public; Owner: pi
--

CREATE FUNCTION public.function_get_order(p_kurs double precision) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret_int integer;
BEGIN
	SELECT 
		id 
	FROM
		orders
	WHERE
		kurs = p_kurs
	INTO ret_int;
	
	return ret_int;
END;
$$;


ALTER FUNCTION public.function_get_order(p_kurs double precision) OWNER TO pi;

--
-- Name: function_insert_order(text, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: pi
--

CREATE FUNCTION public.function_insert_order(p_date text, p_stueck double precision, p_kurs double precision, p_provision double precision DEFAULT 1.5) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_int integer;
	v_time timestamp;

BEGIN
  v_time = TO_TIMESTAMP(p_date, 'YYYY-MM-DD HH:MI:SS');
  INSERT INTO orders(date, kurs, stueck, provision) 
           		VALUES(v_time , p_kurs, p_stueck, p_provision);
  
  SELECT last_value FROM orders_id_seq INTO v_int;

  RETURN v_int;
END;
$$;


ALTER FUNCTION public.function_insert_order(p_date text, p_stueck double precision, p_kurs double precision, p_provision double precision) OWNER TO pi;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_balances; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_balances (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    account_id integer NOT NULL,
    balance double precision NOT NULL
);


ALTER TABLE public.account_balances OWNER TO pi;

--
-- Name: TABLE account_balances; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.account_balances IS 'balance history. Different balance at different date';


--
-- Name: account_balances_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.account_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_balances_id_seq OWNER TO pi;

--
-- Name: account_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.account_balances_id_seq OWNED BY public.account_balances.id;


--
-- Name: account_order_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_order_ref (
    account_id integer NOT NULL,
    order_id integer NOT NULL,
    date timestamp with time zone
);


ALTER TABLE public.account_order_ref OWNER TO pi;

--
-- Name: COLUMN account_order_ref.date; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON COLUMN public.account_order_ref.date IS 'taken from order date, to make the dataset unique';


--
-- Name: account_type_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_type_ref (
    acount_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.account_type_ref OWNER TO pi;

--
-- Name: account_types; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_types (
    id integer NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE public.account_types OWNER TO pi;

--
-- Name: TABLE account_types; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.account_types IS 'giro, verrechnung or depot and etc';


--
-- Name: account_types_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.account_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_types_id_seq OWNER TO pi;

--
-- Name: account_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.account_types_id_seq OWNED BY public.account_types.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.accounts OWNER TO pi;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO pi;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.product_categories (
    id integer NOT NULL,
    category character varying(20) NOT NULL,
    parent_category character varying(20)
);


ALTER TABLE public.product_categories OWNER TO pi;

--
-- Name: TABLE product_categories; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.product_categories IS 'product category, notice his parent_category';


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO pi;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: order_product_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_product_ref (
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.order_product_ref OWNER TO pi;

--
-- Name: order_type_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_type_ref (
    order_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.order_type_ref OWNER TO pi;

--
-- Name: order_types; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_types (
    id integer NOT NULL,
    type character varying NOT NULL,
    note character varying
);


ALTER TABLE public.order_types OWNER TO pi;

--
-- Name: TABLE order_types; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.order_types IS 'buy, sale, close';


--
-- Name: order_types_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.order_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_types_id_seq OWNER TO pi;

--
-- Name: order_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.order_types_id_seq OWNED BY public.order_types.id;


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO pi;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.orders (
    date timestamp with time zone NOT NULL,
    kurs double precision NOT NULL,
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    stueck double precision NOT NULL,
    order_nr bigint,
    provision double precision DEFAULT 1.5
);


ALTER TABLE public.orders OWNER TO pi;

--
-- Name: COLUMN orders.order_nr; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON COLUMN public.orders.order_nr IS 'some of banks offers order number. or it could be rechnungsnummber';


--
-- Name: product_category_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.product_category_ref (
    product_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product_category_ref OWNER TO pi;

--
-- Name: TABLE product_category_ref; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.product_category_ref IS 'conf table between products and categories. one product belongs to one category. but, on category can include multiple products';


--
-- Name: products; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.products (
    id integer NOT NULL,
    wkn character varying(6) NOT NULL,
    isin character varying(12) NOT NULL,
    google_symbol character varying,
    name character varying(100) NOT NULL
);


ALTER TABLE public.products OWNER TO pi;

--
-- Name: TABLE products; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.products IS 'include wkn and isin';


--
-- Name: COLUMN products.google_symbol; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON COLUMN public.products.google_symbol IS 'google finance symbol. kurs data download';


--
-- Name: COLUMN products.name; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON COLUMN public.products.name IS 'product name';


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: pi
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO pi;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: view_order_product; Type: VIEW; Schema: public; Owner: pi
--

CREATE VIEW public.view_order_product AS
 SELECT products.name,
    order_product_ref.order_id,
    orders.date,
    orders.stueck,
    orders.kurs
   FROM public.products,
    public.order_product_ref,
    public.orders
  WHERE ((products.id = order_product_ref.product_id) AND (orders.id = order_product_ref.order_id));


ALTER TABLE public.view_order_product OWNER TO pi;

--
-- Name: account_balances id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_balances ALTER COLUMN id SET DEFAULT nextval('public.account_balances_id_seq'::regclass);


--
-- Name: account_types id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_types ALTER COLUMN id SET DEFAULT nextval('public.account_types_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: order_types id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_types ALTER COLUMN id SET DEFAULT nextval('public.order_types_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: account_balances; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_balances (id, date, account_id, balance) FROM stdin;
\.


--
-- Data for Name: account_order_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_order_ref (account_id, order_id, date) FROM stdin;
1	1	2020-10-01 00:00:00+00
2	3	2020-10-05 00:00:00+00
2	4	2020-10-05 00:00:00+00
\.


--
-- Data for Name: account_type_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_type_ref (acount_id, type_id) FROM stdin;
1	2
\.


--
-- Data for Name: account_types; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_types (id, type) FROM stdin;
1	giro
2	depot
3	verrechnung
4	spar
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.accounts (id, name) FROM stdin;
1	consors505
2	DKB_Depot
\.


--
-- Data for Name: order_product_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_product_ref (order_id, product_id, date) FROM stdin;
1	3	2020-10-01 00:00:00+00
3	11	2020-10-05 00:00:00+00
4	12	2020-10-05 00:00:00+00
\.


--
-- Data for Name: order_type_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_type_ref (order_id, type_id) FROM stdin;
1	1
\.


--
-- Data for Name: order_types; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_types (id, type, note) FROM stdin;
2	sale	if VERKAUF
1	buy	''if KAUF
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.orders (date, kurs, id, stueck, order_nr, provision) FROM stdin;
2020-10-01 00:00:00+00	122.96	1	4.07	\N	\N
2020-10-05 00:00:00+00	577.6	4	0.8657	\N	\N
2020-10-05 00:00:00+00	28.305	3	17.6647	\N	1.5
2020-10-20 00:00:00+00	5.54	6	90.2527	\N	1.5
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.product_categories (id, category, parent_category) FROM stdin;
1	ETF	''Sparplan
\.


--
-- Data for Name: product_category_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.product_category_ref (product_id, category_id) FROM stdin;
1	1
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.products (id, wkn, isin, google_symbol, name) FROM stdin;
1	628930	DE0006289309	EXX1	iShares EURO STOXX Banks 30-15 UCI
2	DBX1SM		DBXS	XTR.SWITZERLAND 1D
4	A0Q4R2	DE000A0Q4R28	EXV5	iShares STOXX Europe 600 Automobiles & Parts UCITS ETF (DE)
8	LYX0FS	LU0496786574	LYPS	Lyxor S&P 500 UCITS ETF
9	A0H08M	DE000A0H08M3	EXH1	iShares STOXX Europe 600 Oil & Gas UCITS ETF (DE)
10	541779	FR0007056841	DJAM	LYX.D.JON.IN.AV.U.ETF D
12	A0YEDL	IE00B53SZB19	SXRV	iShares NASDAQ 100 UCITS ETF
3	DBX1DA	LU0274211480	DBXD 	Xtrackers DAX® UCITS ETF 1
11	593397	DE0005933972	EXS2	ISHARES TECDAX UCITS ETF DE
\.


--
-- Name: account_balances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.account_balances_id_seq', 1, false);


--
-- Name: account_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.account_types_id_seq', 4, true);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.accounts_id_seq', 2, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, true);


--
-- Name: order_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.order_types_id_seq', 2, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.orders_id_seq', 6, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.products_id_seq', 13, true);


--
-- Name: account_types account_types_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT account_types_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: product_categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: products isin; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT isin UNIQUE (isin);


--
-- Name: accounts name; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT name UNIQUE (name);


--
-- Name: order_types order_types_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT order_types_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: order_product_ref unique_date; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_product_ref
    ADD CONSTRAINT unique_date UNIQUE (date, order_id, product_id);


--
-- Name: CONSTRAINT unique_date ON order_product_ref; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON CONSTRAINT unique_date ON public.order_product_ref IS 'unique date for orders. one order for same product once a time';


--
-- Name: products wkn; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT wkn UNIQUE (wkn);


--
-- Name: fk_order_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fk_order_id ON public.order_product_ref USING btree (order_id);


--
-- Name: fki_account; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_account ON public.account_order_ref USING btree (account_id);


--
-- Name: fki_account_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_account_id ON public.account_type_ref USING btree (acount_id);


--
-- Name: fki_accout_type_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_accout_type_id ON public.account_type_ref USING btree (type_id);


--
-- Name: fki_category_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_category_id ON public.product_category_ref USING btree (category_id);


--
-- Name: fki_fk_account; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_fk_account ON public.account_balances USING btree (account_id);


--
-- Name: fki_order; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_order ON public.account_order_ref USING btree (order_id);


--
-- Name: fki_order_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_order_id ON public.order_type_ref USING btree (order_id);


--
-- Name: fki_product; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_product ON public.order_product_ref USING btree (product_id);


--
-- Name: fki_product_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_product_id ON public.product_category_ref USING btree (product_id);


--
-- Name: fki_type_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_type_id ON public.order_type_ref USING btree (type_id);


--
-- Name: account_order_ref account; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_order_ref
    ADD CONSTRAINT account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;


--
-- Name: account_balances account; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;


--
-- Name: CONSTRAINT account ON account_balances; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON CONSTRAINT account ON public.account_balances IS 'assign it to an account ';


--
-- Name: account_type_ref account_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT account_id FOREIGN KEY (acount_id) REFERENCES public.accounts(id) NOT VALID;


--
-- Name: account_type_ref account_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT account_type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;


--
-- Name: product_category_ref category_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category_ref
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.product_categories(id) NOT VALID;


--
-- Name: account_balances fk_account; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;


--
-- Name: CONSTRAINT fk_account ON account_balances; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON CONSTRAINT fk_account ON public.account_balances IS 'assign it to an account ';


--
-- Name: account_order_ref order; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_order_ref
    ADD CONSTRAINT "order" FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- Name: order_product_ref order; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_product_ref
    ADD CONSTRAINT "order" FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- Name: order_type_ref order_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_type_ref
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- Name: order_product_ref product; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_product_ref
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- Name: product_category_ref product_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category_ref
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- Name: order_type_ref type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_type_ref
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.order_types(id) NOT VALID;


--
-- Name: account_type_ref type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

