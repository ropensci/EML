
setClass("id", representation(id = "character"))

setClass("id_scope", 
         representation(id = "character",
                        system = "character",
                        scope = "character"),
         prototype = prototype(scope = "document"))

# need to teach to/from methods to deal with system & scope 
