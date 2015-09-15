#!/bin/sh
# Wait for database to get available

DB_LOOPS="30"

#wait for db
i=0
while ! psql -h $DB_HOST -p $DB_PORT -U postgres >/dev/null 2>&1 < /dev/null; do
  i=`expr $i + 1`
  if [ $i -ge $DB_LOOPS ]; then
    echo "$(date) - ${DB_HOST}:${DB_PORT} still not reachable, giving up"
    exit 1
  fi
  echo "$(date) - waiting for ${DB_HOST}:${DB_PORT}..."
  sleep 1
done

echo "connected with database!"
sleep 20
#continue with further steps

#start the daemon
exec $START_CMD