FROM        debian:bullseye

RUN       apt-get update
RUN       apt-get upgrade -y

RUN       apt-get install -y mariadb-server

RUN       mkdir -p              /run/mysqld
RUN       chown -R mysql:mysql  /run/mysqld

COPY        ./conf/my.cnf /etc/mysql/my.cnf

EXPOSE      3306

COPY        ./tools/create_database.sh  /var/run/create_database.sh
RUN         chmod u+x                   /var/run/create_database.sh

ENTRYPOINT  ["/var/run/create_database.sh"]
CMD         ["mariadbd"]
