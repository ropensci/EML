\name{eml_publish}
\alias{eml_publish}
\title{Publish EML}
\usage{
  eml_publish(file, ...,
    destination = c("figshare", "knb"))
}
\arguments{
  \item{file}{The local path of an EML file}

  \item{...}{Additional metadata options.  If publishing to
  Figshare, these correspond to the options in
  \code{fs_new_article}. See .}

  \item{destination}{the publishing destination, e.g.
  "figshare"}
}
\value{
  Uploads the dataset and file to destination specified
  returns an id
}
\description{
  Push EML and data files to an online server and update
  EML Metadata accordingly
}
\examples{
\dontrun{
   file <- system.file("doc", "my_eml_data.xml", package="reml")
   id <- eml_publish(file, description="Example EML file from reml", categories = "Ecology", tags = "EML")
}
}

