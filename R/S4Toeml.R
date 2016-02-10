

## Used as the basis of most (all) coercion methods from EML S4
## to XML::XMLInternalElementNode class
##
## - Will convert only the id to an attribute, everything else is a child node
## - Cannot be used in coercions to XML because returns null.  Therefore
## `setAs("someS4class", "XMLInternalElementNode", function(from) S4Toeml(from))`
## will fail!

#' @import XML
#' @import methods
S4Toeml <- function(obj,
                    node = NULL,
                    excluded_slots = c("namespaces", "dirname", "xmlNodeName"),
                    ns = character()){

    who <- slotNames(obj)
    if("namespaces" %in% who & length(ns) == 0){
      ns <- obj@namespaces
    }

    slot_classes <- get_slots(class(obj))
    is_attribute <- sapply(slot_classes, function(x) x == "xml_attribute")

    attribute_elements <- who[is_attribute]

    ## Allow XML node name to be defined using a special slot (instead of class name)

    if("xmlNodeName" %in% who){
      node_name <- slot(obj, "xmlNodeName")
    } else {
      node_name <- class(obj)[1]
    }


    if(length(ns) > 0)
      node_name <- paste0("eml:", node_name)

    if(is.null(node))
      node <- newXMLNode(node_name, namespaceDefinitions = ns)




    who <- who[!(who %in% excluded_slots)] # drop excluded slots
    for(s in who){
      ## Attributes
      if(s %in% attribute_elements){
        if(length(slot(obj,s)) > 0){
          attrs <- as.character(slot(obj,s))
          names(attrs) <- s
          addAttributes(node, .attrs = attrs)
        }

      ## Capitalized slots are meta-types, and should not create a new xmlNode but instead
      ## pass their children directly to their parent node.
      } else if(grepl("^[A-Z]", s)){
        X = slot(obj, s)
        if(!isEmpty(X)){
          addChildren(node, S4Toeml(X, node = node))
        }
      } else {
        ## Complex child nodes
        X = slot(obj, s)
        if(!isEmpty(X)){
          if(is(X, "list")){
            if(is.character(X[[1]]) & length(get_slots(class(X[[1]]))) <= 1)
              addChildren(node, lapply(X, function(x) newXMLNode(class(x), x)))
            else
              addChildren(node, lapply(X, as, "XMLInternalElementNode"))
          } else if(isS4(X)){
            addChildren(node, as(slot(obj, s), "XMLInternalElementNode"))
          ## Simple Child nodes
          } else if(length(X) > 0){
             if(s == class(obj)[1] || s == ".Data")              # special case
              addChildren(node, X)   #
             else
              addChildren(node, newXMLNode(s, X))
          ## No child node
          }
        } else {
          node
        }
      }
    }


    node
}


isEmpty <- function(obj){
  if(!isS4(obj)){
    if(length(obj) > 0)
      out <- FALSE
    else
      out <- TRUE
  } else {
    if( identical(obj, new(class(obj)[1])) )
      out <- TRUE
    else if(is(obj, "list"))
      out <- all(sapply(obj, isEmpty))  # a ListOf object of length > 0 is still empty if all elements are empty
    else {
      empty <- sapply(slotNames(obj),
      function(s){
        if(isS4(slot(obj, s)))
          isEmpty(slot(obj,s))
        else {
          if(length(slot(obj, s)) == 0)
            TRUE
          else if(length(slot(obj, s)) > 0)
            FALSE
        }
      })
      out <- !any(!empty)
    }
    out
  }
}


get_slots <- function(class_name){
  getClass(class_name)@slots
}
