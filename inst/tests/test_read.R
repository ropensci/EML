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



test_that("we can access the dataTable", {
  dataTable(S4obj)
})
test_that("we can access the metadata attributeList", {
  attributeList(S4obj)
})
test_that("we can access the contact", {
  contact(S4obj)
})
test_that("we can access the citation", {
  citationInfo(S4obj)
})


