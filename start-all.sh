#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE_NAME="docker-compose.yml"
PROJECT_NAME="${PROJECT_NAME:-supportdraken}"
export COMPOSE_PROJECT_NAME="$PROJECT_NAME"
export COMPOSE_IGNORE_ORPHANS=1   # suppress orphan warnings

DELAY_SECONDS="${DELAY_SECONDS:-60}"

up_in_dir() {
  local dir="$1"
  echo "-> $dir: up -d"
  ( cd "$dir" && docker compose -f "$COMPOSE_FILE_NAME" up -d --no-recreate )
}

# root first
up_in_dir "."

# then all subdirs except seeder
shopt -s nullglob
for d in */ ; do
  d="${d%/}"
  [[ "$d" == "seeder" ]] && continue
  [[ "$d" == .* ]] && continue
  up_in_dir "$d"
done
shopt -u nullglob

echo "Sleeping ${DELAY_SECONDS}s before seeder..."
sleep "$DELAY_SECONDS"

# seeder (foreground, then down)
( cd seeder && docker compose -f "$COMPOSE_FILE_NAME" up --abort-on-container-exit && docker compose -f "$COMPOSE_FILE_NAME" down -v )

echo "Done."
