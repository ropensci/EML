\name{eml_dataTable}
\alias{eml_dataTable}
\title{Function to create an EML Datatable}
\usage{
  eml_dataTable(dataframe, col_metadata, unit_metadata,
    accuracy = NULL, coverage = NULL, methods = NULL,
    missingValueCode = NA, csvfile = NULL,
    file_description = NULL, csv_url = "http://github.com")
}
\arguments{
  \item{col_metadata}{a named character vector of
  definitions, e.g. c("X1" = "species name", "X2" =
  "species density", ...)}

  \item{unit_metadata}{a named list of length ncol.  For
  each column, factor: a named character vector of
  definitions of each factor numeric: unit used, from EML
  list dateTime: For an R time object (POSIXt class), give
  the format character: definition (same as col def?)
  definitions of all factors, a named character vector of
  definitions, e.g.  c("X1" = "species name", "X2" =
  "species density", ...)

  The primary role of an EML Datatable is to define the
  data specified by the column headings; facilitating data
  synthesis.}
}
\description{
  Function to create an EML Datatable
}
\examples{
dat = data.frame(river=c("SAC", "SAC", "AM"),
                   spp = c("king", "king", "ccho"),
                   stg = c("smolt", "parr", "smolt"),
                   ct =  c(293L, 410L, 210L))
 col_metadata = c(river = "http://dbpedia.org/ontology/River",
                  spp = "http://dbpedia.org/ontology/Species",
                  stg = "Life history stage",
                  ct = "count")
 unit_metadata =
  list(river = c(SAC = "The Sacramento River", AM = "The American River"),
       spp = c(king = "King Salmon", ccho = "Coho Salmon"),
       stg = c(parr = "third life stage", smolt = "fourth life stage"),
       ct = "number")

 node = eml_dataTable(dat, col_metadata, unit_metadata)

We have semantic meaning available in EML for many numeric units. Any unit not provided must still be defined semantically.  But we have much more obtuse support for providing semantic meaning to character strings.
}
\references{
  Normative technical specification given at
}

