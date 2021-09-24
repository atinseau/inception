#!/bin/bash

docker --version | grep "20.10.8"
if [ $? != 0 ]; then
	if [ "$(uname)" = "Linux" ]; then
		echo "REINSTALL NEW VERSION OF D0OCKER"
		sudo apt-get remove docker docker-engine docker.io containerd runc
		sudo apt-get update
		
		sudo apt-get install \
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
		sudo apt-get install docker-ce docker-ce-cli containerd.io
		sudo groupadd docker

		if [ $? = 0 ]; then 
			sudo usermod -aG docker $USER
			newgrp docker
			echo "DOCKER is updated"
			echo "PLEASE RESTART THE SESSION"
			exit 1
		fi

		echo "DOCKER is updated"
	else
		echo "YOU ARE NOT ON LINUX, UPDATE DOCKER DESKTOP !"
		exit 1
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


# U=""
# if [ "$SUDO_USER" = "" ]; then
# 	U=$USER
# else
# 	U=$SUDO_USER
# fi;
# URL=${U}.42.fr

# remove_line ()
# {
# 	grep -vwE "($1)" /etc/hosts > /etc/tmp_hosts
# 	cat /etc/tmp_hosts > /etc/hosts
# 	rm /etc/tmp_hosts
# }

# if [ "$1" = "init" ]; then
# 	mkdir ${HOME}/data &> /dev/null
# 	mkdir ${HOME}/data/wordpress &> /dev/null
# 	mkdir ${HOME}/data/db &> /dev/null

# 	sudo chown -R $U ${HOME}/data

# 	sudo echo "127.0.0.1		$URL" >> /etc/hosts
# elif [ "$1" = "clear" ]; then
# 	sudo rm -rf ${HOME}/data
# 	docker volume rm inception_data &> /dev/null
# 	docker volume rm inception_database &> /dev/null
# 	remove_line "127.0.0.1		$URL"
# fi;

# exit 0


