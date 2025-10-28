#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE_NAME="docker-compose.yml"
PROJECT_NAME="${PROJECT_NAME:-supportdraken}"
export COMPOSE_PROJECT_NAME="$PROJECT_NAME"
export COMPOSE_IGNORE_ORPHANS=1   

DELAY_SECONDS="${DELAY_SECONDS:-300}"

up_in_dir() {
  local dir="$1"
  echo "-> $dir: up -d"

  builtin pushd "$dir" >/dev/null

  docker compose -f "$COMPOSE_FILE_NAME" up -d --no-recreate

  builtin popd >/dev/null
}

up_in_dir "."

shopt -s nullglob
for d in */ ; do
  d="${d%/}"
  [[ "$d" == "seeder" ]] && continue
  [[ "$d" == .* ]] && continue
  up_in_dir "$d"
done
shopt -u nullglob

echo "Sleeping ${DELAY_SECONDS}s before seeder."
sleep "$DELAY_SECONDS"

if [[ -d "seeder" ]]; then
  builtin pushd "seeder" >/dev/null

  if docker compose -f "$COMPOSE_FILE_NAME" up --abort-on-container-exit; then
    docker compose -f "$COMPOSE_FILE_NAME" down -v
  fi

  builtin popd >/dev/null
else
  echo "No seeder found"
fi

echo "Done."
