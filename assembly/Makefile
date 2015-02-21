assembly.pdf: assembly.tex
	pdflatex assembly.tex

assembly.epub: assembly.tex
	pandoc --self-contained -o assembly.epub --from=latex --to=epub assembly.tex

upload: all
	rsync -rv ./ philhag@atreus.technomancy.us:atreus/
