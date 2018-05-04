#!/bin/sh

chown -R www-data /srv/web
chmod 777 /srv/web/__swift/files /srv/web/__swift/cache /srv/web/__swift/geoip /srv/web/__swift/logs /srv/web/__apps
chmod 755 /srv/web/console/index.php

if [[ $RELAY_HOST != '' ]]; then
    postconf -e relayhost=$RELAY_HOST
fi

if [[ $ALWAYS_BCC != '' ]]; then
    postconf -e always_bcc=$ALWAYS_BCC
fi

if [[ $HEADER_CHECKS != '' ]]; then
    postconf -e header_checks=$HEADER_CHECKS
fi

if [[ $MSG_SIZE_LIMIT != '' ]]; then
    postconf -e message_size_limit=$MSG_SIZE_LIMIT
fi

nginx && php-fpm
