testthat::context("Additional tests")

test_that("template constructor", {
  creator <- EML:::template_constructor("creator")
  expect_is(creator, "function")
})

test_that("we can validate an xml_document", {
  f <- system.file("extdata", "example.xml", package = "emld")
  x <- xml2::read_xml(f)
  expect_true(eml_validate(x))
})


test_that("set_physical can compute file size automatically", {
  #file.copy(system.file("examples","hf205-01-TPexp1.csv", package="EML"),
  #          "hf205-01-TPexp1.csv")
  skip_if_not(file.exists("hf205-01-TPexp1.csv"))
  expect_message(
    physical <-
      set_physical("hf205-01-TPexp1.csv"),
    "calculated file size"
  )
})

test_that("set_method with additional input files", {

  skip_on_appveyor()
  skip_on_cran()

  coverage <-
    set_coverage(
      date = c("2012-06-01", "2013-12-31"),
      sci_names = "Sarracenia purpurea",
      geographicDescription = "text",
      west = -122.44, east = -117.15,
      north = 37.38, south = 30.00,
      altitudeMin = 160, altitudeMaximum = 330,
      altitudeUnits = "meter"
    )
  expect_is(coverage$geographicCoverage, "list")
  file <- system.file("examples", "hf205-methods.docx", package = "EML")
  methods <- set_methods(file,
    qualityControl_file = file,
    sampling_file = file,
    sampling_coverage = coverage
  )
  expect_is(methods$sampling, "list")
})
