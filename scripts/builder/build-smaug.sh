#!/usr/bin/env bash

set -xe

# Determine config directory
if [ -d "/config" ]; then
  CONFIG_DIR="/config"
else
  CONFIG_DIR="$(dirname "$0")/../../config"
fi

# Clone repo
if [ -d "web-app-support-management-admin" ]; then
  echo "Repository already exists, pulling latest changes..."
  cd web-app-support-management-admin
  git pull origin main
  cd ..
else
  git clone https://github.com/Sundsvallskommun/web-app-support-management-admin.git
fi

echo "=== DEBUG: list locales in cloned repo before build ==="
ls -la web-app-support-management-admin/frontend/public/locales || true
ls -la web-app-support-management-admin/frontend/public/locales/en || true
ls -la web-app-support-management-admin/frontend/public/locales/sv || true

# Copy env files
cp "$CONFIG_DIR/frontend/.env-support-management-admin-frontend" web-app-support-management-admin/frontend/.env
# The backend app loads env from `.env.<NODE_ENV>.local` (see README). Copy the
# provided env into the expected filenames so dotenv picks up variables like LOG_DIR
# when the container runs with NODE_ENV=production.
cp "$CONFIG_DIR/frontend/.env-support-management-admin-backend" web-app-support-management-admin/backend/.env
cp "$CONFIG_DIR/frontend/.env-support-management-admin-backend" web-app-support-management-admin/backend/.env.production.local
cp "$CONFIG_DIR/frontend/.env-support-management-admin-backend" web-app-support-management-admin/backend/.env.test.local

# Copy Dockerfile templates
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-support-management-admin-frontend" "web-app-support-management-admin/frontend/Dockerfile"
cp -f "$CONFIG_DIR/dockerfiles/Dockerfile-support-management-admin-backend" "web-app-support-management-admin/backend/Dockerfile"

# Build images
docker build -t web-app-support-management-admin-backend web-app-support-management-admin/backend
docker build -t web-app-support-management-admin-frontend web-app-support-management-admin/frontend
