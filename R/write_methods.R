
########### Write Methods ###############

#setAs("eml", "XMLInternalDocument", function(from))
#setAs("dataTable", "XMLInternalNode", function(from))
#setAs("", "XMLInternalNode", function(from))





setAs("enumeratedDomain", "XMLInternalNode", function(from)
      newXMLNode("enumeratedDomain", from))

setAs("attributeList", "XMLInternalNode", function(from)
      newXMLNode("attributeList", from))

setAs("eml_person", "XMLInternalNode", function(from) emlS4ToXML(from))
setAs("individualName", "XMLInternalNode", function(from) emlS4ToXML(from))
setAs("attribute", "XMLInternalNode", function(from) emlS4ToXML(from))


setAs("codeDefinition", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("ListOfcodeDefinition", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("textDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("nonNumericDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("nominal", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("ordinal", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("numericDomain", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("unit", "XMLInternalNode", function(from) emlS4ToXML(from))
setAs("ratio", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("interval", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("dateTime", "XMLInternalNode",  function(from) emlS4ToXML(from))
setAs("measurementScale", "XMLInternalNode",  function(from) emlS4ToXML(from))



emlS4ToXML <- function(obj){
  if(!isEmpty(obj)){
    node <- newXMLNode(class(obj)[1])
    for(s in slotNames(obj)){
      ## Attributes
      if(s == "id"){
        if(length(obj@id) > 0){
          addAttributes(node, .attrs = c("id" = obj@id))
        }
      } else {
        ## Complex child nodes
        if(isS4(slot(obj, s))){
          addChildren(node, slot(obj, s))
        ## Simple Child nodes  
        } else if(length(slot(obj, s)) > 0){
          addChildren(node, newXMLNode(s,slot(obj, s)))
        ## No child node
        } else {
          node
        }
      }
    }
    node
  } else {
    NULL
  }
}


isEmpty <- function(obj){
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

#emlS4ToXML <- function(obj){
#  node <- newXMLNode(class(obj)[1])
#  for(s in slotNames(obj)){
#    if(s == "id"){
#      addAttributes(node, .attrs = c("id" = uuid::UUIDgenerate()))
#    } else {
#      if(isS4(slot(obj, s))){ 
#        if(!identical(slot(obj, s), new(s))){  ## S4 object not equal to its prototype (e.g. not empty)
#          addChildren(node, slot(obj, s))
#        }
#      } else {
#        if(length(slot(obj, s)) > 0){
#          addChildren(node, newXMLNode(s,slot(obj, s)))
#        } 
#      }
#    }
#  }
#  node
#}
