\name{eml}
\alias{eml}
\title{generator for eml}
\usage{
  eml(dat, metadata, title, description = character(0),
    creator = new("ListOfcreator", list(as(default_person(), "creator"))),
    contact = as(default_person(), "contact"),
    methods = new("methods"),
    additionalMetadata = new("additionalMetadata"))
}
\description{
  generator for eml
}

