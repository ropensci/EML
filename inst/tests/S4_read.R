

context("Parsing XML into S4")
f <- system.file("examples", "hf205.xml",  "reml")
root <- xmlRoot(xmlParse(f))
s4_eml <- as(root, "eml")
