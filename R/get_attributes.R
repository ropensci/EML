#' get_attributes
#'
#' get_attributes
#' @param x an "attributeList" element from EML
#' @param eml The full eml document, needed only if <references> outside of attributes must be resolved.
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
get_attributes <- function(x, eml = x) {
  attributeList <- x
  A <- attributeList@attribute
  A <- unname(A) # avoid row-names 'attribute','attribute1' etc

  attr_order <- vapply(A, function(a)
    a@attributeName, character(1))


  column_meta <- column_attributes(A)
  numerics <- numeric_attributes(A, eml)
  chars <- char_attributes(A, eml)
  datetimes <- datetime_attributes(A, eml)
  factors <- factor_attributes(A, eml)

  attr_table <-
    merge(merge(merge(numerics, datetimes, all = TRUE), chars, all = TRUE), column_meta, all = TRUE)

  # restore original order of attributes
  row.names(attr_table) <- attr_table$attributeName
  attr_table <- attr_table[attr_order, ]
  row.names(attr_table) <- NULL

  list(attributes = attr_table, factors = factors)

}


## Functions to extract metadata from EML and return tables


column_attributes <- function(ListOfattribute) {
  map_df(ListOfattribute, function(a)
    ## FIXME what about accuracy? coverage? methods?  Hard to represent in table
    ## FIXME would be nice to know whether nominal/ordinals are text or enumerated domain
    data.frame(
      attributeName = a@attributeName,
      attributeLabel = or_na(getone(a@attributeLabel)@.Data),
      # optional, can repeat (though goodness knows why)
      storageType = or_na(getone(a@storageType)@.Data),
      # optional, can repeat (though goodness knows why)
      missingValueCode = or_na(getone(a@missingValueCode)@code),
      # optional, can actually be multiple
      missingValueCodeExplanation = or_na(getone(a@missingValueCode)@codeExplanation),
      # optional, can actually be multiple
      measurementScale = choice(a@measurementScale),
      attributeDefinition = a@attributeDefinition,
      stringsAsFactors = FALSE
    ))
}

## Ratio/Interval maps
numeric_attributes <- function(ListOfattribute, eml) {
  map_df(ListOfattribute, function(a) {
    name <- a@attributeName
    scale <- choice(a@measurementScale)
    if (scale %in% c("ratio", "interval")) {
      b <- slot(a@measurementScale, scale)

      ## Perform Reference lookup.  FIXME consider performing globally.
      if ("references" %in% choice(b@numericDomain))
        b@numericDomain <- get_reference(b@numericDomain, eml)

      ## FIXME can really have multiple bounds?
      bounds <- getone(b@numericDomain@BoundsGroup@bounds)

      data.frame(
        attributeName = name,
        unit = or_na(slot(b@unit, choice(b@unit))@.Data),
        precision = as.numeric(or_na(b@precision@.Data)),
        numberType = or_na(b@numericDomain@numberType@.Data),
        minimum = or_na(bounds@minimum@.Data),
        # leave as char for joining with datetime bounds
        maximum = or_na(bounds@maximum@.Data),
        domain = "numericDomain",
        stringsAsFactors = FALSE
      )

    } else {
      NULL
    }
  })
}

## characters
char_attributes <- function(ListOfattribute, eml) {
  map_df(ListOfattribute, function(a) {
    name <- a@attributeName
    scale <- choice(a@measurementScale)
    if (scale %in% c("nominal", "ordinal")) {
      b <- slot(a@measurementScale, scale)
      if ("references" %in% choice(b@nonNumericDomain))
        b@nonNumericDomain <- get_reference(b@nonNumericDomain, eml)
      s <- choice(b@nonNumericDomain)
      if ("textDomain" %in% s) {
        textDomain <-
          getone(b@nonNumericDomain@textDomain)  ## FIXME can this really be multiple?
        data.frame(
          attributeName = name,
          definition = textDomain@definition,
          pattern = or_na(getone(textDomain@pattern)@.Data),
          source = or_na(textDomain@source),
          domain = "textDomain",
          stringsAsFactors = FALSE
        )
      } else if ("enumeratedDomain" %in% s) {
        #       NULL
        # Just note the domain, details found in foreign-keyed table
        data.frame(
          attributeName = name,
          domain = "enumeratedDomain",
          definition = as.character(NA),
          pattern = as.character(NA),
          source = as.character(NA),
          stringsAsFactors = FALSE
        )
      }
    } else{
      NULL
    }
  })
}

