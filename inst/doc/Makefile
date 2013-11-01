
vignette: vignette.Rmd
	Rscript -e 'require(knitr); knit("vignette.Rmd")'
	pandoc vignette.md -o reml.tex
	mv reml.tex reml.Rnw
	pandoc vignette.md -o reml.pdf
	cp reml.Rnw ../../vignettes/reml.Rnw
	cp reml.pdf ../../vignettes/reml.pdf

readme: vignette.Rmd 
	Rscript -e 'require(knitr); knit("vignette.Rmd")'
	cp vignette.md ../../README.md
	sed -i 's/```r/```coffee/' ../../README.md
