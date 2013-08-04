

### Person #####
setClass("eml:individualName",  
         representation(givenName = "character", 
                        surName = "character"))

setClass("eml:additionalMetadata", 
         representation(metadata = "character",
                        describes = "character"))
setClass("eml:person",
         representation(individualName = "eml:individualName",  
                        electronicMail = "character"))


### Methods ### 
setClass("eml:methodStep", 
         representation(description = "character")) # software, 
setClass("eml:methods", 
         representation(methodsStep = "eml:methodStep"))



## Physical ##
  ### Data Format ###
setClass("eml:simpleDelimited", 
         representation(fieldDelimiter = "character"))

setClass("eml:textFormat", 
         representation(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character", 
                        simpleDelimited = "eml:simpleDelimited"))
setClass("eml:dataFormat",
         representation(textFormat = "eml:textFormat"))

  ### Distribution ##
setClass("eml:offline")
setClass("eml:online",
         representation(url = "character",
                        onlineDescription = "character"))
setClass("eml:distribution",
         representation(online = "eml:online",
                        offline = "eml:offline",
                        inline = "character"))

setClass("eml:physical",
         representation(objectName = "character",
                        size = "character", 
                        characterEncoding = "character",
                        dataFormat = "eml:dataFormat",
                        distribution = "eml:distribution"))



## Attribute List ##
setClass("eml:customUnit")

setClass("eml:codeDefinition", 
         representation(code = "character",
                        definition = "character"))
setClass("ListOfCodeDefinition", contains="list")
setClass("eml:nonNumericDomain", 
         representation(enumeratedDomain = "ListOfCodeDefinition"))
setClass("eml:nominal", 
         representation(nonNumericDomain = "eml:nonNumericDomain"))

setClass("eml:ordinal")

setClass("eml:interval")

setClass("eml:numericDomain", 
         representation(numberType = "character")) 
         # Alternatively restrict this to one of: "natural", "whole", "integer", "real", though schema should enforce that

setClass("eml:unit",
         representation(standardUnit = "character",
                        customUnit = "eml:customUnit")) # make from a restricted subset
setClass("eml:ratio", 
         representation(unit = "eml:unit",
                        precision = "numeric",
                        numericDomain = "eml:numericDomain"))

setClass("eml:dateTime")


setClass("eml:measurementScale", 
         representation(nominal = "eml:nominal",
                        ordinal = "eml:ordinal",
                        interval = "eml:interval",
                        ratio = "eml:ratio",
                        dateTime = "eml:dateTime"))

setClass("eml:attribute", 
         representation(attributeName = "character",
                        attributeDefinition = "character",
                        measurementScale = "eml:measurementScale"))
setClass("eml:attributeList", contains="list")




setClass("eml:dataTable", 
         representation(entityName = "character",
                        entityDescription = "character",
                        physical = "eml:physical",
                        attributeList = "eml:attributeList",
                        caseSensitive = "logical",
                        numberOfRecords = "integer"))

setClass("eml:dataset", 
         representation('title' = "character",
                        creator = "eml:person",
                        rights  = "character",
                        'methods' = "eml:methods",
                        dataTable = "eml:dataTable"))

setClass("eml:eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        namespaces  = "character",
                        dataset     = "eml:dataset",
                        additionalMetadata = "eml:additionalMetadata"))

