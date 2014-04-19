context("generating S4 from R dataframe")
## This file tests constructors for the S4 objects 
## using the expected R input formats 


## FIXME add expect_that to the tests!

require(EML)
eml_reset_config()
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
  metadata <- EML:::detect_class(dat, metadata)
  as(metadata$river, "attribute")
})

test_that("We can coerce metadata to attributeList", {
  metadata <- EML:::detect_class(dat, metadata) ## Needs metadata with class info from data
  as(metadata, "attributeList") 
})

test_that("Generator for dataset containing generator for dataTable", {
  metadata <- EML:::detect_class(dat, metadata)  ## Needs metadata with class info from data
  set <- new("dataset")
  set@dataTable = new("ListOfdataTable", list(new("dataTable", attributeList = as(metadata, "attributeList"))))
})


test_that("Constructor function for physical works given data.frame", {
  EML:::eml_physical(dat, filename="tmp.csv") 
  unlink("tmp.csv")
})

## Constructor functions handle the detect_class internally:

test_that("Constructor function for dataTable works given data.frame and metadata list", {
  EML:::eml_dataTable(dat, metadata, filename="tmp.csv") 
  unlink("tmp.csv")
}) 


## FIXME how about a dataset level test?










test_that("Constructor function for eml works given dat, metadata", {
dat = data.set(river = factor(c("SAC",  "SAC",   "AM")),
               spp   = c("Oncorhynchus tshawytscha",  "Oncorhynchus tshawytscha", "Oncorhynchus kisutch"),
               stg   = ordered(c("smolt", "parr", "smolt"), levels=c("parr", "smolt")), # levels indicates increasing level, eg. parr < smolt
               ct    = c(293L,    410L,    210L),
               day   = as.Date(c("2013-09-01", "2013-09-1", "2013-09-02")),
               stringsAsFactors = FALSE, 
               col.defs = c("River site used for collection",
                            "Species scientific name",
                            "Life Stage", 
                            "count of live fish in traps",
                            "day traps were sampled (usually in morning thereof)"),
               unit.defs = list(c(SAC = "The Sacramento River",                         # Factor 
                                  AM = "The American River"),
                                "Scientific name",                                      # Character string (levels not defined)
                                c(parr = "third life stage",                            # Ordered factor 
                                  smolt = "fourth life stage"),
                                c(unit = "number", precision = 1, bounds = c(0, Inf)),  # Integer
                                c(format = "YYYY-MM-DD", precision = 1)))               # Date

  #eml_config(creator = "Carl Boettiger <cboettig@gmail.com>") 

      EML:::eml(dat, title = "the title", 
      creator = "Carl Boettiger <cboettig@gmail.com>")

      unlink("the_title.csv")
})








