#' 
#' FIXME: we should be able to pass a string, like 'Carl Boettiger' and have it coerced 
#' into as.person and then as.eml_person
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


#' Coercion method from R person class to eml person 
#' @param x an R person object
#' @returns a eml_person node
as.eml_person <- function(x, person_type="contact"){
 eml_person(person_type = person_type, givenName = x$given, surName = x$family, email = x$email)
}
