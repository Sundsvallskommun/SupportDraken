#!/usr/bin/env bash
set -e

SERVICE="api/v2/legalentity"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

LEGAL_ENTITY_ID="123e4567-e89b-12d3-a456-426614174000"
ORGANIZATION_NUMBER="5590001234"
PERSON_NUMBER="19700101-1234"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Resolve GUID by organization number
run_test "GetGuidByOrganizationNumber" GET "$BASE_URL/$MUNICIPALITY_ID/$ORGANIZATION_NUMBER/guid" "$LEGAL_ENTITY_ID"

# Resolve organization number by legal entity id
run_test "GetOrganizationNumberById" GET "$BASE_URL/$MUNICIPALITY_ID/$LEGAL_ENTITY_ID/organizationnumber" "$ORGANIZATION_NUMBER"

# Get legal entity by id
run_test "GetLegalentityById" GET "$BASE_URL/$MUNICIPALITY_ID/$LEGAL_ENTITY_ID" "legalEntityId"

# Get person engagements
run_test "GetPersonEngagements" GET "$BASE_URL/$MUNICIPALITY_ID/engagements/person/$PERSON_NUMBER" "organizationNumber"

# Get organization engagements
run_test "GetOrganizationEngagements" GET "$BASE_URL/$MUNICIPALITY_ID/engagements/organization/$ORGANIZATION_NUMBER" "engagements"

print_summary_and_exit
