#!/usr/bin/env bash
set -euo pipefail

# Entry point used by builder image; delegate to the build script
bash /work/scripts/builder/build-draken-public.sh
