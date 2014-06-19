VIGNETTE = README 
PARSING = Advanced_parsing_of_EML
WRITING = Advanced_writing_of_EML

all: 
	make README.md
	make ../README.md

README.md: README.Rmd 
	Rscript -e 'require(knitr); knit("README.Rmd")'

../README.md: README.md
	cp README.md ../README.md


# ${PARSING}.pdf: ${PARSING}.Rmd
#	$(R_HOME)/bin/Rscript -e 'require(knitr); knit("${PARSING}.Rmd")'
#	pandoc ${PARSING}.md -o ${PARSING}.pdf

#${WRITING}.pdf: vignettes/${WRITING}.Rmd
#	cd vignettes
#	"$(R_HOME)/bin/Rscript -e 'require(knitr); knit("${WRITING}.Rmd")'
#	pandoc ${WRITING}.md -o ${WRITING}.pdf
#	cd - 



clean:
	rm -rf cache/ *.csv *.xml ../tests/testthat/*.xml ../tests/testthat/*.csv ../*.csv ../*.xml 
