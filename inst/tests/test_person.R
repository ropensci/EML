context("write")

test_that("We can write contact information node through eml$set", {
  eml$set(contact_givenName = "Carl", 
          contact_surName = "Boettiger", 
          contact_email = "cboettig@ropensci.org")

  dat = data.frame(a = 1:2, b = 1:2)
  col_metadata = c(a="A", b="B")
  unit_metadata = list(a = "number", b="number")
  doc <- eml_write(dat, col_metadata, unit_metadata, 
            .title="A test EML file", 
            file="tmp.xml", 
            file_description="Test data, only intended for testing")

  require(XML)
  me <- xpathSApply(doc, "//contact//givenName", xmlValue)
  expect_that(me, equals("Carl"))
#  unlink("tmp.xml") # clean up
})


