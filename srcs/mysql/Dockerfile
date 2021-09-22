FROM debian:11

RUN apt update
RUN apt install -y mariadb-server mariadb-common mariadb-client

COPY run.sh /tmp
COPY mysql.cnf /etc/mysql/mariadb.cnf

RUN chmod 0644 /etc/mysql/mariadb.cnf

CMD [ "sh", "/tmp/run.sh" ]