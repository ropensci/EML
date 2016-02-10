testthat::context("We can parse & serialize test files")

library(XML)
testthat::test_that("eml-access.xml", {
  f <- system.file(paste0("xsd/test/", "eml-access.xml"), package = "eml2")
  node <- xmlRoot(xmlParse(f))
  removeAttributes(node, .attrs = "xsi:schemaLocation")

  s4 <- as(node, xmlName(node))
  element <- as(s4, "XMLInternalElementNode")


  testthat::expect_is(element, "XMLInternalElementNode")
})

## FIXME should work withou purrr::safely
xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
out <- lapply(xml_tests, purrr::safely(function(xml){
  testthat::test_that(xml, {
    f <- system.file(paste0("xsd/test/", xml), package = "eml2")
    node <- xmlRoot(xmlParse(f))
    s4 <- as(node, xmlName(node))
    element <- as(s4, "XMLInternalElementNode")
    testthat::expect_is(element, "XMLInternalElementNode")
  })
}))


### Errors:
## Not expected: 'lang' is not a slot in class "title"
