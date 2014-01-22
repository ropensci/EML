context("publish")

test_that("We can publish a draft to figshare", {

  library(EML)
  library(XML)

dat = data.set(river = c("SAC",  "SAC",   "AM"),
               spp   = c("king",  "king", "ccho"),
               stg   = c("smolt", "parr", "smolt"),
               ct    = c(293L,    410L,    210L),
               col.defs = c("River site used for collection",
                            "Species common name",
                            "Life Stage", 
                            "count of live fish in traps"),
               unit.defs = list(c(SAC = "The Sacramento River", 
                                  AM = "The American River"),
                                c(king = "King Salmon", 
                                  ccho = "Coho Salmon"),
                                c(parr = "third life stage", 
                                  smolt = "fourth life stage"),
                                "number"))

  eml <- eml(dat, contact = "test person <test@example.com>")
  f <- "publish_example.xml" 
  csv <- eml_get(eml, "csv_filepaths")
  eml_write(eml, f)

  ## Publish the data to figshare (as a draft)
  id <- eml_publish(f, categories="Ecology", tags = "EML", description="Test of publishing EML", destination="figshare")

  ## Confirm that the appropriate metadata has been written to figshare
  library(rfigshare)
  details <- fs_details(id, mine=TRUE)
  expect_that(details$categories[[1]]$name, equals("Ecology"))

  ## Confirm that the EML contains the figshare metadata 
  doc <- xmlParse(paste0("figshare_", f)) # check uploaded copy, since cannot download draft/private file
  eml_cat <- xpathSApply(doc, "//additionalMetadata[@id = 'figshare']/metadata/keywordSet/keyword", xmlValue)
  expect_true("Ecology" %in% eml_cat)

  ## Clean up 
  fs_delete(id)
  unlink(csv)
  unlink(f)
  unlink(paste0("figshare_", f))
})
