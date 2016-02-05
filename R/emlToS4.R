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

  for(child in names(attrs)){
    slot(s4, child) <- new("xml_attribute",attrs[[child]])
  }


  for(child in unique(names(children))){
    if(is(children[[child]], "XMLInternalTextNode")){
      s4 <- new(node_name)
      s4@.Data <- xmlValue(node)
    } else {
      cls <- slot_classes[[child]]
      if(grepl("^ListOf", cls))
        slot(s4,child) <- listof(children, child)
      else if(cls == "character")
        slot(s4,child) <- xmlValue(children[[child]])
      else
        slot(s4,child) <- as(children[[child]], child)
    }
  }

  s4
}

##
listof <- function(kids, element, listclass = paste0("ListOf", element))
  new(listclass, lapply(kids[names(kids) == element], as, element))  ## subsets already


##  HTML-style comments create: XMLInternalCommentNode as xmlChildren, which we don't want
drop_comment_nodes <- function(nodes){
  drop <- sapply(nodes, function(x) is(x, "XMLInternalCommentNode"))
  nodes[!drop]
  }

