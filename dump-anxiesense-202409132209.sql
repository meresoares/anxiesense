--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-09-13 22:09:37

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
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4815 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 844 (class 1247 OID 16418)
-- Name: person_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.person_type AS ENUM (
    'usuario',
    'paciente'
);


ALTER TYPE public.person_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16507)
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personas (
    id character varying(255) NOT NULL,
    fecha_nacimiento date NOT NULL,
    universidad character varying(255) NOT NULL,
    carrera character varying(255) NOT NULL,
    datos_personales text,
    tipo_persona_role character varying(50) NOT NULL,
    sexo character varying(10),
    CONSTRAINT ck_carrera CHECK (((carrera)::text = ANY ((ARRAY['Lic. en Análisis de Sistemas'::character varying, 'Lic. en Turismo'::character varying, 'Ingeniería de Sistemas'::character varying, 'Ingeniería Eléctrica'::character varying, 'Otro'::character varying])::text[]))),
    CONSTRAINT ck_sexo CHECK (((sexo)::text = ANY ((ARRAY['Femenino'::character varying, 'Masculino'::character varying])::text[]))),
    CONSTRAINT ck_universidad CHECK (((universidad)::text = ANY ((ARRAY['FP-UNE'::character varying, 'FAFI-UNE'::character varying, 'FCE-UNE'::character varying, 'FDCS-UNE'::character varying, 'Otro'::character varying])::text[])))
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16446)
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas (
    id integer NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.preguntas OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16445)
-- Name: preguntas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preguntas_id_seq OWNER TO postgres;

--
-- TOC entry 4817 (class 0 OID 0)
-- Dependencies: 215
-- Name: preguntas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_id_seq OWNED BY public.preguntas.id;


--
-- TOC entry 219 (class 1259 OID 16570)
-- Name: respuestas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.respuestas (
    id integer NOT NULL,
    persona_id character varying(255) NOT NULL,
    pregunta_id integer NOT NULL,
    respuesta character varying(255) NOT NULL,
    evaluacion character varying(255),
    fecha_respuesta timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.respuestas OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16569)
-- Name: respuestas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.respuestas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.respuestas_id_seq OWNER TO postgres;

--
-- TOC entry 4818 (class 0 OID 0)
-- Dependencies: 218
-- Name: respuestas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.respuestas_id_seq OWNED BY public.respuestas.id;


--
-- TOC entry 4646 (class 2604 OID 16449)
-- Name: preguntas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas ALTER COLUMN id SET DEFAULT nextval('public.preguntas_id_seq'::regclass);


--
-- TOC entry 4647 (class 2604 OID 16573)
-- Name: respuestas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas ALTER COLUMN id SET DEFAULT nextval('public.respuestas_id_seq'::regclass);


--
-- TOC entry 4807 (class 0 OID 16507)
-- Dependencies: 217
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personas (id, fecha_nacimiento, universidad, carrera, datos_personales, tipo_persona_role, sexo) FROM stdin;
g9xi7GlCwHWgtGFMJ7WgS6GAF552	1996-12-19	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
XARMoTdD4ZcmQfjE6UF1FNcO12g2	2000-08-08	FP-UNE	Ingeniería Eléctrica	\N	Usuario	Femenino
hNngEGWCrNhPpUe3scVxFGpIW8B2	2002-12-09	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
BTtoBSwhbUfXHMB07VcT3rVosu73	1996-12-19	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
V6EbTFXnKyYpKuOlHQAZlX4INeF2	2000-05-12	FP-UNE	Lic. en Turismo	\N	Usuario	Femenino
AzrpHTVdQuUHSZOKw2ppIGxx1GP2	2000-05-16	FP-UNE	Lic. en Turismo	\N	Usuario	Femenino
iZIxNt45BDXzak5OvpJHUo5nUZG2	2000-05-16	FP-UNE	Ingeniería de Sistemas	\N	Usuario	Masculino
U6MB17KBdAgnWxpEdAowmk7SYCt1	1998-05-17	FP-UNE	Lic. en Turismo	\N	Usuario	Femenino
HA8youyEwNP5eFAwaIeB4n80QIx2	2001-05-17	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Masculino
SX3zcF7cmbaTYDYbAtl93bG3ib92	2001-05-17	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Masculino
MAXbO2I2DmekVMazBEfnigqHvM62	2001-05-17	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
OCGXN9ewVfRdzDBcEV91kKOhmjk1	2002-05-20	FP-UNE	Ingeniería de Sistemas	\N	Usuario	Masculino
r1VrYXMC82gJeXQwlAXJWwkvLnD3	2001-05-22	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
yc8VrHUBfNR2ESvTO9xq3iEqTVL2	1990-01-19	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
1zfFpTJDdWUVBx1CVff6R36seVa2	1999-05-25	Otro	Otro	\N	Usuario	Masculino
4CImRqoWIMPRnHPb20HEMCV5xs32	1999-05-26	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
acGBVp1FIBVJFQE1CVYr1Baw4FS2	1996-06-07	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
SOJp80B2r0fSaYgN7bwL8DQ2jAR2	1996-06-08	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
iMj2dwODZWf0SUDYl7HtbOiBcCu1	2000-01-01	FP-UNE	Ingeniería Eléctrica	\N	Usuario	Masculino
RPbaOQXcZKOq4zTYvoIxLVXkAAs1	1996-01-01	Otro	Otro	admin	Administrador	Femenino
KbyUMntVBlfWlWoLMmUZ4WOMitO2	1997-03-24	FP-UNE	Ingeniería de Sistemas	\N	Usuario	Femenino
5aFbqw6gEHWKVUdSbfEwie65HjF2	1996-03-24	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
bafUeZ5vLeWKJzExHrIeJl9saKS2	1996-05-14	Otro	Otro	administrador	Administrador	Femenino
nepexQ0vNTRjUvTgTbluZgXjygS2	1996-04-16	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Masculino
SovMShigGJVYhAvSGe9wcyVRys93	1990-11-24	FP-UNE	Ingeniería de Sistemas	\N	Usuario	Masculino
EhXJV0JyjBPzfkXWLZxCjE8l9wn2	1990-06-26	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Masculino
he1QuZbQnIhNsdsmm0jkxsu4e7t2	1997-07-06	FP-UNE	Lic. en Análisis de Sistemas	\N	Usuario	Femenino
TFmfAXQKw2TO2MYkD8k8bfYHlOn2	2000-07-06	Otro	Otro	\N	Usuario	Masculino
AFPr7fzZ5lRqiwoDaDWmTPck7jF2	1999-09-22	Otro	Otro	\N	Usuario	Masculino
etreEXBXv0P3lmiygo105zTsvox1	2000-07-10	Otro	Otro	\N	Usuario	Femenino
ERVOfA2CoubfDQgP0j3nKUuRlmh2	2001-07-12	Otro	Otro	\N	Usuario	Femenino
\.


