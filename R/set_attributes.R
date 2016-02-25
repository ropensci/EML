

#' set_attributes
#'
#' set_attributes
#' @param attributes a joined table of all attribute metdata
#' (such as returned by \code{\link{get_attributes}}, see details)
#' @param factors a table with factor code-definition pairs; see details
#' @details The attributes data frame must use only the recognized column
#' headers shown here.  The attributes data frame must contain columns for required metadata.
#' These are:
#'
#' For all data:
#' - attributeName (required)
#' - attributeDefinition (required)
#' - measurementScale (requred)
#' - domain (required)
#'
#' For numeric (ratio or interval) data:
#' - unit (required)
#'
#' For character (textDomain) data:
#' - definition (required)
#'
#' For dateTime data:
#' - formatString (required)
#'
#' For factor data:
#'
#' @return an eml "attributeList" object
#' @export
set_attributes <- function(attributes, factors){

  ##  check attributes data.frame.  must declare required columns: attributeName
  ## consider inferring "domain" & "measurementScale" given optional column classes?
  ## Add NA columns if necessary?
  ## coerce all scolumns to character values!

  out <- new("attributeList")
  out@attribute <- as(lapply(1:dim(attributes)[1], function(i)
    set_attribute(attributes[i,], factors = factors)), "ListOfattribute")
  out
}

na2empty <- function(x){
  if(!is.null(x))
    if(is.na(x))
      x <- character()
  x
}

set_attribute <- function(row, factors){
  s <- row[["measurementScale"]]


  if(s %in% c("ratio", "interval")){
    if(is_customUnit(row[["unit"]])){
      type <- "customUnit"
    } else {
      type <- "standardUnit"
    }
    u <- new("unit")
    slot(u, type) <- new(type, row[["unit"]])
    node <- new(s,
                unit = u,
                precision = new("precision", na2empty(row[["precision"]])),
                numericDomain = new("numericDomain",
                                    numberType = new("numberType", row[["numberType"]]),
                                    BoundsGroup = set_BoundsGroup(row))
                )
  }

  if(s %in% c("ordinal", "nominal")){
    node <- new(s, nonNumericDomain = new("nonNumericDomain"))
    if(row[["domain"]] == "textDomain"){
      n <- new("ListOftextDomain",
               list(new("textDomain",
                        definition = na2empty(row[["definition"]]),
                        source = na2empty(row[["source"]]),
                        pattern = list(new("pattern", na2empty(row[["pattern"]]))))))
      node@nonNumericDomain@textDomain <- n
    } else if(row[["domain"]] == "enumeratedDomain"){
      node@nonNumericDomain@enumeratedDomain <- set_enumeratedDomain(row, factors)

    }
  }


  if(s %in% c("dateTime")){
    node <- new("dateTime",
                formatString = na2empty(row[["formatString"]]),
                dateTimePrecision = na2empty(row[["precision"]]),
                dateTimeDomain = new("dateTimeDomain",
                                     BoundsDateGroup = set_BoundsGroup(row, "BoundsDateGroup")))
  }

  measurementScale = new("measurementScale")
  slot(measurementScale, s) <- node

  new("attribute",
      attributeName = row[["attributeName"]],
      attributeDefinition = row[["attributeDefinition"]],
      attributeLabel = na2empty(row[["attributeLabel"]]),
      storageType = na2empty(row[["storageType"]]),
      missingValueCode = list(new("missingValueCode",
                             code = na2empty(row[["missingValueCode"]]),
                             codeExplanation = na2empty(row[["missingValueCodeExplanation"]]))),
      measurementScale = measurementScale
  )
}

set_enumeratedDomain <- function(row, factors){

  name <- row[["attributeName"]]
  df <- factors[factors$attributeName == name, ]

  ListOfcodeDefinition <- as(lapply(1:dim(df)[1], function(i){
    new("codeDefinition", code = df[i,"code"], definition = df[i, "definition"])
  }), "ListOfcodeDefinition")

  new("ListOfenumeratedDomain",
       list(new("enumeratedDomain",
                codeDefinition = ListOfcodeDefinition)))

}

set_BoundsGroup <- function(row, cls = "BoundsGroup"){
  new(cls,
      bounds = as(list(new("bounds",
               minimum = new("minimum", na2empty(row[["minimum"]]),
                             exclusive = new("xml_attribute", "false")),
               maximum = new("maximum", na2empty(row[["maximum"]]),
                             exclusive = new("xml_attribute", "false")))), "ListOfbounds"))
}

is_customUnit <- function(x){
  standard_unit_list <- read.csv(system.file("units/standard_unit_list.csv", package = "eml2"))
  !(x %in% standard_unit_list[[1]])
}
