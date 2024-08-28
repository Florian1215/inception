#!/bin/bash

sleep 3
cd $VOLUME_WP

if [ -f "wp-config.php" ]
then
	echo "Wordpress already installed"
else
  /wp-cli.phar core download --allow-root
  /wp-cli.phar config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb
  /wp-cli.phar core install --allow-root --url="https://fguirama.42.fr" --title=$COMPOSE_PROJECT_NAME --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
  /wp-cli.phar --allow-root option update siteurl "https://fguirama.42.fr"
  /wp-cli.phar --allow-root option update home "https://fguirama.42.fr"
fi

if [ ! -d /run/php ]; then
	mkdir /run/php
fi

exec $@
