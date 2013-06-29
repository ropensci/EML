\name{eml_figshare}
\alias{eml_figshare}
\title{Upload EML to figshare}
\usage{
  eml_figshare(file, title = NULL, description = NULL,
    categories = NULL, tags = NULL, links = NULL,
    visibility = NULL)
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
}
\examples{
\dontrun{
   id = eml_figshare("my_eml_data.xml", description="Example EML file from reml", categories = "Ecology", tags = "EML")
}
}

