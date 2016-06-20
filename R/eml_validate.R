
#' validate_eml
#'
#' validate_eml
#' @param eml an eml class object, file, or xml document
#' @param encoding optional, if eml is a file path / an eml and has special characters, one can 
#' gives the encoding used by xmlParse.
#' @param ... additional arguments to eml_write, such as namespaces
#' 
#' @return Whether the document is valid (logical)
#' 
#' @examples \donttest{
#'  
#'  f <- system.file("xsd/test", "eml.xml", package = "EML")
#'  
#'  ## validate given a file name, without needing to parse first
#'  eml_validate(f)
#' 
#' ## Validate given an "eml" object
#' eml <- read_eml(f) 
#' eml_validate(eml)
#'  
#' ## Can validate fragments as well, though may need the relevant namespace
#' dataset <- new("dataset", title = "incomplete, invalid EML")
#' eml_validate(dataset, namespaces = c(ds = "eml://ecoinformatics.org/dataset-2.1.1"), ns = "ds")
#' 
#' }
#' 
#' @export
eml_validate <- function(eml, encoding = NULL, ...){
  
  schema <- system.file("xsd/eml.xsd", package = "EML") #"http://ropensci.github.io/EML/eml.xsd"
  
  if(isS4(eml))
    eml <- write_eml(eml, ...)
  
  
  eml <- xmlParse(eml, encoding = encoding)
  
  result <- xmlSchemaValidate(schema, eml)
  
  if (result$status != 0) {
    lapply(result$errors, message_validation_error)
    
    return(FALSE)
  } else {
    return(TRUE)
  }
}


#' message_validation_error
#' 
#' Create a useful message() for an XML validation error.
#'
#' @param error The validation error (XML::XMLError)
#'
#' @return Nothing.
message_validation_error <- function(error) {
  message(paste0(error$line, ".", error$col, ": ", error$msg))
}