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
  unit <- eml_define_unit(id = "metersSquaredPerHectare",
                       parentSI = "dimensionless",
                       unitType = "dimensionless",
                       multiplierToSI = "0.0001")


               })


test_that("We can serialize custom units as valid EML", {

 unit <-  eml_define_unit(id = "metersSquaredPerHectare",
                     parentSI = "dimensionless",
                     unitType = "dimensionless",
                     multiplierToSI = "0.0001",
                     description = "Square meters per hectare")

  eml_write(dat, 
            col.defs = col.defs, 
            unit.defs = unit.defs, 
            custom_units = c(unit),
            file = "customunit.xml", 
            contact = "Carl Boettiger <cboettig@ropensci.org>")
  o <- eml_validate("customunit.xml")
  expect_true(all(o)) # all cases validate

  ## Make sure we actually wrote some additionalMetadata about unit defs...
  eml <- eml_read("customunit.xml")
  expect_more_than(length(eml@additionalMetadata), 0)

  library(XML)
  expect_output(xmlValue(eml@additionalMetadata[[1]]@metadata), "Square meters per hectare")

  
  unlink("*.xml")
  unlink("*.csv")
  eml_reset_config()

})






test_that("We can define custom units with new unit types inline", {

 ## define gram per meter:

  ## first, define a massPerLength type: 
  new_type <-c( 
  eml_define_unitType("massPerLength", 
                      dimensions = 
                        list(c(name="mass"), 
                             c(name="length", power="-1"))))
 ## Define the base SI unit
  new_units <- c(
  eml_define_unit("kilogramPerMeter",
                  unitType = "massPerLength",
                  abbreviation = "kg/m",
                  parentSI = "kilogramPerMeter",
                  multiplierToSI="1"),
  ##  define the desired unit, with SI conversion factor
  eml_define_unit("gramPerMeter", 
                  unitType = "massPerLength",
                  parentSI = "kilogramPerMeter",
                  multiplierToSI = "0.001",
                  abbreviation = "g/m"))

  # Now when we do the usual creating of EML, units are automatically remembered.  
  eml_write(dat, 
            col.defs = col.defs, 
            unit.defs = unit.defs,
            custom_types = new_type,
            custom_units = new_units,
            file = "customunit.xml", 
            contact = "Carl Boettiger <cboettig@ropensci.org>")
  o <- eml_validate("customunit.xml")
  expect_true(all(o)) # all cases validate

  ## Make sure we actually wrote some additionalMetadata about unit defs...
  eml <- eml_read("customunit.xml")
  expect_more_than(length(eml@additionalMetadata), 0)

  library(XML)
  expect_output(xmlAttrs(eml@additionalMetadata[[1]]@metadata[["unitList"]][["unitType"]])[["id"]], "massPerLength")


  unlink("*.xml")
  unlink("*.csv")
  eml_reset_config()

})




