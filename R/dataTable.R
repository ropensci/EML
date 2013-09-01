#' @include attribute.R
#' @include entityGroup.R
setClass("dataTable", 
         representation(attributeList = "attributeList",
                        caseSensitive = "logical",
                        numberOfRecords = "integer"),
         contains="entityGroup")

setAs("XMLInternalElementNode", "dataTable",  function(from) emlToS4(from))


