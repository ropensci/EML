\name{eml}
\alias{eml}
\title{Define constructor function}
\usage{
eml(dat, meta = NULL, title = "metadata", description = character(0),
  creator = get("defaultCreator", envir = remlConfig),
  contact = get("defaultContact", envir = remlConfig),
  coverage = eml_coverage(scientific_names = NULL, dates = NULL,
  geographic_description = NULL, NSEWbox = NULL), methods = new("methods"),
  additionalMetadata = new("ListOfadditionalMetadata",
  list(new("additionalMetadata"))), eml_version = c("2.1.1", "2.1.0"))
}
\description{
  Define constructor function
}

