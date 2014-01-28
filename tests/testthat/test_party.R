context("party.R")

require(EML)

test_that("Coercions work with EML:::contact_creator function", {


  b <- EML:::contact_creator(contact = "Carl Boettiger <cboettig@gmail.com>")

  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")



  b <- EML:::contact_creator(creator = "Carl Boettiger <cboettig@gmail.com>")
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")

  b <- EML:::contact_creator(creator = "Carl Boettiger <cboettig@gmail.com>",
                       contact = "Carl Boettiger <cboettig@gmail.com>")
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")

  b <- EML:::contact_creator(creator = as("Carl Boettiger <cboettig@gmail.com>", "creator"),
                       contact = "Carl Boettiger <cboettig@gmail.com>")
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")

  b <- EML:::contact_creator(contact = as("Carl Boettiger <cboettig@gmail.com>", "contact"))
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")


  b <- EML:::contact_creator(contact = as.person("Carl Boettiger <cboettig@gmail.com>"))
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")

  b <- EML:::contact_creator(creator = c(as("Carl Boettiger <cboettig@gmail.com>", "creator"),
                                  as("Karthik Ram", "creator")),
                       contact = "Carl Boettiger <cboettig@gmail.com>")
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")

## Provide a contact object as creator...
  b <- EML:::contact_creator(creator = as("Carl Boettiger <cboettig@gmail.com>", "contact"))
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")


## Provide a creator  object as contact.
  b <- EML:::contact_creator(contact = as("Carl Boettiger <cboettig@gmail.com>", "creator"))
  expect_is(b$creator, "ListOfcreator")
  expect_is(b$contact, "contact")
  expect_identical(format(as(b$contact, "person")), "Carl Boettiger <cboettig@gmail.com>")
  expect_identical(b$contact@individualName@surName, "Boettiger")
  expect_identical(b$creator[[1]]@individualName@surName, "Boettiger")


## Provide a ListOfcreator  object as contact.
  expect_error(b <- EML:::contact_creator(contact = c(as("Carl Boettiger <cboettig@gmail.com>", "creator"),
                                  as("Karthik Ram", "creator"))))


})
