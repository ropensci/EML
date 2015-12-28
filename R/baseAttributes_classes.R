
setClass("id", slots = c(id = "character"),
         contains = "eml.2.1.1")

setClass("id_scope", 
         slots = c(id = "character",
                        system = "character",
                        scope = "character"),
         prototype = prototype(scope = "document"),
         contains = "eml.2.1.1")

# need to teach to/from methods to deal with system & scope 
