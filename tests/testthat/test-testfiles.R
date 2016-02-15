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

  all_elements <- xpathSApply(xmlParse(f), "//*", xmlName)
  all_elements2 <- xpathSApply(xmlDoc(element), "//*", xmlName)
  testthat::expect_identical(all_elements, all_elements2)
})

xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
## eml-unitDictionary is not EML but STMML; won't validate against EML schema.  (could add it into additionalMetadata though)
xml_tests <- xml_tests[- which(xml_tests == "eml-unitDictionary.xml")]


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



    all_elements <- xpathSApply(xmlParse(f), "//*", xmlName)
    all_elements2 <- xpathSApply(xmlDoc(element), "//*", xmlName)
    ## identical number of elements
    testthat::expect_identical(length(all_elements), length(all_elements2))
    ## identical modulo order
    testthat::expect_identical(sort(all_elements), sort(all_elements2))
    ## strictly identical
    testthat::expect_identical(all_elements, all_elements2)
    })
}))

# Validation fails for:
#  'eml-physical.xml',  'eml-unitDictionary.xml'
#

