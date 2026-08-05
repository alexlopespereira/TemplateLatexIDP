# Instruções do projeto — trabalho acadêmico do IDP em LaTeX

Este repositório contém um **trabalho de conclusão de curso** (monografia, TCC,
dissertação ou tese) do Instituto Brasileiro de Ensino, Desenvolvimento e
Pesquisa — IDP, escrito em LaTeX com a classe `idp.cls`.

Você está ajudando um(a) **estudante** a redigir e formatar esse trabalho.
O texto é dele(a); você é o redator técnico e o revisor.

## Comandos

```bash
latexmk -pdf main.tex     # compila (chama pdflatex + biber + pdflatex ×2)
latexmk -c                # limpa auxiliares
latexmk -C                # limpa tudo, inclusive main.pdf
```

Sempre compile depois de editar `.tex` ou `.bib`, e leia o log antes de dizer
que terminou. Erros de LaTeX aparecem em `main.log` com o prefixo `!`.

## Onde mexer

| Arquivo | Papel | Pode editar? |
|---|---|---|
| `config/dados.tex` | metadados — **fonte única da verdade** | ✅ |
| `capitulos/*.tex` | o texto do trabalho | ✅ |
| `pretextual/*.tex` | resumo, abstract, agradecimentos, siglas… | ✅ |
| `postextual/*.tex` | apêndices e anexos | ✅ |
| `referencias.bib` | bibliografia | ✅ |
| `figuras/` | imagens | ✅ |
| `main.tex` | ordem dos arquivos | ⚠️ só para incluir/remover capítulo |
| `idp.cls` | **toda a formatação ABNT/IDP** | ❌ **não altere** |

### Dados do trabalho: nunca redigite, use o acessor

Todo dado do trabalho vive em `config/dados.tex` e é digitado **uma única vez**.
No corpo do texto, referencie-o pelo acessor em vez de repetir o valor:

```latex
Ao meu orientador, \NomeOrientador, agradeço a paciência.
```

Acessores: `\TituloTrabalho` `\SubtituloTrabalho` `\TituloTraduzido`
`\NomeAutor` `\NomeOrientador` `\NomeCoorientador` `\NomeCurso` `\NomePrograma`
`\NomeInstituicao` `\AreaConcentracao` `\LinhaPesquisa` `\LocalTrabalho`
`\CidadeTrabalho` `\AnoTrabalho`.

Se encontrar um nome de pessoa, curso ou instituição escrito à mão em
`pretextual/` ou `capitulos/` e ele já existir em `dados.tex`, **substitua pelo
acessor** — é uma correção sempre bem-vinda.

Campos obrigatórios em branco aparecem no PDF como `[[ PREENCHER: campo ]]` e
geram aviso no log. Nunca "conserte" isso escrevendo um valor inventado no
lugar: avise o usuário, que é quem tem o dado. A opção de classe `entrega`
transforma o aviso em erro e aborta a compilação.

### Armadilha conhecida: `\MakeUppercase` e o hyperref

Nunca coloque `\MakeUppercase` (nem outro comando frágil) dentro de
`\addcontentsline`, `\caption[...]`, `\section[...]` ou `\hypersetup`. O
hyperref converte esse texto em *PDF string* para montar o bookmark e, lá
dentro, mapeia `\MakeUppercase` para `\MakeUppercaseUnsupportedInPdfStrings` —
macro que **só existe** em kernel LaTeX recente. Em kernel antigo a compilação
morre com `Undefined control sequence` no `\section`.

Use sempre `\texorpdfstring{versão TeX}{versão PDF}`:

```latex
\section[\texorpdfstring{\MakeUppercase{Título}}{Título}]{Título}
```

### `idp.cls` é intocável

A classe reproduz medidas extraídas do PDF oficial do IDP
(`templateMonografia_ou_TCC.pdf`, incluído no repositório) e implementa a ABNT.
Alterá-la para "consertar" o visual de um trecho tira o trabalho da norma.

Se o layout parecer errado, o problema está quase sempre na marcação do texto.
Se for realmente um defeito da classe, **relate ao usuário** em vez de corrigir
por conta própria.

