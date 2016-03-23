
#' validate_eml
#'
#' validate_eml
#' @param eml an eml class object, file, or xml document
#' @param ... additional arguments to eml_write, such as namespaces
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
#' v <- eml_validate(dataset, namespaces = c(ds = "eml://ecoinformatics.org/dataset-2.1.1"), ns = "ds")
#' 
#' 
#' v$errors[[1]]$msg 
#' 
#' }
#' 
#' @export
eml_validate <- function(eml, ...){

  schema <- system.file("xsd/eml.xsd", package = "EML") #"http://ropensci.github.io/EML/eml.xsd"

  if(isS4(eml))
    eml <- write_eml(eml, ...)

  xmlSchemaValidate(schema, eml)
}
