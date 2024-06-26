SRCS_PATH = ./srcs/
YML_FILE = docker-compose.yml
COMPOSE_FILE = $(addprefix $(SRCS_PATH), $(YML_FILE))

all: header
	@echo "Launching Inception ..."
	@docker compose -f $(COMPOSE_FILE) up --build -d

stop:
	@echo "Stopping Inception ..."
	@docker compose -f $(COMPOSE_FILE) down

debug: clean
	@echo "Launching Inception for debug ..."
	@docker compose -f $(COMPOSE_FILE) up --build

remove_volumes:
	@if [ -n "$$(docker volume ls -q)" ]; then \
		echo "Removing docker volumes ..."; \
		docker compose -f $(COMPOSE_FILE) down --volumes; \
		echo "Volumes removed $(GREEN)\t\t\t[ ✔ ]$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker volumes found.\n$(RESET)"; \
	fi

remove_images:
	@if [ -n "$$(docker image ls -q)" ]; then \
		echo "Removing docker images ..."; \
		docker compose -f $(COMPOSE_FILE) down --rmi all; \
		echo "Images removed $(GREEN)\t\t\t\t[ ✔ ]$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker volumes found.\n$(RESET)"; \
	fi

remove_containers:
	@if [ -n "$$(docker ps -aq)" ]; then \
		echo "$(YELLOW)\n. . . stopping and removing docker containers . . . \n$(RESET)"; \
		docker compose -f $(COMPOSE_FILE) down; \
		echo "\n$(BOLD)$(GREEN)Containers stopped and removed [ ✔ ]\n$(RESET)"; \
	else \
		echo "\n$(BOLD)$(RED)No Docker containers found.$(RESET)\n"; \
	fi

clean: remove_volumes remove_containers remove_images
	@echo "Inception cleaned $(GREEN)\t\t\t[ ✔ ]$(RESET)"


prune:
	@echo "$(YELLOW)\n Pruning docker environment... \n$(RESET)"
	@docker system prune -fa
	@echo "\n$(BOLD)$(GREEN)Pruned\t\t\t[ ✔ ]$(RESET)"

fclean: clean prune

re: fclean all


header:
	clear
	@echo "$(BOLD) $(YELLOW) $$HEADER_PROJECT $(RESET)"

.PHONY: all stop debug clean prune fclean re header

define HEADER_PROJECT

██╗███╗   ██╗ ██████╗███████╗██████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝██╔════╝██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║██║     █████╗  ██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║██║     ██╔══╝  ██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║
██║██║ ╚████║╚██████╗███████╗██║        ██║   ██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                        
endef
export HEADER_PROJECT

# COLORS
RESET = \033[0m
WHITE = \033[37m
GREY = \033[90m
RED = \033[91m
DRED = \033[31m
GREEN = \033[92m
DGREEN = \033[32m
YELLOW = \033[93m
DYELLOW = \033[33m
BLUE = \033[94m
DBLUE = \033[34m
MAGENTA = \033[95m
DMAGENTA = \033[35m
CYAN = \033[96m
DCYAN = \033[36m

# FORMAT
BOLD = \033[1m
ITALIC = \033[3m
UNDERLINE = \033[4m
STRIKETHROUGH = \033[9m
