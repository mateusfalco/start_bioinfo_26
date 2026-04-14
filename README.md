# Start Bioinfo '26: Introdução Prática ao Nextflow

<div align="center">
  <img src="start_bioinfo_26_header.png" alt="Cena Panorâmica do Laboratório" width="100%" />
</div>

<br>

A bioinformática moderna exige reprodutibilidade, escalabilidade e controle rigoroso de cada etapa analítica. Neste minicurso, vamos explorar o ecossistema Nextflow e a transição do pensamento linear em scripts Bash para o paradigma de *Dataflow*.

Para que nosso foco seja inteiramente científico e prático, abstraímos a barreira da infraestrutura. O botão acima gera um ambiente virtual conteinerizado (Codespaces) configurado com todas as dependências (Java, Nextflow e Docker) necessárias para a aula.

**Facilitador:** Mateus Falco (Embaixador Nextflow, CTO Genobit).

<br>

<div align="center">
  <img src="https://github.com/codespaces/badge.svg" alt="Abrir no GitHub Codespaces" />
</div>

<br>

---

## Protocolo de Validação do Ambiente (Teste Rápido)

Para garantirmos que o seu ambiente subiu corretamente e que a orquestração está funcional, realizaremos três testes de complexidade crescente. Abra o terminal integrado na parte inferior da tela e siga os passos:

### Teste 1: Validação do Motor Nextflow
Certifique-se de que o sistema base está respondendo.
```bash
nextflow run hello
```
(Saída esperada: Uma mensagem de boas-vindas do Nextflow demonstrando o download e execução do script de teste).

### Teste 2: Execução do Pipeline Customizado (Local)

Vamos rodar o nosso código base que fará a leitura e transformação simples de um arquivo FASTA.

```bash
nextflow run main.nf
```

Validação do Cache: Execute exatamente o mesmo comando, adicionando a flag -resume. Observe que o Nextflow recuperará o estado anterior sem reprocessar os dados desnecessariamente.

### Teste 3: Simulação de Alta Complexidade (nf-core)

Para validar o motor Docker interno e a capacidade de integração em nuvem, rodaremos um teste rápido usando o pipeline padrão ouro para amplicon (16S). Este teste utiliza um dataset sintético minúsculo presente na pasta data/.

```bash
nextflow run nf-core/ampliseq \
    -profile docker \
    --input data/ \
    --outdir resultados \
    --FW_primer GTGYCAGCMGCCGCGGTAA \
    --RV_primer GGACTACNVGGGTWTCTAAT \
    --metadata samplesheet.tsv
```
(Saída esperada: O download dos containers do nf-core e a criação da pasta resultados/ com os arquivos finais de processamento).
Materiais de Apoio
Documentação e Treinamento Oficial (Nextflow)
nf-core: Repositório de Pipelines Validados
