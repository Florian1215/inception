FROM        debian:bullseye

EXPOSE      9000

RUN         apt-get update
RUN         apt-get upgrade -y

RUN         apt-get -y install curl php php-cli php-fpm wget wordpress

RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN         chmod u+x /wp-cli.phar

RUN         mkdir /run/php
RUN         chown -R www-data:www-data /run/php

COPY        ./conf/www.conf                 /etc/php/7.4/fpm/pool.d/
COPY        ./tools/install_wordpress.sh    /var/run/install_wordpress.sh
RUN         chmod u+x                       /var/run/install_wordpress.sh

ENTRYPOINT  ["/var/run/install_wordpress.sh"]
CMD         ["php-fpm7.4", "-F"]
