#!/bin/bash

set -e

: ${INFLUXDB_HOST:?"INFLUXDB_HOST env variable is required"}
: ${BACKUP_DEST:?"BACKUP_DEST env variable is required"}
: ${DATABASES:?"DATABASES env variable is required"}

echo ">> $(date) starting backup in [$BACKUP_DEST] from host [$INFLUXDB_HOST] for db [$DATABASES]"

influxd backup -host $INFLUXDB_HOST:8088 $BACKUP_DEST

# Replace colons with spaces to create list.
for db in ${DATABASES//:/ }; do
  echo "Creating backup for $db"
  influxd backup -database $db -host $INFLUXDB_HOST:8088 $BACKUP_DEST
done

echo ">> $(date) backup done"
