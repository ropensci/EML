setAs("character", "eml_person", function(from)
  as(as.person(from), "eml_person"))


setAs("eml_person", "person", function(from)
  person(from@individualName@givenName,
         from@individualName@surName,
         email = from@electronicMail)
)

setMethod("print", "eml_person", function(x)
  as(x, "person"))

setAs("person", "eml_person", function(from)
  new("eml_person", 
      individualName = new("individualName", 
                           "givenName" = from$given,
                           "surName" = from$family),
      electronicMail = from$email)
)
