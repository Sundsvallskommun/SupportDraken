#!/usr/bin/env bash
source "$(dirname "$0")/../_helpers.sh"

init_report
SERVICE="api/v3/citizen"
MUNICIPALITY_ID="2281"
BASE_URL="http://localhost:9000/$SERVICE/$MUNICIPALITY_ID"

# Person 1
run_test "person-1 details" GET "$BASE_URL/7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b" "Alice"
run_test "person-1 pn" GET "$BASE_URL/7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b/personnumber" "19700101-0001"

# Person 2
run_test "person-2 details" GET "$BASE_URL/8b2f3c4d-9e5f-4a22-8b3c-1d2e3f4a5b6c" "Bob"
run_test "person-2 pn" GET "$BASE_URL/8b2f3c4d-9e5f-4a22-8b3c-1d2e3f4a5b6c/personnumber" "19700101-0002"

# Person 3
run_test "person-3 details" GET "$BASE_URL/9c3f4d5e-af6a-4b33-7c4d-2e3f4a5b6c7d" "Carla"
run_test "person-3 pn" GET "$BASE_URL/9c3f4d5e-af6a-4b33-7c4d-2e3f4a5b6c7d/personnumber" "19700101-0003"

# Person 4
run_test "person-4 details" GET "$BASE_URL/ad4f5e6f-b07b-4c44-6d5e-3f4a5b6c7d8e" "David"
run_test "person-4 pn" GET "$BASE_URL/ad4f5e6f-b07b-4c44-6d5e-3f4a5b6c7d8e/personnumber" "19700101-0004"

# Person 5
run_test "person-5 details" GET "$BASE_URL/be5f6a7b-c18c-4d55-5e6f-4a5b6c7d8e9f" "Eva"
run_test "person-5 pn" GET "$BASE_URL/be5f6a7b-c18c-4d55-5e6f-4a5b6c7d8e9f/personnumber" "19700101-0005"

# GUID lookups by personNumber
run_test "person-1 guid" GET "$BASE_URL/19700101-0001/guid" "7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b"
run_test "person-2 guid" GET "$BASE_URL/19700101-0002/guid" "8b2f3c4d-9e5f-4a22-8b3c-1d2e3f4a5b6c"
run_test "person-3 guid" GET "$BASE_URL/19700101-0003/guid" "9c3f4d5e-af6a-4b33-7c4d-2e3f4a5b6c7d"
run_test "person-4 guid" GET "$BASE_URL/19700101-0004/guid" "ad4f5e6f-b07b-4c44-6d5e-3f4a5b6c7d8e"
run_test "person-5 guid" GET "$BASE_URL/19700101-0005/guid" "be5f6a7b-c18c-4d55-5e6f-4a5b6c7d8e9f"

# GUID batch (post personNumbers)
run_test "guid batch" POST "$BASE_URL/guid/batch" "7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b" '["19700101-0001","19700101-0002"]'

# Personnumbers batch (post personIds) -> expect personNumber in response
run_test "personnumbers batch" POST "$BASE_URL/personnumbers/batch" "19700101-0001" '["7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b","8b2f3c4d-9e5f-4a22-8b3c-1d2e3f4a5b6c"]'

# Changed address since
run_test "changedaddress" GET "$BASE_URL/changedaddress" "Alice"

# Fallback
UNKNOWN_ID="99999999-9999-9999-9999-999999999999"
run_test "fallback details" GET "$BASE_URL/$UNKNOWN_ID" "Zach"
run_test "fallback pn" GET "$BASE_URL/$UNKNOWN_ID/personnumber" "19700101-0006"

print_summary_and_exit
