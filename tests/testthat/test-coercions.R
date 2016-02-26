context("coercions")


from <- as.person("Carl Boettiger <cboettig@gmail.com>")
to <- as(from, "ResponsibleParty")
testthat::expect_is(to, "ResponsibleParty")

to <- as(as(from, "ResponsibleParty"), "contact")
testthat::expect_is(to, "contact")

x = as.person("Carl Boettiger <cboettig@gmail.com> [ctb]")
to <- as(x, "associatedParty")
testthat::expect_is(to, "associatedParty")


x = as.person("Carl David Boettiger <cboettig@gmail.com> [ctb]")
to <- as(x, "associatedParty")
testthat::expect_is(to, "associatedParty")
testthat::expect_equal(to@role[[1]], "ctb")
