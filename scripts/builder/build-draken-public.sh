#!/usr/bin/env bash

set -xe

# Determine config directory based on execution context
if [ -d "/config" ]; then
  # Running inside Docker container
  CONFIG_DIR="/config"
else
  # Running locally
  CONFIG_DIR="$(dirname "$0")/../../config"
fi

# Clone or update the repository
if [ -d "web-app-draken-public" ]; then
  echo "Repository already exists, pulling latest changes..."
  cd web-app-draken-public
  cd ..
else
  git clone --depth 1 https://github.com/Sundsvallskommun/web-app-draken-public
fi

# Clone web-app-fake-sso-idp
if [ -d "web-app-fake-sso-idp" ]; then
  echo "Fake SSO IDP already exists, pulling latest changes..."
  cd web-app-fake-sso-idp
  cd ..
else
  git clone --depth 1 https://github.com/Sundsvallskommun/web-app-fake-sso-idp
fi

# Copy environment files for frontend
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" web-app-draken-public/frontend/.env.kc
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" web-app-draken-public/frontend/.env
cp "$CONFIG_DIR/frontend/.env-draken-public-frontend" web-app-draken-public/frontend/.env.production

# Copy environment files for backend
cp "$CONFIG_DIR/frontend/.env-draken-public-backend" web-app-draken-public/backend/.env.kc.development.local
cp "$CONFIG_DIR/frontend/.env-draken-public-backend" web-app-draken-public/backend/.env.kc.production.local

# Copy custom Dockerfiles
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-draken-public-frontend" "web-app-draken-public/frontend/Dockerfile"
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-draken-public-backend" "web-app-draken-public/backend/Dockerfile"

# Copy configuration for web-app-fake-sso-idp
cp "$CONFIG_DIR/frontend/.env-web-app-fake-sso-idp" web-app-fake-sso-idp/.env
cp "$CONFIG_DIR/frontend/web-app-fake-sso-idp.users.js" web-app-fake-sso-idp/users.js
# Copy certs for web-app-fake-sso-idp
mkdir -p web-app-fake-sso-idp/lib/certs
cp -r "$CONFIG_DIR/frontend/certs/." web-app-fake-sso-idp/lib/certs

# Build images
docker build -t web-app-draken-public-backend web-app-draken-public/backend
docker build -t web-app-draken-public-frontend web-app-draken-public/frontend
docker build -t web-app-fake-sso-idp web-app-fake-sso-idp
