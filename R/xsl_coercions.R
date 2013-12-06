


# file <- system.file("examples", "hf205.xml", package = "reml")
#' @export
get_rdf <- function(file){
  require(Sxslt)
  # FIXME detect EML version first in selecting which stylesheet to use.
  to_rdf <- system.file("xsl", "eml210toDublinCore.xsl", package="reml")
  rdf <- xsltApplyStyleSheet(file, to_rdf)
}
