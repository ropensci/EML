

### Person #####
setClass("individualName",  
         representation(givenName = "character", 
                        surName = "character"))

setClass("additionalMetadata", 
         representation(metadata = "character",
                        describes = "character"))
setClass("eml_person",
         representation(individualName = "individualName",  
                        electronicMailAddress = "character"))

setClass("creator", contains="eml_person")
setClass("contact", contains="eml_person")

### Methods ### 
setClass("methodStep", 
         representation(description = "character")) # software, 
setClass("methods", 
         representation(methodsStep = "methodStep"))



## Physical ##
  ### Data Format ###
setClass("simpleDelimited", 
         representation(fieldDelimiter = "character"))

setClass("textFormat", 
         representation(numHeaderLines = "integer",
                        numFooterLines = "integer",
                        recordDelimiter = "character",
                        attributeOrientation = "character", 
                        simpleDelimited = "simpleDelimited"))



setClass("dataFormat",
         representation(textFormat = "textFormat"))

  ### Distribution ##
setClass("offline")
setClass("online",
         representation(url = "character",
                        onlineDescription = "character"))
setClass("distribution",
         representation(online = "online",
                        offline = "offline",
                        inline = "character"))

setClass("physical",
         representation(objectName = "character",
                        size = "numeric", # "object_size", # R class  
                        characterEncoding = "character",
                        dataFormat = "dataFormat",
                        distribution = "distribution"))



## Attribute List ##


setClass("codeDefinition", 
         representation(code = "character",
                        definition = "character"))
setClass("ListOfCodeDefinition", contains="list")
#setClass("enumeratedDomain", 
#         representation(codeDefinition = "ListOfCodeDefinition"))
setClass("textDomain", 
         representation(definition = "character"))
setClass("nonNumericDomain", 
         representation(enumeratedDomain = "ListOfCodeDefinition", ### Unclear if this should be "enumeratedDomain"
                        textDomain = "textDomain"))
setClass("nominal", 
         representation(nonNumericDomain = "nonNumericDomain"))

setClass("ordinal", contains="nominal")

setClass("numericDomain", 
         representation(numberType = "character")) 
         # Alternatively restrict this to one of: "natural", "whole", "integer", "real", though schema should enforce that

setClass("unit",
         representation(standardUnit = "character", # make from a restricted subset
                        customUnit = "character"))  # should be a class to enforce format?
setClass("ratio", 
         representation(unit = "unit",
                        precision = "numeric",
                        numericDomain = "numericDomain"))

setClass("interval", contains="ratio")


setClass("dateTime", 
         representation(formatString = "character",
                        dateTimePrecision = "character",
                        dateTimeDomain = "character"))

setClass("measurementScale", 
         representation(nominal = "nominal",
                        ordinal = "ordinal",
                        interval = "interval",
                        ratio = "ratio",
                        dateTime = "dateTime"))

setClass("attribute", 
         representation(id = "character",
                        attributeName = "character",
                        attributeDefinition = "character",
                        measurementScale = "measurementScale"))
setClass("attributeList", contains="list")




setClass("entity", 
         representation(entityName = "character",
                        entityDescription = "character"))

setClass("dataTable", 
         representation(physical = "physical",
                        attributeList = "attributeList",
                        caseSensitive = "logical",
                        numberOfRecords = "integer"),
         contains="entity")




default_person <- function(){ # lazy evaluate 
         new("eml_person", 
             individualName = new("individualName", 
                                givenName = getOption("contact_givenName"),
                                surName = getOption("contact_surName")),
             electronicMailAddress = getOption("contact_email"))
}


setClass("ListOfeml_person", contains = "list",
         validity = function(object)
               if(!all(sapply(object, is, "eml_person")))
                  "not all elements are eml_person objects"
               else
                 TRUE)

setClass("ListOfcreator", contains="ListOfeml_person")

setClass("dataset", 
         representation('title' = "character",
                        creator = "ListOfcreator",
                        contact = "eml_person",         ###  No idea why this is not working 
                        rights  = "character",
                        'methods' = "methods",
                        dataTable = "dataTable"),
        prototype(rights = getOption("default_rights"),
                  creator = new("ListOfcreator", list(default_person())),
                  contact = default_person() )) 


eml_namespaces = c(eml = "//ecoinformatics.org/eml-2.1.1", 
                   ds = "//ecoinformatics.org/dataset-2.1.1",
                   xs = "http://www.w3.org/2001/XMLSchema",
                   xsi = "http://www.w3.org/2001/XMLSchema-instance",
                   stmml = "http://www.xml-cml.org/schema/stmml-1.1")

setClass("eml",
         representation(packageId   = "character", 
                        system      = "character", 
                        namespaces  = "character",
                        dataset     = "dataset",
                        additionalMetadata = "additionalMetadata"),
          prototype = prototype(packageId = paste(sep='', "urn:uuid:", uuid::UUIDgenerate()),
                                system = 'uuid',
                                namespaces = eml_namespaces))



