#' Convert a name to the matching EML element
#' 
#' Convert an R 'person' object (or string formatted in the R 'person' style) to the appropriate EML element
#' @param x an R person object or character string containing an individual's name.  See examples.  
#' @param ... additional person objects or names of individuals.  
#' @return the return type depends on the argument given, see details.  
#'  The default return type is a ListOfcreator, as used in resourceGroup for authorship, etc.  
#' @details 
#'  The presence of a single name along with an email address triggers creaton of a contact node. 
#'  The presence of a role triggers the creation of an associatedParty, unless the role is cre (creator), which 
#'  triggers the creation of a creator node.  As all party types except contact permit multiple parties, the return
#'  object is automatically promoted to a `ListOf` the corresponding class, which can be handed directly into any
#'  slot of that name.   
#' 
#' This function is for convenience only.  Any EML responsibleParty-Type element can always be most reliably and more 
#' completely constructed using the S4 constructor function for hte class.  
#' @examples 
#' 
#' cre <- eml_person("Aaron Ellison", "Nicholas Gotelli")               # Creates 'ListOfcreator' (names, no role) 
#' res <- eml_person("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]")  # creates a 'ListOfassociatedParty' (roles != cre)
#' con <- eml_person("Aaron Ellison <fake@email.com>")                  #  Creates 'contact' (Single name, email present)
#' 
#' # Doesn't matter if we give the multiple names in a character vector instead of separate arguments: 
#' res <- eml_person(c("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]")) #ListOfassociatedParty 
#'
#' @export  
eml_person <- function(x, ...){
  x <- as.person(list(x, ...))
  if(length(x) == 1 && !is.null(x$email)){
      output <- as(x, "contact")
  } else {
    output <- lapply(x, function(p){
      if(!is.null(p$role)){
        if(p$role == "cre")
          as(p, "creator")
        else 
          as(p, "associatedParty")
      } else 
        as(p, "creator")
    })
    ## promote to the appropriate ListOf
    output <- new(paste0("ListOf", class(output[[1]])), output)
  }
  output
}

