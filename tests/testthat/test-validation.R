testthat::context("Validating EML documents")

testthat::test_that("We return TRUE when validating valid documents", {
  library("XML")
  
  f <- system.file("examples", "example-eml-valid.xml", package = "EML")

  testthat::expect_true(eml_validate(f))
  testthat::expect_message(eml_validate(f), NA)
  
  
  f2 <- system.file("examples", "example-eml-valid-special-characters.xml", package = "EML")
  
  testthat::expect_true(eml_validate(f2, encoding = "latin1"))
  testthat::expect_message(eml_validate(f2, encoding = "latin1"), NA)
})

testthat::test_that("We return TRUE when validating valid eml objects", {
  library("XML")
  
  f <- system.file("examples", "example-eml-valid.xml", package = "EML")
  eml <- read_eml(f)
  testthat::expect_true(eml_validate(eml))
  testthat::expect_message(eml_validate(eml), NA)
  
  
  f2 <- system.file("examples", "example-eml-valid-special-characters.xml", package = "EML")
  eml2 <- read_eml(f2)
  testthat::expect_true(eml_validate(eml2, encoding = "latin1"))
  testthat::expect_message(eml_validate(eml2, encoding = "latin1"), NA)
})

testthat::test_that("We return FALSE and messages when validating invalid documents", {
  library("XML")
  
  f <- system.file("examples", "example-eml-invalid.xml", package = "EML")

  testthat::expect_false(eml_validate(f))
  testthat::expect_message(eml_validate(f))
})