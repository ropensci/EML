setClass("additionalMetadata", 
         representation(metadata = "character",
                        describes = "character"))
setAs("XMLInternalElementNode", "additionalMetadata",   function(from) emlToS4(from))
setAs("additionalMetadata", "XMLInternalElementNode",   function(from) S4Toeml(from))

