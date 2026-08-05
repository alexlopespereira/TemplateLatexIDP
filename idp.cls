%%=============================================================================
%% idp.cls -- Classe LaTeX para trabalhos academicos do
%%            Instituto Brasileiro de Ensino, Desenvolvimento e Pesquisa (IDP)
%%
%% Reproduz o arquivo "templateMonografia_ou_TCC.pdf" publicado pela
%% Biblioteca Ministro Moreira Alves e atende as normas ABNT:
%%   NBR 14724 (trabalhos academicos)   NBR 6027 (sumario)
%%   NBR 6023  (referencias)            NBR 6028 (resumo)
%%   NBR 10520 (citacoes)               NBR 6024 (numeracao progressiva)
%%
%% Autor  : gerado para o repositorio TemplateLatexIDP
%% Licenca: LPPL 1.3c
%%=============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{idp}[2026/08/05 v1.0 Trabalhos academicos do IDP (ABNT)]

%%-----------------------------------------------------------------------------
%% 1. OPCOES DA CLASSE
%%-----------------------------------------------------------------------------
\RequirePackage{iftex}

\newif\ifidp@novapagina   \idp@novapaginatrue   % secao primaria em nova pagina
\newif\ifidp@links        \idp@linksfalse       % colorir hiperlinks
\newif\ifidp@rascunho     \idp@rascunhofalse    % marca d'agua de rascunho
\newif\ifidp@autorrepetido \idp@autorrepetidofalse % NBR 6023:2018 estrita
\newif\ifidp@entrega      \idp@entregafalse       % aborta se faltar campo

% --- nivel do trabalho (define a natureza padrao e o grau) -------------------
\def\idp@nivel{bacharelado}
\DeclareOption{bacharelado}{\def\idp@nivel{bacharelado}}
\DeclareOption{especializacao}{\def\idp@nivel{especializacao}}
\DeclareOption{mestrado}{\def\idp@nivel{mestrado}}
\DeclareOption{doutorado}{\def\idp@nivel{doutorado}}

% --- comportamento -----------------------------------------------------------
\DeclareOption{secaonovapagina}{\idp@novapaginatrue}
\DeclareOption{secaocontinua}{\idp@novapaginafalse}
\DeclareOption{links}{\idp@linkstrue}
\DeclareOption{semlinks}{\idp@linksfalse}
\DeclareOption{rascunho}{\idp@rascunhotrue}
\DeclareOption{refautorrepetido}{\idp@autorrepetidotrue}
\DeclareOption{entrega}{\idp@entregatrue}

% --- repasse para a classe base ---------------------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{bacharelado,secaonovapagina,semlinks}
\ProcessOptions\relax

\LoadClass[12pt,a4paper,oneside]{article}

%%-----------------------------------------------------------------------------
%% 2. CODIFICACAO, IDIOMA E FONTE (Times New Roman)
%%-----------------------------------------------------------------------------
\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{newtxtext}   % clone metrico de Times New Roman
  \RequirePackage{newtxmath}
\else
  \RequirePackage{fontspec}
  % TeX Gyre Termes e metricamente identico ao Times New Roman e sempre existe.
  % Se a fonte real estiver instalada no sistema, ela e preferida.
  \IfFontExistsTF{Times New Roman}
    {\setmainfont{Times New Roman}}
    {\setmainfont{TeX Gyre Termes}}
\fi

\RequirePackage[main=brazilian,english]{babel}
\RequirePackage{indentfirst}   % ABNT: o primeiro paragrafo tambem e indentado

%%-----------------------------------------------------------------------------
%% 3. GEOMETRIA DA PAGINA
%%    Medidas extraidas do PDF de referencia:
%%      margem esquerda 30 mm | direita 20 mm | superior 30 mm | inferior 20 mm
%%      numero de pagina com o topo a 20 mm da borda superior, alinhado a direita
%%-----------------------------------------------------------------------------
\RequirePackage[a4paper,
                left=30mm, right=20mm, top=30mm, bottom=20mm,
                headheight=14.5pt, headsep=4.89mm,
                footskip=10mm]{geometry}

%%-----------------------------------------------------------------------------
%% 4. ESPACAMENTO ENTRE LINHAS
%%    O template foi produzido no Word com Times New Roman 12 pt.
%%    Espacamento "simples" do Word  = 13,8 pt  -> stretch 0,9517
%%    Espacamento "1,5"     do Word  = 20,7 pt  -> stretch 1,4276
%%    (o LaTeX usa 14,5 pt como \baselineskip nativo em 12 pt)
%%-----------------------------------------------------------------------------
\RequirePackage{setspace}
\def\idp@stretchsimples{0.9517}
\def\idp@stretchumemeio{1.4276}

\newcommand{\espacosimples}{\setstretch{\idp@stretchsimples}}
\newcommand{\espacoumemeio}{\setstretch{\idp@stretchumemeio}}

