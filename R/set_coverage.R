#' set_coverage
#'
#' @param beginDate Starting date for temporal coverage range.
#' @param endDate End date for temporal coverage range
#' @param date give a single date, or vector of single dates covered (instead of beginDate and endDate)
#' @param sci_names string (space separated) or list or data frame of scientific names for species covered.  See details
#' @param geographicDescription text string describing the geographic location
#' @param westBoundingCoordinate Decimal longitude for west edge bounding box
#' @param eastBoundingCoordinate Decimal longitude for east edge bounding box
#' @param northBoundingCoordinate Decimal latitude value for north of bounding box
#' @param southBoundingCoordinate Decimal latitude value for south edge of bounding box
#' @param altitudeMinimum minimum altitude covered by the data (optional)
#' @param altitudeMaximum maximum altitude covered by the data (optional)
#' @param altitudeUnits name of the units used to measure altitude, if given
#' @details set_coverage provides a simple and concise way to specify most common temporal,
#' taxonomic, and geographic coverage metadata. For certain studies this will not be
#' well suited, and users will need the more flexible but more verbose construction using
#' "new()" methods; for instance, to specify temporal coverage in geological epoch instead
#' of calendar dates, or to specify taxonomic coverage in terms of other ranks or identifiers.
#'
#' @return a coverage object for EML
#'
#' @note If "sci_names" is a data frame, column names of the data frame are rank names.
#' For user-defined "sci_names", users must make sure that the order of rank names
#' they specify is from high to low.
#' Ex. "Kingdom","Phylum","Class","Order","Family","Genus","Species","Common"
#'
#' @export
#'
#' @examples
#' coverage <-
#'   set_coverage(
#'     begin = "2012-06-01", end = "2013-12-31",
#'     sci_names = "Sarracenia purpurea",
#'     geographicDescription = "California coast, down through Baja, Mexico",
#'     west = -122.44, east = -117.15,
#'     north = 37.38, south = 30.00
#'   )
set_coverage <-
  function(beginDate = character(),
             endDate = character(),
             date = character(),
             sci_names = character(),
             geographicDescription = character(),
             westBoundingCoordinate = numeric(),
             eastBoundingCoordinate = numeric(),
             northBoundingCoordinate = numeric(),
             southBoundingCoordinate = numeric(),
             altitudeMinimum = numeric(),
             altitudeMaximum = numeric(),
             altitudeUnits = character()) {
    out <-
      list(
        geographicCoverage = set_geographicCoverage(
          geographicDescription,
          westBoundingCoordinate,
          eastBoundingCoordinate,
          northBoundingCoordinate,
          southBoundingCoordinate,
          altitudeMinimum,
          altitudeMaximum,
          altitudeUnits
        ),
        temporalCoverage = set_temporalCoverage(beginDate, endDate, date),
        taxonomicCoverage = set_taxonomicCoverage(sci_names)
      )
    as_emld(out)
  }




######## Geographic Coverage ####################
## Fixme just rewrite constructor?
set_geographicCoverage <-
  function(geographicDescription = character(),
             westBoundingCoordinate = numeric(),
             eastBoundingCoordinate = numeric(),
             northBoundingCoordinate = numeric(),
             southBoundingCoordinate = numeric(),
             altitudeMinimum = numeric(),
             altitudeMaximum = numeric(),
             altitudeUnits = character()) {
    ## Should permit G-Polygon definitions
    list(
      geographicDescription = geographicDescription,
      boundingCoordinates = list(
        westBoundingCoordinate = westBoundingCoordinate,
        eastBoundingCoordinate = eastBoundingCoordinate,
        northBoundingCoordinate = northBoundingCoordinate,
        southBoundingCoordinate = southBoundingCoordinate,
        boundingAltitudes = list(
          altitudeMinimum = altitudeMinimum,
          altitudeMaximum = altitudeMaximum,
          altitudeUnits = altitudeUnits
        )
      )
    )
  }




############ Temporal Coverage #################

## FIXME if given dateTime objects, should coerce appropriately to include 'time' element
set_temporalCoverage <-
  function(beginDate = character(),
             endDate = character(),
             date = character()) {
    if (length(beginDate) > 0) {
      list(
        rangeOfDates = list(
          beginDate = list(calendarDate = beginDate),
          endDate = list(calendarDate = endDate)
        )
      )
    } else if (length(date) > 0) {
      list(singleDateTime = lapply(date, function(x) list(calendarDate = x)))
    }
  }

