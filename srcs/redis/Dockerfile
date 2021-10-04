FROM debian:buster

RUN apt update

RUN apt install -y redis-server

COPY redis.conf etc/redis/redis.conf
RUN chmod 775 etc/redis/redis.conf

CMD [ "redis-server" , "/etc/redis/redis.conf" ]