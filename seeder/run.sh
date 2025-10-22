#!/bin/sh
set -eu

echo "Waiting for server..."
until mariadb-admin ping -h"$MARIADB_HOST" -uroot -p"$MARIADB_ROOT_PASSWORD" --silent; do
  sleep 1
done

if ! ls /seed/*.sql >/dev/null 2>&1; then
  echo "No .sql files found in /seed. Nothing to do."
  exit 0
fi

for f in /seed/*.sql; do
  echo ">> Running $f"
  mariadb -h"$MARIADB_HOST" -uroot -p"$MARIADB_ROOT_PASSWORD" < "$f"
done

echo "All seed files executed."
