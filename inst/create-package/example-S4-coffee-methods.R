## Constructors are not methods, they don't act on classes


individualName <-  function(salutation = new("salutation"),
                            givenName = new("givenName"),
                            surName = new("surName")){

  new("individualName",
      salutation = as(salutation, "salutation"),
      givenName = as(givenName, "givenName"),
      surName = as(surName, "surName"))
}

## Accessors, requires generics
setGeneric("salutation", function(x) standardGeneric("salutation"))
setMethod("salutation", signature = "individualName", function(x) slot(x, "salutation"))

setGeneric("givenName", function(x) standardGeneric("givenName"))
setMethod("givenName", signature = "individualName", function(x) slot(x, "givenName"))

setGeneric("surName", function(objec) standardGeneric("surName"))
setGeneric("surName<-", function(object, value) standardGeneric("surName<-"))
setMethod("surName", signature = "individualName", function(object) slot(object, "surName"))
setMethod("surName<-", signature = "individualName", function(object, value) object@surName <- as(value, "surName"))
