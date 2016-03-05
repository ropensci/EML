
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
#' f <- system.file("xsd/test", "eml.xml", package = "EML")
#' eml <- read_eml(f)
read_eml <- function(file, ...){
  node <- XML::xmlRoot(XML::xmlParse(file, ...))
  emlToS4(node)
}


#' write_eml
#'
#' write_eml
#' @param eml an eml class object
#' @param file file name to write XML. If NULL, will return XML as character string.
#' @param namespaces named character vector of additional XML namespaces to use.
#' @param ns root namespace abbreviation
#' @param ... additional arguments to \code{\link{saveXML}}
#' @return If file is not specified, the result is a character string containing
#'    the resulting XML content. Otherwise return silently.
#' @export
#' @import methods XML
# @importFrom XML saveXML
#' @examples
#' f <- system.file("xsd/test", "eml.xml", package = "EML")
#' eml <- read_eml(f)
#' write_eml(eml)
write_eml <- function(eml, file = NULL, namespaces = NULL, ns = "eml", ...){
  node <- S4Toeml(eml)
  xmlNamespaces(node) <- c(namespaces, eml_namespaces)
  setXMLNamespace(node, ns)
  XML::saveXML(node, file = file, ...)
}

#' validate_eml
#'
#' validate_eml
#' @param eml an eml class object, file, or xml document
#' @param ... additional arguments to eml_write, such as namespaces
#' 
#' @examples \donttest{
#' ## Can validate fragments as well:
#' dataset <- new("dataset", title = "incomplete, invalid EML")
#' v <- eml_validate(dataset, namespaces = c(ds = "eml://ecoinformatics.org/dataset-2.1.1"), ns = "ds")
#' v$errors[[1]]$msg 
#' }
#' 
#' @export
eml_validate <- function(eml, ...){

  schema <- system.file("xsd/eml.xsd", package = "EML") #"http://ropensci.github.io/EML/eml.xsd"

  if(isS4(eml))
    eml <- write_eml(eml, ...)

  xmlSchemaValidate(schema, eml)
}

## Default XML namespaces
eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
#                   xml = "http://www.w3.org/XML/1998/namespace",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml_1.1")


## Creates a 'show' method so that eml S4 elements display in XML format instead of the
## impossible-to-read S4 format
setMethod("show", signature("eml-2.1.1"), function(object) show(S4Toeml(object)))
