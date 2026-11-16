# Biblioteca: normalização e depósito

## Fontes mantidas no repositório

Resolva todos os caminhos a partir da raiz que contém esta skill:

1. `docs/ajustes-biblioteca-2026-11-12.md`: pedidos da Biblioteca e retificação
   de 13/11/2026. Os registros de 12/11 são históricos; use a comparação direta
   com o Word corrigido de 13/11 para as medidas atuais.
2. `Template final_Monografia_Dissertacao_Tese_2026 uni IDP.docx`: referência
   institucional da comparação, SHA-256
   `6beb4cd462d7b130f11681912404f659411212fb8d6ae2543ffe1eb32f197891`.
3. `README.md`, `TUTORIAL.md`, `config/dados.tex`, `idp.cls` e
   `termo-autoria-ia.tex`: aplicação e uso do template aprovado. O código
   sozinho não demonstra o resultado do PDF do aluno.
4. `orientacoes-idp/Regulamento_Repositorio_IDP_2026.pdf`: original do
   Regulamento do Repositório Institucional, de 10/08/2026, incluindo a licença
   não exclusiva no Apêndice A, 12 páginas. SHA-256
   `be585049d00cabbe552fcd4e3ce1dda4c01a6f21f34416ab8a40f862d97bd67f`.
   Origem registrada:
   <https://drive.google.com/file/d/1yTuwekiZNtz-uXBlAdNbHKSgr1wROzZF/view>.
   A cópia local é a fonte consultada; a abertura web desse link não foi possível
   em 16/11/2026. Não confundir com proposta de revisão com alterações rastreadas.

Contato e serviços atuais: <https://www.idp.edu.br/biblioteca>, consultado em
16/11/2026. A página confirma atendimento de normalização e template ABNT.
Não importar normas ou prazos de outros programas ou universidades.

## Matriz de verificação

| ID | Requisito / critério | Evidência e ação | Fonte |
| --- | --- | --- | --- |
| B01 | Marca e capa conforme o modelo aprovado. No exemplo, marca de 57 mm, resguardo mínimo de 3,5 mm e distância marca–instituição de aproximadamente 8,47 mm, comparada a 8,44 mm do Word. | Inspecionar/medir o PDF e comparar ao modelo. Títulos longos requerem inspeção; não converter tolerância de uma medição histórica em regra institucional universal. | Ajustes Biblioteca, retificação de 13/11 |
| B02 | Ficha oficial solicitada à Biblioteca conforme as [instruções do README](../../../../README.md#ficha-catalográfica-oficial). Ficha sintética/rascunho e a página com QR code não substituem a ficha recebida. | Conferir solicitação, PDF oficial, dados coerentes e inserção sem adulteração na versão destinada ao depósito. Não gerar ficha nem inventar Cutter/CDD. Sem comprovante da emissão, não certificar origem só pela aparência. | Ajustes Biblioteca, pedido 2; README, Ficha catalográfica oficial |
| B03 | Área de concentração na folha de aprovação do mestrado/doutorado. | Comparar ao cadastro/metadados e ao texto real da aprovação; campo de exemplo não atende. Folha de aprovação pós-defesa deve refletir banca/data reais e as exigências aplicáveis de validação/assinatura. | Ajustes Biblioteca, pedido 3; MCDIA p. 4 |
| B04 | Abstract e Keywords em corpo 12 e espaço simples. | Medir/inspecionar no PDF. Não aplicar o antigo corpo 10 do Word quando há correção expressa da Biblioteca. | Ajustes Biblioteca, pedido 4 |
| B05 | Indicação de fonte à esquerda da borda do elemento em figuras, quadros, tabelas e gráficos. | Conferir o PDF, inclusive fontes longas. O ambiente `elemento` e `\fonte[largura]` são meios de implementação, não prova automática do alinhamento. | Ajustes Biblioteca, pedido 5 |
| B06 | Depósito conforme padrão institucional e normas de normalização; inconsistências podem impedir processamento e exigir nova versão. | Conferir texto, imagens, citações, referências, dados e PDF; registrar pendências antes do requerimento. O sucesso de `entrega` não substitui aceitação da Biblioteca. | Regulamento, art. 7º, §§2º–4º, p. 3 |
| B07 | Submissão por requerimento no Portal ou solicitação formal à Biblioteca; para TCC, autorização expressa do autor no requerimento eletrônico e ciência da licença. | Distinguir depósito acadêmico e publicação no repositório. Conferir protocolo e autorização; não aceitar automaticamente licença nem escolher modalidade de acesso pelo aluno. Para a turma, seguir também o fluxo específico MCDIA, p. 9. | Regulamento, arts. 7º e 13, pp. 3 e 5 |
| B08 | Direitos de terceiros e restrições pertinentes à obra. | Conferir materiais de terceiros, autorizações e tratamento dos dados identificáveis quando aplicável; apontar documentos ausentes/questões a esclarecer. Não emitir parecer jurídico nem atestar conformidade só porque há termo em branco. | Regulamento, art. 12, p. 5; licença, art. 14, p. 9 |
| B09 | Disponibilização parcial/embargo demanda solicitação/justificativa e modalidade de acesso definida pelo autor, sujeita à apreciação institucional. | Se aplicável, conferir pedido, justificativa, prazo e decisão; não inferir embargo a partir de um arquivo chamado “parcial”. Há distinção entre versão pública e integral depositada sob restrição. | Regulamento, art. 8º, p. 4; licença, arts. 10–13, pp. 8–9 |
| B10 | Identificação de autoria/licença e metadados coerentes. | Cruzar título, autor, orientador, curso/área e ano com ficha, ata, termo, Lattes/ORCID e requerimento. Não inventar identificadores nem exigir DOI/ISBN pessoal ao aluno quando não aplicável. | Licença, arts. 15 e 29, pp. 9 e 11; template |
| B11 | Termo de autoria e uso de IA com informações do aluno, escolhas coerentes e assinatura no procedimento de banca. | O termo separado do template é um modelo: conferir preenchimento, escolhas e assinatura. A existência do arquivo, compilação ou ausência de uso de IA não dispensa o termo exigido pelo documento da turma. | MCDIA pp. 7–8; `termo-autoria-ia.tex` e README |

Na qualificação ou em um rascunho, a ausência da ficha oficial deve ser
registrada como providência para a entrega final; não a transforme em
impedimento da qualificação sem fonte institucional específica. Em depósito
final, a página de orientação do exemplo é uma pendência, não uma ficha válida.
O modo LaTeX `entrega` é uma proteção técnica e não define sozinho o calendário
administrativo de exigibilidade.

Sobre embargo, o art. 8º do regulamento descreve versão parcial com capa até a
introdução e referências; a licença exige o integral em acesso restrito e
indica também resumo/metadados públicos. Se a montagem do pacote depender
dessa articulação, exponha os dois dispositivos e confirme com a Biblioteca.
Não exclua conteúdo do depósito nem libere o integral automaticamente.

Datas de atendimento, prazos para emissão da ficha e formulários de agendamento
de bancas não são fornecidos por essas fontes. Consulte os canais oficiais e
registre a orientação obtida, sem preenchimentos ou envios por conta própria.
