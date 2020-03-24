FROM ubuntu:18.04

# Install latexmk
RUN apt update && apt -y install\
    latexmk \
    && rm -rf /var/lib/apt/lists/*

#It will install tzdata and it needs to configure the location
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt -y install \
    texlive-latex-extra \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt -y install \
    texlive-fonts-extra \
    texlive-lang-spanish \
    python-pygments \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /doc
ENTRYPOINT [ "latexmk" ]
CMD [ "-shell-escape", "-pdf", "document.tex" ]
