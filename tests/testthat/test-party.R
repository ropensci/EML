testthat::context("eml-party")

testthat::test_that("we can roundtrip parse and serialze test/eml-party.xml", {
  library("XML")
  eml_file <- system.file("xsd/test/", "eml-party.xml", package = "eml2")
  root <- XML::xmlRoot(XML::xmlParse(eml_file))
  removeAttributes(root)
  p <- as(root, "party")
  roundtrip <- as(p, "XMLInternalElementNode")

  sink("test.log")
  ## identical except for namespace information in top node
  testthat::expect_identical(show(roundtrip), show(root))
  sink()
  unlink("test.log")
})
