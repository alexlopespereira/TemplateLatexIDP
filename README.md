# TemplateLatexIDP

Template LaTeX para **monografias, TCCs, dissertações e teses** da
**Universidade IDP**.

Segue obrigatoriamente o **template institucional Word de 2026**, da Biblioteca
Ministro Moreira Alves. **O template prevalece nas divergências; o manual é
complementar**, aplicado apenas aos pontos que o template não define. A
denominação Universidade IDP e o logotipo fornecido foram mantidos.

A orientação da Biblioteca IDP de **12/11/2026** prevalece nos pontos revistos no
[quadro de atendimento](docs/ajustes-biblioteca-2026-11-12.md).

> 📘 **É a sua primeira vez?** Leia o **[TUTORIAL.md](TUTORIAL.md)** — ele explica
> o passo a passo, inclusive como escrever a dissertação com o apoio do
> **Claude Code** ou do **Codex**.

---

## O que já está pronto

| Elemento | Situação |
|---|---|
| Capa com logo do IDP | ✅ |
| Folha de rosto | ✅ |
| Inserção do PDF oficial da ficha; orientação para solicitação quando ausente | ✅ |
| Termo de autoria e uso de IA em PDF separado | ✅ |
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

Regras do template de 2026 implementadas na classe `idp.cls`, com complemento
do manual onde o template é omisso:

| Item | Valor |
|---|---|
| Papel | A4 (210 × 297 mm) |
| Margens | esquerda 3 cm · direita 2 cm · superior 3 cm · inferior 2 cm |
| Fonte | Times New Roman 12 no texto, abstract e Keywords; título da capa e da folha de rosto em 16 |
| Entrelinhas | 1,5 no texto; simples no resumo, abstract, citações longas, notas, referências e natureza do trabalho |
| Recuo de parágrafo | 1,25 cm |
| Numeração de páginas | canto superior direito, a 2 cm da borda; contagem começa na folha de rosto e só aparece a partir da introdução |
| Seção primária | `1 TÍTULO` — caixa alta + negrito, em nova página, sem forçar paridade |
| Seção secundária | `1.1 Título` — negrito |
| Seção terciária | `1.1.1 Título` — sem destaque, como no Word |
| Seção quaternária | `1.1.1.1 Título` — itálico, como no Word |
| Seção quinária | `1.1.1.1.1 Título` — itálico, complementado pelo manual |
| Citações autor-data | `(Silva, 2020)`, conforme exemplos da NBR 10520:2023 no manual |
| Palavras-chave | até cinco termos, separados por ponto e vírgula e terminados por ponto |
| Citação longa (> 3 linhas) | recuo 4 cm, corpo 10, entrelinha simples, sem aspas |
| Notas de rodapé | corpo 10, entrelinha simples |
| Legenda de figura | corpo 9 em itálico, acima, como no Word |
| Outras legendas e “Fonte:” | corpo 10; fonte abaixo, sem negrito, alinhada à esquerda do elemento medido |

## Estrutura do repositório

```
TemplateLatexIDP/
├── idp.cls                 ← a classe LaTeX (o coração do template)
├── main.tex                ← documento principal: só inclui os outros arquivos
├── termo-autoria-ia.tex     ← declaração avulsa, compilada separadamente
├── referencias.bib         ← sua bibliografia (formato BibTeX)
├── config/
│   ├── nivel.tex           ← nível do trabalho compartilhado com o termo
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
├── tests/validate_template.py ← verificação dos quatro níveis
└── templateMonografia_ou_TCC.pdf   ← modelo antigo, referência histórica
```

## Como compilar

```bash
latexmk -xelatex main.tex  # gera main.pdf usando Times New Roman instalada
latexmk -c                 # limpa arquivos auxiliares
```

