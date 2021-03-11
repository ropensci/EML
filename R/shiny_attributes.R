#' Create/Edit EML attributes
#'
#' @description Create/edit EML attributes, custom units, and factors in a shiny environment.
#'
#' @details Attributes can be created from scratch using \code{shiny_attributes()}.
#' Or an existing attribute table can be edited using \code{shiny_attributes(NULL, attributes)}.
#' Or new attributes can be created from a data table using \code{shiny_attributes(data, NULL)}.
#' If attributes are created from a data table, fields such as `attributeName` and `numberType` will be automatically
#' completed based on the attributes within the data table.
#' If both existing attributes and data table are entered (i.e. \code{shiny_attributes(data, attributes)}),
#' any automatically generated fields based attributes within the data table **will not** override any non-empty fields in the
#' entered attributes
#'
#' @param data (data.frame) the data.frame of data that needs an attribute table
#' @param attributes (data.frame) an existing attributes table
#' @importFrom utils write.csv
#'
#' @examples
#' \dontrun{
#' # from scratch
#' out <- shiny_attributes(NULL, NULL)
#' 
#' # from data
#' data <- iris
#' out <- shiny_attributes(data, NULL)
#' 
#' # from exisiting attributes
#' file <- system.file("tests", emld::eml_version(),
#'   "eml-datasetWithAttributelevelMethods.xml",
#'   package = "emld"
#' )
#' eml <- read_eml(file)
#' x <- eml$dataset$dataTable$attributeList
#' df <- get_attributes(x, eml)
#' out <- shiny_attributes(NULL, df$attributes)
#' 
#' # from attributes and data
#' out <- shiny_attributes(data, df$attributes)
#' }
#' @export
shiny_attributes <- function(data = NULL, attributes = NULL) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop(
      call. = FALSE,
      "shiny_attributes requires the
         'shiny' package to be installed. Install shiny package for this functionality."
    )
  }

  if (!requireNamespace("shinyjs", quietly = TRUE)) {
    stop(
      call. = FALSE,
      "shiny_attributes requires the
         'shinyjs' package to be installed. Install shinyjs package for this functionality."
    )
  }

  if (!requireNamespace("htmlwidgets", quietly = TRUE)) {
    stop(
      call. = FALSE,
      "shiny_attributes requires the
         'htmlwidgets' package to be installed. Install htmlwidgets package for this functionality."
    )
  }

  ## Set up allowed fields within attributes table
  ## TODO: allow for more fields such as minimum and maximum
  fields <- c(
    "attributeName",
    "measurementScale",
    "domain",
    "unit",
    "numberType",
    "attributeLabel",
    "attributeDefinition",
    "definition",
    "formatString",
    "missingValueCode",
    "missingValueCodeExplanation",
    "id",
    "propertyURI",
    "propertyLabel",
    "valueURI",
    "valueLabel"
  )

  ## Prepare attributes from attribute_table
  if (!is.null(attributes)) {
    if (!is(attributes, "data.frame")) {
      stop("attributes must be a data.frame")
    }

    if (length(attributes$attributeName) == 0) {
      stop("attributeName must be a non-empty field in attributes")
    }

    # Find which fields are not present and set to NA
    fields_not_in <- which(!(fields %in% colnames(attributes)))
    for (field in fields[fields_not_in]) {
      attributes[, field] <- NA
    }

    attributes <- attributes[, fields]
  }

  ## Prepare attributes from data
  if (!is.null(data)) {
    if (!is(data, "data.frame")) {
      stop("data must be a data.frame")
    }

    if (length(colnames(data)) == 0) {
      stop("column names must be populated in data")
    }

    ## Initiallize attribute table from data
    attributeName <- colnames(data)
    attributes_data <- as.data.frame(matrix(nrow = length(attributeName), ncol = length(fields)),
      stringsAsFactors = FALSE
    )
    colnames(attributes_data) <- fields
    attributes_data[, "attributeName"] <- attributeName

    ## Get numberType
    attributes_data[, "numberType"] <- unlist(lapply(data, function(x) get_numberType(x)))

    ## Check if data can be read as a  date
    is_Date <- unlist(lapply(data, function(x) {
      tryCatch({
        as.Date(x)
        TRUE
      }, error = function(e) {
        FALSE
      })
    }), use.names = FALSE)

    ## Get domain
    attributes_data[, "domain"] <- ifelse(!is.na(attributes_data$numberType),
      "numericDomain",
      ifelse(is_Date,
        "dateTimeDomain",
        NA
      )
    )

    ## Get measurementScale
    attributes_data[, "measurementScale"] <- ifelse(attributes_data$domain == "dateTimeDomain",
      "dateTime",
      NA
    )

    ## Update values from attributes if given
    for (r in seq(nrow(attributes))) {
      row <- which(attributes_data$attributeName == attributes$attributeName[r])

      if (length(row) == 1) {
        for (c in seq(ncol(attributes))) {
          col <- which(colnames(attributes_data) == colnames(attributes[c]))

          if (is.na(attributes[r, c])) {
            attributes[r, c] <- attributes_data[row, col]
          }
        }
      }
    }

    ## Bind any extra rows
    attributes <- rbind(
      attributes,
      attributes_data[!(attributes_data$attributeName %in% attributes$attributeName), ]
    )
  }

  ## If both data and attributes are NULL, initiallize a blank table
  if (is.null(attributes)) {
    attributes <- as.data.frame(matrix(nrow = 10, ncol = length(fields)),
      stringsAsFactors = FALSE
    )
    colnames(attributes) <- fields
  }

  attributes <- data.frame(apply(attributes, c(1, 2), as.character), stringsAsFactors = FALSE)
  attributes[is.na(attributes)] <- ""
  shiny::runApp(shiny::shinyApp(
    ui = attributes_ui(),
    server = attributes_server(attributes, data),
    options = list(launch.browser = TRUE)
  ))
}

