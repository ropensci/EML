context("Serializing S4 to XML")

## Test basic writing of S4 classes back into XML

## FIXME add unlink commands to remove/cleanup any files created by tests (e.g. the .csv and .xml files)

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



## Okay, we know this works, so stick it in the global space for the next functions...
S4obj <- reml:::eml(dat, metadata)


test_that("We can write some part of this to XML", {
  S4obj <- reml:::eml(dat, metadata)
  att <- S4obj@dataset@dataTable[[1]]@attributeList@attribute[[1]]@measurementScale
  reml:::S4Toeml(att)
})


test_that("We can write S4 EML to XML and validate", {

  eml_write(dat, metadata, contact = "Carl Boettiger <cboettig@gmail.com>", file="title.xml")

  require(XML)
  ## Test validity  FIXME Should print validator error message!
  xsd <- system.file("xsd", "eml.xsd", package="reml") 
  results <- xmlSchemaValidate(xsd, "title.xml")
    
  expect_equal(results$status, 0)      
  expect_equal(length(results$errors), 0)


   ## Test external validity
  o <- eml_validate(saveXML(xmlParse("title.xml")))                     ## eml_validate function not working 
  expect_true(o[[1]]) # all cases validate
  expect_true(o[[2]]) # all cases validate

   unlink("title.xml")
   unlink("title.csv")
})




test_that("We can add coverage information and validate", {
  contact <- as("Carl Boettiger <cboettig@ropensci.org>", "contact")
  creator <- c(as(contact, "creator"))
  eml_write(new("eml",
                new("dataset", 
                    dataTable = eml_dataTable(dat, 
                                              metadata,
                                              description = "description",
                                              filename = "title.csv"), 
                    contact = contact,
                    creator = creator, 
                    title = "title",
                    coverage = eml_coverage(list("Homo sapiens"), 
                                            c("2013-09-01", "2013-09-03"),  
                                            "Santa Cruz, CA", c(37.0,36.5,-122.0, -122.5))
                   )
                ),
                file = "title.xml")

  require(XML)
  ## Test validity  FIXME Should print validator error message!
  xsd <- system.file("xsd", "eml.xsd", package="reml") 
  results <- xmlSchemaValidate(xsd, "title.xml")
    
  expect_equal(results$status, 0)       
  expect_equal(length(results$errors), 0)

  unlink("title.xml")
  unlink("title.csv")

})


