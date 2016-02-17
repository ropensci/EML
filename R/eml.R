
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
  emlToS4(node)
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
  node <- S4Toeml(eml)
  xmlNamespaces(node) <- eml_namespaces
  setXMLNamespace(node, "eml")
  XML::saveXML(node, file = file, ...)
}

#' validate_eml
#'
#' validate_eml
#' @param eml an eml class object, file, or xml document
#' @export
eml_validate <- function(eml){

  schema <- system.file("xsd/eml.xsd", package = "eml2") #"http://ropensci.github.io/EML/eml.xsd"

  if(is(eml, "eml"))
    eml <- write_eml(eml)

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





# ## extend the auto-created eml class to include namespaces & schemaLocation by default
# setClass("eml:eml",
#          slots = c(namespaces = "character", xmlNodeName = "character"),
#          contains = "eml",
#          prototype = list(namespaces = eml_namespaces,
#                           xmlNodeName = "eml",
#                           schemaLocation = # should be xsi:schemaLocation... inherited from eml-2.1.1
#                             new("xml_attribute", "eml://ecoinformatics.org/eml-2.1.1 eml.xsd")))
