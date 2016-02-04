

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
                    excluded_slots = c("namespaces", "dirname", "xmlNodeName")){

    who <- slotNames(obj)

    slot_classes <- get_slots(obj)
    is_attribute <- sapply(slot_classes, function(x) x == "xml_attribute")

    attribute_elements <- who[is_attribute]

    ## Allow XML node name to be defined using a special slot (instead of class name)
    if(is.null(node)){
      if("xmlNodeName" %in% who)
        node <- newXMLNode(slot(obj, "xmlNodeName"))
      else
        node <- newXMLNode(class(obj)[1])
    }



    who <- who[!(who %in% excluded_slots)] # drop excluded slots
    for(s in who){
      ## Attributes
      if(s %in% attribute_elements){
        if(length(slot(obj,s)) > 0){
          attrs <- as.character(slot(obj,s))
          names(attrs) <- s
          addAttributes(node, .attrs = attrs)
        }
      } else {
        ## Complex child nodes
        X = slot(obj, s)

        if(!isEmpty(X)){
          if(is(X, "list")){
            if(is.character(X[[1]]) & length(get_slots(X[[1]])) <= 1)
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


get_slots <- function(s4){
  getSlots(getClass(class(s4)))
}
