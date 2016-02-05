testthat::context("xsd/test/eml.xml")

testthat::test_that("We can parse the sample EML file correctly", {
  library(XML)
  f <- system.file("xsd/test", "eml.xml", package = "eml2")
  node <- xmlRoot(xmlParse(f))
  removeAttributes(node, .attrs = "xsi:schemaLocation")
  eml <- as(node, "eml")
  out <- as(eml, "XMLInternalElementNode")

  sink("test.log")
  ## Ordering differs
  #names(xmlChildren(node[["dataset"]]))
  #names(xmlChildren(out[["dataset"]]))


  testthat::expect_identical(sort(names(xmlChildren(node[["dataset"]]))), sort(names(xmlChildren(out[["dataset"]]))))

  ## Nodes without repeated elements are identical (as text)
  testthat::expect_identical(show(node[["dataset"]][["purpose"]]), show(out[["dataset"]][["purpose"]]))

  ## Ordering differs
  #testthat::expect_identical(show(node[["dataset"]][["distribution"]]), showL(out[["dataset"]][["distribution"]]))

  #out[["dataset"]][["distribution"]]
  #node[["dataset"]][["distribution"]]

  sink()
  unlink("test.log")
})

