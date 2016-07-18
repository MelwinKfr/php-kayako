FROM php:5.6-fpm-alpine

RUN apk add --no-cache libxml2-dev libmcrypt-dev libpng-dev freetype-dev curl-dev openldap-dev imap-dev libssl1.0 php5-opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-imap-ssl \
    && docker-php-ext-configure mysql --with-mysql=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install mbstring mcrypt curl gd mysql pdo pdo_mysql xml simplexml filter json imap sockets dom ldap opcache \
    && mkdir -p /srv/web/__swift/files /srv/web/__swift/cache /srv/web/__swift/geoip /srv/web/__swift/logs /srv/web/__apps /srv/web/console \
    && touch /srv/web/console/index.php \
    && chmod 777 /srv/web/__swift/files /srv/web/__swift/cache /srv/web/__swift/geoip /srv/web/__swift/logs /srv/web/__apps \
    && chmod 755 /srv/web/console/index.php

COPY php.ini /usr/local/etc/php/php.ini

VOLUME /srv/web

CMD /bin/sh -c "chown -R www-data /srv/web; php-fpm;"
