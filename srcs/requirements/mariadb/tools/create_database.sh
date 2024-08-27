#!/bin/bash

if [ -d /var/lib/mysql ]
then
	echo "Mariadb already downloaded"
else
  chgrp -R mysql /var/lib/mysql
  chmod -R g+rwx /var/lib/mysql

  service mariadb start

  mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
  CREATE USER IF NOT EXISTS \`${DB_USER}\`@'localhost' IDENTIFIED BY '${DB_PASSWORD}';
  GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';
  ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
  FLUSH PRIVILEGES;"

  mysqladmin -u root -p${DB_ROOT_PASSWORD} shutdown
fi

exec "$@"
