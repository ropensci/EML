context("Serializing S4 to XML")

## Test basic writing of S4 classes back into XML
require(reml)

## Okay, we know this works, so stick it in the global space for the next functions...

## Rest of tests use data.set object

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






test_that("We can write S4 EML to XML and validate", {

  eml_write(dat, contact = as("Carl Boettiger <cboettig@gmail.com>", "contact"), file="title.xml")

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
  eml_write(new("eml",dataset = 
                new("dataset", 
                    dataTable = c(eml_dataTable(dat, 
                                              description = "description",
                                              filename = "title.csv")), 
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


