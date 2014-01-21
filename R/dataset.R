#' @include reml_environment.R
#' @include eml_config.R 
#' @include resource.R
#' @include dataTable.R
#' @include methods.R

# #' @include spatialRaster.R
# #' @include spatialVector.R
# #' @include view.R


setClass("ListOfdataTable", contains = "list")
setMethod("c", signature("dataTable"), function(x, ...) new("ListOfdataTable", list(x, ...)))


## A Hack to get element order correct without writing
## a custom S4Toeml function (which writes slots in 
## order provided by slotNames), since resourceGroup elements
## must come before these elements
setClass("dataset_elements",     
         slots = c(purpose = "character", 
                   contact = "contact",
                   publisher = "publisher",
                   methods = "methods",
#                   spatialRaster = "ListOfspatialRaster",
#                   spatialVector = "ListOfspatialVector",
#                   view = "view",
                   dataTable = "ListOfdataTable")) 

## Declaration of the dataset class
##
## dataset_elements should really be in `representation`, but 
## must come after resourceGroup elements se we define them as 
## a separate class.  
setClass("dataset",
         contains = c("resourceGroup", 
                      "dataset_elements", 
                      "referencesGroup"),
        prototype = prototype(coverage = new("coverage"), # if defining a prototype, undefined elements default to NULL?? WTF?  
                              pubDate = as.character(Sys.Date()),
                              title = "metadata", # FIXME something more intelligent.  Use id?  
                              intellectualRights = as.character(get("defaultRights", envir=EMLConfig))))

## Coercion methods to/from XML 
setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



