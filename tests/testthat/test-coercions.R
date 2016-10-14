testthat::context("coercions")


from <- as.person("Carl Boettiger <cboettig@gmail.com>")
to <- as(from, "contact")
testthat::expect_is(to, "contact")

x <- as.person("Carl Boettiger <cboettig@gmail.com> [ctb]")
to <- as(x, "associatedParty")
testthat::expect_is(to, "associatedParty")




x <- as.person("Carl David Boettiger <cboettig@gmail.com> [ctb]")
to <- as(x, "associatedParty")
testthat::expect_is(to, "associatedParty")
testthat::expect_equal(to@role[[1]], "ctb")


citation <-
  read_eml(system.file("xsd/test/eml-literature.xml", package = "EML"))
x <- as(citation, "bibentry")
testthat::expect_is(x, "bibentry")
y <- as(x, "citation")
testthat::expect_is(y, "citation")

testthat::test_that("warning when no role given to a person", {
  x <- as.person("Carl Boettiger <cboettig@gmail.com>")
  testthat::expect_warning(as(x, "associatedParty"))
  x <- as.person("Carl Boettiger <cboettig@gmail.com>")
  testthat::expect_warning(as(x, "contact"))
})
