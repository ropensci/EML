
###### referencesGroup ####
setClass("references", 
         slots = c(references = "character")) # A special case handles this
setAs("XMLInternalElementNode", "references", function(from) emlToS4(from))
setAs("references", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfreferences", 
         contains = "list")
setMethod("c", signature("references"), function(x, ...) new("ListOfreferences", list(x, ...)))

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



setClass("ListOfresponsibleParty", contains ="list")
setMethod("c", signature("responsibleParty"), function(x, ...) new("ListOfresponsibleParty", list(x, ...)))


############ Elements inheriting/of type responsibleParty ### 


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
setMethod("c", signature("creator"), function(x, ...) new("ListOfcreator", list(x, ...)))
# Defines contact ##
setClass("contact", contains="responsibleParty")
setAs("XMLInternalElementNode", "contact",   function(from) emlToS4(from))
setAs("contact", "XMLInternalElementNode",   function(from) S4Toeml(from))
## Defines originator ##
setClass("originator", contains="responsibleParty")
setAs("XMLInternalElementNode", "originator",   function(from) emlToS4(from))
setAs("originator", "XMLInternalElementNode",   function(from) S4Toeml(from))
setClass("ListOforiginator", contains="list")
setMethod("c", signature("originator"), function(x, ...) new("ListOforiginator", list(x, ...)))


# publisher + coercions
setClass("person")

setClass("publisher", contains="responsibleParty")

setAs("XMLInternalElementNode", 
      "publisher",   
      function(from) emlToS4(from))

setAs("publisher", 
      "XMLInternalElementNode",   
      function(from) S4Toeml(from))

setAs("publisher", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p
  })

setAs("person", "publisher", function(from){
   p <- as(as(from, "responsibleParty"), "publisher")
   p
  })

# institution + coercions
setClass("institution", contains="responsibleParty")

setAs("XMLInternalElementNode", 
      "institution",   
      function(from) emlToS4(from))

setAs("institution", 
      "XMLInternalElementNode",   
      function(from) S4Toeml(from))

setClass("ListOfinstitution", contains="list")

setMethod("c", 
          signature("institution"), 
          function(x, ...) new("ListOfinstitution", list(x, ...)))

setAs("institution", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p
  })

setAs("ListOfinstitution", "person", function(from){
      l <- lapply(from, as, "person")
      out <- NULL
      for(p in l)
        out <- c(out, p)
      class(out) = "person"
      out
   })

setAs("person", "ListOfinstitution", function(from){
      new("ListOfinstitution", lapply(person, as, "institution"))
})

# performer + list + coercions
setClass("performer", contains="responsibleParty")

setAs("XMLInternalElementNode", 
      "performer", 
      function(from) emlToS4(from))

setAs("performer", 
      "XMLInternalElementNode",   
      function(from) S4Toeml(from))

setClass("ListOfperformer", contains="list")

setMethod("c", 
          signature("performer"), 
          function(x, ...) new("ListOfperformer", list(x, ...)))

setAs("performer", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p$role = "cre"
   p
  })

setAs("ListOfperformer", "person", function(from){
      l <- lapply(from, as, "person")
      out <- NULL
      for(p in l)
        out <- c(out, p)
      class(out) = "person"
      out
   })

setAs("person", "ListOfperformer", function(from){
      new("ListOfperformer", lapply(person, as, "performer"))
})

# recipient + list + coercions
setClass("recipient", contains="responsibleParty")

setAs("XMLInternalElementNode", 
      "recipient", 
      function(from) emlToS4(from))

setAs("recipient", 
      "XMLInternalElementNode",   
      function(from) S4Toeml(from))

setClass("ListOfrecipient", contains="list")

setMethod("c", 
          signature("recipient"), 
          function(x, ...) new("ListOfrecipient", list(x, ...)))

setAs("recipient", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p$role = "ctb"
   p
  })

setAs("ListOfrecipient", "person", function(from){
      l <- lapply(from, as, "person")
      out <- NULL
      for(p in l)
        out <- c(out, p)
      class(out) = "person"
      out
   })

setAs("person", "ListOfrecipient", function(from){
      new("ListOfrecipient", lapply(person, as, "recipient"))
})

# editor + list + coercions
setClass("editor", contains="responsibleParty")

