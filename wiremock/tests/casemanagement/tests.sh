#!/usr/bin/env bash
set -e

SERVICE="casemanagement"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

EXTERNAL_CASE_ID="externalCaseId"
ORGANIZATION_NUMBER="organizationNumber"
PARTY_ID="partyId"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Get status for a specific case by external case id (404)
run_status "GetStatusByExternalCaseId" GET "$BASE_URL/$MUNICIPALITY_ID/cases/$EXTERNAL_CASE_ID/status" 404 "Case not found"

# Get case statuses for an organization number (200 [])
run_test "GetStatusesByOrganization" GET "$BASE_URL/$MUNICIPALITY_ID/organization/$ORGANIZATION_NUMBER/cases/status" "[]"

# Get case statuses for a party id (200 [])
run_test "GetStatusesByPartyId" GET "$BASE_URL/$MUNICIPALITY_ID/$PARTY_ID/statuses" "[]"

print_summary_and_exit
