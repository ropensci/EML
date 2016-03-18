
#' set_unitList
#' 
#' Define custom units, including new unitTypes.  Note that it is not necessary to define
#' most common units, see get_unitList to display standard units or parse other custom unitList files.
#' 
#' @param units a data.frame describing the custom units, see details.
#' @param unitTypes optional, a data.frame defining any additional unitTypes not already defined
#' @param as_metadata logical, default FALSE. If true, returns a `metadata` element suitable for `additionalMetadata`, see below.
#' @return 
#' 
#' By default the function returns an S4 unitList object, like other set_ methods. If as_metadata is set to TRUE,
#' function returns a `metadata` element.  EML permits a metadata element to contain arbitrary XML, including but
#' not limited to unitList XML for custom units (which is really part of the stmml unit vocabulary used by EML, but
#' part of a more general standard.) This means that once converted to a metadata element, the unit list is coerced
#' into stmml XML and can no longer be subset or modified in the same way.  
#' 
#' @export
#' @details 
#' 
#' The units data.frame must have the following columns:
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
#' In practice, researchers may save these tables of custom units they frequently use in an external .csv 
#' or other format and read them in to R for ready re-use.  
#'
#' The unitType table must have the following columns:
#'  - name:
#'  - id: optional, default is same as the name
#'  - dimension: name of a base dimension of the unit
#'  - power: the power to which the dimension is raised (NA implies power of 1)
#'  
#' @examples 
#' 
#'  ## create the "unitType" table for custom unit
#'  name = c("speed", "speed", "acceleration", "acceleration", "frequency")
#'  dimension = c("length", "time", "length", "time", "time")
#'  power = c(NA, "-1", NA, "-2", "-1")
#'  unitTypes <- data.frame(name = name, dimension = dimension, 
#'                          power = power, stringsAsFactors = FALSE)
#'  
#'  ## Create the units table
#'  name = c("minute", "centimeter")
#'  unitType = c("time", "length")
#'  parentSI = c("second", "meter")
#'  multiplierToSI = c("0.0166", "1")
#'  description = c("one minute is 60 seconds", "centimeter is a 100th of a meter")
#'  units = data.frame(name = name, unitType = unitType, parentSI = parentSI, 
#'                     multiplierToSI = multiplierToSI, description = description, 
#'                     stringsAsFactors = FALSE)
#'  
#'  set_unitList(units, unitTypes)
#' 
set_unitList <- function(units, unitTypes = NULL, as_metadata = FALSE) {
  
  if(is.null(unitTypes)){
    ListOfunitType <- new("ListOfunitType")
  } else {
    
    if(is.null(unitTypes$id))
      unitTypes$id <- unitTypes$name
  
    types <- unique(unitTypes$name)
    ListOfunitType <- as(lapply(types, function(type){
      dimensions <- unitTypes[(unitTypes$name == type), ]
      ListOfdimension <- as(lapply(1:dim(dimensions)[1], function(i){
        row <- dimensions[i,]
        new("dimension", name = row[["dimension"]], power = na2empty(row[["power"]]))
      }), "ListOfdimension")
      
      new(
        "unitType",
         name = dimensions[["name"]][1],
         id = dimensions[["id"]][1],
         dimension = ListOfdimension
      )
    }), "ListOfunitType")
    
    
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
      "unit",
      id = row[["id"]],
      name = row[["name"]],
      abbreviation = na2empty(row[["abbreviation"]]),
      unitType = row[["unitType"]],
      parentSI = row[["parentSI"]],
      multiplierToSI = row[["multiplierToSI"]],
      constantToSI = row[["constantToSI"]],
      description = new("description", row[["description"]])
    )
  }), "ListOfunit")
  
    
  
  out <- new("unitList")
  out@unitType <- ListOfunitType
  out@unit <- ListOfunit
  
  if(as_metadata){
    xml_meta <- S4Toeml(out)
    setXMLNamespace(xml_meta, c(stmml =  "http://www.xml-cml.org/schema/stmml_1.1"))
    new("metadata", list(xml_meta))
  } else{ 
    out
  }
}

# custom unitType:
# data.frame(name, id, dimension_name, dimension_power)

#' get_unitList
#' @param unitList a unitList object.  Usually found in eml@additionalMetadata[[1]]@metadata, see details
#' @return a list with two data.frames: "units", a table defining unit names, types, and conversions to SI,
#' and "unitTypes", defining the type of unit. For instance, the unit table could define "Hertz" as a unit
#' of unitType frequency, and the unitType define frequency as a type whose dimension is 1/time.  
#'
#' @details If no unitList is provided, the function reads in the eml-unitDictionary defining all standard
#' units and unitTypes.  This provides a convenient way to look up standard units and their EML-recognized names
#' when defining metadata, e.g. in the table passed to `set_attributes()`.  
#' @export
#' 
#' @examples 
#' 
#' # Read in additional units defined in a EML file
#' f <- system.file("xsd/test/eml-datasetWithUnits.xml", package = "EML")
#' eml <- read_eml(f)
#' unitList <- get_unitList(eml@@additionalMetadata[[1]]@@metadata[[1]])
#' 
#' ## Read in the definitions of standard units:
#' get_unitList()
#' 
#' 
get_unitList <- function(unitList = read_eml(system.file("xsd/eml-unitDictionary.xml", package = "EML"))){
  
  if(is(unitList, "XMLInternalNode")){
    unitList <- emlToS4(unitList)
  } else if(is(unitList, "metadata")){
    unitList <- emlToS4(unitList[[1]])
  }
    
  list(units = get_unit(unitList@unit), unitTypes = get_unitType(unitList@unitType))
}

get_unit <- function(unit){
  map_df(unit, function(u){
    data.frame(id = or_na(as.character(u@id)), 
               name = or_na(as.character(u@name)),
               unitType = or_na(as.character(u@unitType)),
               parentSI = or_na(as.character(u@parentSI)),
               multiplierToSI = or_na(as.character(u@multiplierToSI)),
               constantToSI = or_na(as.character(u@constantToSI)),
               abbreviation = or_na(as.character(u@abbreviation)),
               description = or_na(as.character(u@description)),
               stringsAsFactors = FALSE)
  })
}

get_unitType <- function(unitType){
  map_df(unitType, function(ut){
    map_df(ut@dimension, function(d){
      data.frame(
      id = or_na(as.character(ut@id)),
      name = or_na(as.character(ut@name)),
      dimension = or_na(as.character(d@name)),
      power =  or_na(as.character(d@power)),
      stringsAsFactors = FALSE)
    })
  })
}