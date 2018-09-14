library(testthat)
library(eml2)

context("eml_get")


test_that("eml_get works on trivial calls", {
  f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
  eml <- read_eml(f)
  x <- eml_get(eml, "physical")
  expect_s3_class(x, "emld")
  y <- eml_get(eml, "attributeList")
  expect_length(y,3)
  expect_s3_class(y, "emld")
})

test_that("eml_get works on more calls", {
  f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
  my_eml <- read_eml(f)
  y <- eml_get(my_eml, "attributeName")
  expect_s3_class(y, "emld")

  y <- eml_get(my_eml$dataset$dataTable$attributeList$attribute[[1]], "attributeName")
})
