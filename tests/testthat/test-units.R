testthat::context("Units")


test_that("Creating custom units", {
  id <-
    c("speed", "speed", "acceleration", "acceleration", "frequency")
  dimension <- c("length", "time", "length", "time", "time")
  power <- c(NA, "-1", NA, "-2", "-1")
  unitTypes <-
    data.frame(
      id = id,
      dimension = dimension,
      power = power,
      stringsAsFactors = FALSE
    )

  id <- c("minute", "centimeter")
  unitType <- c("time", "length")
  parentSI <- c("second", "meter")
  multiplierToSI <- c("0.0166", "1")
  description <-
    c("one minute is 60 seconds", "centimeter is a 100th of a meter")
  units <-
    data.frame(
      id = id,
      unitType = unitType,
      parentSI = parentSI,
      multiplierToSI = multiplierToSI,
      description = description,
      stringsAsFactors = FALSE
    )

  x <- set_unitList(units, unitTypes)
  testthat::expect_is(x, "list")
  testthat::expect_equal(length(x$unit), 2)
  testthat::expect_equal(length(x$unitType), 3)

  x <- set_unitList(units, unitTypes, as_metadata = TRUE)
  testthat::expect_is(x, "list")
})



test_that("Reading default unit definitions", {
  unitList <- get_unitList()

  testthat::expect_equal(dim(unitList$units), c(335, 10))
  # testthat::expect_equal(dim(unitList$unitTypes), c(118, 4))
  testthat::expect_equal(dim(unitList$unitTypes), c(297, 4))
})



test_that("Reading custom unit definitions from EML", {
  f <- system.file("tests", emld::eml_version(), "eml-datasetWithUnits.xml", package = "emld")
  eml <- read_eml(f)
  unitList <- get_unitList(eml)
  expect_is(unitList, "list")

  x <- set_unitList(unitList$units, unitList$unitTypes)
  expect_is(x, "list")


  ## Equivalently:
  additionalMetadata <- set_unitList(unitList$units,
    unitList$unitTypes,
    as_metadata = TRUE
  )
  eml <- list(additionalMetadata = additionalMetadata)
})
