testthat::context("get_attributes")

eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "eml2"))
A <- eml@dataset@dataTable[[1]]@attributeList
df <- get_attributes(A)

eml <- read_eml(system.file("xsd/test/eml-i18n.xml", package = "eml2"))
A <- eml@dataset@dataTable[[1]]@attributeList
df1 <- get_attributes(A, join = FALSE)


df2 <- get_attributes(A, join = TRUE)
testthat::expect_equal(dim(df2$attributes)[1], 12)



attributeList <- set_attributes(df2$attributes, df2$factors)
testthat::expect_equal(length(attributeList@attribute), 12)

testthat::test_that("We can handle missing columns in attributes table", {
  att <- df2$attributes
  att$storageType <- NULL
  att$attributeLabel <- NULL
  attributeList <- set_attributes(att, df2$factors)
  testthat::expect_equal(length(attributeList@attribute), 12)
})

## df1$datetimes %>% dplyr::full_join(df1$numerics) %>% dplyr::full_join(df1$chars) %>% dplyr::full_join(df1$columns) %>% dplyr::as_data_frame()
#merge(merge(merge(df1$datetimes, df1$numerics, all = TRUE), df1$chars, all = TRUE), df1$columns, all = TRUE)  %>% dplyr::as_data_frame()

## merge(merge(merge(df1$numerics, df1$datetimes, all = TRUE), df1$chars, all = TRUE), df1$columns, all = TRUE)  %>% dplyr::as_data_frame()