#' Get EML numberType
#'
#' returns the EML numberType (either 'real', 'integer', 'whole', or 'natural') of input values
#'
#' @param values  (numeric/character) a vector of values, if vector is non-numeric will return NA
#' @return the numberType of \code{values} (either 'real', 'integer', 'whole', or 'natural').
#' @examples
#' \dontrun{
#' # To get numberType for each column in a data.frame:
#' 
#' unlist(lapply(df, function(x) get_numberType(x)))
#' }
get_numberType <- function(values) {
  # Unlist data. Use do.call to preserve date format
  if (is.list(values) == T) {
    values <- do.call("c", values)
  }

  numberType <- NA

  if (is.numeric(values)) {
    if (all(is.nan(values))) {
      # If all values are NaN
      numberType <- "real"
    } else if (any(round(values) != values, na.rm = T)) {
      # If any values are a fraction
      numberType <- "real"
    } else if (any(values < 0, na.rm = T)) {
      # if any values are less than 0
      numberType <- "integer"
    } else if (any(values == 0, na.rm = T)) {
      # if any values are == 0
      numberType <- "whole"
    } else {
      numberType <- "natural"
    }
  }

  return(numberType)
}

#' handsontable to r
#'
#' Takes a handsontable and converts to r data.frame for shiny app
#'
#' @param table input table
table_to_r <- function(table) {

  # Initiallize
  table_data <- table$data
  table_colnames <- table$colnames
  out <- do.call(rbind, lapply(table_data, rbind))

  # Change NULL to empty string in list
  out[sapply(out, is.null)] <- ""

  if (nrow(out) > 1) {
    out <- as.data.frame(apply(out, 2, unlist), stringsAsFactors = FALSE)
  } else {
    out <- unlist(out)
    out <- as.data.frame(t(out), stringsAsFactors = FALSE)
  }

  colnames(out) <- table_colnames
  # Convert empty strings to missing values
  out[sapply(out, function(f){(f == '')})] <- NA
  
  out
}

#' build units table
#'
#' builds unit table for shiny app
#'
#' @param in_units input units
#' @param eml_units eml units
build_units_table <- function(in_units, eml_units) {

  ## Get custom units
  out_units <- suppressWarnings(get_unit_id(in_units))
  out_units_eml <- eml_units[eml_units$id %in% out_units, ]
  names_units <- names(out_units)

  ## Remove escape characters
  out_units <- ifelse(grepl("\"|\'", names_units),
    gsub("\"|\'", "", in_units),
    out_units
  )

  ## Return blank units
  out_units <- ifelse(out_units == "",
    names_units,
    out_units
  )

  ## Clean
  out_units <- out_units[!is.na(out_units)]
  out_units <- out_units[out_units != ""]
  out_units <- unique(out_units)
  out_units <- out_units[!(out_units %in% out_units_eml$id)]

  ## Get Non-standard units
  non_standard_units <- lapply(out_units, function(x) {
    blank_eml_unit <- eml_units[1, ]
    blank_eml_unit[, ] <- ""
    blank_eml_unit$id <- x
    blank_eml_unit$standard <- FALSE
    blank_eml_unit
  })
  non_standard_units <- do.call(rbind, non_standard_units)
  out_units_eml <- rbind(out_units_eml, non_standard_units)

  ## null to na
  out_units_eml <- as.data.frame(apply(out_units_eml, c(1, 2), function(x) {
    if (is.null(unlist(x))) {
      x <- NA
    }
    unlist(x)
  }), stringsAsFactors = FALSE)
  return(out_units_eml)
}

