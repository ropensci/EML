df <- data.frame(attributeName = "svl", attributeDefinition = "Snout-vent length", unit = "meter", numberType = "real", minimum = "0", maximum = NA)
attributeList <- set_attributes(df, col_classes = "numeric")
dataTable <- new("dataTable", 
                 attributeList = attributeList, 
                 entityName = "file.csv", entityDescription = "csv file containing the data", physical = set_physical("file.csv"))

me <- as.person("Carl Boettiger <cboettig@gmail.com> [cre]")
dataset <- new("dataset", title = "Example EML", creator = me, contact = me, dataTable = dataTable)
eml <- new("eml", packageId = "123", system = "uuid", dataset = dataset)
eml_validate(eml)

