--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4

-- Started on 2020-10-17 23:34:12

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
-- TOC entry 1 (class 3079 OID 16386)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16548)
-- Name: account_order_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_order_ref (
    account_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.account_order_ref OWNER TO pi;

--
-- TOC entry 217 (class 1259 OID 16528)
-- Name: account_type_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_type_ref (
    acount_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.account_type_ref OWNER TO pi;

--
-- TOC entry 216 (class 1259 OID 16519)
-- Name: account_types; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.account_types (
    id integer NOT NULL,
    type character varying NOT NULL
);


ALTER TABLE public.account_types OWNER TO pi;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE account_types; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.account_types IS 'giro, verrechnung or depot and etc';


--
-- TOC entry 215 (class 1259 OID 16517)
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
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 215
-- Name: account_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.account_types_id_seq OWNED BY public.account_types.id;


--
-- TOC entry 214 (class 1259 OID 16508)
-- Name: accounts; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.accounts OWNER TO pi;

--
-- TOC entry 213 (class 1259 OID 16506)
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
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 213
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- TOC entry 206 (class 1259 OID 16428)
-- Name: product_categories; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.product_categories (
    id integer NOT NULL,
    category character varying(20) NOT NULL,
    parent_category character varying(20)
);


ALTER TABLE public.product_categories OWNER TO pi;

--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE product_categories; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.product_categories IS 'product category, notice his parent_category';


--
-- TOC entry 205 (class 1259 OID 16426)
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
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.product_categories.id;


--
-- TOC entry 219 (class 1259 OID 16568)
-- Name: order_product_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_product_ref (
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.order_product_ref OWNER TO pi;

--
-- TOC entry 212 (class 1259 OID 16489)
-- Name: order_type_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_type_ref (
    order_id integer NOT NULL,
    type_id integer NOT NULL
);


ALTER TABLE public.order_type_ref OWNER TO pi;

--
-- TOC entry 211 (class 1259 OID 16480)
-- Name: order_types; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.order_types (
    id integer NOT NULL,
    type character varying NOT NULL,
    note character varying
);


ALTER TABLE public.order_types OWNER TO pi;

--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 211
-- Name: TABLE order_types; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.order_types IS 'buy, sale, close';


--
-- TOC entry 210 (class 1259 OID 16478)
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
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 210
-- Name: order_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.order_types_id_seq OWNED BY public.order_types.id;


--
-- TOC entry 209 (class 1259 OID 16472)
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
-- TOC entry 208 (class 1259 OID 16464)
-- Name: orders; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.orders (
    date timestamp with time zone NOT NULL,
    kurs double precision NOT NULL,
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    stueck double precision NOT NULL
);


ALTER TABLE public.orders OWNER TO pi;

--
-- TOC entry 207 (class 1259 OID 16434)
-- Name: product_category_ref; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.product_category_ref (
    product_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product_category_ref OWNER TO pi;

--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE product_category_ref; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.product_category_ref IS 'conf table between products and categories. one product belongs to one category. but, on category can include multiple products';


--
-- TOC entry 204 (class 1259 OID 16417)
-- Name: products; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.products (
    id integer NOT NULL,
    wkn character varying(6) NOT NULL,
    isin character varying(12) NOT NULL,
    info_link character varying,
    name character varying(50) NOT NULL
);


ALTER TABLE public.products OWNER TO pi;

--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE products; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.products IS 'include wkn and isin';


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 204
-- Name: COLUMN products.name; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON COLUMN public.products.name IS 'product name';


--
-- TOC entry 203 (class 1259 OID 16415)
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
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 203
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 2856 (class 2604 OID 16522)
-- Name: account_types id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_types ALTER COLUMN id SET DEFAULT nextval('public.account_types_id_seq'::regclass);


--
-- TOC entry 2855 (class 2604 OID 16511)
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- TOC entry 2854 (class 2604 OID 16483)
-- Name: order_types id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_types ALTER COLUMN id SET DEFAULT nextval('public.order_types_id_seq'::regclass);


--
-- TOC entry 2852 (class 2604 OID 16431)
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2851 (class 2604 OID 16420)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 3031 (class 0 OID 16548)
-- Dependencies: 218
-- Data for Name: account_order_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_order_ref (account_id, order_id) FROM stdin;
1	1
\.


--
-- TOC entry 3030 (class 0 OID 16528)
-- Dependencies: 217
-- Data for Name: account_type_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_type_ref (acount_id, type_id) FROM stdin;
1	2
\.


--
-- TOC entry 3029 (class 0 OID 16519)
-- Dependencies: 216
-- Data for Name: account_types; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.account_types (id, type) FROM stdin;
1	giro
2	depot
3	verrechnung
4	spar
\.


--
-- TOC entry 3027 (class 0 OID 16508)
-- Dependencies: 214
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.accounts (id, name) FROM stdin;
1	consors505
\.


--
-- TOC entry 3032 (class 0 OID 16568)
-- Dependencies: 219
-- Data for Name: order_product_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_product_ref (order_id, product_id, date) FROM stdin;
1	3	2020-10-01 00:00:00+00
\.


--
-- TOC entry 3025 (class 0 OID 16489)
-- Dependencies: 212
-- Data for Name: order_type_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_type_ref (order_id, type_id) FROM stdin;
1	1
\.


--
-- TOC entry 3024 (class 0 OID 16480)
-- Dependencies: 211
-- Data for Name: order_types; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.order_types (id, type, note) FROM stdin;
2	sale	if VERKAUF
1	buy	''if KAUF
\.


--
-- TOC entry 3021 (class 0 OID 16464)
-- Dependencies: 208
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.orders (date, kurs, id, stueck) FROM stdin;
2020-10-01 00:00:00+00	122.96	1	4.07
\.


--
-- TOC entry 3019 (class 0 OID 16428)
-- Dependencies: 206
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.product_categories (id, category, parent_category) FROM stdin;
1	ETF	''Sparplan
\.


--
-- TOC entry 3020 (class 0 OID 16434)
-- Dependencies: 207
-- Data for Name: product_category_ref; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.product_category_ref (product_id, category_id) FROM stdin;
1	1
\.


--
-- TOC entry 3017 (class 0 OID 16417)
-- Dependencies: 204
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.products (id, wkn, isin, info_link, name) FROM stdin;
1	628930	DE0006289309	https://kurse.boerse.ard.de/ard/etf_einzelkurs_uebersicht.htn?i=104063	iShares EURO STOXX Banks 30-15 UCI
2	DBX1SM			XTR.SWITZERLAND 1D
3	DBX1DA	LU0274211480	https://kurse.boerse.ard.de/ard/etf_einzelkurs_uebersicht.htn?i=666336	Xtrackers DAX® UCITS ETF 1
\.


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 215
-- Name: account_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.account_types_id_seq', 4, true);


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 213
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, true);


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 210
-- Name: order_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.order_types_id_seq', 2, true);


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 209
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 203
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.products_id_seq', 3, true);


--
-- TOC entry 2872 (class 2606 OID 16527)
-- Name: account_types account_types_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT account_types_pkey PRIMARY KEY (id);


--
-- TOC entry 2870 (class 2606 OID 16516)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 2860 (class 2606 OID 16433)
-- Name: product_categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2866 (class 2606 OID 16488)
-- Name: order_types order_types_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT order_types_pkey PRIMARY KEY (id);


--
-- TOC entry 2864 (class 2606 OID 16493)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- TOC entry 2858 (class 2606 OID 16425)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2877 (class 1259 OID 16586)
-- Name: fk_order_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fk_order_id ON public.order_product_ref USING btree (order_id);


--
-- TOC entry 2875 (class 1259 OID 16561)
-- Name: fki_account; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_account ON public.account_order_ref USING btree (account_id);


--
-- TOC entry 2873 (class 1259 OID 16536)
-- Name: fki_account_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_account_id ON public.account_type_ref USING btree (acount_id);


--
-- TOC entry 2874 (class 1259 OID 16547)
-- Name: fki_accout_type_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_accout_type_id ON public.account_type_ref USING btree (type_id);


--
-- TOC entry 2861 (class 1259 OID 16448)
-- Name: fki_category_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_category_id ON public.product_category_ref USING btree (category_id);


--
-- TOC entry 2876 (class 1259 OID 16567)
-- Name: fki_order; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_order ON public.account_order_ref USING btree (order_id);


--
-- TOC entry 2867 (class 1259 OID 16499)
-- Name: fki_order_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_order_id ON public.order_type_ref USING btree (order_id);


--
-- TOC entry 2878 (class 1259 OID 16592)
-- Name: fki_product; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_product ON public.order_product_ref USING btree (product_id);


--
-- TOC entry 2862 (class 1259 OID 16442)
-- Name: fki_product_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_product_id ON public.product_category_ref USING btree (product_id);


--
-- TOC entry 2868 (class 1259 OID 16505)
-- Name: fki_type_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_type_id ON public.order_type_ref USING btree (type_id);


--
-- TOC entry 2886 (class 2606 OID 16556)
-- Name: account_order_ref account; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_order_ref
    ADD CONSTRAINT account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;


--
-- TOC entry 2883 (class 2606 OID 16531)
-- Name: account_type_ref account_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT account_id FOREIGN KEY (acount_id) REFERENCES public.accounts(id) NOT VALID;


--
-- TOC entry 2885 (class 2606 OID 16542)
-- Name: account_type_ref account_type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT account_type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;


--
-- TOC entry 2880 (class 2606 OID 16443)
-- Name: product_category_ref category_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category_ref
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.product_categories(id) NOT VALID;


--
-- TOC entry 2887 (class 2606 OID 16562)
-- Name: account_order_ref order; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_order_ref
    ADD CONSTRAINT "order" FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- TOC entry 2888 (class 2606 OID 16571)
-- Name: order_product_ref order; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_product_ref
    ADD CONSTRAINT "order" FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- TOC entry 2881 (class 2606 OID 16494)
-- Name: order_type_ref order_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_type_ref
    ADD CONSTRAINT order_id FOREIGN KEY (order_id) REFERENCES public.orders(id) NOT VALID;


--
-- TOC entry 2889 (class 2606 OID 16587)
-- Name: order_product_ref product; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_product_ref
    ADD CONSTRAINT product FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- TOC entry 2879 (class 2606 OID 16437)
-- Name: product_category_ref product_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category_ref
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


--
-- TOC entry 2882 (class 2606 OID 16500)
-- Name: order_type_ref type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.order_type_ref
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.order_types(id) NOT VALID;


--
-- TOC entry 2884 (class 2606 OID 16537)
-- Name: account_type_ref type_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.account_type_ref
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;


-- Completed on 2020-10-17 23:34:13

--
-- PostgreSQL database dump complete
--

