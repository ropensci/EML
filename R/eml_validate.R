

#' eml_validate
#'
#' eml_validate processes an EML document using the XSD schema for the
#' appropriate version of EML and determines if the document is schema-valid
#' as defined by the XSD specification
#' @param eml file path, xml_document,
#' @param encoding optional encoding for files, default UTF-8.
#' @param schema path to schema
#' @return Whether the document is valid (logical)
#' @note this function is simply an alias to `eml_validate` in `emld` package
#' @examples
#' \donttest{
#' 
#' f <- system.file("extdata", "example.xml", package = "emld")
#' 
#' ## validate file directly from disk:
#' eml_validate(f)
#' 
#' ## validate an eml object:
#' eml <- read_eml(f)
#' eml_validate(eml)
#' }
#' 
#' @export
#' @importFrom emld eml_validate
eml_validate <- emld::eml_validate
