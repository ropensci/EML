


setClass("dataset_elements",                           ## Hack to get element order correct 
         representation(purpose = "character", 
                        contact = "responsibleParty",
                        publisher = "responsibleParty",
                        methods = "methods",
                        dataTable = "dataTable")) 

setClass("dataset",
         contains = c("resourceGroup", "dataset_elements", "referencesGroup"),
        prototype = prototype(intellectualRights = 
                              as.character(get("defaultRights", envir=remlConfig))))

setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



