setClass("additionalMetadata", 
         representation(metadata = "XMLInternalElementNode",
                        describes = "character",
                        id = "character"))
setAs("XMLInternalElementNode", "additionalMetadata", 
      function(from){ 
        if("describes" %in% names(from))
          describes <- xmlValue(from[["describes"]])
        else
          describes <- character(0)
        new("additionalMetadata", 
            describes = describes, 
            metadata = from[["metadata"]])
      })
setAs("additionalMetadata", "XMLInternalElementNode", function(from) S4Toeml(from))


setClass("ListOfadditionalMetadata", contains="list")
