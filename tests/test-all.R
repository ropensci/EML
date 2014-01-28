if (packageVersion("testthat") >= "0.7.1.99") {
    library(testthat)
  test_check("EML")
} else {
  library(testthat)
  test_package("EML")
}