--
-- TOC entry 4806 (class 0 OID 16446)
-- Dependencies: 216
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas (id, descripcion) FROM stdin;
1	Tengo miedo de las autoridades (por ejemplo, profesores, instructores, director, etc.)
2	Me molesta sonrojarme delante de las personas
3	Las fiestas y los eventos sociales me asustan (o angustian)
4	Evito hablar con personas desconocidas
5	Me asusta (o angustia) mucho que me critiquen
6	Evito hacer cosas o hablar con cierta gente por miedo a sentir vergüenza
7	Transpirar delante de otras personas me angustia o estresa
8	Evito ir a fiestas
9	Evito actividades en las cuales soy el centro de atención
10	Hablar con gente desconocida me asusta o angustia
11	Evito hablar en público
12	Haría cualquier cosa para evitar que me critiquen
13	Siento palpitaciones cardíacas cuando estoy con gente desconocida
14	Tengo miedo de hacer cosas cuando la gente me está mirando
15	Mis mayores miedos son sentirme avergonzada/o o un/a tonto/a
16	Evito hablar con cualquier persona con autoridad
17	Que los demás me vean titubear, sonrojar o temblar me angustia o estresa
\.


--
-- TOC entry 4809 (class 0 OID 16570)
-- Dependencies: 219
-- Data for Name: respuestas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.respuestas (id, persona_id, pregunta_id, respuesta, evaluacion, fecha_respuesta) FROM stdin;
242	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Un poco	Ansiedad Social Moderada	2024-05-22 17:50:57.891
243	r1VrYXMC82gJeXQwlAXJWwkvLnD3	2	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
244	r1VrYXMC82gJeXQwlAXJWwkvLnD3	3	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
245	r1VrYXMC82gJeXQwlAXJWwkvLnD3	4	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
246	r1VrYXMC82gJeXQwlAXJWwkvLnD3	5	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
247	r1VrYXMC82gJeXQwlAXJWwkvLnD3	6	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
248	r1VrYXMC82gJeXQwlAXJWwkvLnD3	7	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
249	r1VrYXMC82gJeXQwlAXJWwkvLnD3	8	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
250	r1VrYXMC82gJeXQwlAXJWwkvLnD3	9	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
251	r1VrYXMC82gJeXQwlAXJWwkvLnD3	10	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
252	r1VrYXMC82gJeXQwlAXJWwkvLnD3	11	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
253	r1VrYXMC82gJeXQwlAXJWwkvLnD3	12	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
254	r1VrYXMC82gJeXQwlAXJWwkvLnD3	13	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
255	r1VrYXMC82gJeXQwlAXJWwkvLnD3	14	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
256	r1VrYXMC82gJeXQwlAXJWwkvLnD3	15	Demasiado	Ansiedad Social Moderada	2024-05-22 17:50:57.892
257	r1VrYXMC82gJeXQwlAXJWwkvLnD3	16	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.892
258	r1VrYXMC82gJeXQwlAXJWwkvLnD3	17	Mucho	Ansiedad Social Moderada	2024-05-22 17:50:57.893
259	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	1	Nunca	Ansiedad Social Baja	2024-05-22 18:36:36.197
260	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	2	Nunca	Ansiedad Social Baja	2024-05-22 18:36:36.197
261	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	3	Nunca	Ansiedad Social Baja	2024-05-22 18:36:36.197
262	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	4	Nunca	Ansiedad Social Baja	2024-05-22 18:36:36.197
263	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	5	Muy poco	Ansiedad Social Baja	2024-05-22 18:36:36.197
264	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	6	Muy poco	Ansiedad Social Baja	2024-05-22 18:36:36.197
265	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	7	Muy poco	Ansiedad Social Baja	2024-05-22 18:36:36.197
266	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	8	Nunca	Ansiedad Social Baja	2024-05-22 18:36:36.197
267	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	9	Un poco	Ansiedad Social Baja	2024-05-22 18:36:36.198
268	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	10	Mucho	Ansiedad Social Baja	2024-05-22 18:36:36.198
269	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	11	Un poco	Ansiedad Social Baja	2024-05-22 18:36:36.198
270	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	12	Mucho	Ansiedad Social Baja	2024-05-22 18:36:36.198
271	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	13	Demasiado	Ansiedad Social Baja	2024-05-22 18:36:36.198
272	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	14	Demasiado	Ansiedad Social Baja	2024-05-22 18:36:36.198
273	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	15	Mucho	Ansiedad Social Baja	2024-05-22 18:36:36.198
274	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	16	Un poco	Ansiedad Social Baja	2024-05-22 18:36:36.198
275	yc8VrHUBfNR2ESvTO9xq3iEqTVL2	17	Muy poco	Ansiedad Social Baja	2024-05-22 18:36:36.198
276	1zfFpTJDdWUVBx1CVff6R36seVa2	1	Un poco	Ansiedad Social Moderada	2024-05-25 17:47:03.999
277	1zfFpTJDdWUVBx1CVff6R36seVa2	2	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.006
278	1zfFpTJDdWUVBx1CVff6R36seVa2	3	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.006
279	1zfFpTJDdWUVBx1CVff6R36seVa2	4	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.006
280	1zfFpTJDdWUVBx1CVff6R36seVa2	5	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.006
281	1zfFpTJDdWUVBx1CVff6R36seVa2	6	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.006
282	1zfFpTJDdWUVBx1CVff6R36seVa2	7	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.006
283	1zfFpTJDdWUVBx1CVff6R36seVa2	8	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.006
284	1zfFpTJDdWUVBx1CVff6R36seVa2	9	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.006
285	1zfFpTJDdWUVBx1CVff6R36seVa2	10	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.007
286	1zfFpTJDdWUVBx1CVff6R36seVa2	11	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
287	1zfFpTJDdWUVBx1CVff6R36seVa2	12	Mucho	Ansiedad Social Moderada	2024-05-25 17:47:04.007
288	1zfFpTJDdWUVBx1CVff6R36seVa2	13	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
289	1zfFpTJDdWUVBx1CVff6R36seVa2	14	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
290	1zfFpTJDdWUVBx1CVff6R36seVa2	15	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
291	1zfFpTJDdWUVBx1CVff6R36seVa2	16	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
292	1zfFpTJDdWUVBx1CVff6R36seVa2	17	Demasiado	Ansiedad Social Moderada	2024-05-25 17:47:04.007
293	4CImRqoWIMPRnHPb20HEMCV5xs32	1	Un poco	Ansiedad Social Moderada	2024-05-26 20:38:15.587
294	4CImRqoWIMPRnHPb20HEMCV5xs32	2	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.59
295	4CImRqoWIMPRnHPb20HEMCV5xs32	3	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.59
296	4CImRqoWIMPRnHPb20HEMCV5xs32	4	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.59
297	4CImRqoWIMPRnHPb20HEMCV5xs32	5	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.59
298	4CImRqoWIMPRnHPb20HEMCV5xs32	6	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
299	4CImRqoWIMPRnHPb20HEMCV5xs32	7	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
300	4CImRqoWIMPRnHPb20HEMCV5xs32	8	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
301	4CImRqoWIMPRnHPb20HEMCV5xs32	9	Demasiado	Ansiedad Social Moderada	2024-05-26 20:38:15.591
302	4CImRqoWIMPRnHPb20HEMCV5xs32	10	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
303	4CImRqoWIMPRnHPb20HEMCV5xs32	11	Demasiado	Ansiedad Social Moderada	2024-05-26 20:38:15.591
304	4CImRqoWIMPRnHPb20HEMCV5xs32	12	Un poco	Ansiedad Social Moderada	2024-05-26 20:38:15.591
305	4CImRqoWIMPRnHPb20HEMCV5xs32	13	Demasiado	Ansiedad Social Moderada	2024-05-26 20:38:15.591
306	4CImRqoWIMPRnHPb20HEMCV5xs32	14	Demasiado	Ansiedad Social Moderada	2024-05-26 20:38:15.591
307	4CImRqoWIMPRnHPb20HEMCV5xs32	15	Demasiado	Ansiedad Social Moderada	2024-05-26 20:38:15.591
308	4CImRqoWIMPRnHPb20HEMCV5xs32	16	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
309	4CImRqoWIMPRnHPb20HEMCV5xs32	17	Mucho	Ansiedad Social Moderada	2024-05-26 20:38:15.591
310	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.532
311	r1VrYXMC82gJeXQwlAXJWwkvLnD3	2	Muy poco	Ansiedad Social Baja	2024-06-05 20:46:23.542
312	r1VrYXMC82gJeXQwlAXJWwkvLnD3	3	Mucho	Ansiedad Social Baja	2024-06-05 20:46:23.542
313	r1VrYXMC82gJeXQwlAXJWwkvLnD3	4	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.542
314	r1VrYXMC82gJeXQwlAXJWwkvLnD3	5	Un poco	Ansiedad Social Baja	2024-06-05 20:46:23.543
315	r1VrYXMC82gJeXQwlAXJWwkvLnD3	6	Muy poco	Ansiedad Social Baja	2024-06-05 20:46:23.543
316	r1VrYXMC82gJeXQwlAXJWwkvLnD3	7	Muy poco	Ansiedad Social Baja	2024-06-05 20:46:23.543
317	r1VrYXMC82gJeXQwlAXJWwkvLnD3	8	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.543
318	r1VrYXMC82gJeXQwlAXJWwkvLnD3	9	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.543
319	r1VrYXMC82gJeXQwlAXJWwkvLnD3	10	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.543
320	r1VrYXMC82gJeXQwlAXJWwkvLnD3	11	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.543
321	r1VrYXMC82gJeXQwlAXJWwkvLnD3	12	Demasiado	Ansiedad Social Baja	2024-06-05 20:46:23.543
322	r1VrYXMC82gJeXQwlAXJWwkvLnD3	13	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.543
323	r1VrYXMC82gJeXQwlAXJWwkvLnD3	14	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.544
324	r1VrYXMC82gJeXQwlAXJWwkvLnD3	15	Muy poco	Ansiedad Social Baja	2024-06-05 20:46:23.544
325	r1VrYXMC82gJeXQwlAXJWwkvLnD3	16	Un poco	Ansiedad Social Baja	2024-06-05 20:46:23.544
326	r1VrYXMC82gJeXQwlAXJWwkvLnD3	17	Nada	Ansiedad Social Baja	2024-06-05 20:46:23.544
327	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Nada	Ansiedad Social Baja	2024-06-06 15:41:19.276
328	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Nada	Ansiedad Social Baja	2024-06-06 15:42:59.707
329	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Muy poco	Ansiedad Social Baja	2024-06-06 15:48:54.919
330	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Muy poco	Ansiedad Social Baja	2024-06-06 17:10:06.515
331	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Un poco	Ansiedad Social Baja	2024-06-06 17:14:30.471
332	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Muy poco	Ansiedad Social Baja	2024-06-06 17:14:44.588
333	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Demasiado	Ansiedad Social Baja	2024-06-06 17:15:57.405
334	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Muy poco	Ansiedad Social Baja	2024-06-06 17:18:23.993
335	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Muy poco	Ansiedad Social Baja	2024-06-06 17:29:11.262
336	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Un poco	Ansiedad Social Baja	2024-06-06 17:30:25.245
337	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Un poco	Ansiedad Social Baja	2024-06-06 17:32:42.173
338	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	Un poco	Ansiedad Social Baja	2024-06-07 20:08:04.248
339	r1VrYXMC82gJeXQwlAXJWwkvLnD3	1	1	Ansiedad Social Alta	2024-06-07 20:20:58.686
340	acGBVp1FIBVJFQE1CVYr1Baw4FS2	1	1	Ansiedad Social Alta	2024-06-07 20:23:38.558
341	acGBVp1FIBVJFQE1CVYr1Baw4FS2	1	4	Ansiedad Social Alta	2024-06-07 20:30:39.352
342	acGBVp1FIBVJFQE1CVYr1Baw4FS2	1	2	Ansiedad Social Alta	2024-06-08 19:18:01.813
343	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	1	1	Ansiedad Social Alta	2024-06-08 20:04:51.978
344	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	2	3	Ansiedad Social Alta	2024-06-08 20:04:51.98
345	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	3	1	Ansiedad Social Alta	2024-06-08 20:04:51.98
346	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	4	4	Ansiedad Social Alta	2024-06-08 20:04:51.98
347	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	5	3	Ansiedad Social Alta	2024-06-08 20:04:51.98
348	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	6	2	Ansiedad Social Alta	2024-06-08 20:04:51.98
349	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	7	2	Ansiedad Social Alta	2024-06-08 20:04:51.98
350	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	8	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
351	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	9	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
352	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	10	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
353	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	11	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
354	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	12	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
355	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	13	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
356	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	14	0	Ansiedad Social Alta	2024-06-08 20:04:51.981
357	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	15	0	Ansiedad Social Alta	2024-06-08 20:04:51.981
358	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	16	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
359	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	17	1	Ansiedad Social Alta	2024-06-08 20:04:51.981
360	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	1	2	Ansiedad Social Alta	2024-06-11 19:16:28.558
361	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	2	2	Ansiedad Social Alta	2024-06-11 19:16:28.559
362	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	3	1	Ansiedad Social Alta	2024-06-11 19:16:28.559
363	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	4	3	Ansiedad Social Alta	2024-06-11 19:16:28.559
364	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	5	4	Ansiedad Social Alta	2024-06-11 19:16:28.559
365	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	6	3	Ansiedad Social Alta	2024-06-11 19:16:28.559
366	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	7	2	Ansiedad Social Alta	2024-06-11 19:16:28.559
367	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	8	3	Ansiedad Social Alta	2024-06-11 19:16:28.559
368	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	9	3	Ansiedad Social Alta	2024-06-11 19:16:28.559
369	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	10	2	Ansiedad Social Alta	2024-06-11 19:16:28.559
370	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	11	3	Ansiedad Social Alta	2024-06-11 19:16:28.559
371	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	12	0	Ansiedad Social Alta	2024-06-11 19:16:28.559
372	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	13	0	Ansiedad Social Alta	2024-06-11 19:16:28.559
373	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	14	0	Ansiedad Social Alta	2024-06-11 19:16:28.559
374	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	15	1	Ansiedad Social Alta	2024-06-11 19:16:28.559
375	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	16	1	Ansiedad Social Alta	2024-06-11 19:16:28.559
376	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	17	1	Ansiedad Social Alta	2024-06-11 19:16:28.559
377	SOJp80B2r0fSaYgN7bwL8DQ2jAR2	1	1	Ansiedad Social Alta	2024-06-17 14:34:01.124
378	5aFbqw6gEHWKVUdSbfEwie65HjF2	1	Nada	Ansiedad Social Baja	2024-06-18 16:51:34.754
379	5aFbqw6gEHWKVUdSbfEwie65HjF2	2	Demasiado	Ansiedad Social Baja	2024-06-18 16:51:34.755
380	5aFbqw6gEHWKVUdSbfEwie65HjF2	3	Demasiado	Ansiedad Social Baja	2024-06-18 16:51:34.755
381	5aFbqw6gEHWKVUdSbfEwie65HjF2	4	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.755
382	5aFbqw6gEHWKVUdSbfEwie65HjF2	5	Nada	Ansiedad Social Baja	2024-06-18 16:51:34.755
383	5aFbqw6gEHWKVUdSbfEwie65HjF2	6	Un poco	Ansiedad Social Baja	2024-06-18 16:51:34.755
384	5aFbqw6gEHWKVUdSbfEwie65HjF2	7	Mucho	Ansiedad Social Baja	2024-06-18 16:51:34.756
385	5aFbqw6gEHWKVUdSbfEwie65HjF2	8	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.756
386	5aFbqw6gEHWKVUdSbfEwie65HjF2	9	Nada	Ansiedad Social Baja	2024-06-18 16:51:34.756
387	5aFbqw6gEHWKVUdSbfEwie65HjF2	10	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.756
388	5aFbqw6gEHWKVUdSbfEwie65HjF2	11	Mucho	Ansiedad Social Baja	2024-06-18 16:51:34.756
389	5aFbqw6gEHWKVUdSbfEwie65HjF2	12	Un poco	Ansiedad Social Baja	2024-06-18 16:51:34.756
390	5aFbqw6gEHWKVUdSbfEwie65HjF2	13	Nada	Ansiedad Social Baja	2024-06-18 16:51:34.756
391	5aFbqw6gEHWKVUdSbfEwie65HjF2	14	Mucho	Ansiedad Social Baja	2024-06-18 16:51:34.757
392	5aFbqw6gEHWKVUdSbfEwie65HjF2	15	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.757
393	5aFbqw6gEHWKVUdSbfEwie65HjF2	16	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.757
394	5aFbqw6gEHWKVUdSbfEwie65HjF2	17	Muy poco	Ansiedad Social Baja	2024-06-18 16:51:34.757
395	nepexQ0vNTRjUvTgTbluZgXjygS2	1	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
396	nepexQ0vNTRjUvTgTbluZgXjygS2	2	Un poco	Ansiedad Social Baja	2024-06-23 21:35:16.395
397	nepexQ0vNTRjUvTgTbluZgXjygS2	3	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
398	nepexQ0vNTRjUvTgTbluZgXjygS2	4	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
399	nepexQ0vNTRjUvTgTbluZgXjygS2	5	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
400	nepexQ0vNTRjUvTgTbluZgXjygS2	6	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
401	nepexQ0vNTRjUvTgTbluZgXjygS2	7	Un poco	Ansiedad Social Baja	2024-06-23 21:35:16.395
402	nepexQ0vNTRjUvTgTbluZgXjygS2	8	Un poco	Ansiedad Social Baja	2024-06-23 21:35:16.395
403	nepexQ0vNTRjUvTgTbluZgXjygS2	9	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.395
404	nepexQ0vNTRjUvTgTbluZgXjygS2	10	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.396
405	nepexQ0vNTRjUvTgTbluZgXjygS2	11	Un poco	Ansiedad Social Baja	2024-06-23 21:35:16.396
406	nepexQ0vNTRjUvTgTbluZgXjygS2	12	Muy poco	Ansiedad Social Baja	2024-06-23 21:35:16.396
407	nepexQ0vNTRjUvTgTbluZgXjygS2	13	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.396
408	nepexQ0vNTRjUvTgTbluZgXjygS2	14	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.396
409	nepexQ0vNTRjUvTgTbluZgXjygS2	15	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.396
410	nepexQ0vNTRjUvTgTbluZgXjygS2	16	Nada	Ansiedad Social Baja	2024-06-23 21:35:16.396
411	nepexQ0vNTRjUvTgTbluZgXjygS2	17	Muy poco	Ansiedad Social Baja	2024-06-23 21:35:16.396
412	SovMShigGJVYhAvSGe9wcyVRys93	1	Un poco	Ansiedad Social Baja	2024-06-24 23:43:59.699
413	SovMShigGJVYhAvSGe9wcyVRys93	2	Demasiado	Ansiedad Social Baja	2024-06-24 23:43:59.712
414	SovMShigGJVYhAvSGe9wcyVRys93	3	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
415	SovMShigGJVYhAvSGe9wcyVRys93	4	Mucho	Ansiedad Social Baja	2024-06-24 23:43:59.713
416	SovMShigGJVYhAvSGe9wcyVRys93	5	Un poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
417	SovMShigGJVYhAvSGe9wcyVRys93	6	Un poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
418	SovMShigGJVYhAvSGe9wcyVRys93	7	Nada	Ansiedad Social Baja	2024-06-24 23:43:59.713
419	SovMShigGJVYhAvSGe9wcyVRys93	8	Nada	Ansiedad Social Baja	2024-06-24 23:43:59.713
420	SovMShigGJVYhAvSGe9wcyVRys93	9	Nada	Ansiedad Social Baja	2024-06-24 23:43:59.713
421	SovMShigGJVYhAvSGe9wcyVRys93	10	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
422	SovMShigGJVYhAvSGe9wcyVRys93	11	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
423	SovMShigGJVYhAvSGe9wcyVRys93	12	Nada	Ansiedad Social Baja	2024-06-24 23:43:59.713
424	SovMShigGJVYhAvSGe9wcyVRys93	13	Nada	Ansiedad Social Baja	2024-06-24 23:43:59.713
425	SovMShigGJVYhAvSGe9wcyVRys93	14	Un poco	Ansiedad Social Baja	2024-06-24 23:43:59.713
426	SovMShigGJVYhAvSGe9wcyVRys93	15	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.714
427	SovMShigGJVYhAvSGe9wcyVRys93	16	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.714
428	SovMShigGJVYhAvSGe9wcyVRys93	17	Muy poco	Ansiedad Social Baja	2024-06-24 23:43:59.714
429	SovMShigGJVYhAvSGe9wcyVRys93	1	Un poco	Ansiedad Social Baja	2024-06-25 13:50:28.884
430	SovMShigGJVYhAvSGe9wcyVRys93	2	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.885
431	SovMShigGJVYhAvSGe9wcyVRys93	3	Nada	Ansiedad Social Baja	2024-06-25 13:50:28.885
432	SovMShigGJVYhAvSGe9wcyVRys93	4	Nada	Ansiedad Social Baja	2024-06-25 13:50:28.885
433	SovMShigGJVYhAvSGe9wcyVRys93	5	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.885
434	SovMShigGJVYhAvSGe9wcyVRys93	6	Un poco	Ansiedad Social Baja	2024-06-25 13:50:28.885
435	SovMShigGJVYhAvSGe9wcyVRys93	7	Un poco	Ansiedad Social Baja	2024-06-25 13:50:28.885
436	SovMShigGJVYhAvSGe9wcyVRys93	8	Demasiado	Ansiedad Social Baja	2024-06-25 13:50:28.885
437	SovMShigGJVYhAvSGe9wcyVRys93	9	Mucho	Ansiedad Social Baja	2024-06-25 13:50:28.885
438	SovMShigGJVYhAvSGe9wcyVRys93	10	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.886
439	SovMShigGJVYhAvSGe9wcyVRys93	11	Nada	Ansiedad Social Baja	2024-06-25 13:50:28.886
440	SovMShigGJVYhAvSGe9wcyVRys93	12	Un poco	Ansiedad Social Baja	2024-06-25 13:50:28.886
441	SovMShigGJVYhAvSGe9wcyVRys93	13	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.886
442	SovMShigGJVYhAvSGe9wcyVRys93	14	Mucho	Ansiedad Social Baja	2024-06-25 13:50:28.886
443	SovMShigGJVYhAvSGe9wcyVRys93	15	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.886
444	SovMShigGJVYhAvSGe9wcyVRys93	16	Nada	Ansiedad Social Baja	2024-06-25 13:50:28.886
445	SovMShigGJVYhAvSGe9wcyVRys93	17	Muy poco	Ansiedad Social Baja	2024-06-25 13:50:28.886
446	SovMShigGJVYhAvSGe9wcyVRys93	1	Muy poco	Ansiedad Social Moderada	2024-06-25 14:05:46.421
447	SovMShigGJVYhAvSGe9wcyVRys93	2	Nada	Ansiedad Social Moderada	2024-06-25 14:05:46.421
448	SovMShigGJVYhAvSGe9wcyVRys93	3	Un poco	Ansiedad Social Moderada	2024-06-25 14:05:46.421
449	SovMShigGJVYhAvSGe9wcyVRys93	4	Muy poco	Ansiedad Social Moderada	2024-06-25 14:05:46.421
450	SovMShigGJVYhAvSGe9wcyVRys93	5	Muy poco	Ansiedad Social Moderada	2024-06-25 14:05:46.421
451	SovMShigGJVYhAvSGe9wcyVRys93	6	Mucho	Ansiedad Social Moderada	2024-06-25 14:05:46.421
452	SovMShigGJVYhAvSGe9wcyVRys93	7	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.421
453	SovMShigGJVYhAvSGe9wcyVRys93	8	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.421
454	SovMShigGJVYhAvSGe9wcyVRys93	9	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.422
455	SovMShigGJVYhAvSGe9wcyVRys93	10	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.422
456	SovMShigGJVYhAvSGe9wcyVRys93	11	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.422
457	SovMShigGJVYhAvSGe9wcyVRys93	12	Mucho	Ansiedad Social Moderada	2024-06-25 14:05:46.422
458	SovMShigGJVYhAvSGe9wcyVRys93	13	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.422
459	SovMShigGJVYhAvSGe9wcyVRys93	14	Muy poco	Ansiedad Social Moderada	2024-06-25 14:05:46.422
460	SovMShigGJVYhAvSGe9wcyVRys93	15	Un poco	Ansiedad Social Moderada	2024-06-25 14:05:46.422
461	SovMShigGJVYhAvSGe9wcyVRys93	16	Mucho	Ansiedad Social Moderada	2024-06-25 14:05:46.422
462	SovMShigGJVYhAvSGe9wcyVRys93	17	Demasiado	Ansiedad Social Moderada	2024-06-25 14:05:46.422
463	SovMShigGJVYhAvSGe9wcyVRys93	1	Muy poco	Ansiedad Social Baja	2024-06-26 15:15:17.557
464	SovMShigGJVYhAvSGe9wcyVRys93	2	Mucho	Ansiedad Social Baja	2024-06-26 15:15:17.557
465	SovMShigGJVYhAvSGe9wcyVRys93	3	Nada	Ansiedad Social Baja	2024-06-26 15:15:17.558
466	SovMShigGJVYhAvSGe9wcyVRys93	4	Un poco	Ansiedad Social Baja	2024-06-26 15:15:17.559
467	SovMShigGJVYhAvSGe9wcyVRys93	5	Muy poco	Ansiedad Social Baja	2024-06-26 15:15:17.559
468	SovMShigGJVYhAvSGe9wcyVRys93	6	Nada	Ansiedad Social Baja	2024-06-26 15:15:17.559
469	SovMShigGJVYhAvSGe9wcyVRys93	7	Un poco	Ansiedad Social Baja	2024-06-26 15:15:17.559
470	SovMShigGJVYhAvSGe9wcyVRys93	8	Nada	Ansiedad Social Baja	2024-06-26 15:15:17.559
471	SovMShigGJVYhAvSGe9wcyVRys93	9	Muy poco	Ansiedad Social Baja	2024-06-26 15:15:17.559
472	SovMShigGJVYhAvSGe9wcyVRys93	10	Un poco	Ansiedad Social Baja	2024-06-26 15:15:17.56
473	SovMShigGJVYhAvSGe9wcyVRys93	11	Nada	Ansiedad Social Baja	2024-06-26 15:15:17.56
474	SovMShigGJVYhAvSGe9wcyVRys93	12	Mucho	Ansiedad Social Baja	2024-06-26 15:15:17.56
475	SovMShigGJVYhAvSGe9wcyVRys93	13	Mucho	Ansiedad Social Baja	2024-06-26 15:15:17.56
476	SovMShigGJVYhAvSGe9wcyVRys93	14	Mucho	Ansiedad Social Baja	2024-06-26 15:15:17.56
477	SovMShigGJVYhAvSGe9wcyVRys93	15	Mucho	Ansiedad Social Baja	2024-06-26 15:15:17.56
478	SovMShigGJVYhAvSGe9wcyVRys93	16	Demasiado	Ansiedad Social Baja	2024-06-26 15:15:17.56
479	SovMShigGJVYhAvSGe9wcyVRys93	17	Demasiado	Ansiedad Social Baja	2024-06-26 15:15:17.56
480	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	1	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.228
481	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	2	Un poco	Ansiedad Social Baja	2024-06-27 00:48:56.229
482	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	3	Un poco	Ansiedad Social Baja	2024-06-27 00:48:56.229
483	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	4	Demasiado	Ansiedad Social Baja	2024-06-27 00:48:56.229
484	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	5	Muy poco	Ansiedad Social Baja	2024-06-27 00:48:56.229
485	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	6	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.23
486	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	7	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.23
487	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	8	Muy poco	Ansiedad Social Baja	2024-06-27 00:48:56.23
488	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	9	Un poco	Ansiedad Social Baja	2024-06-27 00:48:56.23
489	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	10	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.231
490	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	11	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.231
491	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	12	Demasiado	Ansiedad Social Baja	2024-06-27 00:48:56.231
492	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	13	Un poco	Ansiedad Social Baja	2024-06-27 00:48:56.231
493	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	14	Demasiado	Ansiedad Social Baja	2024-06-27 00:48:56.231
494	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	15	Un poco	Ansiedad Social Baja	2024-06-27 00:48:56.231
495	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	16	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.231
496	EhXJV0JyjBPzfkXWLZxCjE8l9wn2	17	Nada	Ansiedad Social Baja	2024-06-27 00:48:56.231
497	nepexQ0vNTRjUvTgTbluZgXjygS2	1	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.481
498	nepexQ0vNTRjUvTgTbluZgXjygS2	2	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.486
499	nepexQ0vNTRjUvTgTbluZgXjygS2	3	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.486
500	nepexQ0vNTRjUvTgTbluZgXjygS2	4	Mucho	Ansiedad Social Moderada	2024-06-28 20:31:46.487
501	nepexQ0vNTRjUvTgTbluZgXjygS2	5	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.487
502	nepexQ0vNTRjUvTgTbluZgXjygS2	6	Mucho	Ansiedad Social Moderada	2024-06-28 20:31:46.487
503	nepexQ0vNTRjUvTgTbluZgXjygS2	7	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.487
504	nepexQ0vNTRjUvTgTbluZgXjygS2	8	Mucho	Ansiedad Social Moderada	2024-06-28 20:31:46.487
505	nepexQ0vNTRjUvTgTbluZgXjygS2	9	Muy poco	Ansiedad Social Moderada	2024-06-28 20:31:46.487
506	nepexQ0vNTRjUvTgTbluZgXjygS2	10	Un poco	Ansiedad Social Moderada	2024-06-28 20:31:46.487
507	nepexQ0vNTRjUvTgTbluZgXjygS2	11	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.487
508	nepexQ0vNTRjUvTgTbluZgXjygS2	12	Mucho	Ansiedad Social Moderada	2024-06-28 20:31:46.488
509	nepexQ0vNTRjUvTgTbluZgXjygS2	13	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.488
510	nepexQ0vNTRjUvTgTbluZgXjygS2	14	Un poco	Ansiedad Social Moderada	2024-06-28 20:31:46.488
511	nepexQ0vNTRjUvTgTbluZgXjygS2	15	Demasiado	Ansiedad Social Moderada	2024-06-28 20:31:46.488
512	nepexQ0vNTRjUvTgTbluZgXjygS2	16	Muy poco	Ansiedad Social Moderada	2024-06-28 20:31:46.488
513	nepexQ0vNTRjUvTgTbluZgXjygS2	17	Nada	Ansiedad Social Moderada	2024-06-28 20:31:46.488
514	he1QuZbQnIhNsdsmm0jkxsu4e7t2	1	Nada	Ansiedad Social Moderada	2024-07-06 15:57:10.948
515	he1QuZbQnIhNsdsmm0jkxsu4e7t2	2	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.951
516	he1QuZbQnIhNsdsmm0jkxsu4e7t2	3	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.951
517	he1QuZbQnIhNsdsmm0jkxsu4e7t2	4	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.951
518	he1QuZbQnIhNsdsmm0jkxsu4e7t2	5	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.951
519	he1QuZbQnIhNsdsmm0jkxsu4e7t2	6	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.951
520	he1QuZbQnIhNsdsmm0jkxsu4e7t2	7	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.951
521	he1QuZbQnIhNsdsmm0jkxsu4e7t2	8	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.951
522	he1QuZbQnIhNsdsmm0jkxsu4e7t2	9	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.951
523	he1QuZbQnIhNsdsmm0jkxsu4e7t2	10	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.952
524	he1QuZbQnIhNsdsmm0jkxsu4e7t2	11	Muy poco	Ansiedad Social Moderada	2024-07-06 15:57:10.952
525	he1QuZbQnIhNsdsmm0jkxsu4e7t2	12	Un poco	Ansiedad Social Moderada	2024-07-06 15:57:10.952
526	he1QuZbQnIhNsdsmm0jkxsu4e7t2	13	Muy poco	Ansiedad Social Moderada	2024-07-06 15:57:10.952
527	he1QuZbQnIhNsdsmm0jkxsu4e7t2	14	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.952
528	he1QuZbQnIhNsdsmm0jkxsu4e7t2	15	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.952
529	he1QuZbQnIhNsdsmm0jkxsu4e7t2	16	Demasiado	Ansiedad Social Moderada	2024-07-06 15:57:10.952
530	he1QuZbQnIhNsdsmm0jkxsu4e7t2	17	Mucho	Ansiedad Social Moderada	2024-07-06 15:57:10.952
531	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	1	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.531
532	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	2	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.532
533	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	3	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.533
534	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	4	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.533
535	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	5	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.533
536	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	6	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.533
537	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	7	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.534
538	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	8	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.534
539	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	9	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.534
540	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	10	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.535
541	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	11	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.535
542	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	12	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.535
543	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	13	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.535
544	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	14	Un poco	Ansiedad Social Moderada	2024-07-07 03:19:14.535
545	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	15	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.535
546	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	16	Demasiado	Ansiedad Social Moderada	2024-07-07 03:19:14.536
547	TFmfAXQKw2TO2MYkD8k8bfYHlOn2	17	Mucho	Ansiedad Social Moderada	2024-07-07 03:19:14.536
548	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	1	Un poco	Ansiedad Social Moderada	2024-07-08 22:35:47.474
549	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	2	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.481
550	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	3	Muy poco	Ansiedad Social Moderada	2024-07-08 22:35:47.481
551	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	4	Un poco	Ansiedad Social Moderada	2024-07-08 22:35:47.481
552	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	5	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.483
553	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	6	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.483
554	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	7	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.483
555	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	8	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.483
556	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	9	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.483
557	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	10	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.484
558	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	11	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.484
559	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	12	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.484
560	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	13	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.484
561	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	14	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.484
562	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	15	Demasiado	Ansiedad Social Moderada	2024-07-08 22:35:47.484
563	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	16	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.484
564	AFPr7fzZ5lRqiwoDaDWmTPck7jF2	17	Mucho	Ansiedad Social Moderada	2024-07-08 22:35:47.484
565	etreEXBXv0P3lmiygo105zTsvox1	1	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.489
566	etreEXBXv0P3lmiygo105zTsvox1	2	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.494
567	etreEXBXv0P3lmiygo105zTsvox1	3	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.494
568	etreEXBXv0P3lmiygo105zTsvox1	4	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.494
569	etreEXBXv0P3lmiygo105zTsvox1	5	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.494
570	etreEXBXv0P3lmiygo105zTsvox1	6	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.495
571	etreEXBXv0P3lmiygo105zTsvox1	7	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.495
572	etreEXBXv0P3lmiygo105zTsvox1	8	Mucho	Ansiedad Social Moderada	2024-07-10 20:15:14.495
573	etreEXBXv0P3lmiygo105zTsvox1	9	Muy poco	Ansiedad Social Moderada	2024-07-10 20:15:14.495
574	etreEXBXv0P3lmiygo105zTsvox1	10	Muy poco	Ansiedad Social Moderada	2024-07-10 20:15:14.496
575	etreEXBXv0P3lmiygo105zTsvox1	11	Un poco	Ansiedad Social Moderada	2024-07-10 20:15:14.496
576	etreEXBXv0P3lmiygo105zTsvox1	12	Muy poco	Ansiedad Social Moderada	2024-07-10 20:15:14.496
577	etreEXBXv0P3lmiygo105zTsvox1	13	Un poco	Ansiedad Social Moderada	2024-07-10 20:15:14.496
578	etreEXBXv0P3lmiygo105zTsvox1	14	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.496
579	etreEXBXv0P3lmiygo105zTsvox1	15	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.496
580	etreEXBXv0P3lmiygo105zTsvox1	16	Mucho	Ansiedad Social Moderada	2024-07-10 20:15:14.496
581	etreEXBXv0P3lmiygo105zTsvox1	17	Demasiado	Ansiedad Social Moderada	2024-07-10 20:15:14.496
582	ERVOfA2CoubfDQgP0j3nKUuRlmh2	1	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.232
583	ERVOfA2CoubfDQgP0j3nKUuRlmh2	2	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.237
584	ERVOfA2CoubfDQgP0j3nKUuRlmh2	3	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.237
585	ERVOfA2CoubfDQgP0j3nKUuRlmh2	4	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.237
586	ERVOfA2CoubfDQgP0j3nKUuRlmh2	5	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.237
587	ERVOfA2CoubfDQgP0j3nKUuRlmh2	6	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.237
588	ERVOfA2CoubfDQgP0j3nKUuRlmh2	7	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.237
589	ERVOfA2CoubfDQgP0j3nKUuRlmh2	8	Un poco	Ansiedad Social Moderada	2024-07-16 16:45:49.237
590	ERVOfA2CoubfDQgP0j3nKUuRlmh2	9	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.237
591	ERVOfA2CoubfDQgP0j3nKUuRlmh2	10	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.238
592	ERVOfA2CoubfDQgP0j3nKUuRlmh2	11	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.239
593	ERVOfA2CoubfDQgP0j3nKUuRlmh2	12	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.239
594	ERVOfA2CoubfDQgP0j3nKUuRlmh2	13	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.239
595	ERVOfA2CoubfDQgP0j3nKUuRlmh2	14	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.239
596	ERVOfA2CoubfDQgP0j3nKUuRlmh2	15	Demasiado	Ansiedad Social Moderada	2024-07-16 16:45:49.239
597	ERVOfA2CoubfDQgP0j3nKUuRlmh2	16	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.239
598	ERVOfA2CoubfDQgP0j3nKUuRlmh2	17	Mucho	Ansiedad Social Moderada	2024-07-16 16:45:49.239
\.


