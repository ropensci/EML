VIGNETTE = README 
PARSING = Advanced_parsing_of_EML
WRITING = Advanced_writing_of_EML

all: 
	make README.md
	make ../../../README.md
#	make README.pdf
#	make writing
#	make basic
#	make vignette

README.md: README.Rmd 
	Rscript -e 'require(knitr); knit("README.Rmd")'

../../../README.md: README.md
	cp README.md ../../../README.md
	sed -i 's/```r/```coffee/' ../../../README.md

#README.pdf:  README.Rmd
#	Rscript -e 'require(knitr); knit("README.Rmd")'
#	pandoc README.md -o ${VIGNETTE}.tex
#	mv ${VIGNETTE}.tex ${VIGNETTE}.Rnw
#	pandoc README.md -o ${VIGNETTE}.pdf

# ${PARSING}.pdf: ${PARSING}.Rmd
#	Rscript -e 'require(knitr); knit("${PARSING}.Rmd")'
#	pandoc ${PARSING}.md -o ${PARSING}.pdf

#${WRITING}.pdf: vignettes/${WRITING}.Rmd
#	cd vignettes
#	Rscript -e 'require(knitr); knit("${WRITING}.Rmd")'
#	pandoc ${WRITING}.md -o ${WRITING}.pdf
#	cd - 


#vignette: 
#	cp ${VIGNETTE}.Rnw ${VIGNETTE}.pdf ../../vignettes/


clean:
	rm -rf README.md *.csv *.xml ../../../tests/testthat/*.xml ../../../tests/testthat/*.csv ../../../*.csv ../../../*.xml ../../../tmp
