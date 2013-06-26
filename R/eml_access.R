#' Define a generic public access node
#' Possible that we can simply omit the access node.  
access = newXMLNode("access", .children = 
  newXMLNode("allow", .children = list(
    newXMLNode("principle", "public"), 
    newXMLNode("permission", "read"))))
