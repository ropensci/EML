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
