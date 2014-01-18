context("extract")


## FIXME add unlink commands to remove/cleanup any files created by tests (e.g. the .csv and .xml files)

require(reml)
data(ex4)

S4obj <- reml:::eml(dat, title = "title", 
             creator = "Carl Boettiger <cboettig@gmail.com>")



test_that("we can extract the data unaltered (using method for object 'physical')", {
  out_dat <- reml:::extract(S4obj@dataset@dataTable[[1]]@physical, using=reml:::col_classes(S4obj)) ## Using is ignored...

 
  expect_equal(dat[["river"]], out_dat[["river"]])


#  expect_equal(dat, out_dat) ## FIXME not quite, classes differ 
 # expect_identical(dat, out_dat) ## FIXME should be identical, but isn't because integers are cast as eml:ratio which is cast as numeric.  Need to add mechanism for integers reml::detect_class
})


test_that("we can extract from alternative paths", {
  ## Create a subdirectory to make sure we can read when data is not in the working directory
  dir.create("tmp", showWarnings=FALSE)

  ## Let's get the example dataset from the DataONE REST API just for fun
  require(httr)
  id <- "knb-lter-hfr.205.4" # Interestingly, met@packageID ends with `.7`, not `.4` ...
  base <- "https://cn.dataone.org/cn/v1"
  url <- paste(base, "object", id, sep="/")
  dl <- capture.output(GET(url))
  file <- content(GET(url))

  ## Write the file out again just so we can test our reading local paths
  require(XML)
  saveXML(file, "tmp/hf205.xml")

  ## Here's the actual test
  met <- eml_read("tmp/hf205.xml")
  capture.output(dat <- eml_get(met, "data.set")) # Includes call to extract that must download the CSV file from the address given in the EML
  expect_is(dat, "data.frame")

  ## Cleanup
  unlink("tmp/hf205.xml")
  unlink("tmp/hf205-01-TPexp1.csv")
  unlink("tmp")
})

## Add unit tests for all extractors!

