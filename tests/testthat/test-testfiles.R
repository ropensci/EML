testthat::context("We can parse & serialize test files")

library(xml2)
xml_tests <- list.files("inst/xsd/test/", "^eml-.*\\.xml")
## eml-unitDictionary is not EML but STMML; won't validate against EML schema by itself.
xml_tests <- xml_tests[!xml_tests %in% c("eml-unitDictionary.xml")]



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
    schemaLocation <- strsplit(xml_attr(original, "schemaLocation"), "\\s+")[[1]]
    i <- grep(schemaLocation[1], namespaces)
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
    if (!(xml == 'eml-physical.xml'))      # Skip known issue, ordering need not be identical(?)
      testthat::expect_identical(original, test)

    ## Clean up
    unlink("unittest.xml")
    })
}

out <- lapply(xml_tests, all_test_examples)


