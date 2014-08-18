
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

#' concatenate
#' 
#' concatenate
#' @param x,... units to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-stmmlunit
#' @name class-stmml:unit
setMethod("c", signature("stmml:unit"), function(x, ..., recursive = FALSE) new("stmml:ListOfunit", list(x, ...)))

#' concatenate
#' 
#' concatenate
#' @param x,... objects to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-stmmlunitType
#' @name class-stmml:unitType
setMethod("c", signature("stmml:unitType"), function(x, ..., recursive = FALSE) new("stmml:ListOfunitType", list(x, ...)))

