#' set_coverage
#'
#' @param beginDate Starting date for temporal coverage range.
#' @param endDate End date for temporal coverage range
#' @param date give a single date, or vector of single dates covered (instead of beginDate and endDate)
#' @param sci_names string (space seperated) or list or data frame of scientific names for species covered.  See details
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
#'coverage <-
#'  set_coverage(begin = '2012-06-01', end = '2013-12-31',
#'               sci_names = "Sarracenia purpurea",
#'               geographicDescription = "California coast, down through Baja, Mexico",
#'               west = -122.44, east = -117.15,
#'               north = 37.38, south = 30.00)
#'

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
    new(
      "coverage",
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
    new(
      "geographicCoverage",
      geographicDescription = geographicDescription,
      boundingCoordinates = new(
        "boundingCoordinates",
        westBoundingCoordinate = as.character(westBoundingCoordinate),
        eastBoundingCoordinate = as.character(eastBoundingCoordinate),
        northBoundingCoordinate = as.character(northBoundingCoordinate),
        southBoundingCoordinate = as.character(southBoundingCoordinate),
        boundingAltitudes = new(
          "boundingAltitudes",
          altitudeMinimum = as.character(altitudeMinimum),
          altitudeMaximum = as.character(altitudeMaximum),
          altitudeUnits = altitudeUnits
        )
      )
    )
  }




############ Temporal Coverage #################

## FIXME if given dateTime objects, should coerce appropriately to include 'time' element
set_temporalCoverage <-
  function(beginDate = character(),
           endDate  = character(),
           date  = character()) {
    if (length(beginDate) > 0) {
      node <- new(
        "temporalCoverage",
        rangeOfDates =
          new(
            "rangeOfDates",
            beginDate =
              new("beginDate",
                  calendarDate = beginDate),
            endDate =
              new("endDate",
                  calendarDate = endDate)
          )
      )
    } else if (length(date) > 0) {
      node <- new("temporalCoverage",
                  singleDateTime = lapply(date, function(x)
                    new("singleDateTime", calendarDate = x)))
    }
    node
  }

######## Taxonomic Coverage ####################
#' set_taxonomicCoverage
#'
#' @param sci_names string (space seperated) or list or data frame of scientific names for species covered.
#' @details Turn a data.frame or a list of scientific names into a taxonomicCoverage block
#' sci_names can be a space-separated character string or a data frame with column names as rank name
#' or a list of user-defined taxonomicClassification
#'
#' @return a taxonomicCoverage object for EML
#' @note If "sci_names" is a data frame, column names of the data frame are rank names.
#' For user-defined "sci_names", users must make sure that the order of rank names
#' they specify is from high to low.
#' Ex. "Kingdom","Phylum","Class","Order","Family","Genus","Species","Common"
#'
#' @export
#'
#' @examples
#' taxon_coverage <-
#'  set_taxonomicCoverage(list(KINGDOM="Plantae",
#'                             PHYLUM="Phaeophyta",
#'                             CLASS="Phaeophyceae",
#'                             ORDER="Laminariales",
#'                             FAMILY="Lessoniaceae",
#'                             GENUS="Macrocystis",
#'                             genusSpecies="Macrocystis pyrifera",
#'                             commonName="MAPY"))
#'
#' df <- data.frame(KINGDOM="Plantae",
#'                  PHYLUM="Phaeophyta",
#'                  CLASS="Phaeophyceae",
#'                  ORDER="Laminariales",
#'                  FAMILY="Lessoniaceae",
#'                  GENUS="Macrocystis",
#'                  genusSpecies="Macrocystis pyrifera",
#'                  commonName="MAPY")
#' taxon_coverage <- set_taxonomicCoverage(df)
#'

set_taxonomicCoverage <- function(sci_names) {
  if (class(sci_names) == "character") {
    taxa <- lapply(sci_names, function(sci_name) {
      s <- strsplit(sci_name, " ")[[1]]
      new(
        "taxonomicClassification",
        taxonRankName = "genus",
        taxonRankValue = s[[1]],
        taxonomicClassification = c(
          new(
            "taxonomicClassification",
            taxonRankName = "species",
            taxonRankValue = s[[2]]
          )
        )
      )
    })
    new("taxonomicCoverage",
        taxonomicClassification = do.call(c, taxa))
  } else if (class(sci_names) == "data.frame") {
    taxon_classification <- colnames(sci_names)
    new <- as.data.frame(t(sci_names))
    colnames(new) <- NULL
    taxa <- lapply(new, function(sci_name) {
      tc <- lapply(taxon_classification, function(name) {
        new(
          "taxonomicClassification",
          taxonRankName = name,
          taxonRankValue = as.character(sci_name[name])
        )
      })
      tc <- formRecursiveTree(tc)[[1]]
    })
    new("taxonomicCoverage",
        taxonomicClassification = do.call(c, taxa))
  } else if (class(sci_names) == "list") {
    taxonRankNames <- as.list(names(sci_names))
    taxa <- lapply(taxonRankNames, function(name) {
      new(
        "taxonomicClassification",
        taxonRankName = as.character(name),
        taxonRankValue = as.character(sci_names[[name]])
      )
    })
    taxa <- formRecursiveTree(taxa)
    new("taxonomicCoverage",
        taxonomicClassification = do.call(c, taxa))
  } else {
    stop("Incorrect format: sci_names can only be character string, data.frame or list")
  }
}

# helper function: form a nested tree recursively
formRecursiveTree <- function(listOfelements) {
  if (length(listOfelements) == 1 ||
      length(listOfelements) == 2 && is.null(listOfelements[[2]])) {
    return(do.call(c, listOfelements[1]))
  } else if (is.null(listOfelements[[1]])) {
    formRecursiveTree(listOfelements[2:length(listOfelements)])
  } else {
    listOfelements[[1]]@taxonomicClassification <- formRecursiveTree(listOfelements[2:length(listOfelements)])
    return(do.call(c, listOfelements[1]))
  }
}
