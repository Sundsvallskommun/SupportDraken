#!/usr/bin/env bash
set -e

SERVICE="emailreader"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

NAMESPACE="NS1"
ATTACHMENT_ID="attachmentId"
EMAIL_ID="emailId"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Get emails for a namespace (200 [])
run_test "GetEmails" GET "$BASE_URL/$MUNICIPALITY_ID/email/$NAMESPACE" "[]"

# Fetch a specific attachment (200 binary)
run_test "GetAttachment" GET "$BASE_URL/$MUNICIPALITY_ID/email/attachments/$ATTACHMENT_ID"

# Delete a specific email (200)
run_test "DeleteEmail" DELETE "$BASE_URL/$MUNICIPALITY_ID/email/$EMAIL_ID"

print_summary_and_exit
