testthat::context("Validating EML documents")

testthat::test_that("We return TRUE when validating valid documents", {

  f <-
    system.file("examples", "example-eml-valid.xml", package = "EML")

  testthat::expect_true(eml_validate(f))
  testthat::expect_message(eml_validate(f), NA)
  testthat::expect_length(attr(eml_validate(f), "errors"), 0)


  f2 <-
    system.file("examples",
                "example-eml-valid-special-characters.xml",
                package = "EML")

  v <- eml_validate(f2, encoding = "latin1")
  testthat::expect_true(v)
  testthat::expect_message(v, NA)
  testthat::expect_length(attr(v, "errors"), 0)


  # Check that we properly validate each supported version of EML
  versions <- c("eml-2.1.1", "eml-2.1.0")
  for(version in versions) {
      f <- system.file("examples", paste0("example-", version, ".xml"), package = "EML")
      testthat::expect_true(eml_validate(f))
  }
})

testthat::test_that("We return TRUE when validating valid eml objects", {

  f <-
    system.file("examples", "example-eml-valid.xml", package = "EML")
  eml <- read_eml(f)
  testthat::expect_true(eml_validate(f))
  testthat::expect_message(eml_validate(f), NA)


  f2 <-
    system.file("examples",
                "example-eml-valid-special-characters.xml",
                package = "EML")
  eml2 <- read_eml(f2, encoding = "latin1")
  testthat::expect_true(eml_validate(eml2, encoding = "latin1"))
  testthat::expect_message(eml_validate(eml2, encoding = "latin1"), NA)
})

testthat::test_that("We return FALSE and messages when validating invalid documents", {

  f <-
    system.file("examples", "example-eml-invalid.xml", package = "EML")

  v <- eml_validate(f)
  testthat::expect_false(v)
  testthat::expect_length(attr(v, "errors"), 1)
  #testthat::expect_message(eml_validate(f)) # errors now returned as attributes of the return object, which is easier to compute on


})


testthat::test_that("We can handle validation against sub-schema alone (e.g. against eml-access.xsd)",{
  f <- system.file("xsd/test/eml-access.xml", package = "EML")
  v <- eml_validate(f)
  testthat::expect_true(v)
  testthat::expect_length(attr(v, "errors"), 0)

})


testthat::test_that("We return TRUE when validating a valid just created eml object with latin1 encoding", {
  ex <- system.file("examples", "create-full-eml.R", package = "EML")
  source(ex)


  v <- eml_validate(eml, encoding = "latin1")
  testthat::expect_true(v)
  testthat::expect_message(v, NA)
  testthat::expect_length(attr(v, "errors"), 0)


})


testthat::test_that("We return TRUE when validating a valid just created eml object", {
  ex <- system.file("examples", "create-full-eml.R", package = "EML")
  source(ex)

  v <- eml_validate(eml)
  testthat::expect_true(v)
  testthat::expect_message(v, NA)
  testthat::expect_length(attr(v, "errors"), 0)

})

