testthat::context("eml-party")

test_that("we can roundtrip parse and serialze test/eml-party.xml", {
  library("XML")
  eml_file <- system.file("xsd/test/", "eml-party.xml", package = "eml2")
  root <- XML::xmlRoot(XML::xmlParse(eml_file))
  removeAttributes(root)
  p <- as(root, "party")
  roundtrip <- as(p, "XMLInternalElementNode")

  ## identical except for namespace information in top node
  testthat::expect_identical(
    saveXML(newXMLNode("party", xmlChildren(root))),
    saveXML(newXMLNode("party", xmlChildren(roundtrip)))
    )

})
