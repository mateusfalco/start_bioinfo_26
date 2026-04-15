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

# Cria um arquivo .bashrc totalmente novo para o root, forçando a sua marca
RUN echo 'export PS1="\\[\\033[01;32m\\][StartBioinfo26]\\[\\033[00m\\] \\w $ "' > /root/.bashrc
