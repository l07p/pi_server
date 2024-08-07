PGDMP     +                    x         
   investment #   12.5 (Ubuntu 12.5-0ubuntu0.20.04.1)    13.0 Q    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16385 
   investment    DATABASE     [   CREATE DATABASE investment WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C.UTF-8';
    DROP DATABASE investment;
                postgres    false                        3079    16386 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    1            �            1255    24751    get_product_id_with_wkn(text)    FUNCTION     �   CREATE FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
SELECT id FROM products WHERE wkn = p_wkn INTO p_id;

END;
$$;
 L   DROP FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer);
       public          pi    false            �           0    0 >   FUNCTION get_product_id_with_wkn(p_wkn text, OUT p_id integer)    COMMENT     x   COMMENT ON FUNCTION public.get_product_id_with_wkn(p_wkn text, OUT p_id integer) IS 'return product id with input wkn';
          public          pi    false    217            �            1259    24774    account_balances    TABLE     �   CREATE TABLE public.account_balances (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    balance double precision NOT NULL,
    account_id integer NOT NULL
);
 $   DROP TABLE public.account_balances;
       public         heap    pi    false            �           0    0    TABLE account_balances    COMMENT     Q   COMMENT ON TABLE public.account_balances IS 'balance history on course of time';
          public          pi    false    214            �            1259    24772    account_balances_id_seq    SEQUENCE     �   CREATE SEQUENCE public.account_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.account_balances_id_seq;
       public          pi    false    214            �           0    0    account_balances_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.account_balances_id_seq OWNED BY public.account_balances.id;
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
       public          pi    false    216            �           0    0    account_types_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.account_types_id_seq OWNED BY public.account_types.id;
          public          pi    false    215            �            1259    24697    accounts    TABLE     �   CREATE TABLE public.accounts (
    id integer NOT NULL,
    name character varying NOT NULL,
    type_id integer NOT NULL,
    bank_id integer
);
    DROP TABLE public.accounts;
       public         heap    pi    false            �           0    0    COLUMN accounts.type_id    COMMENT     O   COMMENT ON COLUMN public.accounts.type_id IS 'account of save, depot or giro';
          public          pi    false    206            �            1259    24695    accounts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.accounts_id_seq;
       public          pi    false    206            �           0    0    accounts_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;
          public          pi    false    205            �            1259    24684    order_types    TABLE     b   CREATE TABLE public.order_types (
    id integer NOT NULL,
    type character varying NOT NULL
);
    DROP TABLE public.order_types;
       public         heap    pi    false            �           0    0    TABLE order_types    COMMENT     K   COMMENT ON TABLE public.order_types IS 'ETF, Convertible bonds and so on';
          public          pi    false    204            �            1259    24682    order_types_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.order_types_id_seq;
       public          pi    false    204            �           0    0    order_types_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.order_types_id_seq OWNED BY public.order_types.id;
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
       public          pi    false    210            �           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          pi    false    209            �            1259    24754    product_values    TABLE       CREATE TABLE public.product_values (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    stueck double precision NOT NULL,
    einstandskurs double precision NOT NULL,
    account_id integer NOT NULL,
    product_id integer NOT NULL
);
 "   DROP TABLE public.product_values;
       public         heap    pi    false            �           0    0    TABLE product_values    COMMENT     E   COMMENT ON TABLE public.product_values IS 'In the course of depots';
          public          pi    false    212            �            1259    24752    product_values_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.product_values_id_seq;
       public          pi    false    212            �           0    0    product_values_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.product_values_id_seq OWNED BY public.product_values.id;
          public          pi    false    211            �            1259    24711    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying,
    wkn character varying NOT NULL,
    isin character varying,
    google_symbol character varying,
    category_id character varying
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
       public          pi    false    208            �           0    0    products_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;
          public          pi    false    207                       2604    24777    account_balances id    DEFAULT     z   ALTER TABLE ONLY public.account_balances ALTER COLUMN id SET DEFAULT nextval('public.account_balances_id_seq'::regclass);
 B   ALTER TABLE public.account_balances ALTER COLUMN id DROP DEFAULT;
       public          pi    false    213    214    214                       2604    24798    account_types id    DEFAULT     t   ALTER TABLE ONLY public.account_types ALTER COLUMN id SET DEFAULT nextval('public.account_types_id_seq'::regclass);
 ?   ALTER TABLE public.account_types ALTER COLUMN id DROP DEFAULT;
       public          pi    false    216    215    216                       2604    24700    accounts id    DEFAULT     j   ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);
 :   ALTER TABLE public.accounts ALTER COLUMN id DROP DEFAULT;
       public          pi    false    205    206    206                       2604    24687    order_types id    DEFAULT     p   ALTER TABLE ONLY public.order_types ALTER COLUMN id SET DEFAULT nextval('public.order_types_id_seq'::regclass);
 =   ALTER TABLE public.order_types ALTER COLUMN id DROP DEFAULT;
       public          pi    false    204    203    204                       2604    24725 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          pi    false    210    209    210                       2604    24757    product_values id    DEFAULT     v   ALTER TABLE ONLY public.product_values ALTER COLUMN id SET DEFAULT nextval('public.product_values_id_seq'::regclass);
 @   ALTER TABLE public.product_values ALTER COLUMN id DROP DEFAULT;
       public          pi    false    212    211    212                       2604    24714    products id    DEFAULT     j   ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);
 :   ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
       public          pi    false    208    207    208            �          0    24774    account_balances 
   TABLE DATA           I   COPY public.account_balances (id, date, balance, account_id) FROM stdin;
    public          pi    false    214   Y       �          0    24795    account_types 
   TABLE DATA           1   COPY public.account_types (id, type) FROM stdin;
    public          pi    false    216   �Y       �          0    24697    accounts 
   TABLE DATA           >   COPY public.accounts (id, name, type_id, bank_id) FROM stdin;
    public          pi    false    206   �Y       �          0    24684    order_types 
   TABLE DATA           /   COPY public.order_types (id, type) FROM stdin;
    public          pi    false    204   UZ       �          0    24722    orders 
   TABLE DATA           d   COPY public.orders (id, kurs, stueck, provision, type_id, product_id, account_id, date) FROM stdin;
    public          pi    false    210   �Z       �          0    24754    product_values 
   TABLE DATA           a   COPY public.product_values (id, date, stueck, einstandskurs, account_id, product_id) FROM stdin;
    public          pi    false    212   O\       �          0    24711    products 
   TABLE DATA           S   COPY public.products (id, name, wkn, isin, google_symbol, category_id) FROM stdin;
    public          pi    false    208   l\       �           0    0    account_balances_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.account_balances_id_seq', 8, true);
          public          pi    false    213            �           0    0    account_types_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.account_types_id_seq', 4, true);
          public          pi    false    215            �           0    0    accounts_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.accounts_id_seq', 11, true);
          public          pi    false    205            �           0    0    order_types_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.order_types_id_seq', 4, true);
          public          pi    false    203            �           0    0    orders_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.orders_id_seq', 31, true);
          public          pi    false    209            �           0    0    product_values_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.product_values_id_seq', 1, false);
          public          pi    false    211            �           0    0    products_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.products_id_seq', 11, true);
          public          pi    false    207            6           2606    24779 &   account_balances account_balances_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT account_balances_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT account_balances_pkey;
       public            pi    false    214            ;           2606    24803     account_types account_types_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT account_types_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.account_types DROP CONSTRAINT account_types_pkey;
       public            pi    false    216            "           2606    24705    accounts accounts_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.accounts DROP CONSTRAINT accounts_pkey;
       public            pi    false    206                       2606    24692    order_types order_types_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT order_types_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.order_types DROP CONSTRAINT order_types_pkey;
       public            pi    false    204            .           2606    24727    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            pi    false    210            4           2606    24759 "   product_values product_values_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT product_values_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_values DROP CONSTRAINT product_values_pkey;
       public            pi    false    212            '           2606    24747    products re_unique_product_wkn 
   CONSTRAINT     X   ALTER TABLE ONLY public.products
    ADD CONSTRAINT re_unique_product_wkn UNIQUE (wkn);
 H   ALTER TABLE ONLY public.products DROP CONSTRAINT re_unique_product_wkn;
       public            pi    false    208            %           2606    24707    accounts unique_account 
   CONSTRAINT     R   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT unique_account UNIQUE (name);
 A   ALTER TABLE ONLY public.accounts DROP CONSTRAINT unique_account;
       public            pi    false    206            9           2606    24792    account_balances unique_balance 
   CONSTRAINT     o   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT unique_balance UNIQUE (date, balance, account_id);
 I   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT unique_balance;
       public            pi    false    214    214    214                        2606    24694    order_types unique_order_type 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_types
    ADD CONSTRAINT unique_order_type UNIQUE (type);
 G   ALTER TABLE ONLY public.order_types DROP CONSTRAINT unique_order_type;
       public            pi    false    204            0           2606    24749 !   orders unique_product_stueck_date 
   CONSTRAINT     v   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT unique_product_stueck_date UNIQUE (kurs, stueck, date, product_id);
 K   ALTER TABLE ONLY public.orders DROP CONSTRAINT unique_product_stueck_date;
       public            pi    false    210    210    210    210            )           2606    24719    products unique_product_wkn 
   CONSTRAINT     g   ALTER TABLE ONLY public.products
    ADD CONSTRAINT unique_product_wkn PRIMARY KEY (id) INCLUDE (wkn);
 E   ALTER TABLE ONLY public.products DROP CONSTRAINT unique_product_wkn;
       public            pi    false    208    208            =           2606    24805    account_types unique_type 
   CONSTRAINT     T   ALTER TABLE ONLY public.account_types
    ADD CONSTRAINT unique_type UNIQUE (type);
 C   ALTER TABLE ONLY public.account_types DROP CONSTRAINT unique_type;
       public            pi    false    216            1           1259    24765    fki_account_id    INDEX     O   CREATE INDEX fki_account_id ON public.product_values USING btree (account_id);
 "   DROP INDEX public.fki_account_id;
       public            pi    false    212            7           1259    24790    fki_balance_account_id    INDEX     Y   CREATE INDEX fki_balance_account_id ON public.account_balances USING btree (account_id);
 *   DROP INDEX public.fki_balance_account_id;
       public            pi    false    214            *           1259    24739    fki_order_account    INDEX     J   CREATE INDEX fki_order_account ON public.orders USING btree (account_id);
 %   DROP INDEX public.fki_order_account;
       public            pi    false    210            +           1259    24745    fki_order_product    INDEX     J   CREATE INDEX fki_order_product ON public.orders USING btree (product_id);
 %   DROP INDEX public.fki_order_product;
       public            pi    false    210            ,           1259    24733    fki_order_type    INDEX     D   CREATE INDEX fki_order_type ON public.orders USING btree (type_id);
 "   DROP INDEX public.fki_order_type;
       public            pi    false    210            2           1259    24771    fki_product_id    INDEX     O   CREATE INDEX fki_product_id ON public.product_values USING btree (product_id);
 "   DROP INDEX public.fki_product_id;
       public            pi    false    212            #           1259    24811    fki_type_id    INDEX     C   CREATE INDEX fki_type_id ON public.accounts USING btree (type_id);
    DROP INDEX public.fki_type_id;
       public            pi    false    206            B           2606    24760    product_values account_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT account_id FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 C   ALTER TABLE ONLY public.product_values DROP CONSTRAINT account_id;
       public          pi    false    206    2850    212            D           2606    24780    account_balances account_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.account_balances
    ADD CONSTRAINT account_id FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 E   ALTER TABLE ONLY public.account_balances DROP CONSTRAINT account_id;
       public          pi    false    206    2850    214            @           2606    24734    orders order_account    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_account FOREIGN KEY (account_id) REFERENCES public.accounts(id) NOT VALID;
 >   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_account;
       public          pi    false    206    2850    210            A           2606    24740    orders order_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_product FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 >   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_product;
       public          pi    false    2857    210    208            ?           2606    24728    orders order_type    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT order_type FOREIGN KEY (type_id) REFERENCES public.order_types(id) NOT VALID;
 ;   ALTER TABLE ONLY public.orders DROP CONSTRAINT order_type;
       public          pi    false    210    204    2846            C           2606    24766    product_values product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.product_values
    ADD CONSTRAINT product_id FOREIGN KEY (product_id) REFERENCES public.products(id) NOT VALID;
 C   ALTER TABLE ONLY public.product_values DROP CONSTRAINT product_id;
       public          pi    false    212    208    2857            >           2606    24806    accounts type_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT type_id FOREIGN KEY (type_id) REFERENCES public.account_types(id) NOT VALID;
 :   ALTER TABLE ONLY public.accounts DROP CONSTRAINT type_id;
       public          pi    false    206    2875    216            �   a   x�u���PϤ
