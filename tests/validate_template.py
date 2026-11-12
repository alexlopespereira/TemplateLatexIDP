"""Compila casos reais dos quatro niveis e verifica o contrato publico da classe.

Requer xelatex, biber e pypdf. Execute a partir de qualquer pasta:
    python tests/validate_template.py
Use --engine pdflatex para verificar a compatibilidade legada.
"""
import argparse
import os
import re
import subprocess
from pathlib import Path

from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--engine', choices=['xelatex', 'pdflatex'], default='xelatex')
ENGINE = parser.parse_args().engine
BUILD = ROOT / '.build' / 'validation' / ENGINE
BUILD.mkdir(parents=True, exist_ok=True)


def run(args, ok=True):
    env = {**os.environ, 'LANG': 'C', 'LC_ALL': 'C', 'LC_CTYPE': 'C'}
    p = subprocess.run(args, cwd=ROOT, env=env, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT, text=True, encoding='utf-8', errors='replace')
    if ok and p.returncode:
        raise AssertionError(p.stdout[-6000:])
    return p


def compile_tex(name, body, ok=True, bibliography=False):
    src = BUILD / f'{name}.tex'
    src.write_text(body, encoding='utf-8')
    args = [ENGINE, '-halt-on-error', '-interaction=nonstopmode',
            f'-output-directory={BUILD.as_posix()}', src.as_posix()]
    result = run(args, ok=ok)
    if ok:
        if bibliography:
            run(['biber', f'--input-directory={BUILD.as_posix()}',
                 f'--output-directory={BUILD.as_posix()}', name])
        run(args)
        run(args)
    return result


compile_tex('ficha-teste', r'''\documentclass{article}
\begin{document}PDF DE TESTE -- FICHA CATALOGRAFICA\end{document}''')
ficha = (BUILD / 'ficha-teste.pdf').as_posix()


def fixture(level, official=True, missing=False):
    conf = ''
    if official:
        pdf = (BUILD / 'ausente.pdf').as_posix() if missing else ficha
        conf = rf'\arquivofichacatalografica{{{pdf}}}'
    else:
        conf = r'\autorficha{TESTE, Autor de}\cdd{000}\numeropaginas{1}'
    return rf'''\documentclass[{level},entrega]{{idp}}
\titulo{{Um titulo suficientemente longo para testar a quebra de linhas da capa sem alterar o tamanho da fonte}}
\subtitulo{{}}
\autor{{Autor de Teste}}
\orientador{{Profa. Dra. Orientadora de Teste}}
\curso{{Curso de Teste}}
\programa{{Programa de Teste}}
\area{{Area de Teste}}
\datadefesa{{11 de novembro de 2026}}
\palavraschave{{um; dois.}}
\keywords{{one; two.}}
\addbibresource{{{(ROOT / 'referencias.bib').as_posix()}}}
{conf}
\membrobanca[IDP]{{Orientadora de Teste}}{{Orientadora}}
\membrobancacomidentificador[IDP]{{Examinador de Teste}}{{Identificador de Teste A}}{{Examinador interno}}
\membrobancacomidentificador[Outra Universidade]{{Examinadora Externa de Teste}}{{Identificador de Teste B}}{{Examinadora externa}}
\membrobancacomidentificador[Outra Universidade]{{Examinador Externo de Teste}}{{Identificador de Teste C}}{{Examinador externo}}
\begin{{document}}
\pretextual\capa\folhaderosto\fichacatalografica\folhadeaprovacao
\begin{{resumo}}
Texto de teste do resumo.
\makeatletter\typeout{{IDPTEST-RESUMO=\f@size/\the\baselineskip}}\makeatother
\end{{resumo}}
\begin{{abstract}}Abstract de teste.
\makeatletter\typeout{{IDPTEST-ABSTRACT=\f@size/\the\baselineskip}}\makeatother
\end{{abstract}}
\sumario\textual
\section{{Introducao de teste}}
\typeout{{IDPTEST-PRIMARIA-A=\thepage}}
Texto de teste \parencite{{authier1982}}. \citeonline{{authier1982}}.
\subsection{{Secundaria de teste}}Texto.
\subsubsection{{Terciaria de teste}}Texto.
\paragraph{{Quaternaria de teste}}Texto.
\subparagraph{{Quinaria de teste}}Texto.
\section{{Segunda primaria}}
\typeout{{IDPTEST-PRIMARIA-B=\thepage}}
Texto final de teste \parencite{{abnt10520}}.
\begin{{figure}}[H]
\caption{{Figura de teste}}
\includegraphics[width=40mm]{{figuras/ilustracao-modelo-2026.png}}
\fonte[40mm]{{Fonte de teste.}}
\end{{figure}}
\nocite{{abnt10520,abnt6023,abnt14724,abnt6027}}
\referencias
\end{{document}}
'''


