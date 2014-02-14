context("software")
library(EML)


test_that("we can create valid EML for software", {
  software <- eml_r_package("EML")
  eml <- eml(software = software)
  eml_write(eml, file="eml_R_software.xml")
  o <- eml_validate("eml_R_software.xml")
  expect_true(all(o)) # all cases validate
  unlink("eml_R_software.xml")
})

software <- eml_r_package("EML")
eml <- eml(software = software)
eml_write(eml, file = "eml_R_software.xml")

test_that("we can parse EML for software", {
  eml_read("eml_R_software.xml")
})

unlink("eml_R_software.xml")

