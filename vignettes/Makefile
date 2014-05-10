VIGNETTE = README 
PARSING = Advanced_parsing_of_EML
WRITING = Advanced_writing_of_EML

all: 
	make README.md
	make ../README.md

README.md: README.Rmd 
	Rscript -e 'require(knitr); knit("README.Rmd")'

../README.md: README.md
	cp README.md ../../../README.md
	sed -i 's/```r/```coffee/' ../../../README.md


# ${PARSING}.pdf: ${PARSING}.Rmd
#	Rscript -e 'require(knitr); knit("${PARSING}.Rmd")'
#	pandoc ${PARSING}.md -o ${PARSING}.pdf

#${WRITING}.pdf: vignettes/${WRITING}.Rmd
#	cd vignettes
#	Rscript -e 'require(knitr); knit("${WRITING}.Rmd")'
#	pandoc ${WRITING}.md -o ${WRITING}.pdf
#	cd - 



clean:
	rm -rf cache/ *.csv *.xml ../tests/testthat/*.xml ../tests/testthat/*.csv ../*.csv ../*.xml 
