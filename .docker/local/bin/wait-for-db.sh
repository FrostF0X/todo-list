#!/usr/bin/env bash

set -eou pipefail

echo "Waiting for mysql"
while ! mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" --silent; do
    echo "Waiting for mysql..."
    sleep 1
done
