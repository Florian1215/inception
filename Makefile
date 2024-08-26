
# ---------- VARIABLES ----------------------------------------------------------------------------------------------- #
LOGIN				=	fguirama
DOMAIN				=	$(LOGIN).42.fr

SECRET				=	./.SECRET
SECRET_KEY			=	$(SECRET)/ssl_key
SECRET_CRT			=	$(SECRET)/ssl_crt

#DATA_DIR		=	/home/$(LOGIN)/data
DATA_DIR		=	/Users/florianguiramand/data
DATA_WP_DIR	=	$(DATA_DIR)/wordpress
DATA_DB_DIR	=	$(DATA_DIR)/mariadb

ENV					=	DOMAIN=${DOMAIN} DATA_WP_DIR=$(DATA_WP_DIR) DATA_DB_DIR=$(DATA_DB_DIR) SECRET_KEY=$(SECRET_KEY) SECRET_CRT=$(SECRET_CRT)

COMPOSE				=	docker compose
COMPOSE_FLAGS		=	$(ENV) $(COMPOSE) --project-directory ./srcs


# ---------- RULES --------------------------------------------------------------------------------------------------- #
all:				$(SECRET) $(DATA_DIR) up

up:
					$(COMPOSE_FLAGS) up --build

clean:
					$(COMPOSE_FLAGS) down

fclean:
					#docker run --rm -v /home/fguirama/data:data sh -c "rm -rf $(DATA_DIR)"
					$(COMPOSE_FLAGS) down -v --rmi all
					rm -rf $(SECRET)
					rm -rf $(DATA_DIR)

prune:
					docker system prune -af

$(SECRET):
					mkdir -p $@
					openssl req -x509 -newkey rsa:2048 -nodes -days 365 -out $(SECRET_CRT) -keyout $(SECRET_KEY) -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=$(DOMAIN)/UID=$(LOGIN)"
					#openssl rand -hex -out ${SECRET}password

$(DATA_DIR):
					mkdir -p $@
					mkdir -p $(DATA_WP_DIR)
					mkdir -p $(DATA_DB_DIR)
