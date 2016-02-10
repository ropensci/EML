testthat::context("xsd/test/eml.xml")

testthat::test_that("We can parse the sample EML file correctly", {
  library("XML")

  f <- system.file("xsd/test", "eml.xml", package = "eml2")
  eml <- read_eml(f)
  check <- eml_validate(eml)
  testthat::expect_equal(check$status, 0)

  write_eml(eml, "test.xml")
  check2 <- eml_validate("test.xml")
  testthat::expect_equal(check2$status, 0)

  unlink("test.xml")


  ## Sub-tests
  node <- xmlRoot(xmlParse(f))
  removeAttributes(node, .attrs = "xsi:schemaLocation")
  eml <- as(node, "eml")
  out <- as(eml, "XMLInternalElementNode")



  testthat::expect_identical(sort(names(xmlChildren(node[["dataset"]]))), sort(names(xmlChildren(out[["dataset"]]))))

  ## Nodes without repeated elements are identical (as text)
  sink("test.log")
  testthat::expect_identical(show(node[["dataset"]][["purpose"]]), show(out[["dataset"]][["purpose"]]))
  sink()
  unlink("test.log")

  ## Ordering differs
  #testthat::expect_identical(show(node[["dataset"]][["distribution"]]), showL(out[["dataset"]][["distribution"]]))

  #out[["dataset"]][["distribution"]]
  #node[["dataset"]][["distribution"]]


  ##testthat::expect_true()

})

