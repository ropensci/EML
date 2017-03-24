testthat::context("Creating custom units")


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
testthat::expect_is(x, "unitList")
testthat::expect_equal(length(x@unit), 2)
testthat::expect_equal(length(x@unitType), 3)

x <- set_unitList(units, unitTypes, as_metadata = TRUE)
testthat::expect_is(x, "additionalMetadata")


testthat::context("Reading default unit definitions")

f <- system.file("xsd/eml-2.1.1/eml-unitDictionary.xml", package = "EML")
eml <- read_eml(f)
unitList <- get_unitList(eml)

testthat::expect_equal(dim(unitList$units), c(195, 8))
testthat::expect_equal(dim(unitList$unitTypes), c(118, 4))


testthat::context("Reading custom unit definitions from EML")

f <-
  system.file("xsd/test/eml-datasetWithUnits.xml", package = "EML")
eml <- read_eml(f)
unitList <- get_unitList(eml@additionalMetadata[[1]]@metadata)




unitList <- set_unitList(units, unitTypes)

## reverse operation also works:
get_unitList(unitList)

## To add this to an EML document:
eml <-
  new("eml", additionalMetadata = as(unitList, "additionalMetadata"))

## Equivalently:
additionalMetadata <-
  set_unitList(units, unitTypes, as_metadata = TRUE)
eml <- new("eml", additionalMetadata = additionalMetadata)
