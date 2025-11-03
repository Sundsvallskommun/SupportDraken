#!/usr/bin/env bash
set -e

SERVICE="estateinfo"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

ADDRESS1="Testgatan1"
ADDRESS2="Testgatan2"
ADDRESS3="Testgatan3"
DESIGNATION1="Test1"
DESIGNATION2="Test2"
DESIGNATION3="Test3"
OBJECT_IDENTIFIER1="2f3c098e-fa60-4beb-82e1-680e332b62a1"
OBJECT_IDENTIFIER2="2f3c098e-fa60-4beb-82e1-680e332b62a2"
OBJECT_IDENTIFIER3="2f3c098e-fa60-4beb-82e1-680e332b62a3"

# Shared helpers
source "$(dirname "$0")/../_helpers.sh"
init_report

run_test "GetEstateInfoByAddress1" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-address?address=$ADDRESS1" "[
  {
    "address": "Testgatan 1, Sundsvall",
    "designation": "TEST 1",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a1"
  }
]"

run_test "GetEstateInfoByAddress2" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-address?address=$ADDRESS2" "[
  {
    "address": "Testgatan 2, Sundsvall",
    "designation": "TEST 2",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a2"
  }
]"

run_test "GetEstateInfoByAddress3" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-address?address=$ADDRESS3" "[
  {
    "address": "Testgatan 3, Sundsvall",
    "designation": "TEST 3",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a3"
  }
]"

run_test "GetEstateInfoByFaultyAddress" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-address?address=invalid-address" ""


run_test "GetEstateInfoByDesignation1" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-designation?designation=$DESIGNATION1" "{
    "designation": "Test 1",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a1"
}"


run_test "GetEstateInfoByDesignation2" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-designation?designation=$DESIGNATION2" "{
    "designation": "Test 2",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a2"
}"


run_test "GetEstateInfoByDesignation3" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-designation?designation=$DESIGNATION3" "{
    "designation": "Test 3",
    "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a3"
}"

run_test "GetEstateInfoByFaultyDesignation" GET "$BASE_URL/$MUNICIPALITY_ID/estate-by-designation?designation=invalid-designation" ""

run_test "GetEstate1" GET "$BASE_URL/$MUNICIPALITY_ID/estate-data?objectidentifier=$OBJECT_IDENTIFIER1" "{
  "designation": "Test 1",
  "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a1",
  "totalArea": 1337,
  "totalAreaWater": 0,
  "totalAreaLand": 1337,
  "ownerChanges": [
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "enrollmentDay": "1922-03-06",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "1905-11-18",
          "acquisitionType": "Köp",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": []
    },
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "enrollmentDay": "2012-08-13",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "2012-08-02",
          "acquisitionType": "Fusion",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "share": "1/1",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ]
    },
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "1987-11-04",
          "acquisitionType": "Upplåtelse av tomträtt",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": []
    }
  ],
  "ownership": [
    {
      "type": "Lagfart",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "1922-03-06",
      "decision": "Beviljad",
      "share": "1/1",
      "diaryNumber": [
        "22/23"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "000000-0000",
        "name": "TEST AB",
        "coAddress": "",
        "address": "",
        "postalCode": "00000",
        "city": "SUNDSVALL"
      }
    },
    {
      "type": "Tomträttsinnehav",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "2012-08-13",
      "decision": "Beviljad",
      "share": "1/1",
      "diaryNumber": [
        "12/13723"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "000000-0000",
        "name": "TEST AB",
        "coAddress": "",
        "address": "Testgatan 1",
        "postalCode": "00000",
        "city": "SUNDSVALL"
      }
    }
  ],
  "mortage": [],
  "previousOwnership": [
    {
      "type": "Tomträttsinnehav",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "",
      "decision": "Beviljad",
      "share": "0/1",
      "diaryNumber": [
        "07/24222"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "00000-00000",
        "name": "TEST AB"
      }
    }
  ],
  "actions": [
    {
      "actionType1": "fastighetsreglering",
      "actionType2": "",
      "fileDesignation": "00000-00000",
      "actionDate": "19950317",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "littera": "",
      "runningNumber": 2
    },
    {
      "actionType1": "avstyckning",
      "actionType2": "fastighetsreglering",
      "fileDesignation": "00000-00000",
      "actionDate": "19870327",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "littera": "",
      "runningNumber": 1
    }
  ]
}"

run_test "GetEstate2" GET "$BASE_URL/$MUNICIPALITY_ID/estate-data?objectidentifier=$OBJECT_IDENTIFIER2" "{
  "designation": "Test 2",
  "objectidentifier": "2f3c098e-fa60-4beb-82e1-680e332b62a2",
  "totalArea": 1337,
  "totalAreaWater": 0,
  "totalAreaLand": 1337,
  "ownerChanges": [
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "enrollmentDay": "1922-03-06",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "1905-11-18",
          "acquisitionType": "Köp",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": []
    },
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "enrollmentDay": "2012-08-13",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "2012-08-02",
          "acquisitionType": "Fusion",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "share": "1/1",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ]
    },
    {
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "acquisition": [
        {
          "objectidentifier": "00000000-0000-0000-0000-000000000000",
          "fileNumber": "",
          "decision": "Beviljad",
          "share": "1/1",
          "acquisitionDay": "1987-11-04",
          "acquisitionType": "Upplåtelse av tomträtt",
          "registeredOwnership": "00000000-0000-0000-0000-000000000000"
        }
      ],
      "purchasePrice": {},
      "transfer": []
    }
  ],
  "ownership": [
    {
      "type": "Lagfart",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "1922-03-06",
      "decision": "Beviljad",
      "share": "1/1",
      "diaryNumber": [
        "22/23"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "000000-0000",
        "name": "TEST AB",
        "coAddress": "",
        "address": "",
        "postalCode": "00000",
        "city": "SUNDSVALL"
      }
    },
    {
      "type": "Tomträttsinnehav",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "2012-08-13",
      "decision": "Beviljad",
      "share": "1/1",
      "diaryNumber": [
        "12/13723"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "000000-0000",
        "name": "TEST AB",
        "coAddress": "",
        "address": "Testgatan 1",
        "postalCode": "00000",
        "city": "SUNDSVALL"
      }
    }
  ],
  "mortage": [],
  "previousOwnership": [
    {
      "type": "Tomträttsinnehav",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "enrollmentDay": "",
      "decision": "Beviljad",
      "share": "0/1",
      "diaryNumber": [
        "07/24222"
      ],
      "versionValidFrom": "2013-05-22T22:57:35.065+02:00",
      "owner": {
        "idnumber": "00000-00000",
        "name": "TEST AB"
      }
    }
  ],
  "actions": [
    {
      "actionType1": "fastighetsreglering",
      "actionType2": "",
      "fileDesignation": "00000-00000",
      "actionDate": "19950317",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "littera": "",
      "runningNumber": 2
    },
    {
      "actionType1": "avstyckning",
      "actionType2": "fastighetsreglering",
      "fileDesignation": "00000-00000",
      "actionDate": "19870327",
      "objectidentifier": "00000000-0000-0000-0000-000000000000",
      "littera": "",
      "runningNumber": 1
    }
  ]
}"

run_test "GetEstate3" GET "$BASE_URL/$MUNICIPALITY_ID/estate-data?objectidentifier=$OBJECT_IDENTIFIER3" ""

run_test "GetEstateFaultyObjectIdentifier" GET "$BASE_URL/$MUNICIPALITY_ID/estate-data?objectidentifier=invalid-object-identifier" ""

print_summary_and_exit
