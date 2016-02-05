testthat::context("We can parse & serialize test files")

library(XML)

xml <- "xsd/test/eml-access.xml"

testthat::test_that(xml, {
  f <- system.file(xml, package = "eml2")
  node <- xmlRoot(xmlParse(f))
  removeAttributes(node, .attrs = "xsi:schemaLocation")

  s4 <- as(node, xmlName(node))
  element <- as(s4, "XMLInternalElementNode")

})
