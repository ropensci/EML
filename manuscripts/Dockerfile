# Use:
#  docker run -d -p 8787:8787 cboettig/eml 
#

FROM cboettig/ropensci:latest
MAINTAINER Carl Boettiger cboettig@ropensci.org

## Remain current
RUN apt-get update -qq && apt-get dist-upgrade -y

## LaTeX dependencies for building the manuscript
RUN apt-get install -y texlive-humanities lmodern texlive-fonts-recommended texlive-latex-extra

## This is stupidly large but easiest way to grab the various .sty files in use...
# RUN apt-get install texlive-full

## Install package, with dependencies and suggests
RUN Rscript -e 'install.packages(c("RHTMLForms", "RWordXML", "Sxslt"), repo="http://www.omegahat.org/R", type="source")'
RUN Rscript -e 'options(repos=c(CRAN="http://cran.rstudio.com")); devtools::install_github("ropensci/EML")'


## Clone the repo and switch into manscripts directory
RUN git clone http://github.com/ropensci/EML.git /tmp/EML
WORKDIR /tmp/EML/

## Compile the manuscript & supplement
# RUN Rscript -e 'rmarkdown::render("manuscript.Rmd")'
# RUN Rscript -e 'rmarkdown::render("supplement.Rmd")'

# RStudio server available on 8787
