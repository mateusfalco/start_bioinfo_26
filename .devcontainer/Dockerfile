FROM debian:bookworm-slim

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
       openjdk-17-jre-headless \
       ca-certificates \
       curl \
       git \
    && curl -s https://get.nextflow.io | bash \
    && chmod +x nextflow \
    && mv nextflow /usr/local/bin/nextflow \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

# Recria o .bashrc com o prompt customizado E a ativação das cores
RUN echo 'export PS1="\\[\\033[01;32m\\][StartBioinfo26]\\[\\033[00m\\] \\w $ "' > /root/.bashrc \
    && echo 'export TERM=xterm-256color' >> /root/.bashrc \
    && echo 'alias ls="ls --color=auto"' >> /root/.bashrc \
    && echo 'alias ll="ls -la --color=auto"' >> /root/.bashrc \
    && echo 'alias grep="grep --color=auto"' >> /root/.bashrc
