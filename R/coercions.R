## Internal function for initialize methods
## Promote contents in a ListOf<cls> slot.
c_as <- function(x, cls){
  if(is(x, cls))
    c(x)
  else if(is(x, paste0('ListOf', cls)))
    x
  else if(length(x) > 0)
    do.call(c, lapply(x, as, cls))
  else
    new(paste0('ListOf', cls))
}




## Coercions from "person" type
setOldClass("person")
setAs("person", "ResponsibleParty", function(from){
  new("ResponsibleParty",
      individualName = c(new("individualName",
                             "givenName" = as.character(from$given),
                             "surName" = as(as.character(from$family), "surName"))),
      electronicMailAddress = as.character(from$email))
})

setAs("person", "associatedParty", function(from){
  new("associatedParty",
      ResponsibleParty =  as(from, "ResponsibleParty"),
      role = new("role", from$role))
})

setAs("person", "creator", function(from){
  as(as(from, "ResponsibleParty"), "creator")
})

## Coercions to "person" type

setAs("ListOfcreator", "person", function(from){
  do.call(c, lapply(from, function(x) as(as(x, "ResponsibleParty"), "person")))
})

setAs("ResponsibleParty", "person", function(from){
  do.call(c, lapply(from@individualName, function(x)
  person(given = unlist(x@givenName),
         family = x@surName)))
})

## Coercions between R's bibtype & eml


## Coercions for G-Polygon objects (for coverage data)

