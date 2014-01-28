#' @include baseAttributes.R
#' @include attribute.R
#' @include entity.R


setClass("dataTable_slots", 
         slots = c(attributeList = "attributeList",  ## Hack to make entityGroup slots listed first!  
                   caseSensitive = "character",
                   numberOfRecords = "integer"),
         contains = "id_scope")

setAs("XMLInternalElementNode", "dataTable_slots",  function(from) emlToS4(from))
setAs("dataTable_slots", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("dataTable", 
         contains=c("entityGroup", "dataTable_slots"))
setAs("XMLInternalElementNode", "dataTable",  function(from) emlToS4(from))
setAs("dataTable", "XMLInternalElementNode",   function(from) S4Toeml(from))




