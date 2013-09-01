## Attribute List ##
setClass("codeDefinition", 
         representation(code = "character",
                        definition = "character"))
setClass("ListOfcodeDefinition", contains="list")
setClass("enumeratedDomain", 
         representation(codeDefinition = "ListOfcodeDefinition"))
setClass("textDomain", 
         representation(definition = "character"))
setClass("nonNumericDomain", 
         representation(enumeratedDomain = "enumeratedDomain", 
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

setClass("ListOfattribute", contains="list") # set validity all elements are attribute class

setClass("attributeList", 
         representation(id = "character", 
                        attribute = "ListOfattribute"))



setAs("XMLInternalElementNode", "codeDefinition",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "enumeratedDomain", function(from) emlToS4(from))
setAs("XMLInternalElementNode", "textDomain",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "nonNumericDomain",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "nominal",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "ordinal",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "numericDomain",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "unit", function(from) emlToS4(from))
setAs("XMLInternalElementNode", "ratio",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "interval",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "dateTime",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "measurementScale",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "attribute",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "attributeList",  function(from) emlToS4(from))
s
