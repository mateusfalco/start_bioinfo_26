#!/bin/bash

# Cores para deixar o terminal bonito
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   Iniciando Módulo de Visualização de Dados (R)      ${NC}"
echo -e "${BLUE}======================================================${NC}"

# 1. Cria o script R dinamicamente
echo -e "${YELLOW}[1/3] Preparando o script de análise em R...${NC}"
cat << 'EOF' > plot_microbioma.R
suppressPackageStartupMessages(library(phyloseq))
suppressPackageStartupMessages(library(ggplot2))

# Carrega os dados
ps <- readRDS("resultados/phyloseq/dada2_phyloseq.rds")

# Injeta metadados mínimos
df_metadados <- data.frame(sampleID = sample_names(ps), row.names = sample_names(ps))
sample_data(ps) <- sample_data(df_metadados)

# Tema visual com fundo branco
fundo_branco <- theme(
  plot.background = element_rect(fill = "white", color = NA),
  panel.background = element_rect(fill = "white", color = "gray80"),
  legend.background = element_rect(fill = "white", color = NA)
)

# Gráfico 1: Filos
ps_rel <- transform_sample_counts(ps, function(x) x / sum(x) * 100)
ps_phylum <- tax_glom(ps_rel, taxrank = "Phylum")
p1 <- plot_bar(ps_phylum, fill = "Phylum") +
  geom_bar(stat = "identity", position = "stack", color = NA) +
  theme_minimal() + fundo_branco +
  labs(title = "1. Evolução Taxonômica (Nível de Filo)", x = "Amostras", y = "Abundância Relativa (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
suppressWarnings(ggsave("resultados/grafico_1_composicao.png", plot = p1, width = 10, height = 6, dpi = 300))

# Gráfico 2: Diversidade Alfa
ps_alfa <- prune_samples(sample_sums(ps) > 0, ps)
p2 <- suppressWarnings(plot_richness(ps_alfa, measures = c("Observed", "Shannon", "Simpson"))) +
  theme_bw() + fundo_branco +
  geom_point(size = 4, color = "#2c3e50") +
  labs(title = "2. Diversidade Alfa (Riqueza Intracomunidade)", x = "Amostras") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
suppressWarnings(ggsave("resultados/grafico_2_alfa_div.png", plot = p2, width = 10, height = 6, dpi = 300))

# Gráfico 3: Engraftment Top 10 Gêneros
ps_genus <- tax_glom(ps_rel, taxrank = "Genus")
top10_taxa <- names(sort(taxa_sums(ps_genus), decreasing = TRUE)[1:10])
ps_top10 <- prune_taxa(top10_taxa, ps_genus)
p3 <- plot_bar(ps_top10, fill = "Genus") +
  geom_bar(stat = "identity", position = "stack", color = NA) +
  theme_minimal() + fundo_branco +
  labs(title = "3. Sucesso do Transplante (Top 10 Gêneros Dominantes)", x = "Amostras", y = "Abundância Relativa (%)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), plot.title = element_text(size = 14, face = "bold", hjust = 0.5), legend.title = element_text(face = "bold"))
suppressWarnings(ggsave("resultados/grafico_3_top10_generos.png", plot = p3, width = 11, height = 6, dpi = 300))
EOF

# 2. Localiza a imagem do Docker
echo -e "${YELLOW}[2/3] Conectando ao motor Docker do Nextflow...${NC}"
IMG_R=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep phyloseq | head -n 1)

if [ -z "$IMG_R" ]; then
    echo -e "\033[0;31mERRO: Imagem do Phyloseq não encontrada. Rode o pipeline Nextflow primeiro.\033[0m"
    exit 1
fi

# 3. Executa o script dentro do container
echo -e "${YELLOW}[3/3] Gerando gráficos de publicação na pasta 'resultados/'...${NC}"
docker run --rm -v $(pwd):/workspace -w /workspace $IMG_R Rscript plot_microbioma.R

# 4. Finalização
echo -e "${GREEN} Sucesso absoluto! Abra a pasta 'resultados/' para visualizar as imagens.${NC}"
