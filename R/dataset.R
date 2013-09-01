
setClass("ListOfcreator", contains = "list",
         validity = function(object)
               if(!all(sapply(object, is, "creator")))
                  "not all elements are creator objects"
               else
                 TRUE)

setClass("dataset", 
         representation('title' = "character",
                        creator = "ListOfcreator",
                        contact = "responsibleParty",         ###  No idea why this is not working 
                        rights  = "character",
                        'methods' = "methods",
                        dataTable = "dataTable"),
        prototype(rights = as.character(getOption("defaultRights")),
                  creator = new("ListOfcreator",
                                list(getOption("defaultCreator"))),
                  contact = getOption("defaultContact") ))

## FIXME consider adding coercions for the creator/contact methods
## Consider a different way of setting these defaults?  

setAs("XMLInternalElementNode", "dataset",  function(from) emlToS4(from))



