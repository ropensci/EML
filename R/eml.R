
#' read_eml
#'
#' read_eml
#' @param file path to an EML file
#' @param ... additional arguments to \code{\link{xmlParse}}
#' @return an eml object (S4 object)
#' @export
# @importFrom XML xmlRoot xmlParse
#' @import methods XML
#' @examples
#' f <- system.file("xsd/test", "eml.xml", package = "eml2")
#' eml <- read_eml(f)
read_eml <- function(file, ...){
  node <- XML::xmlRoot(XML::xmlParse(file, ...))
  removeAttributes(node, .attrs = "xsi:schemaLocation")
  as(node, "eml")
}


#' write_eml
#'
#' write_eml
#' @param eml an eml class object
#' @param file file name to write XML. If NULL, will return XML as character string.
#' @param ... additional arguments to \code{\link{saveXML}}
#' @return If file is not specified, the result is a character string containing
#'    the resulting XML content. Otherwise return silently.
#' @export
#' @import methods XML
# @importFrom XML saveXML
#' @examples
#' f <- system.file("xsd/test", "eml.xml", package = "eml2")
#' eml <- read_eml(f)
#' write_eml(eml)
write_eml <- function(eml, file = NULL, ...){
  XML::saveXML(as(eml, "XMLInternalElementNode"), file = file, ...)
}
