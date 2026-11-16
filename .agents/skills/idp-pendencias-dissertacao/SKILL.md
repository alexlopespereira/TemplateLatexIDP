---
name: idp-pendencias-dissertacao
description: Avaliar arquivos locais e pendencias de alunos do MCDIA/IDP para qualificacao, defesa, pos-defesa, Biblioteca e artigo derivado. Use para conferir artefatos e orientar procedimentos conforme as fontes institucionais; nao para redigir pesquisa nem certificar aprovacao academica.
---

# Avaliar pendências da dissertação no IDP

Examine os artefatos reais da pasta indicada pelo usuário e entregue um
diagnóstico rastreável e um roteiro das próximas providências. A avaliação é
somente leitura: não altere o trabalho, assine termos, envie mensagens, publique
dados ou faça requerimentos institucionais sem pedido específico para a ação.

## Fontes e alcance

Leia [requisitos-mcdia.md](references/requisitos-mcdia.md) e
[biblioteca.md](references/biblioteca.md), depois consulte as páginas originais
pertinentes ao estágio do aluno. As referências indicam os documentos
versionados no mesmo repositório; não dependem da máquina do autor da skill.
Resolva os caminhos a partir da localização real da skill, inclusive se ela
estiver instalada por junction/symlink.
No layout distribuído, a raiz das fontes fica três diretórios acima da pasta
da skill (`.agents/skills/idp-pendencias-dissertacao`). A pasta do aluno pode ser
outra: mantenha separados o checkout das normas e o diretório sob avaliação.
Se a skill tiver sido copiada isoladamente, localize as fontes antes de julgar
conformidade; não trate fontes indisponíveis como requisitos já conferidos.

- A base curricular é **Turma 1/2026, MCDIA, novembro de 2026**. Não aplique suas
  datas a outra turma, programa ou doutorado sem confirmar a regra aplicável.
- Os procedimentos acadêmicos seguem o documento da turma e as atualizações
  institucionais pertinentes. A formatação segue o template aprovado, com as
  retificações documentadas da Biblioteca; o manual complementa lacunas.
- Uma divergência entre fontes deve aparecer no relatório, com ambas as
  referências. Não invente a solução nem transforme recomendação em obrigação.
  Propostas de alteração de regulamento não são normas aprovadas.
- Para procedimentos atuais não cobertos pelas fontes, verifique os canais
  oficiais do programa/Biblioteca. Registre data e fonte da consulta. Se faltar
  acesso, diga exatamente o que precisa ser confirmado.

## Levantar os artefatos

Identifique pasta, aluno, turma, estágio e datas relevantes a partir do pedido e
das evidências. Se o estágio não estiver claro, faça uma avaliação preliminar e
pergunte apenas o que muda a conclusão, enquanto prossegue na análise documental.
Não assuma aprovação de banca a partir do nome de uma pasta ou de uma data futura.

Comece com `rg --files --hidden --no-ignore`, excluindo `.git`, ambientes virtuais e caches;
inspecione também arquivos ignorados que possam conter o trabalho atual. Não
limite a busca aos arquivos versionados. Procure versões editáveis e PDFs,
projeto, dissertação parcial/final, apresentações, termos, ficha oficial,
comprovantes de envio/agendamento, atas/pareceres, histórico, Lattes e artigo.
Não exija nomes fixos: classifique pelo conteúdo e pela etapa.

Estabeleça qual é a versão atual por conteúdo, datas e indicação do aluno;
compare versões divergentes sem escolher apenas a mais recente por nome.
Registre cobertura da busca, arquivos ilegíveis, documentos fora da pasta e
limitações de OCR. Ausência na pasta significa **não localizado neste escopo**,
nunca prova de que o aluno não produziu ou não enviou o documento.

**O exemplo distribuído com o template não é evidência de produção do aluno.**
Identifique textos demonstrativos, `[[ PREENCHER ]]`, nomes genéricos, capítulos
de instrução e termos em branco. Um PDF com 26 páginas, compilado sem erros e
com uma banca de exemplo continua sendo um modelo, não uma qualificação pronta.

## Avaliar conteúdo, consistência e apresentação

