#!/bin/sh

# INIT MARIA DB

/usr/bin/mysqld_safe &

db_pid=$!

until echo "SHOW DATABASES" | mysql -uroot > /dev/null
do
	echo "waiting..."
	sleep 1
done

echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY \"$DB_PASSWORD\";" | mysql -uroot
echo "CREATE DATABASE $DB_NAME;" | mysql -uroot
echo "GRANT ALL ON wordpress.* TO '$DB_USER'@'%';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

wait $db_pid