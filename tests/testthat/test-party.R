testthat::context("set-party")

testthat::test_that("set_party produces an error when not given a surName", {
  testthat::expect_error(set_party(givenNames = "FirstName"))
  testthat::expect_error(set_party(type = "creator", electronicMailAddresses = "test@example.com"))
  testthat::expect_error(set_party(salutations = "FirstName"))
})

testthat::test_that("set_party produces an error when role is set on a party type that doesn't support setting a role", {
  testthat::expect_error(set_party(type = "creator", role = "contributor"))
})

testthat::test_that("every argument in set_party works as expected", {
  # This is just a regression test
  party <- set_party("associatedParty",
                     "Bryce",
                     "Mecum",
                     "National Center for Ecological Analysis and Synthesis",
                     "Scientific Software Engineer",
                     set_address(c("735 State St.", "Suite 300"),
                                 "Santa Barbara",
                                 "California",
                                 "93101-5504",
                                 "USA"),
                     set_phone("1-555-555-5555"),
                     "mecum@nceas.ucsb.edu",
                     "https://brycemecum.com",
                     set_userId("https://orcid.org/0000-0002-0381-3766",
                                "https://orcid.org"),
                     role = "contributor")

  testthat::expect_equal(party@individualName[[1]]@givenName[[1]]@.Data, "Bryce")
  testthat::expect_equal(party@individualName[[1]]@surName@.Data, "Mecum")
  testthat::expect_equal(party@organizationName[[1]]@.Data, "National Center for Ecological Analysis and Synthesis")
  testthat::expect_equal(party@positionName[[1]]@.Data, "Scientific Software Engineer")
  testthat::expect_equal(party@address[[1]]@deliveryPoint[[1]]@.Data, "735 State St.")
  testthat::expect_equal(party@address[[1]]@deliveryPoint[[2]]@.Data, "Suite 300")
  testthat::expect_equal(party@address[[1]]@city@.Data, "Santa Barbara")
  testthat::expect_equal(party@address[[1]]@administrativeArea@.Data, "California")
  testthat::expect_equal(party@address[[1]]@postalCode@.Data, "93101-5504")
  testthat::expect_equal(party@address[[1]]@country@.Data, "USA")
  testthat::expect_equal(party@phone[[1]]@.Data, "1-555-555-5555")
  testthat::expect_equal(party@electronicMailAddress[[1]]@.Data, "mecum@nceas.ucsb.edu")
  testthat::expect_equal(party@onlineUrl[[1]]@.Data, "https://brycemecum.com")
  testthat::expect_equal(party@userId[[1]]@.Data, "https://orcid.org/0000-0002-0381-3766")
  testthat::expect_equal(party@userId[[1]]@directory@.Data, "https://orcid.org")
  testthat::expect_equal(party@role@.Data, "contributor")
})
