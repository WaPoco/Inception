#!/bin/bash
set -e

WP_PATH="/var/www/html"

WORDPRESS_DB_PASSWORD=$(cat /run/secrets/db_password)
WORDPRESS_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WORDPRESS_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

echo "Waiting for MariaDB..."

until mariadb-admin ping \
    --host="$WORDPRESS_DB_HOST" \
    --user="$WORDPRESS_DB_USER" \
    --password="$WORDPRESS_DB_PASSWORD" \
    --silent
do
    sleep 1
done

echo "MariaDB is ready."

cd "$WP_PATH"

echo "Setting up WordPress..."

# Download and configure WordPress if not present
if [ ! -f "$WP_PATH/wp-config.php" ]; then
	wp core download --allow-root
	wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST" \
		--allow-root
	wp core install \
		--url="$DOMAIN_NAME" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
    		--allow-root
	wp user create \
	       	"$WORDPRESS_USER" \
		"$WORDPRESS_USER_EMAIL" \
		--user_pass="$WORDPRESS_USER_PASSWORD" \
		--role=author \
		--allow-root
    	# Set secure permissions
    	find "$WP_PATH" -type d -exec chmod 755 {} \;
    	find "$WP_PATH" -type f -exec chmod 644 {} \;
    	chown -R www-data:www-data "$WP_PATH"
	echo "WordPress setup complete."
else
    echo "WordPress already initialized, skipping setup."
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F
