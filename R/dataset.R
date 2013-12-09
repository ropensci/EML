#' @include reml_environment.R
#' @include resource.R

## Helper class definitions for dataset 
setClass("publisher", contains="responsibleParty")
setAs("XMLInternalElementNode", "publisher",   function(from) emlToS4(from))
setAs("publisher", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOfdataTable", contains = "dataTable")


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
        prototype = prototype(pubDate = as.character(Sys.Date()),
                              intellectualRights = 
                              as.character(get("defaultRights", envir=remlConfig))))

## Coercion methods to/from XML 
setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



