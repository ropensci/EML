## Attribute List ##
#' @include generics.R

setClass("codeDefinition", 
         slots = c(code = "character",
                        definition = "character"))
setAs("codeDefinition", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "codeDefinition",  function(from) emlToS4(from))


setClass("ListOfcodeDefinition", contains="list")

setClass("enumeratedDomain", 
         slots = c(codeDefinition = "ListOfcodeDefinition"))
setAs("enumeratedDomain", "XMLInternalElementNode",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "enumeratedDomain", function(from) emlToS4(from))

setClass("textDomain", 
         slots = c(definition = "character"))
setAs("textDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "textDomain",  function(from) emlToS4(from))

setClass("nonNumericDomain", 
         slots = c(enumeratedDomain = "enumeratedDomain", 
                        textDomain = "textDomain"))
setAs("nonNumericDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "nonNumericDomain",  function(from) emlToS4(from))


setClass("nominal", 
         slots = c(nonNumericDomain = "nonNumericDomain"))
setAs("nominal", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "nominal",  function(from) emlToS4(from))


setClass("ordinal", contains="nominal")
setAs("ordinal", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "ordinal",  function(from) emlToS4(from))



setClass("bounds", 
         slots = c(minimum = "numeric",
                        maximum = "numeric"))
setAs("XMLInternalElementNode", "bounds", function(from) emlToS4(from))
setAs("bounds", "XMLInternalElementNode", function(from) S4Toeml(from))

setClass("boundsGroup", 
         slots = c(bounds = "bounds"))  ## FIXME Schema allows this to be ListOf.  What would that mean??? 
setAs("XMLInternalElementNode", "boundsGroup", function(from) emlToS4(from))
setAs("boundsGroup", "XMLInternalElementNode", function(from) S4Toeml(from))

setClass("numericDomain", 
         slots = c(numberType = "character",
                        boundsGroup = "boundsGroup")) 
setAs("numericDomain", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "numericDomain",  function(from) emlToS4(from))

setClass("unit",
         slots = c(standardUnit = "character", # make from a restricted subset
                        customUnit = "character"))  # should be a class to enforce format?
setAs("unit", "XMLInternalElementNode",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "unit", function(from) emlToS4(from))


setClass("ratio", 
         slots = c(unit = "unit",
                        precision = "numeric",
                        numericDomain = "numericDomain"))
setAs("ratio", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "ratio",  function(from) emlToS4(from))

setClass("interval", contains="ratio")
setAs("interval", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "interval",  function(from) emlToS4(from))


setClass("dateTime", 
         slots = c(formatString = "character",
                        dateTimePrecision = "character",
                        dateTimeDomain = "character"))
setAs("dateTime", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "dateTime",  function(from) emlToS4(from))


setClass("measurementScale", 
         slots = c(nominal = "nominal",
                        ordinal = "ordinal",
                        interval = "interval",
                        ratio = "ratio",
                        dateTime = "dateTime"))
setAs("measurementScale", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "measurementScale",  function(from) emlToS4(from))


setClass("attribute", 
         slots = c(id = "character",
                        attributeName = "character",
                        attributeDefinition = "character",
                        measurementScale = "measurementScale"))
setAs("attribute", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "attribute",  function(from) emlToS4(from))


setClass("ListOfattribute", contains="list") # set validity all elements are attribute class

setClass("attributeList", 
         slots = c(id = "character", 
                        attribute = "ListOfattribute"))
setAs("attributeList", "XMLInternalElementNode",   function(from) emlToS4(from))
setAs("XMLInternalElementNode", "attributeList",  function(from) emlToS4(from))



### Helper Method updates metadata list with class #######################
#' Helper function to attach classes to metadata
#' @param dat a data frame
#' @param meta a list containing attribute-level metadata for each column.  
#' each element of list corresponds to a consecutive column, and gives a list containing
#' the column name (as appearing in the data-frame), the column description (e.g. from col.defs)
#' and the 
#' @export 
detect_class <- function(dat, meta){
  for(i in 1:length(dat)){
    meta[[i]][[4]] = map(dat[[i]]) 
  }
  meta 
}

map <- function(x){
  if(is(x, "numeric") | is(x, "integer"))
    "ratio" ## FIXME ideally we'd want to keep track of integer vs numeric..
  else if(is(x, "ordered"))
    "ordinal"
  else if(is(x, "factor"))
    "nominal"
  else if(is(x, "POSIXlt") | is(x, "POSIXct") | is(x, "Date"))
    "dateTime"
  else if(is(x, "character"))
    "nominal"
  else 
    "nominal" # FIXME should we error or default to character string?
}


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



########################### Extraction methods ###################################
## methods extract standard R formats (e.g. the metadata list format) 


setMethod("extract", signature("attributeList"), function(from){
  lapply(from@attribute, 
         function(x) 
           list(x@attributeName,
                x@attributeDefinition,
                extract(x@measurementScale)))
})

 
setMethod("extract", signature("measurementScale"), function(from){
# Find out which scale is not empty...
  plyr::compact(lapply(slotNames(from), function(s)
    if(!isEmpty(slot(from, s)))
      extract(slot(from, s))))[[1]]
})

## FIXME write these methods! 
setMethod("extract", signature("nominal"), function(from){
  x <- from@nonNumericDomain
  if(!isEmpty(x@enumeratedDomain)){  # Factor
    code <- sapply(x@enumeratedDomain@codeDefinition, function(y) y@code)
    def <- sapply(x@enumeratedDomain@codeDefinition, function(y) y@definition)
    names(def) <- code
    def 
  } else if(!isEmpty(x@textDomain)) { # character
    x@textDomain@definition
  }
})
setMethod("extract", signature("ordinal"), function(from){
  extract(as(from, "nominal"))
})
setMethod("extract", signature("ratio"), function(from){
  if(!isEmpty(from@unit@standardUnit))
    from@unit@standardUnit
  else if(!isEmpty(from@unit@customUnit))
    from@unit@customUnit
})
setMethod("extract", signature("interval"), function(from){
  extract(as(from, "ratio"))
})
setMethod("extract", signature("dateTime"), function(from){
  from@formatString
})





