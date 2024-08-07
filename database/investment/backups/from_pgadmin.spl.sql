PGDMP     5    -                y         
   investment #   12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)    13.1 �    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            *           1262    16385 
   investment    DATABASE     [   CREATE DATABASE investment WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C.UTF-8';
    DROP DATABASE investment;
                postgres    false                        3079    16386 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            +           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    1            �            1255    24972 +   get_product_id_with_isin(character varying)    FUNCTION     �   CREATE FUNCTION public.get_product_id_with_isin(p_isin character varying, OUT p_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
SELECT id FROM products WHERE isin = p_isin INTO p_id;

END;
$$;
 [   DROP FUNCTION public.get_product_id_with_isin(p_isin character varying, OUT p_id integer);
       public          pi    false            ,           0    0 M   FUNCTION get_product_id_with_isin(p_isin character varying, OUT p_id integer)    COMMENT     w   COMMENT ON FUNCTION public.get_product_id_with_isin(p_isin character varying, OUT p_id integer) IS 'as function name';
          public          pi    false    230            �            1255    24751    get_product_id_with_wkn(text)    FUNCTION     �   CREATE FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
SELECT id FROM products WHERE wkn = p_wkn INTO p_id;

END;
$$;
 L   DROP FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer);
       public          pi    false            -           0    0 >   FUNCTION get_product_id_with_wkn(p_wkn text, OUT p_id integer)    COMMENT     x   COMMENT ON FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer) IS 'return product id with input wkn';
          public          pi    false    229            �            1255    24878 M   update_date_of_balance(integer, character varying, double precision, integer)    FUNCTION     a  CREATE FUNCTION public.update_date_of_balance(p_id integer DEFAULT 1, p_date character varying DEFAULT '1997-7-1'::character varying, p_balance double precision DEFAULT 1.0, p_account_id integer DEFAULT 1) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_date timestamp;
BEGIN
	SELECT TO_DATE(p_date, 'YYYY-MM-DD') INTO v_date;
	
	if p_id > 0 then
		UPDATE public.account_balances
		SET date=v_date, balance=p_balance, account_id=p_account_id
		WHERE id=p_id;
	else
		INSERT INTO account_balances(date,balance,account_id)
		VALUES (v_date, p_balance, p_account_id);
	end if;
	
	RETURN p_id;
END;
$$;
 �   DROP FUNCTION public.update_date_of_balance(p_id integer, p_date character varying, p_balance double precision, p_account_id integer);
       public          pi    false            .           0    0 y   FUNCTION update_date_of_balance(p_id integer, p_date character varying, p_balance double precision, p_account_id integer)    COMMENT     �   COMMENT ON FUNCTION public.update_date_of_balance(p_id integer, p_date character varying, p_balance double precision, p_account_id integer) IS 'test parameter of string to update it as date(timestamp). return id of updated dateset';
          public          pi    false    243            �            1255    24974 x   update_product_value(integer, character varying, double precision, double precision, double precision, integer, integer)    FUNCTION        CREATE FUNCTION public.update_product_value(p_id integer, p_date character varying, p_stueck double precision, p_einstandskurs double precision, p_kurs double precision, p_account_id integer, p_product_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_date timestamp;
BEGIN
	SELECT TO_DATE(p_date, 'YYYY-MM-DD') INTO v_date;
	
	if p_id > 0 then
		UPDATE public.product_values
		SET date=v_date, stueck=p_stueck, einstandskurs=p_einstandskurs, kurs=p_kurs, account_id=p_account_id, product_id=p_product_id
		WHERE id=p_id;
	else
		INSERT INTO product_values(date,stueck,einstandskurs, kurs, account_id,product_id)
		VALUES (v_date, p_stueck, p_einstandskurs, p_kurs, p_account_id, p_product_id);
		
		SELECT MAX(id) FROM product_values INTO p_id;
	end if;
	
	RETURN p_id;
END;
$$;
 �   DROP FUNCTION public.update_product_value(p_id integer, p_date character varying, p_stueck double precision, p_einstandskurs double precision, p_kurs double precision, p_account_id integer, p_product_id integer);
       public          pi    false            /           0    0 �   FUNCTION update_product_value(p_id integer, p_date character varying, p_stueck double precision, p_einstandskurs double precision, p_kurs double precision, p_account_id integer, p_product_id integer)    COMMENT     �   COMMENT ON FUNCTION public.update_product_value(p_id integer, p_date character varying, p_stueck double precision, p_einstandskurs double precision, p_kurs double precision, p_account_id integer, p_product_id integer) IS 'input date and other values';
          public          pi    false    244            �            1259    24774    account_balances    TABLE     �   CREATE TABLE public.account_balances (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    balance double precision NOT NULL,
    account_id integer NOT NULL
);
 $   DROP TABLE public.account_balances;
       public         heap    pi    false            0           0    0    TABLE account_balances    COMMENT     Q   COMMENT ON TABLE public.account_balances IS 'balance history on course of time';
          public          pi    false    214            �            1259    24772    account_balances_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.account_balances_id_seq;
       public          pi    false    214            1           0    0    account_balances_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.account_balances_id_seq OWNED BY public.account_balances.id;
          public          pi    false    213            �            1259    24795    account_types    TABLE     d   CREATE TABLE public.account_types (
    id integer NOT NULL,
    type character varying NOT NULL
);
 !   DROP TABLE public.account_types;
       public         heap    pi    false            �            1259    24793    account_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.account_types_id_seq;
       public          pi    false    216            2           0    0    account_types_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.account_types_id_seq OWNED BY public.account_types.id;
          public          pi    false    215            �            1259    24697    accounts    TABLE     �   CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    type_id integer NOT NULL,
    bank_id integer
);
    DROP TABLE public.accounts;
       public         heap    pi    false            3           0    0    COLUMN accounts.type_id    COMMENT     O   COMMENT ON COLUMN public.accounts.type_id IS 'account of save, depot or giro';
          public          pi    false    206            �            1259    24695    accounts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.accounts_id_seq;
       public          pi    false    206            4           0    0    accounts_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;
          public          pi    false    205            �            1259    24851    banks    TABLE     �   CREATE TABLE public.banks (
    id integer NOT NULL,
    name character varying NOT NULL,
    link character varying,
    operation character varying
);
    DROP TABLE public.banks;
       public         heap    pi    false            �            1259    24849    banks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.banks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.banks_id_seq;
       public          pi    false    222            5           0    0    banks_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;
          public          pi    false    221            �            1259    24684    order_types    TABLE     b   CREATE TABLE public.order_types (
    id integer NOT NULL,
    type character varying NOT NULL
);
    DROP TABLE public.order_types;
       public         heap    pi    false            6           0    0    TABLE order_types    COMMENT     K   COMMENT ON TABLE public.order_types IS 'ETF, Convertible bonds and so on';
          public          pi    false    204            �            1259    24682    order_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_types_id_seq;
       public          pi    false    204            7           0    0    order_types_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_types_id_seq OWNED BY public.order_types.id;
          public          pi    false    203            �            1259    24722    orders    TABLE       CREATE TABLE public.orders (
    id integer NOT NULL,
    kurs double precision NOT NULL,
    stueck double precision NOT NULL,
    provision double precision,
    type_id integer,
    product_id integer,
    account_id integer,
    date timestamp with time zone NOT NULL
);
    DROP TABLE public.orders;
       public         heap    pi    false            �            1259    24720    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          pi    false    210            8           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          pi    false    209            �            1259    24814    product_categories    TABLE     �   CREATE TABLE public.product_categories (
    id integer NOT NULL,
    category character varying NOT NULL,
    parent_category character varying
);
 &   DROP TABLE public.product_categories;
       public         heap    pi    false            9           0    0    TABLE product_categories    COMMENT     \   COMMENT ON TABLE public.product_categories IS 'Index
  ETF

Zertifikate
  Express
  Bonus';
          public          pi    false    218            �            1259    24812    product_categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.product_categories_id_seq;
       public          pi    false    218            :           0    0    product_categories_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;
          public          pi    false    217            �            1259    24754    product_values    TABLE       CREATE TABLE public.product_values (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    stueck double precision NOT NULL,
    einstandskurs double precision NOT NULL,
    account_id integer NOT NULL,
    product_id integer NOT NULL,
    kurs double precision
);
 "   DROP TABLE public.product_values;
       public         heap    pi    false            ;           0    0    TABLE product_values    COMMENT     E   COMMENT ON TABLE public.product_values IS 'In the course of depots';
          public          pi    false    212            �            1259    24752    product_values_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_values_id_seq;
       public          pi    false    212            <           0    0    product_values_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_values_id_seq OWNED BY public.product_values.id;
          public          pi    false    211            �            1259    24711    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying,
    wkn character varying NOT NULL,
    isin character varying,
    google_symbol character varying,
    category_id integer
);
    DROP TABLE public.products;
       public         heap    pi    false            �            1259    24709    products_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.products_id_seq;
       public          pi    false    208            =           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public          pi    false    207            �            1259    24831    profits    TABLE     �   CREATE TABLE public.profits (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    product_id integer NOT NULL,
    account_id integer NOT NULL
);
    DROP TABLE public.profits;
       public         heap    pi    false            >           0    0    TABLE profits    COMMENT     F   COMMENT ON TABLE public.profits IS 'notice profits from any product';
          public          pi    false    220            �            1259    24829    profits_id_seq    SEQUENCE     �   CREATE SEQUENCE public.profits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.profits_id_seq;
       public          pi    false    220            ?           0    0    profits_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.profits_id_seq OWNED BY public.profits.id;
          public          pi    false    219            �            1259    24987 	   transfers    TABLE       CREATE TABLE public.transfers (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    value double precision NOT NULL,
    buchungstext character varying,
    verwendungszweck character varying,
    account_id integer NOT NULL,
    co_account_id integer
);
    DROP TABLE public.transfers;
       public         heap    pi    false            @           0    0    TABLE transfers    COMMENT     U   COMMENT ON TABLE public.transfers IS 'account transfers to or from another account';
          public          pi    false    228            �            1259    24985    transfers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transfers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.transfers_id_seq;
       public          pi    false    228            A           0    0    transfers_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;
          public          pi    false    227            �            1259    24919    view_latest_balances    VIEW     4  CREATE VIEW public.view_latest_balances AS
 SELECT account_balances.id,
    account_balances.date,
    account_balances.balance,
    account_balances.account_id
   FROM (public.account_balances
     JOIN ( SELECT account_balances_1.account_id,
            max(account_balances_1.date) AS maxdate
           FROM public.account_balances account_balances_1
          GROUP BY account_balances_1.account_id) groupedab ON (((account_balances.account_id = groupedab.account_id) AND (account_balances.date = groupedab.maxdate))))
  ORDER BY account_balances.account_id;
 '   DROP VIEW public.view_latest_balances;
       public          pi    false    214    214    214    214            �            1259    24945    view_accounts_balances    VIEW     �  CREATE VIEW public.view_accounts_balances AS
 SELECT v.date,
    v.balance,
    t.type,
    accounts.name AS account,
    banks.name AS bank
   FROM (((public.banks
     JOIN public.accounts ON ((banks.id = accounts.bank_id)))
     JOIN public.view_latest_balances v ON ((v.account_id = accounts.id)))
     JOIN public.account_types t ON ((t.id = accounts.type_id)))
  ORDER BY accounts.name;
 )   DROP VIEW public.view_accounts_balances;
       public          pi    false    206    216    216    206    206    206    223    223    223    222    222            B           0    0    VIEW view_accounts_balances    COMMENT     k   COMMENT ON VIEW public.view_accounts_balances IS 'combine 3 tables, accounts, account_balances and banks';
          public          pi    false    224            �            1259    24963    view_list_table_names    VIEW       CREATE VIEW public.view_list_table_names AS
 SELECT tables.table_name
   FROM information_schema.tables
  WHERE (((tables.table_type)::text = 'BASE TABLE'::text) AND ((tables.table_schema)::name = 'public'::name))
  ORDER BY tables.table_type, tables.table_name;
 (   DROP VIEW public.view_list_table_names;
       public          pi    false            �            1259    24980    view_profits    VIEW     �  CREATE VIEW public.view_profits AS
 SELECT profits.date,
    p.name AS product,
    profits.value,
    accounts.name AS account,
    t.category,
    t.parent_category AS type
   FROM (((public.profits
     JOIN public.accounts ON ((accounts.id = profits.account_id)))
     JOIN public.products p ON ((p.id = profits.product_id)))
     JOIN public.product_categories t ON ((t.id = p.category_id)))
  ORDER BY p.name;
    DROP VIEW public.view_profits;
       public          pi    false    206    206    208    208    208    218    218    218    220    220    220    220            C           0    0    VIEW view_profits    COMMENT     [   COMMENT ON VIEW public.view_profits IS 'profits list with products, categories, accounts';
          public          pi    false    226            I           2604    25021    account_balances id    DEFAULT     z   ALTER TABLE ONLY public.account_balances ALTER COLUMN id SET DEFAULT nextval('public.account_balances_id_seq'::regclass);
 B   ALTER TABLE public.account_balances ALTER COLUMN id DROP DEFAULT;
       public          pi    false    213    214    214            J           2604    25022    account_types id    DEFAULT     t   ALTER TABLE ONLY public.account_types ALTER COLUMN id SET DEFAULT nextval('public.account_types_id_seq'::regclass);
 ?   ALTER TABLE public.account_types ALTER COLUMN id DROP DEFAULT;
       public          pi    false    216    215    216            E           2604    25023    accounts id    DEFAULT     j   ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);
 :   ALTER TABLE public.accounts ALTER COLUMN id DROP DEFAULT;
       public          pi    false    205    206    206            M           2604    25024    banks id    DEFAULT     d   ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);
 7   ALTER TABLE public.banks ALTER COLUMN id DROP DEFAULT;
       public          pi    false    222    221    222            D           2604    25025    order_types id    DEFAULT     p   ALTER TABLE ONLY public.order_types ALTER COLUMN id SET DEFAULT nextval('public.order_types_id_seq'::regclass);
 =   ALTER TABLE public.order_types ALTER COLUMN id DROP DEFAULT;
       public          pi    false    204    203    204            G           2604    25026 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          pi    false    210    209    210            K           2604    25027    product_categories id    DEFAULT     ~   ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);
 D   ALTER TABLE public.product_categories ALTER COLUMN id DROP DEFAULT;
       public          pi    false    218    217    218            H           2604    25028    product_values id    DEFAULT     v   ALTER TABLE ONLY public.product_values ALTER COLUMN id SET DEFAULT nextval('public.product_values_id_seq'::regclass);
 @   ALTER TABLE public.product_values ALTER COLUMN id DROP DEFAULT;
       public          pi    false    211    212    212            F           2604    25029    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          pi    false    208    207    208            L           2604    25030 
   profits id    DEFAULT     h   ALTER TABLE ONLY public.profits ALTER COLUMN id SET DEFAULT nextval('public.profits_id_seq'::regclass);
 9   ALTER TABLE public.profits ALTER COLUMN id DROP DEFAULT;
       public          pi    false    219    220    220            N           2604    25031    transfers id    DEFAULT     l   ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);
 ;   ALTER TABLE public.transfers ALTER COLUMN id DROP DEFAULT;
       public          pi    false    228    227    228                      0    24774    account_balances 
   TABLE DATA           I   COPY public.account_balances (id, date, balance, account_id) FROM stdin;
    public          pi    false    214   2�                 0    24795    account_types 
   TABLE DATA           1   COPY public.account_types (id, type) FROM stdin;
    public          pi    false    216   +�                 0    24697    accounts 
   TABLE DATA           >   COPY public.accounts (id, name, type_id, bank_id) FROM stdin;
    public          pi    false    206   x�       "          0    24851    banks 
   TABLE DATA           :   COPY public.banks (id, name, link, operation) FROM stdin;
    public          pi    false    222   F�                 0    24684    order_types 
   TABLE DATA           /   COPY public.order_types (id, type) FROM stdin;
    public          pi    false    204   �                 0    24722    orders 
   TABLE DATA           d   COPY public.orders (id, kurs, stueck, provision, type_id, product_id, account_id, date) FROM stdin;
    public          pi    false    210   $�                 0    24814    product_categories 
   TABLE DATA           K   COPY public.product_categories (id, category, parent_category) FROM stdin;
    public          pi    false    218   �                 0    24754    product_values 
   TABLE DATA           g   COPY public.product_values (id, date, stueck, einstandskurs, account_id, product_id, kurs) FROM stdin;
    public          pi    false    212   R�                 0    24711    products 
   TABLE DATA           S   COPY public.products (id, name, wkn, isin, google_symbol, category_id) FROM stdin;
    public          pi    false    208   ì                  0    24831    profits 
   TABLE DATA           J   COPY public.profits (id, date, value, product_id, account_id) FROM stdin;
    public          pi    false    220   8�       $          0    24987 	   transfers 
   TABLE DATA           o   COPY public.transfers (id, date, value, buchungstext, verwendungszweck, account_id, co_account_id) FROM stdin;
    public          pi    false    228   t�       D           0    0    account_balances_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.account_balances_id_seq', 26, true);
          public          pi    false    213            E           0    0    account_types_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.account_types_id_seq', 5, true);
          public          pi    false    215            F           0    0    accounts_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.accounts_id_seq', 20, true);
          public          pi    false    205            G           0    0    banks_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.banks_id_seq', 6, true);
          public          pi    false    221            H           0    0    order_types_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.order_types_id_seq', 4, true);
          public          pi    false    203            I           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 31, true);
          public          pi    false    209            J           0    0    product_categories_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.product_categories_id_seq', 8, true);
          public          pi    false    217            K           0    0    product_values_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_values_id_seq', 12, true);
          public          pi    false    211            L           0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 22, true);
          public          pi    false    207            M           0    0    profits_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.profits_id_seq', 1, true);
          public          pi    false    219            N           0    0    transfers_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.transfers_id_seq', 1, false);
          public          pi    false    227            j           2606    24779 &   account_balances account_balances_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT account_balances_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT account_balances_pkey;
       public            pi    false    214            o           2606    24803     account_types account_types_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT account_types_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.account_types DROP CONSTRAINT account_types_pkey;
       public            pi    false    216            T           2606    24705    accounts accounts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
       public            pi    false    206            y           2606    24859    banks banks_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.banks DROP CONSTRAINT banks_pkey;
       public            pi    false    222            P           2606    24692    order_types order_types_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT order_types_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.order_types DROP CONSTRAINT order_types_pkey;
       public            pi    false    204            b           2606    24727    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            pi    false    210            s           2606    24822 *   product_categories product_categories_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.product_categories DROP CONSTRAINT product_categories_pkey;
       public            pi    false    218            h           2606    24759 "   product_values product_values_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT product_values_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_values DROP CONSTRAINT product_values_pkey;
       public            pi    false    212            w           2606    24836    profits profits_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.profits
    ADD CONSTRAINT profits_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.profits DROP CONSTRAINT profits_pkey;
       public            pi    false    220            [           2606    24747    products re_unique_product_wkn 
   CONSTRAINT     X   ALTER TABLE ONLY public.products
    ADD CONSTRAINT re_unique_product_wkn UNIQUE (wkn);
 H   ALTER TABLE ONLY public.products DROP CONSTRAINT re_unique_product_wkn;
       public            pi    false    208            }           2606    24995    transfers transfers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.transfers DROP CONSTRAINT transfers_pkey;
       public            pi    false    228            X           2606    24707    accounts unique_account 
   CONSTRAINT     R   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT unique_account UNIQUE (name);
 A   ALTER TABLE ONLY public.accounts DROP CONSTRAINT unique_account;
       public            pi    false    206            m           2606    24792    account_balances unique_balance 
   CONSTRAINT     o   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT unique_balance UNIQUE (date, balance, account_id);
 I   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT unique_balance;
       public            pi    false    214    214    214            R           2606    24694    order_types unique_order_type 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT unique_order_type UNIQUE (type);
 G   ALTER TABLE ONLY public.order_types DROP CONSTRAINT unique_order_type;
       public            pi    false    204            d           2606    24749 !   orders unique_product_stueck_date 
   CONSTRAINT     v   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT unique_product_stueck_date UNIQUE (kurs, stueck, date, product_id);
 K   ALTER TABLE ONLY public.orders DROP CONSTRAINT unique_product_stueck_date;
       public            pi    false    210    210    210    210            ]           2606    24719    products unique_product_wkn 
   CONSTRAINT     g   ALTER TABLE ONLY public.products
    ADD CONSTRAINT unique_product_wkn PRIMARY KEY (id) INCLUDE (wkn);
 E   ALTER TABLE ONLY public.products DROP CONSTRAINT unique_product_wkn;
       public            pi    false    208    208                       2606    25009    transfers unique_record 
   CONSTRAINT     w   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT unique_record UNIQUE (date, value, verwendungszweck, account_id);
 A   ALTER TABLE ONLY public.transfers DROP CONSTRAINT unique_record;
       public            pi    false    228    228    228    228            O           0    0 %   CONSTRAINT unique_record ON transfers    COMMENT     u   COMMENT ON CONSTRAINT unique_record ON public.transfers IS 'one account, one date, won value, one verwendungszweck';
          public          pi    false    2943            q           2606    24805    account_types unique_type 
   CONSTRAINT     T   ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT unique_type UNIQUE (type);
 C   ALTER TABLE ONLY public.account_types DROP CONSTRAINT unique_type;
       public            pi    false    216            e           1259    24765    fki_account_id    INDEX     O   CREATE INDEX fki_account_id ON public.product_values USING btree (account_id);
 "   DROP INDEX public.fki_account_id;
       public            pi    false    212            U           1259    24865    fki_accountb    INDEX     D   CREATE INDEX fki_accountb ON public.accounts USING btree (bank_id);
     DROP INDEX public.fki_accountb;
       public            pi    false    206            k           1259    24790    fki_balance_account_id    INDEX     Y   CREATE INDEX fki_balance_account_id ON public.account_balances USING btree (account_id);
 *   DROP INDEX public.fki_balance_account_id;
       public            pi    false    214            ^           1259    24739    fki_order_account    INDEX     J   CREATE INDEX fki_order_account ON public.orders USING btree (account_id);
 %   DROP INDEX public.fki_order_account;
       public            pi    false    210            _           1259    24745    fki_order_product    INDEX     J   CREATE INDEX fki_order_product ON public.orders USING btree (product_id);
 %   DROP INDEX public.fki_order_product;
       public            pi    false    210            `           1259    24733    fki_order_type    INDEX     D   CREATE INDEX fki_order_type ON public.orders USING btree (type_id);
 "   DROP INDEX public.fki_order_type;
       public            pi    false    210            f           1259    24771    fki_product_id    INDEX     O   CREATE INDEX fki_product_id ON public.product_values USING btree (product_id);
 "   DROP INDEX public.fki_product_id;
       public            pi    false    212            Y           1259    24828    fki_producttype    INDEX     K   CREATE INDEX fki_producttype ON public.products USING btree (category_id);
 #   DROP INDEX public.fki_producttype;
       public            pi    false    208            t           1259    24848    fki_profitaccount    INDEX     K   CREATE INDEX fki_profitaccount ON public.profits USING btree (account_id);
 %   DROP INDEX public.fki_profitaccount;
       public            pi    false    220            u           1259    24842    fki_profitproduct    INDEX     K   CREATE INDEX fki_profitproduct ON public.profits USING btree (product_id);
 %   DROP INDEX public.fki_profitproduct;
       public            pi    false    220            z           1259    25001    fki_trans_act    INDEX     I   CREATE INDEX fki_trans_act ON public.transfers USING btree (account_id);
 !   DROP INDEX public.fki_trans_act;
       public            pi    false    228            {           1259    25007    fki_trans_co    INDEX     K   CREATE INDEX fki_trans_co ON public.transfers USING btree (co_account_id);
     DROP INDEX public.fki_trans_co;
       public            pi    false    228            V           1259    24811    fki_type_id    INDEX     C   CREATE INDEX fki_type_id ON public.accounts USING btree (type_id);
    DROP INDEX public.fki_type_id;
       public            pi    false    206            �           2606    24760    product_values account_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT account_id FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 C   ALTER TABLE ONLY public.product_values DROP CONSTRAINT account_id;
       public          pi    false    212    2900    206            �           2606    24780    account_balances account_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT account_id FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 E   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT account_id;
       public          pi    false    2900    206    214            �           2606    24860    accounts accountb    FK CONSTRAINT     z   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accountb FOREIGN KEY (bank_id) REFERENCES public.banks(id) NOT VALID;
 ;   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accountb;
       public          pi    false    222    206    2937            �           2606    24734    orders order_account    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 >   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_account;
       public          pi    false    206    210    2900            �           2606    24740    orders order_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_product FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 >   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_product;
       public          pi    false    2909    210    208            �           2606    24728    orders order_type    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_type FOREIGN KEY (type_id) REFERENCES public.order_types(id) NOT VALID;
 ;   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_type;
       public          pi    false    2896    210    204            �           2606    24766    product_values product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 C   ALTER TABLE ONLY public.product_values DROP CONSTRAINT product_id;
       public          pi    false    208    212    2909            �           2606    24823    products producttype    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT producttype FOREIGN KEY (category_id) REFERENCES public.product_categories(id) NOT VALID;
 >   ALTER TABLE ONLY public.products DROP CONSTRAINT producttype;
       public          pi    false    218    2931    208            �           2606    24843    profits profitaccount    FK CONSTRAINT     �   ALTER TABLE ONLY public.profits
    ADD CONSTRAINT profitaccount FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 ?   ALTER TABLE ONLY public.profits DROP CONSTRAINT profitaccount;
       public          pi    false    206    2900    220            �           2606    24837    profits profitproduct    FK CONSTRAINT     �   ALTER TABLE ONLY public.profits
    ADD CONSTRAINT profitproduct FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 ?   ALTER TABLE ONLY public.profits DROP CONSTRAINT profitproduct;
       public          pi    false    208    2909    220            �           2606    24996    transfers trans_act    FK CONSTRAINT     �   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT trans_act FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 =   ALTER TABLE ONLY public.transfers DROP CONSTRAINT trans_act;
       public          pi    false    228    2900    206            P           0    0 !   CONSTRAINT trans_act ON transfers    COMMENT     J   COMMENT ON CONSTRAINT trans_act ON public.transfers IS 'self account id';
          public          pi    false    2955            �           2606    25002    transfers trans_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT trans_co FOREIGN KEY (co_account_id) REFERENCES public.accounts(id) NOT VALID;
 <   ALTER TABLE ONLY public.transfers DROP CONSTRAINT trans_co;
       public          pi    false    2900    206    228            �           2606    24806    accounts type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;
 :   ALTER TABLE ONLY public.accounts DROP CONSTRAINT type_id;
       public          pi    false    206    216    2927               �   x�}�An ��+z�@^c��-��;jHrh$q���jQQ�dU�y��-R������)qʂe�8u����>`�`*d��	+c\d̶����~:�h���'@��q�2C�(��8�PӇ�;�3B�6�����3����F
Ό���6C�WF-����=c�]�n0�l�nmx�CS�75Th���h*�-M%�ӫ��W|5�zd/����U%��:��۫�g5������         =   x�3�L�,��2�,ILO-NO�I�2�LK-.3M8SR�K�L9�R��R�3�J�ҹb���� �y         �   x�U�M� ���aL���ƝW0ij����u��4@��������ԍj�$�0��h�B�+�Ӷ��Y �XG�VK�|����0�a�f��R�-�A�D�w�a��k��\=/����G9>�y�5T܌��0��֬���'HM�ؑ���̣c�re�Sz�"��L�(�<n��G^R����?!j[      "   �   x�m�A�0��+��
	
<�/ n\��-Q�:؉�>moH�V�i���e.�+�i���@i��H�~BT�`GMQ�FQzI3N�%.SG%7��b%�4���I~;���}������)m/�
�n��?nw �<�bdU|���C3         +   x�3��I��2��N,M�2�K-��L8��
@r1z\\\ �
�         �  x�}�M��0���)�/B�W�z���潴��ᅾ���ȓl�I:�d��IA*�db�Ty����z~�<�P�#I'���-�
}J^F69 B�~���AK��ꛏ{>�ɜd�c�~��Ϡ��A�s�����$�6(xy�{���.�%��1�>Լ�FJx����)�C|���h����U!�&���c�mm>�<z������O���8�}l�o9�	�u���ˊ��@D�.��Ղ���-�Wv�-������2�J2�v���*�j�Q=�l0���]8K���N�V\ZT���+�g�F�^��_�.x��j�8���J��Nr�ǀq��ȵ �[�=׾��hk�b�GP�
��?/��u�!v� X�E��c�^��q�l؋_��9�w�����9�?+�.9h��C���>}��         _   x�U�;� ���aL�{=���7$�	��6XΔ�qU��p���#�5,S��}�]NA89�!dK-��޿ꠕˣ�6*�y.���,�         a   x�m�Q
�0�����J���y�EC'��%ą <���Y�[���jn��P��L	����f+Y��e挷v?����7ο���T��f)"         e  x�}��r�0���S�)�L%��#Ǥ`6��BR�2I��;�K�!�d�P������J���+�Mc'��ra�;\ٵ-�&�]�y�JB�G��w)$Wa�r ��+'a�u�VGN '� 
4��h$S�����E].QV˦����C�L(׉`���!�7:P|C�O�A�a�>w8%��#^�e�;+�C">BH���M:��n��y�t�P&�5R��+�F$����#7@6�J�>4���{�*~�:{U�54	!�	�\F��K@S��\��F�Y�H�&�}��3��1�T�)���e;��(��S��IM�����sU�):>sf2'ǇD�V���	������>mo�Gux�E;�wʛk�dGW����+�31���|�h
���e����b4p-�!����QL1� ��"�]�����p���e�b-����&�+3�+�9QK�_���o0�+��g���~�m����}���=����v�
�&(#�b4���b�=ژ�?m��K?��!�f ��6hl6Z.j�;u1��*�f1;6�5�#�Y����]�T��f�C���$#�"�hkN�l�i�#���x�68^�c�b[���T          ,   x�3�4202�54"+0�60�442�35�4�4����� �>�      $      x������ � �     