FROM debian:buster

EXPOSE 21

RUN apt update
RUN apt install -y vsftpd

COPY vsftpd.conf /etc/vsftpd.conf
COPY run.sh /tmp/run.sh

CMD [ "sh", "/tmp/run.sh" ]