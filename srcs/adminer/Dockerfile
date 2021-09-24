FROM debian:11

EXPOSE 8080

RUN apt update
RUN apt install -y adminer


CMD [ "php", "-S", "[::]:8080", "/usr/share/adminer/adminer.php" ]