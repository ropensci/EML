\name{eml_coverage}
\alias{eml_coverage}
\title{Helper constructor for creating coverage node.
Provides convenience tools to write the more common
versions of coverage metadata.}
\usage{
  eml_coverage(scientific_names = NULL, dates = NULL,
    geographic_description = NULL, NSEWbox = NULL)
}
\arguments{
  \item{scientific_names}{a list or character string of
  scientific names of species covered by this dataset.
  Assumes names are two words long, given as "genus
  species" or "genus_species". Can alternatively provide an
  `eml::taxonomicCoverage` object.}

  \item{dates}{a length-2 character vector giving the start
  and end dates in YYYY-MM-DD (ISO8601) format, or Date
  object.  Can alternatively provide an existing
  `eml::temporalCoverage` object.}

  \item{geographic_descirption}{a plain-text description of
  the geographic location covered by this data.}

  \item{NSEWbox}{numeric vector giving the decimal degrees
  of latitude or longitude for a bounding box in the order
  North, South, East, West.  Optionally followed by a 5th
  and 6th value giving the altitude minimum and maximum in
  meters.  Can alternatively provide an existing
  `eml::geographicCoverage` object.}
}
\value{
  an S4 representation of an eml coverage node.
}
\description{
  Helper constructor for creating coverage node. Provides
  convenience tools to write the more common versions of
  coverage metadata.
}

