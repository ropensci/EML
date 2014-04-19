

eml_attribute <- function(from, ...){
        new("attribute", 
            attributeName = from[[1]],
            attributeDefinition = from[[2]],
            measurementScale = eml_measurementScale(from[[3]], from[[4]], ...))
}


eml_measurementScale <- function(unit.def, col.class, attrListID = NULL){

  ## FIXME HACK.  Consider more explicit R-based col.class, 
  if(col.class == "nominal" && length(unit.def) == 1)
    new("measurementScale", 
        nominal = new("nominal", 
                      nonNumericDomain = new("nonNumericDomain",
                                             textDomain = new("textDomain", 
                                                              definition = unit.def))))
  else 
  switch(col.class,
         nominal = new("measurementScale", 
                       nominal = new("nominal", 
                                     nonNumericDomain = eml_nonNumericDomain(unit.def))), 
         ordinal = new("measurementScale", 
                       ordinal = new("ordinal", 
                                     nonNumericDomain = eml_nonNumericDomain(unit.def))), 
         ratio = new("measurementScale", 
                     ratio = new("ratio",
                                 numericDomain = new("numericDomain", 
                                                     numberType = "real"), #FIXME get numberType properly
                                 unit = eml_unit(unit.def[[1]]))), 
         # FIXME has precision and numericDomain@numberType, numericDomain@boundsGroup
         dateTime = new("measurementScale", 
                        dateTime = eml_dateTime(unit.def[[1]]) ), 
         interval = new("measurementScale", 
                        interval = new("interval",
                                       numericDomain = new("numericDomain", 
                                                           numberType = "real"), 
                                       unit = eml_unit(unit.def[[1]])))
         )
}

eml_dateTime <- function(formatstring){ # FIXME perform validation. Accept R notation (%Y -> YYYY)
  new("dateTime", formatString = formatstring)
}
eml_nonNumericDomain <- function(from){
new("nonNumericDomain", 
    enumeratedDomain = 
      new("enumeratedDomain", 
          codeDefinition = 
            new("ListOfcodeDefinition", 
                lapply(names(from), 
                       function(name) new("codeDefinition", 
                                          code = name, 
                                          definition = as.character(from[name]))))))
}

eml_unit <- function(unit){
  if(is_standard_unit(unit)){ 
    out <- new("unit", 
               standardUnit = unit) 
  } else {
    out <- new("unit", customUnit = unit)
    if(!in_custom_library(unit))
      create_custom_unit(unit)
  }
  out
}


in_custom_library <- function(unit){
  custom_units <- mget("custom_units", envir = EMLConfig, ifnotfound=list(list()))$custom_units
  unit %in% sapply(custom_units, `[[`, "id")
}


#' create a custom unit
#' 
#' create a custom unit
#' @param id The id of the unit, given in camelCase with `Per` signifying division, Squared for second power, etc.  
#' @param name The name of the unit, by default the same as the id.   
#' @param unitType The type of the unit. 
#' @param parentSI the parent SI unit from the Standard Units list
#' @param multiplierToSI The multiplicative factor to convert the given unit into the parent unit
#' @param constantToSI An additive constant needed for the conversion, such as farenheight to celsius
#' @param abbreviation Optional abbreviation
#' @param description a plain text description of the unit
#' @details Defines a custom unit whose id is used in the unit definition metadata. See https://github.com/ropensci/EML/issues/12 
#' @return The unit definition (invisibly), as a list object.  A list of these returned objects
#' can be passed to the \code{\link{eml}} function directly to define additional units, bypassing
#' the config mechanism used by default.  
#' @export
#' @examples
#'  create_custom_unit(id = "metersSquaredPerHectare",
#'                     parentSI = "dimensionless",
#'                     unitType = "dimensionless",
#'                     multiplierToSI = "0.0001",
#'                     description = "Square meters per hectare")
#' 
create_custom_unit <- function(id,
                               unitType = NULL,
                               parentSI = NULL, 
                               multiplierToSI = NULL, 
                               name = id, 
                               constantToSI = NULL,
                               abbreviation = NULL,
                               description = NULL){
  if(in_custom_library(id))
    return(NULL)
  else { 
  # FIXME if is nomeric, convert multiplier to a character 
  # without, e.g.,  0.0001 becoming "1e-4"
   
    if(interactive()){
      if(is.null(unitType))
        unitType <- readline(paste("unitType for", id, "not found. Please specify the unitType"))
      if(is.null(multiplierToSI))
        multiplierToSI <- readline(paste("multiplierToSI for", id, "not defined. Please specify the unit conversion factor to the parent SI unit\n"))
      if(is.null(parentSI))
        parentSI <- readline(paste("parentSI for", id, "not defined. Please specify the parent unit in the SI system\n"))
    }

    # FIXME Make sure id is camelcase or convert it to such
    if(is.null(description))
      description <- camelCase_to_human(id)

    unit.def <- list(id = id, 
                    multiplierToSI = multiplierToSI, 
                    name = name, 
                    parentSI = parentSI, 
                    unitType = unitType,
                    description = description)
    custom_units <- mget("custom_units", envir = EMLConfig, 
                         ifnotfound=list(list()))$custom_units


    assign("custom_units", c(custom_units, list(unit.def)), envir=EMLConfig)

    invisible(unit.def)
  }
}

camelCase_to_human <- function(x){
  x <- gsub('([a-z]+)([A-Z][a-z]+)', '\\1 \\2', x)
  x <- gsub('([a-z]+)([A-Z][a-z]+)', '\\1 \\2', x)
}





serialize_custom_units <- function(custom_units, id){
  unitList <- newXMLNode("unitList", .children =
    lapply(custom_units, function(unit.def){
      attrs <- unit.def[names(unit.def != "description")]
      newXMLNode("unit", attrs = attrs, 
                 newXMLNode("description", unit.def$description))
            }
    )
  )
  new("additionalMetadata",
      describes = id,
      metadata = new("metadata", 
                     unitList))


}
          





# https://knb.ecoinformatics.org/#external//emlparser/docs/eml-2.1.1/eml-unitTypeDefinitions.html#StandardUnitDictionary
# FIXME perform fuzzy matching
is_standard_unit <- function(unit){
  f <- system.file("units", "standard_unit_list.csv", package="EML")
  std_units <- read.csv(f)
  ## check for matches against other columns
  unit %in% std_units[["EML_Name"]]
}
