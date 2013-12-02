
setClass("references", 
         slots = c(references = "character")) # A special case handles this
setAs("XMLInternalElementNode", "references", function(from) emlToS4(from))
setAs("references", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfreferences", 
         contains = "list")

setClass("referencesGroup", 
         slots = c("references" = "ListOfreferences"))

setAs("XMLInternalElementNode", "referencesGroup", function(from) emlToS4(from))
setAs("referencesGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))


