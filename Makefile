######################################
########     INCEPTION    ############
######################################

GREEN=\033[0;32m
NO=\033[0m

CC=docker-compose -p inception
LAUNCHER=./launcher.sh

all:
	@$(LAUNCHER) mount 0
	@sudo $(LAUNCHER) host 1
	@$(CC) build
	@$(CC) up -d
	@printf "$(GREEN)2. Docker-compose done$(NO)\n"
	@echo "\n\nGo to https://$$USER.42.fr"


clean:
	@$(CC) down > /dev/null
	@printf "$(GREEN)0. Docker-compose cleaned$(NO)\n"

fclean:
	@$(CC) down -v > /dev/null
	@$(LAUNCHER) delete 1
	@sudo $(LAUNCHER) unhost 2
	
re:
	@make fclean
	@make

update:
	$(LAUNCHER) update