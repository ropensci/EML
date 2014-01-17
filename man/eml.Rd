\name{eml}
\alias{eml}
\title{eml constructor function}
\usage{
eml(dat, title = "metadata", creator = get("defaultCreator", envir =
  remlConfig), contact = get("defaultContact", envir = remlConfig),
  coverage = eml_coverage(scientific_names = NULL, dates = NULL,
  geographic_description = NULL, NSEWbox = NULL), methods = new("methods"),
  ..., additionalMetadata = c(new("additionalMetadata")))
}
\arguments{
  \item{dat}{a data.set object}

  \item{title}{for the metadata.  Also used as the csv
  filename.}

  \item{creator}{a ListOfcreator object, character string,
  or person object.  Otherwise loaded from value set by
  eml_config.}

  \item{contact}{a contact object, character string, or
  person object.  Otherwise loaded from value set by
  eml_config.}

  \item{a}{coverage object, such as created by the
  eml_coverage constructor function.}

  \item{methods}{a method object.}

  \item{...}{additional slots passed to the dataset
  constructor `new("dataset", ...)`}

  \item{additionalMetadata}{an additionalMetadata object}
}
\description{
  eml constructor function
}
\details{
  - Permits character string definitions of creator &
  contact - generates a unique PackageId - Avoids more
  verbose separate call to dataset constructor and
  eml_dataTable
}

