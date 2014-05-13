
## download this one from the archive... should consider removing this dependency from RWordXML in favor of jpeg package
download.file("http://cran.r-project.org/src/contrib/Archive/rimage/rimage_0.5-8.2.tar.gz", "rimage.tar.gz")
untar("rimage.tar.gz")
writeLines("", "rimage/NAMESPACE")
install.packages("rimage/", repos=NULL)

## Ugh, install_github fails on this one too!
download.file("https://github.com/omegahat/Rcompression/archive/master.zip", "Rcompression.zip", "wget")
unzip("Rcompression.zip")
setwd("Rcompression-master")
system("chmod a+x configure")
library("devtools")
install(".")

#install_github("Rcompression", "omegahat")
#install_github("ROOXML", "duncantl")
#install_github("RWordXML", "duncantl")
