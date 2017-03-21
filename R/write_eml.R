#' write_eml
#'
#' write_eml
#' @param eml an eml class object
#' @param file file name to write XML.
#' @param namespaces named character vector of additional XML namespaces to use.
#' @param ns root namespace abbreviation
#' @param ... additional arguments to \code{\link{write_xml}}
#' @return If file is not specified, the result is a character string containing
#'    the resulting XML content. Otherwise return silently.
#' @export
#' @import methods xml2
#' @importFrom xml2 write_xml xml_set_namespace
#' @importFrom uuid UUIDgenerate
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

  ## Make sure `eml` node has a schemaLocation
  if(is(eml, "eml") && is_blank(eml@schemaLocation))
    eml@schemaLocation@.Data <- "eml://ecoinformatics.org/eml-2.1.1 eml.xsd"

  ## By default, we use UUID system to generate packageId
  if("system" %in% slotNames(eml) && is_blank(eml@system))
    slot(eml,"system") <- as("uuid", "xml_attribute")

  ## By default, a packageId will be generated if one is not available (required by schema)
  if(is(eml, "eml") && is_blank(eml@packageId))
    slot(eml,"packageId") <- as(uuid::UUIDgenerate(), "xml_attribute")

  # id <- basename(tempfile("eml"))

  ## use default namespaces if not provided
  if(is.null(namespaces))
    namespaces <- eml_namespaces

  ## Convert to xml
  node <- s4_to_xml(eml, ns = namespaces)
  root <- xml2::xml_root(node)

  prune_empty(root)

  ## setting root element ns doesn't appear to do anything:
  #xml2::xml_set_namespace(tmp, ns, paste0(ns, "://ecoinformatics.org/", ns, "-2.1.1"))
  ## so we set it manually by renaming the node:
  if(!is_blank(ns)){
    root_name <- xml_name(root)
    xml_name(root) <- paste(ns, root_name, sep=":")
  }

  ## Now we write out to file
  xml2::write_xml(root, file, ...)

}


prune_empty <- function(xml){
  before <- 1
  after <- 0
  empty <- "//*[not(@*)][not(*)][not(normalize-space())]"  ##
  while(after < before){
    before <- length(xml_name(xml_find_all(xml, "//*") ))

    ## Avoid removing document root, which results in a segfault
    total <- length(xml_find_all(xml, "//*"))
    if(total > 1){
      xml_remove(xml_find_all(xml, empty))
    }
    after <- length(xml_name(xml_find_all(xml, "//*") ))
  }
  xml
}

# character(0) or "" data
is_blank <- function(x) length(x) < 1 || x == ""

## Default XML namespaces
eml_namespaces <- xml2::xml_ns(xml2::read_xml(system.file("examples", "example-eml-valid.xml", package = "EML")))
