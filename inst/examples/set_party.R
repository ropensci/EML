
setOldClass("person")
setAs("person", "ResponsibleParty", function(from){
  if(length(from) == 1){
    new("ResponsibleParty",
        individualName = new("individualName",
                             "givenName" = as.character(from$given),
                             "surName" = as.character(from$family)),
        electronicMailAddress = as.character(from$email))
  } else if(length(from) > 1){
    new("ListOfresponsibleParty", lapply(from, as, "responsibleParty"))
  } else if(length(from) < 1){
    new("responsibleParty")
  }

})
