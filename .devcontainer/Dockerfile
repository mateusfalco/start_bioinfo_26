FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Instala o Java 17 (recomendado para Nextflow moderno) e dependências
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends openjdk-17-jre-headless curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala o Nextflow globalmente
RUN curl -s https://get.nextflow.io | bash \
    && chmod +x nextflow \
    && mv nextflow /usr/local/bin/nextflow
