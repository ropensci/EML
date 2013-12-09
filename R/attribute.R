## Attribute List ##
setClass("codeDefinition", 
         slots = c(code = "character",
                        definition = "character"))
setAs("codeDefinition", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "codeDefinition",  function(from) emlToS4(from))


setClass("ListOfcodeDefinition", contains="list")

setClass("enumeratedDomain",
         slots = c(codeDefinition = "ListOfcodeDefinition"))
setAs("enumeratedDomain", "XMLInternalElementNode",  function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "enumeratedDomain", function(from) emlToS4(from))

setClass("textDomain",
         slots = c(definition = "character"))
setAs("textDomain", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "textDomain",  function(from) emlToS4(from))

setClass("nonNumericDomain",
         slots = c(enumeratedDomain = "enumeratedDomain",
                        textDomain = "textDomain"))
setAs("nonNumericDomain", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "nonNumericDomain",  function(from) emlToS4(from))


setClass("nominal",
         slots = c(nonNumericDomain = "nonNumericDomain"))
setAs("nominal", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "nominal",  function(from) emlToS4(from))


setClass("ordinal", contains="nominal")
setAs("ordinal", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "ordinal",  function(from) emlToS4(from))



setClass("bounds",
         slots = c(minimum = "numeric",
                   maximum = "numeric"))
setAs("bounds", "XMLInternalElementNode", function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "bounds", function(from) emlToS4(from))

setClass("boundsGroup",
         slots = c(bounds = "bounds"))  ## FIXME Schema allows this to be ListOf.  What would that mean???
setAs("boundsGroup", "XMLInternalElementNode", function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "boundsGroup", function(from) emlToS4(from))

setClass("numericDomain",
         slots = c(numberType = "character",
                        boundsGroup = "boundsGroup"))
setAs("numericDomain", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "numericDomain",  function(from) emlToS4(from))

setClass("unit",
         slots = c(standardUnit = "character", # make from a restricted subset
                        customUnit = "character"))  # should be a class to enforce format?
setAs("unit", "XMLInternalElementNode",  function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "unit", function(from) emlToS4(from))


setClass("ratio",
         slots = c(unit = "unit",
                        precision = "numeric",
                        numericDomain = "numericDomain"))
setAs("ratio", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "ratio",  function(from) emlToS4(from))

setClass("interval", contains="ratio")
setAs("interval", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "interval",  function(from) emlToS4(from))


setClass("dateTime",
         slots = c(formatString = "character",
                        dateTimePrecision = "character",
                        dateTimeDomain = "character"))
setAs("dateTime", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "dateTime",  function(from) emlToS4(from))


setClass("measurementScale",
         slots = c(nominal = "nominal",
                        ordinal = "ordinal",
                        interval = "interval",
                        ratio = "ratio",
                        dateTime = "dateTime"))
setAs("measurementScale", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "measurementScale",  function(from) emlToS4(from))

setClass("attribute",
         slots = c(id = "character",
                        attributeName = "character",
                        attributeDefinition = "character",
                        measurementScale = "measurementScale"))
setAs("attribute", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "attribute",  function(from) emlToS4(from))


setClass("ListOfattribute", contains="list",
         validity = function(object)
               if(!all(sapply(object, is, "attribute")))
                  "not all elements are attribute objects"
               else
                 TRUE)

setClass("attributeList",
         slots = c(id = "character",
                        attribute = "ListOfattribute"))
setAs("attributeList", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "attributeList",  function(from) emlToS4(from))


