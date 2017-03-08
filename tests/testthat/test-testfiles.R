testthat::context("We can parse & serialize test files")

## FIXME rewrite to be independent of all this XML assumption crap

library(xml2)


xml_tests <- list.files("inst/xsd/test/", "eml-.*\\.xml")
## eml-unitDictionary is not EML but STMML; won't validate against EML schema.  (could add it into additionalMetadata though)
xml_tests <-
  xml_tests[-which(xml_tests == "eml-unitDictionary.xml")]



all_test_examples<- function(xml) {
  testthat::test_that(xml, {

    message(paste("testing", xml))

    ## Read EML
    f <- system.file(paste0("xsd/test/", xml), package = "EML")
    eml <- read_eml(f)
    testthat::expect_true(isS4(eml))

    ## Because root element in many test files is not "eml" but some sub-class like "dataset" or "access", we need to be explicit about namespace
    original <- xml2::read_xml(f)
    namespaces <- xml_ns(original)
    i <- grep("eml", names(namespaces))
    if(length(i) == 0) i <- 1
    ns <- names(namespaces[i])

    ## Write and Validate EML (handling explicit namespacing)
    write_eml(eml, "unittest.xml", namespaces = namespaces, ns = ns)
    v <- eml_validate("unittest.xml")
    testthat::expect_true(v)


    ## Check no elements were lost:
    original <- xml_name( xml_find_all(read_xml(f), "//*") )
    test <- xml_name(xml_find_all(xml2::read_xml("unittest.xml"), "//*") )

    ## identical number of elements
    testthat::expect_identical(length(original), length(test))
    ## elements are identical, modulo ordering
    testthat::expect_identical(sort(original), sort(test))
    ## strictly identical:
#    if (!(xml == 'eml-physical.xml'))      # Skip known error
      testthat::expect_identical(original, test)

    ## Clean up
    unlink("unittest.xml")
    })
}

out <- lapply(xml_tests, all_test_examples)
#out <- purrr::safely(purrr::map(xml_tests, all_test_examples))


## scratch tests

testthat::test_that('check a single test file', {
xml <-xml_tests[2]
f <- system.file(paste0("xsd/test/", xml), package = "EML")
eml <- read_eml(f)
original <- xml2::read_xml(f)
namespaces <- xml_ns(original)
i <- grep("eml", names(namespaces))
if(length(i) == 0) i <- 1
ns <- names(namespaces[i])

## Write and Validate EML (handling explicit namespacing)
write_eml(eml, "unittest.xml", namespaces = namespaces, ns = ns)
v <- eml_validate("unittest.xml")
testthat::expect_true(v)
original <- xml_name( xml_find_all(read_xml(f), "//*") )
test <- xml_name(xml_find_all(xml2::read_xml("unittest.xml"), "//*") )

testthat::expect_identical(length(original), length(test))
testthat::expect_identical(sort(original), sort(test))
testthat::expect_identical(original, test)
})

## Clean up
## purrr::compact(lapply(out, `[[`, "error"))

# length differs for: 'eml-i18n.xml', 'eml-literatureInPress.xml',  'eml-literature.xml', 'eml-text.xml'
# identical ordering differs for: 'eml-physical.xml'
#
#  - eml-i18n.xml has "<value> child elements in i18nNonEmptyStringType's. Same problem where mixed character type & child element results in tags being dropped.
#  - literature: has <abstract> without TextType elements.  Would have been fine if used TextType elements, otherwise treated as character
#  - eml-text: misses 2 <section> tags that are children of a <section> tag

## Note: we cannot parse text nodes that mix text content and marked up content into slot values.
## cannot interleave slot values. Thus we treat as literal XML
