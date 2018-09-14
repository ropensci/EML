testthat::context("get_attributes")

testthat::test_that("get_attributes returns attributes", {

  file <- system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "EML")
  eml <- read_eml(file)
  x <- eml$dataset$dataTable$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  testthat::expect_gt(nrow(attributes), 0)
  testthat::expect_gt(ncol(attributes), 0)
  testthat::expect_null(factors)
})

testthat::test_that("get_attributes returns attributes and factors", {

  file <- system.file("xsd/test/eml-i18n.xml", package = "EML")
  eml <- read_eml(file)
  x <- eml$dataset$dataTable$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  testthat::expect_gt(nrow(attributes), 0)
  testthat::expect_gt(ncol(attributes), 0)
  testthat::expect_gt(nrow(factors), 0)
  testthat::expect_gt(ncol(factors), 0)
})

testthat::test_that("get_attributes works with references", {

  file <- system.file("xsd/test/eml-i18n.xml", package = "EML")
  eml <- eml2::read_eml(file)
  eml$dataset$dataTable$attributeList$id <- "att_id"
  dataTable_2 <- list(entityName = "entityName",
                      attributeList = list(references = "att_id"))
  eml$dataset$dataTable <- list(eml$dataset$dataTable, dataTable_2)

  testthat::expect_true(eml_validate(eml))

  x <- eml$dataset$dataTable[[2]]$attributeList

  testthat::expect_warning(get_attributes(x))

  x <- eml$dataset$dataTable[[1]]$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  testthat::expect_gt(nrow(attributes), 0)
  testthat::expect_gt(ncol(attributes), 0)
  testthat::expect_gt(nrow(factors), 0)
  testthat::expect_gt(ncol(factors), 0)
})
