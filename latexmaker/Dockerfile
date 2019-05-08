FROM ubuntu:18.04

ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install \
    latexmk \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-pictures \
    texlive-latex-extra \
    texlive-lang-spanish \
    plantuml \
    make \
    git

WORKDIR /doc

