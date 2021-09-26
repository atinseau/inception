FROM debian:buster

RUN apt update
RUN apt install -y nginx
RUN apt install -y openssl
RUN apt install -y wget

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/localhost.pem -keyout /etc/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Nginx Inception FT/OU=Arthur/CN=localhost"

##### BONUS
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/bonus_localhost.pem -keyout /etc/ssl/bonus_localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=Nginx Bonus Inception FT/OU=Arthur/CN=localhost"
RUN mkdir /var/www/bonus
#####

COPY default /etc/nginx/sites-available/default
COPY dist /var/www/bonus/.

CMD ["nginx", "-g", "daemon off;"]