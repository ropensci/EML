testthat::context("eml_find and eml_get")

f = tempfile()
download.file("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/doi%3A10.5063%2FF1BZ63Z8",f)
eml = read_eml(f)

devtools::test_that("we can find and get an element", {

  m <- eml_get(eml, "methods") 
  testthat::expect_is(m, "methods")
  m <- eml_find(eml, "methods") # ok
  testthat::expect_is(m, "methods")

})



geographicCoverage = eml_get(eml, "geographicCoverage") #works
eml_get(geographicCoverage, "geographicDescription") # return NULL
eml_get(eml, "geographicDescription")  #return NULL