testthat::context("TextType")

testthat::test_that("we can create TextType from a simple character string", {
  ## using a simple character string
  a <- set_TextType(text = "This is the abstract")
  ab <- as(a, "abstract")
  testthat::expect_is(ab, "abstract")

})

## Using an external markdown file
testthat::test_that("we can create TextType using an external markdown file", {
  skip_on_cran()
#  skip_on_appveyor()
#  skip_on_os("windows")

  f <- system.file("examples/hf205-abstract.md", package = "EML")
  a <- set_TextType(f)
  ab <- as(a, "abstract")
  testthat::expect_is(ab, "abstract")
})

testthat::test_that("we can create TextType in a .docx MS Word file.", {
  skip_on_cran()
  #skip_on_appveyor()
  #skip_on_os("windows")

  f <- system.file("examples/hf205-abstract.docx", package = "EML")
  a <- set_TextType(f)
  ab <- as(a, "abstract")
  testthat::expect_is(ab, "abstract")
})

testthat::test_that(
  "Documents can have richer formatting.  Documents with title headings use `section` instead of `para` notation",
  {
    skip_on_cran()
   # skip_on_appveyor()
   # skip_on_os("windows")


    f <- system.file("examples/hf205-methods.docx", package = "EML")
    d <- set_TextType(f)
    node <- as(d, "description")
    testthat::expect_is(node, "description")

    out <- tempfile()
    get_TextType(node, view = FALSE, output = out)
    unlink(out)
  }
)



testthat::test_that(
  "We can parse a richer abstract into markdown",
  {
    skip_on_cran()
    #skip_on_appveyor()
    #skip_on_os("windows")


 f <- system.file("examples/hf205.xml", package = "EML")
 eml <- read_eml(f)
 abstract <- eml_get(eml, "abstract")
 get_TextType(abstract[[1]], "markdown", "abstract.markdown")
 a <- readLines("abstract.markdown")

 testthat::expect_is(a, "character")

 unlink("abstract.markdown") # tidy up

  })
