#' 
#'
eml_contact <- function(givenName = eml$get("givenName"), 
                        surName = eml$get("surName"), 
                        email = eml$get("email")){
  newXMLNode("contact", .children = list( 
    newXMLNode("individualName", .children = list(
      newXMLNode("givenName", givenName),
      newXMLNode("surName", surName))),
    newXMLNode("electronicMailAddress", email)
    ))
}


