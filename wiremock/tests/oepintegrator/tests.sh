#!/usr/bin/env bash
set -e

SERVICE="oepintegrator"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

INSTANCE_TYPE="internal"
FLOW_INSTANCE_ID="flowInstanceId"
PARTY_ID="partyId"
FAMILY_ID="familyId"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Confirm a delivery to Open-E. (200 {})
run_test "ConfirmDelivery" POST "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/delivery" "" "{"caseId": 123, "delivered": true}"

# Set a status on an Open-E errand. (200 {})
run_test "SetStatus" PUT "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/status" "" '{"id": 1, "name": "Per", "principal": null}'

# Get list of cases based on instance type and familyId. (200 [])
run_test "GetCasesByFamily" GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/families/$FAMILY_ID" "[]"
 
# Get a specific case. (404)
run_status "GetCase" GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID" 404 "Case not found"

# Get status of a specific case. (404)
run_status "GetCaseStatus" GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/status" 404 "Case status not found"

# Get case statuses for a given partyId. (200 [])
run_test "GetCasesByParty" GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/parties/$PARTY_ID" "[]"

# Get a specific attachment (binary)
run_test "GetCasePdf" GET "$BASE_URL/$MUNICIPALITY_ID/$INSTANCE_TYPE/cases/$FLOW_INSTANCE_ID/pdf"

print_summary_and_exit
