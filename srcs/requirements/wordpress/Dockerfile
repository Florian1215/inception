FROM        debian:bullseye

EXPOSE      9000

RUN         apt-get update
RUN         apt-get upgrade -y

RUN         apt-get -y install wget

RUN         wget https://wordpress.org/latest.tar.gz -P /
RUN         tar -xzvf /latest.tar.gz -C /var/www/
RUN         rm -rf latest.tar.gz

COPY        ./conf/wp-config.php /var/www/wordpress
