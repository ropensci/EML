\name{eml}
\alias{eml}
\title{eml constructor function}
\usage{
eml(dat = NULL, title = "metadata", creator = NULL, contact = NULL,
  coverage = eml_coverage(scientific_names = NULL, dates = NULL,
  geographic_description = NULL, NSEWbox = NULL), methods = new("methods"),
  custom_units = NULL, ...,
  additionalMetadata = new("ListOfadditionalMetadata"), citation = NULL,
  software = NULL, protocol = NULL)
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

  \item{coverage}{a coverage object, such as created by the
  eml_coverage constructor function. (optional)}

  \item{citation}{a citation object (optional, an EML file
  can have either a dataset OR citation OR software OR
  protocol as its top-level object)}

  \item{software}{a software object (optional)}

  \item{protocol}{a protocol object (optional)}

  \item{methods}{a method object or plain text string,
  documenting additional methods}

  \item{custom_units}{a list of custom units. Leave as NULL
  and these will be automatically detected from the
  EMLConfig after a user declares any custom units using
  \link{\code{create_custom_unit}}.  Advanced users can
  alternatively just give a list of custom_unit definitions
  here.  See \link{\code{create_custom_unit}} for details.}

  \item{...}{additional slots passed to the dataset
  constructor `new("dataset", ...)`}

  \item{additionalMetadata}{an additionalMetadata object}
}
\description{
eml constructor function
}
\details{
- Permits character string definitions of creator & contact
- generates a unique PackageId - Avoids more verbose
separate call to dataset constructor and eml_dataTable
}

