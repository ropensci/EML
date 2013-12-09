context("generating S4 from R dataframe")
## This file tests constructors for the S4 objects 
## using the expected R input formats 


## FIXME add expect_that to the tests!

require(reml)
dat = data.frame(river = c("SAC",  "SAC",   "AM"),
                 spp   = c("king",  "king", "ccho"),
                 stg   = c("smolt", "parr", "smolt"),
                 ct    = c(293L,    410L,    210L))
metadata <- 
  list("river" = list("river",
                      "River site used for collection",
                      c(SAC = "The Sacramento River", 
                        AM = "The American River")),
       "spp" = list("spp",
                    "Species common name", 
                    c(king = "King Salmon", 
                      ccho = "Coho Salmon")),
       "stg" = list("stg",
                    "Life Stage", 
                    c(parr = "third life stage", 
                      smolt = "fourth life stage")),
       "ct"  = list("ct",
                    "count", 
                    "number"))

test_that("We can coerce factor definitions to nominal", {
  as(metadata$river[[3]], "nominal")
})

test_that("We can coerce list to to attribute", {
  metadata <- reml:::detect_class(dat, metadata)
  as(metadata$river, "attribute")
})

test_that("We can coerce metadata to attributeList", {
  metadata <- reml:::detect_class(dat, metadata) ## Needs metadata with class info from data
  as(metadata, "attributeList") 
})

test_that("Generator for dataset containing generator for dataTable", {
  metadata <- reml:::detect_class(dat, metadata)  ## Needs metadata with class info from data
  new("dataset", dataTable = new("ListOfdataTable", list(new("dataTable", attributeList = as(metadata, "attributeList")))))
})


test_that("Constructor function for physical works given data.frame", {
  reml:::eml_physical(dat, filename="tmp.csv") 
  unlink("tmp.csv")
})

## Constructor functions handle the detect_class internally:

test_that("Constructor function for dataTable works given data.frame and metadata list", {
  reml:::eml_dataTable(dat, metadata, filename="tmp.csv") 
  unlink("tmp.csv")
}) 


## FIXME how about a dataset level test?


test_that("Constructor function for eml works given dat, metadata", {
  #eml_config(creator = "Carl Boettiger <cboettig@gmail.com>") 
      reml:::eml(dat, metadata, title = "the title", 
      description = "some description", 
      creator = "Carl Boettiger <cboettig@gmail.com>")

      unlink("the_title.csv")
})








