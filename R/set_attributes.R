#' set_attributes
#'
#' set_attributes
#' @param attributes a joined table of all attribute metadata
#' @param factors a table with factor code-definition pairs; see details
#' @param col_classes optional, list of R column classes ('ordered', 'numeric', 'factor', 'Date', or 'character', case sensitive)
#' will let the function infer missing 'domain' and 'measurementScale' values for attributes column.
#' Should be in same order as attributeNames in the attributes table, or be a named list with names corresponding to attributeNames
#' in the attributes table.
#' @param missingValues optional, a table with missing value code-deinition pairs; see details
#' @details The attributes data frame must use only the recognized column
#' headers shown here.  The attributes data frame must contain columns for required metadata.
#' These are:
#'
#' \strong{For all data:}
#' 
#' \itemize{
#'   \item attributeName (required, free text field)
#' 
#'   \item attributeDefinition (required, free text field)
#' 
#'   \item measurementScale (required, "nominal", "ordinal", "ratio", "interval", or "dateTime",
#'  case sensitive) but it can be inferred from col_classes.
#'  
#'   \item domain (required, "numericDomain", "textDomain", "enumeratedDomain", or "dateTimeDomain",
#'  case sensitive) but it can be inferred from col_classes.
#' }
#' 
#' \strong{For numeric (ratio or interval) data:}
#' \itemize{
#'   \item unit (required). Unitless values should use "dimensionless" as the unit.
#' }
#' 
#' \strong{For character (textDomain) data:}
#' \itemize{
#'   \item definition (required)
#' }
#' 
#' \strong{For dateTime data:}
#' \itemize{
#'   \item formatString (required)
#' }
#' 
#' Other optional allowed columns in the attributes table are:
#' source, pattern, precision, numberType, missingValueCode, missingValueCodeExplanation,
#' attributeLabel, storageType, minimum, maximum
#'
#' The \strong{factors} data frame, required for attributes in an enumerated domain, must use only the
#'  following recognized column headers:
#' \itemize{
#'   \item attributeName (required)
#'   \item code (required)
#'   \item definition (required)
#' }
#' 
#' The \strong{missingValues} data frame, optional, can be used in the case that multiple missing value codes
#' need to be set for the same attribute. This table must contain the following recognized column
#' headers.
#' \itemize{
#'   \item attributeName (required)
#'   \item code (required)
#'   \item definition (required)
#' }
#' 
#' @return an eml "attributeList" object
#' @export
set_attributes <-
  function(attributes,
             factors = NULL,
             col_classes = NULL,
             missingValues = NULL) {
    ## convert factors to data.frame because it could be a tibble
    ## or tbl_df
    factors <- as.data.frame(factors)
    missingValues <- as.data.frame(missingValues)

    ## all as characters please (no stringsAsFactors!)
    attributes[] <- lapply(attributes, as.character)
    factors[] <- lapply(factors, as.character)
    missingValues[] <- lapply(missingValues, as.character)
    ##  check attributes data.frame.
    ## must declare required columns: attributeName, attributeDescription
    ## infer "domain" & "measurementScale" given optional column classes

    attributes <-
      check_and_complete_attributes(attributes, col_classes)

    # check factors
    if (nrow(factors) != 0) {
      check_codeDefinitions(factors, type = "factors")
    }
    
    # check missingValues
    if (nrow(missingValues) != 0) {
      check_codeDefinitions(missingValues, type = "missingValues")
    }

    ## Add NA columns if necessary FIXME some of these can
    ## be missing if their class isn't represented, but otherwise
    ## must be present
    for (x in c(
      "precision",
      "minimum",
      "maximum",
      "unit",
      "numberType",
      "formatString",
      "definition",
      "pattern",
      "source",
      "attributeLabel",
      "storageType",
      "missingValueCode",
      "missingValueCodeExplanation"
    )) {
      attributes <- add_na_column(x, attributes)
    }

    out <- list()
    out$attribute <-
      lapply(1:dim(attributes)[1], function(i)
        set_attribute(attributes[i, ], factors = factors, missingValues = missingValues))

    as_emld(out)
  }





