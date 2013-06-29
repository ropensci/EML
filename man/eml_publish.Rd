\name{eml_publish}
\alias{eml_publish}
\title{Publish EML}
\usage{
  eml_publish(file, ...,
    destination = c("figshare", "github"))
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
   id = eml_publish("my_eml_data.xml", description="Example EML file from reml", categories = "Ecology", tags = "EML")
}
}

