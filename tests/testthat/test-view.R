# testthat::context("Viewing EML documents")
#
# testthat::test_that("The function doesn't fail", {
#   if (!requireNamespace("listviewer", quietly = TRUE)) {
#     f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
#     testthat::expect_null(eml_view(f))
#     f <- system.file("xsd/test", "eml.xml", package = "EML")
#     testthat::expect_null(eml_view(f))
#     f <- system.file("xsd/test", "eml-sample.xml", package = "EML")
#     testthat::expect_null(eml_view(f))
#     f <- system.file("xsd/test", "eml-datasetWithCitation.xml", package = "EML")
#     testthat::expect_null(eml_view(f))
#     f <- system.file("examples", "example-eml-2.1.0.xml", package = "EML")
#     testthat::expect_null(eml_view(f))
#   }else{
#     f <- system.file("xsd/test", "eml-datasetWithUnits.xml", package = "EML")
#     testthat::expect_is(eml_view(f), "jsonedit")
#     f <- system.file("xsd/test", "eml.xml", package = "EML")
#     testthat::expect_is(eml_view(f), "jsonedit")
#     f <- system.file("xsd/test", "eml-sample.xml", package = "EML")
#     testthat::expect_is(eml_view(f), "jsonedit")
#     f <- system.file("xsd/test", "eml-datasetWithCitation.xml", package = "EML")
#     testthat::expect_is(eml_view(f), "jsonedit")
#     f <- system.file("examples", "example-eml-2.1.0.xml", package = "EML")
#     testthat::expect_is(eml_view(f), "jsonedit")
#
#   }
#
# })
