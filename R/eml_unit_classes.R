
setClass("stmml:unit",
         slots = c(id = "character",
                   unitType = "character",
                   parentSI = "character", 
                   multiplierToSI = "character", 
                   name = "character", 
                   constantToSI = "character",
                   abbreviation = "character",
                   description = "character"))

setClass("stmml:dimension", slots = c(name = "character",
                                      power = "character"))
setClass("stmml:ListOfdimension", contains="list")

setClass("stmml:unitType",
         slots = c(id = "character",
                   dimensions = "stmml:ListOfdimension",
                   name = "character"))

setClass("stmml:ListOfunitType", contains="list")
setClass("stmml:ListOfunit", contains="list")

setMethod("c", signature("stmml:unit"), function(x, ..., recursive = FALSE) new("stmml:ListOfunit", list(x, ...)))
setMethod("c", signature("stmml:unitType"), function(x, ..., recursive = FALSE) new("stmml:ListOfunitType", list(x, ...)))

