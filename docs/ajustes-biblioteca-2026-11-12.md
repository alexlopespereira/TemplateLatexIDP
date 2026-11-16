# Atendimento à revisão da Biblioteca IDP — 12/11/2026

**Retificação de 13/11/2026:** a classificação anterior do item 1 como atendido
foi insuficiente. O resguardo mínimo da imagem foi medido, mas não o espaçamento
equivalente ao Word indicado pelo responsável. A versão de 12/11 tinha 5,47 mm
entre a imagem e a linha “Universidade IDP”; o Word fornecido em 13/11 tem
8,44 mm. A capa foi corrigida e o novo PDF tem 8,47 mm. Os registros de 12/11
abaixo são históricos e não substituem a conferência atual descrita ao final.

Origem: resposta de Natália Bianca Mascarenhas Puricelli, Biblioteca IDP,
em 12/11/2026, ao envio dos PDFs do modelo acadêmico e do termo de autoria/IA.
Esta orientação posterior prevalece nos cinco pontos abaixo. Nas demais
questões, o template institucional Word continua obrigatório e o manual
permanece complementar.

## Solicitações e alterações

| Nº | Solicitação | Atendimento |
|---|---|---|
| 1 | Aumentar o espaço entre a marca e “Universidade IDP”, preservando uma área livre equivalente ao espaçamento interno da assinatura. | O resguardo de 3,5 mm foi mantido, mas o espaço de 5,47 mm de 12/11 não reproduzia o Word. Em 13/11 a marca foi elevada em 3 mm e o intervalo seguinte aumentado, produzindo 8,47 mm livres, frente aos 8,44 mm do Word. A compensação que elevava título, autor e cidade/ano foi retirada. |
| 2 | Retirar o rascunho de ficha catalográfica incorreto e orientar os alunos a solicitar a ficha à Biblioteca, incluindo formulário e aviso normativo. | Não há ficha sintética no PDF atual. Em 13/11 a página de solicitação foi alinhada ao Word fornecido: título, painel de orientação e QR code de 71,1 mm. O aviso integral, o e-mail e o URL do formulário são visíveis; os links funcionam e o QR code foi decodificado do PDF renderizado. |
| 3 | Incluir a área de concentração na folha de aprovação. | A natureza do trabalho na aprovação inclui `\area{...}` para mestrado e doutorado, reaproveitando os metadados de `config/dados.tex`. |
| 4 | Aumentar o abstract e as Keywords para corpo 12. | Ambos usam corpo 12, com espaçamento simples. A orientação escrita no próprio exemplo também foi corrigida. |
| 5 | Alinhar as fontes das ilustrações e tabelas à esquerda do respectivo elemento. | Criado o ambiente `elemento`, que mede a largura da imagem ou tabela centralizada. `\fonte` usa essa medida para alinhar seu texto à esquerda. Corrigidos os quatro exemplos: figura, quadro, tabela e gráfico. |

## Orientações de uso

