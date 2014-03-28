
all:
	make manuscript.md 
	make manuscript.pdf 

README.md: README.Rmd 
	Rscript -e 'require(knitr); opts_knit[["set"]](upload.fun = imgur_upload); knit("../vignettes/README.Rmd")'

../../../README.md: README.md
	cp README.md ../../../README.md
	sed -i 's/```r/```coffee/' ../../../README.md

../../../vignettes/README.Rmd: README.Rmd
	cp README.Rmd ../../../vignettes/README.Rmd


manuscript.md: manuscript.Rmd
	Rscript -e 'require(knitr); opts_knit[["set"]](upload.fun = imgur_upload); knit("manuscript.Rmd")'
	sed -i 's/```r/```coffee/' manuscript.md

manuscript.pdf: manuscript.Rmd
	Rscript -e 'require(knitr); opts_chunk[["set"]](dev='pdf'); knit("manuscript.Rmd", "tmp.md")'
	pandoc tmp.md --template elsarticle.latex -o manuscript.pdf
	rm tmp.md 

