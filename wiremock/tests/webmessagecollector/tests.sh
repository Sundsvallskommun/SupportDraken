#!/usr/bin/env bash
set -e

SERVICE="webmessagecollector"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

FAMILY_ID="123"
ATTACHMENT_ID="attachmentId"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

# Get messages for familyId and instance (200 [])
run_test "GetMessages" GET "$BASE_URL/$MUNICIPALITY_ID/messages/$FAMILY_ID/internal" "[]"

# Delete all messages with ID in given list. (200)
run_test "DeleteMessages" DELETE "$BASE_URL/$MUNICIPALITY_ID/messages" "" '[1,2,3]'

# Fetch a specific attachment (200 binary)
run_test "GetAttachment" GET "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/$ATTACHMENT_ID"

# Delete a specific attachment (200)
run_test "DeleteAttachment" DELETE "$BASE_URL/$MUNICIPALITY_ID/messages/attachments/$ATTACHMENT_ID"

print_summary_and_exit
