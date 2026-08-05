# Tutorial — escrevendo sua monografia, dissertação ou tese do IDP com este template

Este guia é para **alunos do IDP** que vão escrever o trabalho de conclusão em
LaTeX e querem usar um assistente de IA de linha de comando — **Claude Code** ou
**Codex** — como copiloto de escrita.

Você não precisa saber LaTeX para começar. Precisa saber **escrever** e
**revisar** — o assistente cuida da marcação, e este template cuida da
formatação ABNT/IDP.

**Índice**

1. [Preparando o ambiente](#1-preparando-o-ambiente)
2. [Obtendo o template](#2-obtendo-o-template)
3. [Entendendo os arquivos](#3-entendendo-os-arquivos)
4. [Preencha seus dados](#4-preencha-seus-dados)
5. [Compilando pela primeira vez](#5-compilando-pela-primeira-vez)
6. [Escrevendo os capítulos](#6-escrevendo-os-capítulos)
7. [Citações e referências (ABNT)](#7-citações-e-referências-abnt)
8. [Figuras, tabelas, quadros e gráficos](#8-figuras-tabelas-quadros-e-gráficos)
9. [Usando o Claude Code ou o Codex](#9-usando-o-claude-code-ou-o-codex)
10. [Erros comuns e como resolver](#10-erros-comuns-e-como-resolver)
11. [Checklist ABNT antes de entregar](#11-checklist-abnt-antes-de-entregar)

---

## 1. Preparando o ambiente

Você precisa de três coisas: **Git**, uma **distribuição LaTeX** e o
**assistente de IA**.

### 1.1 Git

* **Windows**: baixe em <https://git-scm.com/download/win> (instale o *Git Bash* junto).
* **macOS**: `xcode-select --install`
* **Linux**: `sudo apt install git`

### 1.2 LaTeX

| Sistema | O que instalar | Comando |
|---|---|---|
| Windows | MiKTeX | `winget install --id MiKTeX.MiKTeX --scope user` |
| macOS | MacTeX | `brew install --cask mactex` |
| Linux | TeX Live | `sudo apt install texlive-full latexmk biber` |

No **MiKTeX**, deixe a instalação automática de pacotes ligada — assim os
pacotes que faltarem são baixados na primeira compilação:

```powershell
initexmf --set-config-value "[MPM]AutoInstall=1"
```

Confira se deu certo:

```bash
pdflatex --version
latexmk --version
biber --version
```

> **Alternativa sem instalar nada: Overleaf.**
> Crie uma conta em <https://overleaf.com>, use *New Project → Upload Project*
> e envie um `.zip` deste repositório. Depois, em *Menu → Settings*, escolha
> **Compiler: pdfLaTeX** e **TeX Live version: 2023 ou superior**.
> O Overleaf detecta o `biber` automaticamente. A desvantagem é que o Claude
> Code/Codex não roda dentro do Overleaf — você escreveria localmente e
> sincronizaria via Git.

### 1.3 O assistente de IA

* **Claude Code**: `npm install -g @anthropic-ai/claude-code`, depois `claude`
  dentro da pasta do projeto.
* **Codex**: `npm install -g @openai/codex`, depois `codex` dentro da pasta.

Ambos leem automaticamente o arquivo de instruções do projeto
(`CLAUDE.md` para o Claude Code, `AGENTS.md` para o Codex). Esses arquivos já
estão neste repositório e ensinam o assistente a respeitar as regras da ABNT e a
estrutura do template — **não os apague**.

---

## 2. Obtendo o template

No GitHub, clique em **“Use this template” → “Create a new repository”** para
criar o *seu* repositório (assim você tem histórico próprio e backup na nuvem).
Depois:

```bash
git clone https://github.com/SEU-USUARIO/minha-dissertacao.git
cd minha-dissertacao
```

Se preferir só baixar sem criar repositório:

```bash
git clone https://github.com/alexlopespereira/TemplateLatexIDP.git minha-dissertacao
cd minha-dissertacao
rm -rf .git && git init          # começa um histórico novo, seu
```

> **Por que usar Git?** Porque você vai escrever durante meses. Um `git commit`
> por sessão de escrita significa que nenhuma versão se perde e que você
> consegue voltar atrás quando o orientador mudar de ideia.

---

## 3. Entendendo os arquivos

Você vai mexer em **quatro lugares**, e só neles:

| Onde | O que colocar |
|---|---|
| `config/dados.tex` | seu nome, título, orientador, banca, palavras-chave |
| `capitulos/*.tex` | o texto do trabalho, um arquivo por capítulo |
| `pretextual/*.tex` | resumo, abstract, agradecimentos, dedicatória, siglas |
| `referencias.bib` | todas as obras que você citar |

**`idp.cls` é a formatação.** Não altere esse arquivo para "consertar" o visual
de um trecho — se algo está errado, é quase sempre no seu texto. Alterar a
classe é o jeito mais rápido de sair da norma sem perceber.

`main.tex` é apenas o índice do documento: ele diz em que ordem os pedaços
entram. Você só o edita para **adicionar ou remover um capítulo**.

---

## 4. Preencha seus dados

Abra `config/dados.tex` e preencha tudo:

```latex
\titulo{A eficácia horizontal dos direitos fundamentais}
\subtitulo{uma análise da jurisprudência do STF}

\autor{Maria Aparecida de Souza}
\autorficha{SOUZA, Maria Aparecida de}     % formato invertido, p/ a ficha

\orientador{Prof. Dr. João Carlos Pereira}
\coorientador{}                            % vazio se não houver

\curso{Direito}                            % graduação / especialização
\programa{Direito Constitucional}          % mestrado / doutorado
\local{Brasília-DF}
\data{2026}

\datadefesa{Brasília, 15 de dezembro de 2026.}

\membrobanca{Prof. Dr. João Carlos Pereira}{Orientador}
\membrobanca{Profa. Dra. Ana Lima}{Examinadora}
\membrobanca{Prof. Dr. Pedro Rocha}{Examinador}

\palavraschave{Direitos fundamentais. Eficácia horizontal. STF.}
\keywords{Fundamental rights. Horizontal effect. Brazilian Supreme Court.}
```

Depois, em `main.tex`, escolha o tipo de trabalho:

```latex
\documentclass[mestrado]{idp}    % bacharelado | especializacao | mestrado | doutorado
```

O texto da natureza do trabalho (“Dissertação apresentada ao programa de
pós-graduação em…”) é gerado automaticamente a partir dessa opção.

### A ficha catalográfica

A ficha oficial é elaborada **pela Biblioteca Ministro Moreira Alves**. Solicite
pelo e-mail **biblioteca@idp.edu.br** e, quando receber, transcreva os dados em
`config/dados.tex` (`\cutter`, `\numeropaginas`, `\cdd`, `\assuntos`).

---

## 5. Compilando pela primeira vez

```bash
latexmk -pdf main.tex
```

Abra o `main.pdf` gerado. Na primeira execução o MiKTeX pode baixar pacotes —
isso demora alguns minutos, mas acontece só uma vez.

Comandos úteis:

```bash
latexmk -pdf -pvc main.tex   # recompila sozinho a cada vez que você salva
latexmk -c                   # apaga arquivos auxiliares (.aux, .log…)
latexmk -C                   # apaga tudo, inclusive o PDF
```

> Se `latexmk` não existir no seu PATH, use a sequência manual:
> `pdflatex main` → `biber main` → `pdflatex main` → `pdflatex main`.
> São quatro passos porque o sumário, as listas e as referências precisam de
> duas passadas para "assentar".

---

## 6. Escrevendo os capítulos

Cada arquivo em `capitulos/` começa com um `\section{}` — que é a **seção
primária** da ABNT (o que a maioria das pessoas chama de "capítulo").

```latex
\section{Referencial teórico}          % vira "2 REFERENCIAL TEÓRICO"

Texto introdutório do capítulo, com pelo menos um parágrafo antes da primeira
subseção — a ABNT exige isso.

\subsection{Eficácia horizontal: origem do conceito}    % vira "2.1 ..."

Texto da subseção.

\subsubsection{A doutrina alemã da Drittwirkung}        % vira "2.1.1 ..."

Texto.
```

Regras que o template já aplica sozinho:

* a numeração (`2`, `2.1`, `2.1.1`) é automática — **nunca digite os números**;
* a caixa alta e o negrito das seções primárias são automáticos — escreva
  `\section{Referencial teórico}` em caixa normal;
* cada seção primária começa em folha nova;
* o sumário é gerado a partir desses comandos.

### Adicionando um capítulo novo

1. Crie `capitulos/06-meu-capitulo.tex`.
2. Acrescente a linha em `main.tex`, na ordem certa:
   `\input{capitulos/06-meu-capitulo}`.

### Listas

```latex
\begin{itemize}
  \item primeiro item;
  \item segundo item.
\end{itemize}

\begin{enumerate}
  \item primeiro item;
  \item segundo item.
\end{enumerate}
```

### Caracteres que precisam de cuidado

`% $ & # _ { } ~ ^ \` têm significado especial em LaTeX. Para escrevê-los
literalmente, use `\%`, `\$`, `\&`, `\#`, `\_`, `\{`, `\}`.
O caso que mais pega gente desprevenida é o **`%`**: tudo o que vem depois dele
na linha vira comentário e simplesmente **não aparece no PDF**.

Aspas em português: use `` ``texto'' `` (duas crases e dois apóstrofos), que
produz “texto”.

---

## 7. Citações e referências (ABNT)

O fluxo é sempre o mesmo: **a obra entra no `referencias.bib` uma vez** e depois
você a chama pela *chave* quantas vezes quiser. As referências que aparecem no
final do trabalho são geradas automaticamente, em ordem alfabética, apenas com
o que foi efetivamente citado — exatamente como manda a NBR 6023.

### 7.1 Cadastrando uma obra

Abra `referencias.bib` e acrescente:

```bibtex
@book{silva2020,
  author    = {Silva, José Afonso da},
  title     = {Curso de direito constitucional positivo},
  edition   = {43},
  location  = {São Paulo},
  publisher = {Malheiros},
  year      = {2020},
}
```

A palavra logo após `{` (`silva2020`) é a **chave**. Use um padrão:
sobrenome + ano.

O arquivo já traz modelos comentados de `@book`, `@article`, `@incollection`,
`@thesis`, `@inproceedings`, `@online` e `@legislation` (leis e jurisprudência).
Copie o modelo mais próximo e edite.

### 7.2 Citando no texto

| Você quer | Escreva | Sai assim |
|---|---|---|
| Autor dentro dos parênteses | `\parencite{silva2020}` | (SILVA, 2020) |
| Autor com página | `\parencite[p.~45]{silva2020}` | (SILVA, 2020, p. 45) |
| Autor como sujeito da frase | `\citeonline{silva2020}` | Silva (2020) |
| Autor como sujeito, com página | `\citeonline[p.~45]{silva2020}` | Silva (2020, p. 45) |

**Citação direta curta (até 3 linhas)** — entre aspas, no corpo do parágrafo:

```latex
Segundo \citeonline[p.~45]{silva2020}, a norma é ``o resultado da interpretação''.
```

**Citação direta longa (mais de 3 linhas)** — use o ambiente `citacao`, que já
aplica recuo de 4 cm, corpo 10, entrelinha simples e ausência de aspas:

```latex
\begin{citacao}
Texto transcrito literalmente, sem aspas, com mais de três linhas de extensão,
exatamente como aparece na obra consultada. \parencite[p.~181]{silva2020}
\end{citacao}
```

**Citação indireta** — você resume a ideia com suas palavras e credita:

```latex
Para \citeonline{silva2020}, a interpretação constitucional é atividade criativa.
```

### 7.3 A regra que mais reprova trabalho

**Nunca cite uma obra que você não leu, e nunca deixe de citar uma que usou.**
Se o assistente de IA sugerir uma referência, **verifique se ela existe** antes
de aceitar (veja a [seção 9](#9-usando-o-claude-code-ou-o-codex)).

---

## 8. Figuras, tabelas, quadros e gráficos

O padrão ABNT é: **legenda acima**, elemento no meio, **fonte abaixo**. O
template faz isso automaticamente — você só precisa escrever na ordem certa.

Coloque suas imagens em `figuras/`.

```latex
\begin{figure}[htb]
  \caption{Organograma do Poder Judiciário}
  \label{fig:organograma}
  \centering
  \includegraphics[width=0.8\textwidth]{figuras/organograma.png}
  \fonte{Brasil (2023).}
\end{figure}
```

Trocando `figure` por `table`, `quadro` ou `grafico` você obtém, respectivamente,
uma tabela, um quadro ou um gráfico — cada um com sua própria numeração e sua
própria lista pré-textual.

```latex
\begin{table}[htb]
  \caption{Distribuição dos acórdãos por ano}
  \label{tab:acordaos}
  \centering
  \begin{tabular}{lrr}
    \toprule
    \textbf{Ano} & \textbf{Acórdãos} & \textbf{\%} \\
    \midrule
    2021 & 120 & 40,0 \\
    2022 &  90 & 30,0 \\
    \bottomrule
  \end{tabular}
  \fonte{Elaborada pela autora (2026).}
\end{table}
```

**Toda ilustração precisa ser citada no texto** antes de aparecer:

```latex
A Figura~\ref{fig:organograma} mostra... A Tabela~\ref{tab:acordaos} indica...
```

O `~` é um espaço que não quebra linha — evita que "Figura" fique numa linha e
"1" na seguinte.

Se você não usar quadros ou gráficos, apague as linhas `\listaquadros` e
`\listagraficos` de `main.tex`.

---

## 9. Usando o Claude Code ou o Codex

Esta é a parte que muda o seu ritmo de trabalho. A ideia **não** é pedir "escreva
minha dissertação" — isso produz texto genérico, sem sua voz, com referências
inventadas, e é desonestidade acadêmica. A ideia é usar o assistente como um
**redator técnico e revisor incansável** que trabalha a partir do material que
**você** produziu.

### 9.1 Começando

Na pasta do projeto:

```bash
claude          # Claude Code
# ou
codex           # Codex
```

O assistente lê o `CLAUDE.md` / `AGENTS.md` deste repositório e já sabe:
a estrutura de pastas, quais comandos usar para compilar, as regras da ABNT que
o template aplica e o que ele **não** deve fazer (inventar referências, alterar
`idp.cls`, mudar a numeração manualmente).

### 9.2 O ciclo de trabalho que funciona

```
   Você escreve/fornece o conteúdo bruto
              ↓
   Pede ao assistente para estruturar em LaTeX
              ↓
   Pede para compilar e corrigir erros
              ↓
   VOCÊ lê o PDF e revisa o conteúdo
              ↓
   git commit
```

Trabalhe **um capítulo por vez** e **uma seção por vez**. Sessões longas com
muitos arquivos abertos produzem resultado pior do que pedidos pequenos e
específicos.

### 9.3 Prompts que funcionam bem

**Estruturar material bruto que você já escreveu:**

> Tenho estas anotações sobre a evolução jurisprudencial da eficácia horizontal
> [cole ou aponte o arquivo]. Estruture em `capitulos/02-referencial-teorico.tex`
> usando `\subsection` e `\subsubsection`. Mantenha exatamente as minhas
> afirmações e a minha argumentação — não acrescente conteúdo novo nem
> referências que eu não citei. Onde faltar uma referência, insira o comentário
> `% TODO: referência`.

**Cadastrar referências a partir dos dados que você tem em mãos:**

> Adicione ao `referencias.bib` estas obras, que estão na minha bibliografia
> [cole os dados completos: autor, título, editora, local, ano]. Use o tipo
> BibTeX adequado a cada uma e chaves no padrão sobrenome+ano. Depois, no
> capítulo 2, substitua os marcadores `% TODO: referência` pelas chamadas
> `\citeonline{}` ou `\parencite{}` correspondentes.

**Compilar e corrigir:**

> Compile com `latexmk -pdf main.tex`, leia o log e corrija os erros de LaTeX.
> Não altere o conteúdo do texto nem o `idp.cls` — corrija apenas a marcação.
> No final, me diga em uma frase o que estava errado.

**Revisão de forma (sem mexer no conteúdo):**

> Revise `capitulos/03-procedimentos-metodologicos.tex` procurando: citações
> diretas longas que deveriam usar o ambiente `citacao`; figuras sem `\fonte{}`;
> ilustrações que não são citadas no texto; `\ref{}` quebrados. Liste o que
> encontrou antes de alterar qualquer coisa.

**Verificar consistência bibliográfica:**

> Compare as chaves citadas nos arquivos de `capitulos/` com as entradas de
> `referencias.bib`. Liste (a) obras citadas que não existem no `.bib` e
> (b) entradas do `.bib` que nunca são citadas.

**Revisão de texto (português):**

> Revise a redação de `capitulos/01-introducao.tex`: concordância, regência,
> pontuação e clareza. Preserve o meu vocabulário e a minha linha de
> argumentação. Não reescreva parágrafos inteiros — proponha correções
> pontuais e me mostre um diff.

### 9.4 Regras de segurança — leia com atenção

| ⚠️ Regra | Por quê |
|---|---|
| **Nunca aceite uma referência bibliográfica sem verificar** | Modelos de linguagem produzem citações plausíveis e inexistentes. Confira cada obra no catálogo da biblioteca, no Google Scholar ou no site da editora **antes** de deixá-la no `.bib`. Uma referência falsa numa banca é fatal. |
| **Nunca peça "escreva o capítulo X sobre o tema Y"** | O resultado é texto genérico e sem fonte, que sua banca reconhece de longe — e que configura fraude acadêmica. |
| **Você é o autor** | Leia cada parágrafo do PDF final. Se você não consegue defender uma frase, ela não pode ficar. |
| **Não deixe o assistente alterar `idp.cls`** | É o que garante a conformidade com a norma. Se algo parece errado no layout, abra uma *issue* no repositório do template. |
| **Consulte as regras do seu programa** | Alguns cursos do IDP têm exigências adicionais. Este template atende ao modelo geral da Biblioteca. |
| **Faça `git commit` com frequência** | Assim você sempre consegue desfazer uma alteração automática que não gostou. |

### 9.5 Um comando que vale ouro

Peça ao assistente para conferir o resultado contra o modelo oficial, que está
no próprio repositório:

> Compare visualmente o `main.pdf` gerado com o `templateMonografia_ou_TCC.pdf`
> (margens, fontes, entrelinhas, posição do número de página) e me diga se
> encontrou alguma divergência de formatação.

---

## 10. Erros comuns e como resolver

| Sintoma | Causa provável | Solução |
|---|---|---|
| `Undefined control sequence` | comando digitado errado ou pacote faltando | veja a linha indicada no log; confira a grafia |
| Citação aparece como `[silva2020]` ou em negrito estranho | a chave não existe no `.bib`, ou o `biber` não rodou | rode `latexmk -pdf main.tex` de novo (ele chama o `biber` sozinho) |
| Sumário desatualizado | falta uma passada de compilação | `latexmk` resolve; manualmente, compile 2× |
| `Missing $ inserted` | um `_`, `^`, `&` ou `%` solto no texto | escape-o: `\_`, `\^{}`, `\&`, `\%` |
| Figura não aparece | caminho ou extensão errados | confira que o arquivo está em `figuras/` e o nome bate (maiúsculas contam) |
| `File 'xxx.sty' not found` | pacote não instalado | MiKTeX baixa sozinho; no TeX Live, `sudo tlmgr install xxx` |
| Texto sumiu do PDF | um `%` no meio da linha | escreva `\%` quando quiser o símbolo por cento |
| Tudo parou de compilar depois de uma alteração | erro estrutural (chave `}` faltando) | `git diff` para ver o que mudou; `git checkout -- arquivo.tex` para desfazer |

Se travar de vez: apague os auxiliares e recomece do zero.

```bash
latexmk -C && latexmk -pdf main.tex
```

---

## 11. Checklist ABNT antes de entregar

**Formatação** *(o template já garante — confira mesmo assim)*

- [ ] A4, margens 3/2/3/2 cm
- [ ] Times New Roman 12, entrelinhas 1,5
- [ ] Recuo de parágrafo 1,25 cm
- [ ] Numeração no canto superior direito, começando a aparecer na introdução
- [ ] Citações longas com recuo de 4 cm, corpo 10, entrelinha simples

**Conteúdo**

- [ ] Capa, folha de rosto, ficha catalográfica e folha de aprovação preenchidas
- [ ] Ficha catalográfica **oficial**, solicitada em biblioteca@idp.edu.br
- [ ] Resumo entre 150 e 500 palavras, parágrafo único, com palavras-chave
- [ ] *Abstract* fiel ao resumo, com *keywords*
- [ ] Sumário conferindo com os títulos e as páginas do texto
- [ ] Introdução com tema, problema, hipótese, objetivos e justificativa
- [ ] Considerações finais respondendo à pergunta da introdução

**Referências e citações**

- [ ] Toda citação do texto tem entrada correspondente nas referências
- [ ] Toda referência listada é efetivamente citada no texto
- [ ] **Todas as obras foram verificadas e existem de verdade**
- [ ] Citações diretas com autor, ano **e página**
- [ ] Referências em ordem alfabética, entrelinha simples, alinhadas à esquerda

**Ilustrações**

- [ ] Toda ilustração é citada no texto antes de aparecer
- [ ] Toda ilustração tem legenda acima e **Fonte:** abaixo
- [ ] As listas pré-textuais batem com o que existe no trabalho

**Último passo**

- [ ] Leia o PDF inteiro, do começo ao fim, em uma sentada só.

---

## Precisa de ajuda?

* Formatação e normas: **biblioteca@idp.edu.br**
* Conteúdo e método: seu orientador
* Problemas com o template: abra uma *issue* em
  <https://github.com/alexlopespereira/TemplateLatexIDP/issues>

Bom trabalho! 🎓
