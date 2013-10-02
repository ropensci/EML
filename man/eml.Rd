\name{eml}
\alias{eml}
\title{generator for eml}
\usage{
  eml(dat, metadata, title, description = character(0),
    creator = get("defaultCreator", envir = remlConfig),
    contact = get("defaultContact", envir = remlConfig),
    coverage = eml_coverage(scientific_names = NULL, dates = NULL, geographic_description = NULL, NSEWbox = NULL),
    methods = new("methods"),
    additionalMetadata = new("additionalMetadata"))
}
\description{
  generator for eml
}

