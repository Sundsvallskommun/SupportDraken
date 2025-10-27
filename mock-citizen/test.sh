#!/usr/bin/env bash

set -e

BASE_URL="http://localhost:9000"
MUNICIPALITY_ID="2281"

test_endpoint()
{
  local method="$1"
  local url="$2"
  local data="${3:-}"

  echo ">> $method $url"

  if [ "$method" = "GET" ]; then
    curl "$url"
  else
    curl -X "$method" "$url" \
      -H "Content-Type: application/json" \
      -d "$data"
  fi

  echo
}

# /{municipalityId}/{personId}
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/550e8400-e29b-41d4-a716-446655440000"
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/06f7c0aa-bb0b-470f-90e8-c1920aff0ae2"

# /{municipalityId}/batch
test_endpoint POST "$BASE_URL/$MUNICIPALITY_ID/batch" \
  '["11111111-1111-1111-1111-111111111111", "22222222-2222-2222-2222-222222222222"]'

# /{municipalityId}/changedaddress
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/changedaddress"

# /{municipalityId}/{personId}/personnumber
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/11111111-1111-1111-1111-111111111111/personnumber"

# /{municipalityId}/{personNumber}/guid
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/19111111-1111/guid"

# /{municipalityId}/guid/batch
test_endpoint POST "$BASE_URL/$MUNICIPALITY_ID/guid/batch" \
  '["19111111-1111", "19222222-2222"]'

# test default 404
test_endpoint GET "$BASE_URL/foo"
test_endpoint POST "$BASE_URL/baz"
