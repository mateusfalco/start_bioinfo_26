# Carrega as bibliotecas silenciosamente
suppressPackageStartupMessages(library(phyloseq))
suppressPackageStartupMessages(library(ggplot2))

cat("Carregando os dados do microbioma...\n")
ps <- readRDS("resultados/phyloseq/dada2_phyloseq.rds")

# Injetando metadados mínimos à força para evitar bugs internos do phyloseq
df_metadados <- data.frame(sampleID = sample_names(ps), row.names = sample_names(ps))
sample_data(ps) <- sample_data(df_metadados)

# --- TEMA PADRÃO PARA FUNDO BRANCO SÓLIDO ---
fundo_branco <- theme(
  plot.background = element_rect(fill = "white", color = NA),
  panel.background = element_rect(fill = "white", color = "gray80"),
  legend.background = element_rect(fill = "white", color = NA)
)

# ==========================================
# GRÁFICO 1: COMPOSIÇÃO TAXONÔMICA (FILO)
# ==========================================
cat("Gerando Gráfico 1: Composição (Filo)...\n")
ps_rel <- transform_sample_counts(ps, function(x) x / sum(x) * 100)
ps_phylum <- tax_glom(ps_rel, taxrank = "Phylum")

p1 <- plot_bar(ps_phylum, fill = "Phylum") +
  geom_bar(stat = "identity", position = "stack", color = NA) +
  theme_minimal() + fundo_branco +
  labs(title = "1. Evolução Taxonômica Geral (Nível de Filo)", x = "Amostras", y = "Abundância Relativa (%)") +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), 
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5)
  )

suppressWarnings(ggsave("resultados/grafico_1_composicao.png", plot = p1, width = 10, height = 6, dpi = 300))

# ==========================================
# GRÁFICO 2: DIVERSIDADE ALFA (Riqueza)
# ==========================================
cat("Gerando Gráfico 2: Diversidade Alfa...\n")
ps_alfa <- prune_samples(sample_sums(ps) > 0, ps)

p2 <- suppressWarnings(plot_richness(ps_alfa, measures = c("Observed", "Shannon", "Simpson"))) +
  theme_bw() + fundo_branco +
  geom_point(size = 4, color = "#2c3e50") +
  labs(title = "2. Diversidade Alfa (Riqueza Intracomunidade)", x = "Amostras") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), plot.title = element_text(size = 14, face = "bold", hjust = 0.5))

suppressWarnings(ggsave("resultados/grafico_2_alfa_div.png", plot = p2, width = 10, height = 6, dpi = 300))

# ==========================================
# GRÁFICO 3: ENGRAFTMENT (TOP 10 GÊNEROS)
# ==========================================
cat("Gerando Gráfico 3: Engraftment (Top 10 Gêneros)...\n")
# Agrupa os dados em Gênero
ps_genus <- tax_glom(ps_rel, taxrank = "Genus")

# Descobre quais são os 10 gêneros mais abundantes somando todas as amostras
top10_taxa <- names(sort(taxa_sums(ps_genus), decreasing = TRUE)[1:10])

# Filtra o objeto para manter APENAS esses 10 campeões
ps_top10 <- prune_taxa(top10_taxa, ps_genus)

p3 <- plot_bar(ps_top10, fill = "Genus") +
  geom_bar(stat = "identity", position = "stack", color = NA) +
  theme_minimal() + fundo_branco +
  labs(title = "3. Sucesso do Transplante (Top 10 Gêneros Dominantes)", x = "Amostras", y = "Abundância Relativa (%)") +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"), 
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    legend.title = element_text(face = "bold")
  )

suppressWarnings(ggsave("resultados/grafico_3_top10_generos.png", plot = p3, width = 11, height = 6, dpi = 300))

cat("Sucesso absoluto! Gráficos salvos na pasta 'resultados/'.\n")
