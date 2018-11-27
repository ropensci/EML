#' read_eml
#'
#' Read an EML file into R as an emld object.
#' @param x path to an EML file
#' @param from explicit type for the input format. Possible values:
#' "xml", "json", "list", or "guess" with "xml" as the default.
#'
#' @return an emld object (list / S3 object)
#' @export
#' @examples
#' f <- system.file("extdata", "example.xml", package = "emld")
#' eml <- read_eml(f)
#' @export
#' @importFrom emld as_emld

read_eml <- function(x, from = "xml") {
  emld::as_emld(x, from = from)
}
