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

  ## use default namespaces if not provided
  if(is.null(namespaces))
    namespaces <- eml_namespaces

  ## Convert to xml
  node <- s4_to_xml(eml, ns = namespaces)

  ## setting root element ns doesn't appear to do anything:
  #xml2::xml_set_namespace(tmp, ns, paste0(ns, "://ecoinformatics.org/", ns, "-2.1.1"))

  ## so we set it manually by renaming the node:
  who <- xml_name(node)
  xml_name(node) <- paste(ns, who, sep=":")

  ## Now we write out to file
  xml2::write_xml(node, file, ...)

}


## Default XML namespaces
eml_namespaces <- xml2::xml_ns(xml2::read_xml(system.file("examples", "example-eml-valid.xml", package = "EML")))
