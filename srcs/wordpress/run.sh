
until  echo "SHOW DATABASES;" | mysql -u$DB_USER -p$DB_PASSWORD -h "mysql" 

do
	echo "mysql waiting...."
done

wp core is-installed --path="/var/www/html" --allow-root
if [ $? != 0 ]; then 
	wp config create --path="/var/www/html" --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="mysql" --allow-root

	wp core install \
		--path="/var/www/html" \
		--url="https://${CURRENT_USER}.42.fr" \
		--title="${TITLE}" \
		--admin_user="${ADMIN_USER}" \
		--admin_password="${ADMIN_PASSWORD}" \
		--admin_email="${ADMIN_EMAIL}" \
		--skip-email \
		--allow-root

	wp user create ${WP_USER} ${WP_USER_EMAIL} \
		--role="${WP_ROLE}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--display_name="${USER}" \
		--path="/var/www/html" \
		--allow-root

	wp config --path="/var/www/html" --allow-root set FS_METHOD direct
	wp config --path="/var/www/html" --allow-root set WP_REDIS_HOST redis
	wp config --path="/var/www/html" --allow-root set WP_CACHE_KEY_SALT wp-docker-5DknvYepdjyJMo8gDqrLhrpAJUQ

	# BONUS
	wp --path="/var/www/html" plugin install redis-cache --allow-root
	wp --path="/var/www/html" plugin activate redis-cache --allow-root
	wp redis --path="/var/www/html" --allow-root enable
fi;


mkdir /run/php
php-fpm8.0 -F