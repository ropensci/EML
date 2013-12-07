
#' @include baseAttributes.R
setClass("dataTable_slots", 
         slots = c(attributeList = "attributeList",  ## Hack to make entityGroup slots listed first!  
                        caseSensitive = "character",
                        numberOfRecords = "integer"),
         contains = "id_scope")

setAs("XMLInternalElementNode", "dataTable_slots",  function(from) emlToS4(from))
setAs("dataTable_slots", "XMLInternalElementNode",   function(from) S4Toeml(from))

#' @include attribute.R
#' @include entityGroup.R
setClass("dataTable", 
         contains=c("entityGroup", "dataTable_slots"))
setAs("XMLInternalElementNode", "dataTable",  function(from) emlToS4(from))
setAs("dataTable", "XMLInternalElementNode",   function(from) S4Toeml(from))




## constructor / generator for data table
eml_dataTable <- function(dat, 
                          meta, 
                          title = character(0), 
                          description = character(0), 
                          filename = character(0), ...){
  if(length(title) > 0 & length(filename) == 0)
    filename <- paste0(gsub(" ", "_", title), ".csv")
  meta <- detect_class(dat, meta)
  id <- reml_id()
  dataTable <- new("dataTable",
                  id = id[["id"]],
                  system = id[["system"]],
                  scope = id[["scope"]],
                  entityName = title,
                  entityDescription = description,
                  attributeList = as(meta, "attributeList"),
                  physical = eml_physical(dat, filename=filename),
                  caseSensitive = 'yes',
                  numberOfRecords = dim(dat)[1])
}





