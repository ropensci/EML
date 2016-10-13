## Internal function for initialize methods
## Promote contents in a ListOf<cls> slot.
c_as <- function(x, cls) {
  if (is(x, cls))
    c(x)
  else if (is(x, paste0('ListOf', cls)))
    x
  else if (length(x) > 0)
    do.call(c, lapply(x, as, cls))
  else
    new(paste0('ListOf', cls))
}




## Coercions from "person" type
setOldClass("person")

from_a_person <- function(to) {
  if (to %in% c("associatedParty", "personnel"))
    
    
    function(from) {
      if (is.null(from$role)) {
        warning(paste0("Person ", as.character(from), " was not given any role."),
                call. = FALSE)
      }
      new(
        to,
        individualName = new(
          "individualName",
          "givenName" = as.character(from$given),
          "surName" = as(as.character(from$family), "surName")
        ),
        electronicMailAddress = as.character(from$email),
        role = as.character(from$role)
      )
    }
  
  else
    
    function(from) {
      if (is.null(from$role)) {
        warning(paste0("Person ", as.character(from), " was not given any role."),
                call. = FALSE)
      }
      new(
        to,
        individualName = new(
          "individualName",
          "givenName" = as.character(from$given),
          "surName" = as(as.character(from$family), "surName")
        ),
        electronicMailAddress = as.character(from$email)
      )
    }
  
  
}

from_person <- function(to) {
  function(from) {
    if (length(from) > 1) {
      do.call(c, lapply(from, from_a_person(to)))
    } else {
      from_a_person(to)(from)
    }
  }
}

setAs("person",
      "ResponsibleParty",
      from_person("ResponsibleParty"))
setAs("person", "associatedParty", from_person("associatedParty"))
setAs("person", "personnel", from_person("personnel"))
setAs("person", "creator", from_person("creator"))
setAs("person", "contact", from_a_person("contact"))
setAs("person", "ListOfcreator", from_person("creator"))

## Coercions to "person" type



setAs("creator", "person", function(from) {
  do.call(c, unname(lapply(from@individualName, function(x)
    person(given = unlist(x@givenName),
           family = x@surName))))
})


setAs("ListOfcreator", "person", function(from) {
  do.call(c,
          unname(lapply(from, function(x)
            as(x, "person"))))
})

## Coercions between R's bibtype & eml


## Coercions for G-Polygon objects (for coverage data)
