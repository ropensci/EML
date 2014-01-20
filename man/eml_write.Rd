\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Top-level API function for writing eml}
\usage{
eml_write(dat, file = NULL, title = "metadata",
  creator = get("defaultCreator", envir = remlConfig),
  contact = get("defaultContact", envir = remlConfig))
}
\arguments{
  \item{dat}{either a data.frame, data.set, or eml object}
}
\description{
  Top-level API function for writing eml
}

