#!/usr/bin/env bash
set -euo pipefail

dockerd-entrypoint.sh --log-level=error &

until docker info >/dev/null 2>&1; do
  echo "waiting for docker daemon"
  sleep 1
done
echo "Docker daemon ready"

# List of all GHCR images
declare -a ghcr_images=(
  ghcr.io/sundsvallskommun/api-service-case-data:latest
  ghcr.io/sundsvallskommun/api-service-case-status:latest
  ghcr.io/sundsvallskommun/api-service-eventlog:latest
  ghcr.io/sundsvallskommun/api-service-message-exchange:latest
  ghcr.io/sundsvallskommun/api-service-messaging:latest
  ghcr.io/sundsvallskommun/api-service-messaging-settings:latest
  ghcr.io/sundsvallskommun/api-service-notes:latest
  ghcr.io/sundsvallskommun/api-service-party:latest
  ghcr.io/sundsvallskommun/api-service-relations:latest
  ghcr.io/sundsvallskommun/api-service-support-management:latest
  ghcr.io/sundsvallskommun/api-service-templating:latest
)

# List of all images that are built locally, basically the frontend images. 
declare -a react_images=(
  web-app-draken-public-backend:latest
  web-app-draken-public-frontend:latest
  web-app-fake-sso-idp:latest
  web-app-support-management-admin-backend:latest
  web-app-support-management-admin-frontend:latest
)

force_build="${1:-}"

for image in "${ghcr_images[@]}"; do
  if ! docker image inspect "$image" &>/dev/null; then
    echo "⏬ pulling $image from GHCR"
    docker pull "$image" || echo "could not pull $image"
  fi
done

need_build=false
for image in "${react_images[@]}"; do
  if ! docker image inspect "$image" &>/dev/null; then
    need_build=true
  fi
done

if [ "$force_build" = "-f" ]; then
  need_build=true
fi

if [ "$need_build" = true ]; then
  echo "Building web-app-draken-public images via builder"
  docker compose --profile build build builder
  docker compose --profile build run --rm builder
else
  echo "All web-app-draken-public images found locally"
fi

echo "Starting services"
docker compose up
