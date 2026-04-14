<div align="center">

# Start Bioinfo '26
*Introdução ao Nextflow*

<img src="img/start_bioinfo_26_header.png" alt="Start Bioinfo 26 Logo"/>

</div>

<br>

A bioinformática moderna exige reprodutibilidade, escalabilidade e controle rigoroso de cada etapa analítica. Neste minicurso, vamos explorar o ecossistema Nextflow e a transição do pensamento linear em scripts Bash para o paradigma de *Dataflow*.

<br>

<div align="center">
  <a href="https://codespaces.new/mateusfalco/start_bioinfo_26">
    <img src="https://github.com/codespaces/badge.svg" alt="Open in GitHub Codespaces" height="40" />
  </a>
  <p><i>Clique no botão acima para iniciar o ambiente de prática.</i></p>
</div>

<br>

Para que nosso foco seja inteiramente científico e prático, abstraímos a barreira da infraestrutura. O ambiente virtual gerado pelo Codespaces já vem configurado com todas as dependências (Java, Nextflow e Docker) necessárias para a aula.

Facilitador:* Mateus Falco* (Embaixador Nextflow, CEO/CTO Genobit).
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

* Validação do Cache: Execute exatamente o mesmo comando, adicionando a flag -resume. Observe que o Nextflow recuperará o estado anterior sem reprocessar os dados desnecessariamente.

```bash
nextflow run main.nf -resume
```

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
### Materiais de Apoio
[Documentação e Treinamento Oficial (Nextflow)](https://training.nextflow.io/): Documentação completa e exercícios avançados.

[nf-core: Repositório de Pipelines Validados](https://nf-co.re/): Catálogo de pipelines padrão ouro para bioinformática.
	
