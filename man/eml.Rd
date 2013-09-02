\name{eml}
\alias{eml}
\title{generator for eml}
\usage{
  eml(dat, metadata, title, description = character(0),
    creator = new("ListOfcreator", list(get("defaultCreator", envir = remlConfig))),
    contact = get("defaultContact", envir = remlConfig),
    methods = new("methods"),
    additionalMetadata = new("additionalMetadata"))
}
\description{
  generator for eml
}

