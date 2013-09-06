context("extracting data from S4 to native R")


## FIXME add unlink commands to remove/cleanup any files created by tests (e.g. the .csv and .xml files)

require(reml)
data(ex1)

S4obj <- reml:::eml(dat, metadata, title = "title", 
             description = "description", 
             creator = "Carl Boettiger <cboettig@gmail.com>")



test_that("we can extract the data unaltered (using method for object 'physical')", {
  out_dat <- extract(S4obj@dataset@dataTable@physical, using=col_classes(S4obj))
  expect_equal(dat, out_dat) 
 # expect_identical(dat, out_dat) ## FIXME should be identical, but isn't because integers are cast as eml:ratio which is cast as numeric.  Need to add mechanism for integers reml::detect_class
})


## Add unit tests for all extractors!

test_that("we can extract from eml directly", {
#  extract(S4obj)
})
