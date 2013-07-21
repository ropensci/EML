#' Create  an EML Software node
#' 
#' @param license Text string containing the software license 
#' @param version of the software 
#' @param node an existing software node we wish to append to
#' @details We need to pass implementation
eml_software <- function(title, authors, license, version, implementation, 
                         .dependency = list(), ..., node = NULL){
  if(is.null(node))
    node <- newXMLNode("software")
  addChildren(node, newXMLNode("title", title))
  for(author in authors){
    addChildren(node, as.eml_person(author, "creator"))
  }
  addChildren(node, do.call(eml_implementation, implementation))

  if(!is.empty(.dependency))
    addChildren(node, do.call(eml_dependency, .dependency))
  addChildren(node, newXMLNode("license", license))
  addChildren(node, newXMLNode("version", version))

  node
}

#' Create an EML implementation node
#' 
#' @param node the path to an existing implementation node
eml_implementation <- function(node=NULL, distribution, ...){
   if(is.null(node))
     node <- newXMLNode("implementation")
   addChildren(node, 
               do.call(eml_distribution, distribution),
               parent = node)
}
