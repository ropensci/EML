setClass("address", 
         representation(deliveryPoint = "character", # street address
                         city = "character",
                         adminstrativeArea = "character", #state
                         postalCode = "character",
                         country = "character"),
         contains = "referencesGroup")
setAs("XMLInternalElementNode", "address",   function(from) emlToS4(from))


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
setAs("XMLInternalElementNode", "responsibleParty",   function(from) emlToS4(from))

