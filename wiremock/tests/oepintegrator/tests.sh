#!/usr/bin/env bash
set -e

SERVICE="oepintegrator"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

INSTANCE_TYPE="internal"
FLOW_INSTANCE_ID="flowInstanceId"
PARTY_ID="partyId"
FAMILY_ID="familyId"

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

### Confirm a delivery to Open-E.
echo "Expects an empty response"
test_endpoint POST    "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/delivery" '{"caseId": 123, "delivered": true}'

### Set a status on an Open-E errand.
echo "Expects an empty response"
test_endpoint PUT "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/status" '{"id": 1, "name": "Per", "principal": null}'

### Get list of cases based on instance type and familyId.
echo "Expects an empty array []"
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/families/$FAMILY_ID"

### Get a specific case.
echo "Expect an 404 error"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID"

### Get status of a specific case.
echo "Expect an 404 error"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/status"

### Get case statuses for a given partyId.
echo "Expect an empty array []"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/parties/$PARTY_ID"

### Get a specific attachment.
echo "Expect a bunch of binary data"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/pdf"



