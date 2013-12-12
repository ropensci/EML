person_wizard <- function(type){
  p <- new(type)
  p@individualName@givenName <- readline(paste("Given name for the", type))
  p@individualName@surName <- readline("Surname?")
  if(type == "contact"){
    p@electronicMailAddress <- readline("Email address for thecontact? (or leave blank and hit <Enter> provide a mailing address)")
    p@address <-  new("address", 
        deliveryPoint = readline("deilvery point (street address)?"),
        city = readline("city?"),
        administrativeArea = readline("State or adminstrative area?"),
        postalCode =  readline("zip code or postal code?"),
        country = readline("country?"))
  } else if(type == "associatedParty"){
    p@role <- readline("role of this associated party?")
  }
  if(type != "contact")
    p <- c(p)
  p
}
