#' @export
setGeneric("dataTable", function(object) standardGeneric("dataTable"))

setGeneric("attributeList", function(object) standardGeneric("attributeList"))

#' @export
setGeneric("citationInfo", function(object) standardGeneric("citationInfo")) # can overload 'citation' if we didn't set a generic

#' @export
setGeneric("creator", function(object) standardGeneric("creator"))
#' @export
setGeneric("contact", function(object) standardGeneric("contact"))

#' @export
setGeneric("col_classes", function(object) standardGeneric("col_classes"))

#' @export
setGeneric("metadata", function(object) standardGeneric("metadata"))

#' @export
setGeneric("col.defs", function(object) standardGeneric("col.defs"))

#' @export
setGeneric("unit.defs", function(object) standardGeneric("unit.defs"))

#' @export
setGeneric("id", function(x) standardGeneric("id"))
          
#' @export 
setGeneric("version", function(x) standardGeneric("version"))


#' @export
setGeneric("filepath", function(from) standardGeneric("filepath"))


#' @export
setGeneric("keywords", function(object) standardGeneric("keywords"))


