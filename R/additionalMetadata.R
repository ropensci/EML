setClass("metadata", contains="XMLInternalElementNode")
setAs("metadata", "XMLInternalElementNode", function(from) newXMLNode("metadata", from))
setAs("XMLInternalElementNode", "metadata", function(from) new("metadata", from))


setClass("additionalMetadata", 
         slots = c(metadata = "metadata",
                   describes = "character",
                   id = "character"))

setAs("additionalMetadata", "XMLInternalElementNode", function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "additionalMetadata", 
      function(from){ 
        if("describes" %in% names(from))
          describes <- xmlValue(from[["describes"]])
        else
          describes <- character(0)
        new("additionalMetadata", 
            describes = describes, 
            metadata = as(from[["metadata"]], "metadata"))
      })


setClass("ListOfadditionalMetadata", contains="list")
