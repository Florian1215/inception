FROM    debian:bullseye

EXPOSE  443

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get install -y nginx
RUN     apt-get install -y openssl

# TODO replace with good secrets
RUN     mkdir -p /run/secrets/
COPY    ./.SECRET/inception.crt  /run/secrets/inception.crt
COPY    ./.SECRET/inception.key  /run/secrets/inception.key

COPY    ./conf/nginx.conf /etc/nginx/conf.d/

CMD     [ "nginx", "-g", "daemon off;" ]
