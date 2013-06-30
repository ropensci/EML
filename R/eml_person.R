#' 
#'
eml_person <- function(person_type = "contact",
                         givenName = eml$get("contact_givenName"), 
                           surName = eml$get("contact_surName"), 
                             email = eml$get("contact_email")) {
  newXMLNode(person_type, .children = list( 
    newXMLNode("individualName", .children = list(
      newXMLNode("givenName", givenName),
      newXMLNode("surName", surName))),
    newXMLNode("electronicMailAddress", email)
  ))
}


