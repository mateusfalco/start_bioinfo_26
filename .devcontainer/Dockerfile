# Usa a versão oficial mínima do Debian 12
FROM debian:bookworm-slim

# Instalação cirúrgica apenas do essencial e limpeza profunda em uma única camada
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
