#' Create an eml_distribution node
#' 
#' Defines how a resource is distributed
#' @param url the online url at which a resource can be found
#' @return an EML distribution node
#' @details Currently only provides online distribution types
#' FIXME should be extended to support offline and inline 
#' distribution 
eml_distribution <- function(url, node=NULL){
  if(is.null(node))
    node <- newXMLNode("distribution") 
  addChildren(node, newXMLNode("online", 
                      newXMLNode("url", url)))
  node # already returned by addChildren
}
