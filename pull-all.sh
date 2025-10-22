#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE_NAME="docker-compose.yml"

pull_in_dir() {
  local dir="$1"
  local file="$dir/$COMPOSE_FILE_NAME"

  if [[ -f "$file" ]]; then
    ( cd "$dir" && docker compose -f "$COMPOSE_FILE_NAME" pull )
  fi
}

ROOT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

pull_in_dir "."

shopt -s nullglob
for d in */ ; do
  d="${d%/}"
  [[ "$d" == .* ]] && continue
  pull_in_dir "$d"
done
shopt -u nullglob

echo "Done - All images pulled"
