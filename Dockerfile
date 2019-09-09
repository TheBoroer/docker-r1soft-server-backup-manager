FROM ubuntu:16.04

LABEL maintainer "docker@bo.ro"

RUN apt-get update \
    && apt-get install -y wget

RUN echo deb http://repo.r1soft.com/apt stable main >> /etc/apt/sources.list \
    && wget http://repo.r1soft.com/r1soft.asc \
    && apt-key add r1soft.asc 

RUN apt-get update
RUN apt-get install -y serverbackup-enterprise

ADD start.sh /start.sh
RUN chmod 755 /start.sh

CMD ["/start.sh"]