testthat::context("Validating EML documents")

testthat::test_that("We return TRUE when validating valid documents", {
  library("XML")

  f <-
    system.file("examples", "example-eml-valid.xml", package = "EML")

  testthat::expect_true(eml_validate(f))
  testthat::expect_message(eml_validate(f), NA)


  f2 <-
    system.file("examples",
                "example-eml-valid-special-characters.xml",
                package = "EML")

  testthat::expect_true(eml_validate(f2, encoding = "latin1"))
  testthat::expect_message(eml_validate(f2, encoding = "latin1"), NA)

  # Check that we properly validate each supported version of EML
  versions <- c("eml-2.1.1", "eml-2.1.0")
  for(version in versions) {
      eml <- system.file("examples", paste0("example-", version, ".xml"), package = "EML")
      testthat::expect_true(eml_validate(eml))
      testthat::expect_message(eml_validate(eml), NA)
  }
})

testthat::test_that("We return TRUE when validating valid eml objects", {
  library("XML")

  f <-
    system.file("examples", "example-eml-valid.xml", package = "EML")
  eml <- read_eml(f)
  testthat::expect_true(eml_validate(eml))
  testthat::expect_message(eml_validate(eml), NA)


  f2 <-
    system.file("examples",
                "example-eml-valid-special-characters.xml",
                package = "EML")
  eml2 <- read_eml(f2, encoding = "latin1")
  testthat::expect_true(eml_validate(eml2, encoding = "latin1"))
  testthat::expect_message(eml_validate(eml2, encoding = "latin1"), NA)
})

testthat::test_that("We return FALSE and messages when validating invalid documents", {
  library("XML")

  f <-
    system.file("examples", "example-eml-invalid.xml", package = "EML")

  testthat::expect_false(eml_validate(f))
  testthat::expect_message(eml_validate(f))
})
