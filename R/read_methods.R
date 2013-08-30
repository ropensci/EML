

################## Read methods ##################


setAs("XMLInternalElementNode", "individualName",   function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "additionalMetadata",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "eml_person", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "contact", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "creator", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "methodStep",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "methods",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "simpleDelimited",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "textFormat",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "dataFormat", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "offline", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "online", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "distribution", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "physical", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "codeDefinition",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "ListOfcodeDefinition",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "textDomain",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "nonNumericDomain",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "nominal",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "ordinal",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "numericDomain",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "unit", function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "ratio",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "interval",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "dateTime",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "measurementScale",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "attribute",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "attributeList",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "entity",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "dataTable",  function(from) xmlToS4(from))
#setAs("XMLInternalElementNode", "dataset",  function(from) xmlToS4(from))
setAs("XMLInternalElementNode", "eml", function(from) xmlToS4(from))


## ICK! have to write custom methods every time we get multiply defined fields... really need XMLSchema... 
setAs("XMLInternalElementNode", "dataset", function(from){
         obj = new("dataset")
         kids = xmlChildren(from)
         obj@creator = new("ListOf_creator", lapply(kids[names(kids) == "creator"], as, "creator"))

         xmlToS4(from, obj)

         obj
})
 


setAs("XMLInternalElementNode", "attributeList", function(from){
        
        obj <- new("attributeList") # Create object
        atrs <- xmlAttrs(from)      # add attributes
        if(!is.na(attrs["id"]))
           obj@id <- attrs["id"]
        kids = xmlChildren(from)    # add child nodes
        obj@attribute = new("ListOfattribute", lapply(kids[names(kids) == "attribute"], as, "attribute"))
})
setAs("attributeList", "XMLInternalElementNode", function(from){
      newXMLInternalNode("attributeList", kids = from@attribute)  
})


