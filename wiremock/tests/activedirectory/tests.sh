#!/usr/bin/env bash
set -e

SERVICE="activedirectory"
BASE_URL="http://localhost:9000/$SERVICE"
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

### Expect 2 groups.
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/search/personal"

### Expect 2 users in group
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/group1"

### Expect 1 user in group
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/group2"

### Expect empty array
test_endpoint GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/invalid-group"

### Expect 2 groups
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/joe01doe"

### Expect 1 group
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/jan01doe"

## Expect empty array
test_endpoint GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/invalid-user"