FROM debian:buster

EXPOSE 8080

RUN apt update
RUN apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https
RUN wget https://packages.sury.org/php/apt.gpg
RUN apt-key add apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php8.list
RUN apt update
RUN apt install -y php8.0 php8.0-cli php8.0-common php8.0-fpm php8.0-mysql mariadb-client

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php 

CMD [ "php", "-S", "[::]:8080", "adminer-4.8.1.php" ]