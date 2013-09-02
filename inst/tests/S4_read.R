context("Parsing XML into S4")

## test basic reading

library(XML)
require(reml)
f <- system.file("examples", "hf205.xml",  package="reml")
root <- xmlRoot(xmlParse(f))
s4_eml <- as(root, "eml")


## Test higher-level method (e.g. calls parsing internally)
