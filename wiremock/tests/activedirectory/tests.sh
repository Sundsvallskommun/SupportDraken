#!/usr/bin/env bash
set -e

SERVICE="activedirectory"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

### Expect 2 groups.
run_test "SearchGroups" GET "$BASE_URL/$MUNICIPALITY_ID/search/personal" "[
    {
        "name": "group1",
        "displayName": "Grupp 1",
        "schemaClassName": "group",
        "guid": "8c4ca7f6-97d0-4213-bfed-884176737d35",
        "ouPath": "",
        "description": "",
        "domain": "personal",
        "isLinked": false,
        "personId": null
    },
    {
        "name": "group2",
        "displayName": "Grupp 2",
        "schemaClassName": "group",
        "guid": "8c4ca7f6-97d0-4213-bfed-884176737d34",
        "ouPath": "",
        "description": "",
        "domain": "personal",
        "isLinked": false,
        "personId": null
    }
]"

### Expect 2 users in group
run_test "GetGroup1Members" GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/group1" "[
    {
    "name": "joe12doe",
    "displayName": "John Doe",
    "schemaClassName": "user",
    "guid": "e4b4d711-fd75-4eb5-a048-8ae2ec4f2dd4",
    "ouPath": "CN=joe12doe,OU=ABC1,OU=ABC2,OU=ABC3,DC=personal,DC=sundsvall,DC=se",
    "description": "Verksamhetsutvecklare",
    "domain": "personal",
    "isLinked": false,
    "personId": "7709e3d7-eee7-45d7-9cef-511381e8435h"
  },
  {
    "name": "jan12doe",
    "displayName": "Jane Doe",
    "schemaClassName": "user",
    "guid": "e4b4d711-fd75-4eb5-a048-8ae2ec4f2dd5",
    "ouPath": "CN=jan12doe,OU=ABC1,OU=ABC2,OU=ABC3,DC=personal,DC=sundsvall,DC=se",
    "description": "Kundtjänstmedarbetare",
    "domain": "personal",
    "isLinked": false,
    "personId": "7709e3d7-eee7-45d7-9cef-511381e8435f" 
  } 
]"

### Expect 1 user in group
run_test "GetGroup2Members" GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/group2" "[
    {
        "name": "joe12doe",
        "displayName": "John Doe",
        "schemaClassName": "user",
        "guid": "e4b4d711-fd75-4eb5-a048-8ae2ec4f2dd4",
        "ouPath": "CN=joe12doe,OU=ABC1,OU=ABC2,OU=ABC3,DC=personal,DC=sundsvall,DC=se",
        "description": "Verksamhetsutvecklare",
        "domain": "personal",
        "isLinked": false,
        "personId": "7709e3d7-eee7-45d7-9cef-511381e8435h"
    }
]"

### Expect empty array
run_test "GetInvalidGroupMembers" GET "$BASE_URL/$MUNICIPALITY_ID/groupmembers/personal/invalid-group" "[]"

### Expect 2 groups
run_test "GetUser1Groups" GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/joe01doe" "[
    {
        "name": "Group 1",
        "displayName": "Grupp 1",
        "schemaClassName": "group",
        "guid": "8c4ca7f6-97d0-4213-bfed-884176737d35",
        "ouPath": "",
        "description": "",
        "domain": "personal",
        "isLinked": false,
        "personId": null
    },
    {
        "name": "Group 2",
        "displayName": "Grupp 2",
        "schemaClassName": "group",
        "guid": "8c4ca7f6-97d0-4213-bfed-884176737d34",
        "ouPath": "",
        "description": "",
        "domain": "personal",
        "isLinked": false,
        "personId": null
    }
]"

### Expect 1 group
run_test "GetUser2Groups"  GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/jan01doe" "[
    {
        "name": "Group 1",
        "displayName": "Grupp 1",
        "schemaClassName": "group",
        "guid": "8c4ca7f6-97d0-4213-bfed-884176737d35",
        "ouPath": "",
        "description": "",
        "domain": "personal",
        "isLinked": false,
        "personId": null
    }
]"

## Expect empty array
run_test "GetInvalidUserGroups"  GET    "$BASE_URL/$MUNICIPALITY_ID/usergroups/personal/invalid-user" "[]"

print_summary_and_exit
