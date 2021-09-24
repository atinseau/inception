######################################
########     INCEPTION    ############
######################################


CC=docker-compose -p inception
EXEC=sudo bash srcs/launcher.sh

all: build run

run:
	$(CC) up -d
	@echo -i "\n\nINCEPTION IS ONLINE https://$${USER}.42.fr"

build:
	$(EXEC) init
	$(CC) build

stop:
	$(CC) down

clear: stop
	$(EXEC) clear

re: clear build run