#' build factor table
#'
#' builds factor table for shiny app
#'
#' @param att_table (data.frame) input attributes table
#' @param data (data.frame) input data
build_factors <- function(att_table, data) {

  ## Get attribute names of enumeratedDomains
  attributeNames <- att_table[att_table$domain == "enumeratedDomain", "attributeName"]

  if (length(attributeNames) == 0) {
    out <- data.frame(matrix(nrow = 0, ncol = 3), stringsAsFactors = F)
    colnames(out) <- c("attributeName", "code", "definition")

    ## If data is null or attribute is not in data make one blank row
  } else if (is.null(data) || !all(attributeNames %in% colnames(data))) {
    out <- data.frame(matrix(nrow = length(attributeNames), ncol = 3), stringsAsFactors = F)
    colnames(out) <- c("attributeName", "code", "definition")
    out$attributeName <- attributeNames

    ## Else, get all codes
  } else {
    en_data <- data[attributeNames]
    en_data <- lapply(seq_along(en_data), function(i) {
      attributeName <- colnames(en_data)[i]
      code <- unique(en_data[, i])
      definition <- ""
      out <- data.frame(attributeName, code, definition, stringsAsFactors = F)
      colnames(out) <- c("attributeName", "code", "definition")
      out <- out[!is.na(code), ]
      out
    })

    out <- do.call(rbind, en_data)
  }

  out
}

#' Launch attributes htmlwidget
#'
#' Used to call handsontable html widget to build attributes
#'
#' @param df (data.frame) the data.frame of data that needs an attribute table
#' @param type (character) either "attributes", "units", or "factors"
htmlwidgets_attributes <- function(df, type = NULL) {
  stopifnot(is.data.frame(df))

  ## Build handsontable columns
  columns <- lapply(colnames(df), function(col) {

    ## Initiallize options
    render_type <- "text"
    colWidths <- 150

    if (col %in% c("attributeDefinition", "definition", "description")) {
      colWidths <- 320
    }

    if (col %in% c("domain", "measurementScale", "numberType")) {
      render_type <- "dropdown"
    }

    out <- list(
      type = render_type,
      colWidths = colWidths,
      allowInvalid = TRUE # https://github.com/handsontable/handsontable/issues/4551
    )

    # Set renderers
    if (is.null(type)) {
      type <- NULL
    } else if (type == "attributes") {
      if (out$type == "dropdown") {
        out$renderer <- htmlwidgets::JS("customDropdown_att")
      } else {
        out$renderer <- htmlwidgets::JS("customText_att")
      }
    } else if (type == "units") {
      out$renderer <- htmlwidgets::JS("customText_units")
    } else if (type == "factors") {
      out$renderer <- htmlwidgets::JS("customText")
    } else {
      out$renderer <- NULL
    }

    out
  })

  ## Create widget input
  x <- list(
    data = jsonlite::toJSON(as.matrix(df), na = "null"),
    colHeaders = colnames(df),
    columns = columns,
    rType = type
  )

  ## Create the widget
  hot <- htmlwidgets::createWidget("htmlwidget_attributes_table",
    x,
    width = NULL, height = NULL, package = "EML"
  )
  hot
}

htmlwidgets_attributes_output <-
  function(outputId, width = "100%", height = "100%") {
    htmlwidgets::shinyWidgetOutput(outputId,
      "htmlwidget_attributes_table",
      width,
      height,
      package = "EML"
    )
  }

render_htmlwidgets_attributes <-
  function(expr, env = parent.frame(), quoted = FALSE) {
    if (!quoted) {
      expr <- substitute(expr)
    } # force quoted
    htmlwidgets::shinyRenderWidget(expr, htmlwidgets_attributes_output, env, quoted = TRUE)
  }