O README mantém as instruções de
[solicitação e inserção da ficha oficial](../README.md#ficha-catalográfica-oficial)
e de [alinhamento das fontes e compatibilidade](../README.md#fontes-de-ilustrações-e-tabelas).
Os [exemplos de marcação](../TUTORIAL.md#8-figuras-tabelas-quadros-e-gráficos)
ficam no tutorial.

## Verificação

- PDF principal recompilado com XeLaTeX e Times New Roman: 26 páginas,
  com inspeção visual de todas as páginas renderizadas.
- Página de solicitação, aprovação, abstract e quatro exemplos de elementos
  conferidos no PDF, incluindo medidas de alinhamento.
- Abstract e Keywords medidos em aproximadamente 11,96 pontos PDF,
  correspondentes ao corpo LaTeX de 12 pontos.
- QR code lido tanto na imagem original quanto na página renderizada;
  conteúdo idêntico e correspondente ao formulário indicado, com o parâmetro
  de origem `origin=QRCode`.
- Suíte `tests/validate_template.py`: quatro níveis acadêmicos, inserção
  da ficha oficial, bloqueios de entrega e regressão do termo avulso.
  Verificação nos motores XeLaTeX e pdfLaTeX.
- Termo avulso recompilado: uma página, seis cláusulas e onze opções
  sem marcação. A resposta não solicitou alteração específica no termo.

A emissão da ficha continua sendo uma etapa da Biblioteca; o exemplo não
substitui uma ficha oficial. O atendimento técnico acima não constitui
nova aprovação institucional do template.

## Duas rodadas adicionais de conferência — 12/11/2026

As rodadas abaixo foram realizadas após o atendimento inicial, por solicitação
do responsável pelo template. O e-mail foi relido na conta conectada para
conferir os cinco pedidos originais, sem ampliar o escopo da revisão.

### Rodada adicional 1 — PDFs existentes

Foram conferidos os PDFs efetivamente disponíveis na raiz do repositório,
com nova renderização e inspeção visual das 26 páginas do modelo acadêmico.

| Pedido | Conferência no resultado | Resultado |
|---|---|---|
| Resguardo da marca | Capa, página física 1: referência interna de aproximadamente 3,135 mm na escala utilizada; resguardo configurado de 3,5 mm; texto seguinte a 5,473 mm da imagem. | Atendido |
| Ficha catalográfica | Página física 3: ausência de ficha sintética; texto normativo integral, e-mail, formulário e QR code. Os dois links foram conferidos nas anotações do PDF; o QR foi decodificado da página renderizada. | Atendido |
| Área na aprovação | Página física 4: área de concentração presente na natureza do trabalho. | Atendido |
| Abstract e Keywords | Página física 9: todos os caracteres em aproximadamente 11,955 pontos PDF, equivalentes a 12 pontos LaTeX. | Atendido |
| Fontes à esquerda do elemento | Figura na página física 17, quadro na 18, tabela e gráfico na 19: diferença horizontal máxima de aproximadamente 0,007 ponto entre o início da fonte e a borda do elemento. | Atendido |

**Correções após esta rodada:** nenhuma adicional foi necessária. Os cinco
pedidos já estavam executados no resultado renderizado.

### Rodada adicional 2 — nova compilação e regressão

Os dois documentos foram compilados novamente com XeLaTeX em uma pasta de
compilação separada. Foram repetidas as medições dos cinco pedidos e a leitura
do QR code, seguidas de inspeção visual das páginas renderizadas.

- Os cinco pedidos permaneceram atendidos, com as mesmas medidas da rodada 1.
- As imagens das 26 páginas coincidiram byte a byte com as renderizações da
  rodada 1. Isso confirma que a nova compilação reproduziu o mesmo resultado
  visual dos PDFs já disponibilizados.
- Os logs não apresentaram erros, referências indefinidas nem caixas de texto
  excedendo a largura ou altura disponível.
- A suíte XeLaTeX foi executada novamente para os quatro níveis acadêmicos,
  incluindo área de concentração na aprovação de mestrado/doutorado, tamanho
  do abstract/Keywords, inserção da ficha oficial e bloqueios de entrega.
- O termo continuou com uma página, seis cláusulas e onze opções sem marcação.
  O e-mail não contém pedido específico de alteração desse documento.

**Correções após esta rodada:** nenhuma adicional foi necessária. Foi
atualizado somente este registro de conferência; a classe e os PDFs existentes
foram mantidos, pois a nova compilação reproduziu o resultado já correto.

## Retificação e comparação direta com o Word — 13/11/2026

Referência: `Template final_Monografia_Dissertacao_Tese_2026 uni IDP.docx`,
fornecido pelo responsável e exportado em modo somente leitura pelo Word.
O SHA-256 dessa referência é
`6beb4cd462d7b130f11681912404f659411212fb8d6ae2543ffe1eb32f197891`.
Esse arquivo difere do DOCX usado na comparação inicial de 11/11.

| Pedido | Evidência no PDF corrigido | Resultado |
|---|---|---|
| Espaço da marca | Página física 1: 8,473 mm entre a base da imagem e o topo da linha da instituição; Word: 8,443 mm. Marca a 35,069 mm do topo; Word: 35,137 mm. | Conferido e corrigido |
| Solicitação da ficha | Página física 3: sem “RASCUNHO”, CDD ou CDU; título e painel de solicitação, e-mail, formulário, aviso normativo completo e QR code. Dois destinos de link conferidos, QR decodificado para o formulário solicitado. | Conferido e ajustado ao Word |
| Área de concentração | Página física 4: área presente no texto de aprovação. | Conferido |
| Abstract e Keywords | Página física 9: caracteres em 11,955 pontos PDF, correspondentes a 12 pontos LaTeX. | Conferido |
| Fontes dos elementos | Figura (17), quadro (18), tabela e gráfico (19): diferença entre a borda esquerda do elemento e o início de “Fonte:” de no máximo 0,007 ponto. | Conferido |

Os outros 24 conjuntos de texto e coordenadas de página permaneceram
inalterados. O modelo tem 26 páginas; o termo avulso tem uma página,
seis cláusulas e onze opções sem marcação. Os dois documentos foram
recompilados com XeLaTeX, sem erros, referências indefinidas ou caixas excedidas.
As evidências, logs e medições estão em `.build/revisao-20261113/`.

A suíte `tests/validate_template.py` passou novamente nos quatro níveis
acadêmicos, tanto com XeLaTeX quanto com pdfLaTeX. Foram inspecionadas as
renderizações das 26 páginas, os detalhes das páginas 1, 3, 4, 9, 17, 18 e 19
e a página do termo. A leitura do QR code foi feita da página 3 renderizada.

As versões históricas em `.build/comparacao-2026/iteracao-3/` são anteriores
à revisão da Biblioteca e ainda incluem o rascunho da ficha. Não devem ser
apresentadas como a versão corrigida de 13/11. A raiz do repositório contém
os PDFs atuais: [modelo acadêmico](../main.pdf) e
[termo avulso](../termo-autoria-ia.pdf).
