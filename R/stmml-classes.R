#####  inst/xsd/stmml.xsd  ####
setClass('stmml:coordinate2Type', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:coordinate3Type', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:dataTypeType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:sizeType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:delimiterType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:floatArrayType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:countType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:idType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:errorBasisType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:maxType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:minType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:namespaceRefType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:stmml', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:definition', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:documentation', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:metadataList', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:metadataType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:dimensionType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:unitsType', contains = c('eml-2.1.1', 'character')) ## B
setClass('stmml:dataGroup', contains = c('eml-2.1.1', 'character')) ## B


setClass("ListOfstmml:unitType", contains = "list")
setClass("ListOfstmml:unit", contains = "list")
setClass("ListOfstmml:dimension", contains = "list")


## FIXME has only attribute slots, not child slots!
setClass('stmml:array', slots = c('character' = 'character', 'dataType' = 'xml_attribute', 'errorValues' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValues' = 'xml_attribute', 'maxValues' = 'xml_attribute', 'units' = 'xml_attribute', 'delimiter' = 'xml_attribute', 'size' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:scalar', slots = c('character' = 'character', 'dataType' = 'xml_attribute', 'errorValue' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValue' = 'xml_attribute', 'maxValue' = 'xml_attribute', 'units' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:matrix', slots = c('character' = 'character', 'dataType' = 'xml_attribute', 'delimiter' = 'xml_attribute', 'rows' = 'xml_attribute', 'columns' = 'xml_attribute', 'units' = 'xml_attribute', 'matrixType' = 'xml_attribute', 'errorValues' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValues' = 'xml_attribute', 'maxValues' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:table', slots = c('rows' = 'xml_attribute', 'columns' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:list', slots = c('type' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:link', slots = c('from' = 'xml_attribute', 'to' = 'xml_attribute', 'ref' = 'xml_attribute', 'role' = 'xml_attribute', 'href' = 'xml_attribute', 'type' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:action', slots = c('type' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:actionList', slots = c('type' = 'xml_attribute', 'order' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:object', slots = c('type' = 'xml_attribute', 'count' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:observation', slots = c('type' = 'xml_attribute', 'count' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:dictionary', slots = c('href' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:entry', slots = c('dataType' = 'xml_attribute', 'rows' = 'xml_attribute', 'columns' = 'xml_attribute', 'recommendedUnits' = 'xml_attribute', 'unitType' = 'xml_attribute', 'minExclusive' = 'xml_attribute', 'minInclusive' = 'xml_attribute', 'maxExclusive' = 'xml_attribute', 'maxInclusive' = 'xml_attribute', 'totalDigits' = 'xml_attribute', 'fractionDigits' = 'xml_attribute', 'length' = 'xml_attribute', 'minLength' = 'xml_attribute', 'maxLength' = 'xml_attribute', 'units' = 'xml_attribute', 'whiteSpace' = 'xml_attribute', 'pattern' = 'xml_attribute', 'term' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:enumeration', slots = c('value' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:alternative', slots = c('character' = 'character', 'type' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:relatedEntry', slots = c('type' = 'xml_attribute', 'href' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:annotation', slots = c('source' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:appinfo', slots = c('source' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:matrixType', contains = c('eml-2.1.1', 'character', 'stmml:namespaceRefType')) ## D
setClass('stmml:refType', contains = c('eml-2.1.1', 'stmml:idType', 'character')) ## D


setClass('stmml:description', slots = c('stmml:class' ='xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:dimension', slots = c('name' = 'xml_attribute', 'power' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('stmml:unitList', slots = c('href' = 'xml_attribute', 'unit' = 'ListOfstmml:unit', 'unitType' = 'ListOfstmml:unitType'), contains = c('eml-2.1.1')) ## A
setClass('stmml:unitType', slots = c('dimension' = 'ListOfstmml:dimension' , 'id' = 'xml_attribute', 'name' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A
setClass('stmml:unit', slots = c('description' = 'stmml:description', 'id' = 'xml_attribute', 'abbreviation' = 'xml_attribute', 'name' = 'xml_attribute', 'parentSI' = 'xml_attribute', 'unitType' = 'xml_attribute', 'multiplierToSI' = 'xml_attribute', 'constantToSI' = 'xml_attribute'), contains = c('eml-2.1.1', 'character')) ## A

setMethod(c, signature('stmml:unitType'), function(x, ..., recursive = FALSE) new('ListOfstmml:unitType', list(x, ...)))
setMethod(c, signature('stmml:unit'), function(x, ..., recursive = FALSE) new('ListOfstmml:unit', list(x, ...)))
setMethod(c, signature('stmml:dimension'), function(x, ..., recursive = FALSE) new('ListOfstmml:dimension', list(x, ...)))


setMethod(initialize, "stmml:unitList", function(.Object, href = character(), unitType = character(), unit = character()){
  slot(.Object, "href") <- as(href, "xml_attribute")
  slot(.Object, "unit") <- c_as(unit, "stmml:unit")
  slot(.Object, "unitType") <- c_as(unitType, "stmml:unitType")
  .Object
})
setMethod(initialize, "stmml:dimension", function(.Object, name = character(), power = character()){
  slot(.Object, "power") <- as(power, "xml_attribute")
  slot(.Object, "name") <- as(name, "xml_attribute")
  .Object
})
setMethod(initialize, "stmml:unitType", function(.Object, dimension = character(), id = character(), name = character()){
  slot(.Object, "id") <- as(id, "xml_attribute")
  slot(.Object, "name") <- as(name, "xml_attribute")
  slot(.Object, "dimension") <- c_as(dimension, "stmml:dimension")
  .Object
})
setMethod(initialize, "stmml:unit", function(.Object, description = character(), 
                                             id = character(), abbreviation = character(), 
                                             name = character(), parentSI = character(), 
                                             unitType = character(), multiplierToSI = character(), 
                                             constantToSI = character()){
  slot(.Object, "id") <- as(id, "xml_attribute")
  slot(.Object, "name") <- as(name, "xml_attribute")
  slot(.Object, "abbreviation") <- as(abbreviation, "xml_attribute")
  slot(.Object, "parentSI") <- as(parentSI, "xml_attribute")
  slot(.Object, "unitType") <- as(unitType, "xml_attribute")
  slot(.Object, "multiplierToSI") <- as(multiplierToSI, "xml_attribute")
  slot(.Object, "constantToSI") <- as(constantToSI, "xml_attribute")
  slot(.Object, "description") <- as(description, "stmml:description")
  .Object
})

