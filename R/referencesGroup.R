
setClass("references", 
         representation(references = "character")) # A special case handles this
setClass("ListOfreferences", 
         contains = "list")

setClass("referencesGroup", 
         representation("references" = "ListOfreferences"))

setAs("XMLInternalElementNode", "referencesGroup", function(from) emlToS4(from))
setAs("XMLInternalElementNode", "references", function(from) emlToS4(from))

