#!/bin/bash

U=""
if [ "$SUDO_USER" = "" ]; then
	U=$USER
else
	U=$SUDO_USER
fi;
H="/home/$U"
URL=${U}.42.fr

remove_line ()
{
	grep -vwE "($1)" /etc/hosts > /etc/tmp_hosts
	cat /etc/tmp_hosts > /etc/hosts
	rm /etc/tmp_hosts
}

if [ "$1" = "init" ]; then
	mkdir ${H}/data &> /dev/null
	mkdir ${H}/data/wordpress &> /dev/null
	mkdir ${H}/data/db &> /dev/null
	sudo echo "127.0.0.1		$URL" >> /etc/hosts
elif [ "$1" = "clear" ]; then
	sudo rm -rf ${H}/data
	docker volume rm inception_data &> /dev/null
	docker volume rm inception_database &> /dev/null
	remove_line "127.0.0.1		$URL"
fi;

exit 0


