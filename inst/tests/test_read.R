context("Parsing")

## test basic reading of XML into S4

library(XML)
require(reml)
f <- system.file("examples", "hf205.xml",  package="reml")

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


require(reml)
data(ex1)
S4obj <- reml:::eml(dat, metadata, title = "title", 
             description = "description", 
             creator = "Carl Boettiger <cboettig@gmail.com>")




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
  eml_get(S4obj, "data.set")
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



