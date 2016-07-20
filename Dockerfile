FROM php:5.6-fpm-alpine

COPY postfix.sh /home/www-data/postfix.sh

RUN apk add --no-cache libxml2-dev libmcrypt-dev libpng-dev freetype-dev curl-dev openldap-dev imap-dev libssl1.0 php5-opcache php5-mysqli php5-pdo_mysql postfix \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    && docker-php-ext-configure imap --with-imap-ssl \
    && docker-php-ext-configure mysql --with-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-install mbstring mcrypt curl gd mysql mysqli pdo pdo_mysql xml simplexml filter json imap sockets dom ldap opcache \
    && chmod +x /home/www-data/postfix.sh

COPY php.ini /usr/local/etc/php/php.ini

VOLUME /srv/web

CMD /bin/sh -c "chown -R www-data /srv/web; \
                chmod 777 /srv/web/__swift/files /srv/web/__swift/cache /srv/web/__swift/geoip /srv/web/__swift/logs /srv/web/__apps; \
                chmod 755 /srv/web/console/index.php; \
                /home/www-data/postfix.sh; \
                postfix start; \
                php-fpm;"
