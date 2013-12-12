person_wizard <- function(type){
  p <- new(type)
  p@individualName@givenName <- readline(paste("Given name for the", type, "\n"))
  p@individualName@surName <- readline("Surname?\n")
  if(type == "contact"){
    p@electronicMailAddress <- readline("Email address for the contact?\n (or leave blank and hit <Enter> provide a mailing address)\n")
    p@address <-  new("address", 
        deliveryPoint = readline("deilvery point (street address)?\n"),
        city = readline("city?"),
        administrativeArea = readline("State or adminstrative area?\n"),
        postalCode =  readline("zip code or postal code?\n"),
        country = readline("country?\n"))
  } else if(type == "associatedParty"){
    p@role <- readline("role of this associated party?\n")
  }
  if(type != "contact")
    p <- c(p)
  p
}
