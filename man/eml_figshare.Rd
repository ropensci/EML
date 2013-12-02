\name{eml_figshare}
\alias{eml_figshare}
\title{Upload EML to figshare}
\usage{
eml_figshare(file, title = NULL, description = NULL, categories = NULL,
  tags = NULL, links = NULL, visibility = c("draft", "private", "public"),
  figshare_id = NULL, modified_eml_filename = paste("figshare", file, sep =
  "_"))
}
\arguments{
  \item{title}{of the figshare dataset,}

  \item{description}{of the dataset,}

  \item{categories}{a category or list of categories,
  selected from the figshare list:}

  \item{tags}{at least one tag, any terms are permitted.
  Tags not required}

  \item{links}{provided in the list on links of the
  figshare page. optional.}

  \item{visibility}{one of "draft", "public", or
  "private".}

  \item{figshare_id}{If the object already has a figshare
  id and we want to modify it.}
}
\value{
  the figshare id
}
\description{
  Modifies the EML file to reflect the figshare
}
\details{
  figshare requires authentication. See rfigshare
  [tutorial]() for help on configuring this. Arguments for
  figshare are optional, if not provided reml will attempt
  to extract appropriate values from the EML.  If no values
  are found for essential metadata (title, description,
  category), then figshare object will be still be created
  as a draft but cannot be published.

  If publishing as a draft or private file, one can always
  make public later through fs_make_public or the figshare
  online interface.  However, eml_figshare can take the
  figshare_id to change any fields of an existing figshare
  object, and in doing so will also update the EML file.
}
\examples{
\dontrun{
   file <- system.file("doc", "my_eml_data.xml", package="reml")
   id <- eml_figshare(file, description="Example EML file from reml", categories = "Ecology", tags = "EML")
}
}

