#!/bin/sh
set -ex

echo "Configuring XDebug"
/xdebug.sh

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

echo "Executing '$@'..."
/bin/sh -c "$@"
