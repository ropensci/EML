

#' set_unitList
#'
#' Define custom units, including new unitTypes.  Note that it is not necessary to define
#' most common units, see get_unitList to display standard units or parse other custom unitList files.
#'
#' @param units a data.frame describing the custom units, see details.
#' @param unitTypes optional, a data.frame defining any additional unitTypes not already defined
#' @param as_metadata logical, default FALSE. If true, returns an `additionalMetadata` element, see below.
#' @return
#'
#' By default the function returns an S4 unitList object, like other set_ methods. If as_metadata is set to TRUE,
#' function returns an `additionalMetadata` element, which can be added directly to an eml object (see examples),
#' which is the usual location for declaring additional units.
#'
#' Note that EML permits a metadata element to contain arbitrary XML, including but
#' not limited to unitList XML for custom units (which is really part of the stmml unit vocabulary used by EML, but
#' part of a more general standard.) This means that once converted to a metadata element, the unit list is coerced
#' into stmml XML and can no longer be subset or modified in the same way.
#'
#' @export
#' @details
#'
#' The units data.frame must have the following columns:
#'  - id: the referenced name of unit (singular). e.g. 'meter', 'second'
#'  - unitType: the base type of unit, e.g. 'length'.  If not from a standard type, a new unitType must be provided
#'  - multiplierToSI: the multiplicative constant to convert to the SI unit.
#'  - parentSI: the name of the parent SI unit, e.g. second.
#'  - description: a text string describing the unit of measure.

#'  The following columns are optional:
#'  - name: usually the same as the id of the unit, e.g. second
#'  - abbreviation: common abbreviation, e.g. s
#'  - constantToSI: an additive constant to convert to the equivalent SI unit. If not given, default is "0"
#'
#' In practice, researchers may save these tables of custom units they frequently use in an external .csv
#' or other format and read them in to R for ready re-use.
#'
#' The unitType table must have the following columns:
#'  - id: the name by which the unitType is referred to.
#'  - name: optional, default is same as the id
#'  - dimension: name of a base dimension of the unit
#'  - power: the power to which the dimension is raised (NA implies power of 1)
#'
#' @examples
#'
#'  ## create the "unitType" table for custom unit
#'  id = c("speed", "speed", "acceleration", "acceleration", "frequency")
#'  dimension = c("length", "time", "length", "time", "time")
#'  power = c(NA, "-1", NA, "-2", "-1")
#'  unitTypes <- data.frame(id = id, dimension = dimension,
#'                          power = power, stringsAsFactors = FALSE)
#'
#'  ## Create the units table
#'  id = c("minute", "centimeter")
#'  unitType = c("time", "length")
#'  parentSI = c("second", "meter")
#'  multiplierToSI = c("0.0166", "1")
#'  description = c("one minute is 60 seconds", "centimeter is a 100th of a meter")
#'  units = data.frame(id = id, unitType = unitType, parentSI = parentSI,
#'                     multiplierToSI = multiplierToSI, description = description,
#'                     stringsAsFactors = FALSE)
#'
#'  unitList <- set_unitList(units, unitTypes)
#'
#'  ## reverse operation also works:
#'  get_unitList(unitList)
#'
#'  ## To add this to an EML document:
#'  new("eml", additionalMetadata = as(unitList, "additionalMetadata"))
#'
#'  ## Equivalently:
#'  additionalMetadata <- set_unitList(units, unitTypes, as_metadata = TRUE)
#'  new("eml", additionalMetadata = additionalMetadata)

set_unitList <-
  function(units,
           unitTypes = NULL,
           as_metadata = FALSE) {
    ## no factors please
    units[] <- lapply(units, as.character)
    unitTypes[] <- lapply(unitTypes, as.character)


    if (is.null(unitTypes)) {
      ListOfunitType <- new("ListOfunitType")
    } else {
      if (is.null(unitTypes$name))
        unitTypes$name <- unitTypes$id
      if (is.null(unitTypes$id))
        unitTypes$id <- unitTypes$name


      types <- unique(unitTypes$id)
      ListOfunitType <- as(lapply(types, function(type) {
        dimensions <- unitTypes[(unitTypes$name == type),]
        ListOfdimension <-
          as(lapply(1:dim(dimensions)[1], function(i) {
            row <- dimensions[i, ]
            new("dimension",
                name = row[["dimension"]],
                power = na2empty(row[["power"]]))
          }), "ListOfdimension")

        new(
          "unitType",
          name = dimensions[["name"]][1],
          id = dimensions[["id"]][1],
          dimension = ListOfdimension
        )
      }), "ListOfunitType")


    }

    if (is.null(units$name))
      units$name <- units$id
    if (is.null(units$id))
      units$id <- units$name
    if (is.null(units$abbreviation))
      units$abbreviation <- rep(NA, length(units$name))
    if (is.null(units$constantToSI))
      units$constantToSI <- rep(NA, length(units$name))
    if (is.null(units$description))
      units$description <- rep(NA, length(units$name))
    if (is.null(units$multiplierToSI))
      units$multiplierToSI <- rep(NA, length(units$name))
    if (is.null(units$parentSI))
      units$parentSI <- rep(NA, length(units$name))

    ## Coerce all columns to characters

    ListOfunit <- as(lapply(1:dim(units)[1], function(i) {
      row <- units[i, ]
      new(
        "unit",
        id = row[["id"]],
        name = row[["name"]],
        abbreviation = na2empty(row[["abbreviation"]]),
        unitType = row[["unitType"]],
        parentSI = na2empty(row[["parentSI"]]),
        multiplierToSI = na2empty(as.character(row[["multiplierToSI"]])),
        constantToSI = na2empty(as.character(row[["constantToSI"]])),
        description = na2empty(row[["description"]])
      )
    }), "ListOfunit")



    out <- new("unitList")
    out@unitType <- ListOfunitType
    out@unit <- ListOfunit

    if (as_metadata) {
      xml_meta <- S4Toeml(out)
      setXMLNamespace(xml_meta,
                      c(stmml =  "http://www.xml-cml.org/schema/stmml_1.1"))
      new("additionalMetadata", metadata = new("metadata", list(xml_meta)))
    } else{
      out
    }
  }



setAs("unitList", "additionalMetadata", function(from) {
  xml_meta <- S4Toeml(from)
  setXMLNamespace(xml_meta,
                  c(stmml =  "http://www.xml-cml.org/schema/stmml_1.1"))
  new("additionalMetadata", metadata = new("metadata", list(xml_meta)))
})
