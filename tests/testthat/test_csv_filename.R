context("CSV file naming")

#source(system.file("demo/ex1.R", package="EML")) # load dat, col.defs, unit.defs
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




  test_that("We can document an external csv file path directly without parsing or renaming it", {

  write.csv(dat, "test.csv")
  eml <- eml("test.csv", col.defs = col.defs, unit.defs = unit.defs, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "test.csv")

  unlink(eml_get(eml, "csv_filepaths"))

})



test_that("We can specify the csv file name explicitly at through higher-level constructor", {

  dattab <- eml_dataTable(dat, col.defs = col.defs, unit.defs = unit.defs, filename="my_special_filename.csv")
  eml <- eml(dattab, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "my_special_filename.csv")

  unlink(eml_get(eml, "csv_filepaths"))
})


test_that("We create a sensible default csv file name", {


  eml <- eml(dat, col.defs = col.defs, unit.defs = unit.defs, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "data_table_\\S{6}\\.csv")

  unlink(eml_get(eml, "csv_filepaths"))

})
