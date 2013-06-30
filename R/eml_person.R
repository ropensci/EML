#' 
#'
eml_person <- function(givenName = eml$get("contact_givenName"), 
                        surName = eml$get("contact_surName"), 
                        email = eml$get("contact_email")) {
    newXMLNode("individualName", .children = list(
      newXMLNode("givenName", givenName),
      newXMLNode("surName", surName)),
    newXMLNode("electronicMailAddress", email))
}


