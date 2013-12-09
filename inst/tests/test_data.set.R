context("data.set")

library(reml)

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
  s4 <- reml:::eml_dataTable(dat, metadata(dat), title=title, description=description)
  expect_is(s4, "dataTable")
               
               })

test_that("We can generate an dataset S4 object", {
  dt <- reml:::eml_dataTable(dat, metadata(dat), title=title, description=description)
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
  dt <- reml:::eml_dataTable(dat, metadata(dat), title=title, description=description)
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
    id <- paste0("reml_", runif(1, 1e6, 9e6))
    system <- "reml"
  }
  s4 <- new("eml",
      packageId = id,
      system = system,
      dataset = ds)

  expect_is(s4, "eml")

})



test_that("We can generate an eml S4 object", {
  s4 <- reml:::eml(dat, 
                   metadata(dat), 
                   title=title, 
                   description=description, 
                   creator = "Carl Boettiger <cboettig@ropensci.org>")
  expect_is(s4, "eml")

})


test_that("Show method is working", {
  s4 <- reml:::eml(dat, 
                   metadata(dat), 
                   title=title, 
                   description=description, 
                   creator = "Carl Boettiger <cboettig@ropensci.org>")
  capture.output(show(s4))
})

test_that("we can build eml from a data.set using embedded metadata", {
  s4 <- reml:::eml(dat,
            title = "reml example",  
            description = "An example, intended for illustrative purposes only.",
            creator = "Carl Boettiger <cboettig@gmail.com>")
  unlink("reml_example.csv")

})



test_that("we can write out a data.set using embedded metadata", {
  eml_write(dat,
            title = "reml example",  
            description = "An example, intended for illustrative purposes only.",
            creator = "Carl Boettiger <cboettig@gmail.com>",
            file = "test.xml")
  unlink("test.xml")
  unlink("reml_example.csv")

})