Requer uma distribuição LaTeX (MiKTeX, TeX Live ou MacTeX) com `biber`.
Para reproduzir a fonte do Word, instale Times New Roman e use XeLaTeX.
Sem essa fonte, XeLaTeX utiliza TeX Gyre Termes. A compilação legada
`latexmk -pdf main.tex` continua disponível, com a aproximação tipográfica
do pacote `newtx`; ela não incorpora a fonte Times New Roman original.
Veja a instalação passo a passo no [TUTORIAL.md](TUTORIAL.md#1-preparando-o-ambiente).

## Escolhendo o tipo de trabalho

A escolha em `config/nivel.tex` é compartilhada pelo trabalho e pelo termo de
autoria. O exemplo vem configurado para mestrado. Escolha uma destas definições:

```latex
\def\NivelTrabalho{bacharelado}     % monografia / TCC de graduação
\def\NivelTrabalho{especializacao}  % pós-graduação lato sensu
\def\NivelTrabalho{mestrado}        % dissertação
\def\NivelTrabalho{doutorado}       % tese
```

Outras opções combináveis:

| Opção | Efeito |
|---|---|
| `secaonovapagina` | *(padrão)* cada seção primária começa em nova página, par ou ímpar |
| `secaocontinua` | seções primárias seguem na mesma página |
| `semlinks` | *(padrão)* hiperlinks sem cor, adequados para impressão |
| `links` | hiperlinks coloridos, úteis na versão digital |
| `rascunho` | marca d'água “RASCUNHO” |
| `refautorrepetido` | mantida por compatibilidade; repetir a autoria já é o padrão |
| `entrega` | aborta a compilação se algum campo obrigatório estiver em branco |

## Os dados do trabalho

`config/dados.tex` é a **fonte única da verdade**: cada dado é digitado uma vez
e alimenta capa, folha de rosto, folha de aprovação e os
metadados do PDF.

```latex
\titulo{A eficácia horizontal dos direitos fundamentais}
\subtitulo{uma análise da jurisprudência do STF}
\autor{Maria Aparecida de Souza}
\orientador{Prof. Dr. João Carlos Pereira}
\programa{Direito Constitucional}
\area{Direitos Fundamentais}
\linhapesquisa{Jurisdição constitucional}
\cidade{Brasília}
\datadefesa{15 de dezembro de 2026}          % só a data; a cidade vem de \cidade
\membrobancacomidentificador[UnB]{Prof. Dr. Pedro Rocha}{ID Lattes ou ORCID}{Examinador externo}
```

Consulte a [tabela de campos do tutorial](TUTORIAL.md#4-preencha-seus-dados)
para os metadados disponíveis. Para personalizações, também existem
`\tipotrabalho` (legado), `\preambulo`, `\instituicao`, `\logo` e `\semlogo`.

O modelo da banca inclui identificador Lattes/ORCID e instituição. Use
`\membrobancacomidentificador[Instituição]{Nome}{Identificador}{Função}`.
A chamada antiga `\membrobanca[Instituição]{Nome}{Função}` continua válida.
O exemplo contém quatro membros, como o Word; ajuste a composição à banca
aprovada pelo programa. A área de concentração é obrigatória no mestrado e
no doutorado e integra a nota da folha de rosto com a expressão *stricto sensu*.
A folha de aprovação também inclui a área de concentração, por orientação da
Biblioteca em 12/11/2026.

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

Campo obrigatório em branco aparece no PDF como `[[ PREENCHER: titulo ]]` e gera
aviso nomeando o campo. Na versão final, compile com a opção `entrega`: o aviso
vira erro e **nenhum PDF é gerado** enquanto houver pendência.

```latex
\input{config/nivel}
\documentclass[\NivelTrabalho,entrega]{idp}
```

## Ficha catalográfica oficial

Solicite a ficha à Biblioteca Ministro Moreira Alves, por `biblioteca@idp.edu.br`
ou pelo [formulário de solicitação](https://forms.cloud.microsoft/r/wPvmB4C7v6).
Salve o PDF recebido em `pretextual/` e
configure em `config/dados.tex`:

```latex
\arquivofichacatalografica{pretextual/ficha-catalografica-oficial.pdf}
```

O comando `\fichacatalografica` insere o PDF na posição correta. Sem o arquivo,
o exemplo exibe apenas a orientação com e-mail, formulário, QR code e o aviso
exigido pela Biblioteca. **Não se gera ficha de rascunho.** A opção `entrega`
exige o PDF oficial ao inserir a ficha. Os comandos catalográficos antigos
continuam aceitos por compatibilidade, mas não geram conteúdo catalográfico.

**ATENÇÃO!** Fichas que não estiverem de acordo com as normas do Código de
Catalogação Anglo-Americano vigente não serão aceitas.

## Fontes de ilustrações e tabelas

Para figuras, quadros, tabelas e gráficos, envolva o elemento centralizado em
`\begin{elemento}...\end{elemento}` e use `\fonte{...}` logo abaixo. O ambiente
mede a largura e alinha a fonte à borda esquerda real. A largura explícita
`\fonte[largura]{texto}` continua disponível. Sem medição nem largura, a classe
avisa e usa a largura do texto; ajuste documentos antigos ao novo padrão.
Veja os [exemplos do tutorial](TUTORIAL.md#8-figuras-tabelas-quadros-e-gráficos).

## Resguardo da marca

A marca padrão tem resguardo branco de 3,5 mm em todos os lados.
`\resguardologo{medida}` permite configurar
outra medida sem alterar a imagem nem sua proporção.

As medições e a comparação com o Word estão no
[registro da revisão](docs/ajustes-biblioteca-2026-11-12.md#retificação-e-comparação-direta-com-o-word--13112026).

## Termo de autoria e uso de IA

```bash
latexmk -xelatex termo-autoria-ia.tex
```

Gera `termo-autoria-ia.pdf` separadamente, reutilizando autor, título, vínculo e
matrícula (`\matricula{}`) de `config/dados.tex`. As opções de qualificação/defesa,
uso de IA, ferramentas, datas e assinaturas permanecem em branco para o aluno.
A redação do termo oficial foi preservada, inclusive sua denominação institucional.
O termo não integra a paginação do trabalho e não declara automaticamente uso ou
ausência de IA.
O termo segue sua própria formatação oficial: corpo 10,5, título 14,
subtítulo 9 em itálico, marcações `( )` e uma página com os dados de exemplo.
Dados excepcionalmente extensos podem exigir revisão da paginação.

## Fontes da atualização de 2026

| Fonte | Aplicação |
|---|---|
| [Modelo Word 2026](<Template final_Monografia_Dissertacao_Tese_2026 uni IDP.docx>) | referência fornecida para a revisão; apresentação, hierarquia, resumos, natureza e banca, com as ressalvas da Biblioteca |
| [Manual 2026](https://drive.google.com/file/d/1fy5h0PsfprHcXnFbC5MuXxzMTufblAYD/view) | complemento apenas nos pontos não definidos no template |
| [Regulamento e licença do RI](https://drive.google.com/file/d/1yTuwekiZNtz-uXBlAdNbHKSgr1wROzZF/view) | orientações de depósito e autorização pelo Portal do Aluno |
| [Termo de autoria e IA](https://docs.google.com/document/d/1zNp7tbtB3X--BvLmIZSPh7mkdRiehvN2nW9Cg7drGvM/edit) | documento avulso para qualificação/defesa |
| [Orientações MCDIA — Turma 1/2026](<orientacoes-idp/Turma 1-2026 MCDIA - Orientações para Qualificação e Defesa de Dissertação.pdf>) | orientações de qualificação e defesa dessa turma |

Nas contradições internas do Word, a instrução específica do elemento prevalece
sobre instruções gerais e formatação incidental. Para o abstract e as Keywords,
vale a revisão posterior da Biblioteca, refletida na tabela de
[formatação implementada](#formatação-implementada). A citação longa usa 10,
conforme a orientação junto ao exemplo; uma orientação geral anterior diz 11.
Os títulos da capa e da folha de rosto acompanham o formato 16 do Word.
O terceiro nível é normal e o quarto é itálico. O quinto nível, não exemplificado
no Word, segue o manual. A epígrafe também segue o manual complementar.
A legenda da figura acompanha o corpo 9 em itálico observado no Word, e a
indicação de fonte segue a orientação de
[alinhamento ao elemento](#fontes-de-ilustrações-e-tabelas).
O exemplo inclui a ilustração extraída do Word sem alterar o PNG, com o recorte
original reproduzido pelo LaTeX. Ver [relatório das três rodadas](docs/validacao-modelo-2026.md).

As referências continuam repetindo autores por extenso, como no Word. Dados
bibliográficos precisam ser verificados: o Word lista NBR 6027 com ano 2018,
enquanto o manual informa 2012; a entrada existente de 2012 foi preservada.

O PDF é digital e usa margens de 3 cm à esquerda/acima e 2 cm à direita/abaixo.
As seções primárias começam em nova página, sem inserir folhas para forçar
página ímpar: o próprio modelo inclui início de seção em página par.
A licença de depósito
não é anexada automaticamente: o regulamento prevê manifestação do autor no
Portal do Aluno (art. 13, §1º). Não se presume uma licença Creative Commons.
O antigo `templateMonografia_ou_TCC.pdf` permanece apenas como referência histórica.

## Avaliar pendências do aluno

A skill [idp-pendencias-dissertacao](.agents/skills/idp-pendencias-dissertacao/SKILL.md)
confere os artefatos da pasta local e orienta sobre qualificação, defesa,
pós-defesa, Biblioteca e artigo derivado. Use, por exemplo:

```text
Use $idp-pendencias-dissertacao para avaliar minha pasta para a qualificação.
```

Ela cruza os arquivos com as orientações da Turma 1/2026 e as fontes da
Biblioteca, aponta inconsistências e documentos não localizados e distingue
evidência documental de confirmação administrativa. Os prazos da turma não
são automaticamente aplicados a outros programas. A avaliação não modifica
o trabalho nem realiza envios ou requerimentos pelo aluno.

O [Regulamento do Repositório Institucional de 2026](orientacoes-idp/Regulamento_Repositorio_IDP_2026.pdf)
é mantido com a skill como fonte de consulta, em sua versão original, sem
incorporar propostas de alteração não aprovadas.

## Verificação

```bash
python tests/validate_template.py
```

Requer `xelatex`, `biber` e `pypdf`. Compila os quatro níveis e verifica vínculo
na capa, ficha oficial, citações, corpo/entrelinha dos resumos, banca com
identificadores, ausência de páginas de ajuste e termo em uma página.
Também verifica a página de solicitação sem ficha sintética e rejeição de ficha ausente/inexistente e de área
vazia em pós-graduação. Para conferir a compatibilidade legada, execute
`python tests/validate_template.py --engine pdflatex`. Os arquivos ficam em `.build/`.
As instruções e referências de exemplo precisam ser substituídas pelos dados
verificados do trabalho do aluno antes da entrega.

## Licença

Os arquivos da classe estão sob [LPPL 1.3c](LICENSE); o conteúdo de exemplo é
de domínio público. O PDF oficial do IDP e o logotipo pertencem ao IDP e estão
incluídos apenas para referência e uso pelos seus alunos.
