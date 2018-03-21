#!/bin/bash

export PGPASSWORD="postgres"

# Check if postgresql db is connected
i=0
while ! psql -h db -U postgres postgres >/dev/null 2>&1 < /dev/null; do
    i=$(($i+1))
    if [ $i -ge 50 ]; then
        echo "$(date) - postgres:5432 still not reachable, giving up"
        exit 1
    fi
    echo "$(date) - waiting for postgres:5432..."
    sleep 1
done
echo "postgres connection established"

# Init postgresql db with table schema
psql -h db -U postgres postgres < ./relational_db/schema_table1.sql

# Start express server
node app