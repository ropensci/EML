### Person #####
setClass("individualName",  
         representation(salutation = "character",
                        givenName = "character", 
                        surName = "character"))

setClass("additionalMetadata", 
         representation(metadata = "character",
                        describes = "character"))
setClass("eml_person",
         representation(individualName = "individualName",  
                        electronicMailAddress = "character"))

setClass("creator", contains="eml_person")
setClass("contact", contains="eml_person")


