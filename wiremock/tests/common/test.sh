#!/usr/bin/env bash
set -e

BASE_URL="http://localhost:9000"
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
      curl -sS -X DELETE "$url";;
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

### Retrieve token ###
test_endpoint POST "$BASE_URL/token"