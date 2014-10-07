
#' Define a new unit type
#' 
#' Define a kind of unit that is not already available in EML
#' @param id the id of the unitType, in camelCase.  See details.
#' @param dimensions a list of named character vectors. Must include
#' a value for "name" that corresponds to a fundamental unit
#' type: either mass, length, or time.  Optionally include a value
#' for "power" where appropriate, see examples.
#' @param name the name for the unit, usually the same as the id (set by default)
#' @return the new unit type definition is stored for this R session
#' and appended to any EML objects generated during that session.  
#' Also invisibly returns the unit_type entry.  
#' @details This function defines base types of units when
#' no such type is available.  If your unit can be converted
#' to an existing base type (e.g. milligrams / Liter can be
#' converted to the SI measure of mass per volume as kg/m^3
#' using the appropriate scaling factor). 
#' 
#' For selecting id/name values: We suggest a camelCase
#' name based on the raw units, such as massPerLength. If your
#' unit has a 
#' @examples
#' # define a base unitType to use with units like kg/m
#' eml_define_unitType("massPerLength", 
#'                    dimensions = 
#'                      list(c(name="mass"), 
#'                           c(name="length", power="-1")))
#' 
#' @export
eml_define_unitType <- function(id,
                                dimensions,
                                name = id){
  dims <- new("stmml_ListOfdimension",
              lapply(dimensions, function(d)
                     new("stmml_dimension", 
                         name = d["name"],
                         power = as.character(na.omit(d["power"])))))
  unit_type <- new("stmml_unitType", 
                   id = id,
                   dimensions = dims,
                   name = name)

}
