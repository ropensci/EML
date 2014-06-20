context("test input formats")

## Add tests with .csv file


test_that("We can use the unit.def/col.def format", {
  dat <- data.frame(river = factor(c("SAC",  
                                     "SAC",   
                                     "AM")),
                    spp   = c("Oncorhynchus tshawytscha",  
                              "Oncorhynchus tshawytscha", 
                              "Oncorhynchus kisutch"),
                    stg   = ordered(c("smolt", 
                                      "parr", 
                                      "smolt"), 
                                    levels=c("parr", 
                                             "smolt")), # => parr < smolt
                    ct    = c(293L,    
                              410L,    
                              210L),
                    day   = as.Date(c("2013-09-01", 
                                      "2013-09-1", 
                                      "2013-09-02")),
                    stringsAsFactors = FALSE)


  col.defs <- c("River site used for collection",
                "Species scientific name",
                "Life Stage", 
                "count of live fish in traps",
                "day traps were sampled (usually in morning thereof)")

  unit.defs <- list(
    c(SAC = "The Sacramento River",     # Factor 
      AM = "The American River"),
   "Scientific name",                   # Character string 
    c(parr = "third life stage",        # Ordered factor 
      smolt = "fourth life stage"),
    c(unit = "number", 
      precision = 1, 
      bounds = c(0, Inf)),              # Integer
    c(format = "YYYY-MM-DD",            # Date
      precision = 1))


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



test_that("We can use the (pseudo-depricated) data.set metadata format", {

  # load sample data
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


  # Write EML
  eml_write(dat, 
      contact="Carl Boettiger <cboettig@ropensci.org>", 
      file = "test.xml")

  # Validate
  o <- eml_validate("test.xml")
  expect_true(all(o)) # all cases validate
  unlink("test.xml")

})



