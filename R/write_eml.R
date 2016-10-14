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
write_eml <-
  function(eml,
           file = NULL,
           namespaces = NULL,
           ns = "eml",
           ...) {
    node <- S4Toeml(eml)
    xmlNamespaces(node) <- c(namespaces, eml_namespaces)
    setXMLNamespace(node, ns)
    XML::saveXML(node, file = file, ...)
  }
## Default XML namespaces
eml_namespaces <- c(
  eml = "eml://ecoinformatics.org/eml-2.1.1",
  xs = "http://www.w3.org/2001/XMLSchema",
  #                   xml = "http://www.w3.org/XML/1998/namespace",
  xsi = "http://www.w3.org/2001/XMLSchema-instance",
  stmml = "http://www.xml-cml.org/schema/stmml_1.1"
)
