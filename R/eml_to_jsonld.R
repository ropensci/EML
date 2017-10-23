#' Convert an EML abstract into its JSON-LD equivalent
#'
#' This function is convoluted. It takes an EML abstract, converts it into a
#' DocBook XML document, uses Pandoc (via the rmarkdown package) to convert that
#' into plain text, cleans up the output, and returns a character vector of
#' length one.
#'
#' @param abstract
#'
#' @return (character) The abstract text as a single-length character vector
eml_abstract_to_jsonld <- function(abstract) {
  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop(paste("The rmarkdown package is required to convert EML abstracts",
               "into a format appropriate for Schema.org's description field"),
         call. = FALSE)
  }

  if (!inherits(abstract, "abstract")) {
    stop(call. = FALSE,
         paste0("Argument 'abstract' must be of class 'abstract' but was of ",
                "class '", class(abstract), "' instead."))
  }

  abstract_children <- xml2::xml_children(EML:::s4_to_xml(abstract))

  # Create a bare-bones DocBook XML document to put the EML abstract's children
  # into
  doctype <-
    xml2::xml_new_root(
      xml2::xml_dtd("section",
                    "-//OASIS//DTD DocBook XML V4.2//EN",
                    "http://oasis-open.org/docbook/xml/4.5/docbookx.dtd"))
  article_el <- xml2::xml_add_child(doctype, "article")

  # Because EML abstract can have multiple top-level children, and xml2::add_child
  # doesn't support adding a nodeset (i.e. multiple children at a time), we have
  # to one each top-level child at time
  lapply(abstract_children, function(node) { xml2::xml_add_child(article_el, node)})

  input_path <- tempfile()
  output_path <- tempfile()

  xml2::write_xml(doctype, input_path)

  pandoc_convert(
    input_path,
    to = "plain",
    from = "docbook",
    output = output_path,
    options = "--wrap=none" # Default is to hard-wrap at 72 char columns
  )

  # Clean up
  unlink(xml_path)
  unlink(output_path)

  # Return cleaned up version
  paste(remove_extra_empty_lines(plain_abstract), collapse = "\n")
}


#' Remove leading, duplicate interior, and trailing empty strings
#'
#' This function is a workaround for the odd behavior Pandoc exhibits when
#' converting from DocBook to plain (text) where leading, duplicate interior,
#' and trailing empty lines are included in the output.
#'
#' @param lines (character) A character vector of the lines of text to modify
#'
#' @return (character)
remove_extra_empty_lines <- function(lines) {
  total_lines <- length(lines)
  first_line <- FALSE # Whether we've iterated to the first non-zero-length line

  for (line_no in seq_along(lines)) {
    line_nchar <- nchar(lines[line_no])

    # Remove leading empty lines
    if (!first_line) {
      if (line_nchar == 0) {
        lines[line_no] <- NA
      } else {
        first_line <- TRUE
      }
    }

    # Remove the current line if the current one is blank and we're not at last
    # line end and the next line is blank too
    if (line_nchar == 0 &&
        total_lines > line_no &&
        nchar(lines[line_no + 1]) == 0) {
      lines[line_no] <- NA
    }

    # Remove the current line if it's the last one and it's blank
    if (line_no == total_lines &&
        line_nchar == 0) {
      lines[line_no] <- NA
    }
  }

  lines[which(!is.na(lines))]
}

#' Convert an EML Party to a list suitable for conversion to Schema.org JSON-LD
#'
#' This is a helper function to handle converting an EML party to a list with a
#' structure suitable for conversion to JSON-LD. The main trick is that the type
#' of an EML party is implicit based upon the presence of individualName,
#' organizationName, and positionName children elements whereas the type in
#' Schema.org JSON-LD is explicit.
#'
#' Also because Schema.org doesn't have a concept for a party that is defined
#' only by its position, this function produces a warning and returns an empty
#' list whenever the EML party is only defined by a position.
#'
#' @param party Any EML party (e.g., creator, contact, etc.)
#'
#' @return (list) A list of statements for insertion into the JSON-LD document
eml_party_to_jsonld <- function(party) {
  if (length(party@individualName) > 0) {
    type <- "Person"
  } else if (length(party@organizationName) > 0) {
    type <- "Organization"
  } else {
    warning(call. = FALSE,
            paste0("Unable to determine the type of a party (Person or Organization) so the party will not be included in the result."))
    return(list())
  }

  statements <- list("@type" = type)

  if (type == "Person") {
    statements[["givenName"]] <- lapply(party@individualName[[1]]@givenName, function(givenName) {
      givenName@.Data
    })

    statements[["familyName"]] <- lapply(party@individualName[[1]]@surName, function(surName) {
      surName@.Data
    })
  } else if (type == "Organization") {
    statements[["name"]] <- lapply(party@organizationName, function(organizationName) {
      organizationName@.Data
    })
  }

  statements
}

#' Convert an EML geographiCoverage to a list suitable for conversion to
#' Schema.org JSON-LD
#'
#' @param geographicCoverage An EML geographicCoverage object
#'
#' @return (list) A list of statements for insertion into the JSON-LD document
eml_geographicCoverage_to_Place <- function(geographicCoverage) {
  if (length(geographicCoverage@datasetGPolygon) > 0) {
    warning(call. = FALSE,
            paste0("geographicCoverages with datasetGPolygon are not supported",
                   " so only the boundingCoordates were used."))
  }

  list("@type" = "Place",
       "geo" = eml_boundingCoordinates_to_GeoShape(geographicCoverage@boundingCoordinates))
}

