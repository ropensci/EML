context("publish")

test_that("We can publish a draft to figshare", {

  library(EML)
  library(XML)

  f <- system.file("examples", "hf205.xml",  package="EML")
  csv <- system.file("examples", "hf205-01-TPexp1.csv",  package="EML")

  # move files to working directory
  saveXML(xmlParse(f), "hf205.xml")
  write.csv(read.csv(csv), "hf205-01-TPexp1.csv")

  ## Publish the data to figshare (as a draft)
  id <- eml_publish("hf205.xml", categories="Ecology", destination="figshare")

  ## Confirm that the appropriate metadata has been written to figshare
  library(rfigshare)
  details <- fs_details(id, mine=TRUE)
  expect_that(details$categories[[1]]$name, equals("Ecology"))

  ## Confirm that the EML contains the figshare metadata 
  doc <- xmlParse("figshare_hf205.xml") # check uploaded copy, since cannot download draft/private file
  eml_cat <- xpathSApply(doc, "//additionalMetadata[@id = 'figshare']/metadata/keywordSet/keyword", xmlValue)
  expect_that(eml_cat, equals("Ecology"))

  ## Clean up 
  fs_delete(id)
  unlink("hf205-01-TPexp1.csv")
  unlink("hf205.xml")
  unlink("figshare_hf205.xml")
})
