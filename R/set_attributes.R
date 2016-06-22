#' set_attributes
#'
#' set_attributes
#' @param attributes a joined table of all attribute metdata
#' (such as returned by \code{\link{get_attributes}}, see details)
#' @param factors a table with factor code-definition pairs; see details
#' @param col_classes optional, list of R column classes (numeric, factor, date, character)
#' will let the function infer missing 'domain' and 'measurementScale' values for attributes column.
#' Should be in same order as attributeNames in the attribute table, or be a named list.
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
set_attributes <- function(attributes, factors = NULL, col_classes = NULL){
  
  ## all as characters please (no stringsAsFactors!)
  attributes[] <- lapply(attributes, as.character)
  factors[]  <- lapply(factors, as.character)
  
  ##  check attributes data.frame.  must declare required columns: attributeName, (attributeDescription, ....)
  if(! "attributeName" %in% names(attributes))
    stop("attributes table must include an 'attributeName' column")
  
  ## Factors table must be all of type character!  
  if(!is.null(factors))
    factors <- data.frame(lapply(factors, as.character), stringsAsFactors = FALSE)
  
  ## infer "domain" & "measurementScale" given optional column classes
  if(!is.null(col_classes))
    attributes <- merge(attributes, infer_domain_scale(col_classes, attributes$attributeName), all = TRUE)
  ## Add NA columns if necessary FIXME some of these can be missing if their class isn't represented, but otherwise must be present
  for(x in c("precision", "minimum", "maximum", "unit", "numberType", "formatString", "definition",
             "pattern", "source", "attributeLabel", "storageType", "missingValueCode",
             "missingValueCodeExplanation")){
    attributes <- add_na_column(x, attributes)
  }
  
  out <- new("attributeList")
  out@attribute <- as(lapply(1:dim(attributes)[1], function(i)
    set_attribute(attributes[i,], factors = factors)), "ListOfattribute")
  out
}





set_attribute <- function(row, factors = NULL){
  s <- row[["measurementScale"]]
  
  
  if(s %in% c("ratio", "interval")){
    if(!is_standardUnit(row[["unit"]])){
      type <- "customUnit"
      warning(paste0("unit '", row[["unit"]], "' is not recognized, using custom unit. 
                     Please define a custom unit or replace with a 
                     recognized standard unit (see set_unitList() for details)"))
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
  
  if(!is.na(row[["minimum"]]))
    minimum = new("minimum", na2empty(row[["minimum"]]),
                  exclusive = new("xml_attribute", "false"))
  else 
    minimum <- new("minimum")
  
  if(!is.na(row[["maximum"]]))
    maximum = new("maximum", na2empty(row[["maximum"]]),
                  exclusive = new("xml_attribute", "false"))
  else 
    maximum <- new("maximum")
  
  
  new(cls,
      bounds = as(list(new("bounds", 
                           minimum = minimum, 
                           maximum = maximum)), 
                  "ListOfbounds"))
}



infer_domain_scale <- function(col_classes, attributeName = names(col_classes)){
  domain <- col_classes
  measurementScale <- col_classes
  storageType <- col_classes
  domain[col_classes == "numeric"] <- "numericDomain"
  domain[col_classes == "character"] <- "textDomain"
  domain[col_classes %in% c("factor", "ordered")] <- "enumeratedDomain"
  domain[col_classes %in% c("Date")] <- "dateTimeDomain"
  
  measurementScale[col_classes == "numeric"] <- "ratio" # !
  measurementScale[col_classes == "character"] <- "nominal"
  measurementScale[col_classes == "ordered"] <- "ordinal"
  measurementScale[col_classes == "factor"] <- "nominal"
  measurementScale[col_classes %in% c("Date")] <- "dateTime"
  
  ## storage type is optional, maybe better not to set this?
  storageType[col_classes == "numeric"] <- "float"
  storageType[col_classes == "character"] <- "string"
  storageType[col_classes %in% c("factor", "ordered")] <- "string"
  storageType[col_classes %in% c("Date")] <- "date"
  
  
  data.frame(attributeName = attributeName, domain = domain, measurementScale = measurementScale, storageType = storageType, stringsAsFactors = FALSE)
}


add_na_column <- function(column, df){
  if(! column %in% names(df))
    df[[column]] <- as.character(NA)
  df
}


na2empty <- function(x){
  if(!is.null(x)){ 
    if(is.na(x)){
      x <- character()
    } else if(is.numeric(x)){
      x <- as.character(x)
    }
  }
  x
}