�L��������Ln���8���ᵑ�ם���Vk	��P�$qN��D.�I��b��,�$,����kr���v1CM�Y�� �%�/�      �   /   x�3�L�,��2�,ILO-NO�I�2�LK-.3M8SR�K�b���� "S�      �   {   x�M�=�0�����ʇ8���#ICJ)��;��I��]��=��Lѓ�!4Ʒ�f��;F��ϴ84InYV�����O�x��fv_�	j<hc�\bK�9Dg����,HWG�N�ŷ��g�9�      �   +   x�3��I��2��N,M�2�K-��L8��
@r1z\\\ �
�      �   �  x�}�M��0���)�/B�W�z���潴��ᅾ���ȓl�I:�d��IA*�db�Ty����z~�<�P�#I'���-�
}J^F69 B�~���AK��ꛏ{>�ɜd�c�~��Ϡ��A�s�����$�6(xy�{���.�%��1�>Լ�FJx����)�C|���h����U!�&���c�mm>�<z������O���8�}l�o9�	�u���ˊ��@D�.��Ղ���-�Wv�-������2�J2�v���*�j�Q=�l0���]8K���N�V\ZT���+�g�F�^��_�.x��j�8���J��Nr�ǀq��ȵ �[�=׾��hk�b�GP�
��?/��u�!v� X�E��c�^��q�l؋_��9�w�����9�?+�.9h��C���>}��      �      x������ � �      �   y  x�u��N�0��O�+�.m���e�EF�놅p3�30ї�!|2[&��ޝ�����/��~����27��f��B!�H�vO����vѤn{T��R#UЕT� �4((H�1n���1Xf
��x�噗d��y��@	, ��0(,�1������|H�PJ�R��0�R�}?�m^;S���#��KTU�����ϛ=��a�!�b��v���'`�W���������8�
p�o}ã��}��RL��3oѹ�)$�1_/z$m��C#0��~ج�=�%|~\�ڮz�Hi�)(!A��N:2S��Kʅ*R�ID���@	��� �!}�5Hw'�����?<��G!��MZ��.�f�����Q��N9f�u:�/7��C     