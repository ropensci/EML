context("extracting data from S4 to native R")


## FIXME add unlink commands to remove/cleanup any files created by tests (e.g. the .csv and .xml files)

require(reml)
dat = data.frame(river = c("SAC",  "SAC",   "AM"),
                 spp   = c("king",  "king", "ccho"),
                 stg   = c("smolt", "parr", "smolt"),
                 ct    = c(293L,    410L,    210L))
metadata <- 
  list("river" = list("river",
                      "River site used for collection",
                      c(SAC = "The Sacramento River", 
                        AM = "The American River")),
       "spp" = list("spp",
                    "Species common name", 
                    c(king = "King Salmon", 
                      ccho = "Coho Salmon")),
       "stg" = list("stg",
                    "Life Stage", 
                    c(parr = "third life stage", 
                      smolt = "fourth life stage")),
       "ct"  = list("ct",
                    "count", 
                    "number"))

  S4obj <- reml:::eml(dat, metadata, title = "title", 
               description = "description", 
               creator = "Carl Boettiger <cboettig@gmail.com>")



test_that("we can extract the data unaltered", {
  out_dat <- extract(S4obj@dataset@dataTable@physical)
  expect_identical(dat, out_dat)
})


 
