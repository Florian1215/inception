FROM        debian:bullseye

RUN         apt-get update
RUN         apt-get upgrade -y

RUN         apt-get -y install wget


RUN         apt-get install -y php7.4 php-fpm php-mysql mariadb-client

RUN         wget https://fr.wordpress.org/wordpress-6.5.3-fr_FR.tar.gz -P /var/www

RUN         cd /var/www && tar -xzf wordpress-6.5.3-fr_FR.tar.gz && rm wordpress-6.5.3-fr_FR.tar.gz

RUN         chown -R root:root /var/www/wordpress

COPY        tools/config_wordpress.sh /var/run/
RUN         chmod u+x /var/run/config_wordpress.sh

ENTRYPOINT  ["/var/run/config_wordpress.sh"]