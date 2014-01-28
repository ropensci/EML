\name{eml_person}
\alias{eml_person}
\title{Convert a name to the matching EML element}
\usage{
eml_person(x, ...)
}
\arguments{
  \item{x}{an R person object or character string
  containing an individual's name.  See examples.}

  \item{...}{additional person objects or names of
  individuals.}
}
\value{
the return type depends on the argument given, see details.
The default return type is a ListOfcreator, as used in
resourceGroup for authorship, etc.
}
\description{
Convert an R 'person' object (or string formatted in the R
'person' style) to the appropriate EML element
}
\details{
The presence of a single name along with an email address
triggers creaton of a contact node.  The presence of a role
triggers the creation of an associatedParty, unless the
role is cre (creator), which triggers the creation of a
creator node.  As all party types except contact permit
multiple parties, the return object is automatically
promoted to a `ListOf` the corresponding class, which can
be handed directly into any slot of that name.

This function is for convenience only.  Any EML
responsibleParty-Type element can always be most reliably
and more completely constructed using the S4 constructor
function for hte class.
}
\examples{
cre <- eml_person("Aaron Ellison", "Nicholas Gotelli")               # Creates 'ListOfcreator' (names, no role)
res <- eml_person("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]")  # creates a 'ListOfassociatedParty' (roles != cre)
con <- eml_person("Aaron Ellison <fake@email.com>")                  #  Creates 'contact' (Single name, email present)
# Doesn't matter if we give the multiple names in a character vector instead of separate arguments:
res <- eml_person(c("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]")) #ListOfassociatedParty
}

