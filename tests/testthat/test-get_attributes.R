context("get_attributes")

test_that("get_attributes returns attributes", {
  file <- system.file("tests", emld::eml_version(),
    "eml-datasetWithAttributelevelMethods.xml",
    package = "emld"
  )
  eml <- read_eml(file)
  x <- eml$dataset$dataTable$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  expect_gt(nrow(attributes), 0)
  expect_gt(ncol(attributes), 0)
  expect_null(factors)
})

test_that("get_attributes returns attributes and factors", {
  file <- system.file("tests",
    emld::eml_version(),
    "eml-i18n.xml",
    package = "emld"
  )
  eml <- read_eml(file)
  x <- eml$dataset$dataTable$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  expect_gt(nrow(attributes), 0)
  expect_gt(ncol(attributes), 0)
  expect_gt(nrow(factors), 0)
  expect_gt(ncol(factors), 0)
})

test_that("get_attributes works with references", {
  file <- system.file("tests",
    emld::eml_version(),
    "eml-i18n.xml",
    package = "emld"
  )
  eml <- EML::read_eml(file)
  eml$dataset$dataTable$attributeList$id <- "att_id"
  dataTable_2 <- list(
    entityName = "entityName",
    attributeList = list(references = "att_id")
  )
  eml$dataset$dataTable <- list(eml$dataset$dataTable, dataTable_2)

  expect_true(eml_validate(eml))

  x <- eml$dataset$dataTable[[2]]$attributeList

  expect_warning(get_attributes(x))

  x <- eml$dataset$dataTable[[1]]$attributeList
  df <- get_attributes(x, eml)
  attributes <- df$attributes
  factors <- df$factors

  expect_gt(nrow(attributes), 0)
  expect_gt(ncol(attributes), 0)
  expect_gt(nrow(factors), 0)
  expect_gt(ncol(factors), 0)
})

test_that("get_attributes errors when not used with an attributeList", {
  file <- system.file("tests", emld::eml_version(),
                      "eml-datasetWithAttributelevelMethods.xml",
                      package = "emld"
  )
  eml <- read_eml(file)
  
  x <- eml$dataset$dataTable
  y <- eml$dataset$dataTable$attributeList$attribute
  
  expect_error(get_attributes(x))
  expect_error(get_attributes(y))
})