#' Convert an EML boundingCoordinates to a list suitable for conversion to
#' Schema.org JSON-LD#'
#' @param boundingCoordinates An EML boundingCoordinate object
#'
#' @return (list) A list of statements for insertion into the JSON-LD document
eml_boundingCoordinates_to_GeoShape <- function(boundingCoordinates) {
  if (!inherits(boundingCoordinates, "boundingCoordinates")) {
    stop(call. = FALSE,
         paste0("Argument 'boundingCoordinates' must be of class ",
                "'boundingCoordinates' but was of class '", class(boundingCoordinates),
                "' instead."))
  }

  #' The first point is the lower corner, the second point is the upper corner.
  #' Appears to be in format lat lon lat lon
  list("@type" = "GeoShape",
       "box" = paste(boundingCoordinates@southBoundingCoordinate@.Data,
                     boundingCoordinates@westBoundingCoordinate@.Data,
                     boundingCoordinates@northBoundingCoordinate@.Data,
                     boundingCoordinates@eastBoundingCoordinate@.Data))
}

#' Convert an EML temporalCoverage to a list suitable for conversion to
#' Schema.org JSON-LD
#'
#' @param temporalCoverage An EML temporalCoverage object
#'
#' @return (list) A list of statements for insertion into the JSON-LD document
eml_temporalCoverage_to_Text <- function(temporalCoverage) {
  if (!inherits(temporalCoverage, "temporalCoverage")) {
    stop(call. = FALSE,
         paste0("Argument 'temporalCoverage' must be of class ",
                "'temporalCoverage' but was of class '",
                class(temporalCoverage), "' instead."))
  }

  if (length(temporalCoverage@singleDateTime) > 1) {
    statements <- lapply(temporalCoverage@singleDateTime, eml_SingleDateTime_to_Text)
  } else {
    statements <- paste(c(eml_SingleDateTime_to_Text(temporalCoverage@rangeOfDates@beginDate),
                          eml_SingleDateTime_to_Text(temporalCoverage@rangeOfDates@endDate)),
                        collapse = "/")
  }

  statements
}

#' Convert an EML SingleDateTime to a list suitable for conversion to Schema.org
#'  JSON-LD
#'
#' @param SingleDateTime An EML SingleDateTime object
#'
#' @return (character) The datetime as a string
eml_SingleDateTime_to_Text <- function(SingleDateTime) {
  # if (!inherits(SingleDateTime, "SingleDateTime")) {
  #   stop(call. = FALSE,
  #        paste0("Argument 'SingleDateTime' must be of class ",
  #               "'SingleDateTime' but was of class '",
  #               class(SingleDateTime), "' instead."))
  # }

  if (length(SingleDateTime@alternativeTimeScale) > 0) {
    warning(call. = FALSE,
            "alternativeTimeScale is not supported so this SingleDateTime was skipped.")
    return(list())
  }

  SingleDateTime@calendarDate@.Data
}


#' Convert an EML object to a list suitable for conversion to Schema.org JSON-LD
#'
#' This function makes heavy use of streamlining assumptions about how to
#' convert from EML to Schema.org JSON-LD. In-line comments describe the nuances
#' of the conversion for each Schema.org concept.
#'
#' @param doc An EML Object to convert
#'
#' @return A JSON(-LD) string
#' @export
#'
#' @examples
#' library(EML)
#' doc <- read_eml(system.file("examples", "hf205.xml", package = "EML"))
#' eml_to_jsonld(doc)
eml_to_jsonld <- function(doc) {
  if (!inherits(doc, "eml")) {
    stop(call. = FALSE,
         paste0("Argument 'doc' must be of class ",
                "'eml' but was of class '",
                class(doc), "' instead."))
  }

  # JSON-LD Preamble
  statements <- list("@context" = "http://schema.org",
                     "@type" = "Dataset")

  # eml:title <-> schema:name
  statements[["name"]] = lapply(doc@dataset@title, function(title) {
    slot(title, ".Data")
  })

  #' eml:abstract <-> schema:description
  #'
  #' This is done in sort of a roundabout fashion: Abstracts are converted
  #' from their EML DocBook-subset form by conveting them by hand into DocBook
  #' documents, running them thorugh Pandoc (via the rmarkdown package) and
  #' converting them to 'plain' format and cleaning up the output.
  if (length(eml_get(doc, "abstract")) == 1) {
    statements[["description"]] <- eml_abstract_to_jsonld(eml_get(doc, "abstract")[[1]])
  }

  #' creator
  #' TODO: Improve how much of this mapping is covered
  statements[["creator"]] <- lapply(doc@dataset@creator, function(creator) {
    eml_party_to_jsonld(creator)
  })

  #' contact
  #' TODO: How does this map to Schema.org/Dataset?

  #'
  #' eml:keywordSet <-> schema:keywords
  #'
  #' Note: Returns the unique list of all keywords in the dataset description
  if (length(doc@dataset@keywordSet) > 0) {
    statements[["keywords"]] <- unique(unlist(lapply(doc@dataset@keywordSet, function(keywordSet) {
      lapply(keywordSet@keyword, function(keyword) {
        slot(keyword, ".Data")
      })
    })))
  }

  #' eml:geographiCoverage <-> schema:spatialCoverage
  statements[["spatialCoverage"]] <- lapply(doc@dataset@coverage@geographicCoverage, function(geographicCoverage) {
    eml_geographicCoverage_to_Place(geographicCoverage)
  })

  #' eml:temporalCoverage <-> schema:temporalCoverage
  #'
  #' Note: This is only converting to Text and not DateTime
  statements[["temporalCoverage"]] <- lapply(doc@dataset@coverage@temporalCoverage, function(temporalCoverage) {
    eml_temporalCoverage_to_Text(temporalCoverage)
  })

  # Convert the list of statements into a JSON object
  jsonlite::toJSON(statements,
                   pretty = TRUE,
                   auto_unbox = TRUE)
}
