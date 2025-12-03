#!/usr/bin/env bash
set -e

SERVICE="api/v2/employee"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

# Sample IDs
PERSON_ID_OK="7a1f2b3c-8d4e-4f11-9a2b-0c1d2e3f4a5b"
PERSON_ID_404="00000000-0000-0000-0000-000000000000"
MANAGER_ID="9c3f4d5e-af6a-4b33-7c4d-2e3f4a5b6c7d"

source "$(dirname "$0")/../_helpers.sh"
init_report

# Accounts 200 and 404
run_test   "GetAccounts200" GET "$BASE_URL/$MUNICIPALITY_ID/employed/$PERSON_ID_OK/accounts" "jdoe"
run_status "GetAccounts404" GET "$BASE_URL/$MUNICIPALITY_ID/employed/$PERSON_ID_404/accounts" 404 "Not Found"

# Portal person data by domain/login and by email
run_test "GetPortalPersonDataByDomainLogin" GET "$BASE_URL/$MUNICIPALITY_ID/portalpersondata/AD/jdoe" "John Doe"
run_test "GetPortalPersonDataByEmail"       GET "$BASE_URL/$MUNICIPALITY_ID/portalpersondata/jane.doe@example.com" "Jane Doe"

# Employments and New Employments
run_test "ListEmployments"     GET "$BASE_URL/$MUNICIPALITY_ID/employments" "Engineer"
run_test "ListNewEmployments"  GET "$BASE_URL/$MUNICIPALITY_ID/newemployments" "Analyst"

# Person image: GET (binary), PUT, DELETE
run_test   "GetPersonImage"   GET "$BASE_URL/$MUNICIPALITY_ID/$PERSON_ID_OK/personimage"
run_test   "PutPersonImage"   PUT "$BASE_URL/$MUNICIPALITY_ID/$PERSON_ID_OK/personimage" "updated" '{"title":"Profile","imageData":"<base64>"}'
run_test   "DeletePersonImage" DELETE "$BASE_URL/$MUNICIPALITY_ID/$PERSON_ID_OK/personimage" "deleted"

# Manager employees
run_test   "GetManagerEmployees" GET "$BASE_URL/$MUNICIPALITY_ID/manageremployees/$MANAGER_ID" "9c3f4d5e-af6a-4b33-7c4d-2e3f4a5b6c7d"

print_summary_and_exit
