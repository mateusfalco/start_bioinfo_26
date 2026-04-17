<div align="center">

# Start Bioinfo '26
*Introdução ao Nextflow e Bioinformática Reprodutível*

<img src="img/start_bioinfo_26_header.png" alt="Start Bioinfo 26 Logo"/>

</div>

<br>

A bioinformática moderna exige reprodutibilidade, escalabilidade e controle rigoroso de cada etapa analítica. Neste minicurso, vamos explorar o ecossistema Nextflow, a transição do pensamento linear em *scripts Bash* para o paradigma de *Dataflow* e a execução de pipelines padrão-ouro diretamente na nuvem.

<br>

<div align="center">
  <a href="https://codespaces.new/mateusfalco/start_bioinfo_26">
    <img src="https://github.com/codespaces/badge.svg" alt="Open in GitHub Codespaces" height="40" />
  </a>
  <p><i>Clique acima para iniciar o ambiente de prática.</i></p>
</div>

<br>

Para que nosso foco seja inteiramente científico e prático, abstraímos a barreira da infraestrutura. O ambiente virtual gerado pelo **Codespaces** já vem configurado com todas as dependências (Nextflow, Docker e utilitários) necessárias para a aula.

<br>

<div align="center">
  <h3>Gravação Oficial do Minicurso</h3>
  <a href="https://www.youtube.com/watch?v=tKOzPr_Evxw" target="_blank">
    <img src="https://img.youtube.com/vi/tKOzPr_Evxw/maxresdefault.jpg" alt="Start Bioinfo 2026 - Introdução ao Nextflow - dia 04" width="700" style="border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
  </a>
  <br>
  <p><i>▶️ Clique na imagem acima para assistir à gravação completa no YouTube.</i></p>
</div>

---

## O Experimento: Transplante de Microbiota Fecal (FMT)

A nossa prática não é apenas um teste de software, é ciência real. Os dados utilizados são baseados em um estudo longitudinal in vivo de Transplante de Microbiota Fecal (FMT) em camundongos.

Acompanharemos uma série temporal de 4 pontos (referente à amostra "19022" no Camundongo #2) para analisar o *engraftment* (sucesso da colonização) das bactérias:
* **Dia 0:** Fezes Humanas Originais (Input/Doador) - `SRR38096734`
* **Dia 7:** Fezes Camundongo #2 (Antes da consolidação do FMT) - `SRR38097380`
* **Dia 23:** Fezes Camundongo #2 (Pós-FMT) - `SRR38096774`
* **Dia 27:** Fezes Camundongo #2 (Evolução final) - `SRR38097389`

---

## Execução do Pipeline Padrão Ouro

### 1. Preparando os Metadados (`samplesheet.csv`)
O Nextflow exige rigor na entrada de dados. Certifique-se de que o arquivo `samplesheet.csv` na raiz do seu projeto contenha a seguinte estrutura para mapear os arquivos baixados:

```csv
sampleID,forwardReads,reverseReads,run
S00_19022_Human_Stool,./data/SRR38096734_1.fastq.gz,./data/SRR38096734_2.fastq.gz,1
S01_19022_Mouse2_D23,./data/SRR38096774_1.fastq.gz,./data/SRR38096774_2.fastq.gz,1
S02_19022_Mouse2_D7,./data/SRR38097380_1.fastq.gz,./data/SRR38097380_2.fastq.gz,1
S03_19022_Mouse2_D27,./data/SRR38097389_1.fastq.gz,./data/SRR38097389_2.fastq.gz,1
```

### 2. A Orquestração (nf-core/ampliseq)

Para processar os dados brutos e gerar as matrizes de abundância com resolução de ASVs, executaremos o pipeline nf-core/ampliseq.

*Nota biológica: Como o protocolo de sequenciamento utilizado (EMP) já entrega reads sem primers na extremidade 5', mas com read-through na 3', nós desligamos o Cutadapt e ajustamos o truncamento nativo do DADA2.*

```bash
nextflow run nf-core/ampliseq \
  -r 2.16.1 \
  -profile docker \
  --input samplesheet.csv \
  --FW_primer "GTGYCAGCMGCCGCGGTAA" \
  --RV_primer "GGACTACNVGGGTWTCTAAT" \
  --outdir ./resultados \
  --skip_cutadapt \
  --trunclenf 240 \
  --trunclenr 200 \
  -resume
```

*  **Cache:** A flag `-resume` garante que a execução recupere etapas previamente calculadas em caso de interrupção, economizando horas de processamento.

---

## Visualização de Dados

Um pipeline profissional não devolve apenas tabelas de texto; ele entrega produtos prontos para *Data Science*. O Nextflow empacotou nossa filogenia, taxonomia e contagens em um único objeto `.rds` (Phyloseq).

Para gerar gráficos de publicação sem precisar instalar o R na sua máquina, encapsulamos toda a lógica em um script automatizado que reutiliza o ambiente isolado do *Docker*. No terminal do seu *Codespace*, execute:

```bash
./dataviz.sh
```
* Resultado: Abra a pasta `resultados/` no explorador do VS Code e clique nas imagens `.png` para visualizar a evolução taxonômica e a substituição das comunidades do camundongo pela do doador humano.

---

## Materiais de Apoio

*  **[Slides da Apresentação (PDF)](doc/Start_Bioinfo_26.pdf)** ![Novo](https://img.shields.io/badge/Novo-brightgreen): Material de apoio teórico utilizado na aula, cobrindo os conceitos de Big Data, Conteinerização, DAGs e Dataflow.

*  **[Documentação e Treinamento Oficial (Nextflow)](https://training.nextflow.io/)**: Documentação completa e exercícios avançados.

*  **[nf-core: Repositório de Pipelines Validados](https://nf-co.re/)**: Catálogo de pipelines padrão-ouro para bioinformática.

---

##  Créditos e Licença

Este projeto é mantido por **[Mateus Falco](AUTHORS.md)**. O conteúdo está disponível sob a licença **[CC BY-NC 4.0](LICENSE.md)**, permitindo o uso e modificação para fins educacionais e científicos, desde que citada a fonte e sem finalidade comercial.

###  Agradecimentos

A ciência reprodutível é construída sobre ombros de gigantes. Agradecemos imensamente às comunidades que mantêm as ferramentas base deste minicurso:

* **[Nextflow](https://nextflow.io/) / [Seqera](https://seqera.io/)**: Pela revolução na orquestração de dados.
* **[nf-core](https://nf-co.re/)**: Pela curadoria e desenvolvimento do pipeline `ampliseq`.
* **[R Project](https://www.r-project.org/)**: Pelos pacotes `phyloseq` e `ggplot2`.
* **[Docker](https://www.docker.com/)** & **[Bioconda](https://bioconda.github.io/)**: Pelo ecossistema de containers.
