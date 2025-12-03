#!/usr/bin/env bash
# Run all WireMock test suites and summarize results
# Portable to macOS default Bash 3.2 (no mapfile, process substitution, or bashisms beyond arrays)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FAIL_FAST=false
FILTERS=()

# Parse args
for arg in "$@"; do
  case "$arg" in
    --fail-fast)
      FAIL_FAST=true
      ;;
    --help|-h)
      echo "Usage: $0 [--fail-fast] [suiteName ...]"
      echo "  Run all suites in $SCRIPT_DIR/*/tests.sh and $SCRIPT_DIR/common/test.sh"
      echo "  Provide names (directory names like 'legalentity') to filter which suites to run."
      exit 0
      ;;
    *)
      FILTERS+=("$arg")
      ;;
  esac
done

# Discover suites
FOUND=()
for f in "$SCRIPT_DIR"/*/tests.sh; do
  if [ -f "$f" ]; then
    FOUND+=("$f")
  fi
done
# Include common
if [ -f "$SCRIPT_DIR/common/test.sh" ]; then
  FOUND+=("$SCRIPT_DIR/common/test.sh")
fi

# Filter by names if provided
SUITES=()
if [ ${#FILTERS[@]} -gt 0 ]; then
  for suite in "${FOUND[@]}"; do
    name="$(basename "$(dirname "$suite")")"
    # common suite special-case: name becomes 'common'
    if [ "$name" = "tests" ]; then
      name="common"
    fi
    for flt in "${FILTERS[@]}"; do
      if [ "$name" = "$flt" ]; then
        SUITES+=("$suite")
        break
      fi
    done
  done
else
  SUITES=("${FOUND[@]}")
fi

if [ ${#SUITES[@]} -eq 0 ]; then
  echo "No test suites matched."
  exit 1
fi

# Run suites
TOTAL=${#SUITES[@]}
PASSED=0
FAILED=0

# Build names list for header
NAMES=()
for s in "${SUITES[@]}"; do
  n="$(basename "$(dirname "$s")")"
  if [ "$n" = "tests" ]; then
    n="common"
  fi
  NAMES+=("$n")
done

echo "Running $TOTAL suite(s): ${NAMES[*]}"

idx=1
for suite in "${SUITES[@]}"; do
  name="$(basename "$(dirname "$suite")")"
  if [ "$name" = "tests" ]; then
    name="common"
  fi
  echo
  echo "[$idx/$TOTAL] $name"
  if bash "$suite"; then
    echo "$name ✓"
    PASSED=$((PASSED+1))
  else
    code=$?
    echo "$name ✗ (exit $code)"
    FAILED=$((FAILED+1))
    if [ "$FAIL_FAST" = true ]; then
      echo
      echo "Suites summary: $TOTAL total, $PASSED passed, $FAILED failed"
      exit 1
    fi
  fi
  idx=$((idx+1))
done

echo
echo "Suites summary: $TOTAL total, $PASSED passed, $FAILED failed"
if [ $FAILED -gt 0 ]; then
  exit 1
fi
