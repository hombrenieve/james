# Gtypist in spanish image
FROM ubuntu:24.04

RUN apt -y update &&\
   apt -y upgrade &&\
   apt -y install gtypist &&\
   DEBIAN_FRONTEND=noninteractive apt -y install locales

RUN sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
   dpkg-reconfigure --frontend=noninteractive locales && \
   update-locale LANG=es_ES.UTF-8

ENV LANG es_ES.UTF-8
ENV LC_ALL es_ES.UTF-8
ENV LANGUAGE es_ES.UTF-8

ENTRYPOINT ["gtypist", "esp.typ"]
