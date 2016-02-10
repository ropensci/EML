testthat::context("We can parse & serialize test files")

library(XML)
testthat::test_that("eml-access.xml", {

  f <- system.file(paste0("xsd/test/", "eml-access.xml"), package = "eml2")
  node <- xmlRoot(xmlParse(f))

  ## This can cause trouble if not namespaced, and is not required
  XML::removeAttributes(node, .attrs = "xsi:schemaLocation")

  ## Test: can we parse into S4?
  s4 <- as(node, xmlName(node))

  ## Test: can we transform back into XML?
  element <- as(s4, "XMLInternalElementNode")

  ## Test: is our XML still schema-valid?
  xmlNamespaces(element) <- xmlNamespaces(node)
  setXMLNamespace(element, "acc")

  saveXML(xmlDoc(element), "test.xml")
  v <- eml_validate("test.xml")

  testthat::expect_equal(v$status, 0)

})

xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
lapply(xml_tests, function(xml){
  testthat::test_that(xml, {
    f <- system.file(paste0("xsd/test/", xml), package = "eml2")
    ## This can cause trouble if not namespaced, and is not required
    XML::removeAttributes(node, .attrs = "xsi:schemaLocation")

    ## Test: can we parse into S4?
    s4 <- as(node, xmlName(node))

    ## Test: can we transform back into XML?
    element <- as(s4, "XMLInternalElementNode")

    ## Test: is our XML still schema-valid?
    xmlNamespaces(element) <- xmlNamespaces(node)
    setXMLNamespace(element, "acc")

    saveXML(xmlDoc(element), "test.xml")
    v <- eml_validate("test.xml")

    testthat::expect_equal(v$status, 0)
    })
})


### Errors:
## Not expected: 'lang' is not a slot in class "title"
