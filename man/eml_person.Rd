\name{eml_person}
\alias{eml_person}
\title{FIXME: we should be able to pass a string, like 'Carl Boettiger' and have it coerced
into as.person and then as.eml_person}
\usage{
  eml_person(person_type = "contact",
    givenName = eml$get("contact_givenName"),
    surName = eml$get("contact_surName"),
    email = eml$get("contact_email"))
}
\description{
  FIXME: we should be able to pass a string, like 'Carl
  Boettiger' and have it coerced into as.person and then
  as.eml_person
}

