#!/usr/bin/env bash
set -e

BASE_URL="http://localhost:9000/webmessagecollector"
MUNICIPALITY_ID="2281"

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
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/messages/123/internal"
### Delete all messages with ID in given list.
test_endpoint DELETE "$BASE_URL/$MUNICIPALITY_ID/messages" '[1,2,3]'
### Fetch a specific attachment
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/attachmentId"
### Delete a specific attachment
test_endpoint DELETE "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/attachmentId"