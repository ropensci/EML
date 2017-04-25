#' get_unitList
#' @param x a unitList object.  Usually found in eml@additionalMetadata[[1]]@metadata, see details
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
#' \donttest{
#' f <- system.file("xsd/test/eml-datasetWithUnits.xml", package = "EML")
#' eml <- read_eml(f)
#' unitList <- get_unitList(eml@@additionalMetadata[[1]]@@metadata)
#'
#' ## Read in the definitions of standard units:
#' get_unitList()
#' }
#'
get_unitList <-
  function(x = read_eml(system.file("xsd/eml-2.1.1/eml-unitDictionary.xml", package = "EML"))) {
    unitList <- x
    if (is(unitList, "xml_node")) {
      unitList <- emlToS4(unitList)
    } else if (is(unitList, "metadata")) {
      unitList <- emlToS4(unitList[[1]])
    }

    list(units = get_unit(unitList@unit),
         unitTypes = get_unitType(unitList@unitType))
  }



get_unit <- function(unit) {
  map_df(unit, function(u) {
    data.frame(
      id = or_na(as.character(u@id)),
      name = or_na(as.character(u@name)),
      unitType = or_na(as.character(u@unitType)),
      parentSI = or_na(as.character(u@parentSI)),
      multiplierToSI = or_na(as.character(u@multiplierToSI)),
      constantToSI = or_na(as.character(u@constantToSI)),
      abbreviation = or_na(as.character(u@abbreviation)),
      description = or_na(as.character(u@description)),
      stringsAsFactors = FALSE
    )
  })
}

get_unitType <- function(unitType) {
  map_df(unitType, function(ut) {
    map_df(ut@dimension, function(d) {
      data.frame(
        id = or_na(as.character(ut@id)),
        name = or_na(as.character(ut@name)),
        dimension = or_na(as.character(d@name)),
        power =  or_na(as.character(d@power)),
        stringsAsFactors = FALSE
      )
    })
  })
}
