FROM    debian:bullseye

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get install -y mariadb-server

RUN     mkdir -p              /var/run/mysqld
RUN     chown -R mysql:mysql  /var/run/mysqld
RUN     chmod 777             /var/run/mysqld

COPY    ./conf/my.cnf /etc/mysql/my.cnf

EXPOSE  3306

COPY    ./tools/create_database.sh  /var/run/create_database.sh
RUN     chmod u+x                   /var/run/create_database.sh
CMD     ["/var/run/create_database.sh"]
