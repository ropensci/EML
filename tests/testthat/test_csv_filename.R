context("CSV file naming")

  test_that("We can document an external csv file path directly without parsing or renaming it", {
  source(system.file("demo/ex1.R", package="EML")) # load dat, col.defs, unit.defs

  write.csv(dat, "test.csv")
  eml <- eml("test.csv", col.defs = col.defs, unit.defs = unit.defs, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "test.csv")

  unlink(eml_get(eml, "csv_filepaths"))

})



test_that("We can specify the csv file name explicitly at through higher-level constructor", {

#  demo("ex1", "EML") # load dat, col.defs, unit.defs
  source(system.file("demo/ex1.R", package="EML")) # load dat, col.defs, unit.defs

  dattab <- eml_dataTable(dat, col.defs = col.defs, unit.defs = unit.defs, filename="my_special_filename.csv")
  eml <- eml(dattab, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "my_special_filename.csv")

  unlink(eml_get(eml, "csv_filepaths"))
})


test_that("We create a sensible default csv file name", {

#  demo("ex1", "EML") # load dat, col.defs, unit.defs
  source(system.file("demo/ex1.R", package="EML")) # load dat, col.defs, unit.defs

  eml <- eml(dat, col.defs = col.defs, unit.defs = unit.defs, creator = "joe plummer <joe@plummer.com>")
  expect_output(eml_get(eml, "csv_filepaths"), "data_table_\\S{6}\\.csv")

  unlink(eml_get(eml, "csv_filepaths"))

})
