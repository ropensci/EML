## use old-school way to avoid purrr or dplyr dependency
map_df <- function(x, f, ...){
  do.call(rbind, lapply(x, f, ...))
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
    x <- NA
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



## Functions to extract metadata from EML and return tables


attributes <- function(ListOfattribute){
map_df(ListOfattribute, function(a)
  data.frame(name = a@attributeName,
             label = or_na(getone(a@attributeLabel)@.Data),      # optional, can repeat (though goodness knows why)
             type = or_na(getone(a@storageType)@.Data),          # optional, can repeat (though goodness knows why)
             missing = or_na(getone(a@missingValueCode)@.Data),  # optional, can actually be multiple
             scale = choice(a@measurementScale),
             def = a@attributeDefinition,
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

      data.frame(name = name,
                 unit = or_na(slot(b@unit, choice(b@unit))@.Data),
                 precision = as.numeric(or_na(b@precision@.Data)),
                 type = or_na(b@numericDomain@numberType@.Data),
                 lower_bound = or_na(bounds@minimum@.Data), # leave as char for joining with datetime bounds
                 upper_bound = or_na(bounds@maximum@.Data),
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
        data.frame(name = name,
                   definition = textDomain@definition,
                   pattern = or_na(textDomain@pattern),
                   source = or_na(textDomain@source),
                   stringsAsFactors = FALSE)
      } else if("enumeratedDomain" %in% s) {
        NULL
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

      bounds <- getone(b@dateTimeDomain@BoundsDateGroup@bounds)

      data.frame(name = name,
                 formatString = b@formatString,
                 precision = as.numeric(b@dateTimePrecision),
                 lower_bound = or_na(bounds@minimum@.Data), # time string, best left as character
                 upper_bound = or_na(bounds@maximum@.Data),
                 stringsAsFactors = FALSE)

    } else{
      NULL
    }
  })

}


## FIXME implement this one
factor_attributes <- function(A, eml) NULL


#' get_attributes
#'
#' get_attributes
#' @param attributeList an "attributeList" element from EML
#' @param eml The full eml document, needed only if <references> outside of attributes must be resolved.
#' @param join logical, default FALSE. Should the resulting data frames for each
#' attribute type (~column class, numeric, charcters, datetimes, factors) be joined
#' into a single data frame or returned in separate data frames?
#' @param compact logical, default FALSE. Should any columns with only missing metadata be dropped?
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
#' eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "eml2"))
#' get_attributes( eml@@dataset@@dataTable[[1]]@@attributeList )
#'
#' }
get_attributes <- function(attributeList, eml = attributeList, join = FALSE, compact = FALSE){
  A <- attributeList@attribute
  columns <- attributes(A)
  numerics <- numeric_attributes(A, eml)
  chars <- char_attributes(A, eml)
  datetimes <- datetime_attributes(A, eml)
  factors <- factor_attributes(A, eml)

  ## FIXME Consider compacting each data.frame to drop any columns of all NAs (optional)
  if(join){
    merge(merge(merge(columns, units, all = TRUE), chars, all = TRUE), datetimes, all = TRUE)
  } else {
    list(columns = columns, numerics = numerics, chars = chars, datetimes = datetimes)
  }
}

## FIXME  need factor_attributes method!
## method needs more tests against more EML!
## consider testing against any xsd/test files with attributeList elements?

# eml <- read_eml(system.file("xsd/test/eml-datasetWithAttributelevelMethods.xml", package = "eml2"))
# A = eml@dataset@dataTable[[1]]@attributeList
# get_attributes(A)


