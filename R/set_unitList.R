
#' set_unitList
#' 
#' @param units a data.frame describing the custom units, see details.
#' @param unitTypes optional, a data.frame defining any additional unitTypes not already defined
#' @return a stmml:unitList element that can be included in additionalMetadata
#' @export

#' @details The units data.frame must have the following columns:
#'  - name: the name of unit (singular). e.g. 'meter', 'second'
#'  - unitType: the base type of unit, e.g. 'length'.  If not from a standard type, a new unitType must be provided
#'  - multiplierToSI: the multiplicative constant to convert to the SI unit. 
#'  - parentSI: the name of the parent SI unit, e.g. second.  
#'  - description: a text string describing the unit of measure.

#'  The following columns are optional:
#'  - id: usually the same as the name of the unit, e.g. second
#'  - abbreviation: common abbreviation, e.g. s
#'  - constantToSI: an additive constant to convert to the equivalent SI unit. If not given, default is "0"
#'
#' The unitType table must have the following columns:
#'  - name:
#'  - id: optional, default is same as the name
#'  - dimension: name of a base dimension of the unit
#'  - power: the power to which the dimension is raised (NA implies power of 1)
#'  
#'  For instance, the following table defines three base unitTypes: 
#'  speed (i.e. m/s), acceleration (m/s^2), and frequency (1/s)
#'  
#'  name,         dimension, power,
#'  speed,        length,    NA,
#'  speed,        time,      "-1",
#'  acceleration, length,    NA,
#'  acceleration, time,      "-2",
#'  frequency,    time,      "-1",
set_unitList <- function(units, unitTypes = NULL) {
  
  if(is.null(unitTypes))
    ListOfunitType <- new("ListOfstmml:unitType")
  else{
    
    if(is.null(unitTypes$id))
      unitTypes$id <- unitTypes$name
  
    
    ListOfunitType <- as(lapply(1:dim(unitTypes)[1], function(i){
      row <- unitTypes[i,]
      dimensions <- unitTypes[unitTypes$name == unitTypes[i,"name"], ]
      
      
      ListOfdimension <- as(lapply(1:dim(dimensions)[1], function(i){
        row <- dimensions[i,]
        new("stmml:dimension", name = row[["dimension"]], power = na2empty(row[["power"]]))
      }), "ListOfstmml:dimension")
      
      new(
        "stmml:unitType",
         name = row[["name"]],
         id = row[["id"]],
         dimension = ListOfdimension
      )
    }), "ListOfstmml:unitType")
    
    
  }
  
  if(is.null(units$id))
    units$id <- units$name
  if(is.null(units$abbreviation))
      units$abbreviation <- rep(NA, length(units$name))
  if(is.null(units$constantToSI))
    units$constantToSI <- rep("0", length(units$name))
  
  ## Coerce all columns to characters
          
    ListOfunit <- as(lapply(1:dim(units)[1], function(i){
    row <- units[i,]
    new(
      "stmml:unit",
      id = row[["id"]],
      name = row[["name"]],
      abbreviation = na2empty(row[["abbreviation"]]),
      unitType = row[["unitType"]],
      parentSI = row[["parentSI"]],
      multiplierToSI = row[["multiplierToSI"]],
      constantToSI = row[["constantToSI"]],
      description = new("stmml:description", row[["description"]])
    )
  }), "ListOfstmml:unit")
  
    
  
  out <- new("stmml:unitList")
  out@unitType <- ListOfunitType
  out@unit <- ListOfunit
  out
 
}

# custom unitType:
# data.frame(name, id, dimension_name, dimension_power)