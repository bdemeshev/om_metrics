file_name = om_metrics_13

$(file_name).pdf: $(file_name).tex chapters/ figures/ preamble.tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -xelatex $(file_name).tex

	# clean auxillary files
	latexmk -c $(file_name).tex

	echo
	echo ---------------------------
	echo To make pngs use 'make png'

png:
	mkdir -p slides
	pdftocairo $(file_name).pdf slides/om_mtrcs-$(file_name) -png -r 300 -transp 

clean:
	latexmk -c $(file_name).tex
	-rm *.nav
	-rm *.snm
	-rm *.xdv

