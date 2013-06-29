#' Return the citation information to an EML file.  
#' 
#' @aliases citation.eml
#' @param doc an object of the class eml, as returned from `eml_read`, or the filename of an eml object 
#' @details Can simply be called as `citation(doc)` after reading in a file
#' with eml_read.  
#' @seealso \code{\link{citation}}
eml_citation <- function(doc){
  if(is.character(doc)){
    # doc <- eml_read(doc)
    doc <- xmlParse(doc)
  }
  
  stop("This function does not yet exist")
  ## Extract all the necessary citation information from the relevant nodes.  
  ## Not sure what the best way to do this is, could be lots of different nodes to consider.  
#   xmlGetNodeSet("")

  ## Convert citation metadata into a bibentry object
}
