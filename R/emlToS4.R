## Used as the basis for all coercion methods from XML::XMLInternalElementNode
## to EML's S4 objects.

## Assumes slot is named by the name of the repeated element
## but has type "ListOf<element>" which contains a list containing
## the repeated elements.

#' @import XML

emlToS4 <- function (node, obj = new(xmlName(node)), ...){

  node_name <- xmlName(node)
  attrs <- xmlAttrs(node)
  children <- drop_comment_nodes(xmlChildren(node))
  xml_names <- names(children)


  s4 <- new(node_name)

  slot_classes <- get_slots(node_name)
  s4_names <- names(slot_classes)
  subclasses <- xml_names[!xml_names %in% s4_names]
  not_sub <- xml_names[xml_names %in% s4_names]

  metanames <- s4_names[grepl("^[A-Z]", s4_names)]
  metaclasses <- lapply(metanames, get_slots)
  names(metaclasses) <- metanames



  for(child in names(attrs)){
    slot(s4, child) <- new("xml_attribute",attrs[[child]])
  }

  ## consider xmlValue assignment if no matches for class
  if(length(metaclasses) == 0 && length(subclasses) > 0){
      s4 <- new(node_name)
      s4@.Data <- xmlValue(node)
  } else {


    ## These elements, like "title", go to s4@ResourceGroup@title,
    ## rather than s4@title, where ResourceGroup is metaclass
    for(child in unique(subclasses)){
      y = lapply(metaclasses, function(x) match(child, names(x)))
      s = names(y)[!is.na(y)]
      cls <- metaclasses[[s]][[ y[[s]] ]]
      if(grepl("^ListOf", cls))
        slot(slot(s4, s), child) <- listof(children, child)
      else if(cls == "character")
        slot(slot(s4, s), child) <- xmlValue(children[[child]])
      else
        slot(slot(s4, s), child) <- as(children[[child]], child)
    }

    ## These are the normal s4@slot items
    for(child in unique(not_sub)){
      cls <- slot_classes[[child]]
      if(grepl("^ListOf", cls)){
        slot(s4,child) <- listof(children, child)
      } else if(cls == "character"){
        slot(s4,child) <- xmlValue(children[[child]])
      } else {
        slot(s4,child) <- as(children[[child]], child)
      }
    }


  }

  s4
}

##
listof <- function(kids, element, listclass = paste0("ListOf", element))
  new(listclass, lapply(kids[names(kids) == element], emlToS4))  ## subsets already


##  HTML-style comments create: XMLInternalCommentNode as xmlChildren, which we don't want
drop_comment_nodes <- function(nodes){
  drop <- sapply(nodes, function(x) is(x, "XMLInternalCommentNode"))
  nodes[!drop]
  }