--
-- TOC entry 4819 (class 0 OID 0)
-- Dependencies: 215
-- Name: preguntas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_id_seq', 30, true);


--
-- TOC entry 4820 (class 0 OID 0)
-- Dependencies: 218
-- Name: respuestas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.respuestas_id_seq', 598, true);


--
-- TOC entry 4655 (class 2606 OID 16516)
-- Name: personas id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT id_unique UNIQUE (id);


--
-- TOC entry 4653 (class 2606 OID 16453)
-- Name: preguntas preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (id);


--
-- TOC entry 4659 (class 2606 OID 16578)
-- Name: respuestas respuestas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_pkey PRIMARY KEY (id);


--
-- TOC entry 4656 (class 1259 OID 16591)
-- Name: idx_respuestas_persona_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_respuestas_persona_id ON public.respuestas USING btree (persona_id);


--
-- TOC entry 4657 (class 1259 OID 16592)
-- Name: idx_respuestas_pregunta_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_respuestas_pregunta_id ON public.respuestas USING btree (pregunta_id);


--
-- TOC entry 4660 (class 2606 OID 16581)
-- Name: respuestas fk_pregunta_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT fk_pregunta_id FOREIGN KEY (pregunta_id) REFERENCES public.preguntas(id);


--
-- TOC entry 4661 (class 2606 OID 16586)
-- Name: respuestas respuestas_persona_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.respuestas
    ADD CONSTRAINT respuestas_persona_id_fkey FOREIGN KEY (persona_id) REFERENCES public.personas(id);


--
-- TOC entry 4816 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-09-13 22:09:38

--
-- PostgreSQL database dump complete
--

