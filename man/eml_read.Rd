\name{eml_read}
\alias{eml_read}
\alias{read.eml}
\title{read eml files (.xml)}
\usage{
  eml_read(file, extract = FALSE, just_data = FALSE, ...)
}
\arguments{
  \item{file}{the name or path to the file (see ?xmlParse
  for details)}

  \item{extract}{logical. default to FALSE.  extract the
  data table when reading the data?}

  \item{just_data}{logical. default FALSE. Set to true to
  reduce memory footprint by reading in data alone without
  additional metadata. Only works if extract = TRUE}
}
\description{
  read eml files (.xml)
}

