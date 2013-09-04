\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Top-level API function for writing eml}
\usage{
  eml_write(dat, metadata = NULL, title,
    description = character(0),
    creator = new("ListOfcreator", list(get("defaultCreator", envir = remlConfig))),
    contact = get("defaultContact", envir = remlConfig),
    coverage = eml_coverage(scientific_names = NULL, dates = NULL, geographic_description = NULL, NSEWbox = NULL),
    methods = new("methods"),
    additionalMetadata = new("additionalMetadata"),
    file = paste0(gsub(" ", "_", title), ".xml"))
}
\description{
  Top-level API function for writing eml
}