## datetimes df
datetime_attributes <- function(ListOfattribute, eml) {
  map_df(ListOfattribute, function(a) {
    name <- a@attributeName
    scale <- choice(a@measurementScale)
    if (scale %in% c("dateTime")) {
      b <- slot(a@measurementScale, scale)

      if ("references" %in% choice(b@dateTimeDomain))
        b@dateTimeDomain <- get_reference(b@dateTimeDomain, eml)

      bounds <-
        getone(get_path(b, "dateTimeDomain@BoundsDateGroup@bounds"))

      data.frame(
        attributeName = name,
        formatString = b@formatString,
        precision = as.numeric(or_na(b@dateTimePrecision)),
        minimum = or_na(bounds@minimum@.Data),
        # time string, best left as character
        maximum = or_na(bounds@maximum@.Data),
        domain = "dateTimeDomain",
        stringsAsFactors = FALSE
      )

    } else{
      NULL
    }
  })

}


factor_attributes <- function(ListOfattribute, eml) {
  map_df(ListOfattribute, function(a) {
    name <- eml_get(a, "attributeName")
    scale <- choice(a@measurementScale)
    if (scale %in% c("nominal", "ordinal")) {
      b <- slot(a@measurementScale, scale)

      if ("references" %in% choice(b@nonNumericDomain))
        b@nonNumericDomain <- get_reference(b@nonNumericDomain, eml)

      s <- choice(b@nonNumericDomain)
      if ("enumeratedDomain" %in% s) {
        d <- slot(b@nonNumericDomain, s)
        s <-
          choice(d[[1]]) # FIXME: what to do about multiple enumeratedDomain elements?
        if ("codeDefinition" %in% s) {
          code_df <-  codedef_to_df(d[[1]]@codeDefinition)
          data.frame(attributeName = rep(name, dim(code_df)[1]), code_df)
        } else if ("externalCodeSet" %in% s) {
          NULL
        } else if ("entityCodeList" %in% s) {
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

codedef_to_df <- function(codeDefinition) {
  map_df(unname(codeDefinition), function(x)
    data.frame(
      code = x@code,
      definition = x@definition,
      stringsAsFactors = FALSE
    ))
}

## use old-school way to avoid purrr or dplyr dependency
map_df <- function(x, f, ...) {
  do.call(rbind, unname(lapply(x, f, ...)))
}


## like 'slot', but never NULL
get_slot <- function(object, name) {
  out <- slot(object, name)
  if (is.null(out)) {
    cls <- getSlots(class(object))[[name]]
    out <- new(cls)
  }
  out
}

get_path <- function(node, path) {
  p <- strsplit(path, "@")[[1]]

  newpath <- paste(p[-1], collapse = "@")
  newnode <- get_slot(node, p[1])

  if (length(p[-1]) > 0)
    get_path(newnode, newpath)
  else
    newnode
}

## cannot subset farther down the tree if no element exists, so this creates a blank element.
## Consider rolling this into the prototype of all ListOf classes?
getone <- function(x) {
  if (is(x, "list")) {
    if (length(x) == 0) {
      cls <- sub("^ListOf", "", class(x))
      x <- new(class(x), list(new(cls)))
    }
  }
  x[[1]]
}

## treat length-zero results like character() as NAs
or_na <- function(x) {
  if (length(x) == 0)
    x <- as.character(NA) # avoid being a logical
  x
}

## Resolve reference nodes into copies of actual metadata nodes.  slow!
get_reference <- function(n, eml) {
  id <- n@references[[1]]
  doc <- XML::xmlParse(write_eml(eml))
  node <- XML::xpathApply(doc, sprintf("//*[@id = '%s']", id))[[1]]
  emlToS4(node)
}


## identify which slot(s) (xs:choice child eleemnts) are non-empty
choice <- function(s4) {
  who <- slotNames(class(s4))
  drop <- sapply(who, function(x)
    isEmpty(slot(s4, x)))
  who[!drop]
}
