#' get_attributes
#'
#' get_attributes
#' @param attributeList an "attributeList" element from EML
#' @param eml The full eml document, needed only if <references> outside of attributes must be resolved.
#' @param join logical, default FALSE. Should the resulting data frames for each
#' attribute type (~column class, numeric, charcters, datetimes, factors) be joined
#' into a single data frame or returned in separate data frames?
#' @return a data frame whose rows are the attributes (names of each column in the data file)
#' and whose columns describe metadata about those attributes.  By default separate tables
#' are given for each type
#' @details EML metadata can use "references" elements which allow one attribute to use metadata
#' declared elsewhere in the document.  This function will automatically resolve these references
#' and thus infer the correct metadata.
#' @export
#' @examples
#' \donttest{ # runs > 5s
#'
#' eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "EML"))
#' get_attributes( eml@@dataset@@dataTable[[1]]@@attributeList )
#'
#' }
get_attributes <- function(attributeList, eml = attributeList, join = FALSE){
  A <- attributeList@attribute
  A <- unname(A) # avoid row-names 'attribute','attribute1' etc
  column_meta <- column_attributes(A)
  numerics <- numeric_attributes(A, eml)
  chars <- char_attributes(A, eml)
  datetimes <- datetime_attributes(A, eml)
  factors <- factor_attributes(A, eml)


  if(join){ # Provide factor table separately
    list(attributes = merge(merge(merge(numerics, datetimes, all = TRUE), chars, all = TRUE), column_meta, all = TRUE),
         factors = factors)
  } else {
    list(columns = column_meta, numerics = numerics,
         chars = chars, datetimes = datetimes,
         factors = factors)
  }
}

## Functions to extract metadata from EML and return tables


column_attributes <- function(ListOfattribute){
  map_df(ListOfattribute, function(a)
    ## FIXME what about accuracy? coverage? methods?  Hard to represent in table
    ## FIXME would be nice to know whether nominal/ordinals are text or enumerated domain
    data.frame(attributeName = a@attributeName,
               attributeLabel = or_na(getone(a@attributeLabel)@.Data),      # optional, can repeat (though goodness knows why)
               storageType = or_na(getone(a@storageType)@.Data),          # optional, can repeat (though goodness knows why)
               missingValueCode = or_na(getone(a@missingValueCode)@code),  # optional, can actually be multiple
               missingValueCodeExplanation = or_na(getone(a@missingValueCode)@codeExplanation),  # optional, can actually be multiple
               measurementScale = choice(a@measurementScale),
               attributeDefinition = a@attributeDefinition,
               stringsAsFactors = FALSE))
}

## Ratio/Interval maps
numeric_attributes <- function(ListOfattribute, eml){
  map_df(ListOfattribute, function(a){
    name = a@attributeName
    scale = choice(a@measurementScale)
    if(scale %in% c("ratio", "interval")){
      b <- slot(a@measurementScale, scale)

      ## Perform Reference lookup.  FIXME consider performing globally.
      if( "ReferencesGroup" %in% choice(b@numericDomain) )
        b@numericDomain <- get_reference(b@numericDomain, eml)

      ## FIXME can really have multiple bounds?
      bounds <- getone(b@numericDomain@BoundsGroup@bounds)

      data.frame(attributeName = name,
                 unit = or_na(slot(b@unit, choice(b@unit))@.Data),
                 precision = as.numeric(or_na(b@precision@.Data)),
                 numberType = or_na(b@numericDomain@numberType@.Data),
                 minimum = or_na(bounds@minimum@.Data), # leave as char for joining with datetime bounds
                 maximum = or_na(bounds@maximum@.Data),
                 domain = "numericDomain",
                 stringsAsFactors = FALSE)

    } else {
      NULL
    }
  })
}

## characters
char_attributes <- function(ListOfattribute, eml){
  map_df(ListOfattribute, function(a){
    name = a@attributeName
    scale = choice(a@measurementScale)
    if(scale %in% c("nominal", "ordinal")){
      b <- slot(a@measurementScale, scale)
      if( "ReferencesGroup" %in% choice(b@nonNumericDomain) )
        b@nonNumericDomain <- get_reference(b@nonNumericDomain, eml)
      s <- choice(b@nonNumericDomain)
      if("textDomain" %in% s){
        textDomain <- getone(b@nonNumericDomain@textDomain)  ## FIXME can this really be multiple?
        data.frame(attributeName = name,
                   definition = textDomain@definition,
                   pattern = or_na(getone(textDomain@pattern)@.Data),
                   source = or_na(textDomain@source),
                   domain = "textDomain",
                   stringsAsFactors = FALSE)
      } else if("enumeratedDomain" %in% s) {
        #       NULL
        # Just note the domain, details found in foreign-keyed table
        data.frame(attributeName = name, domain = "enumeratedDomain",
                   definition = as.character(NA), pattern = as.character(NA),
                   source = as.character(NA), stringsAsFactors = FALSE)
      }
    } else{
      NULL
    }
  })
}

