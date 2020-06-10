#!/bin/bash
set -e

if [ -n "$(ls -A /data 2>/dev/null)" ]
then
    echo "Data directory contains files, not downloading NamelessMC"
else
    echo "Data directory is empty, downloading NamelessMC.."
    set -x
    mkdir -p /data
    cd /tmp
    curl -Lo nameless.tar.gz https://github.com/NamelessMC/Nameless/archive/v$NAMELESSMC_VERSION.tar.gz
    tar -xf nameless.tar.gz
    mv Nameless-$NAMELESSMC_VERSION/{,.[^.]}* /data
    chown -R www-data:www-data /data
    chmod 755 -R /data
    rm -rf /tmp
    set +x
    echo "Done!"
fi

exec php-fpm