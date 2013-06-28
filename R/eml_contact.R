#' 
#'
eml_contact <- function(contact_givenName = eml$get("contact_givenName"), 
                        contact_surName = eml$get("contact_surName"), 
                        contact_email = eml$get("contact_email")){
  newXMLNode("contact", .children = list( 
    newXMLNode("individualName", .children = list(
      newXMLNode("givenName", contact_givenName),
      newXMLNode("surName", contact_surName))),
    newXMLNode("electronicMailAddress", contact_email)))
}


