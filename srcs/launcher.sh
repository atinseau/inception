#!/bin/bash

U=""
if [ "$SUDO_USER" = "" ]; then
	U=$USER
else
	U=$SUDO_USER
fi;
URL=${U}.42.fr

remove_line ()
{
	grep -vwE "($1)" /etc/hosts > /etc/tmp_hosts
	cat /etc/tmp_hosts > /etc/hosts
	rm /etc/tmp_hosts
}

if [ "$1" = "init" ]; then
	mkdir ${HOME}/data &> /dev/null
	mkdir ${HOME}/data/wordpress &> /dev/null
	mkdir ${HOME}/data/db &> /dev/null

	sudo chown -R $U ${HOME}/data

	sudo echo "127.0.0.1		$URL" >> /etc/hosts
elif [ "$1" = "clear" ]; then
	sudo rm -rf ${HOME}/data
	docker volume rm inception_data &> /dev/null
	docker volume rm inception_database &> /dev/null
	remove_line "127.0.0.1		$URL"
fi;

exit 0


