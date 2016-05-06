testthat::context("Validating EML documents")

testthat::test_that("We return TRUE when validating valid documents", {
  library("XML")
  
  f <- system.file("examples", "example-eml-valid.xml", package = "EML")

  testthat::expect_true(eml_validate(f))
  testthat::expect_message(eml_validate(f), NA)
})

testthat::test_that("We return FALSE and messages when validating invalid documents", {
  library("XML")
  
  f <- system.file("examples", "example-eml-invalid.xml", package = "EML")

  testthat::expect_false(eml_validate(f))
  testthat::expect_message(eml_validate(f))
})