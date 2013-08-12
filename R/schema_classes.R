

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
                        size = "numeric", # "object_size", # R class  
                        characterEncoding = "character",
                        dataFormat = "eml:dataFormat",
                        distribution = "eml:distribution"))



## Attribute List ##


setClass("eml:codeDefinition", 
         representation(code = "character",
                        definition = "character"))
setClass("ListOfCodeDefinition", contains="list")
setClass("eml:textDomain", 
         representation(definition = "character"))
setClass("eml:nonNumericDomain", 
         representation(enumeratedDomain = "ListOfCodeDefinition",
                        textDomain = "eml:textDomain"))
setClass("eml:nominal", 
         representation(nonNumericDomain = "eml:nonNumericDomain"))

setClass("eml:ordinal", contains="eml:nominal")

setClass("eml:numericDomain", 
         representation(numberType = "character")) 
         # Alternatively restrict this to one of: "natural", "whole", "integer", "real", though schema should enforce that

setClass("eml:unit",
         representation(standardUnit = "character", # make from a restricted subset
                        customUnit = "character"))  # should be a class to enforce format?
setClass("eml:ratio", 
         representation(unit = "eml:unit",
                        precision = "numeric",
                        numericDomain = "eml:numericDomain"))

setClass("eml:interval", contains="eml:ratio")


setClass("eml:dateTime", 
         representation(formatString = "character",
                        dateTimePrecision = "character",
                        dateTimeDomain = "character"))

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




setClass("eml:entity", 
         representation(entityName = "character",
                        entityDescription = "character"))

setClass("eml:dataTable", 
         representation(physical = "eml:physical",
                        attributeList = "eml:attributeList",
                        caseSensitive = "logical",
                        numberOfRecords = "integer"),
         contains="eml:entity")




## Read from eml$get
default_creator <- 
  new("eml:person", 
      individualName = new("eml:individualName", 
                           givenName = eml$get("contact_givenName"),
                           surName = eml$get("contact_surName")),
      electronicMail = eml$get("contact_email"))



setClass("eml:dataset", 
         representation('title' = "character",
                        creator = "eml:person",
                        contact = "eml:person",
                        rights  = "character",
                        'methods' = "eml:methods",
                        dataTable = "eml:dataTable"),
        prototype(rights = eml$get("default_rights"),
                  creator = default_creator,
                  contact = default_creator))


eml_namespaces = c(eml = "eml://ecoinformatics.org/eml-2.1.1", 
                   ds = "eml://ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml:eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        namespaces  = "character",
                        dataset     = "eml:dataset",
                        additionalMetadata = "eml:additionalMetadata"),
          prototype = prototype(packageId = paste(sep='', "urn:uuid:", uuid::UUIDgenerate()),
                                system = 'uuid',
                                namespaces = eml_namespaces))



