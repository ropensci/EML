context("publish")

test_that("We can publish a draft to figshare", {
#  file <- system.file("doc", "my_eml_data.xml", package="reml")


  ## Generate some example data
  dat <- data.frame(a = 1:2, b = 1:2)
  col_metadata <- c(a = "A", b = "B")
  unit_metadata <- list(a = "number", b="number")
  eml_write(dat, col_metadata, unit_metadata, 
            .title = "A test EML file", file = "tmp.xml",
            file_description = "Test data, only intended for testing")

  ## Publish the data to figshare (as a draft)
  id <- eml_publish("tmp.xml", categories="Ecology")

  ## Confirm that the appropriate metadata has been written to figshare
  library(rfigshare)
  details <- fs_details(id, mine=TRUE)
  expect_that(details$categories[[1]]$name, equals("Ecology"))


  ## Confirm that the EML contains the figshare metadata 
  doc <- xmlParse("tmp.xml")
  eml_cat <- xpathSApply(doc, "//additionalMetadata[@id = 'figshare']/metadata/keywordSet/keyword", xmlValue)
  expect_that(eml_cat, equals("Ecology"))

  ## Clean up 
  fs_delete(id)
  unlink("tmp.xml") 
  unlink("a_b.csv") 
})
