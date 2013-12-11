
###### referencesGroup ####
setClass("references", 
         slots = c(references = "character")) # A special case handles this
setAs("XMLInternalElementNode", "references", function(from) emlToS4(from))
setAs("references", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfreferences", 
         contains = "list")

setClass("referencesGroup", 
         slots = c("references" = "ListOfreferences"))

setAs("XMLInternalElementNode", "referencesGroup", function(from) emlToS4(from))
setAs("referencesGroup", "XMLInternalElementNode",   function(from) S4Toeml(from))


################ responsibleParty ######################

### Definitions for elements of responsibleParty ### 

setClass("individualName",
         slots = c(salutation = "character",
                        givenName = "character",
                        surName = "character"))
setAs("XMLInternalElementNode", "individualName",   function(from) emlToS4(from))
setAs("individualName", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("address",
         slots = c(deliveryPoint = "character", # street address
                         city = "character",
                         administrativeArea = "character", #state
                         postalCode = "character",
                         country = "character"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "address",   function(from) emlToS4(from))
setAs("address", "XMLInternalElementNode",   function(from) S4Toeml(from))


### definition of the focal class, responsibleParty
setClass("responsibleParty",
         slots = c(individualName = "individualName", # or
                        organizationName = "character",
                        positionName = "character",
                        address = "address",
                        phone = "character",
                        electronicMailAddress = "character",
                        onlineUrl = "character",
                        userID = "character"),
         contains = "referencesGroup")
## Methods for the class
setAs("XMLInternalElementNode", "responsibleParty",   function(from) emlToS4(from))
setAs("responsibleParty", "XMLInternalElementNode",   function(from) S4Toeml(from))





## Defines creator ##
setClass("creator", contains="responsibleParty")
setAs("XMLInternalElementNode", "creator",   function(from) emlToS4(from))
setAs("creator", "XMLInternalElementNode",   function(from) S4Toeml(from))
setClass("ListOfcreator", contains = "list",
         validity = function(object)
               if(!all(sapply(object, is, "creator")))
                  "not all elements are creator objects"
               else
                 TRUE)
# Defines contact ##
setClass("contact", contains="responsibleParty")
setAs("XMLInternalElementNode", "contact",   function(from) emlToS4(from))
setAs("contact", "XMLInternalElementNode",   function(from) S4Toeml(from))
## Defines originator ##
setClass("originator", contains="responsibleParty")
setAs("XMLInternalElementNode", "originator",   function(from) emlToS4(from))
setAs("originator", "XMLInternalElementNode",   function(from) S4Toeml(from))
setClass("ListOforiginator", contains="list")


## Helper class definitions for dataset 
setClass("publisher", contains="responsibleParty")
setAs("XMLInternalElementNode", "publisher",   function(from) emlToS4(from))
setAs("publisher", "XMLInternalElementNode",   function(from) S4Toeml(from))

########### Coercions between classes ########### 


setAs("creator", "contact", function(from)
      as(as(from, "responsibleParty"), "contact"))


### Coercsions to person object ###########

# Make a formal S4 class of the S3 class.  Could add a validation method to check is(object, "person")...
#' @import utils 
setClass("person", contains = "list")

setAs("character", "responsibleParty", function(from)
  as(as.person(from), "responsibleParty"))  # need to import utils for the person definition

setAs("responsibleParty", "person", function(from)
  person(from@individualName@givenName,
         from@individualName@surName,
         email = from@electronicMailAddress)
)
setAs("person", "responsibleParty", function(from)
  new("responsibleParty",
      individualName = new("individualName",
                           "givenName" = as.character(from$given),
                           "surName" = as.character(from$family)),
      electronicMailAddress = as.character(from$email))
)

setMethod("print", "responsibleParty", function(x)
  as(x, "person"))
setClass("ListOfresponsibleParty", contains ="list")


setAs("person", "creator", function(from)
  as(as(from, "responsibleParty"), "creator"))
setAs("creator", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p$role = "cre"
   p
  })
setAs("character", "creator", function(from)
  as(as.person(from), "creator"))


setAs("person", "contact", function(from)
  as(as(from, "responsibleParty"), "contact"))
setAs("contact", "person", function(from){
   as(as(from, "responsibleParty"), "person")
  })
setAs("character", "contact", function(from)
  as(as.person(from), "contact"))


## FIXME Should be something more intelligent that will let these
## inherit the method from responsibleParty?  callNextMethod() maybe??

setAs("ListOfresponsibleParty", "person", function(from){
      l <- lapply(from, as, "person")
      out <- l[[1]]
      for(p in l)
        c(out, p)
      out
  })

setAs("ListOfcreator", "person", function(from){
    l <- lapply(from, as, "person")
      out <- NULL
      for(p in l)
        out <- c(out, p)
      class(out) = "person"
      out
  })


setAs("person", "individualName", function(from)
   new("individualName",
       givenName = from@given,
       surName = from@family))

setAs("individualName", "person", function(from){
  person(from@givenName,from@surName)
})