######## Taxonomic Coverage ####################
#' set_taxonomicCoverage
#'
#' @param sci_names string (space separated) or list or data frame of scientific names for species covered.
#' @param expand Set to TRUE to use `[taxadb]` to expand sci_names into full taxonomic classifications
#' @param db The taxonomic database to query (when expand is set to \code{TRUE}). See `[taxadb::filter_name]` for valid options. Defaults to 'itis'.
#' @details Turn a data.frame or a list of scientific names into a taxonomicCoverage block
#' sci_names can be a space-separated character string or a data frame with column names as rank name
#' or a list of user-defined taxonomicClassification
#'
#' @return a taxonomicCoverage object for EML
#' @note If "sci_names" is a data frame, column names of the data frame are rank names.
#' For user-defined "sci_names", users must make sure that the order of rank names
#' they specify is from high to low.
#' Ex. "Kingdom","Phylum","Class","Order","Family","Genus","Species","Common"
#' EML permits any rank names provided they go in descending order.
#'
#' @export
#' @importFrom methods is
#' @examples
#'
#' sci_names <- data.frame(
#'   Kingdom = "Plantae",
#'   Phylum = "Phaeophyta",
#'   Class = "Phaeophyceae",
#'   Order = "Laminariales",
#'   Family = "Lessoniaceae",
#'   Genus = "Macrocystis",
#'   Species = "pyrifera"
#' )
#' taxon_coverage <- set_taxonomicCoverage(sci_names)
#'
#' \donttest{ # Examples that may take > 5s
#'
#' # Query ITIS using taxadb to fill in the full taxonomy given just species
#' #  # names
#' taxon_coverage <- set_taxonomicCoverage(
#'   c("Macrocystis pyrifera", "Homo sapiens"),
#'   expand = TRUE
#' )
#'
#' # Query GBIF instead of ITIS
#' taxon_coverage <- set_taxonomicCoverage(
#'   c("Macrocystis pyrifera"),
#'   expand = TRUE,
#'   db = "gbif"
#' )
#'
#' ## use a list of lists for multiple species
#' sci_names <- list(list(
#'   Kindom = "Plantae",
#'   Phylum = "Phaeophyta",
#'   Class = "Phaeophyceae",
#'   Order = "Laminariales",
#'   Family = "Lessoniaceae",
#'   Genus = "Macrocystis",
#'   Species = "pyrifera"
#' ))
#' set_taxonomicCoverage(sci_names)
#'
#' }
set_taxonomicCoverage <- function(sci_names, expand = FALSE, db = "itis") {
  # Expand using taxadb and ITIS if the user passes in just scientific names
  if (is.character(sci_names) && expand) {
    sci_names <- expand_scinames(sci_names, db)
  }
  if (is.character(sci_names) && !expand) {
    taxa <- lapply(strsplit(sci_names, " "), function(s) {
      list(
        taxonRankName = "Genus",
        taxonRankValue = s[[1]],
        taxonomicClassification = list(
          taxonRankName = "Species",
          taxonRankValue = s[[2]]
        )
      )
    })
    list(taxonomicClassification = taxa)
  } else if (is.data.frame(sci_names)) {
    set_taxonomicCoverage.data.frame(sci_names)
  } else if (is.list(sci_names)) {
    names(sci_names) <- NULL
    set_taxonomicCoverage.list(sci_names)
  } else {
    stop("Incorrect format: sci_names
can only be character string, data.frame or list")
  }
}



## Recursively turn named list into nested list
pop <- function(taxa) {
  if (length(taxa) > 1) {
    list(
      taxonRankName = names(taxa)[1],
      taxonRankValue = taxa[[1]],
      taxonomicClassification = pop(taxa[-1])
    )
  } else {
    list(
      taxonRankName = names(taxa)[1],
      taxonRankValue = taxa[[1]]
    )
  }
}

#' @importFrom stats setNames
set_taxonomicCoverage.data.frame <- function(sci_names) {
  ranks <- colnames(sci_names)
  values <- as.data.frame(t(sci_names), stringsAsFactors = FALSE)
  colnames(values) <- NULL

  taxa <- lapply(values, function(v) {
    pop(setNames(v, ranks))
  })
  list(taxonomicClassification = taxa)
}

set_taxonomicCoverage.list <- function(sci_names) {
  taxa <- lapply(sci_names, function(sci_name) {
    pop(sci_name)
  })
  list(taxonomicClassification = taxa)
}



expand_scinames <- function(sci_names, db){
  if (!requireNamespace("taxadb", quietly = TRUE)) {
    stop(call. = FALSE,
         "Expansion of scientific names requires the 'taxadb' package to be installed. Install taxadb or set expand to FALSE."
        )}
  df <- taxadb::filter_name(sci_names, provider = db)
  as.list(df[c("kingdom", "phylum", "class", "order", "family", "genus", "specificEpithet")])
}
