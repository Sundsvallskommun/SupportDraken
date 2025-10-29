#!/usr/bin/env bash
set -e

SERVICE="webmessagecollector"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

FAMILY_ID="123"
ATTACHMENT_ID="attachmentId"

test_endpoint() {
  local method="$1"
  local url="$2"
  local data="${3:-}"

  echo ">> $method $url"

  case "$method" in
    GET)
      curl -sS "$url";;
    DELETE)
      if [ -n "$data" ]; then
        curl -sS -X DELETE "$url" -H "Content-Type: application/json" -d "$data"
      else
        curl -sS -X DELETE "$url"
      fi;;
    POST)
      curl -sS -X POST "$url" -H "Content-Type: application/json" -d "${data:-{}}";;
    PUT)
      curl -sS -X PUT "$url" -H "Content-Type: application/json" -d "${data:-{}}";;
    PATCH)
      curl -sS -X PATCH "$url" -H "Content-Type: application/json" -d "${data:-{}}";;
    *)
      echo "Ogiltig metod: $method" >&2
      exit 2;;
  esac

  echo
} 

### Get messages for familyId "123" and instance "internal"
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/messages/$FAMILY_ID/internal"
### Delete all messages with ID in given list.
test_endpoint DELETE "$BASE_URL/$MUNICIPALITY_ID/messages" '[1,2,3]'
### Fetch a specific attachment
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/$ATTACHMENT_ID"
### Delete a specific attachment
test_endpoint DELETE "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/$ATTACHMENT_ID"