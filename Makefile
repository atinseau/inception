######################################
########     INCEPTION    ############
######################################

GREEN=\033[0;32m
NO=\033[0m

CC=docker-compose -p inception
LAUNCHER=./srcs/launcher.sh

all:
	@$(LAUNCHER) mount 0
	@sudo $(LAUNCHER) host 1
	$(CC) up --build -d
	@printf "$(GREEN)2. Docker-compose done$(NO)\n"
	@echo "\n\nGo to https://$$USER.42.fr"


clean:
	@$(CC) down > /dev/null
	@printf "$(GREEN)0. Docker-compose cleaned$(NO)\n"

fclean: clean
	@$(LAUNCHER) delete 1
	@sudo $(LAUNCHER) unhost 2
	
re: fclean all