set_attribute <- function(row, factors = NULL, missingValues = NULL) {
  s <- row[["measurementScale"]]


  if (s %in% c("ratio", "interval")) {
    if (!is_standardUnit(row[["unit"]])) {
      type <- "customUnit"
      warning(
          "Unit '",
          row[["unit"]],
          "' is not a recognized standard unit; treating as custom unit. ",
          "Please be sure you also define a custom unit in your EML record, ",
          "or replace with a recognized standard unit. ",
          if(is.na(row[["unit"]])){
            'For unitless values, use "dimensionless" as the unit. '
          } ,
          "See set_unitList() for details."
      )
    } else {
      type <- "standardUnit"
    }

    u <- setNames(list(list()), type)
    u[[type]] <- row[["unit"]]
    node <- list(
      unit = u,
      precision = row[["precision"]],
      numericDomain = list(
        numberType = row[["numberType"]],
        bounds = set_BoundsGroup(row)
      )
    )
  }

  if (s %in% c("ordinal", "nominal")) {
    node <- list(nonNumericDomain = list())
    if (row[["domain"]] == "textDomain") {
      n <- list(
        definition = row[["definition"]],
        source = row[["source"]],
        pattern = row[["pattern"]]
      )
      node$nonNumericDomain$textDomain <- n
    } else if (row[["domain"]] == "enumeratedDomain") {
      node$nonNumericDomain$enumeratedDomain <-
        set_codeDefinitions(row, code_set = factors, type = "factors")
    }
  }
  
  


  if (s %in% c("dateTime")) {
    if (is.na(row[["formatString"]])) {
      warning(paste0(
        "The required formatString is missing for attribute ",
        row[["attributeName"]]
      ))
    }
    node <- list(
      formatString = row[["formatString"]],
      dateTimePrecision = row[["precision"]],
      dateTimeDomain = list(bounds = set_BoundsGroup(row))
    )
  }

  measurementScale <- setNames(list(list()), s)
  measurementScale[[s]] <- node
  missingValueCode <- NULL
  if (!is.na(row[["missingValueCode"]]) & !(row[["attributeName"]] %in% unique(missingValues$attributeName))) {
    missingValueCode <-
      list(
        code = na2empty(row[["missingValueCode"]]),
        codeExplanation = na2empty(row[["missingValueCodeExplanation"]])
      )
  }
  else if (is.na(row[["missingValueCode"]]) & row[["attributeName"]] %in% unique(missingValues$attributeName)){
    missingValueCode <- set_codeDefinitions(row, code_set = missingValues, type = "missingValues")
  }
  
  else if (!is.na(row[["missingValueCode"]]) & row[["attributeName"]] %in% unique(missingValues$attributeName)){
    warning(
      paste0("The attribute '",
        row[["attributeName"]],
        "' has missing value codes set in both the 'attributes' and 'missingValues' data.frames.
        Using codes from 'missingValues' data.frame."
      )
    )
    missingValueCode <- set_codeDefinitions(row, code_set = missingValues, type = "missingValues")
  }
  
  list(
    attributeName = row[["attributeName"]],
    attributeDefinition = row[["attributeDefinition"]],
    attributeLabel = row[["attributeLabel"]],
    storageType = row[["storageType"]],
    missingValueCode = missingValueCode,
    measurementScale = measurementScale
  )
}

set_codeDefinitions <- function(row, code_set, type) {
  name <- row[["attributeName"]]
  df <- code_set[code_set$attributeName == name, ]
  if (type == "factors"){
    ListOfcodeDefinition <- lapply(1:dim(df)[1], function(i) {
      list(
        code = df[i, "code"],
        definition = df[i, "definition"]
      )
    })
    list(codeDefinition = ListOfcodeDefinition)
  }
  else if (type == "missingValues"){
    if (nrow(df) > 0){
      ListOfcodeDefinition <- lapply(1:dim(df)[1], function(i) {
        list(
          code = df[i, "code"],
          codeExplanation = df[i, "definition"]
        )
      })
     }
   }
}

set_BoundsGroup <- function(row) {
  if (!is.na(row[["minimum"]])) {
    minimum <- list(na2empty(row[["minimum"]]),
      "exclusive" = "false"
    )
  } else {
    minimum <- NULL
  }

  if (!is.na(row[["maximum"]])) {
    maximum <- list(na2empty(row[["maximum"]]),
      "exclusive" = "false"
    )
  } else {
    maximum <- NULL
  }


  list(minimum = minimum, maximum = maximum)
}



