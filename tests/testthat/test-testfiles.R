testthat::context("We can parse & serialize test files")

library(XML)


xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
## eml-unitDictionary is not EML but STMML; won't validate against EML schema.  (could add it into additionalMetadata though)
xml_tests <-
  xml_tests[-which(xml_tests == "eml-unitDictionary.xml")]


out <- lapply(xml_tests, function(xml) {
  testthat::test_that(xml, {
    f <- system.file(paste0("xsd/test/", xml), package = "EML")
    node <- xmlRoot(xmlParse(f))
    ## This can cause trouble if not namespaced, and is not required
    XML::removeAttributes(node, .attrs = "xsi:schemaLocation")
    ## Test: can we parse into S4?
    s4 <- as(node, xmlName(node))
    ## Test: can we transform back into XML?
    element <- as(s4, "XMLInternalNode")
    ## Test: is our XML still schema-valid?
    ## preserve the namespace of the input
    ns <- xmlNamespaces(node)
    xmlNamespaces(element) <- ns
    ids <- sapply(ns, `[[`, "id")
    tmp <- which(ids  == "eml")
    if (length(tmp) > 0) {
      ns_1 <- ids[[tmp]]
    } else {
      ns_1 <- ns[[1]]$id
    }
    setXMLNamespace(element, ns_1)
    saveXML(xmlDoc(element), "test.xml")

    all_elements <- xpathSApply(xmlParse(f), "//*", xmlName)
    all_elements2 <- xpathSApply(xmlDoc(element), "//*", xmlName)

    ## identical number of elements
    testthat::expect_identical(length(all_elements), length(all_elements2))
    ## identical modulo order
    testthat::expect_identical(sort(all_elements), sort(all_elements2))
    ## strictly identical:
    if (!(xml == 'eml-physical.xml'))
      # Skip known error
      testthat::expect_identical(all_elements, all_elements2)

    ## Validate
    v <- eml_validate("test.xml")
    testthat::expect_equal(v$status, 0)

    ## Clean up
    unlink("test.xml")

  })
})


## purrr::compact(lapply(out, `[[`, "error"))

# length differs for: 'eml-i18n.xml', 'eml-literatureInPress.xml',  'eml-literature.xml', 'eml-text.xml'
# identical ordering differs for: 'eml-physical.xml'
#
#  - eml-i18n.xml has "<value> child elements in i18nNonEmptyStringType's. Same problem where mixed character type & child element results in tags being dropped.
#  - literature: has <abstract> without TextType elements.  Would have been fine if used TextType elements, otherwise treated as character
#  - eml-text: misses 2 <section> tags that are children of a <section> tag

## Note: we cannot parse text nodes that mix text content and marked up content into slot values.
## cannot interleave slot values. Thus we treat as literal XML
