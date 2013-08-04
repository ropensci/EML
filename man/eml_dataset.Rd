\name{eml_dataset}
\alias{eml_dataset}
\title{Function to create an EML Dataset node}
\usage{
  eml_dataset(..., .title = "Unnamed", .creator = list(),
    .contact = list(), .methods = list(),
    .coverage = list(),
    .rights = eml$get("default_rights"))
}
\arguments{
  \item{...}{arguments to \code{\link{eml_dataTable}}}

  \item{.contact}{a list of arguments to
  \code{\link{eml_contact}}}

  \item{.creator}{a list of arguments to
  \code{\link{eml_creator}}}

  \item{.methods}{a list of arguments to
  \code{\link{eml_methods}}}

  \item{.coverage}{a list of arguments to
  \code{\link{eml_coverage}}}
}
\description{
  Function to create an EML Dataset node
}
\references{
  Normative technical specification given at
  http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-dataset.html
}

