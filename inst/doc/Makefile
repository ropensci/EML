VIGNETTE = reml_tutorial

all: 
	make vignette
	make readme

vignette: README.Rmd
	Rscript -e 'require(knitr); knit("README.Rmd")'
	pandoc README.md -o ${VIGNETTE}.tex
	mv ${VIGNETTE}.tex ${VIGNETTE}.Rnw
	pandoc README.md -o ${VIGNETTE}.pdf
	cp ${VIGNETTE}.Rnw ../../vignettes/
	cp ${VIGNETTE}.pdf ../../vignettes/

readme: README.Rmd 
	Rscript -e 'require(knitr); knit("README.Rmd")'
	cp README.md ../../README.md
	sed -i 's/```r/```coffee/' ../../README.md

clean:
	rm README.md 
