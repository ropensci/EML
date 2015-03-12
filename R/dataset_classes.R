#' @include reml_environment.R
#' @include eml_config.R
#' @include resource_classes.R
#' @include dataTable_classes.R
#' @include methods_classes.R
#' @include entity_classes.R

# #' @include spatialRaster.R
# #' @include spatialVector.R
# #' @include view.R


setClass("ListOfdataTable", contains = "list")
setClass("ListOfotherEntity", contains = "list")

#' concatenate
#'
#' concatenate
#' @param x,... dataTables to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-dataTable
setMethod("c", signature("dataTable"), function(x, ..., recursive = FALSE) new("ListOfdataTable", list(x, ...)))

#' concatenate
#'
#' concatenate
#' @param x,... otherEntities to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-otherEntity
setMethod("c", signature("otherEntity"), function(x, ..., recursive = FALSE) new("ListOfotherEntity", list(x, ...)))

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
                   dataTable = "ListOfdataTable",
                   otherEntity = "ListOfotherEntity"),
         contains="id_scope")

## Declaration of the dataset class
##
## dataset_elements should really be in `representation`, but
## must come after resourceGroup elements se we define them as
## a separate class.
setClass("dataset",
         contains = c("resourceGroup",
                      "dataset_elements",
                      "referencesGroup"),
# if defining a prototype, undefined elements default to NULL?? WTF?
        prototype = prototype(coverage = new("coverage"),
                              pubDate = as.character(Sys.Date()),
                              title = "metadata",
                              # FIXME Make title something more intelligent.  Use id?
                              intellectualRights = as.character(get("defaultRights", envir=EMLConfig))))

## Coercion methods to/from XML
setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



