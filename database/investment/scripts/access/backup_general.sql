--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4 (Ubuntu 12.4-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.4

-- Started on 2020-10-15 22:35:56

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
-- TOC entry 2964 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 206 (class 1259 OID 16428)
-- Name: categories; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    category character varying(20) NOT NULL,
    parent_category character varying(20)
);


ALTER TABLE public.categories OWNER TO pi;

--
-- TOC entry 2965 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE categories; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.categories IS 'product category, notice his parent_category';


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
-- TOC entry 2966 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


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
    stueck integer NOT NULL,
    kurs double precision NOT NULL,
    id integer DEFAULT nextval('public.orders_id_seq'::regclass) NOT NULL,
    CONSTRAINT "positive stueck" CHECK ((stueck > 0))
);


ALTER TABLE public.orders OWNER TO pi;

--
-- TOC entry 2967 (class 0 OID 0)
-- Dependencies: 208
-- Name: CONSTRAINT "positive stueck" ON orders; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON CONSTRAINT "positive stueck" ON public.orders IS 'number of ordered product is larger than 0';


--
-- TOC entry 207 (class 1259 OID 16434)
-- Name: product_category; Type: TABLE; Schema: public; Owner: pi
--

CREATE TABLE public.product_category (
    product_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.product_category OWNER TO pi;

--
-- TOC entry 2968 (class 0 OID 0)
-- Dependencies: 207
-- Name: TABLE product_category; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.product_category IS 'conf table between products and categories. one product belongs to one category. but, on category can include multiple products';


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
-- TOC entry 2969 (class 0 OID 0)
-- Dependencies: 204
-- Name: TABLE products; Type: COMMENT; Schema: public; Owner: pi
--

COMMENT ON TABLE public.products IS 'include wkn and isin';


--
-- TOC entry 2970 (class 0 OID 0)
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
-- TOC entry 2971 (class 0 OID 0)
-- Dependencies: 203
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pi
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 2815 (class 2604 OID 16431)
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- TOC entry 2814 (class 2604 OID 16420)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 2955 (class 0 OID 16428)
-- Dependencies: 206
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.categories (id, category, parent_category) FROM stdin;
1	ETF	
\.


--
-- TOC entry 2957 (class 0 OID 16464)
-- Dependencies: 208
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.orders (date, stueck, kurs, id) FROM stdin;
\.


--
-- TOC entry 2956 (class 0 OID 16434)
-- Dependencies: 207
-- Data for Name: product_category; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.product_category (product_id, category_id) FROM stdin;
1	1
\.


--
-- TOC entry 2953 (class 0 OID 16417)
-- Dependencies: 204
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: pi
--

COPY public.products (id, wkn, isin, info_link, name) FROM stdin;
1	628930	DE0006289309	https://kurse.boerse.ard.de/ard/etf_einzelkurs_uebersicht.htn?i=104063	iShares EURO STOXX Banks 30-15 UCI
\.


--
-- TOC entry 2972 (class 0 OID 0)
-- Dependencies: 205
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.categories_id_seq', 1, true);


--
-- TOC entry 2973 (class 0 OID 0)
-- Dependencies: 209
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 203
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pi
--

SELECT pg_catalog.setval('public.products_id_seq', 1, true);


--
-- TOC entry 2821 (class 2606 OID 16433)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 2819 (class 2606 OID 16425)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2822 (class 1259 OID 16448)
-- Name: fki_category_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_category_id ON public.product_category USING btree (category_id);


--
-- TOC entry 2823 (class 1259 OID 16442)
-- Name: fki_product_id; Type: INDEX; Schema: public; Owner: pi
--

CREATE INDEX fki_product_id ON public.product_category USING btree (product_id);


--
-- TOC entry 2825 (class 2606 OID 16443)
-- Name: product_category category_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT category_id FOREIGN KEY (category_id) REFERENCES public.categories(id) NOT VALID;


--
-- TOC entry 2824 (class 2606 OID 16437)
-- Name: product_category product_id; Type: FK CONSTRAINT; Schema: public; Owner: pi
--

ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;


-- Completed on 2020-10-15 22:35:56

--
-- PostgreSQL database dump complete
--

