#!/bin/bash

sleep 10

if [ ! -f wp-config.php ]; then
    wp config create	--allow-root --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_USER_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'

    sleep 2
    wp core download --allow-root
    head -n -1 /var/www/wordpress/wp-config.php > tmp.txt; mv tmp.txt /var/www/wordpress/wp-config.php
    cat /custom/conf.php >> /var/www/wordpress/wp-config.php


    wp core install --url=$DOMAIN --title=inception --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
    wp user create --allow-root --role=author $WORDPRESS_USER $WORDPRESS_USER_EMAIL --user_pass=$WORDPRESS_USER_PASSWORD --path='/var/www/wordpress' >> /log.txt
    wp theme install bizboost --activate --allow-root --path='/var/www/wordpress'
    wp plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'
    wp plugin update --all --allow-root --path='/var/www/wordpress'
fi

if [ ! -d /run/php ]; then
	mkdir /run/php
fi
wp redis enable --allow-root  --path='/var/www/wordpress'

/usr/sbin/php-fpm7.4 -F
