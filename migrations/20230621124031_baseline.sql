-- Drop schema named "public"
DROP SCHEMA "public" CASCADE;
-- Add new schema named "beehive"
CREATE SCHEMA "beehive";
-- Create "Extraction" table
CREATE TABLE "beehive"."Extraction" ("extractionId" text NOT NULL, "chainId" integer NOT NULL, "lastBlockNumber" integer NOT NULL, "outputsHash" text NOT NULL, PRIMARY KEY ("extractionId"));
-- Create enum type "QueueStatus"
CREATE TYPE "beehive"."QueueStatus" AS ENUM ('ACCEPTED', 'EXECUTING', 'COMPLETED', 'ERRORED');
-- Create "Queue" table
CREATE TABLE "beehive"."Queue" ("slotId" serial NOT NULL, "status" "beehive"."QueueStatus" NOT NULL DEFAULT 'ACCEPTED', "request" jsonb NOT NULL, "result" jsonb NULL, "error" text NULL, "enqueueTime" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP, "updateTime" timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP, "routingTag" text NOT NULL, "requestId" text NOT NULL, PRIMARY KEY ("slotId"));
-- Create index "Queue_routingTag_requestId_key" to table: "Queue"
CREATE UNIQUE INDEX "Queue_routingTag_requestId_key" ON "beehive"."Queue" ("routingTag", "requestId");
-- Create "RoyaltyData" table
CREATE TABLE "beehive"."RoyaltyData" ("collectionContract" text NOT NULL, "executingContract" text NOT NULL, "tokenContract" text NOT NULL, "blockNumber" integer NOT NULL, "transactionHash" text NOT NULL, "logIndex" integer NOT NULL, "fromAddr" text NOT NULL, "toAddr" text NOT NULL, "tokenId" text NOT NULL, "data" text NOT NULL, "amount" bigint NOT NULL, "timestamp" timestamp(3) NOT NULL, PRIMARY KEY ("transactionHash", "logIndex"));
