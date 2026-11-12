# Comparação e correção dos modelos IDP — 11/11/2026

Foram concluídas três rodadas de comparação, correção, compilação e inspeção
dos PDFs. O template institucional é obrigatório; o manual complementa apenas
os pontos que o template não define. A denominação Universidade IDP, o logo
fornecido, o termo separado e a inserção da ficha oficial foram preservados.

## Referências e método

- [Template Word 2026](https://docs.google.com/document/d/1EGSqrgCwIYK5MpelwSsYxsqPF9-v92em/edit), exportado localmente pelo Microsoft Word para comparação visual.
- [Termo oficial](https://docs.google.com/document/d/1zNp7tbtB3X--BvLmIZSPh7mkdRiehvN2nW9Cg7drGvM/edit), exportado do Google Docs em PDF.
- [Manual complementar](https://drive.google.com/file/d/1fy5h0PsfprHcXnFbC5MuXxzMTufblAYD/view).

Foram comparados conteúdo obrigatório, fontes incorporadas, tamanhos, recuos,
posições de elementos fixos, intervalos, figura/legenda/fonte e paginação.
Os PDFs foram renderizados e todas as 26 páginas do exemplo e a página do termo
foram inspecionadas. Comparações geométricas usaram 20 pontos de referência;
os limites foram 1 mm para recuos de títulos, 2 mm para o termo e a primeira
linha textual, 3 mm para capa/rosto e 4 mm para blocos de aprovação.

As alternativas de graduação/mestrado/doutorado e os balões de orientação
do Word não foram transcritos simultaneamente: o documento final apresenta
somente a alternativa correspondente ao nível selecionado.

## Rodadas

| Rodada | Diferenças identificadas | Correções e verificação |
|---|---|---|
| 1 | Título/autor da capa cerca de 3,4 mm acima; cidade/ano até 7,5 mm acima; recuo da nota do rosto 5 mm além do Word; aprovação com blocos até 17,3 mm acima. | Calibração de capa e rodapé, nota do rosto a 105 mm da borda esquerda, tipografia da nota, redação própria da aprovação, subtítulo sem negrito e intervalos da banca. Cabeçalho do termo alinhado. PDFs recompilados e renderizados. |
| 2 | Posição inicial da aprovação ainda incorreta; figura genérica; legenda/fonte diferentes; capítulo 4 com título diferente; palavra adicional na citação de exemplo de Sá. | Aprovação alinhada, ilustração original extraída do Word, legenda de figura em 9 pt itálico, fonte sem negrito, título “Apresentação e análise dos dados” e transcrição de Sá ajustada ao texto fornecido no modelo. PDFs recompilados e renderizados. |
| 3 | Recorte da ilustração ainda mostrava resíduo da anotação interna; indicação de fonte centralizada; intervalos de títulos e da banca ainda diferentes. | Recorte nativo de 5/17/22/73 pixels, fonte alinhada sob a imagem, recuos dos títulos primário/secundário e intervalo título–texto ajustados; espaçamento dos quatro membros calibrado. Revisão final completa e testes nos quatro níveis, com os dois compiladores. |

## Resultado geométrico final

Diferenças em milímetros; valores positivos ficam abaixo/à direita do modelo.

| Elemento | Diferença |
|---|---:|
| Capa: instituição / título / autor | +0,34 / +0,02 / +0,07 |
| Capa: cidade / ano | +0,01 / −0,03 |
| Rosto: autor / título | +0,27 / −0,51 |
| Rosto: recuo da nota | +0,03 |
| Rosto: cidade / ano | +0,01 / −0,07 |
| Aprovação: autor / título | −0,05 / −0,10 |
| Aprovação: data / “Banca Examinadora” | −0,45 / −0,40 |
| Termo: título / subtítulo / abertura | +0,05 / +0,60 / +0,06 |
| Texto: recuo do título primário / secundário | 0,00 / 0,00 |
| Texto: primeira linha após o título primário | +1,12 |

Todos os pontos medidos ficaram dentro dos limites definidos. Não foram
observadas diferenças significativas remanescentes de formatação nos elementos
comparáveis, sobreposição, corte de texto, páginas vazias de ajuste ou estouro
de caixas no log. Isso não equivale a identidade de pixels entre Word e LaTeX.

## Conteúdo, fontes e compatibilidade

- Exemplo: 26 páginas; termo: uma página, como seu modelo oficial.
- Times New Roman incorporada nos PDFs finais compilados com XeLaTeX.
- Texto fixo das seis cláusulas do termo igual ao documento oficial, após
  normalizar espaços, marcações vazias e substituir o campo de título pelos
  dados de exemplo. As 11 opções permanecem desmarcadas.
- Os quatro blocos da banca incluem instituição e campo Lattes/ORCID.
- Testes passaram para bacharelado, especialização, mestrado e doutorado,
  com XeLaTeX e pdfLaTeX. Incluem legenda 9/itálico, fonte com largura opcional,
  ficha oficial, modo entrega, dados de pós-graduação, citações e termo avulso.
- O PNG extraído do Word foi copiado sem alterações, SHA-256
  `cbc06a0aa69510a6bdd5c51a580a5080fcf71e37ea2a34552a0c50436c330af6`.
  O recorte é aplicado somente na apresentação em LaTeX.

## Diferenças previstas e limites

- O Word tem 23 páginas; o exemplo tem 26 por incluir epígrafe, lista de quadros
  e segundo apêndice, além de textos e dados demonstrativos próprios.
  Esses conteúdos e os nomes/títulos preenchidos também alteram quebras de linha.
- O abstract segue a instrução expressa do Word (10 pt, simples), embora o
  parágrafo do arquivo de referência esteja formatado em 12 pt. A prioridade
  da instrução específica está registrada no README. A citação longa segue 10,
  instrução junto ao exemplo, em lugar do 11 citado na orientação geral.
- A nota da folha de rosto usa o primeiro espaço de apresentação do modelo,
  com a redação do nível escolhido; não conserva os espaços das alternativas removidas.
- Foram mantidos o nome Universidade IDP e o logo fornecido. A denominação
  antiga no termo foi preservada como parte de sua redação oficial.
- A ficha presente no exemplo é rascunho identificado. A entrega exige o PDF
  oficial da Biblioteca. Metadados, resumos, textos e referências continuam
  demonstrativos e precisam ser substituídos/verificados no trabalho real.
- O README registra a divergência do ano da NBR 6027 entre as fontes.
  A referência bibliográfica existente de 2012 foi preservada.

As evidências locais (PDFs de cada rodada, renderizações, medidas JSON e logs)
ficam em `.build/comparacao-2026/`. As rodadas foram realizadas localmente;
a publicação no repositório é uma etapa separada.
