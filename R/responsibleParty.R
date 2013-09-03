require(utils)


setClass("individualName",  
         representation(salutation = "character",
                        givenName = "character", 
                        surName = "character"))
setAs("XMLInternalElementNode", "individualName",   function(from) emlToS4(from))
setAs("individualName", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("address", 
         representation(deliveryPoint = "character", # street address
                         city = "character",
                         adminstrativeArea = "character", #state
                         postalCode = "character",
                         country = "character"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "address",   function(from) emlToS4(from))
setAs("address", "XMLInternalElementNode",   function(from) S4Toeml(from))


### definition of the focal class, responsibleParty 
setClass("responsibleParty",
         representation(individualName = "individualName", # or
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
setAs("character", "responsibleParty", function(from)
  as(as.person(from), "responsibleParty"))  # need to import utils for the person definition
#' @import utils 
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



setClass("creator", contains="responsibleParty")
setAs("XMLInternalElementNode", "creator",   function(from) emlToS4(from))
setAs("creator", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("person", "creator", function(from)
  as(as(from, "responsibleParty"), "creator"))
setAs("creator", "person", function(from){
   p <- as(from, "person")
   p$role = "cre" 
   p
  })
setAs("character", "creator", function(from)
  as(as.person(from), "creator"))
setAs("creator", "contact", function(from)
      as(as(from, "responsibleParty"), "contact"))


setClass("ListOfcreator", contains = "list",
         validity = function(object)
               if(!all(sapply(object, is, "creator")))
                  "not all elements are creator objects"
               else
                 TRUE)

setClass("contact", contains="responsibleParty")
setAs("XMLInternalElementNode", "contact",   function(from) emlToS4(from))
setAs("contact", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("person", "contact", function(from)
  as(as(from, "responsibleParty"), "contact"))
setAs("contact", "person", function(from){
   as(from, "person")
  })
setAs("character", "contact", function(from)
  as(as.person(from), "contact"))
## FIXME Should be something more intelligent that will let these
## inherit the method from responsibleParty?  callNextMethod() maybe??



