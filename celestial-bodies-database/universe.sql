--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: black_hole; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.black_hole (
    black_hole_id integer NOT NULL,
    name character varying(60) NOT NULL,
    constellation character varying(60)
);


ALTER TABLE public.black_hole OWNER TO freecodecamp;

--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.black_hole_black_hole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.black_hole_black_hole_id_seq OWNER TO freecodecamp;

--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.black_hole_black_hole_id_seq OWNED BY public.black_hole.black_hole_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    num_of_stars_bn smallint,
    type character varying(60),
    constellation character varying(60),
    years_old_bn numeric(3,1)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    orbit_distance_km integer,
    orbital_period_days numeric(4,1),
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    has_life boolean,
    description text,
    distance_from_earth integer,
    mean_tmp_celc smallint,
    star_id integer NOT NULL,
    is_dwarf boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    type character varying(60),
    temp_in_celcius smallint,
    years_old_bn numeric(3,1),
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: black_hole black_hole_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole ALTER COLUMN black_hole_id SET DEFAULT nextval('public.black_hole_black_hole_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: black_hole; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.black_hole VALUES (1, 'Gaia BH1', 'Ophiuchus');
INSERT INTO public.black_hole VALUES (2, 'TON 618', 'Canes Venatici');
INSERT INTO public.black_hole VALUES (3, 'Sagittarius A*', 'Sagittarius');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 100, 'Barred Spiral', 'Sagittarius', 13.6);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 1000, 'Spiral', 'Andromeda', NULL);
INSERT INTO public.galaxy VALUES (3, 'Sombrero', NULL, 'Spiral', 'Virgo', NULL);
INSERT INTO public.galaxy VALUES (4, 'Whirlpool', NULL, 'Spiral', 'Canes Venatici', NULL);
INSERT INTO public.galaxy VALUES (5, 'Triangulum', 40, 'Spiral', 'Triangulum', NULL);
INSERT INTO public.galaxy VALUES (6, 'Messier 87', 1000, 'Elliptical', 'Virgo', NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon', 382500, 27.3, 4);
INSERT INTO public.moon VALUES (3, 'Phobos', 9376, 0.3, 5);
INSERT INTO public.moon VALUES (4, 'IO', 421800, 1.7, 6);
INSERT INTO public.moon VALUES (5, 'Deimos', 23458, 1.3, 5);
INSERT INTO public.moon VALUES (6, 'Europa', 671000, 3.5, 6);
INSERT INTO public.moon VALUES (7, 'Ganymede', 1070400, 7.2, 6);
INSERT INTO public.moon VALUES (8, 'Callisto', 1882700, 16.7, 6);
INSERT INTO public.moon VALUES (9, 'Enceladus', 238037, 1.4, 7);
INSERT INTO public.moon VALUES (10, 'Miranda', 129900, 1.4, 8);
INSERT INTO public.moon VALUES (11, 'Titan', 1221850, 15.9, 7);
INSERT INTO public.moon VALUES (12, 'Triton', 354800, 5.9, 9);
INSERT INTO public.moon VALUES (13, 'Charon', 17536, 6.4, 14);
INSERT INTO public.moon VALUES (14, 'Rhea', 527068, 4.5, 7);
INSERT INTO public.moon VALUES (15, 'Iapetus', 3560851, 79.3, 7);
INSERT INTO public.moon VALUES (16, 'Titania', 436300, 8.7, 8);
INSERT INTO public.moon VALUES (17, 'Phoebe', 12952000, 551.0, 7);
INSERT INTO public.moon VALUES (18, 'Mimas', 186000, 0.9, 7);
INSERT INTO public.moon VALUES (19, 'Dione', 377400, 2.7, 7);
INSERT INTO public.moon VALUES (20, 'Tethys', 295000, 1.9, 7);
INSERT INTO public.moon VALUES (21, 'Prometheus', 139000, 0.6, 7);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (14, 'Pluto', false, 'Pluto was long considered our solar systems ninth planet. But it was reclassified as a dwarf planet in 2006 by the International Astronomical Union', 7500, -232, 1, true);
INSERT INTO public.planet VALUES (1, 'Mercury', false, 'Mercury is the smallest planet in our solar system and is located closest to the Sun', 77, 167, 1, false);
INSERT INTO public.planet VALUES (3, 'Venus', false, 'Throughout history, Venus was one of the planets that many civilizations recognized. Named after the Roman goddess of love and beauty, it was also known by the Greeks as Aphrodite', 40, 464, 1, false);
INSERT INTO public.planet VALUES (4, 'Earth', true, 'Earth is the only known planet to support life and was formed around 4.54 billion years ago', NULL, 15, 1, false);
INSERT INTO public.planet VALUES (5, 'Mars', false, 'It has a distinctive red color and was therefore associated with battles and war and named after the Roman god of war', 225, -63, 1, false);
INSERT INTO public.planet VALUES (6, 'Jupiter', false, 'It’s the fifth planet from the sun in our solar system and the largest planet of all', 714, -110, 1, false);
INSERT INTO public.planet VALUES (7, 'Saturn', false, 'Saturn has a diameter that is the second largest in our solar system', 1300, -178, 1, false);
INSERT INTO public.planet VALUES (8, 'Uranus', false, 'The planet Uranus is one of the gas giants and in our solar system, it’s huge diameter makes it the third largest and the fourth in mass', 2600, -195, 1, false);
INSERT INTO public.planet VALUES (9, 'Neptune', false, 'Neptune is the eighth planet in our solar system and is known for its beautiful blue color', 3000, -214, 1, false);
INSERT INTO public.planet VALUES (11, 'Kepler-90e', false, 'Kepler-90e is a Neptune-like exoplanet that orbits a G-type star', NULL, 453, 2, false);
INSERT INTO public.planet VALUES (10, 'Kepler-90i', false, 'Kepler-90 i is a super Earth exoplanet that orbits a G-type star', NULL, 436, 2, false);
INSERT INTO public.planet VALUES (12, 'Kepler-90f', false, 'Kepler-90f is a Neptune-like exoplanet that orbits a G-type star', NULL, 134, 2, false);
INSERT INTO public.planet VALUES (13, 'Kepler-90h', false, 'Kepler-90h is a gas giant exoplanet that orbits a G-type star', NULL, 19, 2, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 'Yellow dwarf', 5600, 4.6, 1);
INSERT INTO public.star VALUES (2, 'Kepler-90', 'Yellow dwarf', 5800, 2.0, 1);
INSERT INTO public.star VALUES (3, 'Proxima Centauri', 'Red dwarf', 2768, NULL, 1);
INSERT INTO public.star VALUES (4, 'Sirius', 'Binary star', 9666, 0.2, 1);
INSERT INTO public.star VALUES (5, 'Lich Pulsar', 'Neutron star', 28583, 1.0, 1);
INSERT INTO public.star VALUES (6, 'Fomalhaut', 'Hydrogen-fusing dwarf', 8316, 0.1, 1);


--
-- Name: black_hole_black_hole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.black_hole_black_hole_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 14, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: black_hole black_hole_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_name_key UNIQUE (name);


--
-- Name: black_hole black_hole_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.black_hole
    ADD CONSTRAINT black_hole_pkey PRIMARY KEY (black_hole_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon fk_planet_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT fk_planet_id FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet fk_star_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT fk_star_id FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

