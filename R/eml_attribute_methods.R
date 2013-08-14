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
#             enumeratedDomain = as(from, "enumeratedDomain"))
              enumeratedDomain = as(from, "ListOfCodeDefinition"))
      })

#setAs("character", "enumeratedDomain", function(from)
#      new("enumeratedDomain", codeDefinition = as(from, "ListOfCodeDefinition")))

setAs("character", "ListOfCodeDefinition", 
      function(from){
        new("ListOfCodeDefinition", 
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
  new("attributeList", lapply(from, as, "attribute"))
})





#attrList =  as(metadata, "attributeList")


  
#new("dataset", dataTable = new("dataTable", attributeList = attrList) )

