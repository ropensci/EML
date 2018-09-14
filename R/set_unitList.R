

#' set_unitList
#'
#' Define custom units, including new unitTypes.  Note that it is not necessary to define
#' most common units.
#'
#' @param units a data.frame describing the custom units, see details.
#' @param unitTypes optional, a data.frame defining any additional unitTypes not already defined
#' @param as_metadata logical, default FALSE. If true, returns an `additionalMetadata` element, see below.
#' @return unitList list object
#'
#'
#' @export
#' @details  The units data.frame must have the following columns:
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
#' ## create the "unitType" table for custom unit
#' id <- c("speed", "speed", "acceleration", "acceleration", "frequency")
#' dimension <- c("length", "time", "length", "time", "time")
#' power <- c(NA, "-1", NA, "-2", "-1")
#' unitTypes <- data.frame(
#'   id = id, dimension = dimension,
#'   power = power, stringsAsFactors = FALSE
#' )
#' 
#' ## Create the units table
#' id <- c("minute", "centimeter")
#' unitType <- c("time", "length")
#' parentSI <- c("second", "meter")
#' multiplierToSI <- c("0.0166", "1")
#' description <- c("one minute is 60 seconds", "centimeter is a 100th of a meter")
#' units <- data.frame(
#'   id = id, unitType = unitType, parentSI = parentSI,
#'   multiplierToSI = multiplierToSI, description = description,
#'   stringsAsFactors = FALSE
#' )
#' 
#' unitList <- set_unitList(units, unitTypes)
set_unitList <-
  function(units,
             unitTypes = NULL,
             as_metadata = FALSE) {
    ## no factors please
    units[] <- lapply(units, as.character)
    unitTypes[] <- lapply(unitTypes, as.character)


    if (is.null(unitTypes)) {
      ListOfunitType <- NULL
    } else {
      if (is.null(unitTypes$name)) {
        unitTypes$name <- unitTypes$id
      }
      if (is.null(unitTypes$id)) {
        unitTypes$id <- unitTypes$name
      }


      types <- unique(unitTypes$id)
      ListOfunitType <- lapply(types, function(type) {
        dimensions <- unitTypes[(unitTypes$name == type), ]
        ListOfdimension <-
          lapply(1:dim(dimensions)[1], function(i) {
            row <- dimensions[i, ]
            list(
              name = row[["dimension"]],
              power = na2empty(row[["power"]])
            )
          })
        list(
          name = dimensions[["name"]][1],
          id = dimensions[["id"]][1],
          dimension = ListOfdimension
        )
      })
    }

    if (is.null(units$name)) {
      units$name <- units$id
    }
    if (is.null(units$id)) {
      units$id <- units$name
    }
    if (is.null(units$abbreviation)) {
      units$abbreviation <- rep(NA, length(units$name))
    }
    if (is.null(units$constantToSI)) {
      units$constantToSI <- rep(NA, length(units$name))
    }
    if (is.null(units$description)) {
      units$description <- rep(NA, length(units$name))
    }
    if (is.null(units$multiplierToSI)) {
      units$multiplierToSI <- rep(NA, length(units$name))
    }
    if (is.null(units$parentSI)) {
      units$parentSI <- rep(NA, length(units$name))
    }

    ## Coerce all columns to characters

    ListOfunit <- lapply(1:dim(units)[1], function(i) {
      row <- units[i, ]
      list(
        id = row[["id"]],
        name = row[["name"]],
        abbreviation = na2empty(row[["abbreviation"]]),
        unitType = row[["unitType"]],
        parentSI = na2empty(row[["parentSI"]]),
        multiplierToSI = na2empty(as.character(row[["multiplierToSI"]])),
        constantToSI = na2empty(as.character(row[["constantToSI"]])),
        description = na2empty(row[["description"]])
      )
    })



    out <- list()
    out$unitType <- ListOfunitType
    out$unit <- ListOfunit

    if (as_metadata) {
      list(metadata = list(unitList = out))
    } else {
      out
    }
  }
