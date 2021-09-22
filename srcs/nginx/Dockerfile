FROM debian:11


RUN apt update
RUN apt install -y nginx
RUN apt install -y openssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Nginx Inception FT/OU=Arthur/CN=localhost"

COPY default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]