for level in ['bacharelado', 'especializacao', 'mestrado', 'doutorado']:
    compile_tex(level, fixture(level), bibliography=True)
    pdf = PdfReader(BUILD / f'{level}.pdf')
    text = '\n'.join(p.extract_text() or '' for p in pdf.pages)
    compact = re.sub(r'\s+', '', text)
    cover = pdf.pages[0].extract_text()
    expected = 'Programa de Teste' if level in ('mestrado', 'doutorado') else 'Curso de Teste'
    assert expected in re.sub(r'\s+', ' ', cover), cover
    assert 'Identificador de Teste A' in text and 'Identificador de Teste C' in text
    assert ('stricto sensu' in text) == (level in ('mestrado', 'doutorado'))
    assert 'PDF DE TESTE' in text, 'Ficha oficial nao foi incluida'
    assert 'RASCUNHO DE FICHA' not in text, 'Gerou ficha sintetica apesar do PDF oficial'
    captions = []
    for page in pdf.pages:
        def inspect_caption(value, cm, tm, font, size):
            if 'Figura' in value and 'teste' in value:
                captions.append((size, str((font or {}).get('/BaseFont', ''))))
        page.extract_text(visitor_text=inspect_caption)
    assert any(abs(size-9) < .15 and 'Italic' in font for size,font in captions), \
        'Legenda da figura diverge do tamanho/italico do modelo'
    assert 'Fonte de teste.' in text, 'Fonte com largura opcional nao foi renderizada'
    assert re.search(r'\(Authier-Reiriz,?\s+1982\)', text), 'Capitalizacao incorreta na citacao'
    assert 'AssociaçãoBrasileiradeNormasTécnicas,2023' in compact, \
        'Capitalizacao incorreta na citacao de entidade'
    assert compact.count('ASSOCIAÇÃOBRASILEIRADENORMASTÉCNICAS') == 4, \
        'Autoria repetida foi substituida por tracos nas referencias'
    log = (BUILD / f'{level}.log').read_text(encoding='utf-8', errors='replace')
    resumo = re.search(r'IDPTEST-RESUMO=([\d.]+)/([\d.]+)pt', log)
    abstract = re.search(r'IDPTEST-ABSTRACT=([\d.]+)/([\d.]+)pt', log)
    assert float(resumo[1]) == 12 and abs(float(resumo[2])-13.8) < .05
    assert float(abstract[1]) == 10 and abs(float(abstract[2])-11.5) < .05
    a, b = map(int, re.findall(r'IDPTEST-PRIMARIA-[AB]=(\d+)', log))
    assert b == a+1, 'Inseriu pagina para forcar paridade'
    assert all((p.extract_text() or '').strip() for p in pdf.pages), 'Pagina vazia de ajuste'
    assert 'Overfull \\vbox' not in log, 'Pagina excedeu a altura disponivel'
    assert 'Overfull \\hbox' not in log, 'Texto ou numero ultrapassou sua caixa'
    assert 'destination with the same identifier' not in log, 'Ancora de pagina duplicada'
    assert 'undefined' not in log.lower(), 'Referencia ou comando indefinido'
    print(f'OK {ENGINE}/{level}: capa, banca, ficha, resumos e paginas consecutivas', flush=True)

# Falhas necessarias: entrega sem ficha oficial e caminho inexistente.
r = compile_tex('sem-ficha', fixture('mestrado', official=False), ok=False)
assert r.returncode and 'Ficha catalografica oficial nao fornecida' in r.stdout
r = compile_tex('arquivo-ausente', fixture('mestrado', missing=True), ok=False)
assert r.returncode and 'PDF da ficha catalografica nao encontrado' in r.stdout
r = compile_tex('area-vazia', fixture('mestrado').replace(r'\area{Area de Teste}', r'\area{}'), ok=False)
assert r.returncode and 'Campo nao preenchido' in r.stdout

# Mantem os comandos antigos funcionando em modo de rascunho.
draft = fixture('bacharelado', official=False).replace('[bacharelado,entrega]', '[bacharelado]')
compile_tex('rascunho', draft, bibliography=True)
text = '\n'.join(p.extract_text() or '' for p in PdfReader(BUILD / 'rascunho.pdf').pages)
assert 'RASCUNHO DE FICHA' in text
assert 'elaborada pela Biblioteca' not in text
print('OK protecoes da ficha oficial e compatibilidade do rascunho')

# O termo usa seu proprio modelo e reaproveita os dados do trabalho.
compile_tex('termo-modelo', (ROOT / 'termo-autoria-ia.tex').read_text(encoding='utf-8'))
pdf = PdfReader(BUILD / 'termo-modelo.pdf')
assert len(pdf.pages) == 1, 'Termo do exemplo nao cabe em uma pagina'
text = re.sub(r'\s+', ' ', pdf.pages[0].extract_text())
compact = re.sub(r'\s+', '', text)
assert re.sub(r'\s+', '', str(pdf.metadata.author)) in compact
assert re.sub(r'\s+', '', str(pdf.metadata.title)) in compact
assert list(map(int, re.findall(r'([1-6])\.(?:Declaro|Quanto|Quando)', compact))) == list(range(1, 7))
assert compact.count('()') == 11, 'Opcoes do termo ausentes ou marcadas'
print(f'OK {ENGINE}/termo: uma pagina, seis clausulas, dados e opcoes em branco')