## datetimes df
datetime_attributes <- function(ListOfattribute, eml){

  map_df(ListOfattribute, function(a){
    name = a@attributeName
    scale = choice(a@measurementScale)
    if(scale %in% c("dateTime")){
      b <- slot(a@measurementScale, scale)

      if( "ReferencesGroup" %in% choice(b@dateTimeDomain) )
        b@dateTimeDomain <- get_reference(b@dateTimeDomain, eml)

      bounds <- getone(get_path(b, "dateTimeDomain@BoundsDateGroup@bounds"))

      data.frame(attributeName = name,
                 formatString = b@formatString,
                 precision = as.numeric(or_na(b@dateTimePrecision)),
                 minimum = or_na(bounds@minimum@.Data), # time string, best left as character
                 maximum = or_na(bounds@maximum@.Data),
                 domain = "dateTimeDomain",
                 stringsAsFactors = FALSE)

    } else{
      NULL
    }
  })

}


factor_attributes <- function(ListOfattribute, eml){
  map_df(ListOfattribute, function(a){
    name = a@attributeName
    scale = choice(a@measurementScale)
    if(scale %in% c("nominal", "ordinal")){
      b <- slot(a@measurementScale, scale)

      if( "ReferencesGroup" %in% choice(b@nonNumericDomain) )
        b@nonNumericDomain <- get_reference(b@nonNumericDomain, eml)

      s <- choice(b@nonNumericDomain)
      if("enumeratedDomain" %in% s){
        d <- slot(b@nonNumericDomain, s)
        s <- choice(d[[1]]) # FIXME: what to do about multiple enumeratedDomain elements?
        if("codeDefinition" %in% s){
          data.frame(attributeName = name, codedef_to_df(d[[1]]@codeDefinition))
        } else if("externalCodeSet" %in% s){
          NULL
        } else if("entityCodeList" %in% s){
          NULL
        }
      }
      else {
        NULL
      }
    } else {
      NULL
    }
  })
}

codedef_to_df <- function(codeDefinition){
  map_df(unname(codeDefinition), function(x)
    data.frame(code = x@code, definition = x@definition, stringsAsFactors = FALSE)
  )
}

## use old-school way to avoid purrr or dplyr dependency
map_df <- function(x, f, ...){
  do.call(rbind, lapply(x, f, ...))
}


## like 'slot', but never NULL
get_slot <- function(object, name){
  out <- slot(object, name)
  if(is.null(out)){
    cls <- getSlots(class(object))[[name]]
    out <- new(cls)
  }
  out
}

get_path <- function(node, path){
  p <- strsplit(path, "@")[[1]]

  newpath <- paste(p[-1], collapse = "@")
  newnode <- get_slot(node, p[1])

  if(length(p[-1]) > 0)
    get_path(newnode, newpath)
  else
    newnode
}

## cannot subset farther down the tree if no element exists, so this creates a blank element.
## Consider rolling this into the prototype of all ListOf classes?
getone <- function(x){
  if(is(x, "list")){
    if(length(x) == 0){
      cls <- sub("^ListOf", "", class(x))
      x <- new(class(x), list(new(cls)))
    }
  }
  x[[1]]
}

## treat length-zero results like character() as NAs
or_na <- function(x){
  if(length(x) == 0)
    x <- as.character(NA) # avoid being a logical
  x
}

## Resolve reference nodes into copies of actual metadata nodes.  slow!
get_reference <- function(n, eml){
  id <- n@ReferencesGroup@references[[1]]
  doc = XML::xmlParse(write_eml(eml))
  node <- XML::xpathApply(doc, sprintf("//*[@id = '%s']", id))[[1]]
  emlToS4(node)
}


## identify which slot(s) (xs:choice child eleemnts) are non-empty
choice <- function(s4){
  who <- slotNames(class(s4))
  drop <- sapply(who, function(x) isEmpty(slot(s4,x)))
  who[!drop]
}




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
set_attributes <- function(attributes, factors, col_classes = NULL){

  ##  check attributes data.frame.  must declare required columns: attributeName, (attributeDescription, ....)
  if(! "attributeName" %in% names(attributes))
    stop("attributes table must include an 'attributeName' column")

  ## Factors table must be all of type character!  
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

add_na_column <- function(column, df){
  if(! column %in% names(df))
    df[[column]] <- as.character(NA)
  df
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
  standard_unit_list <- read.csv(system.file("units/standard_unit_list.csv", package = "EML"))
  !(x %in% standard_unit_list[[1]])
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

