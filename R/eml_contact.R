#' 
#'
eml_contact <- function(givenName = eml_settings$get("givenName"), 
                        surName = eml_settings$get("surName"), 
                        email = eml_settings$get("email")){
  newXMLNode("contact", .children = list( 
    newXMLNode("individualName", .children = list(
      newXMLNode("givenName", givenName),
      newXMLNode("surName", surName))),
    newXMLNode("electronicMailAddress", email)
    ))
}


