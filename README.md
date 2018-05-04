A standalone container to run [Kayako](https://www.kayako.com/) built on top of alpine Linux.

This image contains:
- Nginx web server
- Needed PHP extensions to run Kayako
- PHP cache accelerator (opcache) and a customizable postfix server.
- Postfix server for  mailing needs

# Usage

Create a Dockerfile to `COPY` your own Kayako's files into `/srv/web`.

Here is my usual working stack:
```yaml
version: '3'
services:
    kayako:
        build:
            context: .
            dockerfile: Dockerfile
        links:
            - mysql:mysql
        volumes:
            - /path_to_logs:/srv/web/__swift/logs
            - /path_to_files:/srv/web/__swift/files
            - /path_to_geoip:/srv/web/__swift/geoip
        environment:
            KAYAKO_DB_HOSTNAME: mysql
            KAYAKO_DB_USERNAME: kayako_user
            KAYAKO_DB_PASSWORD: kayako_pwd
            KAYAKO_DB_NAME: kayako
    mysql:
        image: mysql:5.7
        volumes:
            - /path_to_db_data:/var/lib/mysql
```
## Kayako Configuration
It is done via environment variable

Variable name      | Description
------------------ | -------------
KAYAKO_BASENAME    | Base path name (defaults to `index.php?`)
KAYAKO_DB_HOSTNAME | Database hostname
KAYAKO_DB_USERNAME | Database username
KAYAKO_DB_PASSWORD | Database password
KAYAKO_DB_NAME     | Database schema name
KAYAKO_DB_PORT     | Database port (defaults to `3306`)

## PHP Configuration

If you want to customise your PHP configuration, you want to `COPY` your `.ini` file into `/usr/local/etc/php/conf.d/`.
It will override the default configuration.

## Postfix configuration

There is few environment variables to configure the postfix server, feel free to ask for more settings.

Variable name  | Description
-------------- | -------------
POSTFIX_ENABLE | Set to `false` if you don't want to start postfix server
RELAY_HOST     | [relayhost](http://www.postfix.org/postconf.5.html#relayhost)
ALWAYS_BCC     | [always_bcc](http://www.postfix.org/postconf.5.html#always_bcc)
HEADER_CHECKS  | [header_checks](http://www.postfix.org/postconf.5.html#header_checks)
MSG_SIZE_LIMIT | [message_size_limit](http://www.postfix.org/postconf.5.html#message_size_limit)

# Documentation

For more explanations please refer to [Kayako](https://kayako.atlassian.net/wiki/display/DOCS/Server+requirements),
[nginx](https://nginx.org/en/docs/) or [PHP](https://hub.docker.com/_/php/) documentations.
