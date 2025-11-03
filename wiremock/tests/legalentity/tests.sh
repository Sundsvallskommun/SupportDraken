#!/usr/bin/env bash
set -e

SERVICE="api/v2/legalentity"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

LEGAL_ENTITY_ID="123e4567-e89b-12d3-a456-426614174000"
ORGANIZATION_NUMBER="5590001234"
PERSON_NUMBER="19700101-1234"

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

### Resolve GUID by organization number
# Expect a UUID string
 test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$ORGANIZATION_NUMBER/guid"

### Resolve organization number by legal entity id
# Expect numeric org number string
 test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$LEGAL_ENTITY_ID/organizationnumber"

### Get legal entity by id
# Expect JSON object with fields matching schema
 test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/$LEGAL_ENTITY_ID"

### Get person engagements
# Expect JSON array of engagements
 test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/engagements/person/$PERSON_NUMBER"

### Get organization engagements
# Expect JSON object with engagements list
 test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/engagements/organization/$ORGANIZATION_NUMBER"
