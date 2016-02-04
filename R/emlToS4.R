## Used as the basis for all coercion methods from XML::XMLInternalElementNode
## to EML's S4 objects.

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.

#' @import XML

emlToS4 <- function (node, obj = new(xmlName(node)), ...){

  node_name <- xmlName(node)
  s4 <- new(node_name)

  slot_classes <- getClass(node_name)@slots
  attrs <- xmlAttrs(node)

  children <- drop_comment_nodes(xmlChildren(node))

  if(is(s4, "character"))
    s4 <- new(node_name, xmlValue(node))

  for(child in names(attrs)){
    slot(s4, child) <- new("xml_attribute",attrs[[child]])
  }

  if(!is(s4, "character")){
    for(child in names(children)){
      cls <- slot_classes[child]
      if(grepl("^ListOf", cls))
        slot(s4,child) <- new(cls[[1]], list(as(children[[child]], child)))
      else if(cls == "character")
        slot(s4,child) <- xmlValue(children[[child]])
      else
        slot(s4,child) <- as(children[[child]], child)
    }
  }
  s4
}

##  HTML-style comments create: XMLInternalCommentNode as xmlChildren, which can cause problems.
## Rather than just drop them, we are assuming in the XML-parsing world that we only work with XMLInternalElementNode objects
## anyway (e.g. the setAs methods are defined only for that class), so just get them.
drop_comment_nodes <- function(nodes){
  keep <- sapply(nodes, function(x) is(x, "XMLInternalElementNode"))
  nodes[keep]
  }

