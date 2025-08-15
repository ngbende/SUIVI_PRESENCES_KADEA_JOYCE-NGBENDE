--
-- PostgreSQL database dump
--

\restrict yWd65jdPAiHQK0T0bzCU0CHMofZTGdGbQ70QjZqfbaagwrBrTynMCjO8iEfUeMq

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cohorte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cohorte (
    id_cohorte integer NOT NULL,
    nom_cohorte character varying(50) NOT NULL,
    id_formation integer,
    id_salle integer
);


ALTER TABLE public.cohorte OWNER TO postgres;

--
-- Name: cohorte_id_cohorte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cohorte_id_cohorte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cohorte_id_cohorte_seq OWNER TO postgres;

--
-- Name: cohorte_id_cohorte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cohorte_id_cohorte_seq OWNED BY public.cohorte.id_cohorte;


--
-- Name: formation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formation (
    id_formation integer NOT NULL,
    nom_formation character varying(100) NOT NULL
);


ALTER TABLE public.formation OWNER TO postgres;

--
-- Name: formation_id_formation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formation_id_formation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.formation_id_formation_seq OWNER TO postgres;

--
-- Name: formation_id_formation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.formation_id_formation_seq OWNED BY public.formation.id_formation;


--
-- Name: justification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.justification (
    id_justification integer NOT NULL,
    id_utilisateur integer,
    id_session integer,
    motif text NOT NULL,
    document text,
    statut character varying(20),
    CONSTRAINT justification_statut_check CHECK (((statut)::text = ANY ((ARRAY['Accept‚e'::character varying, 'Refus‚e'::character varying, 'En attente'::character varying])::text[])))
);


ALTER TABLE public.justification OWNER TO postgres;

--
-- Name: justification_id_justification_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.justification_id_justification_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.justification_id_justification_seq OWNER TO postgres;

--
-- Name: justification_id_justification_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.justification_id_justification_seq OWNED BY public.justification.id_justification;


--
-- Name: presence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presence (
    id_presence integer NOT NULL,
    id_utilisateur integer,
    id_session integer,
    heure_arrivee time without time zone,
    heure_depart time without time zone,
    etat character varying(20),
    id_justification integer,
    CONSTRAINT presence_etat_check CHECK (((etat)::text = ANY ((ARRAY['Pr‚sent'::character varying, 'Absent'::character varying, 'Retard'::character varying])::text[])))
);


ALTER TABLE public.presence OWNER TO postgres;

--
-- Name: presence_id_presence_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.presence_id_presence_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.presence_id_presence_seq OWNER TO postgres;

--
-- Name: presence_id_presence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.presence_id_presence_seq OWNED BY public.presence.id_presence;


--
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role (
    id_role integer NOT NULL,
    nom_role character varying(50) NOT NULL
);


ALTER TABLE public.role OWNER TO postgres;

--
-- Name: role_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_id_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_role_seq OWNER TO postgres;

--
-- Name: role_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_id_role_seq OWNED BY public.role.id_role;


--
-- Name: salle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salle (
    id_salle integer NOT NULL,
    nom_salle character varying(50) NOT NULL,
    id_ville integer
);


ALTER TABLE public.salle OWNER TO postgres;

--
-- Name: salle_id_salle_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salle_id_salle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salle_id_salle_seq OWNER TO postgres;

--
-- Name: salle_id_salle_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salle_id_salle_seq OWNED BY public.salle.id_salle;


--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    id_session integer NOT NULL,
    date_session date NOT NULL,
    id_cohorte integer
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: session_id_session_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.session_id_session_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_id_session_seq OWNER TO postgres;

--
-- Name: session_id_session_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.session_id_session_seq OWNED BY public.session.id_session;


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    prenom character varying(50) NOT NULL,
    nom character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    genre character(1),
    id_role integer,
    CONSTRAINT utilisateur_genre_check CHECK ((genre = ANY (ARRAY['M'::bpchar, 'F'::bpchar])))
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNER TO postgres;

--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- Name: ville; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    nom_ville character varying(100) NOT NULL
);


ALTER TABLE public.ville OWNER TO postgres;

--
-- Name: ville_id_ville_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ville_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ville_id_ville_seq OWNER TO postgres;

--
-- Name: ville_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;


--
-- Name: cohorte id_cohorte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cohorte ALTER COLUMN id_cohorte SET DEFAULT nextval('public.cohorte_id_cohorte_seq'::regclass);


--
-- Name: formation id_formation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formation ALTER COLUMN id_formation SET DEFAULT nextval('public.formation_id_formation_seq'::regclass);


--
-- Name: justification id_justification; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justification ALTER COLUMN id_justification SET DEFAULT nextval('public.justification_id_justification_seq'::regclass);


--
-- Name: presence id_presence; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presence ALTER COLUMN id_presence SET DEFAULT nextval('public.presence_id_presence_seq'::regclass);


--
-- Name: role id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role ALTER COLUMN id_role SET DEFAULT nextval('public.role_id_role_seq'::regclass);


--
-- Name: salle id_salle; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle ALTER COLUMN id_salle SET DEFAULT nextval('public.salle_id_salle_seq'::regclass);


--
-- Name: session id_session; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session ALTER COLUMN id_session SET DEFAULT nextval('public.session_id_session_seq'::regclass);


--
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- Name: ville id_ville; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);


--
-- Data for Name: cohorte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cohorte (id_cohorte, nom_cohorte, id_formation, id_salle) FROM stdin;
1	Cohorte 1	1	1
2	Cohorte 2	2	3
\.


