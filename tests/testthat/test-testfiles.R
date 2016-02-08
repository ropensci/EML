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


xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
out <- lapply(xml_tests, safely(function(xml){
  testthat::test_that(xml, {
    f <- system.file(paste0("xsd/test/", xml), package = "eml2")
    node <- xmlRoot(xmlParse(f))
    removeAttributes(node, .attrs = "xsi:schemaLocation")
    s4 <- as(node, xmlName(node))
    element <- as(s4, "XMLInternalElementNode")
    testthat::expect_is(element, "XMLInternalElementNode")
  })
}))


### Errors:
## Not expected: ‘id’ is not a slot in class “unit”
## Not expected: assignment of an object of class “inline” is not valid for slot ‘inline’ in an object of class “distribution”; is(value, "InlineType") is not TRUE
## Not expected: ‘lang’ is not a slot in class “eml”
## Not expected: assignment of an object of class “character” is not valid for @‘.Data’ in an object of class “required”; is(value, "logical") is not TRUE
