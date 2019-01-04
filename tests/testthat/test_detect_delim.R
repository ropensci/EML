context("detect_delim")

test_that("detects lf delimiters correctly", {
  path <- tempfile()
  writeChar("asdf\rasdf\rasdf\r", path)
  on.exit({
    unlink(path)
  })

  expect_equal(detect_delim(path), "\r")
})

test_that("detects crlf delimiters correctly", {
  path <- tempfile()
  writeChar("asdf\r\nasdf\r\nasdf\r\n", path)
  on.exit({
    unlink(path)
  })

  expect_equal(detect_delim(path), "\r\n")
})

test_that("falls back to crlf when it find sno delimiters", {
  path <- tempfile()
  writeChar("asdf", path)
  on.exit({
    unlink(path)
  })

  expect_equal(detect_delim(path), "\r\n")
})

test_that("warns and falls back on file not found", {
  expect_equal(suppressWarnings(detect_delim("idontexist")), "\r\n")
})
