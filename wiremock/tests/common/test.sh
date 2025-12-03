#!/usr/bin/env bash
set -e

SERVICE="token"
BASE_URL="http://localhost:9000/$SERVICE"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Retrieve token
run_test "RetrieveToken" POST "$BASE_URL" "access_token"

print_summary_and_exit
