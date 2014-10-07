
setClass("stmml_unit",
         slots = c(id = "character",
                   unitType = "character",
                   parentSI = "character", 
                   multiplierToSI = "character", 
                   name = "character", 
                   constantToSI = "character",
                   abbreviation = "character",
                   description = "character"))

setClass("stmml_dimension", slots = c(name = "character",
                                      power = "character"))
setClass("stmml_ListOfdimension", contains="list")

setClass("stmml_unitType",
         slots = c(id = "character",
                   dimensions = "stmml_ListOfdimension",
                   name = "character"))

setClass("stmml_ListOfunitType", contains="list")
setClass("stmml_ListOfunit", contains="list")

#' concatenate
#' 
#' concatenate
#' @param x,... units to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-stmmlunit
# @name class-stmml_unit
#' @aliases c,stmml_unit-method
setMethod("c", signature("stmml_unit"), function(x, ..., recursive = FALSE) new("stmml_ListOfunit", list(x, ...)))

#' concatenate
#' 
#' concatenate
#' @param x,... objects to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-stmmlunitType
# @name class-stmml_unitType
#' @aliases c,stmml_unitType-method
setMethod("c", signature("stmml_unitType"), function(x, ..., recursive = FALSE) new("stmml_ListOfunitType", list(x, ...)))

