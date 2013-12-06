\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Top-level API function for writing eml}
\usage{
eml_write(dat, meta = NULL, title = "metadata",
  description = character(0), creator = get("defaultCreator", envir =
  remlConfig), contact = get("defaultContact", envir = remlConfig),
  coverage = eml_coverage(scientific_names = NULL, dates = NULL,
  geographic_description = NULL, NSEWbox = NULL), methods = new("methods"),
  additionalMetadata = new("ListOfadditionalMetadata"), file = NULL,
  eml_version = c("2.1.1", "2.1.0"))
}
\arguments{
  \item{dat}{either a data.frame, data.set, or eml object}
}
\description{
  Top-level API function for writing eml
}

