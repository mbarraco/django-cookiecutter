#!/bin/sh
# vim:sw=4:ts=4:et
set -e

# Always wait for PostgreSQL to be ready
echo "Waiting for postgres"
wait-for-it -s "$POSTGRES_HOST:$POSTGRES_PORT" -t 120
exec "$@"
