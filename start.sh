#!/bin/sh

set -e

echo "run db migration"
. /app/app.env
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app"
# $@ means execute all passed parameters
# in this case it would be /app/start.sh
exec "$@"