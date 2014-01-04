\name{eml}
\alias{eml}
\title{eml constructor function}
\usage{
eml(dat, meta = NULL, title = "metadata", description = character(0),
  creator = get("defaultCreator", envir = remlConfig),
  contact = get("defaultContact", envir = remlConfig),
  coverage = eml_coverage(scientific_names = NULL, dates = NULL,
  geographic_description = NULL, NSEWbox = NULL), methods = new("methods"),
  ..., additionalMetadata = c(new("additionalMetadata")))
}
\description{
  eml constructor function
}
\details{
  - Permits character string definitions of creator &
  contact - Avoid separate call to eml_dataTable, just pass
  it dat, optionally meta too
}

