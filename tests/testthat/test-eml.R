testthat::context("xsd/test/eml.xml")

testthat::test_that("We can parse the sample EML file correctly", {
  library("XML")

  f <- system.file("xsd/test", "eml.xml", package = "EML")
  eml <- read_eml(f)

  ## FIXME: even basic schema validation needs network connection for w3.org schema checks
  check <- eml_validate(eml)
  testthat::expect_true(check)

  write_eml(eml, "test.xml")
  check2 <- eml_validate("test.xml")
  testthat::expect_true(check2)

  unlink("test.xml")

})
