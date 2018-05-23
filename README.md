# Deprecated
In advantage to [dalim-it/docker-images -> kayako](https://github.com/dalim-it/docker-images/tree/master/kayako)

A PHP-FPM container for [Kayako](https://www.kayako.com/) built on top of [php:5.6-fpm-alpine](https://github.com/docker-library/php/blob/f016f5dc420e7d360f7381eb014ac6697e247e11/5.6/fpm/alpine/Dockerfile). All needed PHP extensions are included as well as a PHP cache accelerator (opcache).

This image is not designed to work in standalone mode.

##### Tags

Tagname | Description | Dockerfile
------- | ----------- | ----------
latest  | All needed PHP extensions with a PHP cache accelerator (opcache). | [master](https://github.com/MelwinKfr/php-kayako/blob/master/Dockerfile)
postfix | Everything in latest plus a customisable postfix server. | [postfix](https://github.com/MelwinKfr/php-kayako/blob/postfix/Dockerfile)

# Usage

Create a Dockerfile to `COPY` your own Kayako's files into `/srv/web` or simply use a `--volume`.

Recommended configuration:
```yaml
    php:
        build:
            context: .
            dockerfile: Dockerfile-php
        external_links:
            - mysql:mysql
        volumes:
            - /path_to_logs:/srv/web/__swift/logs
            - /path_to_files:/srv/web/__swift/files
            - /path_to_geoip:/srv/web/__swift/geoip
        restart: always
        network_mode: "default"
    nginx:
        build:
            context: .
            dockerfile: Dockerfile-nginx
        links:
            - php:php
        volumes_from:
            - php
        restart: always
        network_mode: "default"
```

## PHP Configuration

If you want to customise your PHP configuration, you just have to `COPY` your `.ini` file into `/usr/local/etc/php/conf.d/`. It will override the default configuration.

## Postfix configuration

There is few environment variables to configure the postfix server, feel free to ask me for more settings or make a pull request.

Variable name | Documentation
------------- | -------------
RELAY_HOST    | [relayhost](http://www.postfix.org/postconf.5.html#relayhost)
ALWAYS_BCC    | [always_bcc](http://www.postfix.org/postconf.5.html#always_bcc)
HEADER_CHECKS | [header_checks](http://www.postfix.org/postconf.5.html#header_checks)

# Documentation

For more explanations please refer to [Kayako](https://kayako.atlassian.net/wiki/display/DOCS/Server+requirements) and [PHP](https://hub.docker.com/_/php/) documentation.
