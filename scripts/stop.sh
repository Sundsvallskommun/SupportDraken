#!/usr/bin/env bash
set -euo pipefail

bin=""
cleanup_volumes=false
container_name="runner"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --docker) bin="docker" ;;
    --podman) bin="podman" ;;
    -v|--volumes) cleanup_volumes=true ;;
    *) ;; 
  esac
  shift
done

# Auto-detect container engine if not provided
if [[ -z "${bin}" ]]; then
  if command -v podman >/dev/null 2>&1; then
    bin="podman"
  elif command -v docker >/dev/null 2>&1; then
    bin="docker"
  else
    echo "error: neither docker nor podman found in PATH" >&2
    exit 1
  fi
fi

# MSYS fixes for Git Bash on Windows
if [[ -n "${MSYSTEM:-}" ]]; then
  export MSYS=enable_pcon
  export MSYS_NO_PATHCONV=1
fi

echo "Using container engine: $bin"
echo "Target container: $container_name"

# Helper: does container exist?
container_exists() {
  "$bin" ps -a --format '{{.Names}}' | grep -Fxq "$container_name"
}

# Helper: is container running?
container_running() {
  "$bin" inspect -f '{{.State.Running}}' "$container_name" >/dev/null 2>&1 && \
  [[ "$("$bin" inspect -f '{{.State.Running}}' "$container_name" 2>/dev/null)" == "true" ]]
}

# Stop and remove container
if container_exists; then
  if container_running; then
    echo "Stopping $container_name ..."
    "$bin" stop -t 10 "$container_name" || true
  else
    echo "$container_name is not running."
  fi

  echo "Removing $container_name ..."
  "$bin" rm -f "$container_name" >/dev/null 2>&1 || true
  echo "Done."
else
  echo "No container named '$container_name' found. Nothing to do."
fi

# Optionally remove volumes
if [[ "$cleanup_volumes" == true ]]; then
  echo "Removing volumes: docker-cache, maven-cache, mariadb-data ..."
  for vol in docker-cache maven-cache mariadb-data; do
    "$bin" volume rm -f "$vol" >/dev/null 2>&1 || true
  done
  echo "Volume cleanup complete."
fi
