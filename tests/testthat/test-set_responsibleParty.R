testthat::context("set_responsibleParty")

testthat::test_that("We can set responsible party", {
  matt <- set_responsibleParty("Matt", "Jones",
    email = "mbjones@nceas.ucsb.edu"
  )
  me <- set_responsibleParty(
    as.person("Carl Boettiger <cboettig@ropensci.org>")
  )
  eml <- list(
    dataset = list(
      title = "dataset title",
      contact = me,
      creator = list(me, matt)
    ),
    system = "doi",
    packageId = "10.xxx"
  )

  write_eml(eml, "ex.xml")
  testthat::expect_true(eml_validate("ex.xml"))
  unlink("ex.xml")
})
