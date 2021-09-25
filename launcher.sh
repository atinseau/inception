#!/bin/bash

GREEN='\033[0;32m'
NO='\033[0m'

remove_line ()
{
	grep -vwE "($1)" /etc/hosts > /etc/tmp_hosts
	cat /etc/tmp_hosts > /etc/hosts
	rm /etc/tmp_hosts
}

if [ $1 != "" ]; then

	if [ "$1" = "delete" ]; then

		docker volume remove wp
		docker volume remove db
		VOLUME_PATH="${HOME}/data"
		if [ "$(uname)" = "Darwin" ]; then
			VOLUME_PATH="${PWD}/data"
		fi;
		sudo rm -rf $VOLUME_PATH
		printf "${GREEN}${2}. Inception volume cleaned${NO}\n"
	fi;

	if [ "$1" = "mount" ]; then

		VOLUME_PATH="${HOME}/data"
		if [ "$(uname)" = "Darwin" ]; then
			mkdir -p data/wp &> /dev/null
			mkdir -p data/db &> /dev/null
			VOLUME_PATH="${PWD}/data"
		else
			mkdir -p ${HOME}/data/wp &> /dev/null
			mkdir -p ${HOME}/data/db &> /dev/null
		fi

		docker volume create --name wp --opt type=none --opt device=${VOLUME_PATH}/wp --opt o=bind &> /dev/null
		docker volume create --name db --opt type=none --opt device=${VOLUME_PATH}/db --opt o=bind &> /dev/null

		printf "${GREEN}${2}. Volumes is mount at ${HOME}/data${NO}\n"
	fi;

	if [ "$1" = "host" ]; then
		echo "127.0.0.1		${SUDO_USER}.42.fr" >> /etc/hosts
		printf "${GREEN}${2}. Hosts is update with ${SUDO_USER}.42.fr${NO}\n"
	fi;

	if [ "$1" = "unhost" ]; then
		remove_line "127.0.0.1		${SUDO_USER}.42.fr"
		printf "${GREEN}${2}. Hosts is cleared${NO}\n"
	fi;


	if [ "$1" = "update" ]; then

		docker --version | grep "20.10.8"
		if [ $? != 0 ]; then
			if [ "$(uname)" = "Linux" ]; then
				echo "REINSTALL NEW VERSION OF D0OCKER"
				sudo apt-get remove docker docker-engine docker.io containerd runc
				sudo apt-get update
				
				sudo apt-get install -y \
				apt-transport-https \
				ca-certificates \
				curl \
				gnupg \
				lsb-release
				
				curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
				
				echo \
				"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
				$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
			
				# INSTALLING
				sudo apt-get update 
				sudo apt-get install -y docker-ce docker-ce-cli containerd.io
				echo "DOCKER is updated"
			else
				echo "YOU ARE NOT ON LINUX, UPDATE DOCKER DESKTOP !"
			fi
		fi;

		docker-compose --version | grep "1.29.2"
		if [ $? != 0 ]; then
			if [ "$(uname)" = "Linux" ]; then
				sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
				sudo chmod +x /usr/local/bin/docker-compose
				sudo rm -rf /usr/bin/docker-compose
				sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

				docker-compose --version
				if [ $? = 0 ]; then
					echo "DOCKER-COMPOSE is updated"
				else
					echo "Somethings wrong with the previous docker-compose installation..."
					exit 1
				fi;
			fi;
		fi
	fi;
fi;