--
-- Data for Name: formation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.formation (id_formation, nom_formation) FROM stdin;
1	D‚veloppement Web
2	Data Science
\.


--
-- Data for Name: justification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.justification (id_justification, id_utilisateur, id_session, motif, document, statut) FROM stdin;
3	1	4	Maladie	certificat.pdf	Accept‚e
4	2	5	Rendez-vous administratif	\N	En attente
\.


--
-- Data for Name: presence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.presence (id_presence, id_utilisateur, id_session, heure_arrivee, heure_depart, etat, id_justification) FROM stdin;
21	1	4	09:00:00	16:00:00	Pr‚sent	\N
22	2	4	09:30:00	16:00:00	Retard	\N
23	3	4	09:00:00	12:00:00	Pr‚sent	\N
24	4	5	\N	\N	Absent	\N
25	1	6	08:50:00	15:00:00	Pr‚sent	\N
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role (id_role, nom_role) FROM stdin;
1	Apprenant
2	Formateur
3	Admin
\.


--
-- Data for Name: salle; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salle (id_salle, nom_salle, id_ville) FROM stdin;
1	Salle A	1
2	Salle B	1
3	Salle C	2
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (id_session, date_session, id_cohorte) FROM stdin;
4	2025-08-10	1
5	2025-08-11	1
6	2025-08-12	2
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id_utilisateur, prenom, nom, email, genre, id_role) FROM stdin;
1	Alice	Mwamba	alice@example.com	F	1
2	Jean	Kalala	jean@example.com	M	1
3	Sarah	Mutombo	sarah@example.com	F	2
4	Paul	Banza	paul@example.com	M	1
5	Nadine	Kabuya	nadine@example.com	F	3
\.


--
-- Data for Name: ville; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ville (id_ville, nom_ville) FROM stdin;
1	Kinshasa
2	Lubumbashi
\.


--
-- Name: cohorte_id_cohorte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cohorte_id_cohorte_seq', 2, true);


--
-- Name: formation_id_formation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.formation_id_formation_seq', 2, true);


--
-- Name: justification_id_justification_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.justification_id_justification_seq', 4, true);


--
-- Name: presence_id_presence_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.presence_id_presence_seq', 25, true);


--
-- Name: role_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_id_role_seq', 3, true);


--
-- Name: salle_id_salle_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salle_id_salle_seq', 3, true);


--
-- Name: session_id_session_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.session_id_session_seq', 6, true);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 5, true);


--
-- Name: ville_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ville_id_ville_seq', 2, true);


--
-- Name: cohorte cohorte_nom_cohorte_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cohorte
    ADD CONSTRAINT cohorte_nom_cohorte_key UNIQUE (nom_cohorte);


--
-- Name: cohorte cohorte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cohorte
    ADD CONSTRAINT cohorte_pkey PRIMARY KEY (id_cohorte);


--
-- Name: formation formation_nom_formation_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formation
    ADD CONSTRAINT formation_nom_formation_key UNIQUE (nom_formation);


--
-- Name: formation formation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formation
    ADD CONSTRAINT formation_pkey PRIMARY KEY (id_formation);


--
-- Name: justification justification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justification
    ADD CONSTRAINT justification_pkey PRIMARY KEY (id_justification);


--
-- Name: presence presence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_pkey PRIMARY KEY (id_presence);


--
-- Name: role role_nom_role_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_nom_role_key UNIQUE (nom_role);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id_role);


--
-- Name: salle salle_nom_salle_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle
    ADD CONSTRAINT salle_nom_salle_key UNIQUE (nom_salle);


--
-- Name: salle salle_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle
    ADD CONSTRAINT salle_pkey PRIMARY KEY (id_salle);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id_session);


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_email_key UNIQUE (email);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: ville ville_nom_ville_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_nom_ville_key UNIQUE (nom_ville);


--
-- Name: ville ville_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);


--
-- Name: cohorte cohorte_id_formation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cohorte
    ADD CONSTRAINT cohorte_id_formation_fkey FOREIGN KEY (id_formation) REFERENCES public.formation(id_formation);


--
-- Name: cohorte cohorte_id_salle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cohorte
    ADD CONSTRAINT cohorte_id_salle_fkey FOREIGN KEY (id_salle) REFERENCES public.salle(id_salle);


--
-- Name: justification justification_id_session_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justification
    ADD CONSTRAINT justification_id_session_fkey FOREIGN KEY (id_session) REFERENCES public.session(id_session);


--
-- Name: justification justification_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.justification
    ADD CONSTRAINT justification_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: presence presence_id_justification_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_id_justification_fkey FOREIGN KEY (id_justification) REFERENCES public.justification(id_justification);


--
-- Name: presence presence_id_session_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_id_session_fkey FOREIGN KEY (id_session) REFERENCES public.session(id_session);


--
-- Name: presence presence_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presence
    ADD CONSTRAINT presence_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: salle salle_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salle
    ADD CONSTRAINT salle_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- Name: session session_id_cohorte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_id_cohorte_fkey FOREIGN KEY (id_cohorte) REFERENCES public.cohorte(id_cohorte);


--
-- Name: utilisateur utilisateur_id_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_id_role_fkey FOREIGN KEY (id_role) REFERENCES public.role(id_role);


--
-- PostgreSQL database dump complete
--

\unrestrict yWd65jdPAiHQK0T0bzCU0CHMofZTGdGbQ70QjZqfbaagwrBrTynMCjO8iEfUeMq