Cruze a matriz das referências com os arquivos encontrados, avaliando a fase
atual e indicando separadamente as exigências futuras. Para cada achado, associe
a regra, o grau de obrigatoriedade, a fonte e a evidência local exata.

- Confira problema/pergunta, objetivos, justificativa, método, referencial,
  desenvolvimento e conclusão em relação à etapa. Aponte contradições reais,
  objetivos sem tratamento, resultados sem evidência e conclusões que não
  respondem à pergunta; não crie argumentos, dados ou referências para suprir lacunas.
- Compare autor, título/subtítulo, programa, orientador, área, ano e banca entre
  capa, folha de rosto, aprovação, resumos, ficha, termo de IA, atas e formulários.
  Mudanças de título pós-banca pedem verificação da versão aprovada e da ficha.
- Relacione citações e bibliografia, referências indefinidas, citações diretas,
  indicação de página e fontes de figuras/tabelas. Não acuse plágio nem declare
  originalidade com base só em busca textual; a conferência institucional de
  similaridade é uma etapa distinta.
- Leia o PDF efetivamente destinado à entrega e renderize as páginas relevantes:
  capa, rosto, ficha, aprovação, resumos, sumário, corpo, elementos e referências.
  Extração de texto não demonstra margens, fontes, alinhamento ou integridade visual.
- Conte as páginas **textuais**, declarando os limites usados, sem pré/pós-textuais.
  Não compare o total físico do PDF às faixas preferenciais da turma. Não reprove
  automaticamente quem está fora da faixa; registre recomendação e consulta ao orientador.
- Em LaTeX, confira inclusão de capítulos/figuras, metadados, bibliografia, logs
  e correspondência do PDF às fontes. Se for necessário compilar, use pasta
  temporária e não habilite shell escape. Não modifique `idp.cls` para adaptar
  o trabalho do aluno. Um teste de compilação não substitui revisão do PDF.

Termos devem ter os dados do aluno e escolhas coerentes, com evidência de
assinatura quando exigida. Nome digitado, espaço de assinatura e PDF de exemplo
não comprovam assinatura. Validade criptográfica, anuência, composição aprovada
da banca e execução de atos no portal exigem evidências próprias; se não houver,
use **não comprovado** e indique quem confirma.

## Orientar os procedimentos

Explique os passos aplicáveis à fase atual: anuência do orientador, composição
e agendamento de banca, entrega prévia, termo de IA, apresentação, resultado,
reformulações, versão final, Biblioteca/depósito e artigo. Use os responsáveis
e prazos das referências. Não invente número de optativas, URL de agendamento,
prazo de emissão de ficha, limite de similaridade ou prazo de embargo.

Calcule datas apenas quando o evento e sua data-base estiverem comprovados.
Informe a data-base, dias corridos/antecedência conforme a fonte e eventual
dependência do calendário da Coordenação. “Maio de 2027” não autoriza inventar
um dia. Distinga data da defesa, aprovação após reformulação e depósito.

## Entregar o diagnóstico

Abra com o estágio avaliado, a versão examinada e as limitações relevantes.
Não declare o aluno “apto” ou “aprovado pelo IDP”. Informe se há pendências
documentais identificadas para a próxima etapa e quais confirmações faltam.

Use uma tabela de achados com:

`Requisito | Situação | Evidência local | Fonte institucional | Providência / responsável | Prazo`

Situações: **atendido** (evidência suficiente no escopo), **inconsistente**,
**faltante na pasta** (artefato esperado na fase, não localizado), **não comprovado**
(ato/condição ou conteúdo que não pôde ser verificado) e **não aplicável agora**
(justifique). Registre recomendações como tais, sem classificá-las como impedimentos.

Ordene por impedimentos expressos da próxima etapa, prazos próximos, correções
formais e recomendações. Termine com ações concretas do aluno e os pontos a
confirmar com orientador, Coordenação ou Biblioteca. Cite arquivos/páginas ou
linhas, evitando reproduzir dados pessoais desnecessários.

Responda no chat por padrão. Só grave um relatório se solicitado, no destino
indicado; não versione ou transmita o trabalho ou os comprovantes do aluno por
conta própria. Revisões seguintes devem comparar o estado atual às pendências
anteriores, sem transportar conclusões antigas sem verificar os novos arquivos.
