table "Extraction" {
  schema = schema.beehive
  column "extractionId" {
    null = false
    type = text
  }
  column "chainId" {
    null = false
    type = integer
  }
  column "lastBlockNumber" {
    null = false
    type = integer
  }
  column "outputsHash" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.extractionId]
  }
}
table "Queue" {
  schema = schema.beehive
  column "slotId" {
    null = false
    type = serial
  }
  column "status" {
    null    = false
    type    = enum.QueueStatus
    default = "ACCEPTED"
  }
  column "request" {
    null = false
    type = jsonb
  }
  column "result" {
    null = true
    type = jsonb
  }
  column "error" {
    null = true
    type = text
  }
  column "enqueueTime" {
    null    = false
    type    = timestamp(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "updateTime" {
    null    = false
    type    = timestamp(3)
    default = sql("CURRENT_TIMESTAMP")
  }
  column "routingTag" {
    null = false
    type = text
  }
  column "requestId" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.slotId]
  }
  index "Queue_routingTag_requestId_key" {
    unique  = true
    columns = [column.routingTag, column.requestId]
  }
}
table "RoyaltyData" {
  schema = schema.beehive
  column "collectionContract" {
    null = false
    type = text
  }
  column "executingContract" {
    null = false
    type = text
  }
  column "tokenContract" {
    null = false
    type = text
  }
  column "blockNumber" {
    null = false
    type = integer
  }
  column "transactionHash" {
    null = false
    type = text
  }
  column "logIndex" {
    null = false
    type = integer
  }
  column "fromAddr" {
    null = false
    type = text
  }
  column "toAddr" {
    null = false
    type = text
  }
  column "tokenId" {
    null = false
    type = text
  }
  column "data" {
    null = false
    type = text
  }
  column "amount" {
    null = false
    type = bigint
  }
  column "timestamp" {
    null = false
    type = timestamp(3)
  }
  primary_key {
    columns = [column.transactionHash, column.logIndex]
  }
}
enum "QueueStatus" {
  schema = schema.beehive
  values = ["ACCEPTED", "EXECUTING", "COMPLETED", "ERRORED"]
}
schema "beehive" {
}
