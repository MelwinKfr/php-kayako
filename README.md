A PHP-FPM container for [Kayako](https://www.kayako.com/) built on top of [php:5.6-fpm-alpine](https://github.com/docker-library/php/blob/f016f5dc420e7d360f7381eb014ac6697e247e11/5.6/fpm/alpine/Dockerfile). All needed PHP extensions are included as well as a PHP cache accelerator (opcache).

This image is not designed to work in standalone mode. ([Dockerfile](https://github.com/MelwinKfr/php-kayako/blob/master/Dockerfile))

# Usage

Create a Dockerfile to `COPY` your own Kayako's files into `/srv/web` or use a `--volume`.

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

# Documentation

For more explanations please refer to [Kayako](https://kayako.atlassian.net/wiki/display/DOCS/Server+requirements) and [PHP](https://hub.docker.com/_/php/) documentation.
