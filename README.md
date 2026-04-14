# 🧬 Start Bioinfo '26: Introdução Prática ao Nextflow

Orquestrar análises de dados biológicos não é muito diferente de sentar na bateria e ditar o ritmo de uma música: cada batida precisa estar perfeitamente sincronizada, ser reprodutível e acontecer no tempo exato. 

Bem-vindos ao minicurso prático de Nextflow! Este ambiente foi cuidadosamente preparado para que você não perca um único minuto instalando softwares. Tudo o que você precisa já está configurado nas nuvens.

**Facilitador:** Mateus Falco (Embaixador Nextflow, CTO na Genobit).

---

## Como usar este ambiente?

Nós vamos utilizar o **GitHub Codespaces**. Ele é basicamente um computador virtual completo que roda direto no seu navegador, já equipado com Java, Nextflow e Docker.

### Passo 1: Ligando os motores
1. Clique no botão verde **`<> Code`** no topo desta página.
2. Selecione a aba **`Codespaces`**.
3. Clique em **`Create codespace on main`**.
4. Aguarde cerca de 1 a 2 minutos. O GitHub vai preparar o ambiente, baixar as ferramentas e abrir uma tela idêntica ao *VS Code* diretamente no seu navegador.

---

## O que faremos na prática?

Quando o seu ambiente carregar, você verá um **Terminal** na parte inferior da tela. É lá que a mágica acontece.

### Parte 1: O "Hello World" da Bioinformática
Para garantir que o seu motor Nextflow está funcionando, digite no terminal e aperte `Enter`:
```bash
nextflow run hello
```

Se você viu uma mensagem de boas-vindas do Nextflow, parabéns! Seu ambiente está 100% pronto.


### Parte 2: O Nosso Primeiro Pipeline Customizado

Durante a aula, vamos construir do zero um mini-pipeline para manipulação e contagem de sequências FASTA. O arquivo base main.nf já está aqui no repositório.

Para rodá-lo (conforme formos preenchendo o código na aula), você usará:

```bash
nextflow run main.nf
```

* Dica de Ouro: Quer ver o poder do cache do Nextflow? Tente rodar o comando acima adicionando -resume no final. Ele só vai processar o que for novidade!


## >> Rodando um Pipeline Padrão-Ouro (nf-core) <<

Para encerrar o curso, vamos simular o mundo real. Você vai executar o nf-core/ampliseq, um pipeline profissional e validado mundialmente para análise de microbioma (16S).

Nós deixamos arquivos de dados sintéticos (minúsculos) na pasta data/ apenas para validação.

Execute o comando abaixo no seu terminal para acionar o poder dos containers Docker orquestrados pelo Nextflow:

```bash
nextflow run nf-core/ampliseq \
    -profile docker \
    --input data/ \
    --outdir resultados \
    --FW_primer GTGYCAGCMGCCGCGGTAA \
    --RV_primer GGACTACNVGGGTWTCTAAT \
    --metadata data/metadata.tsv
```

### Onde estão meus resultados?

A "Caixa de Areia": Durante a execução, o Nextflow joga tudo em diretórios temporários dentro da pasta oculta work/.

A Vitrine: Os arquivos finais, relatórios e tabelas que importam para a sua pesquisa serão publicados de forma organizada na pasta resultados/ (que será criada automaticamente).

### Onde aprender mais?

 Nextflow Training Oficial

 Catálogo de Pipelines do nf-core

 Comunidade no Slack

Boa aula e bem-vindos à era da reprodutibilidade genômica!
