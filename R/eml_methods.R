#' Generate an EML methods node
eml_methods <- function(..., node=NULL){
  if(is.null(node))
    node <- newXMLNode("methods")
  ## Add lots of stuff not written yet... 
  ## http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-methods.html
  node
}
