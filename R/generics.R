#' @export
setGeneric("extract", function(from, using) standardGeneric("extract"))

#' @export
setGeneric("dataTable", function(object) standardGeneric("dataTable"))

#' @export
setGeneric("attributeList", function(object) standardGeneric("attributeList"))

#' @export
setGeneric("citationInfo", function(object) standardGeneric("citationInfo")) # can overload 'citation' if we didn't set a generic

#' @export
setGeneric("contact", function(object) standardGeneric("contact"))

#' @export
setGeneric("col_classes", function(object) standardGeneric("col_classes"))

