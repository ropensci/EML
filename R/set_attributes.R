

#' set_attributes
#'
#' set_attributes
#' @param attributes a joined table of all attribute metdata
#' (such as returned by \code{\link{get_attributes}}, see details)
#' @param factors a table with factor code-definition pairs; see details
#' @details
#' @return an eml "attributeList" object
set_attributes <- function(attributes, factors){
  new("attributeList")
}
