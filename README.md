# TemplateLatexIDP

Template LaTeX para **monografias, TCCs, dissertações e teses** do
**Instituto Brasileiro de Ensino, Desenvolvimento e Pesquisa — IDP**.

Reproduz a formatação do arquivo oficial
[`templateMonografia_ou_TCC.pdf`](https://www.idp.edu.br/arquivos/biblioteca/templateMonografia_ou_TCC.pdf)
(Biblioteca Ministro Moreira Alves) e implementa as normas da ABNT para
referências e citações.

> 📘 **É a sua primeira vez?** Leia o **[TUTORIAL.md](TUTORIAL.md)** — ele explica
> o passo a passo, inclusive como escrever a dissertação com o apoio do
> **Claude Code** ou do **Codex**.

---

## O que já está pronto

| Elemento | Situação |
|---|---|
| Capa com logo do IDP | ✅ |
| Folha de rosto | ✅ |
| Ficha catalográfica | ✅ |
| Folha de aprovação (banca) | ✅ |
| Dedicatória, agradecimentos, epígrafe | ✅ |
| Resumo e *abstract* (NBR 6028) | ✅ |
| Listas de ilustrações, tabelas, quadros, gráficos e siglas | ✅ (automáticas) |
| Sumário (NBR 6027) | ✅ (automático) |
| Numeração progressiva das seções (NBR 6024) | ✅ |
| Citações diretas e indiretas (NBR 10520) | ✅ |
| Referências (NBR 6023) via `biblatex-abnt` | ✅ |
| Apêndices e anexos | ✅ |

## Formatação implementada

Todos os valores abaixo foram **medidos no PDF oficial do IDP** e reproduzidos
na classe `idp.cls`:

| Item | Valor |
|---|---|
| Papel | A4 (210 × 297 mm) |
| Margens | esquerda 3 cm · direita 2 cm · superior 3 cm · inferior 2 cm |
| Fonte | Times New Roman 12 (via `newtx`, metricamente idêntica) |
| Entrelinhas | 1,5 no texto; simples em resumo, citações longas, notas e referências |
| Recuo de parágrafo | 1,25 cm |
| Numeração de páginas | canto superior direito, a 2 cm da borda; contagem começa na folha de rosto e só aparece a partir da introdução |
| Seção primária | `1 TÍTULO` — caixa alta + negrito, em folha nova |
| Seção secundária | `1.1 Título` — negrito |
| Seção terciária | `1.1.1 Título` — sem destaque |
| Citação longa (> 3 linhas) | recuo 4 cm, corpo 10, entrelinha simples, sem aspas |
| Notas de rodapé | corpo 10, entrelinha simples |
| Legendas e “Fonte:” | corpo 10, centralizadas; legenda **acima**, fonte **abaixo** |

## Estrutura do repositório

```
TemplateLatexIDP/
├── idp.cls                 ← a classe LaTeX (o coração do template)
├── main.tex                ← documento principal: só inclui os outros arquivos
├── referencias.bib         ← sua bibliografia (formato BibTeX)
├── config/
│   └── dados.tex           ← autor, título, orientador, banca, palavras-chave…
├── pretextual/
│   ├── dedicatoria.tex     agradecimentos.tex   epigrafe.tex
│   └── resumo.tex          abstract.tex         siglas.tex
├── capitulos/
│   ├── 01-introducao.tex
│   ├── 02-referencial-teorico.tex
│   ├── 03-procedimentos-metodologicos.tex
│   ├── 04-analise-e-discussao.tex
│   └── 05-consideracoes-finais.tex
├── postextual/
│   ├── apendices.tex
│   └── anexos.tex
├── figuras/                ← suas imagens (+ logo do IDP)
├── CLAUDE.md / AGENTS.md   ← instruções para o Claude Code / Codex
├── TUTORIAL.md             ← guia completo para o aluno
└── templateMonografia_ou_TCC.pdf   ← PDF oficial, para conferência
```

## Como compilar

```bash
latexmk -pdf main.tex      # gera main.pdf
latexmk -c                 # limpa arquivos auxiliares
```

Requer uma distribuição LaTeX (MiKTeX, TeX Live ou MacTeX) com `biber`.
Veja a instalação passo a passo no [TUTORIAL.md](TUTORIAL.md#1-preparando-o-ambiente).

## Escolhendo o tipo de trabalho

A opção da classe em `main.tex` define automaticamente o texto da natureza do
trabalho na folha de rosto e na folha de aprovação:

```latex
\documentclass[bacharelado]{idp}     % monografia / TCC de graduação
\documentclass[especializacao]{idp}  % pós-graduação lato sensu
\documentclass[mestrado]{idp}        % dissertação
\documentclass[doutorado]{idp}       % tese
```

Outras opções combináveis:

| Opção | Efeito |
|---|---|
| `secaonovapagina` | *(padrão)* cada seção primária começa em folha nova |
| `secaocontinua` | seções primárias seguem na mesma página |
| `semlinks` | *(padrão)* hiperlinks sem cor, adequados para impressão |
| `links` | hiperlinks coloridos, úteis na versão digital |
| `rascunho` | marca d'água “RASCUNHO” |
| `refautorrepetido` | repete o nome do autor nas referências, em vez do travessão |
| `entrega` | aborta a compilação se algum campo obrigatório estiver em branco |

## Os dados do trabalho

`config/dados.tex` é a **fonte única da verdade**: cada dado é digitado uma vez
e alimenta capa, folha de rosto, ficha catalográfica, folha de aprovação e os
metadados do PDF.

```latex
\titulo{A eficácia horizontal dos direitos fundamentais}
\subtitulo{uma análise da jurisprudência do STF}
\autor{Maria Aparecida de Souza}
\autorficha{SOUZA, Maria Aparecida de}
\orientador{Prof. Dr. João Carlos Pereira}
\programa{Direito Constitucional}
\area{Direitos Fundamentais}
\linhapesquisa{Jurisdição constitucional}
\cidade{Brasília}
\datadefesa{15 de dezembro de 2026}          % só a data; a cidade vem de \cidade
\membrobanca[UnB]{Prof. Dr. Pedro Rocha}{Examinador}   % instituição é opcional
```

Campos disponíveis: `\titulo` `\subtitulo` `\titulotraduzido` `\autor`
`\autorficha` `\orientador` `\coorientador` `\curso` `\programa` `\area`
`\linhapesquisa` `\cidade` `\local` `\data` `\datadefesa` `\datadefesacompleta`
`\membrobanca` `\palavraschave` `\keywords` `\cutter` `\numeropaginas` `\cdd`
`\assuntos` `\tipotrabalho` `\preambulo` `\instituicao` `\logo` `\semlogo`.

### Reaproveite os dados no texto

Em vez de redigitar um nome no corpo do trabalho, use o acessor — o texto
acompanha qualquer mudança em `dados.tex`:

```latex
Ao meu orientador, \NomeOrientador, agradeço a paciência e o rigor.
```

`\TituloTrabalho` `\SubtituloTrabalho` `\TituloTraduzido` `\NomeAutor`
`\NomeOrientador` `\NomeCoorientador` `\NomeCurso` `\NomePrograma`
`\NomeInstituicao` `\AreaConcentracao` `\LinhaPesquisa` `\LocalTrabalho`
`\CidadeTrabalho` `\AnoTrabalho`.

### Nada de `XXXX` na versão entregue

Campo obrigatório em branco aparece no PDF como `[[ PREENCHER: cdd ]]` e gera
aviso nomeando o campo. Na versão final, compile com a opção `entrega`: o aviso
vira erro e **nenhum PDF é gerado** enquanto houver pendência.

```latex
\documentclass[mestrado,entrega]{idp}
```

## Licença

Os arquivos da classe estão sob [LPPL 1.3c](LICENSE); o conteúdo de exemplo é
de domínio público. O PDF oficial do IDP e o logotipo pertencem ao IDP e estão
incluídos apenas para referência e uso pelos seus alunos.
