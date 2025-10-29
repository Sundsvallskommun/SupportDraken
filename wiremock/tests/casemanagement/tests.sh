#!/usr/bin/env bash
set -e

SERVICE="casemanagement"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

EXTERNAL_CASE_ID="externalCaseId"
ORGANIZATION_NUMBER="organizationNumber"
PARTY_ID="partyId"

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

### Get status for a specific case by external case id.
echo "Expects an error"
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/cases/$EXTERNAL_CASE_ID/status"
### Get case statuses for an organization number.
echo "Expects an empty array []"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/organization/$ORGANIZATION_NUMBER/cases/status"
### get case statuses for a party id.
echo "Expects an empty array []"
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/$PARTY_ID/statuses"