infer_domain_scale <-
  function(col_classes,
             attributeName = names(col_classes),
             attributes) {
    if (length(col_classes) != nrow(attributes)) {
      if (is.null(names(col_classes))) {
        stop(
          call. = FALSE,
          "If col_classes is not NULL, it must have
 as many elements as there are rows in attributes unless they are named."
        )
      }
    }
    if (!is.null(names(col_classes))) {
      if (!(all(names(col_classes) %in% attributeName))) {
        stop(
          call. = FALSE,
          "If col_classes is a named list, it should have names
 corresponding to attributeName."
        )
      }
    }

    if (!(all(
      col_classes[!is.na(col_classes)] %in%
        c("numeric", "character", "factor", "Date", "ordered")
    ))) {
      stop(
        call. = FALSE,
        "All non missing col_classes values have to
        be 'ordered', 'numeric', 'character', 'factor' or 'Date'."
      )
    }
    domain <- col_classes
    measurementScale <- col_classes
    storageType <- col_classes
    domain[col_classes == "numeric"] <- "numericDomain"
    domain[col_classes == "character"] <- "textDomain"
    domain[col_classes %in% c("factor", "ordered")] <-
      "enumeratedDomain"
    domain[col_classes %in% c("Date")] <- "dateTimeDomain"
    # compare domain with domain given in attributes if there is one
    if ("domain" %in% names(attributes)) {
      if (!is.null(names(col_classes))) {
        if (any(domain !=
          attributes$domain[
            attributes$attributeName == names(col_classes)
          ])) {
          whichNot <-
            names(col_classes)[which(domain !=
              attributes$domain[
                attributes$attributeName ==
                  names(col_classes)
              ])]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the domain value inferred from col_classes
              does not agree with the domain value existing
              in attributes. Check col_classes and the domain
              column you provided.\n"
            )
          )
        }
      } else {
        if (any(domain != attributes$domain)) {
          whichNot <-
            attributes$attributeName[which(domain != attributes$domain)]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the domain value inferred from col_classes
                  does not agree with the domain value existing
                in attributes. Check col_classes and the domain column
                you provided.\n"
            )
          )
        }
      }
    }

    # Map "numeric" cols to "ratio" by default
    measurementScale[col_classes == "numeric"] <- "ratio"

    # But trust the user if they specify "interval"
    if ("measurementScale" %in% names(attributes)) {
      measurementScale[
        col_classes == "numeric" &
          attributes$measurementScale == "interval"] <- "interval"
    }

    measurementScale[col_classes == "character"] <- "nominal"
    measurementScale[col_classes == "ordered"] <- "ordinal"
    measurementScale[col_classes == "factor"] <- "nominal"
    measurementScale[col_classes %in% c("Date")] <- "dateTime"

    # compare measurementScale with measurementScale
    # given in attributes if there is one
    if ("measurementScale" %in% names(attributes)) {
      if (!is.null(names(col_classes))) {
        if (any(measurementScale !=
          attributes$measurementScale[
            attributes$attributeName ==
              names(col_classes)
          ])) {
          whichNot <-
            names(col_classes)[
              which(measurementScale !=
                attributes$measurementScale[
                  attributes$attributeName ==
                    names(col_classes)
                ])
            ]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the measurementScale value
              inferred from col_classes does not
              agree with the measurementScale value
              existing in attributes. Check col_classes
              and the measurementScale column you provided.\n"
            )
          )
        }
      } else {
        if (any(measurementScale != attributes$measurementScale)) {
          whichNot <-
            attributes$attributeName[
              which(measurementScale != attributes$measurementScale)
            ]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the measurementScale value inferred from col_classes
              does not agree with the measurementScale value existing
              in attributes. Check col_classes and the measurementScale
              column you provided.\n"
            )
          )
        }
      }
    }


    ## storage type is optional, maybe better not to set this?
    storageType[col_classes == "numeric"] <- "float"
    storageType[col_classes == "character"] <- "string"
    storageType[col_classes %in% c("factor", "ordered")] <- "string"
    storageType[col_classes %in% c("Date")] <- "date"

    # compare storageType with storageType given in attributes if there is one
    if ("storageType" %in% names(attributes)) {
      if (!is.null(names(col_classes))) {
        if (any(storageType != attributes$storageType[
          attributes$attributeName == names(col_classes)
        ])) {
          whichNot <-
            names(col_classes)[
              which(storageType != attributes$storageType[
                attributes$attributeName == names(col_classes)
              ])
            ]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the storageType value inferred from col_classes
              does not agree with the storageType value existing in attributes.
              Check col_classes and the storageType column you provided.\n"
            )
          )
        }
      } else {
        if (any(storageType != attributes$storageType)) {
          whichNot <-
            attributes$attributeName[
              which(storageType != attributes$storageType)
            ]
          stop(
            call. = FALSE,
            paste0(
              "For the attribute ",
              whichNot,
              " the storageType value inferred from col_classes
                does not agree with the storageType value existing
                in attributes. Check col_classes and the storageType
                column you provided.\n"
            )
          )
        }
      }
    }


    data.frame(
      attributeName = attributeName,
      domain = domain,
      measurementScale = measurementScale,
      storageType = storageType,
      stringsAsFactors = FALSE
    )
  }


