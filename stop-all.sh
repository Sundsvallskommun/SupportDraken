#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE_NAME="docker-compose.yml"
PROJECT_NAME="${PROJECT_NAME:-supportdraken}"
export COMPOSE_PROJECT_NAME="$PROJECT_NAME"

# Default: do not remove volumes
REMOVE_VOLUMES=false

# Parse arguments
for arg in "$@"; do
  case "$arg" in
    -v|--volumes)
      REMOVE_VOLUMES=true
      ;;
    *)
      echo "Unknown argument: $arg"
      echo "Usage: ./down-all.sh [-v|--volumes]"
      exit 1
      ;;
  esac
done

down_in_dir() {
  local dir="$1"
  local file="$dir/$COMPOSE_FILE_NAME"

  if [[ -f "$file" ]]; then
    echo "Stopping services in $dir"
    if [[ "$REMOVE_VOLUMES" == true ]]; then
      ( cd "$dir" && docker compose -f "$COMPOSE_FILE_NAME" down -v )
    else
      ( cd "$dir" && docker compose -f "$COMPOSE_FILE_NAME" down )
    fi
  fi
}

ROOT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

echo "Using project name: $PROJECT_NAME"

echo "1) Shutting down all subdirectories (including seeder)"
shopt -s nullglob
for d in */ ; do
  d="${d%/}"
  [[ "$d" == .* ]] && continue
  down_in_dir "$d"
done
shopt -u nullglob

echo "2) Shutting down root compose"
down_in_dir "."

if [[ "$REMOVE_VOLUMES" == true ]]; then
  echo "All services stopped and volumes removed."
else
  echo "All services stopped (volumes preserved)."
fi
