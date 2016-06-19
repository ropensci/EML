testthat::context("get_attributes")

eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "EML"))
A <- eml@dataset@dataTable[[1]]@attributeList
df <- get_attributes(A)

eml <- read_eml(system.file("xsd/test/eml-i18n.xml", package = "EML"))
A <- eml@dataset@dataTable[[1]]@attributeList
df1 <- get_attributes(A)


