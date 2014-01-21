\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Top-level API function for writing eml}
\usage{
eml_write(dat, file = NULL, title = "metadata",
  creator = get("defaultCreator", envir = EMLConfig),
  contact = get("defaultContact", envir = EMLConfig), ...)
}
\arguments{
  \item{dat}{either a data.frame, data.set, or eml object}
}
\description{
Top-level API function for writing eml
}

