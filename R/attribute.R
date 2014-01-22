## Attribute List ##

#' @include literature.R

# FIXME Enumerated Domains (nominal and ordinal) need externalCodeSet and entityCodeList and child classes defined.  (alternatives to codeDefinition)
# @mbjones I'm not clear how these fields would actually be used.  Docs seem to prefer codDefinition to externalCodeSet.  not sure what CodeList is for.  

setClass("codeDefinition", 
         slots = c(code = "character",
                        definition = "character"))
setAs("codeDefinition", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "codeDefinition",  function(from) emlToS4(from))


setClass("ListOfcodeDefinition", contains="list")

#' concatenate
#' 
#' concatenate
#' @param x,... codeDefinitions to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-codeDefinition
setMethod("c", signature("codeDefinition"), function(x, ..., recursive = FALSE) new("ListOfcodeDefinition", list(x, ...)))

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


setClass("ListOfattribute", contains="list") # set validity all elements are attribute class

#' concatenate
#' 
#' concatenate
#' @param x,... attributes to concatenate
#' @param recursive Needed for compatibility with generic, otherwise ignored
#' @rdname class-attribute
setMethod("c", signature("attribute"), function(x, ..., recursive = FALSE) new("ListOfattribute", list(x, ...)))

setClass("attributeList", 
         slots = c(id = "character", 
                        attribute = "ListOfattribute"))
setAs("attributeList", "XMLInternalElementNode",   function(from) S4Toeml(from))
setAs("XMLInternalElementNode", "attributeList",  function(from) emlToS4(from))



######## Methods that write user-provided metadata into S4 #######################

### FIXME weird to have these as coercion methods defined in this manner, 
### since they do not take a general character 
### but rather a very particular data structure.  
### Should at very least define this metadata list as an S3 class (preferably S4 class)
### of it's own, so that we can be sure the object in `from` has correct form.  
### Consider adding or replacing all these methods with coercions from `data.set` 

### Character to nominal 
setAs("character", "nominal", 
      function(from)
        new("nominal",
            nonNumericDomain = as(from, "nonNumericDomain")))

setAs("character", "textDomain", function(from){
  new("textDomain", definition = from)
})
setAs("character", "nonNumericDomain", 
      function(from){
        if (length(from) == 1)
          new("nonNumericDomain",
              textDomain = as(from, "textDomain"))
        else if(length(from) > 1)                                     ## Arguably only for factors?  
          new("nonNumericDomain",                                     ## Arguably only for factors?  
             enumeratedDomain = as(from, "enumeratedDomain"))         ## Arguably only for factors?  
      })
setAs("character", "enumeratedDomain", function(from)                 ## Arguably only for factors?  
      new("enumeratedDomain", 
          codeDefinition = as(from, "ListOfcodeDefinition")))

setAs("character", "ListOfcodeDefinition", 
      function(from){
        new("ListOfcodeDefinition", 
            lapply(names(from), function(name)
              new("codeDefinition", code = name, definition = from[name])))
      })

### Factor to nominal 

setAs("factor", "nominal", 
      function(from)
        new("nominal",
            nonNumericDomain = 
            as(from, "nonNumericDomain")))
setAs("factor", "nonNumericDomain", 
      function(from){
        new("nonNumericDomain", 
             enumeratedDomain = as(from, "enumeratedDomain"))
      })
setAs("factor", "enumeratedDomain", function(from)
      new("enumeratedDomain", codeDefinition = as(from, "ListOfcodeDefinition")))
setAs("factor", "ListOfcodeDefinition", 
      function(from){
        new("ListOfcodeDefinition", 
            lapply(names(from), function(name)
              new("codeDefinition", code = name, definition = as.character(from[name]))))
      })


## Promote nominal to a measurement scale
setAs("nominal", "measurementScale",
      function(from)
        new("measurementScale", 
            nominal = from))


## Ordinal ##
setAs("character", "ordinal", 
      function(from)
        new("ordinal",
            nonNumericDomain = as(from, "nonNumericDomain")))
setAs("ordinal", "measurementScale",
      function(from)
        new("measurementScale", 
            ordinal = from))


## Ratio ## (Note that the unit definition is a character, not a numeric..) 
setAs("character", "ratio", 
      function(from)
        new("ratio", 
            unit = as(from, "unit"),
            numericDomain = new("numericDomain", 
                                numberType = "real"))) 
## FIXME write integers as integers!!
## Unfortunately this is difficult, because both numerics and integers
## come in flagged as a ratio (we also ignore 'interval' type...)
## Might have to correct this post-hoc

setAs("character", "unit", 
      function(from)
        new("unit", standardUnit = from[[1]])) # FIXME Could match from to the standardUnit list
setAs("ratio", "measurementScale",
      function(from)
        new("measurementScale", 
            ratio = from))


#### interval ### 
setAs("character", "interval", 
      function(from)
        new("interval", unit = as(from, "unit")))
setAs("interval", "measurementScale",
      function(from)
        new("measurementScale", 
            interval = from))


## dateTime ## 
setAs("character", "dateTime", 
      function(from)
        new("dateTime", formatString = from[[1]])) 
## FIXME could perform check / validation on string. Could accept R notation (e.g. %Y in place of YYYY)

setAs("dateTime", "measurementScale",
      function(from)
        new("measurementScale", 
            dateTime = from))


            
## Coerce from[[3]] into appropriate scale
setAs("list", "attribute", 
      function(from)
        new("attribute", 
            attributeName = from[[1]],
            attributeDefinition = from[[2]],
            measurementScale = as(as(from[[3]], from[[4]]), "measurementScale")))


setAs("list", "attributeList", function(from){
  if(! all(sapply(from, class) == "list") )
    stop("expected list of lists")
  new("attributeList", 
      attribute = new("ListOfattribute", 
                      lapply(from, as, "attribute")))
})






