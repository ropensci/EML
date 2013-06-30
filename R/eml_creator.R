#' 
#'
eml_creator <- function(givenName = eml$get("contact_givenName"), 
                        surName = eml$get("contact_surName"), 
                        email = eml$get("contact_email")) {
  newXMLNode("creator", .children = list( 
	do.call(eml_person, list(givenName=givenName, surName=surName, email=email))
  ))
}


