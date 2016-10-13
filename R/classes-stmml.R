#' @include classes.R


setClass('ListOfunitType', contains = 'list')
setClass('ListOfunit', contains = 'list')
setClass('ListOfdimension', contains = 'list')


setClass('appinfo', contains = c('eml-2.1.1', 'character'))
setClass('documentation', contains = c('eml-2.1.1', 'character'))
setClass(
  'annotation',
  slots = c('appinfo' = 'appinfo', 'documentation' = 'documentation'),
  contains = 'eml-2.1.1'
)

#setClass('description', slots = c('stmml:class' ='xml_attribute'), contains = c('TextType')) ## A

setClass(
  'dimension',
  slots = c('name' = 'xml_attribute', 'power' = 'xml_attribute'),
  contains = c('eml-2.1.1')
) ## A
setClass(
  'unitList',
  slots = c(
    'href' = 'xml_attribute',
    'unit' = 'ListOfunit',
    'unitType' = 'ListOfunitType'
  ),
  contains = c('eml-2.1.1')
) ## A
setClass(
  'unitType',
  slots = c(
    'dimension' = 'ListOfdimension' ,
    'id' = 'xml_attribute',
    'name' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A

# overloaded, inherits UnitType from EML version of unit
setClass(
  'unit',
  slots = c(
    'description' = 'description',
    'annotation' = 'annotation',
    'id' = 'xml_attribute',
    'abbreviation' = 'xml_attribute',
    'name' = 'xml_attribute',
    'parentSI' = 'xml_attribute',
    'unitType' = 'xml_attribute',
    'multiplierToSI' = 'xml_attribute',
    'constantToSI' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'UnitType')
) ## A

setMethod(c, signature('unitType'), function(x, ..., recursive = FALSE)
  new('ListOfunitType', list(x, ...)))
setMethod(c, signature('unit'), function(x, ..., recursive = FALSE)
  new('ListOfunit', list(x, ...)))
setMethod(c, signature('dimension'), function(x, ..., recursive = FALSE)
  new('ListOfdimension', list(x, ...)))


setMethod(initialize, 'unitList', function(.Object,
                                           href = character(),
                                           unitType = character(),
                                           unit = character(),
                                           slot_order = c("unitType", "unit")) {
  slot(.Object, 'href') <- as(href, 'xml_attribute')
  slot(.Object, 'unit') <- c_as(unit, 'unit')
  slot(.Object, 'unitType') <- c_as(unitType, 'unitType')
  slot(.Object, 'slot_order') <- slot_order
  .Object
})
setMethod(initialize, 'dimension', function(.Object,
                                            name = character(),
                                            power = character()) {
  slot(.Object, 'power') <- as(power, 'xml_attribute')
  slot(.Object, 'name') <- as(name, 'xml_attribute')
  .Object
})
setMethod(initialize, 'unitType', function(.Object,
                                           dimension = character(),
                                           id = character(),
                                           name = character()) {
  slot(.Object, 'id') <- as(id, 'xml_attribute')
  slot(.Object, 'name') <- as(name, 'xml_attribute')
  slot(.Object, 'dimension') <- c_as(dimension, 'dimension')
  .Object
})
setMethod(initialize, 'unit', function(.Object,
                                       description = character(),
                                       id = character(),
                                       abbreviation = character(),
                                       name = character(),
                                       parentSI = character(),
                                       unitType = character(),
                                       multiplierToSI = character(),
                                       constantToSI = character(),
                                       standardUnit = character(),
                                       customUnit = character()) {
  slot(.Object, 'id') <- as(id, 'xml_attribute')
  slot(.Object, 'name') <- as(name, 'xml_attribute')
  slot(.Object, 'abbreviation') <- as(abbreviation, 'xml_attribute')
  slot(.Object, 'parentSI') <- as(parentSI, 'xml_attribute')
  slot(.Object, 'unitType') <- as(unitType, 'xml_attribute')
  slot(.Object, 'multiplierToSI') <-
    as(multiplierToSI, 'xml_attribute')
  slot(.Object, 'constantToSI') <- as(constantToSI, 'xml_attribute')
  slot(.Object, 'description') <- as(description, 'description')
  slot(.Object, 'standardUnit') <-
    as(standardUnit, 'StandardUnitDictionary')
  slot(.Object, 'customUnit') <- as(customUnit, 'character')
  
  .Object
})


setMethod(initialize, 'description', function(.Object,
                                              .Data = character(),
                                              section = character(),
                                              para = character(),
                                              lang = new('xml_attribute'),
                                              schemaLocation = new('xml_attribute'),
                                              slot_order = new('character')) {
  slot(.Object, 'lang') <- as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'para') <- c_as(para, 'para')
  slot(.Object, 'section') <- c_as(section, 'section')
  slot(.Object, '.Data') <- .Data
  .Object
})