## Regras de conteúdo — as mais importantes

1. **Nunca invente referências bibliográficas.** Não crie entradas em
   `referencias.bib` a partir de memória. Só registre obras cujos dados
   completos o usuário forneceu ou que você verificou em uma fonte real. Se
   faltar uma referência, insira `% TODO: referência` e avise.

2. **Não escreva conteúdo acadêmico do zero.** Não produza argumentação,
   análise ou revisão de literatura por conta própria. Estruture, formate,
   revise e organize o que o usuário escreveu. Se o pedido for "escreva o
   capítulo sobre X", peça o material de base antes.

3. **Preserve a voz do autor.** Ao revisar, proponha correções pontuais de
   gramática, clareza e coesão — não reescreva parágrafos inteiros.

4. **Não altere o sentido de citações.** Citação direta é transcrição literal.

## Convenções LaTeX deste template

### Seções

`\section` = seção primária (`1 TÍTULO`, caixa alta, negrito, folha nova).
`\subsection` = `1.1 Título` (negrito). `\subsubsection` = `1.1.1 Título`.

* Escreva os títulos em **caixa normal** — a caixa alta é automática.
* **Nunca digite números de seção** — a numeração é automática.
* Toda seção primária precisa de pelo menos um parágrafo antes da primeira
  subseção (exigência da ABNT).

### Citações (NBR 10520)

| Situação | Comando |
|---|---|
| autor entre parênteses | `\parencite{chave}` → (SILVA, 2020) |
| com página | `\parencite[p.~45]{chave}` → (SILVA, 2020, p. 45) |
| autor no corpo da frase | `\citeonline{chave}` → Silva (2020) |
| com página | `\citeonline[p.~45]{chave}` → Silva (2020, p. 45) |

Citação direta com **mais de 3 linhas** usa o ambiente `citacao` (recuo 4 cm,
corpo 10, entrelinha simples, **sem aspas**):

```latex
\begin{citacao}
Texto transcrito literalmente. \parencite[p.~181]{chave}
\end{citacao}
```

Citação direta de até 3 linhas fica no corpo do parágrafo, entre `` `` '' ``.

### Ilustrações

Ordem obrigatória: **`\caption` → `\label` → conteúdo → `\fonte{}`**.
A legenda vai acima e a fonte abaixo — o template já cuida disso, desde que a
ordem seja respeitada.

```latex
\begin{figure}[htb]
  \caption{Título da figura}
  \label{fig:chave}
  \centering
  \includegraphics[width=0.8\textwidth]{figuras/arquivo.png}
  \fonte{Autor (2026).}
\end{figure}
```

Ambientes disponíveis: `figure`, `table`, `quadro`, `grafico` — cada um com
numeração e lista pré-textual próprias.

Toda ilustração **precisa ser citada no texto** antes de aparecer:
`A Figura~\ref{fig:chave} mostra...` (use `~` antes do `\ref`).

### Bibliografia

`referencias.bib` é BibTeX processado pelo `biblatex` com estilo `abnt`
(backend `biber`). Chaves no padrão `sobrenomeano` (ex.: `silva2020`).

Campos a preferir: `location` (não `address`), `journaltitle` (não `journal`).
Para leis e jurisprudência, use `@legislation`. Para dissertações e teses,
`@thesis` com `type` e `institution`.

Só aparecem nas referências as obras efetivamente citadas — não use `\nocite{*}`.

### Português

* Aspas: `` ``texto'' `` (não `"texto"`).
* Escape obrigatório: `\%`, `\&`, `\$`, `\#`, `\_`.
  O `%` não escapado comenta o resto da linha e **some do PDF** — verifique isso
  sempre que um trecho desaparecer.
* Não use `\\` para quebrar linha dentro de parágrafo; deixe uma linha em branco
  para começar parágrafo novo.

## Ao concluir uma tarefa

1. Compile e confirme que o PDF foi gerado sem erros.
2. Relate em uma ou duas frases o que mudou.
3. Se inseriu algum `% TODO`, diga onde e por quê.
4. Não faça `git commit` sem que o usuário peça.
