


#' get rdf
#'   
#' get rdf
#' @param eml an eml file, file name, or XML content (text string). See xsltApplyStyleSheet
#' @return an rdf file containing metadata that could be rendered in Dublin Core.  
# @export
# @examples
# file <- system.file("examples", "hf205.xml", package = "EML")
# get_rdf(file) # not working yet

get_rdf <- function(eml){
  require(Sxslt)
  # FIXME stylesheet not working yet
  # FIXME detect EML version first in selecting which stylesheet to use.
  if(is(eml, "eml"))
    eml <- eml_write(eml)

  to_rdf <- system.file("xsl", "eml210toDublinCore.xsl", package="EML")
  rdf <- Sxslt::xsltApplyStyleSheet(eml, to_rdf)
}
