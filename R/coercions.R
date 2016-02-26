## Coercions from "person" type
setOldClass("person")
setAs("person", "ResponsibleParty", function(from){
  new("ResponsibleParty",
      individualName = c(new("individualName",
                             "givenName" = as.character(from$given),
                             "surName" = as(from$family, "surName"))),
      electronicMailAddress = as.character(from$email))
})

setAs("person", "associatedParty", function(from){
  new("associatedParty",
      ResponsibleParty =  as(from, "ResponsibleParty"),
      role = new("role", from$role))
})

## Coercions to "person" type


## Coercions between R's bibtype & eml


## Coercions for G-Polygon objects (for coverage data)

