LOGIN			=	fguirama
DOMAIN			=	$(LOGIN).42.fr
SECRET			=	.SECRET/

$(SECRET):
					mkdir -p ${SECRET}
					openssl req -x509 -newkey rsa:2048 -nodes -days 365 -out $(SECRET)inception.crt -keyout $(SECRET)inception.key -subj "/C=FR/ST=ARA/L=Lyon/O=42/OU=42/CN=$(DOMAIN)/UID=$(LOGIN)"
					#openssl rand -hex -out ${SECRET}password