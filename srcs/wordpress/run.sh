
until  echo "SHOW DATABASES;" | mysql -u$DB_USER -p$DB_PASSWORD -h "mysql" 

do
	echo "mysql waiting...."
done


wp core is-installed
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

	wp user create ${USER} ${USER_EMAIL} \
		--role="editor" \
		--user_pass="${USER_PASSWORD}" \
		--display_name="${USER}" \
		--path="/var/www/html" \
		--allow-root
fi;




service php8.0-fpm start


bash