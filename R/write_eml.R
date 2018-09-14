

#' write_eml
#'
#' write_eml
#' @param eml an emld class object
#' @param file file name to write XML.
#' @param namespaces named character vector of additional XML namespaces to use.
#' @param ns root namespace abbreviation
#' @param ... additional arguments to \code{\link{write_xml}}
#' @return If file is not specified, the result is a character string containing
#'    the resulting XML content. Otherwise return silently.
#' @export
#' @importFrom uuid UUIDgenerate
#' @importFrom xml2 write_xml xml_set_namespace
#' @examples
#' f <- system.file("extdata", "example.xml", package = "emld")
#' eml <- read_eml(f)
#' write_eml(eml, "test.xml")
#' eml_validate("test.xml")
#' unlink("test.xml") # clean up
write_eml <- function(eml,
                      file,
                      namespaces = NULL,
                      ns = "eml",
                      ...) {
  ## FIXME, insist on a packageId, or consider validation which can ignore id?
  if (is.null(eml$packageId)) {
    eml$packageId <- uuid::UUIDgenerate()
    eml$system <- "uuid"
  }

  emld::as_xml(eml, file, ns = ns)
}
