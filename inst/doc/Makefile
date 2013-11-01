
vignette: vignette.Rmd
	Rscript -e 'require(knitr); knit("vignette.Rmd")'
	pandoc vignette.md -o vignette.tex
	pandoc vignette.md -o vignette.pdf
	mv vignette.tex ../../vignettes/vignette.Rnw
	mv vignette.pdf ../../vignettes/vignette.pdf
