FROM debian:11

RUN apt update

RUN apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https
RUN wget https://packages.sury.org/php/apt.gpg
RUN apt-key add apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php8.list
RUN apt update
RUN apt install -y php8.0 php8.0-cli php8.0-common php8.0-fpm php8.0-mysql mariadb-client

##### BONUS 
RUN apt install -y redis-server
RUN apt install -y php-redis
#####

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /var/www/html
RUN wp core download --locale=fr_FR --allow-root --path="/var/www/html"

COPY www.conf /etc/php/8.0/fpm/pool.d/www.conf
COPY run.sh /tmp/run.sh

###### BONUS
COPY redis.conf etc/redis/redis.conf
RUN chmod 775 etc/redis/redis.conf
######

CMD ["sh", "/tmp/run.sh"]