add_na_column <- function(column, df) {
  if (!column %in% names(df)) {
    df[[column]] <- as.character(NA)
  }
  df
}


na2empty <- function(x) {
  if (!is.null(x)) {
    if (is.na(x)) {
      x <- character()
    } else if (is.numeric(x)) {
      x <- as.character(x)
    }
  }
  x
}

check_and_complete_attributes <- function(attributes, col_classes) {
  if (!"attributeName" %in% names(attributes)) {
    stop(
      call. = FALSE,
      "attributes table must include an 'attributeName' column"
    )
  } else {
    if (any(is.na(attributes$attributeName))) {
      stop(
        call. = FALSE,
        "The attributeName column must be filled for each attribute."
      )
    }
  }
  attribute_names <- c("source",
                       "pattern",
                       "measurementScale",
                       "unit",
                       "precision",
                       "numberType",
                       "domain",
                       "definition",
                       "formatString",
                       "missingValueCode",
                       "missingValueCodeExplanation",
                       "attributeName",
                       "attributeDefinition",
                       "attributeLabel",
                       "storageType",
                       "minimum",
                       "maximum")
  
  if (any(!names(attributes) %in% attribute_names)) {
    
    stop(
      call. = FALSE,
      paste0("The column names '", 
             paste(names(attributes)[which(!(names(attributes) %in% attribute_names))], collapse = ", "),
             "' in the attributes table are not recognized.")
    )
    
  }

  ## infer "domain" & "measurementScale" given optional column classes
  if (!is.null(col_classes)) {
    attributes <-
      merge(
        attributes,
        infer_domain_scale(
          col_classes, attributes$attributeName,
          attributes
        ),
        all = TRUE,
        sort = FALSE
      )
  }

  if (!"attributeDefinition" %in% names(attributes)) {
    stop(
      call. = FALSE,
      "attributes table must include an 'attributeDefinition' column"
    )
  } else {
    if (any(is.na(attributes$attributeDefinition))) {
      stop(
        call. = FALSE,
        "The attributeDefinition column must be filled for each attribute."
      )
    }
  }


  if (!"measurementScale" %in% names(attributes)) {
    stop(
      call. = FALSE,
      "attributes table must include an 'measurementScale'
      column, or you need to input 'col_classes'."
    )
  } else {
    if (any(is.na(attributes$measurementScale))) {
      stop(
        call. = FALSE,
        "The measurementScale column must be filled for each attribute."
      )
    } else {
      if (!(all(
        attributes$measurementScale %in% c(
          "nominal", "ordinal", "ratio",
          "interval", "dateTime"
        )
      ))) {
        stop(
          call. = FALSE,
          "measurementScale permitted values are 'nominal',
          'ordinal', 'ratio', 'interval', 'dateTime'."
        )
      }
    }
  }


  if (!"domain" %in% names(attributes)) {
    stop(
      call. = FALSE,
      "attributes table must include an 'domain' column,
      or you need to input 'col_classes'."
    )
  } else {
    if (any(is.na(attributes$domain))) {
      stop(
        call. = FALSE,
        "The domain column must be filled for each attribute."
      )
    } else {
      if (!(all(
        attributes$domain %in% c(
          "numericDomain",
          "textDomain",
          "enumeratedDomain",
          "dateTimeDomain"
        )
      ))) {
        stop(
          call. = FALSE,
          "domain permitted values are 'numericDomain', 'textDomain',
          'enumeratedDomain', 'dateTimeDomain'."
        )
      }
    }
  }

  # Check that measurementScale and domain values make valid combinations
  if ("measurementScale" %in% names(attributes) &&
    "domain" %in% names(attributes)) {
    for (i in seq_len(nrow(attributes))) {
      mscale <- attributes[i, "measurementScale"]
      domain <- attributes[i, "domain"]

      if (mscale %in% c("nominal", "ordinal") &&
        !(domain %in% c("enumeratedDomain", "textDomain"))) {
        stop(
          call. = FALSE,
          paste0(
            "The attribute in row ",
            i,
            " has an invalid combination of measurementScale (",
            mscale,
            ") and domain (",
            domain,
            "). For a measurementScale of '",
            mscale,
            "', domain must be either 'enumeratedDomain' or 'textDomain'."
          )
        )
      } else if (mscale %in% c("interval", "ratio") &&
        domain != "numericDomain") {
        stop(
          call. = FALSE,
          paste0(
            "The attribute in row ",
            i,
            " has an invalid combination of measurementScale (",
            mscale,
            ") and domain (",
            domain,
            "). For a measurementScale of '",
            mscale,
            "', domain must be 'numericDomain'."
          )
        )
      } else if (mscale == "dateTime" &&
        !is.null(domain) && domain != "dateTimeDomain") {
        stop(
          call. = FALSE,
          paste0(
            "The attribute in row ",
            i,
            " has an invalid combination of measurementScale (",
            mscale,
            ") and domain (",
            domain,
            "). For a measurementScale of '",
            mscale,
            "', domain must be 'dateTimeDomain'."
          )
        )
      }
    }
  }

  return(attributes)
}

