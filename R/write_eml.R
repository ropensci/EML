#' write_eml
#'
#' write_eml
#' @param eml an eml class object
#' @param file file name to write XML.
#' @param namespaces named character vector of additional XML namespaces to use.
#' @param ns root namespace abbreviation
#' @param ... additional arguments to \code{\link{saveXML}}
#' @return If file is not specified, the result is a character string containing
#'    the resulting XML content. Otherwise return silently.
#' @export
#' @import methods xml2
#' @importFrom xml2 write_xml xml_set_namespace
#' @examples
#' f <- system.file("examples", "example-eml-valid.xml", package = "EML")
#' eml <- read_eml(f)
#' write_eml(eml, "test.xml")
#' unlink("test.xml") # clean up
write_eml <- function(eml,
                      file,
                      namespaces = NULL,
                      ns = "eml",
                      ...) {

  tmp <- s4_to_xml(eml, ns = c(namespaces, eml_namespaces))
  xml2::xml_set_namespace(tmp, ns, paste0(ns, "://ecoinformatics.org/eml-2.1.1"))
  xml2::write_xml(tmp, file, ...)

}


## Default XML namespaces
eml_namespaces <- c(
  "xmlns:eml" = "eml://ecoinformatics.org/eml-2.1.1",
  "xmlns:xs" = "http://www.w3.org/2001/XMLSchema",
  "xmlns:xsi" = "http://www.w3.org/2001/XMLSchema-instance",
  "xmlns:stmml" = "http://www.xml-cml.org/schema/stmml_1.1"
)
