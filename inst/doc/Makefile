
vignette: vignette.Rmd
	Rscript -e 'require(knitr); knit("vignette.Rmd")'
	pandoc vignette.md -o vignette.tex
	pandoc vignette.md -o vignette.pdf
	mv vignette.tex ../../vignettes/reml.Rnw
	mv vignette.pdf ../../vignettes/reml.pdf

readme: vignette.Rmd 
	Rscript -e 'require(knitr); knit("vignette.Rmd")'
	cp vignette.md ../../README.md
	sed -i 's/```r/```coffee/' ../../README.md
