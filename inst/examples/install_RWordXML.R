
download.file("http://cran.r-project.org/src/contrib/Archive/rimage/rimage_0.5-8.2.tar.gz", "rimage.tar.gz")
untar("rimage.tar.gz")
writeLines("", "rimage/NAMESPACE")
install.packages("rimage/", repos=NULL)
library("devtools")
install_github("RWordXML", "duncantl")
