FROM phusion/baseimage:latest-amd64
LABEL maintainer "docker@bo.ro"

RUN apt update \
    && apt install -y wget gnupg2

RUN apt upgrade -y

RUN echo deb http://repo.r1soft.com/apt stable main >> /etc/apt/sources.list \
    && wget http://repo.r1soft.com/r1soft.asc \
    && apt-key add r1soft.asc 

RUN apt update
RUN apt install -y serverbackup-enterprise

ADD start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]