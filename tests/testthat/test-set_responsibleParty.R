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

testthat::test_that("We can set a responsible party that's an organization", {
  # Verify this way of calling the function works
  party <- set_responsibleParty(organizationName = "Some Organization")
  testthat::expect_equal(party$organizationName, "Some Organization")

  # Also verify we create valid documents when doing so
  doc <- list(
    dataset = list(
      title = "dataset title",
      contact = party,
      creator = party
    ),
    system = "doi",
    packageId = "10.xxx"
  )

  write_eml(doc, "ex.xml")
  testthat::expect_true(eml_validate("ex.xml"))
  unlink("ex.xml")
})
