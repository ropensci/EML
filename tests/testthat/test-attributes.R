testthat::context("get_attributes")

eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "EML"))
A <- eml@dataset@dataTable[[1]]@attributeList
df <- get_attributes(A)

eml <- read_eml(system.file("xsd/test/eml-i18n.xml", package = "EML"))
A <- eml@dataset@dataTable[[1]]@attributeList
df1 <- get_attributes(A)

testthat::test_that("we can have numeric data with bounds where some bounds are missing", {
  
  df <- data.frame(attributeName = "svl", 
                   attributeDefinition = "Snout-vent length", 
                   unit = "meter", 
                   numberType = "real", 
                   minimum = "0", 
                   maximum = NA,
                   stringsAsFactors = FALSE)
  attributeList <- set_attributes(df, col_classes = "numeric")
  
  dataTable <- new("dataTable", 
                   attributeList = attributeList, 
                   entityName = "file.csv", 
                   entityDescription = "csv file containing the data", 
                   physical = set_physical("file.csv"))
  
  me <- as.person("Carl Boettiger <cboettig@gmail.com>")
  dataset <- new("dataset", title = "Example EML", creator = me, contact = me, dataTable = dataTable)
  eml <- new("eml", packageId = "123", system = "uuid", dataset = dataset)
  
  v <- eml_validate(eml)
  testthat::expect_true(v)


})