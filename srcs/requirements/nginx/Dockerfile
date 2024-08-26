FROM    debian:bullseye

EXPOSE  443

RUN     apt-get update
RUN     apt-get upgrade -y

RUN     apt-get install -y nginx
RUN     apt-get install -y openssl

COPY    ./conf/nginx.conf /etc/nginx/nginx.conf

CMD     [ "nginx", "-g", "daemon off;" ]
