

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

## Tests
from = as.person("Carl Boettiger <cboettig@gmail.com>")
as(from, "ResponsibleParty")

as(as(from, "ResponsibleParty"), "contact")

x = as.person("Carl Boettiger <cboettig@gmail.com> [ctb]")
as(x, "associatedParty")


x = as.person("Carl David Boettiger <cboettig@gmail.com> [ctb]")
as(x, "associatedParty")
