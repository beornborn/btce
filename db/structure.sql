--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: day3s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE day3s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: day3s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE day3s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: day3s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE day3s_id_seq OWNED BY day3s.id;


--
-- Name: day7s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE day7s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: day7s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE day7s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: day7s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE day7s_id_seq OWNED BY day7s.id;


--
-- Name: days; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE days (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE days_id_seq OWNED BY days.id;


--
-- Name: exchanges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE exchanges (
    id integer NOT NULL,
    name character varying(255),
    comission numeric(10,5)
);


--
-- Name: exchanges_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exchanges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exchanges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE exchanges_id_seq OWNED BY exchanges.id;


--
-- Name: hour12s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hour12s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: hour12s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hour12s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hour12s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hour12s_id_seq OWNED BY hour12s.id;


--
-- Name: hour2s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hour2s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: hour2s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hour2s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hour2s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hour2s_id_seq OWNED BY hour2s.id;


--
-- Name: hour4s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hour4s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: hour4s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hour4s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hour4s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hour4s_id_seq OWNED BY hour4s.id;


--
-- Name: hour6s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hour6s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: hour6s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hour6s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hour6s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hour6s_id_seq OWNED BY hour6s.id;


--
-- Name: hours; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hours (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: hours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hours_id_seq OWNED BY hours.id;


--
-- Name: minute15s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minute15s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: minute15s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE minute15s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minute15s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE minute15s_id_seq OWNED BY minute15s.id;


--
-- Name: minute30s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minute30s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: minute30s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE minute30s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minute30s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE minute30s_id_seq OWNED BY minute30s.id;


--
-- Name: minute3s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minute3s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: minute3s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE minute3s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minute3s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE minute3s_id_seq OWNED BY minute3s.id;


--
-- Name: minute5s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minute5s (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: minute5s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE minute5s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minute5s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE minute5s_id_seq OWNED BY minute5s.id;


--
-- Name: minutes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE minutes (
    id integer NOT NULL,
    "time" timestamp without time zone,
    enter numeric(24,12),
    close numeric(24,12),
    min numeric(24,12),
    max numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: minutes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE minutes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minutes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE minutes_id_seq OWNED BY minutes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: strategy_results; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE strategy_results (
    id integer NOT NULL,
    "time" timestamp without time zone,
    btc numeric(24,12),
    usd numeric(24,12),
    estimate_usd numeric(24,12),
    strategy character varying(255)
);


--
-- Name: strategy_results_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE strategy_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strategy_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE strategy_results_id_seq OWNED BY strategy_results.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    "time" timestamp without time zone,
    price numeric(24,12),
    amount numeric(24,12)
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY day3s ALTER COLUMN id SET DEFAULT nextval('day3s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY day7s ALTER COLUMN id SET DEFAULT nextval('day7s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY days ALTER COLUMN id SET DEFAULT nextval('days_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY exchanges ALTER COLUMN id SET DEFAULT nextval('exchanges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hour12s ALTER COLUMN id SET DEFAULT nextval('hour12s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hour2s ALTER COLUMN id SET DEFAULT nextval('hour2s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hour4s ALTER COLUMN id SET DEFAULT nextval('hour4s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hour6s ALTER COLUMN id SET DEFAULT nextval('hour6s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hours ALTER COLUMN id SET DEFAULT nextval('hours_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY minute15s ALTER COLUMN id SET DEFAULT nextval('minute15s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY minute30s ALTER COLUMN id SET DEFAULT nextval('minute30s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY minute3s ALTER COLUMN id SET DEFAULT nextval('minute3s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY minute5s ALTER COLUMN id SET DEFAULT nextval('minute5s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY minutes ALTER COLUMN id SET DEFAULT nextval('minutes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY strategy_results ALTER COLUMN id SET DEFAULT nextval('strategy_results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Name: day3s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY day3s
    ADD CONSTRAINT day3s_pkey PRIMARY KEY (id);


--
-- Name: day7s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY day7s
    ADD CONSTRAINT day7s_pkey PRIMARY KEY (id);


--
-- Name: days_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY days
    ADD CONSTRAINT days_pkey PRIMARY KEY (id);


--
-- Name: exchanges_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY exchanges
    ADD CONSTRAINT exchanges_pkey PRIMARY KEY (id);


--
-- Name: hour12s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hour12s
    ADD CONSTRAINT hour12s_pkey PRIMARY KEY (id);


--
-- Name: hour2s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hour2s
    ADD CONSTRAINT hour2s_pkey PRIMARY KEY (id);


--
-- Name: hour4s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hour4s
    ADD CONSTRAINT hour4s_pkey PRIMARY KEY (id);


--
-- Name: hour6s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hour6s
    ADD CONSTRAINT hour6s_pkey PRIMARY KEY (id);


--
-- Name: hours_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hours
    ADD CONSTRAINT hours_pkey PRIMARY KEY (id);


--
-- Name: minute15s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minute15s
    ADD CONSTRAINT minute15s_pkey PRIMARY KEY (id);


--
-- Name: minute30s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minute30s
    ADD CONSTRAINT minute30s_pkey PRIMARY KEY (id);


--
-- Name: minute3s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minute3s
    ADD CONSTRAINT minute3s_pkey PRIMARY KEY (id);


--
-- Name: minute5s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minute5s
    ADD CONSTRAINT minute5s_pkey PRIMARY KEY (id);


--
-- Name: minutes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minutes
    ADD CONSTRAINT minutes_pkey PRIMARY KEY (id);


--
-- Name: strategy_results_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY strategy_results
    ADD CONSTRAINT strategy_results_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: index_day3s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_day3s_on_time ON day3s USING btree ("time");


--
-- Name: index_day7s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_day7s_on_time ON day7s USING btree ("time");


--
-- Name: index_days_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_days_on_time ON days USING btree ("time");


--
-- Name: index_hour12s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_hour12s_on_time ON hour12s USING btree ("time");


--
-- Name: index_hour2s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_hour2s_on_time ON hour2s USING btree ("time");


--
-- Name: index_hour4s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_hour4s_on_time ON hour4s USING btree ("time");


--
-- Name: index_hour6s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_hour6s_on_time ON hour6s USING btree ("time");


--
-- Name: index_hours_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_hours_on_time ON hours USING btree ("time");


--
-- Name: index_minute15s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_minute15s_on_time ON minute15s USING btree ("time");


--
-- Name: index_minute30s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_minute30s_on_time ON minute30s USING btree ("time");


--
-- Name: index_minute3s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_minute3s_on_time ON minute3s USING btree ("time");


--
-- Name: index_minute5s_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_minute5s_on_time ON minute5s USING btree ("time");


--
-- Name: index_minutes_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_minutes_on_time ON minutes USING btree ("time");


--
-- Name: index_transactions_on_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_transactions_on_time ON transactions USING btree ("time");


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131218193659');

INSERT INTO schema_migrations (version) VALUES ('20131219201914');

INSERT INTO schema_migrations (version) VALUES ('20131221070844');

INSERT INTO schema_migrations (version) VALUES ('20131221071618');

INSERT INTO schema_migrations (version) VALUES ('20131221201745');

INSERT INTO schema_migrations (version) VALUES ('20131221201757');

INSERT INTO schema_migrations (version) VALUES ('20131221201820');

INSERT INTO schema_migrations (version) VALUES ('20131221201839');

INSERT INTO schema_migrations (version) VALUES ('20131221201905');

INSERT INTO schema_migrations (version) VALUES ('20131221201933');

INSERT INTO schema_migrations (version) VALUES ('20131221201940');

INSERT INTO schema_migrations (version) VALUES ('20131221201948');

INSERT INTO schema_migrations (version) VALUES ('20131221201955');

INSERT INTO schema_migrations (version) VALUES ('20131221202016');

INSERT INTO schema_migrations (version) VALUES ('20131221202033');

INSERT INTO schema_migrations (version) VALUES ('20131221202041');
