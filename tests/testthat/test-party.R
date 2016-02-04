
library("XML")
eml_file <- "inst/xsd/test/eml-party.xml"
root <- XML::xmlRoot(XML::xmlParse(eml_file))
removeAttributes(root)
p <- as(root, "party")
roundtrip <- as(p, "XMLInternalElementNode")

## identical except for namespace information in top node
testthat::expect_identical(
  saveXML(newXMLNode("party", xmlChildren(root))),
  saveXML(newXMLNode("party", xmlChildren(roundtrip)))
  )
#library("xml2")
#node <- read_xml(eml_file)
