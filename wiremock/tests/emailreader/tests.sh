#!/usr/bin/env bash
set -e

SERVICE="emailreader"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

NAMESPACE="NS1"
ATTACHMENT_ID="attachmentId"
EMAIL_ID="emailId"

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

### Get emails for a namespace
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/email/$NAMESPACE"
### Fetch a specific attachment
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/email/attachments/$ATTACHMENT_ID"
### Delete a specific email
test_endpoint DELETE "$BASE_URL/$MUNICIPALITY_ID/email/$EMAIL_ID"