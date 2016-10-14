

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
read_eml <- function(file, ...) {
  node <- XML::xmlRoot(XML::xmlParse(file, ...))
  emlToS4(node)
}



## Creates a 'show' method so that eml S4 elements display in XML format instead of the
## impossible-to-read S4 format
setMethod("show", signature("eml-2.1.1"), function(object)
  show(S4Toeml(object)))

# cat(yaml::as.yaml(XML::xmlToList(S4Toeml(object))))
