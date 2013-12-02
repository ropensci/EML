\name{eml_yaml}
\alias{eml_yaml}
\title{Convert EML into a YAML file}
\usage{
eml_yaml(file, con = stdout(), .parseopts = list(), .yamlopts = list())
}
\arguments{
  \item{file}{the path to the EML file to be converted}

  \item{con}{optional file name to write out to (see
  \code{\link{writeLines}}.  otherwise returned to
  terminal.}

  \item{.parseopts}{optional additional arguments to
  \code{\link{xmlParse}}}

  \item{.yamlopts}{optional additional arguments to
  \code{\link{as.yaml}}}
}
\value{
  A YAML representation of the metadata in the EML file,
  either to the terminal or externally.
}
\description{
  Provides a reasonably readable plain-text summary of
  metadata by converting XML to YAML
}
\examples{
file <- system.file("doc", "my_eml_data.xml", package="reml")
eml_yaml(file)
# we can pass additional optional arguments too, e.g.
eml_yaml(file, .yamlopts = list(indent=4))
}

