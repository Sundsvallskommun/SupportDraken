# WireMock mocks & API test suites

This folder contains WireMock mappings and lightweight Bash test suites that automatically validate the mock endpoints.

- Mappings: `wiremock/mappings/**`
- Response bodies: `wiremock/responses/**`
- Test suites: `wiremock/tests/*/tests.sh`
- Shared helpers: `wiremock/tests/_helpers.sh`
- Aggregator: `wiremock/tests/run_all.sh`

## Prerequisites

- Docker (for WireMock)
- Bash (on macOS invoke with `bash` explicitly)

## Start WireMock

```bash
# From repo root
docker compose -f wiremock/compose.yml up -d
```

## Run the tests

- Run all suites with summary and proper exit code:

```bash
bash wiremock/tests/run_all.sh
```

- Run a subset by name (directory name or `common`):

```bash
bash wiremock/tests/run_all.sh legalentity emailreader
```

- Stop on first failing suite:

```bash
bash wiremock/tests/run_all.sh --fail-fast
```

- Run a single suite directly:

```bash
bash wiremock/tests/legalentity/tests.sh
```

### Output format

Each individual test prints a compact pass/fail line:

```
GetLegalentityById ✓
GetPersonEngagements ✓
...

Summary: 5 total, 5 passed, 0 failed
```

The aggregator prints per‑suite status and a final summary, exiting non‑zero if any suite failed.

## Adding a new WireMock test suite

1. Create a folder and script: `wiremock/tests/<servicename>/tests.sh`
2. Use this template and adjust URLs/expectations:

```bash
#!/usr/bin/env bash
set -e

SERVICE="<service>"      # e.g. "api/v2/legalentity" or "emailreader"
BASE_URL="http://localhost:9000/$SERVICE"
MUNICIPALITY_ID="2281"

source "$(dirname "$0")/../_helpers.sh"
init_report

# Examples:
run_test   "ListThings" GET  "$BASE_URL/$MUNICIPALITY_ID/things" "[]"
run_status "GetThing404" GET  "$BASE_URL/$MUNICIPALITY_ID/things/does-not-exist" 404 "not found"
run_test   "CreateThing" POST "$BASE_URL/$MUNICIPALITY_ID/things" "" '{"name":"X"}'

print_summary_and_exit
```

3. Add any needed mappings under `wiremock/mappings/<servicename>` and responses under
   `wiremock/responses/<servicename>`.
4. Run `bash wiremock/tests/run_all.sh` to include it automatically.

## Helper API (`_helpers.sh`)

- `run_test name METHOD URL [expected-substring] [data]` asserts HTTP 200 and optionally that the body contains a fixed
  substring. Use this for success cases.
- `run_status name METHOD URL expected-status [expected-substring] [data]` asserts a specific status code and optional
  substring. Use this for non‑200 cases (e.g., 404).
- Pretty output with green `✓` and red `✗` plus an aggregated summary and non‑zero exit on failures.

Notes:

- Substring checks are literal (fixed-string `grep -F`), so `[]` is safe to match.
- When sending JSON request bodies and you don’t need a substring match, pass an empty string argument for the expected
  substring (e.g., `""`) before the body.
- The aggregator is compatible with macOS default Bash 3.2.
