--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 14.8

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
-- Name: beehive; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA beehive;


--
-- Name: QueueStatus; Type: TYPE; Schema: beehive; Owner: -
--

CREATE TYPE beehive."QueueStatus" AS ENUM (
    'ACCEPTED',
    'EXECUTING',
    'COMPLETED',
    'ERRORED'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Extraction; Type: TABLE; Schema: beehive; Owner: -
--

CREATE TABLE beehive."Extraction" (
    "extractionId" text NOT NULL,
    "chainId" integer NOT NULL,
    "lastBlockNumber" integer NOT NULL,
    "outputsHash" text NOT NULL
);


--
-- Name: Queue; Type: TABLE; Schema: beehive; Owner: -
--

CREATE TABLE beehive."Queue" (
    "slotId" integer NOT NULL,
    status beehive."QueueStatus" DEFAULT 'ACCEPTED'::beehive."QueueStatus" NOT NULL,
    request jsonb NOT NULL,
    result jsonb,
    error text,
    "enqueueTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updateTime" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "routingTag" text NOT NULL,
    "requestId" text NOT NULL
);


--
-- Name: Queue_slotId_seq; Type: SEQUENCE; Schema: beehive; Owner: -
--

CREATE SEQUENCE beehive."Queue_slotId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Queue_slotId_seq; Type: SEQUENCE OWNED BY; Schema: beehive; Owner: -
--

ALTER SEQUENCE beehive."Queue_slotId_seq" OWNED BY beehive."Queue"."slotId";


--
-- Name: RoyaltyData; Type: TABLE; Schema: beehive; Owner: -
--

CREATE TABLE beehive."RoyaltyData" (
    "collectionContract" text NOT NULL,
    "executingContract" text NOT NULL,
    "tokenContract" text NOT NULL,
    "blockNumber" integer NOT NULL,
    "transactionHash" text NOT NULL,
    "logIndex" integer NOT NULL,
    "fromAddr" text NOT NULL,
    "toAddr" text NOT NULL,
    "tokenId" text NOT NULL,
    data text NOT NULL,
    amount bigint NOT NULL,
    "timestamp" timestamp(3) without time zone NOT NULL
);


--
-- Name: Queue slotId; Type: DEFAULT; Schema: beehive; Owner: -
--

ALTER TABLE ONLY beehive."Queue" ALTER COLUMN "slotId" SET DEFAULT nextval('beehive."Queue_slotId_seq"'::regclass);


--
-- Name: Extraction Extraction_pkey; Type: CONSTRAINT; Schema: beehive; Owner: -
--

ALTER TABLE ONLY beehive."Extraction"
    ADD CONSTRAINT "Extraction_pkey" PRIMARY KEY ("extractionId");


--
-- Name: Queue Queue_pkey; Type: CONSTRAINT; Schema: beehive; Owner: -
--

ALTER TABLE ONLY beehive."Queue"
    ADD CONSTRAINT "Queue_pkey" PRIMARY KEY ("slotId");


--
-- Name: RoyaltyData RoyaltyData_pkey; Type: CONSTRAINT; Schema: beehive; Owner: -
--

ALTER TABLE ONLY beehive."RoyaltyData"
    ADD CONSTRAINT "RoyaltyData_pkey" PRIMARY KEY ("transactionHash", "logIndex");


--
-- Name: Queue_routingTag_requestId_key; Type: INDEX; Schema: beehive; Owner: -
--

CREATE UNIQUE INDEX "Queue_routingTag_requestId_key" ON beehive."Queue" USING btree ("routingTag", "requestId");


--
-- PostgreSQL database dump complete
--

