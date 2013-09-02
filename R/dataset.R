

setClass("dataset", 
         representation('title' = "character",
                        creator = "ListOfcreator",
                        contact = "responsibleParty",         ###  No idea why this is not working 
                        rights  = "character",
                        'methods' = "methods",
                        dataTable = "dataTable"),
        prototype(rights = as.character(getOption("defaultRights"))
#                  , creator = new("ListOfcreator",
#                                list(get("defaultCreator", envir=remlConfig))),
#                  contact = get("defaultContact", envir=remlConfig) 
                  )
        )

## FIXME consider adding coercions for the creator/contact methods
## Consider a different way of setting these defaults?  

setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))
setAs("dataset", "XMLInternalElementNode",   function(from) S4Toeml(from))



