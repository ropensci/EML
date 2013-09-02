\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Top-level API function for writing eml}
\usage{
  eml_write(dat, metadata, title,
    description = character(0),
    creator = new("ListOfcreator", list(get("defaultCreator", envir = remlConfig))),
    contact = get("defaultContact", envir = remlConfig),
    methods = new("methods"),
    additionalMetadata = new("additionalMetadata"),
    file = "metadata.xml")
}
\description{
  Top-level API function for writing eml
}

