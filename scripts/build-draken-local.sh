#!/usr/bin/env bash
#
# Build draken backend + frontend + fake-sso-idp images from LOCAL source code
# instead of cloning from GitHub. Uses the same config as SupportDraken's builder.
#
# Usage:  ./scripts/build-draken-local.sh [--backend-only]
#

set -xe

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config"
DRAKEN_DIR="${DRAKEN_DIR:-$HOME/Code/scit/web-app-draken-public}"
FAKE_SSO_DIR="${FAKE_SSO_DIR:-$HOME/Code/scit/web-app-fake-sso-idp}"

BACKEND_ONLY=false
if [ "$1" = "--backend-only" ]; then
  BACKEND_ONLY=true
fi

echo "=== Building from local source ==="
echo "Draken repo: $DRAKEN_DIR"
echo "Fake SSO repo: $FAKE_SSO_DIR"

# --- Backend ---
echo "--- Copying backend env config ---"
cp "$CONFIG_DIR/frontend/.env-draken-public-backend" "$DRAKEN_DIR/backend/.env.kc.development.local"
cp "$CONFIG_DIR/frontend/.env-draken-public-backend" "$DRAKEN_DIR/backend/.env.kc.production.local"
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-draken-public-backend" "$DRAKEN_DIR/backend/Dockerfile.supportdraken"

echo "--- Building web-app-draken-public-backend image ---"
docker build -t web-app-draken-public-backend -f "$DRAKEN_DIR/backend/Dockerfile.supportdraken" "$DRAKEN_DIR/backend"

if [ "$BACKEND_ONLY" = true ]; then
  echo "=== Backend-only build complete ==="
  exit 0
fi

# --- Frontend ---
echo "--- Copying frontend env config ---"
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" "$DRAKEN_DIR/frontend/.env.kc"
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" "$DRAKEN_DIR/frontend/.env"
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" "$DRAKEN_DIR/frontend/.env.production"
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-draken-public-frontend" "$DRAKEN_DIR/frontend/Dockerfile.supportdraken"

echo "--- Building web-app-draken-public-frontend image ---"
docker build -t web-app-draken-public-frontend -f "$DRAKEN_DIR/frontend/Dockerfile.supportdraken" "$DRAKEN_DIR/frontend"

# --- Fake SSO IDP ---
echo "--- Copying fake SSO config ---"
cp "$CONFIG_DIR/frontend/.env-web-app-fake-sso-idp" "$FAKE_SSO_DIR/.env"
cp "$CONFIG_DIR/frontend/web-app-fake-sso-idp.users.js" "$FAKE_SSO_DIR/users.js"
mkdir -p "$FAKE_SSO_DIR/lib/certs"
cp -r "$CONFIG_DIR/frontend/certs/." "$FAKE_SSO_DIR/lib/certs"

echo "--- Building web-app-fake-sso-idp image ---"
docker build -t web-app-fake-sso-idp "$FAKE_SSO_DIR"

echo "=== All images built from local source ==="