# number of codes by attributeName in factors
count_levels <- function(attributeName, factors) {
  factors <- factors[factors$attributeName == attributeName, ]
  length(unique(factors$code))
}

# number of lines by attributeName in factors
count_lines <- function(attributeName, factors) {
  factors <- factors[factors$attributeName == attributeName, ]
  nrow(factors)
}

# check the names of factors
# check that for each attributeName codes are unique
check_codeDefinitions <- function(code_set, type) {
  if (!all(c("attributeName", "code", "definition") %in% names(code_set))) {
    stop(
      paste0("The ", type, " data.frame should have
      variables called attributeName, code and definition."
      ),
      call. = FALSE
    )
  }

  lines_no <- vapply(unique(code_set$attributeName),
    count_lines,
    factors = code_set, 1
  )
  levels_no <- vapply(unique(code_set$attributeName),
    count_levels,
    factors = code_set, 1
  )

  forcheck <- data.frame(
    lines_no = lines_no,
    levels_no = levels_no,
    attributeName = unique(code_set$attributeName)
  )
  notequal <- forcheck[forcheck$lines_no != forcheck$levels_no, ]
  if (nrow(notequal) != 0) {
    stop(
      paste(paste0("There are attributeName(s) in ", type, " with duplicate codes:"
      ),
        notequal$attributeName
      ),
      call. = FALSE
    )
  }
}


#' is_standardUnit
#'
#' @param x name of unit to check
#'
#' @return TRUE if unit is exact match to the id of
#'  a unit in the Standard Units Table, FALSE otherwise.
#' @export
#'
#' @examples
#' is_standardUnit("amperePerMeter") # TRUE
#' is_standardUnit("speciesPerSquareMeter") # FALSE
is_standardUnit <- function(x) {
  ## standard_unit_list <- read.csv(
  ##  system.file("units/standard_unit_list.csv", package = "EML"))
  standard_unit_list <- standardUnits$units$id
  (x %in% standard_unit_list)
}

