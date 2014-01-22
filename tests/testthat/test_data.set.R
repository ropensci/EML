context("data.set")

library(EML)

dat = data.set(river = factor(c("SAC",  
                                "SAC",   
                                "AM")),
               spp   = c("Oncorhynchus tshawytscha",  
                         "Oncorhynchus tshawytscha", 
                         "Oncorhynchus kisutch"),
               stg   = ordered(c("smolt", 
                                 "parr", 
                                 "smolt"), 
                               levels=c("parr", "smolt")), # levels indicates increasing level, eg. parr < smolt
               ct    = c(293L,    
                         410L,    
                         210L),
               day   = as.Date(c("2013-09-01", 
                                 "2013-09-1", 
                                 "2013-09-02")),
               stringsAsFactors = FALSE, 
               col.defs = c("River site used for collection",
                            "Species scientific name",
                            "Life Stage", 
                            "count of live fish in traps",
                            "day traps were sampled (usually in morning thereof)"),
               unit.defs = list(c(SAC = "The Sacramento River",                         # Factor 
                                  AM = "The American River"),
                                c("Scientific name"),                                   # Character string (levels not defined)
                                c(parr = "third life stage",                            # Ordered factor 
                                  smolt = "fourth life stage"),
                                c(unit = "number", precision = 1, bounds = c(0, Inf)),  # Integer
                                c(format = "YYYY-MM-DD", precision = 1)))               # Date

title = "testing title"
description = "testing description"


test_that("We can generate an dataTable S4 object", {
  s4 <- EML:::eml_dataTable(dat, EML:::get_metadata(dat), description=description)
  expect_is(s4, "dataTable")              
})

test_that("We can generate an dataset S4 object", {
  dt <- EML:::eml_dataTable(dat, EML:::get_metadata(dat), description=description)
  creator <- new("ListOfcreator", list(as("Carl Boettiger <cboettig@ropensci.org>", "creator")))
  s4 <- new("dataset", 
      title = title, 
      creator = creator,
      contact = as(creator[[1]], "contact"),
      coverage = new("coverage"),
      dataTable = c(dt),
      methods = new("methods"))
  expect_is(s4, "dataset")
})



test_that("We can generate an eml S4 object", {
  dt <- eml_dataTable(dat, EML:::get_metadata(dat), description=description)
  creator <- new("ListOfcreator", list(as("Carl Boettiger <cboettig@ropensci.org>", "creator")))
  ds <- new("dataset", 
      title = title, 
      creator = creator,
      contact = as(creator[[1]], "contact"),
      coverage = new("coverage"),
      dataTable = c(dt),
      methods = new("methods"))

  success <- require(uuid)
  if(success){
    id <- paste0("urn:uuid:", uuid::UUIDgenerate())
    system <- "uuid"
  } else {
    id <- paste0("EML_", runif(1, 1e6, 9e6))
    system <- "EML"
  }
  s4 <- new("eml",
      packageId = id,
      system = system,
      dataset = ds)

  expect_is(s4, "eml")

})



test_that("We can generate an eml S4 object more cleanly, and test show method", {
  dt <- eml_dataTable(dat)
  creator <- c(as("Carl Boettiger <cboettig@ropensci.org>", "creator"))
  ds <- new("dataset", 
            creator = creator,
            contact = as(creator[[1]], "contact"),
#            coverage = new("coverage"),
            dataTable = c(dt))
  s4 <- new("eml",
            dataset = ds)
  expect_is(s4, "eml")
  capture.output(show(s4))
})


test_that("we can write out a data.set using embedded metadata", {
  eml_write(dat,
            contact = as("Carl Boettiger <cboettig@gmail.com>", "contact"),
            file = "test.xml")
  expect_true(all(eml_validate("test.xml")))
  unlink("test.xml")
})



test_that("we can use plain text strings in contact", {
  s4 <- eml(dat, contact = "Carl Boettiger <cboettig@ropensi.org>")
  expect_identical(as(s4@dataset@creator, "person")$family, "Boettiger")
})


