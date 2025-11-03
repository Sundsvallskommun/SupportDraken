#!/usr/bin/env bash

set -xe

git clone --depth 1 https://github.com/Sundsvallskommun/web-app-draken-public

cp /config/.env-draken-public-frontend web-app-draken-public/frontend/.env.kc
cp /config/.env-draken-public-frontend web-app-draken-public/frontend/.env
cp /config/.env-draken-public-frontend web-app-draken-public/frontend/.env.production

cp /config/.env-draken-public-backend web-app-draken-public/backend/.env.kc.development.local
cp /config/.env-draken-public-backend web-app-draken-public/backend/.env.kc.production.local

cp -f "/config/Dockerfile-draken-public-frontend" "web-app-draken-public/frontend/Dockerfile"
cp -f "/config/Dockerfile-draken-public-backend"  "web-app-draken-public/backend/Dockerfile"

docker build -t web-app-draken-public-backend web-app-draken-public/backend
docker build -t web-app-draken-public-frontend web-app-draken-public/frontend