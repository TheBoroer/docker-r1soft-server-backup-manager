FROM ubuntu:18.04
LABEL maintainer "docker@bo.ro"

RUN apt update \
    && apt install -y wget gnupg2 nano

RUN apt upgrade -y

RUN echo deb http://repo.r1soft.com/apt stable main >> /etc/apt/sources.list \
    && wget http://repo.r1soft.com/r1soft.asc \
    && apt-key add r1soft.asc

RUN apt update
RUN apt install -y serverbackup-enterprise

# make a copy of the conf folders.
RUN cp -avr /usr/sbin/r1soft/conf /usr/sbin/r1soft/conf-init
RUN cp -avr /usr/sbin/r1soft/log /usr/sbin/r1soft/log-init

ADD start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]