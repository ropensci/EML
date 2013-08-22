

```r
require(reml)
```


## What example functions would look like

```r

eml_write <- function(x, file = NULL) {
    eml <- as(x, "eml:eml")
    doc <- newXMLDoc(node = eml)
    saveXML(doc, file = file)
}
```


some testing data


```r

dat = data.frame(river = c("SAC", "SAC", "AM"), spp = c("king", "king", "ccho"), 
    stg = c("smolt", "parr", "smolt"), ct = c(293L, 410L, 210L))
```



New metadata format


```r
metadata <- list(river = list("river", "River site used for collection", c(SAC = "The Sacramento River", 
    AM = "The American River")), spp = list("spp", "Species common name", c(king = "King Salmon", 
    ccho = "Coho Salmon")), stg = list("stg", "Life Stage", c(parr = "third life stage", 
    smolt = "fourth life stage")), ct = list("ct", "count", "number"))
```


### Coercion methods 

Detect types 


```r
metadata <- detect_class(dat, metadata)
```


Coerce a factor definitions into a nominal,


```r
as(metadata$river[[3]], "eml:nominal")
```

```
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "SAC"
## 
## Slot "definition":
##                    SAC 
## "The Sacramento River" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "AM"
## 
## Slot "definition":
##                   AM 
## "The American River" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
```


or coerce the entire list into an attribute node (includes the above coercion)


```r
as(metadata$river, "eml:attribute")
```

```
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "river"
## 
## Slot "attributeDefinition":
## [1] "River site used for collection"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "SAC"
## 
## Slot "definition":
##                    SAC 
## "The Sacramento River" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "AM"
## 
## Slot "definition":
##                   AM 
## "The American River" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
```


Or all metadata lists at once:


```r
as(metadata, "eml:attributeList")
```

```
## An object of class "eml:attributeList"
## [[1]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "river"
## 
## Slot "attributeDefinition":
## [1] "River site used for collection"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "SAC"
## 
## Slot "definition":
##                    SAC 
## "The Sacramento River" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "AM"
## 
## Slot "definition":
##                   AM 
## "The American River" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[2]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "spp"
## 
## Slot "attributeDefinition":
## [1] "Species common name"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "king"
## 
## Slot "definition":
##          king 
## "King Salmon" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "ccho"
## 
## Slot "definition":
##          ccho 
## "Coho Salmon" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[3]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "stg"
## 
## Slot "attributeDefinition":
## [1] "Life Stage"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "parr"
## 
## Slot "definition":
##               parr 
## "third life stage" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "smolt"
## 
## Slot "definition":
##               smolt 
## "fourth life stage" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[4]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "ct"
## 
## Slot "attributeDefinition":
## [1] "count"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## [1] "number"
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
```



```r
new("eml:dataset", dataTable = new("eml:dataTable", attributeList = as(metadata, 
    "eml:attributeList")))
```

```
## An object of class "eml:dataset"
## Slot "title":
## character(0)
## 
## Slot "creator":
## An object of class "eml:person"
## Slot "individualName":
## An object of class "eml:individualName"
## Slot "givenName":
## character(0)
## 
## Slot "surName":
## character(0)
## 
## 
## Slot "electronicMail":
## character(0)
## 
## 
## Slot "rights":
## character(0)
## 
## Slot "methods":
## An object of class "eml:methods"
## Slot "methodsStep":
## An object of class "eml:methodStep"
## Slot "description":
## character(0)
## 
## 
## 
## Slot "dataTable":
## An object of class "eml:dataTable"
## Slot "physical":
## An object of class "eml:physical"
## Slot "objectName":
## character(0)
## 
## Slot "size":
## character(0)
## 
## Slot "characterEncoding":
## character(0)
## 
## Slot "dataFormat":
## An object of class "eml:dataFormat"
## Slot "textFormat":
## An object of class "eml:textFormat"
## Slot "numHeaderLines":
## integer(0)
## 
## Slot "numFooterLines":
## integer(0)
## 
## Slot "recordDelimiter":
## character(0)
## 
## Slot "attributeOrientation":
## character(0)
## 
## Slot "simpleDelimited":
## An object of class "eml:simpleDelimited"
## Slot "fieldDelimiter":
## character(0)
## 
## 
## 
## 
## Slot "distribution":
## An object of class "eml:distribution"
## Slot "online":
## An object of class "eml:online"
## Slot "url":
## character(0)
## 
## Slot "onlineDescription":
## character(0)
## 
## 
## Slot "offline":
## NULL
## 
## Slot "inline":
## character(0)
## 
## 
## 
## Slot "attributeList":
## An object of class "eml:attributeList"
## [[1]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "river"
## 
## Slot "attributeDefinition":
## [1] "River site used for collection"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "SAC"
## 
## Slot "definition":
##                    SAC 
## "The Sacramento River" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "AM"
## 
## Slot "definition":
##                   AM 
## "The American River" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[2]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "spp"
## 
## Slot "attributeDefinition":
## [1] "Species common name"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "king"
## 
## Slot "definition":
##          king 
## "King Salmon" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "ccho"
## 
## Slot "definition":
##          ccho 
## "Coho Salmon" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[3]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "stg"
## 
## Slot "attributeDefinition":
## [1] "Life Stage"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## [[1]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "parr"
## 
## Slot "definition":
##               parr 
## "third life stage" 
## 
## 
## [[2]]
## An object of class "eml:codeDefinition"
## Slot "code":
## [1] "smolt"
## 
## Slot "definition":
##               smolt 
## "fourth life stage" 
## 
## 
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## [[4]]
## An object of class "eml:attribute"
## Slot "attributeName":
## [1] "ct"
## 
## Slot "attributeDefinition":
## [1] "count"
## 
## Slot "measurementScale":
## An object of class "eml:measurementScale"
## Slot "nominal":
## An object of class "eml:nominal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## [1] "number"
## 
## 
## 
## 
## Slot "ordinal":
## An object of class "eml:ordinal"
## Slot "nonNumericDomain":
## An object of class "eml:nonNumericDomain"
## Slot "enumeratedDomain":
## An object of class "ListOfCodeDefinition"
## list()
## 
## Slot "textDomain":
## An object of class "eml:textDomain"
## Slot "definition":
## character(0)
## 
## 
## 
## 
## Slot "interval":
## An object of class "eml:interval"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "ratio":
## An object of class "eml:ratio"
## Slot "unit":
## An object of class "eml:unit"
## Slot "standardUnit":
## character(0)
## 
## Slot "customUnit":
## character(0)
## 
## 
## Slot "precision":
## numeric(0)
## 
## Slot "numericDomain":
## An object of class "eml:numericDomain"
## Slot "numberType":
## character(0)
## 
## 
## 
## Slot "dateTime":
## An object of class "eml:dateTime"
## Slot "formatString":
## character(0)
## 
## Slot "dateTimePrecision":
## character(0)
## 
## Slot "dateTimeDomain":
## character(0)
## 
## 
## 
## 
## 
## Slot "caseSensitive":
## logical(0)
## 
## Slot "numberOfRecords":
## integer(0)
## 
## Slot "entityName":
## character(0)
## 
## Slot "entityDescription":
## character(0)
```

