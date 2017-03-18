

#' read_eml
#'
#' read_eml
#' @param file path to an EML file
#' @param ... additional arguments to \code{\link{read_xml}}
#' @return an eml object (S4 object)
#' @export
#' @import methods xml2
#' @examples
#' f <- system.file("xsd/test", "eml.xml", package = "EML")
#' eml <- read_eml(f)
read_eml <- function(file, ...) {
  node <- xml2::read_xml(file, ...)
  emlToS4(node)
}



## Creates a 'show' method so that eml S4 elements display in XML format instead of the
## impossible-to-read S4 format
setMethod("show", signature("eml-2.1.1"), function(object){
  tmp <- tempfile()
  write_eml(object, tmp, namespaces = character(), ns = character(), options = c("format", "no_declaration"))
  cat(readLines(tmp), sep="\n")
})
