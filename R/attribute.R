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


setAs("codeDefinition", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("enumeratedDomain", "XMLInternalElementNode",  function(from) emlToS4(from))
setAs("textDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("nonNumericDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("nominal", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("ordinal", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("numericDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("unit", "XMLInternalElementNode",  function(from) emlToS4(from))
setAs("ratio", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("interval", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("dateTime", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("measurementScale", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("attribute", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("attributeList", "XMLInternalElementNode",   function(from) emlToS4(from))



#' Helper function to attach classes to metadata
#' @export 
detect_class <- function(dat, meta){
  for(i in 1:length(dat)){
    meta[[i]][[4]] = map(class(dat[[i]])) 
  }
  meta 
}

map <- function(x){
  if(is(x, "numeric"))
    "ratio"
  else if(is(x, "ordered"))
    "ordinal"
  else if(is(x, "factor"))
    "nominal"
  else if(is(x, "POSIXlt") | is(x, "POSIXct"))
    "dateTime"
  else if(is(x, "character"))
    "nominal"
}


### Character to nominal (factors and character strings) ###
setAs("character", "nominal", 
      function(from)
        new("nominal",
            nonNumericDomain = as(from, "nonNumericDomain")))
setAs("factor", "nominal", 
      function(from)
        new("nominal",
            nonNumericDomain = 
            as(as(from, "character"),
               "nonNumericDomain")))



setAs("character", "textDomain", function(from){
  new("textDomain", definition = from)
})
setAs("character", "nonNumericDomain", 
      function(from){
        if (length(from) == 1)
          new("nonNumericDomain",
              textDomain = as(from, "textDomain"))
        else if(length(from) > 1)
          new("nonNumericDomain", 
             enumeratedDomain = as(from, "enumeratedDomain"))
#              enumeratedDomain = as(from, "ListOfcodeDefinition"))
      })

setAs("character", "enumeratedDomain", function(from)
      new("enumeratedDomain", codeDefinition = as(from, "ListOfcodeDefinition")))

setAs("character", "ListOfcodeDefinition", 
      function(from){
        new("ListOfcodeDefinition", 
            lapply(names(from), function(name)
              new("codeDefinition", code = name, definition = from[name])))
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


## Ratio ## 
setAs("character", "ratio", 
      function(from)
        new("ratio", unit = as(from, "unit")))
setAs("character", "unit", 
      function(from)
        new("ratio", standardUnit = from)) # Could match from to the standardUnit list

#### interval ### 
setAs("character", "interval", 
      function(from)
        new("interval", unit = as(from, "unit")))


## dateTime ## 
setAs("character", "dateTime", 
      function(from)
        new("dateTime", formatString = from)) ## could perform check / validation on string


            
## Coerce from[[3]] into appropriate scale
setAs("list", "attribute", 
      function(from)
        new("attribute", 
            attributeName = from[[1]],
            attributeDefinition = from[[2]],
            measurementScale = as(as(from[[3]], from[[4]]), "measurementScale")))


setAs("list", "attributeList", function(from){
  if(! all(sapply(from, class) == "list") )
    error("expected list of lists")
  new("attributeList", 
      attribute = new("ListOfattribute", 
                      lapply(from, as, "attribute")))
})


setMethod("extract", signature("attributeList"), function(from){
  lapply(from@attribute, 
         function(x) 
           list(x@attributeName,
                x@attributeDefintion,
                extract(x@measurementScale)))
})

 
setMethod("extract", signature("measurementScale"), function(from){
# Find out which scale is not empty...
  for(s in slotNames(from)){
    if(!isEmpty(slot(from, s))){
      extract(slot(from, s))
    }
  }
})

## FIXME write these methods! 
setMethod("extract", signature("nominal"), function(from){
  character()
})
setMethod("extract", signature("ordinal"), function(from){
  character()
})
setMethod("extract", signature("ratio"), function(from){
  character()
})
setMethod("extract", signature("interval"), function(from){
  character()
})
setMethod("extract", signature("dateTime"), function(from){
  character()
})