setAs("XMLInternalElementNode", 
      "editor",   
      function(from) emlToS4(from))

setAs("editor", 
      "XMLInternalElementNode",   
      function(from) S4Toeml(from))

setAs("editor", 
      "person", 
      function(from){
        p <- as(as(from, "responsibleParty"), "person")
        p$role = "cre"
        p
      }
    )

setAs("person", 
      "editor", 
      function(from) as(as(from, "responsibleParty"), "editor"))

setAs("character", 
      "editor", 
      function(from) as(as.person(from), "editor"))

setClass("ListOfeditor", contains="list")

setMethod("c", 
          signature("editor"), 
          function(x, ...) new("ListOfeditor", list(x, ...)))

setAs("ListOfeditor", 
      "person", 
      function(from){
        l <- lapply(from, as, "person")
        out <- NULL
        for(p in l)
          out <- c(out, p)
        class(out) = "person"
        out
      }
    )

setAs("person", 
      "ListOfeditor", 
      function(from){
        new("ListOfeditor", lapply(person, as, "editor"))
      }
    )


####### Part of resource.R class
setClass("metadataProvider", contains="responsibleParty")
setAs("XMLInternalElementNode", "metadataProvider",   function(from) emlToS4(from))
setAs("metadataProvider", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("associatedPartySlots", slots = c(role = "character")) # hack to change odering
# Unclear if role should be one of the controlled types: http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-party.html#RoleType, hf205 doesn't follow that.
setClass("associatedParty", contains=c("responsibleParty", "associatedPartySlots")) # FIXME should be ListOfresponsibleParty? but then does not find the type...
setAs("XMLInternalElementNode", "associatedParty",   function(from) emlToS4(from))
setAs("associatedParty", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("ListOfmetadataProvider", contains="list")
setMethod("c", signature("metadataProvider"), function(x, ...) new("ListOfmetadataProvider", list(x, ...)))
setClass("ListOfassociatedParty", contains="list")
setMethod("c", signature("associatedParty"), function(x, ...) new("ListOfassociatedParty", list(x, ...)))







########### Coercions between classes ########### 


setAs("creator", "contact", function(from)
      as(as(from, "responsibleParty"), "contact"))


### Coercsions to person object ###########

# Make a formal S4 class of the S3 class.  
#' @import utils 
setOldClass("person") # promote to S4

setAs("character", "responsibleParty", function(from){
  if(length(from) > 0)
    as(as.person(from), "responsibleParty")
  else
    new("responsibleParty")
  })
setAs("list", "responsibleParty", function(from)
      as(as(from, "character"),"responsibleParty"))

setAs("person", "responsibleParty", function(from){
      if(length(from) == 1){
        new("responsibleParty",
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

setAs("NULL", "responsibleParty", function(from) new("responsibleParty"))
setAs("NULL", "creator", function(from) new("creator"))
setAs("NULL", "contact", function(from) new("contact"))


setAs("responsibleParty", "person", function(from)
  person(from@individualName@givenName,
         from@individualName@surName,
         email = from@electronicMailAddress)
)

setAs("person", "metadataProvider", function(from)
      as(as(from, "responsibleParty"), "metadataProvider"))
setAs("person", "associatedParty", function(from){
      out <- as(as(from, "responsibleParty"), "associatedParty")
      out@role <- from$role
      out
      })


setAs("person", "creator", function(from)
  as(as(from, "responsibleParty"), "creator"))

setAs("creator", "person", function(from){
   p <- as(as(from, "responsibleParty"), "person")
   p$role = "cre"
   p
  })
setAs("character", "creator", function(from)
  as(as(from, "responsibleParty"), "creator"))


setAs("person", "contact", function(from)
  as(as(from, "responsibleParty"), "contact"))
setAs("contact", "person", function(from){
   as(as(from, "responsibleParty"), "person")
  })
setAs("character", "contact", function(from)
  as(as(from, "responsibleParty"), "contact"))

setMethod("print", "responsibleParty", function(x)
  as(x, "person"))


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
setAs("person", "ListOfcreator", function(from){
      new("ListOfcreator", lapply(person, as, "creator"))
})




setAs("person", "individualName", function(from)
   new("individualName",
       givenName = from$given,
       surName = from$family))

setAs("individualName", "person", function(from){
  person(from@givenName,from@surName)
})



