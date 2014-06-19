context("Parsing")

## test basic reading of XML into S4

library(XML)
require(EML)
f <- system.file("examples", "hf205.xml",  package="EML")

test_that("we can parse XML into S4", {

  root <- xmlRoot(xmlParse(f))
  s4_eml <- as(root, "eml")
  expect_is(s4_eml, "eml")
})

## Test higher-level method (e.g. calls parsing internally)

test_that("we can read in S4 using eml_read", {
  s4 <- eml_read(f)
  expect_is(s4, "eml")
})

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



S4obj <- eml(dat, col.defs = col.defs, unit.defs = unit.defs, 
             title = "title", creator = "Carl Boettiger <cboettig@gmail.com>")


test_that("We can access a file by DataONE ID", {
          a <- eml_read("knb-lter-hfr.205.4")
          expect_is(a, "eml")
          unlink("hf205.xml")
})

test_that("We can access a file by its URL", {
          a <- eml_read("http://harvardforest.fas.harvard.edu/data/eml/hf205.xml")
          expect_is(a, "eml")
          unlink("hf205.xml")
})


### These should be moved into seperate tests


test_that("we can access the dataTable", {
  eml_get(S4obj, "data.frame")
})
test_that("we can access the metadata attributeList", {
          eml_get(S4obj, "attributeList")
})
test_that("we can access the contact", {
  eml_get(S4obj, "contact")
})
test_that("we can access the citation", {
  eml_get(S4obj, "citation_info")
})


# Created by S4Obj for the 'physical' node
unlink("title.csv")




test_that("we don't overwrite the identifiers (packageId) when reading in EML", {
  s4 <- eml_read(f)
  id <- eml_get(s4, "id")
  expect_identical(id, "knb-lter-hfr.205.4")
})

test_that("we don't overwirte the namespace when reading in the EML", {
  s4 <- eml_read(f)
  expect_match(s4@namespaces["eml"], "2.1.0") 
})



