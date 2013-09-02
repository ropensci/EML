#' @include attribute.R
#' @include entityGroup.R
setClass("dataTable", 
         representation(attributeList = "attributeList",
                        caseSensitive = "logical",
                        numberOfRecords = "integer"),
         contains="entityGroup")

setAs("XMLInternalElementNode", "dataTable",  function(from) emlToS4(from))
setAs("dataTable", "XMLInternalElementNode",   function(from) S4Toeml(from))




## generator for data table
eml_dataTable <- function(dat, metadata, 
                          title = character(0), 
                          description = character(0), 
                          filename = character(0), ...){
  if(length(title) > 0 & length(filename) == 0)
    filename <- paste0(title, ".csv")
  metadata <- detect_class(dat, metadata)
  dataTable = new("dataTable", 
                  entityName = title,
                  entityDescription = description,
                  attributeList = as(metadata, "attributeList"),
                  physical = eml_physical(dat, filename=filename),
                  caseSensitive = TRUE,
                  numberOfRecords = dim(dat)[1])
}





