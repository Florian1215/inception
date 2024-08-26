FROM        debian:bullseye

EXPOSE      9000

RUN         apt-get update
RUN         apt-get upgrade -y

RUN         apt-get -y install wget curl php-fpm php wordpress php-cli

RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN         chmod u+x /wp-cli.phar

RUN         mkdir /run/php
RUN         chown -R www-data:www-data /run/php

COPY        ./conf/www.conf /etc/php/7.4/fpm/pool.d/
COPY        ./tools/config_wordpress.sh /tmp/
RUN         chmod u+x /tmp/config_wordpress.sh

ENTRYPOINT  ["tmp/config_wordpress.sh"]
CMD         ["php-fpm7.4", "-F"]
