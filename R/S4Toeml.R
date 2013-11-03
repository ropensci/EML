########### Write Methods ###############

## Used as the basis of most (all) coercion methods from reml S4 
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
    drop <- match(excluded_slots, who)
    if(!is.na(drop))
      who <- who[-drop] # drop excluded slots
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
            addChildren(node, lapply(slot(obj, s), S4Toeml))
          } else if(isS4(slot(obj, s))){
            addChildren(node, S4Toeml(slot(obj, s)))
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
      FALSE
    else 
      TRUE
  } else {
    if( identical(obj, new(class(obj)[1])) )
      out <- TRUE
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

