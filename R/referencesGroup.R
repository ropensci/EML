
setClass("references", 
         representation(references = "character")) # A special case handles this
setAs("XMLInternalElementNode", "references", function(from) emlToS4(from))
setAs("references", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfreferences", 
         contains = "list")

setClass("referencesGroup", 
         representation("references" = "ListOfreferences"))

setAs("XMLInternalElementNode", "referencesGroup", function(from) emlToS4(from))
setAs("referencesGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))


