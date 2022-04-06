#!/usr/bin/env bash
set -eou pipefail

if ! [[ "${XDEBUG_ENABLE:-}" -eq "1" ]]; then
    echo "Disabling xdebug";
    rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini || true
    pecl uninstall xdebug
fi
