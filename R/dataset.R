setClass("publisher", contains="responsibleParty")
setAs("XMLInternalElementNode", "publisher",   function(from) emlToS4(from))
setAs("publisher", "XMLInternalElementNode",   function(from) S4Toeml(from))



setClass("dataset_elements",                           ## Hack to get element order correct 
         representation(purpose = "character", 
                        contact = "contact",
                        publisher = "publisher",
                        methods = "methods",
                        dataTable = "dataTable")) 

setClass("dataset",
         contains = c("resourceGroup", "dataset_elements", "referencesGroup"),
        prototype = prototype(pubDate = as.character(Sys.Date()),
                              intellectualRights = 
                              as.character(get("defaultRights", envir=remlConfig))))

setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



