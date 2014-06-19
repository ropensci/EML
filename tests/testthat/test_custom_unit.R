context("Custom units")


library("EML")
dat <- data.frame(river = factor(c("SAC",  
                                   "SAC",   
                                   "AM")),
                  spp   = c("Oncorhynchus tshawytscha",  
                            "Oncorhynchus tshawytscha", 
                            "Oncorhynchus kisutch"),
                  stg   = ordered(c("smolt", 
                                    "parr", 
                                    "smolt"), 
                                  levels=c("parr", 
                                           "smolt")), # => parr < smolt
                  ct    = c(293L,    
                            410L,    
                            210L),
                  day   = as.Date(c("2013-09-01", 
                                    "2013-09-1", 
                                    "2013-09-02")),
                  stringsAsFactors = FALSE)
col.defs <- c("River site used for collection",
              "Species scientific name",
              "Life Stage", 
              "count of live fish in traps",
              "day traps were sampled (usually in morning thereof)")

unit.defs <- list(
  c(SAC = "The Sacramento River",     # Factor 
    AM = "The American River"),
 "Scientific name",                   # Character string 
  c(parr = "third life stage",        # Ordered factor 
    smolt = "fourth life stage"),
  c(unit = "number", 
    precision = 1, 
    bounds = c(0, Inf)),              # Integer
  c(format = "YYYY-MM-DD",            # Date
    precision = 1))




test_that("We can define custom units", {
eml_reset_config()
  create_custom_unit(id = "metersSquaredPerHectare",
                       parentSI = "dimensionless",
                       unitType = "dimensionless",
                       multiplierToSI = "0.0001")

  custom_units <- mget("custom_units", envir = EML:::EMLConfig,
                       ifnotfound = list(list()))$custom_units
  expect_is(custom_units, "list")
  expect_equal(length(custom_units), 1)
  eml_reset_config()

               })


test_that("We can serialize custom units as valid EML", {

  create_custom_unit(id = "metersSquaredPerHectare",
                     parentSI = "dimensionless",
                     unitType = "dimensionless",
                     multiplierToSI = "0.0001",
                     description = "Square meters per hectare")

  eml_write(dat, col.defs = col.defs, unit.defs = unit.defs, file = "customunit.xml", contact = "Carl Boettiger <cboettig@ropensci.org>")
  o <- eml_validate("customunit.xml")
  expect_true(all(o)) # all cases validate
  unlink("*.xml")
  unlink("*.csv")
  eml_reset_config()

})



