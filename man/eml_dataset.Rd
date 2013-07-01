\name{eml_dataset}
\alias{eml_dataset}
\title{Function to create an EML Dataset node}
\usage{
  eml_dataset(..., .title = "Unnamed", .creator = list(),
    .contact = list())
}
\arguments{
  \item{...}{arguments to \code{\link{eml_dataTable}}}

  \item{.contact}{a list of argumens to
  \code{\link{eml_contact}}}
}
\description{
  Function to create an EML Dataset node
}
\references{
  Normative technical specification given at
  http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-dataset.html
}