% ATENCAO: \setstretch executa \@currsize, que reseleciona o TAMANHO corrente.
% Por isso todo bloco em corpo menor precisa mudar o espacamento ANTES do
% tamanho. \idpcorpo{tamanho}{entrelinha} faz isso na ordem certa.
\newcommand{\idpcorpo}[2]{\setstretch{1}\fontsize{#1}{#2}\selectfont}
\newcommand{\idpcorpodez}{\idpcorpo{10}{11.5}}   % citacoes longas, fontes, notas
\newcommand{\idpcorpoonze}{\idpcorpo{11}{12.65}} % ficha catalografica

% Altura de uma linha com espacamento 1,5 -- usada nos espacamentos verticais
\newlength{\idplinha}      \setlength{\idplinha}{20.7pt}
\newlength{\idplinhasimp}  \setlength{\idplinhasimp}{13.8pt}

\espacoumemeio

% Recuo de primeira linha: 1,25 cm (ABNT / template)
\setlength{\parindent}{1.25cm}
\setlength{\parskip}{0pt}

% Em portugues nao se usa espaco extra depois do ponto final
\frenchspacing

% Justificado, sem "overfull" agressivo
\RequirePackage{microtype}
\tolerance=1500
\emergencystretch=1em
\hyphenpenalty=200

%%-----------------------------------------------------------------------------
%% 5. TABULACAO DOS TITULOS (emula os tabuladores padrao do Word: 0,635 cm)
%%    "1"     -> titulo comeca a 0,635 cm
%%    "1.1"   -> titulo comeca a 0,635 cm
%%    "1.1.1" -> titulo comeca a 1,270 cm
%%-----------------------------------------------------------------------------
\newlength{\idp@tabstop} \setlength{\idp@tabstop}{6.35mm}
\newlength{\idp@lw}
\newlength{\idp@nw}
\newcommand{\idptabbox}[1]{%
  \settowidth{\idp@nw}{#1}%
  \addtolength{\idp@nw}{0.6mm}% exige um espaco minimo antes do proximo tabulador
  \setlength{\idp@lw}{\idp@tabstop}%
  \@whiledim\idp@lw<\idp@nw\do{\addtolength{\idp@lw}{\idp@tabstop}}%
  \makebox[\idp@lw][l]{#1}%
}

%%-----------------------------------------------------------------------------
%% 6. TITULOS DE SECAO (NBR 6024 / NBR 14724)
%%    1  SECAO PRIMARIA .... caixa alta + negrito
%%    1.1  Secao secundaria . negrito
%%    1.1.1 Secao terciaria . sem destaque
%%    1.1.1.1 quaternaria ... italico
%%    1.1.1.1.1 quinaria .... negrito + italico
%%    Separados do texto por uma linha em branco de 1,5 (antes e depois).
%%-----------------------------------------------------------------------------
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{4}

\titleformat{\section}[block]
  {\normalfont\normalsize\bfseries\raggedright}
  {\idptabbox{\thesection}}{0pt}{\MakeUppercase}
\titleformat{\subsection}[block]
  {\normalfont\normalsize\bfseries\raggedright}
  {\idptabbox{\thesubsection}}{0pt}{}
\titleformat{\subsubsection}[block]
  {\normalfont\normalsize\raggedright}
  {\idptabbox{\thesubsubsection}}{0pt}{}
\titleformat{\paragraph}[block]
  {\normalfont\normalsize\itshape\raggedright}
  {\idptabbox{\theparagraph}}{0pt}{}
\titleformat{\subparagraph}[block]
  {\normalfont\normalsize\bfseries\itshape\raggedright}
  {\idptabbox{\thesubparagraph}}{0pt}{}

\titlespacing{\section}      {0pt}{\idplinha}{\idplinha}
\titlespacing{\subsection}   {0pt}{\idplinha}{\idplinha}
\titlespacing{\subsubsection}{0pt}{\idplinha}{\idplinha}
\titlespacing{\paragraph}    {0pt}{\idplinha}{\idplinha}
\titlespacing{\subparagraph} {0pt}{\idplinha}{\idplinha}

% NBR 14724, 5.2.2: cada secao primaria comeca em folha propria.
\ifidp@novapagina
  \newcommand{\sectionbreak}{\clearpage}
\fi

% As secoes primarias aparecem em CAIXA ALTA tambem no sumario. Para isso o
% \section grava a entrada do sumario ja envolvida em \MakeUppercase (aplicar
% \MakeUppercase na leitura do .toc quebraria as ancoras do hyperref).
%
% O \texorpdfstring e OBRIGATORIO aqui, nao e refinamento: a mesma entrada vai
% para \addcontentsline, e o hyperref a converte em PDF string para montar o
% bookmark. Dentro do \pdfstringdef ele mapeia \MakeUppercase para
% \MakeUppercaseUnsupportedInPdfStrings, macro que so existe quando o kernel
% oferece \text_uppercase:n (LaTeX recente). Em kernel antigo esse macro NAO e
% definido e a compilacao morre com "undefined control sequence" ao gerar o
% bookmark. Com \texorpdfstring o \MakeUppercase nunca chega ao PDF string:
% o sumario sai em caixa alta e o bookmark sai em caixa normal.
\let\idp@origsection\section
\newcommand{\idp@sectionstar}[1]{\idp@origsection*{#1}}
\def\idp@sectionplain[#1]#2{%
  \idp@origsection[\texorpdfstring{\MakeUppercase{#1}}{#1}]{#2}}
\renewcommand{\section}{\@ifstar{\idp@sectionstar}{\@dblarg\idp@sectionplain}}

% Apelidos em portugues para quem preferir "capitulo"
\newcommand{\capitulo}{\section}
\newcommand{\subcapitulo}{\subsection}

%%-----------------------------------------------------------------------------
%% 7. CABECALHO: numero da pagina no canto superior direito
%%-----------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\fancypagestyle{idp}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyhead[R]{\normalfont\normalsize\thepage}%
}
\fancypagestyle{idpsemnumero}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{idpsemnumero}

%%-----------------------------------------------------------------------------
%% 8. NOTAS DE RODAPE -- fonte 10, espacamento simples, alinhadas a margem
%%-----------------------------------------------------------------------------
\RequirePackage[bottom,flushmargin]{footmisc}
\renewcommand{\footnotesize}{\fontsize{10}{11.5}\selectfont}
\renewcommand{\footnoterule}{%
  \vspace{2pt}\hrule width 0.4\columnwidth height 0.4pt\vspace{4pt}}
% Chamada na margem, texto da primeira linha recuado (padrao do template)
\renewcommand{\@makefntext}[1]{%
  \idpcorpodez\noindent\@thefnmark\hspace{10.9mm}#1}

%%-----------------------------------------------------------------------------
%% 9. CITACOES (NBR 10520)
%%    Citacao direta com mais de 3 linhas: recuo de 4 cm, fonte 10,
%%    espacamento simples, sem aspas, justificada.
%%-----------------------------------------------------------------------------
\newenvironment{citacao}{%
  \par\vspace{\idplinha}%
  \begin{list}{}{%
    \setlength{\leftmargin}{4cm}%
    \setlength{\rightmargin}{0pt}%
    \setlength{\listparindent}{0pt}%
    \setlength{\itemindent}{0pt}%
    \setlength{\labelwidth}{0pt}%
    \setlength{\labelsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}}%
  \item[]\idpcorpodez\noindent\ignorespaces
}{%
  \end{list}\par\vspace{\idplinha}%
}
% Versao em lingua estrangeira (NBR 10520: destacar em italico)
\newenvironment{citacaoestrangeira}{\begin{citacao}\itshape}{\end{citacao}}

%%-----------------------------------------------------------------------------
%% 10. FIGURAS, QUADROS, GRAFICOS E TABELAS
%%     Legenda ACIMA ("Figura 1 - Titulo"), fonte ABAIXO ("Fonte: ...").
%%     Ambas em fonte 10, centralizadas, espacamento simples.
%%-----------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage[labelsep=endash,justification=centering,
                skip=4pt,position=top]{caption}
\DeclareCaptionFont{idpcap}{\idpcorpodez}
\captionsetup{font=idpcap,labelfont=idpcap,textfont=idpcap}

\floatstyle{plaintop}          % legenda SEMPRE acima do elemento
\newfloat{quadro}{htbp}{loq}
\floatname{quadro}{Quadro}
\newfloat{gfc}{htbp}{lgr}
\floatname{gfc}{Gr\'afico}
% "grafico" e o nome amigavel do ambiente
\let\grafico\gfc
\let\endgrafico\endgfc

\captionsetup[quadro]{font=idpcap,labelfont=idpcap,position=top}
\captionsetup[gfc]{font=idpcap,labelfont=idpcap,position=top}
\captionsetup[figure]{position=top}
\captionsetup[table]{position=top}

% Linha "Fonte: ..." abaixo do elemento ilustrativo
\newcommand{\fonte}[1]{%
  \par\vspace{2pt}%
  {\centering\idpcorpodez\textbf{Fonte:}~#1\par}%
}
\newcommand{\nota}[1]{%
  \par\vspace{2pt}%
  {\centering\idpcorpodez\textbf{Nota:}~#1\par}%
}

%%-----------------------------------------------------------------------------
%% 11. LISTAS (itemize/enumerate) -- alinhadas com o recuo de paragrafo
%%-----------------------------------------------------------------------------
\RequirePackage{enumitem}
% Marcador a 1,25 cm da margem e texto a 1,88 cm (como no template)
\setlist{nosep,topsep=0pt,partopsep=0pt,parsep=0pt,itemsep=0pt,
         labelindent=1.25cm,leftmargin=1.88cm,labelwidth=0.63cm,
         labelsep=0pt,align=left}
\setlist[itemize,1]{label=\textbullet}

%%-----------------------------------------------------------------------------
%% 12. DADOS DO TRABALHO
%%-----------------------------------------------------------------------------
% --- Marcador de campo nao preenchido ---------------------------------------
% Os campos obrigatorios NAO tem valor padrao plausivel: eles nascem com um
% marcador que salta aos olhos no PDF e que a classe sabe reconhecer para
% avisar (ou abortar, com a opcao `entrega') se algo ficou por preencher.
% E texto puro de proposito -- assim sobrevive a \MakeUppercase e aos
% metadados do PDF sem quebrar nada.
% Nao use ">>>" nem "<<<": na codificacao T1 eles viram as ligaduras » e «.
\newcommand{\idp@campovazio}[1]{[[ PREENCHER: #1 ]]}

\newcount\idp@pendentes
\newcommand{\idp@confere}[2]{%
  \def\idp@tmp{\idp@campovazio{#1}}%
  \ifx#2\idp@tmp
    \global\advance\idp@pendentes by 1\relax
    \ClassWarningNoLine{idp}{Campo nao preenchido em config/dados.tex: #1}%
  \fi
}

\def\idp@instituicao{Instituto Brasileiro de Ensino, Desenvolvimento e Pesquisa
                     \textendash\ IDP}
\def\idp@titulo{\idp@campovazio{titulo}}
\def\idp@subtitulo{}
\def\idp@autor{\idp@campovazio{autor}}
\def\idp@autorficha{\idp@campovazio{autorficha}}
\def\idp@orientador{\idp@campovazio{orientador}}
\def\idp@coorientador{}
\def\idp@curso{\idp@campovazio{curso}}
\def\idp@programa{\idp@campovazio{programa}}
\def\idp@area{}              % area de concentracao (mestrado/doutorado)
\def\idp@linhapesquisa{}     % linha de pesquisa
\def\idp@titulotraduzido{}   % titulo em lingua estrangeira (para o abstract)
\def\idp@local{Bras\'ilia-DF}
\def\idp@cidade{Bras\'ilia}  % so a cidade, usada na folha de aprovacao
\def\idp@data{\the\year}
\def\idp@datadefesa{\idp@campovazio{datadefesa}}
\def\idp@palavraschave{\idp@campovazio{palavraschave}}
\def\idp@keywords{\idp@campovazio{keywords}}
\def\idp@cdd{\idp@campovazio{cdd}}
\def\idp@assuntos{}   % "1. Assunto. 2. Assunto." -- se vazio usa \palavraschave
\def\idp@cutter{}
\def\idp@paginas{\idp@campovazio{numeropaginas}}
\def\idp@tipotrabalho{}
\def\idp@preambulo{}
\def\idp@logo{figuras/idp-logo.png}   % use \semlogo para omitir

\newcommand{\instituicao}[1]{\def\idp@instituicao{#1}}
\newcommand{\titulo}[1]{\def\idp@titulo{#1}}
\newcommand{\subtitulo}[1]{\def\idp@subtitulo{#1}}
\renewcommand{\author}[1]{\def\idp@autor{#1}}
\newcommand{\autor}[1]{\def\idp@autor{#1}}
\newcommand{\autorficha}[1]{\def\idp@autorficha{#1}}
\newcommand{\orientador}[1]{\def\idp@orientador{#1}}
\newcommand{\coorientador}[1]{\def\idp@coorientador{#1}}
\newcommand{\curso}[1]{\def\idp@curso{#1}}
\newcommand{\programa}[1]{\def\idp@programa{#1}}
\newcommand{\area}[1]{\def\idp@area{#1}}
\newcommand{\linhapesquisa}[1]{\def\idp@linhapesquisa{#1}}
\newcommand{\titulotraduzido}[1]{\def\idp@titulotraduzido{#1}}
\newcommand{\local}[1]{\def\idp@local{#1}}
\newcommand{\cidade}[1]{\def\idp@cidade{#1}}
\renewcommand{\date}[1]{\def\idp@data{#1}}
\newcommand{\data}[1]{\def\idp@data{#1}}
% \datadefesa recebe SO a data; a cidade vem de \cidade, para nao repetir o
% mesmo dado em dois campos. Use \datadefesacompleta para controlar a linha
% inteira (ex.: "Aprovada em 15 de dezembro de 2026.").
\newcommand{\datadefesa}[1]{%
  \def\idp@datadefesa{\idp@cidade, #1.}}
\newcommand{\datadefesacompleta}[1]{\def\idp@datadefesa{#1}}
\newcommand{\palavraschave}[1]{\def\idp@palavraschave{#1}}
\newcommand{\keywords}[1]{\def\idp@keywords{#1}}
\newcommand{\cdd}[1]{\def\idp@cdd{#1}}
\newcommand{\assuntos}[1]{\def\idp@assuntos{#1}}
\newcommand{\cutter}[1]{\def\idp@cutter{#1}}
\newcommand{\numeropaginas}[1]{\def\idp@paginas{#1}}
\newcommand{\tipotrabalho}[1]{\def\idp@tipotrabalho{#1}}
\newcommand{\preambulo}[1]{\def\idp@preambulo{#1}}
\newcommand{\logo}[1]{\def\idp@logo{#1}}
\newcommand{\semlogo}{\let\idp@logo\@empty}

% --- Acessores publicos ------------------------------------------------------
% Permitem reaproveitar os dados no corpo do texto sem redigita-los. Ex.:
%   "Ao meu orientador, \NomeOrientador, pela paciencia..."
% Se o nome mudar em config/dados.tex, muda em todo lugar de uma vez.
\newcommand{\TituloTrabalho}{\idp@titulo}
\newcommand{\SubtituloTrabalho}{\idp@subtitulo}
\newcommand{\TituloTraduzido}{\idp@titulotraduzido}
\newcommand{\NomeAutor}{\idp@autor}
\newcommand{\NomeOrientador}{\idp@orientador}
\newcommand{\NomeCoorientador}{\idp@coorientador}
\newcommand{\NomeCurso}{\idp@curso}
\newcommand{\NomePrograma}{\idp@programa}
\newcommand{\NomeInstituicao}{\idp@instituicao}
\newcommand{\AreaConcentracao}{\idp@area}
\newcommand{\LinhaPesquisa}{\idp@linhapesquisa}
\newcommand{\LocalTrabalho}{\idp@local}
\newcommand{\CidadeTrabalho}{\idp@cidade}
\newcommand{\AnoTrabalho}{\idp@data}

% --- Verificacao dos campos obrigatorios ------------------------------------
% Roda depois que config/dados.tex ja foi lido. Sem a opcao `entrega' apenas
% avisa; com ela, aborta a compilacao -- assim e impossivel gerar a versao
% final com um ">>> PREENCHER <<<" perdido no meio do documento.
\AtBeginDocument{%
  \idp@confere{titulo}{\idp@titulo}%
  \idp@confere{autor}{\idp@autor}%
  \idp@confere{autorficha}{\idp@autorficha}%
  \idp@confere{orientador}{\idp@orientador}%
  \idp@confere{datadefesa}{\idp@datadefesa}%
  \idp@confere{palavraschave}{\idp@palavraschave}%
  \idp@confere{keywords}{\idp@keywords}%
  \idp@confere{cdd}{\idp@cdd}%
  \idp@confere{numeropaginas}{\idp@paginas}%
  % curso e programa sao mutuamente exclusivos: cobra so o que o nivel usa
  \ifx\idp@nivel\idp@n@mestrado
    \idp@confere{programa}{\idp@programa}%
  \else\ifx\idp@nivel\idp@n@doutorado
    \idp@confere{programa}{\idp@programa}%
  \else
    \idp@confere{curso}{\idp@curso}%
  \fi\fi
  \ifnum\idp@pendentes>0\relax
    \ifidp@entrega
      \ClassError{idp}{%
        \the\idp@pendentes\space campo(s) obrigatorio(s) nao preenchido(s) em
        config/dados.tex}{%
        Procure por "[[ PREENCHER" no PDF e pelas linhas "Campo nao
        preenchido" acima neste log.\MessageBreak
        Preencha config/dados.tex ou remova a opcao `entrega' da classe.}%
      \stop % aborta de fato: nao gera PDF de entrega incompleto
    \else
      \ClassWarningNoLine{idp}{%
        ATENCAO: \the\idp@pendentes\space campo(s) de config/dados.tex ainda
        nao preenchido(s).\MessageBreak
        Eles aparecem como ">>> PREENCHER: ... <<<" no PDF.\MessageBreak
        Use a opcao de classe `entrega' para transformar isto em erro}%
    \fi
  \fi
}

% Banca examinadora: \membrobanca[Instituicao]{Nome}{Funcao}
% A instituicao e opcional e sai numa terceira linha, sob a funcao -- util
% quando ha examinador externo ao IDP.
\newcommand{\idp@banca}{}
\newcommand{\membrobanca}[3][]{%
  \g@addto@macro\idp@banca{\idp@membro{#2}{#3}{#1}}%
}

% Titulo completo (titulo: subtitulo)
\newcommand{\idp@titulocompleto}{%
  \textbf{\idp@titulo}%
  \ifx\idp@subtitulo\@empty\else\textbf{:} \idp@subtitulo\fi
}

%%-----------------------------------------------------------------------------
%% 13. NATUREZA DO TRABALHO -- texto padrao por nivel
%%-----------------------------------------------------------------------------
\newcommand{\idp@preambulopadrao}{%
  \ifx\idp@nivel\idp@n@bacharelado
    Monografia apresentada como requisito para obten\c{c}\~ao do t\'itulo de
    bacharel em \idp@curso\ do \idp@instituicao.%
  \else\ifx\idp@nivel\idp@n@especializacao
    Monografia apresentada como requisito para obten\c{c}\~ao do t\'itulo de
    especialista em \idp@curso\ do \idp@instituicao.%
  \else\ifx\idp@nivel\idp@n@mestrado
    Disserta\c{c}\~ao apresentada ao programa de p\'os-gradua\c{c}\~ao em
    \idp@programa, como parte do requisito para a obten\c{c}\~ao do t\'itulo de
    Mestre em \idp@programa\ pelo \idp@instituicao.%
  \else
    Tese apresentada ao programa de p\'os-gradua\c{c}\~ao em \idp@programa,
    como parte do requisito para a obten\c{c}\~ao do t\'itulo de Doutor em
    \idp@programa\ pelo \idp@instituicao.%
  \fi\fi\fi
}
\def\idp@n@bacharelado{bacharelado}
\def\idp@n@especializacao{especializacao}
\def\idp@n@mestrado{mestrado}
\def\idp@n@doutorado{doutorado}

% \tipotrabalho{} sobrepoe o tipo deduzido do nivel (util p/ "Trabalho de
% Conclusao de Curso", "Relatorio Tecnico" etc. na ficha catalografica)
\newcommand{\idp@tipopadrao}{%
  \ifx\idp@tipotrabalho\@empty
    \ifx\idp@nivel\idp@n@mestrado Disserta\c{c}\~ao%
    \else\ifx\idp@nivel\idp@n@doutorado Tese%
    \else Monografia\fi\fi
  \else\idp@tipotrabalho\fi
}

% Bloco da natureza do trabalho: recuo de 8 cm, justificado, espacamento simples
\newcommand{\idp@blocopreambulo}{%
  \hspace*{8cm}%
  \begin{minipage}{\dimexpr\textwidth-8cm\relax}
    \espacosimples\setlength{\parindent}{0pt}\normalsize
    \ifx\idp@preambulo\@empty\idp@preambulopadrao\else\idp@preambulo\fi\par
    \ifx\idp@area\@empty\else
      \vspace{\idplinhasimp}\'Area de concentra\c{c}\~ao: \idp@area\par\fi
    \ifx\idp@linhapesquisa\@empty\else
      Linha de pesquisa: \idp@linhapesquisa\par\fi
    \vspace{\idplinhasimp}
    Orientador(a): \idp@orientador
    \ifx\idp@coorientador\@empty\else\par Coorientador(a): \idp@coorientador\fi
  \end{minipage}%
}

%%-----------------------------------------------------------------------------
%% 14. ELEMENTOS PRE-TEXTUAIS
%%-----------------------------------------------------------------------------
\newcommand{\idp@tituloelemento}[1]{%
  \clearpage
  \phantomsection
  {\centering\normalfont\normalsize\bfseries\MakeUppercase{#1}\par}%
  \vspace{\idplinha}%
}

% --- CAPA (nao e contada na paginacao) ---------------------------------------
\newcommand{\capa}{%
  \thispagestyle{empty}%
  \begin{center}
    \espacosimples
    \ifx\idp@logo\@empty
      \vspace*{35.4mm}%
    \else
      \vspace*{0mm}%
      {\includegraphics[height=36.3mm]{\idp@logo}\par}%
      \vspace{2.9mm}%
    \fi
    {\bfseries \idp@instituicao\par}
    {\bfseries Curso de \idp@curso\par}
    \vspace{81.1mm}
    {\setstretch{1}\fontsize{16}{19.2}\selectfont\idp@titulocompleto\par}
    \vspace{22.3mm}
    {\idp@autor\par}
    {Orientador: \idp@orientador\par}
    \vfill
    {\idp@local\par}
    {\idp@data\par}
    \vspace{4.6mm}
  \end{center}
  \clearpage
}

% --- FOLHA DE ROSTO (folha 1 da contagem) ------------------------------------
\newcommand{\folhaderosto}{%
  \setcounter{page}{1}%
  \thispagestyle{idpsemnumero}%
  \begin{center}
    \espacosimples
    {\bfseries\MakeUppercase{\idp@autor}\par}
    \vspace{54.6mm}
    {\setstretch{1}\fontsize{16}{19.2}\selectfont\idp@titulocompleto\par}
  \end{center}
  \vspace{7.3mm}
  \noindent\idp@blocopreambulo
  \vfill
  \begin{center}
    \espacosimples
    {\idp@local\par}
    {\idp@data\par}
    \vspace{5.7mm}
  \end{center}
  \clearpage
}

% --- FICHA CATALOGRAFICA -----------------------------------------------------
\newcommand{\fichacatalografica}{%
  \thispagestyle{idpsemnumero}%
  \null\vfill
  \begin{center}
  \idpcorpoonze
  \begin{minipage}{150mm}
    \setlength{\parindent}{0pt}
    \rule{\linewidth}{0.4pt}\par\vspace{2mm}
    \hspace*{0.6mm}\idp@cutter\hspace{10mm}\idp@autorficha\par\vspace{1.5mm}
    \hspace*{15mm}\begin{minipage}{\dimexpr\linewidth-18mm\relax}
      \idp@titulo\ifx\idp@subtitulo\@empty\else: \idp@subtitulo\fi\ /
      \idp@autor. \textendash\ Bras\'ilia: IDP, \idp@data.\par\vspace{2mm}
      \idp@paginas\ p.\par
      Inclui bibliografia.\par\vspace{2mm}
      Trabalho de Conclus\~ao de Curso (\idp@tipopadrao) \textendash\
      \idp@instituicao, Curso de \idp@curso, Bras\'ilia, \idp@data.\par
      Orientador: \idp@orientador.\par\vspace{2mm}
      \ifx\idp@assuntos\@empty\idp@palavraschave\else\idp@assuntos\fi\
      I. T\'itulo.\par
      \hfill CDD: \idp@cdd\par
    \end{minipage}\par\vspace{1mm}
    \rule{\linewidth}{0.4pt}
  \end{minipage}\par\vspace{3mm}
  {\idpcorpoonze
   Ficha catalogr\'afica elaborada pela Biblioteca Ministro Moreira Alves\par
   \idp@instituicao\par}
  \end{center}
  \vspace{8mm}
  {\centering\idpcorpodez\itshape
   A Biblioteca Ministro Moreira Alves oferece o servi\c{c}o de elabora\c{c}\~ao
   de fichas catalogr\'aficas; solicite via e-mail para
   biblioteca@idp.edu.br\par}
  \clearpage
}

% --- FOLHA DE APROVACAO ------------------------------------------------------
% #1 nome | #2 funcao | #3 instituicao (opcional)
\newcommand{\idp@membro}[3]{%
  \vspace{10.3mm}
  {\rule{80mm}{0.4pt}\par #1\par #2\par
   \if\relax\detokenize{#3}\relax\else #3\par\fi}%
}
\newcommand{\folhadeaprovacao}{%
  \thispagestyle{idpsemnumero}%
  \begin{center}
    \espacosimples
    {\bfseries\MakeUppercase{\idp@autor}\par}
    \vspace{9.7mm}
    {\bfseries\idp@titulo
     \ifx\idp@subtitulo\@empty\else: \idp@subtitulo\fi\par}
  \end{center}
  \vspace{16.5mm}
  \noindent\idp@blocopreambulo
  % espaco flexivel: encolhe se a banca tiver muitos membros
  \vspace{56.2mm minus 45mm}
  \begin{center}
    \espacosimples
    {\idp@datadefesa\par}
    \vspace{9.8mm}
    {\bfseries Banca Examinadora\par}
    \idp@banca
  \end{center}
  \clearpage
}

% --- DEDICATORIA / EPIGRAFE --------------------------------------------------
\newenvironment{dedicatoria}{%
  \clearpage\thispagestyle{idpsemnumero}%
  \null\vfill
  \noindent\hspace*{8cm}%
  \begin{minipage}{\dimexpr\textwidth-8cm\relax}
    \espacosimples\setlength{\parindent}{0pt}\itshape\ignorespaces
}{%
  \end{minipage}\par\vspace{20mm}\clearpage
}
\newenvironment{epigrafe}{%
  \clearpage\thispagestyle{idpsemnumero}%
  \null\vfill
  \noindent\hspace*{8cm}%
  \begin{minipage}{\dimexpr\textwidth-8cm\relax}
    \espacosimples\setlength{\parindent}{0pt}\itshape\raggedleft\ignorespaces
}{%
  \end{minipage}\par\vspace{20mm}\clearpage
}

% --- AGRADECIMENTOS ----------------------------------------------------------
\newenvironment{agradecimentos}{%
  \idp@tituloelemento{Agradecimentos}\espacoumemeio
}{\clearpage}

% --- RESUMO / ABSTRACT (NBR 6028: paragrafo unico, sem recuo, simples) -------
\newenvironment{resumo}{%
  \idp@tituloelemento{Resumo}%
  \espacosimples\setlength{\parindent}{0pt}\noindent\ignorespaces
}{%
  \par\vspace{2\idplinhasimp}%
  \noindent\textbf{Palavras-chave:} \idp@palavraschave
  \clearpage
}
\renewenvironment{abstract}{%
  \idp@tituloelemento{Abstract}%
  \espacosimples\setlength{\parindent}{0pt}\selectlanguage{english}\noindent\ignorespaces
}{%
  \par\vspace{2\idplinhasimp}%
  \noindent\textbf{Keywords:} \idp@keywords
  \selectlanguage{brazilian}\clearpage
}
% Resumo em outro idioma qualquer
\newenvironment{resumoestrangeiro}[2]{%
  \idp@tituloelemento{#1}%
  \espacosimples\setlength{\parindent}{0pt}\noindent\ignorespaces
  \def\idp@kwtmp{#2}%
}{%
  \par\vspace{2\idplinhasimp}%
  \noindent\textbf{\idp@kwtmp}
  \clearpage
}

%%-----------------------------------------------------------------------------
%% 15. LISTAS DE ILUSTRACOES, TABELAS, QUADROS, GRAFICOS E SIGLAS
%%-----------------------------------------------------------------------------
% Entradas das listas: "Figura 1 - Titulo ......... 14"
\newcommand{\idp@entradalista}[2]{%
  \titlecontents{#1}[0pt]
    {\espacoumemeio}
    {#2~\thecontentslabel\ \textendash\ }
    {}
    {\titlerule*[1.1mm]{.}\contentspage}%
}
\idp@entradalista{figure}{Figura}
\idp@entradalista{table}{Tabela}
\idp@entradalista{quadro}{Quadro}
\idp@entradalista{gfc}{Gr\'afico}

\newcommand{\idp@listaformato}[1]{%
  \begingroup
  \espacoumemeio
  \setlength{\parskip}{0pt}%
  #1%
  \endgroup
}
\newcommand{\listailustracoes}{%
  \idp@tituloelemento{Lista de Ilustra\c{c}\~oes}%
  \idp@listaformato{\@starttoc{lof}}\clearpage}
\newcommand{\listatabelas}{%
  \idp@tituloelemento{Lista de Tabelas}%
  \idp@listaformato{\@starttoc{lot}}\clearpage}
\newcommand{\listaquadros}{%
  \idp@tituloelemento{Lista de Quadros}%
  \idp@listaformato{\@starttoc{loq}}\clearpage}
\newcommand{\listagraficos}{%
  \idp@tituloelemento{Lista de Gr\'aficos}%
  \idp@listaformato{\@starttoc{lgr}}\clearpage}

% Lista de abreviaturas e siglas: sigla na margem, significado a 2,5 cm
\newenvironment{siglas}{%
  \idp@tituloelemento{Lista de Abreviaturas e Siglas}%
  \espacoumemeio
  \begin{list}{}{%
    \setlength{\labelwidth}{25mm}%
    \setlength{\leftmargin}{25mm}%
    \setlength{\labelsep}{0pt}%
    \setlength{\itemindent}{0pt}%
    \setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}%
    \setlength{\parsep}{0pt}\setlength{\itemsep}{0pt}%
    \renewcommand{\makelabel}[1]{##1\hfill}}%
}{\end{list}\clearpage}
\newcommand{\sigla}[2]{\item[#1]#2}

% Glossario simples (mesma estrutura)
\newenvironment{glossario}{%
  \idp@tituloelemento{Gloss\'ario}\espacoumemeio
  \begin{description}[leftmargin=0pt,style=nextline,font=\normalfont\bfseries]
}{\end{description}\clearpage}

%%-----------------------------------------------------------------------------
%% 16. SUMARIO (NBR 6027)
%%-----------------------------------------------------------------------------
\newcommand{\idp@toclabel}[1]{\idptabbox{#1}}
\contentsmargin{0pt}   % numero de pagina rente a margem direita

\titlecontents{section}[0pt]
  {\espacoumemeio\bfseries}
  {\idp@toclabel{\thecontentslabel}}
  {\idp@toclabel{}}
  {\titlerule*[1.1mm]{.}\contentspage}
\titlecontents{subsection}[0pt]
  {\espacoumemeio\bfseries}
  {\idp@toclabel{\thecontentslabel}}
  {\idp@toclabel{}}
  {\titlerule*[1.1mm]{.}\contentspage}
\titlecontents{subsubsection}[0pt]
  {\espacoumemeio}
  {\idp@toclabel{\thecontentslabel}}
  {\idp@toclabel{}}
  {\titlerule*[1.1mm]{.}\contentspage}
\titlecontents{paragraph}[0pt]
  {\espacoumemeio}
  {\idp@toclabel{\thecontentslabel}}
  {\idp@toclabel{}}
  {\titlerule*[1.1mm]{.}\contentspage}

\newcommand{\sumario}{%
  \idp@tituloelemento{Sum\'ario}%
  \begingroup
    \espacoumemeio
    \makeatletter\@starttoc{toc}\makeatother
  \endgroup
  \clearpage
}

% Entrada nao numerada no sumario (REFERENCIAS, APENDICES, ANEXOS...)
\newcommand{\idpaddtoc}[1]{%
  \phantomsection
  \addcontentsline{toc}{section}{\protect\numberline{}#1}%
}

%%-----------------------------------------------------------------------------
%% 17. PARTES DO DOCUMENTO
%%-----------------------------------------------------------------------------
\newcommand{\pretextual}{%
  \pagestyle{idpsemnumero}\pagenumbering{arabic}%
}
\newcommand{\textual}{%
  \clearpage
  \pagestyle{idp}\thispagestyle{idp}%
  \espacoumemeio
}
\newcommand{\postextual}{%
  \clearpage
  \pagestyle{idp}%
}

%%-----------------------------------------------------------------------------
%% 18. APENDICES E ANEXOS
%%-----------------------------------------------------------------------------
\newcounter{idp@apendice}
\newcounter{idp@anexo}
\newcommand{\apendice}[1]{%
  \clearpage\stepcounter{idp@apendice}%
  \idpaddtoc{AP\^ENDICE \Alph{idp@apendice} \textendash\ #1}%
  {\centering\bfseries AP\^ENDICE \Alph{idp@apendice} \textendash\
   \MakeUppercase{#1}\par}%
  \vspace{\idplinha}%
}
\newcommand{\anexo}[1]{%
  \clearpage\stepcounter{idp@anexo}%
  \idpaddtoc{ANEXO \Alph{idp@anexo} \textendash\ #1}%
  {\centering\bfseries ANEXO \Alph{idp@anexo} \textendash\
   \MakeUppercase{#1}\par}%
  \vspace{\idplinha}%
}

%%-----------------------------------------------------------------------------
%% 19. REFERENCIAS (NBR 6023) via biblatex-abnt
%%     - titulo destacado em negrito
%%     - autor repetido substituido por travessao
%%     - espacamento simples, alinhadas a esquerda, separadas por uma linha
%%-----------------------------------------------------------------------------
\RequirePackage[autostyle=true]{csquotes}
\RequirePackage[backend=biber,
                style=abnt,
                sorting=nyt,        % ordem alfabetica: nome, titulo, ano
                maxbibnames=99,     % NBR 6023: lista todos os autores
                minbibnames=99,
                maxcitenames=3,     % 4 ou mais autores -> "et al." na citacao
                mincitenames=1,
                giveninits=false,   % nomes por extenso (padrao do IDP)
                usedashes=true,     % autor repetido -> travessao (______.)
                repeatfields=false,
                accite=true,        % NBR 10520: autor em CAIXA ALTA entre parenteses
                ittitles=false,     % titulo em NEGRITO (como no template do IDP)
                natbib=true         % habilita \citeonline, \citet, \citep
               ]{biblatex}

\defbibheading{idpbib}[\refname]{}
\setlength{\bibitemsep}{\idplinhasimp}
\setlength{\bibhang}{0pt}

% Autor repetido: travessao no formato do template do IDP ("_______.").
% Com a opcao de classe `refautorrepetido' o nome e repetido por extenso,
% como determina a NBR 6023:2018.
\AtBeginDocument{%
  \ifidp@autorrepetido
    \ExecuteBibliographyOptions{usedashes=false}%
  \else
    \renewcommand*{\bibnameunderscore}{\underline{\hspace*{3.7em}}}%
    \renewcommand*{\bibnamedash}{\bibnameunderscore\addperiod\addspace}%
  \fi
}

\newcommand{\referencias}{%
  \clearpage
  \idpaddtoc{REFER\^ENCIAS}%
  {\centering\normalfont\normalsize\bfseries REFER\^ENCIAS\par}%
  \vspace{\idplinha}%
  \begingroup
    \espacosimples
    \raggedright
    \printbibliography[heading=idpbib]%
  \endgroup
}

% Aliases de citacao no estilo abntex2
\newcommand{\citeonline}[2][]{\textcite[#1]{#2}}
\newcommand{\citacaodireta}[3][]{(\textsc{#2}, #3)}

%%-----------------------------------------------------------------------------
%% 20. HIPERLINKS E METADADOS DO PDF
%%-----------------------------------------------------------------------------
\RequirePackage{xcolor}
\ifidp@links
  \RequirePackage[colorlinks=true,linkcolor=blue,citecolor=blue,
                  urlcolor=blue,breaklinks=true]{hyperref}
\else
  \RequirePackage[hidelinks,breaklinks=true]{hyperref}
\fi
\RequirePackage{url}
\urlstyle{same}

% Rede de seguranca: comandos da classe que porventura cheguem a um PDF string
% (bookmarks, \pdftitle, \pdfauthor) sao neutralizados aqui, em vez de
% dependerem do tratamento que cada versao do hyperref oferece.
% (\idp@campovazio nao precisa entrar aqui: ja produz texto puro.)
\pdfstringdefDisableCommands{%
  \let\idptabbox\@firstofone
  \let\espacosimples\@empty
  \let\espacoumemeio\@empty
  \let\idpcorpodez\@empty
  \let\idpcorpoonze\@empty
}

\AtBeginDocument{%
  \hypersetup{%
    pdftitle={\idp@titulo},
    pdfauthor={\idp@autor},
    pdfsubject={\idp@instituicao},
    pdfkeywords={\idp@palavraschave},
    pdfcreator={LaTeX com a classe idp.cls}}%
}

%%-----------------------------------------------------------------------------
%% 21. MARCA D'AGUA DE RASCUNHO (opcional)
%%-----------------------------------------------------------------------------
\ifidp@rascunho
  \RequirePackage{draftwatermark}
  \SetWatermarkText{RASCUNHO}
  \SetWatermarkScale{0.8}
  \SetWatermarkLightness{0.93}
\fi

%%-----------------------------------------------------------------------------
%% 22. AJUSTES FINAIS
%%-----------------------------------------------------------------------------
% Nomes em portugues para os elementos flutuantes
\AtBeginDocument{%
  \renewcommand{\figurename}{Figura}%
  \renewcommand{\tablename}{Tabela}%
  \renewcommand{\contentsname}{Sum\'ario}%
  \renewcommand{\listfigurename}{Lista de Ilustra\c{c}\~oes}%
  \renewcommand{\listtablename}{Lista de Tabelas}%
  \renewcommand{\refname}{Refer\^encias}%
  \renewcommand{\bibname}{Refer\^encias}%
}

% Evita paginas com linhas orfas/viuvas
\widowpenalty=10000
\clubpenalty=10000

\endinput
%%============================== fim de idp.cls ===============================
