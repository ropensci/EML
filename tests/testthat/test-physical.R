testthat::context("physical")

testthat::test_that("We can generate EML physical structures correctly", {
  library(EML)

  p1 <-
    set_physical("filename",
                 id = "ident",
                 numHeaderLines = "1",
                 size = "879")
  testthat::expect_match(p1@size@.Data, "879")
  testthat::expect_match(p1@size@unit, "bytes")
})


testthat::test_that("set_physical automatically calculates size and checksum", {
  path <- system.file("examples", "hf205.xml", package = "EML")
  suppressWarnings({
    testthat::expect_warning(phys <- set_physical(path))
  })

  testthat::expect_equal(phys@size@.Data, "29666")
  testthat::expect_equal(phys@authentication[[1]]@method@.Data, "MD5")
  testthat::expect_equal(phys@authentication@.Data[[1]]@.Data, digest::digest(path, algo = "md5", file = TRUE))
})
