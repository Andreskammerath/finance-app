--
-- PostgreSQL database dump
--

-- Dumped from database version 12.13 (Debian 12.13-1.pgdg110+1)
-- Dumped by pg_dump version 12.13 (Debian 12.13-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: budgets; Type: TABLE; Schema: public; Owner: financial_app_user
--

CREATE TABLE public.budgets (
    id integer NOT NULL,
    category_id integer,
    user_email character varying(255),
    amount numeric NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.budgets OWNER TO financial_app_user;

--
-- Name: budgets_id_seq; Type: SEQUENCE; Schema: public; Owner: financial_app_user
--

CREATE SEQUENCE public.budgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.budgets_id_seq OWNER TO financial_app_user;

--
-- Name: budgets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: financial_app_user
--

ALTER SEQUENCE public.budgets_id_seq OWNED BY public.budgets.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: financial_app_user
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.categories OWNER TO financial_app_user;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: financial_app_user
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO financial_app_user;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: financial_app_user
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: financial_app_user
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    type character varying(10) NOT NULL,
    description character varying(255),
    amount numeric NOT NULL,
    date date NOT NULL,
    category_id integer,
    user_email character varying(255),
    CONSTRAINT transactions_type_check CHECK (((type)::text = ANY ((ARRAY['income'::character varying, 'expense'::character varying])::text[])))
);


ALTER TABLE public.transactions OWNER TO financial_app_user;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: financial_app_user
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO financial_app_user;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: financial_app_user
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: financial_app_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying NOT NULL,
    email character varying,
    full_name character varying,
    disabled boolean DEFAULT false,
    hashed_password character varying NOT NULL
);


ALTER TABLE public.users OWNER TO financial_app_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: financial_app_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO financial_app_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: financial_app_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: budgets id; Type: DEFAULT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.budgets ALTER COLUMN id SET DEFAULT nextval('public.budgets_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);


--
-- Name: categories categories_name_key; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: budgets budgets_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: budgets budgets_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_user_email_fkey FOREIGN KEY (user_email) REFERENCES public.users(email);


--
-- Name: transactions transactions_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: transactions transactions_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: financial_app_user
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_email_fkey FOREIGN KEY (user_email) REFERENCES public.users(email);


INSERT INTO public.users (username, email, full_name, disabled, hashed_password)
VALUES ('andy', 'a@a.com', 'andy', false, '$2b$12$zJVr6jsJlzQWfZrhul9c3ueTqcawbwXk98QJzgRokePulPjm630.i');

INSERT INTO public.categories (name) VALUES ('Salario');

INSERT INTO public.budgets (category_id, amount, start_date, end_date) VALUES (1, 1000000, '2024-04-01', '2024-04-30');

INSERT INTO public.transactions (amount, description, date, category_id, type, user_email)
VALUES (900000, 'Salario Andres', '2024-04-19', 1, 'income', 'a@a.com');


