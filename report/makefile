all: parcial

parcial: relatorio_parcial.tex
	-pdflatex -interaction nonstopmode -shell-escape relatorio_parcial
	-bibtex notas_de_aula
	-pdflatex -interaction nonstopmode -shell-escape relatorio_parcial
	-pdflatex -interaction nonstopmode -shell-escape relatorio_parcial
