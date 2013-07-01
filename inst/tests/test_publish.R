context("publish")

test_that("We can publish a draft to figshare", {
#  file <- system.file("doc", "my_eml_data.xml", package="reml")


  dat = data.frame(a = 1:2, b = 1:2)
  col_metadata = c(a="A", b="B")
  unit_metadata = list(a = "number", b="number")
  doc <- eml_write(dat, col_metadata, unit_metadata, 
            .title="A test EML file", file="tmp.xml",
            file_description="Test data, only intended for testing")

  id <- eml_publish("tmp.xml")


  ## expect_that()

  library(rfigshare)
  fs_delete(id)



  unlink("tmp.xml") # clean up
  unlink("a_b.csv") # clean up
})
