\name{eml_dataTable}
\alias{eml_dataTable}
\title{Function to create an EML DataTable}
\usage{
  eml_dataTable(dataframe, col_metadata, unit_metadata,
    accuracy = NULL, coverage = NULL, methods = NULL,
    missingValueCode = NA, csvfilename = NULL,
    file_description = NULL)
}
\arguments{
  \item{col_metadata}{a named character vector of
  definitions, e.g. c("X1" = "species name", "X2" =
  "species density", ...)}

  \item{unit_metadata}{a named list of length ncol defining
  the cell values. arguments will vary by object class; see
  details.}
}
\description{
  Function to create an EML DataTable
}
\details{
  unit_metadata list items will depend on the class, as
  shown in the examples. For instance: \item factor: a
  named character vector of definitions of each factor
  \item numeric: unit used, from EML list \item dateTime:
  For an R time object (POSIXt class), give the format
  \item character: definition (same as col def?)
  definitions: of all factors, a named character vector of
  definitions, e.g.  c("X1" = "species name", "X2" =
  "species density", ...)

  Semantics:

  The primary role of an EML Datatable is to define the
  data specified by the column headings; facilitating data
  synthesis. We have semantic meaning available in EML for
  many numeric units. Any unit not provided must still be
  defined semantically.  But we have much more obtuse
  support for providing semantic meaning to character
  strings.
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
}
\references{
  Normative technical specification given at:
}

