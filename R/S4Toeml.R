#' @include reml_environment.R


########### Write Methods ###############



## Used as the basis of most (all) coercion methods from EML S4 
## to XML::XMLInternalElementNode class
##
## - Will convert only the id to an attribute, everything else is a child node
## - Cannot be used in coercions to XML because returns null.  Therefore
## `setAs("someS4class", "XMLInternalElementNode", function(from) S4Toeml(from))`
## will fail!

attribute_elements <- c("id", "system", "scope", "packageId")

S4Toeml <- function(obj, 
                    node = newXMLNode(class(obj)[1]),
                    excluded_slots = c("namespaces", "dirname")){
    who <- slotNames(obj)
    who <- who[!(who %in% excluded_slots)] # drop excluded slots
    for(s in who){
      ## Attributes
      if(s %in% attribute_elements){
        if(length(slot(obj,s)) > 0){
          attrs <- slot(obj,s)
          names(attrs) <- s
          addAttributes(node, .attrs = attrs)
        }
      } else {
        ## Complex child nodes
        if(!isEmpty(slot(obj,s))){
          if(is(slot(obj, s), "list")){
            addChildren(node, lapply(slot(obj, s), as, "XMLInternalElementNode"))
          } else if(isS4(slot(obj, s))){
            addChildren(node, as(slot(obj, s), "XMLInternalElementNode"))
          ## Simple Child nodes  
          } else if(length(slot(obj, s)) > 0){
             if(s == class(obj)[1])              # special case
              addChildren(node, slot(obj, s))   #
             else  
              addChildren(node, newXMLNode(s,slot(obj, s)))
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

