#' EML access definition
#'
#' Define a generic public access node
#' Possible that we can simply omit the access node.  

eml_access <- function(){
  newXMLNode("access", .children = 
    newXMLNode("allow", .children = list(
      newXMLNode("principle", "public"), 
      newXMLNode("permission", "read"))))
}
