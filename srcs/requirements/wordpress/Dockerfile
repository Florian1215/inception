FROM        debian:bullseye

EXPOSE      9000

RUN         apt-get update
RUN         apt-get upgrade -y

RUN         apt-get -y install wget
RUN         apt-get -y install php-fpm

RUN         wget https://wordpress.org/latest.tar.gz -P /var/www
RUN         tar -xzvf /var/www/latest.tar.gz -C /var/www/
RUN         rm -rf /var/www/latest.tar.gz

COPY        ./conf/wp-config.php /var/www/wordpress

RUN         mkdir /run/php
RUN         chown -R www-data:www-data /run/php

CMD         ["php-fpm7.4", "-F"]