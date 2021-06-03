context("taxonomicCoverage")

test_that("set_taxonomicCoverage works with data.frame", {
  
  sci_names <- data.frame(
    Kingdom = "Plantae",
    Phylum = "Phaeophyta",
    Class = "Phaeophyceae",
    Order = "Laminariales",
    Family = "Lessoniaceae",
    Genus = "Macrocystis",
    specificEpithet = "pyrifera"
  )
  taxon_coverage <- set_taxonomicCoverage(sci_names)

  expect_is(taxon_coverage, "list")
})



test_that("set_taxonomicCoverage works with nested lists", {
  sci_names <- list(list(
    Kingdom = "Plantae",
    Phylum = "Phaeophyta",
    Class = "Phaeophyceae",
    Order = "Laminariales",
    Family = "Lessoniaceae",
    Genus = "Macrocystis",
    specificEpithet = "pyrifera"
  ))
  x <- set_taxonomicCoverage(sci_names)

  expect_is(x, "list")
})

test_that("set_taxonomicCoverage works with
           ITIS using taxize", {
             
  skip_if_not_installed("taxadb")           
  skip_on_cran()           
  taxon_coverage <- set_taxonomicCoverage(
    c("Macrocystis pyrifera"),
    expand = TRUE
  )

  expect_is(taxon_coverage, "list")
})



test_that("set_taxonomicCoverage works with
           ITIS using taxadb", {
             
  skip_if_not_installed("taxadb")
  skip("Interactive test")

  taxon_coverage <- set_taxonomicCoverage(
    c("Macrocystis pyrifera", "Homo sapiens"),
    expand = TRUE
  )

  expect_is(taxon_coverage, "list")
})


test_that("set_taxonomicCoverage works GBIF instead of ITIS", {
  skip("Interactive test")
  skip_if_not_installed("taxadb")           
  
  taxon_coverage <- set_taxonomicCoverage(
    c("Macrocystis pyrifera"),
    expand = TRUE,
    db = "gbif"
  )

  expect_is(taxon_coverage, "list")
})
