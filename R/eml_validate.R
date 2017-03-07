
#' eml_validate
#'
#' eml_validate processes an EML document using the XSD schema for the
#' appropriate version of EML and determines if the document is schema-valid
#' as defined by the XSD specification
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
#' @importFrom xml2 read_xml xml_validate
eml_validate <- function(eml, encoding = "UTF-8"){

  # validation is based on the xml format not the S4 objects
  if(isS4(eml)){
    f <- tempfile()
    write_eml(eml, file = f, encoding = encoding)
    eml <- f
  }
  doc <- xml2::read_xml(eml, encoding = encoding)
  # tidy up
  if(exists(f)) unlink(f)

  # Use the EML namespace to find the EML version and the schema location
  try(schema <- eml_locate_schema(doc))
  schema_doc <- xml2::read_xml(schema)
  result <- tryCatch(xml2::xml_validate(doc, schema_doc),
    error = function(e) {
      warning("The document could not be validated.")
      list(status=1, errors=c(NULL), warnings=c(e))
    }
  )

result

#  if (result$status != 0) {
#    lapply(result$errors, message_validation_error)
#    return(FALSE)
#  } else {
#    return(TRUE)
#  }
}

#' eml_locate_schema
#'
#' eml_locate_schema returns the location of the XSD schema file for a given
#' EML document, as shipped with the EML R package.
#'
#' @details The schema location is based on the last path component from the EML
#' namespace (e.g., eml-2.1.1), which corresponds to the directory containing xsd
#' files that ship with the EML package. Schema files are copies of the schemas
#' from the EML versioned releases. If an appropriate schema is not found,
#' the function returns FALSE.
#'
#' @param eml an xml2::xml_document instance for an EML document
#'
#' @return fully qualified path to the XSD schema for the appropriate version of EML
#'
#' @examples \donttest{
#' f <- system.file("examples", "example-eml-2.1.1.xml", package = "EML")
#' eml <- xml2::read_xml(f)
#' schema <- eml_locate_schema(eml)
#' }
#' @importFrom stringr str_match str_c
#' @importFrom xml2 xml_ns
#' @export
eml_locate_schema <- function(eml) {


    if(!is(eml,'xml_document')) {
        stop("Argument is not an instance of an XML document (xml2::xml_document)")
    }
    namespace <- xml2::xml_ns(eml)
    stopifnot(is(namespace, 'xml_namespace'))
    eml_version <- stringr::str_match(namespace[[1]], "eml://ecoinformatics.org/(.*)")[,2]
    schema <- system.file(stringr::str_c("xsd/", eml_version, "/eml.xsd"), package='EML')
    if(schema == '') {
        stop(stringr::str_c("No schema found for namespace: ", namespace[[1]]))
    }
    return(schema)
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
