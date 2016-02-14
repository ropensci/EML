testthat::context("We can parse & serialize test files")

library(XML)
testthat::test_that("eml-attribute.xml", {

  f <- system.file(paste0("xsd/test/", "eml-attribute.xml"), package = "eml2")
  node <- xmlRoot(xmlParse(f))
  ## This can cause trouble if not namespaced, and is not required
  XML::removeAttributes(node, .attrs = "xsi:schemaLocation")
  ## Test: can we parse into S4?
  s4 <- as(node, xmlName(node))
  ## Test: can we transform back into XML?
  element <- as(s4, "XMLInternalElementNode")
  ## Test: is our XML still schema-valid?
  ns <- xmlNamespaces(node)
  xmlNamespaces(element) <- ns
  setXMLNamespace(element, ns[[1]]$id)
  saveXML(xmlDoc(element), "test.xml")
  v <- eml_validate("test.xml")
  unlink("test.xml")
  testthat::expect_equal(v$status, 0)

})

xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
out <- lapply(xml_tests, purrr::safely(function(xml){
  testthat::test_that(xml, {
    f <- system.file(paste0("xsd/test/", xml), package = "eml2")
    node <- xmlRoot(xmlParse(f))
    ## This can cause trouble if not namespaced, and is not required
    XML::removeAttributes(node, .attrs = "xsi:schemaLocation")
    ## Test: can we parse into S4?
    s4 <- as(node, xmlName(node))
    ## Test: can we transform back into XML?
    element <- as(s4, "XMLInternalElementNode")
    ## Test: is our XML still schema-valid?
    ns <- xmlNamespaces(node)
    xmlNamespaces(element) <- ns

    ids <- sapply(ns, `[[`, "id")
    tmp <- which(ids  == "eml")
    if(length(tmp) > 0){
      ns_1 <- ids[[tmp]]
    } else {
      ns_1 <- ns[[1]]$id
    }
    setXMLNamespace(element, ns_1)
    saveXML(xmlDoc(element), "test.xml")
    v <- eml_validate("test.xml")
    testthat::expect_equal(v$status, 0)
    })
}))

# Validation fails for:
# 'eml-i18n.xml', 'eml-physical.xml', 'eml-project.xml', 'eml-unitDictionary.xml'
#

