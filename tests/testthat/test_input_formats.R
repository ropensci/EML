context("test input formats")

test_that("We can use the unit.def/col.def format", {

  # load sample data
  source(system.file("examples", "ex3.R", package="EML"))

  # Write EML
  eml_write(dat, 
      col.defs = col.defs,
      unit.defs = unit.defs,
      contact = "Carl Boettiger <cboettig@ropensci.org>", 
      file = "test.xml")

  # Validate
  o <- eml_validate("test.xml")
  expect_true(all(o)) # all cases validate
  unlink("test.xml")

})


test_that("We can use the original metadata format", {

  # load sample data
  source(system.file("examples", "ex1.R", package="EML"))

  # Write EML
  eml_write(dat, 
      meta = metadata, 
      contact = "Carl Boettiger <cboettig@ropensci.org>", 
      file = "test.xml")

  # Validate
  o <- eml_validate("test.xml")
  expect_true(all(o)) # all cases validate
  unlink("test.xml")

})



test_that("We can use the (pseudo-depricated) data.set metadata format", {

  # load sample data
  source(system.file("examples", "ex2.R", package="EML"))

  # Write EML
  eml_write(dat, 
      contact="Carl Boettiger <cboettig@ropensci.org>", 
      file = "test.xml")

  # Validate
  o <- eml_validate("test.xml")
  expect_true(all(o)) # all cases validate
  unlink("test.xml")

})



