#' @include resource.R 

setClass("proceduralStep", slots = c(procedure = "character")) # FIXME DUMMY  class, the real class is recursive.  


setClass("ListOfproceduralStep", contains="list")
setMethod("c", signature("proceduralStep"), function(x, ...) new("ListOfproceduralStep", list(x, ...)))


setClass("protocol_elements", 
         slots = c(proceduralStep = "ListOfproceduralStep"))

setClass("protocol", 
         contains = c("resourceGroup", 
                      "protocol_elements",
                      "referencesGroup"))


setAs("XMLInternalElementNode", "protocol",   function(from) emlToS4(from))
setAs("protocol", "XMLInternalElementNode",   function(from) S4Toeml(from))


