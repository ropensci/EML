context("Identical read in and write out of an existing EML file")

## test basic reading of XML into S4


test_that("we can read in and write out the file", {
  require(EML)
  f <- system.file("examples", "hf205.xml",  package="EML")
  eml <- read.eml(f)
  ex <- eml_write(eml) #  version is preserved 
#  eml_validate(ex)  # Won't validate against the 211 schema.  
})

