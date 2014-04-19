context("Custom units")


library(EML)
dat = data.set(river = c("SAC",  "SAC",   "AM"),
               spp   = c("king",  "king", "ccho"),
               stg   = c("smolt", "parr", "smolt"),
               ct    = c(293L,    410L,    210L),
               col.defs = c("River site used for collection",
                            "Species common name",
                            "Life Stage", 
                            "density of fish traps in trap area per river area"),
               unit.defs = list(c(SAC = "The Sacramento River", 
                                  AM = "The American River"),
                                c(king = "King Salmon", 
                                  ccho = "Coho Salmon"),
                                c(parr = "third life stage", 
                                  smolt = "fourth life stage"),
                                "metersSquaredPerHectare"))


test_that("We can define custom units", {
  rm("custom_units", envir = EML:::EMLConfig)
  create_custom_unit(id = "metersSquaredPerHectare",
                       parentSI = "dimensionless",
                       unitType = "dimensionless",
                       multiplierToSI = "0.0001")

  custom_units <- mget("custom_units", envir = EML:::EMLConfig,
                       ifnotfound = list(list()))$custom_units
  expect_is(custom_units, "list")
  expect_equal(length(custom_units), 1)

               })


test_that("We can serialize custom units as valid EML", {

  create_custom_unit(id = "metersSquaredPerHectare",
                     parentSI = "dimensionless",
                     unitType = "dimensionless",
                     multiplierToSI = "0.0001",
                     description = "Square meters per hectare")

  eml_write(dat, file = "customunit.xml", contact = "Carl Boettiger <cboettig@ropensci.org>")
  o <- eml_validate("customunit.xml")
  expect_true(all(o)) # all cases validate
  unlink("*.xml")
  unlink("*.csv")

})



