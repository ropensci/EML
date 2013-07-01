\name{eml_write}
\alias{eml_write}
\alias{write.eml}
\title{Write R objects into an EML file}
\usage{
  eml_write(..., file = "eml_data.xml")
}
\description{
  Generates an EML file corresponding to the data provided.
}
\examples{
eml$set(givenName = "Carl", surName = "Boettiger", email = "cboettig@gmail.com")
 dat = data.frame(river=c("SAC", "SAC", "AM"),
                   spp = c("king", "king", "ccho"),
                   stg = c("smolt", "parr", "smolt"),
                   ct =  c(293L, 410L, 210L))
 col_metadata = c(river = "http://dbpedia.org/ontology/River",
                  spp = "http://dbpedia.org/ontology/Species",
                  stg = "Life history stage",
                  ct = "count")
 unit_metadata =
  list(river = c(SAC = "The Sacramento River", AM = "The American River"),
       spp = c(king = "King Salmon", ccho = "Coho Salmon"),
       stg = c(parr = "third life stage", smolt = "fourth life stage"),
       ct = "number")

 node = eml_write(dat, col_metadata, unit_metadata)
}

