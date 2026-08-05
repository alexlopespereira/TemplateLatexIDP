# Configuracao do latexmk para o template do IDP.
# Uso: latexmk -pdf main.tex   |   latexmk -c (limpa)   |   latexmk -C (limpa tudo)

$pdf_mode = 1;              # pdflatex
$bibtex_use = 2;
$biber = 'biber --input-encoding=utf8 --output-encoding=utf8 %O %S';
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 -file-line-error %O %S';

# Extensoes geradas pelas listas personalizadas (quadros e graficos)
push @generated_exts, 'loq', 'lgr', 'lof', 'lot', 'bcf', 'run.xml', 'synctex.gz';
$clean_ext .= ' %R.loq %R.lgr %R.bbl %R.run.xml %R.synctex.gz';
