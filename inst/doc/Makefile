VIGNETTE = reml_tutorial
PARSING = Advanced_parsing_of_EML
WRITING = Advanced_writing_of_EML

all: 
	make readme
	make writing
#	make basic
#	make vignette

readme: README.Rmd 
	Rscript -e 'require(knitr); knit("README.Rmd")'
	cp README.md ../../README.md
	sed -i 's/```r/```coffee/' ../../README.md

basic:  README.Rmd
	Rscript -e 'require(knitr); knit("README.Rmd")'
#	pandoc README.md -o ${VIGNETTE}.tex
#	mv ${VIGNETTE}.tex ${VIGNETTE}.Rnw
#	pandoc README.md -o ${VIGNETTE}.pdf

parsing: ${PARSING}.Rmd
	Rscript -e 'require(knitr); knit("${PARSING}.Rmd")'
	pandoc ${PARSING}.md -o ${PARSING}.pdf

writing: ${WRITING}.Rmd
	cd ../../vignettes
	Rscript -e 'require(knitr); knit("${WRITING}.Rmd")'
	pandoc ${WRITING}.md -o ${WRITING}.pdf
	cd -

#vignette: 
#	cp ${VIGNETTE}.Rnw ${VIGNETTE}.pdf ../../vignettes/


clean:
	rm -rf README.md *.csv *.xml ../tests/*.csv ../tests/*.xml ../tests/tmp ../../*.csv ../../*.xml ../../tmp
