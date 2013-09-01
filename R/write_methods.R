
########### Write Methods ###############

#setAs("eml", "XMLInternalDocument", function(from))
#setAs("dataTable", "XMLInternalNode", function(from))
#setAs("", "XMLInternalNode", function(from))


#
#
#
#
#
#
#setAs("codeDefinition", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("textDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("enumeratedDomain", "XMLInternalNode", function(from)
#      newXMLNode("enumeratedDomain", from@codeDefinition))
#setAs("nonNumericDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("nominal", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("ordinal", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("numericDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("unit", "XMLInternalNode", function(from) emlS4ToXML(from))
#setAs("ratio", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("interval", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("dateTime", "XMLInternalNode",  function(from) emlS4ToXML(from))
#setAs("measurementScale", "XMLInternalNode",  function(from) emlS4ToXML(from))
#
#setAs("attributeList", "XMLInternalNode", function(from)
#      newXMLNode("attributeList", from))
#
#
#setAs("eml_person", "XMLInternalNode", function(from) emlS4ToXML(from))
#setAs("individualName", "XMLInternalNode", function(from) emlS4ToXML(from))
#setAs("attribute", "XMLInternalNode", function(from) emlS4ToXML(from))
#



## FIXME This works on everyone, but is unsafe.  
## Would be much better to write as an object-specific method.  While
## that would be somewhat verbose, it would also avoid calling this 
## on S4 objects for which the assumptions of this function are not 
## accurate in writing to XML
##
##
## - Will convert only the id to an attribute, everything else is a child node
## - Cannot be used in coercions to XML because returns null.  Therefore
## `setAs("someS4class", "XMLInternalNode", function(from) emlS4ToXML(from))`
## will fail!

S4Toeml <- function(obj){
    node <- newXMLNode(class(obj)[1])
    for(s in slotNames(obj)){
      ## Attributes
      if(s == "id"){
        if(length(obj@id) > 0){
          addAttributes(node, .attrs = c("id" = obj@id))
        }
      } else {
        ## Complex child nodes
        if(!isEmpty(slot(obj,s))){
          if(is(slot(obj, s), "list")){
            addChildren(node, lapply(slot(obj, s), emlS4ToXML))
          } else if(isS4(slot(obj, s))){
            addChildren(node, emlS4ToXML(slot(obj, s)))
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

