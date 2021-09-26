FROM debian:buster

RUN apt update

RUN apt install -y redis-server

COPY run.sh /tmp/run.sh
COPY redis.conf etc/redis/redis.conf
RUN chmod 775 etc/redis/redis.conf

CMD [ "sh", "/tmp/run.sh"]