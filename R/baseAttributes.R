
setClass("id", representation(id = "character"))

setClass("has_scope", 
         representation(id = "character",
                        system = "character",
                        scope = "character"),
         prototype = prototype( scope = "Document"))

# need to teach to/from methods to deal with system & scope 
