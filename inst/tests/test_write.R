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


test_that("We can write sample data/metadata into EML", {
  ## must either call eml_config or pass creator
  S4obj <- reml:::eml(dat, metadata, title = "title", description = "description", 
               creator = "Carl Boettiger <cboettig@gmail.com>")

  expect_equal(S4obj@dataset@creator[[1]]@individualName@givenName, "Carl")
  ## FIXME add more expect_equals to check other fields in this way
})

## Okay, we know this works, so stick it in the global space for the next functions...
S4obj <- reml:::eml(dat, metadata, title = "title", description = "description", 
               creator = "Carl Boettiger <cboettig@gmail.com>")



test_that("We can write some part of this to XML", {
  att <- S4obj@dataset@dataTable@attributeList@attribute[[1]]@measurementScale
  reml:::S4Toeml(att)
})



test_that("We can write S4 EML to XML and validate", {

  eml_write(dat, metadata, title = "title", description = "description", creator = "Carl Boettiger <cboettig@gmail.com>", file="title.xml")

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
  eml_write(dat, 
            metadata, 
            file = "title.xml",
            title = "title", 
            description = "description", 
            creator = "Carl Boettiger <cboettig@gmail.com>",
            coverage = eml_coverage(list("Homo sapiens"), 
                                    c("2013-09-01", "2013-09-03"),  
                                    "Santa Cruz, CA", c(37.0,36.5,-122.0, -122.5)))

  require(XML)
  ## Test validity  FIXME Should print validator error message!
  xsd <- system.file("xsd", "eml.xsd", package="reml") 
  results <- xmlSchemaValidate(xsd, "title.xml")
    
  expect_equal(results$status, 0)       
  expect_equal(length(results$errors), 0)

  unlink("title.xml")
  unlink("title.csv")

})


test_that("We can write older versions of EML", {
  ex = eml_write(dat, metadata, title = "title", 
                 description = "description", 
                 creator = "Carl Boettiger <cboettig@gmail.com>",
                 eml_version = "2.1.0")
  eml_validate(ex)

})


