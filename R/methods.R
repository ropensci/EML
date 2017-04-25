setOldClass("xml_node")


#####  inst/xsd/eml-text.xsd  ####


setAs('text', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'text',  function(from)
  emlToS4(from))
setAs('section', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'section',  function(from)
  emlToS4(from))

setMethod(c, signature('section'), function(x, ..., recursive = FALSE)
  new('ListOfsection', list(x, ...)))
setAs('para', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'para',  function(from)
  emlToS4(from))

setMethod(c, signature('para'), function(x, ..., recursive = FALSE)
  new('ListOfpara', list(x, ...)))
setMethod(initialize, 'TextType', function(.Object,
                                           section = character(),
                                           para = character(),
                                           .Data = new('character'),
                                           lang = new('xml_attribute'),
                                           schemaLocation = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'section') <-
    c_as(section, 'section')
  slot(.Object, 'para') <-
    c_as(para, 'para')
  .Object@.Data <-
    .Data
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('TextType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'TextType',  function(from)
  emlToS4(from))
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setAs('itemizedlist', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'itemizedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('itemizedlist'), function(x, ..., recursive = FALSE)
  new('ListOfitemizedlist', list(x, ...)))
setAs('orderedlist', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'orderedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('orderedlist'), function(x, ..., recursive = FALSE)
  new('ListOforderedlist', list(x, ...)))
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setMethod(initialize, 'emphasis', function(.Object,
                                           value = character(),
                                           .Data = new('character'),
                                           lang = new('xml_attribute'),
                                           schemaLocation = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'value') <-
    c_as(value, 'value')
  .Object@.Data <-
    .Data
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('emphasis', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'emphasis',  function(from)
  emlToS4(from))

setMethod(c, signature('emphasis'), function(x, ..., recursive = FALSE)
  new('ListOfemphasis', list(x, ...)))
setAs('subscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'subscript',  function(from)
  emlToS4(from))

setMethod(c, signature('subscript'), function(x, ..., recursive = FALSE)
  new('ListOfsubscript', list(x, ...)))
setAs('superscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'superscript',  function(from)
  emlToS4(from))

setMethod(c, signature('superscript'), function(x, ..., recursive = FALSE)
  new('ListOfsuperscript', list(x, ...)))
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setMethod(initialize, 'literalLayout', function(.Object,
                                                value = character(),
                                                .Data = new('character'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'value') <-
    c_as(value, 'value')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('literalLayout', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'literalLayout',  function(from)
  emlToS4(from))

setMethod(c, signature('literalLayout'), function(x, ..., recursive = FALSE)
  new('ListOfliteralLayout', list(x, ...)))
setAs('citetitle', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citetitle',  function(from)
  emlToS4(from))

setMethod(c, signature('citetitle'), function(x, ..., recursive = FALSE)
  new('ListOfcitetitle', list(x, ...)))
setMethod(initialize, 'ulink', function(.Object,
                                        citetitle = character(),
                                        .Data = new('character'),
                                        url = new('xml_attribute'),
                                        schemaLocation = new('xml_attribute'),
                                        lang = new('xml_attribute'),
                                        slot_order = new('character')) {

  slot(.Object, 'citetitle') <-
    c_as(citetitle, 'citetitle')
  .Object@.Data <-
    .Data
  slot(.Object, 'url') <-
    as(url, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ulink', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ulink',  function(from)
  emlToS4(from))

setMethod(c, signature('ulink'), function(x, ..., recursive = FALSE)
  new('ListOfulink', list(x, ...)))

setAs('ParagraphType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ParagraphType',  function(from)
  emlToS4(from))
setAs('title', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'title',  function(from)
  emlToS4(from))
setAs('para', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'para',  function(from)
  emlToS4(from))

setMethod(c, signature('para'), function(x, ..., recursive = FALSE)
  new('ListOfpara', list(x, ...)))
setAs('section', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'section',  function(from)
  emlToS4(from))

setMethod(c, signature('section'), function(x, ..., recursive = FALSE)
  new('ListOfsection', list(x, ...)))

setAs('SectionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SectionType',  function(from)
  emlToS4(from))
setAs('para', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'para',  function(from)
  emlToS4(from))

setMethod(c, signature('para'), function(x, ..., recursive = FALSE)
  new('ListOfpara', list(x, ...)))
setAs('itemizedlist', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'itemizedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('itemizedlist'), function(x, ..., recursive = FALSE)
  new('ListOfitemizedlist', list(x, ...)))
setAs('orderedlist', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'orderedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('orderedlist'), function(x, ..., recursive = FALSE)
  new('ListOforderedlist', list(x, ...)))
setMethod(initialize, 'listitem', function(.Object,
                                           para = character(),
                                           itemizedlist = character(),
                                           orderedlist = character(),
                                           .Data = new('character'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'para') <-
    c_as(para, 'para')
  slot(.Object, 'itemizedlist') <-
    c_as(itemizedlist, 'itemizedlist')
  slot(.Object, 'orderedlist') <-
    c_as(orderedlist, 'orderedlist')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('listitem', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'listitem',  function(from)
  emlToS4(from))

setMethod(c, signature('listitem'), function(x, ..., recursive = FALSE)
  new('ListOflistitem', list(x, ...)))
setMethod(initialize, 'ListType', function(.Object,
                                           listitem = character(),
                                           .Data = new('character'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'listitem') <-
    c_as(listitem, 'listitem')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ListType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ListType',  function(from)
  emlToS4(from))
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setAs('subscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'subscript',  function(from)
  emlToS4(from))

setMethod(c, signature('subscript'), function(x, ..., recursive = FALSE)
  new('ListOfsubscript', list(x, ...)))
setAs('superscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'superscript',  function(from)
  emlToS4(from))

setMethod(c, signature('superscript'), function(x, ..., recursive = FALSE)
  new('ListOfsuperscript', list(x, ...)))
setMethod(initialize, 'SubSuperScriptType', function(.Object,
                                                     value = character(),
                                                     subscript = character(),
                                                     superscript = character(),
                                                     .Data = new('character'),
                                                     lang = new('xml_attribute'),
                                                     schemaLocation = new('xml_attribute'),
                                                     slot_order = new('character')) {

  slot(.Object, 'value') <-
    c_as(value, 'value')
  slot(.Object, 'subscript') <-
    c_as(subscript, 'subscript')
  slot(.Object, 'superscript') <-
    c_as(superscript, 'superscript')
  .Object@.Data <-
    .Data
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SubSuperScriptType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SubSuperScriptType',  function(from)
  emlToS4(from))
setMethod(initialize, 'i18nString', function(.Object,
                                             .Data = new('character'),
                                             lang = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('i18nString', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'i18nString',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-documentation.xsd  ####


setAs('moduleName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'moduleName',  function(from)
  emlToS4(from))
setAs('moduleDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'moduleDescription',  function(from)
  emlToS4(from))
setAs('recommendedUsage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'recommendedUsage',  function(from)
  emlToS4(from))
setAs('standAlone', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'standAlone',  function(from)
  emlToS4(from))
setMethod(initialize, 'moduleDocs', function(.Object,
                                             .Data = new('character'),
                                             moduleName = new('character'),
                                             moduleDescription = new('TextType'),
                                             recommendedUsage = new('character'),
                                             standAlone = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'moduleName') <-
    as(moduleName, 'moduleName')
  slot(.Object, 'moduleDescription') <-
    as(moduleDescription, 'moduleDescription')
  slot(.Object, 'recommendedUsage') <-
    as(recommendedUsage, 'recommendedUsage')
  slot(.Object, 'standAlone') <-
    as(standAlone, 'standAlone')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('moduleDocs', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'moduleDocs',  function(from)
  emlToS4(from))
setAs('tooltip', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'tooltip',  function(from)
  emlToS4(from))
setAs('summary', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'summary',  function(from)
  emlToS4(from))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))
setAs('example', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'example',  function(from)
  emlToS4(from))
setAs('lineage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lineage',  function(from)
  emlToS4(from))
setAs('module', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'module',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-unitTypeDefinitions.xsd  ####


setAs('StandardUnitDictionary', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'StandardUnitDictionary',  function(from)
  emlToS4(from))
setAs('LengthUnitType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'LengthUnitType',  function(from)
  emlToS4(from))
setAs('MassUnitType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'MassUnitType',  function(from)
  emlToS4(from))
setAs('otherUnitType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'otherUnitType',  function(from)
  emlToS4(from))
setAs('angleUnitType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'angleUnitType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-party.xsd  ####


setAs('individualName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'individualName',  function(from)
  emlToS4(from))

setMethod(c, signature('individualName'), function(x, ..., recursive = FALSE)
  new('ListOfindividualName', list(x, ...)))
setAs('organizationName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'organizationName',  function(from)
  emlToS4(from))

setMethod(c, signature('organizationName'), function(x, ..., recursive = FALSE)
  new('ListOforganizationName', list(x, ...)))
setAs('positionName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'positionName',  function(from)
  emlToS4(from))

setMethod(c, signature('positionName'), function(x, ..., recursive = FALSE)
  new('ListOfpositionName', list(x, ...)))
setAs('address', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'address',  function(from)
  emlToS4(from))

setMethod(c, signature('address'), function(x, ..., recursive = FALSE)
  new('ListOfaddress', list(x, ...)))
setMethod(initialize, 'phone', function(.Object,
                                        .Data = new('character'),
                                        character = new('character'),
                                        phonetype = new('xml_attribute'),
                                        schemaLocation = new('xml_attribute'),
                                        lang = new('xml_attribute'),
                                        slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'phonetype') <-
    as(phonetype, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('phone', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'phone',  function(from)
  emlToS4(from))

setMethod(c, signature('phone'), function(x, ..., recursive = FALSE)
  new('ListOfphone', list(x, ...)))
setAs('electronicMailAddress', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'electronicMailAddress',  function(from)
  emlToS4(from))

setMethod(c, signature('electronicMailAddress'), function(x, ..., recursive = FALSE)
  new('ListOfelectronicMailAddress', list(x, ...)))
setAs('onlineUrl', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'onlineUrl',  function(from)
  emlToS4(from))

setMethod(c, signature('onlineUrl'), function(x, ..., recursive = FALSE)
  new('ListOfonlineUrl', list(x, ...)))
setMethod(initialize, 'userId', function(.Object,
                                         .Data = new('character'),
                                         character = new('character'),
                                         directory = new('xml_attribute'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'directory') <-
    as(directory, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('userId', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'userId',  function(from)
  emlToS4(from))

setMethod(c, signature('userId'), function(x, ..., recursive = FALSE)
  new('ListOfuserId', list(x, ...)))
setMethod(initialize, 'ResponsibleParty', function(.Object,
                                                   individualName = character(),
                                                   organizationName = character(),
                                                   positionName = character(),
                                                   address = character(),
                                                   phone = character(),
                                                   electronicMailAddress = character(),
                                                   onlineUrl = character(),
                                                   userId = character(),
                                                   .Data = new('character'),
                                                   references = new('references'),
                                                   id = new('xml_attribute'),
                                                   system = new('xml_attribute'),
                                                   scope = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'individualName') <-
    c_as(individualName, 'individualName')
  slot(.Object, 'organizationName') <-
    c_as(organizationName, 'organizationName')
  slot(.Object, 'positionName') <-
    c_as(positionName, 'positionName')
  slot(.Object, 'address') <-
    c_as(address, 'address')
  slot(.Object, 'phone') <-
    c_as(phone, 'phone')
  slot(.Object, 'electronicMailAddress') <-
    c_as(electronicMailAddress, 'electronicMailAddress')
  slot(.Object, 'onlineUrl') <-
    c_as(onlineUrl, 'onlineUrl')
  slot(.Object, 'userId') <-
    c_as(userId, 'userId')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ResponsibleParty', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ResponsibleParty',  function(from)
  emlToS4(from))
setAs('salutation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'salutation',  function(from)
  emlToS4(from))

setMethod(c, signature('salutation'), function(x, ..., recursive = FALSE)
  new('ListOfsalutation', list(x, ...)))
setAs('givenName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'givenName',  function(from)
  emlToS4(from))

setMethod(c, signature('givenName'), function(x, ..., recursive = FALSE)
  new('ListOfgivenName', list(x, ...)))
setAs('surName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'surName',  function(from)
  emlToS4(from))
setMethod(initialize, 'Person', function(.Object,
                                         salutation = character(),
                                         givenName = character(),
                                         .Data = new('character'),
                                         surName = new('surName'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  slot(.Object, 'salutation') <-
    c_as(salutation, 'salutation')
  slot(.Object, 'givenName') <-
    c_as(givenName, 'givenName')
  .Object@.Data <-
    .Data
  slot(.Object, 'surName') <-
    as(surName, 'surName')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Person', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Person',  function(from)
  emlToS4(from))
setAs('deliveryPoint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'deliveryPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('deliveryPoint'), function(x, ..., recursive = FALSE)
  new('ListOfdeliveryPoint', list(x, ...)))
setAs('city', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'city',  function(from)
  emlToS4(from))
setAs('administrativeArea', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'administrativeArea',  function(from)
  emlToS4(from))
setAs('postalCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'postalCode',  function(from)
  emlToS4(from))
setAs('country', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'country',  function(from)
  emlToS4(from))
setMethod(initialize, 'Address', function(.Object,
                                          deliveryPoint = character(),
                                          .Data = new('character'),
                                          city = new('city'),
                                          administrativeArea = new('administrativeArea'),
                                          postalCode = new('postalCode'),
                                          country = new('country'),
                                          references = new('references'),
                                          id = new('xml_attribute'),
                                          system = new('xml_attribute'),
                                          scope = new('xml_attribute'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  slot(.Object, 'deliveryPoint') <-
    c_as(deliveryPoint, 'deliveryPoint')
  .Object@.Data <-
    .Data
  slot(.Object, 'city') <-
    as(city, 'city')
  slot(.Object, 'administrativeArea') <-
    as(administrativeArea, 'administrativeArea')
  slot(.Object, 'postalCode') <-
    as(postalCode, 'postalCode')
  slot(.Object, 'country') <-
    as(country, 'country')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Address', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Address',  function(from)
  emlToS4(from))
setAs('party', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'party',  function(from)
  emlToS4(from))
setAs('RoleType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'RoleType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-resource.xsd  ####


setMethod(initialize, 'alternateIdentifier', function(.Object,
                                                      .Data = new('character'),
                                                      character = new('character'),
                                                      system = new('xml_attribute'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('alternateIdentifier', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'alternateIdentifier',  function(from)
  emlToS4(from))

setMethod(c, signature('alternateIdentifier'), function(x, ..., recursive = FALSE)
  new('ListOfalternateIdentifier', list(x, ...)))
setAs('shortName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'shortName',  function(from)
  emlToS4(from))
setAs('title', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'title',  function(from)
  emlToS4(from))

setMethod(c, signature('title'), function(x, ..., recursive = FALSE)
  new('ListOftitle', list(x, ...)))
setAs('creator', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'creator',  function(from)
  emlToS4(from))

setMethod(c, signature('creator'), function(x, ..., recursive = FALSE)
  new('ListOfcreator', list(x, ...)))
setAs('metadataProvider', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'metadataProvider',  function(from)
  emlToS4(from))

setMethod(c, signature('metadataProvider'), function(x, ..., recursive = FALSE)
  new('ListOfmetadataProvider', list(x, ...)))
setAs('role', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'role',  function(from)
  emlToS4(from))
setMethod(initialize, 'associatedParty', function(.Object,
                                                  individualName = character(),
                                                  organizationName = character(),
                                                  positionName = character(),
                                                  address = character(),
                                                  phone = character(),
                                                  electronicMailAddress = character(),
                                                  onlineUrl = character(),
                                                  userId = character(),
                                                  .Data = new('character'),
                                                  references = new('references'),
                                                  id = new('xml_attribute'),
                                                  system = new('xml_attribute'),
                                                  scope = new('xml_attribute'),
                                                  role = new('RoleType'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'individualName') <-
    c_as(individualName, 'individualName')
  slot(.Object, 'organizationName') <-
    c_as(organizationName, 'organizationName')
  slot(.Object, 'positionName') <-
    c_as(positionName, 'positionName')
  slot(.Object, 'address') <-
    c_as(address, 'address')
  slot(.Object, 'phone') <-
    c_as(phone, 'phone')
  slot(.Object, 'electronicMailAddress') <-
    c_as(electronicMailAddress, 'electronicMailAddress')
  slot(.Object, 'onlineUrl') <-
    c_as(onlineUrl, 'onlineUrl')
  slot(.Object, 'userId') <-
    c_as(userId, 'userId')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'role') <-
    as(role, 'role')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('associatedParty', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'associatedParty',  function(from)
  emlToS4(from))

setMethod(c, signature('associatedParty'), function(x, ..., recursive = FALSE)
  new('ListOfassociatedParty', list(x, ...)))
setAs('pubDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pubDate',  function(from)
  emlToS4(from))
setAs('language', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'language',  function(from)
  emlToS4(from))
setAs('series', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'series',  function(from)
  emlToS4(from))
setAs('abstract', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'abstract',  function(from)
  emlToS4(from))

setAs('keyword', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'keyword',  function(from)
  emlToS4(from))

setMethod(c, signature('keyword'), function(x, ..., recursive = FALSE)
  new('ListOfkeyword', list(x, ...)))
setAs('keywordThesaurus', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'keywordThesaurus',  function(from)
  emlToS4(from))
setMethod(initialize, 'keywordSet', function(.Object,
                                             keyword = character(),
                                             .Data = new('character'),
                                             keywordThesaurus = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'keyword') <-
    c_as(keyword, 'keyword')
  .Object@.Data <-
    .Data
  slot(.Object, 'keywordThesaurus') <-
    as(keywordThesaurus, 'keywordThesaurus')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('keywordSet', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'keywordSet',  function(from)
  emlToS4(from))

setMethod(c, signature('keywordSet'), function(x, ..., recursive = FALSE)
  new('ListOfkeywordSet', list(x, ...)))
setAs('additionalInfo', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'additionalInfo',  function(from)
  emlToS4(from))

setMethod(c, signature('additionalInfo'), function(x, ..., recursive = FALSE)
  new('ListOfadditionalInfo', list(x, ...)))
setAs('intellectualRights', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'intellectualRights',  function(from)
  emlToS4(from))
setAs('distribution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'distribution',  function(from)
  emlToS4(from))

setMethod(c, signature('distribution'), function(x, ..., recursive = FALSE)
  new('ListOfdistribution', list(x, ...)))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))
setMethod(initialize, 'ResourceGroup', function(.Object,
                                                alternateIdentifier = character(),
                                                title = character(),
                                                creator = character(),
                                                metadataProvider = character(),
                                                associatedParty = character(),
                                                keywordSet = character(),
                                                additionalInfo = character(),
                                                distribution = character(),
                                                .Data = new('character'),
                                                shortName = new('character'),
                                                pubDate = new('yearDate'),
                                                language = new('character'),
                                                series = new('character'),
                                                abstract = new('TextType'),
                                                intellectualRights = new('TextType'),
                                                coverage = new('Coverage'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'creator') <-
    c_as(creator, 'creator')
  slot(.Object, 'metadataProvider') <-
    c_as(metadataProvider, 'metadataProvider')
  slot(.Object, 'associatedParty') <-
    c_as(associatedParty, 'associatedParty')
  slot(.Object, 'keywordSet') <-
    c_as(keywordSet, 'keywordSet')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  .Object@.Data <-
    .Data
  slot(.Object, 'shortName') <-
    as(shortName, 'shortName')
  slot(.Object, 'pubDate') <-
    as(pubDate, 'pubDate')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'series') <-
    as(series, 'series')
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'intellectualRights') <-
    as(intellectualRights, 'intellectualRights')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ResourceGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ResourceGroup',  function(from)
  emlToS4(from))
setMethod(initialize, 'references', function(.Object,
                                             .Data = new('character'),
                                             character = new('character'),
                                             system = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('references', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'references',  function(from)
  emlToS4(from))
setMethod(initialize, 'ReferencesGroup', function(.Object,
                                                  .Data = new('character'),
                                                  references = new('references'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ReferencesGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ReferencesGroup',  function(from)
  emlToS4(from))
setAs('KeyTypeCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'KeyTypeCode',  function(from)
  emlToS4(from))
setAs('yearDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'yearDate',  function(from)
  emlToS4(from))
setAs('IDType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'IDType',  function(from)
  emlToS4(from))
setAs('SystemType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SystemType',  function(from)
  emlToS4(from))
setAs('ScopeType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ScopeType',  function(from)
  emlToS4(from))
setAs('FunctionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'FunctionType',  function(from)
  emlToS4(from))
setAs('online', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'online',  function(from)
  emlToS4(from))
setAs('offline', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'offline',  function(from)
  emlToS4(from))
setAs('inline', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'inline',  function(from)
  emlToS4(from))
setMethod(initialize, 'DistributionType', function(.Object,
                                                   .Data = new('character'),
                                                   online = new('OnlineType'),
                                                   offline = new('OfflineType'),
                                                   inline = new('InlineType'),
                                                   references = new('references'),
                                                   id = new('xml_attribute'),
                                                   system = new('xml_attribute'),
                                                   scope = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'online') <-
    as(online, 'online')
  slot(.Object, 'offline') <-
    as(offline, 'offline')
  slot(.Object, 'inline') <-
    as(inline, 'inline')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DistributionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DistributionType',  function(from)
  emlToS4(from))
setMethod(initialize, 'schemeName', function(.Object,
                                             .Data = new('character'),
                                             character = new('character'),
                                             system = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('schemeName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'schemeName',  function(from)
  emlToS4(from))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))
setAs('name', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'name',  function(from)
  emlToS4(from))
setAs('definition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'definition',  function(from)
  emlToS4(from))
setAs('defaultValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'defaultValue',  function(from)
  emlToS4(from))

setAs('parameterDefinition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'parameterDefinition',  function(from)
  emlToS4(from))

setMethod(c, signature('parameterDefinition'), function(x, ..., recursive = FALSE)
  new('ListOfparameterDefinition', list(x, ...)))
setMethod(initialize, 'ConnectionDefinitionType', function(.Object,
                                                           parameterDefinition = character(),
                                                           .Data = new('character'),
                                                           schemeName = new('schemeName'),
                                                           description = new('TextType'),
                                                           references = new('references'),
                                                           id = new('xml_attribute'),
                                                           system = new('xml_attribute'),
                                                           scope = new('xml_attribute'),
                                                           schemaLocation = new('xml_attribute'),
                                                           lang = new('xml_attribute'),
                                                           slot_order = new('character')) {

  slot(.Object, 'parameterDefinition') <-
    c_as(parameterDefinition, 'parameterDefinition')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemeName') <-
    as(schemeName, 'schemeName')
  slot(.Object, 'description') <-
    as(description, 'description')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ConnectionDefinitionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ConnectionDefinitionType',  function(from)
  emlToS4(from))
setAs('InlineType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'InlineType',  function(from)
  emlToS4(from))
setAs('mediumName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumName',  function(from)
  emlToS4(from))
setAs('mediumDensity', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumDensity',  function(from)
  emlToS4(from))
setAs('mediumDensityUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumDensityUnits',  function(from)
  emlToS4(from))
setAs('mediumVolume', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumVolume',  function(from)
  emlToS4(from))
setAs('mediumFormat', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumFormat',  function(from)
  emlToS4(from))

setMethod(c, signature('mediumFormat'), function(x, ..., recursive = FALSE)
  new('ListOfmediumFormat', list(x, ...)))
setAs('mediumNote', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'mediumNote',  function(from)
  emlToS4(from))
setMethod(initialize, 'OfflineType', function(.Object,
                                              mediumFormat = character(),
                                              .Data = new('character'),
                                              mediumName = new('character'),
                                              mediumDensity = new('character'),
                                              mediumDensityUnits = new('character'),
                                              mediumVolume = new('character'),
                                              mediumNote = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'mediumFormat') <-
    c_as(mediumFormat, 'mediumFormat')
  .Object@.Data <-
    .Data
  slot(.Object, 'mediumName') <-
    as(mediumName, 'mediumName')
  slot(.Object, 'mediumDensity') <-
    as(mediumDensity, 'mediumDensity')
  slot(.Object, 'mediumDensityUnits') <-
    as(mediumDensityUnits, 'mediumDensityUnits')
  slot(.Object, 'mediumVolume') <-
    as(mediumVolume, 'mediumVolume')
  slot(.Object, 'mediumNote') <-
    as(mediumNote, 'mediumNote')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('OfflineType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'OfflineType',  function(from)
  emlToS4(from))
setAs('onlineDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'onlineDescription',  function(from)
  emlToS4(from))
setAs('url', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'url',  function(from)
  emlToS4(from))
setAs('connection', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'connection',  function(from)
  emlToS4(from))
setAs('connectionDefinition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'connectionDefinition',  function(from)
  emlToS4(from))
setMethod(initialize, 'OnlineType', function(.Object,
                                             .Data = new('character'),
                                             onlineDescription = new('onlineDescription'),
                                             url = new('UrlType'),
                                             connection = new('ConnectionType'),
                                             connectionDefinition = new('ConnectionDefinitionType'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'onlineDescription') <-
    as(onlineDescription, 'onlineDescription')
  slot(.Object, 'url') <-
    as(url, 'url')
  slot(.Object, 'connection') <-
    as(connection, 'connection')
  slot(.Object, 'connectionDefinition') <-
    as(connectionDefinition, 'connectionDefinition')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('OnlineType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'OnlineType',  function(from)
  emlToS4(from))

setAs('UrlType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'UrlType',  function(from)
  emlToS4(from))
setAs('connectionDefinition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'connectionDefinition',  function(from)
  emlToS4(from))
setAs('name', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'name',  function(from)
  emlToS4(from))
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setAs('parameter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'parameter',  function(from)
  emlToS4(from))

setMethod(c, signature('parameter'), function(x, ..., recursive = FALSE)
  new('ListOfparameter', list(x, ...)))
setMethod(initialize, 'ConnectionType', function(.Object,
                                                 parameter = character(),
                                                 .Data = new('character'),
                                                 connectionDefinition = new('ConnectionDefinitionType'),
                                                 references = new('references'),
                                                 id = new('xml_attribute'),
                                                 system = new('xml_attribute'),
                                                 scope = new('xml_attribute'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  slot(.Object, 'parameter') <-
    c_as(parameter, 'parameter')
  .Object@.Data <-
    .Data
  slot(.Object, 'connectionDefinition') <-
    as(connectionDefinition, 'connectionDefinition')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ConnectionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ConnectionType',  function(from)
  emlToS4(from))
setAs('NonEmptyStringType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'NonEmptyStringType',  function(from)
  emlToS4(from))
setMethod(initialize, 'value', function(.Object,
                                        .Data = new('character'),
                                        character = new('character'),
                                        lang = new('xml_attribute'),
                                        schemaLocation = new('xml_attribute'),
                                        slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('value', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setMethod(initialize, 'i18nNonEmptyStringType', function(.Object,
                                                         value = character(),
                                                         .Data = new('character'),
                                                         lang = new('xml_attribute'),
                                                         schemaLocation = new('xml_attribute'),
                                                         slot_order = new('character')) {

  slot(.Object, 'value') <-
    c_as(value, 'value')
  .Object@.Data <-
    .Data
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('i18nNonEmptyStringType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'i18nNonEmptyStringType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialReference.xsd  ####


setAs('horizCoordSysName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizCoordSysName',  function(from)
  emlToS4(from))
setAs('horizCoordSysDef', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizCoordSysDef',  function(from)
  emlToS4(from))
setAs('altitudeDatumName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeDatumName',  function(from)
  emlToS4(from))
setAs('altitudeResolution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeResolution',  function(from)
  emlToS4(from))

setMethod(c, signature('altitudeResolution'), function(x, ..., recursive = FALSE)
  new('ListOfaltitudeResolution', list(x, ...)))
setAs('altitudeDistanceUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeDistanceUnits',  function(from)
  emlToS4(from))
setAs('altitudeEncodingMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeEncodingMethod',  function(from)
  emlToS4(from))
setMethod(initialize, 'altitudeSysDef', function(.Object,
                                                 altitudeResolution = character(),
                                                 .Data = new('character'),
                                                 altitudeDatumName = new('character'),
                                                 altitudeDistanceUnits = new('character'),
                                                 altitudeEncodingMethod = new('character'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  slot(.Object, 'altitudeResolution') <-
    c_as(altitudeResolution, 'altitudeResolution')
  .Object@.Data <-
    .Data
  slot(.Object, 'altitudeDatumName') <-
    as(altitudeDatumName, 'altitudeDatumName')
  slot(.Object, 'altitudeDistanceUnits') <-
    as(altitudeDistanceUnits, 'altitudeDistanceUnits')
  slot(.Object, 'altitudeEncodingMethod') <-
    as(altitudeEncodingMethod, 'altitudeEncodingMethod')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('altitudeSysDef', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeSysDef',  function(from)
  emlToS4(from))
setAs('depthDatumName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'depthDatumName',  function(from)
  emlToS4(from))
setAs('depthResolution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'depthResolution',  function(from)
  emlToS4(from))

setMethod(c, signature('depthResolution'), function(x, ..., recursive = FALSE)
  new('ListOfdepthResolution', list(x, ...)))
setAs('depthDistanceUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'depthDistanceUnits',  function(from)
  emlToS4(from))
setAs('depthEncodingMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'depthEncodingMethod',  function(from)
  emlToS4(from))
setMethod(initialize, 'depthSysDef', function(.Object,
                                              depthResolution = character(),
                                              .Data = new('character'),
                                              depthDatumName = new('character'),
                                              depthDistanceUnits = new('character'),
                                              depthEncodingMethod = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'depthResolution') <-
    c_as(depthResolution, 'depthResolution')
  .Object@.Data <-
    .Data
  slot(.Object, 'depthDatumName') <-
    as(depthDatumName, 'depthDatumName')
  slot(.Object, 'depthDistanceUnits') <-
    as(depthDistanceUnits, 'depthDistanceUnits')
  slot(.Object, 'depthEncodingMethod') <-
    as(depthEncodingMethod, 'depthEncodingMethod')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('depthSysDef', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'depthSysDef',  function(from)
  emlToS4(from))
setMethod(initialize, 'vertCoordSys', function(.Object,
                                               .Data = new('character'),
                                               altitudeSysDef = new('altitudeSysDef'),
                                               depthSysDef = new('depthSysDef'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'altitudeSysDef') <-
    as(altitudeSysDef, 'altitudeSysDef')
  slot(.Object, 'depthSysDef') <-
    as(depthSysDef, 'depthSysDef')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('vertCoordSys', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'vertCoordSys',  function(from)
  emlToS4(from))
setMethod(initialize, 'SpatialReferenceType', function(.Object,
                                                       .Data = new('character'),
                                                       horizCoordSysName = new('horizCoordSysName'),
                                                       horizCoordSysDef = new('horizCoordSysType'),
                                                       vertCoordSys = new('vertCoordSys'),
                                                       references = new('references'),
                                                       id = new('xml_attribute'),
                                                       system = new('xml_attribute'),
                                                       scope = new('xml_attribute'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'horizCoordSysName') <-
    as(horizCoordSysName, 'horizCoordSysName')
  slot(.Object, 'horizCoordSysDef') <-
    as(horizCoordSysDef, 'horizCoordSysDef')
  slot(.Object, 'vertCoordSys') <-
    as(vertCoordSys, 'vertCoordSys')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SpatialReferenceType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SpatialReferenceType',  function(from)
  emlToS4(from))
setMethod(initialize, 'datum', function(.Object,
                                        .Data = new('character'),
                                        name = new('xml_attribute'),
                                        schemaLocation = new('xml_attribute'),
                                        lang = new('xml_attribute'),
                                        slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('datum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'datum',  function(from)
  emlToS4(from))
setMethod(initialize, 'spheroid', function(.Object,
                                           .Data = new('character'),
                                           name = new('xml_attribute'),
                                           semiAxisMajor = new('xml_attribute'),
                                           denomFlatRatio = new('xml_attribute'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'semiAxisMajor') <-
    as(semiAxisMajor, 'xml_attribute')
  slot(.Object, 'denomFlatRatio') <-
    as(denomFlatRatio, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('spheroid', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spheroid',  function(from)
  emlToS4(from))
setMethod(initialize, 'primeMeridian', function(.Object,
                                                .Data = new('character'),
                                                name = new('xml_attribute'),
                                                longitude = new('xml_attribute'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'longitude') <-
    as(longitude, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('primeMeridian', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'primeMeridian',  function(from)
  emlToS4(from))

setAs('unit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'unit',  function(from)
  emlToS4(from))
setMethod(initialize, 'geogCoordSysType', function(.Object,
                                                   .Data = new('character'),
                                                   datum = new('datum'),
                                                   spheroid = new('spheroid'),
                                                   primeMeridian = new('primeMeridian'),
                                                   unit = new('unit'),
                                                   name = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'datum') <-
    as(datum, 'datum')
  slot(.Object, 'spheroid') <-
    as(spheroid, 'spheroid')
  slot(.Object, 'primeMeridian') <-
    as(primeMeridian, 'primeMeridian')
  slot(.Object, 'unit') <-
    as(unit, 'unit')
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('geogCoordSysType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geogCoordSysType',  function(from)
  emlToS4(from))
setAs('geogCoordSys', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geogCoordSys',  function(from)
  emlToS4(from))
setAs('geogCoordSys', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geogCoordSys',  function(from)
  emlToS4(from))

setAs('parameter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'parameter',  function(from)
  emlToS4(from))

setMethod(c, signature('parameter'), function(x, ..., recursive = FALSE)
  new('ListOfparameter', list(x, ...)))

setAs('unit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'unit',  function(from)
  emlToS4(from))
setMethod(initialize, 'projection', function(.Object,
                                             parameter = character(),
                                             .Data = new('character'),
                                             unit = new('unit'),
                                             name = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'parameter') <-
    c_as(parameter, 'parameter')
  .Object@.Data <-
    .Data
  slot(.Object, 'unit') <-
    as(unit, 'unit')
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('projection', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'projection',  function(from)
  emlToS4(from))
setMethod(initialize, 'projCoordSys', function(.Object,
                                               .Data = new('character'),
                                               geogCoordSys = new('geogCoordSysType'),
                                               projection = new('projection'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'geogCoordSys') <-
    as(geogCoordSys, 'geogCoordSys')
  slot(.Object, 'projection') <-
    as(projection, 'projection')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('projCoordSys', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'projCoordSys',  function(from)
  emlToS4(from))
setMethod(initialize, 'horizCoordSysType', function(.Object,
                                                    .Data = new('character'),
                                                    geogCoordSys = new('geogCoordSysType'),
                                                    projCoordSys = new('projCoordSys'),
                                                    name = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'geogCoordSys') <-
    as(geogCoordSys, 'geogCoordSys')
  slot(.Object, 'projCoordSys') <-
    as(projCoordSys, 'projCoordSys')
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('horizCoordSysType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizCoordSysType',  function(from)
  emlToS4(from))
setAs('horizCoordSysDef', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizCoordSysDef',  function(from)
  emlToS4(from))

setMethod(c, signature('horizCoordSysDef'), function(x, ..., recursive = FALSE)
  new('ListOfhorizCoordSysDef', list(x, ...)))
setMethod(initialize, 'projectionList', function(.Object,
                                                 horizCoordSysDef = character(),
                                                 .Data = new('character'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  slot(.Object, 'horizCoordSysDef') <-
    c_as(horizCoordSysDef, 'horizCoordSysDef')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('projectionList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'projectionList',  function(from)
  emlToS4(from))
setAs('spatialReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialReference',  function(from)
  emlToS4(from))
setAs('lengthUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lengthUnits',  function(from)
  emlToS4(from))
setAs('angleUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'angleUnits',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-access.xsd  ####


setAs('access', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'access',  function(from)
  emlToS4(from))
setAs('allow', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'allow',  function(from)
  emlToS4(from))

setMethod(c, signature('allow'), function(x, ..., recursive = FALSE)
  new('ListOfallow', list(x, ...)))
setAs('deny', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'deny',  function(from)
  emlToS4(from))

setMethod(c, signature('deny'), function(x, ..., recursive = FALSE)
  new('ListOfdeny', list(x, ...)))
setMethod(initialize, 'AccessType', function(.Object,
                                             allow = character(),
                                             deny = character(),
                                             .Data = new('character'),
                                             references = new('references'),
                                             id = new('xml_attribute'),
                                             system = new('xml_attribute'),
                                             scope = new('xml_attribute'),
                                             order = new('xml_attribute'),
                                             authSystem = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'allow') <-
    c_as(allow, 'allow')
  slot(.Object, 'deny') <-
    c_as(deny, 'deny')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'order') <-
    as(order, 'xml_attribute')
  slot(.Object, 'authSystem') <-
    as(authSystem, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('AccessType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'AccessType',  function(from)
  emlToS4(from))
setAs('principal', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'principal',  function(from)
  emlToS4(from))

setMethod(c, signature('principal'), function(x, ..., recursive = FALSE)
  new('ListOfprincipal', list(x, ...)))
setAs('permission', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'permission',  function(from)
  emlToS4(from))

setMethod(c, signature('permission'), function(x, ..., recursive = FALSE)
  new('ListOfpermission', list(x, ...)))
setMethod(initialize, 'AccessRule', function(.Object,
                                             principal = character(),
                                             permission = character(),
                                             .Data = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'principal') <-
    c_as(principal, 'principal')
  slot(.Object, 'permission') <-
    c_as(permission, 'permission')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('AccessRule', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'AccessRule',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-constraint.xsd  ####


setAs('attributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeReference',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeReference'), function(x, ..., recursive = FALSE)
  new('ListOfattributeReference', list(x, ...)))
setMethod(initialize, 'key', function(.Object,
                                      attributeReference = character(),
                                      .Data = new('character'),
                                      schemaLocation = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'attributeReference') <-
    c_as(attributeReference, 'attributeReference')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('key', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'key',  function(from)
  emlToS4(from))
setMethod(initialize, 'primaryKey', function(.Object,
                                             .Data = new('character'),
                                             ConstraintBaseGroup = new('ConstraintBaseGroup'),
                                             key = new('key'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ConstraintBaseGroup') <-
    as(ConstraintBaseGroup, 'ConstraintBaseGroup')
  slot(.Object, 'key') <-
    as(key, 'key')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('primaryKey', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'primaryKey',  function(from)
  emlToS4(from))
setAs('attributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeReference',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeReference'), function(x, ..., recursive = FALSE)
  new('ListOfattributeReference', list(x, ...)))
setMethod(initialize, 'key', function(.Object,
                                      attributeReference = character(),
                                      .Data = new('character'),
                                      schemaLocation = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'attributeReference') <-
    c_as(attributeReference, 'attributeReference')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('key', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'key',  function(from)
  emlToS4(from))
setMethod(initialize, 'uniqueKey', function(.Object,
                                            .Data = new('character'),
                                            ConstraintBaseGroup = new('ConstraintBaseGroup'),
                                            key = new('key'),
                                            schemaLocation = new('xml_attribute'),
                                            lang = new('xml_attribute'),
                                            slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ConstraintBaseGroup') <-
    as(ConstraintBaseGroup, 'ConstraintBaseGroup')
  slot(.Object, 'key') <-
    as(key, 'key')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('uniqueKey', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'uniqueKey',  function(from)
  emlToS4(from))
setAs('checkCondition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'checkCondition',  function(from)
  emlToS4(from))
setMethod(initialize, 'checkConstraint', function(.Object,
                                                  .Data = new('character'),
                                                  ConstraintBaseGroup = new('ConstraintBaseGroup'),
                                                  checkCondition = new('character'),
                                                  language = new('xml_attribute'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ConstraintBaseGroup') <-
    as(ConstraintBaseGroup, 'ConstraintBaseGroup')
  slot(.Object, 'checkCondition') <-
    as(checkCondition, 'checkCondition')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('checkConstraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'checkConstraint',  function(from)
  emlToS4(from))
setMethod(initialize, 'foreignKey', function(.Object,
                                             .Data = new('character'),
                                             ForeignKeyGroup = new('ForeignKeyGroup'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ForeignKeyGroup') <-
    as(ForeignKeyGroup, 'ForeignKeyGroup')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('foreignKey', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'foreignKey',  function(from)
  emlToS4(from))
setAs('attributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeReference',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeReference'), function(x, ..., recursive = FALSE)
  new('ListOfattributeReference', list(x, ...)))
setMethod(initialize, 'referencedKey', function(.Object,
                                                attributeReference = character(),
                                                .Data = new('character'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'attributeReference') <-
    c_as(attributeReference, 'attributeReference')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('referencedKey', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'referencedKey',  function(from)
  emlToS4(from))
setMethod(initialize, 'joinCondition', function(.Object,
                                                .Data = new('character'),
                                                ForeignKeyGroup = new('ForeignKeyGroup'),
                                                referencedKey = new('referencedKey'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ForeignKeyGroup') <-
    as(ForeignKeyGroup, 'ForeignKeyGroup')
  slot(.Object, 'referencedKey') <-
    as(referencedKey, 'referencedKey')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('joinCondition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'joinCondition',  function(from)
  emlToS4(from))
setAs('attributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeReference',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeReference'), function(x, ..., recursive = FALSE)
  new('ListOfattributeReference', list(x, ...)))
setMethod(initialize, 'key', function(.Object,
                                      attributeReference = character(),
                                      .Data = new('character'),
                                      schemaLocation = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'attributeReference') <-
    c_as(attributeReference, 'attributeReference')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('key', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'key',  function(from)
  emlToS4(from))
setMethod(initialize, 'notNullConstraint', function(.Object,
                                                    .Data = new('character'),
                                                    ConstraintBaseGroup = new('ConstraintBaseGroup'),
                                                    key = new('key'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ConstraintBaseGroup') <-
    as(ConstraintBaseGroup, 'ConstraintBaseGroup')
  slot(.Object, 'key') <-
    as(key, 'key')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('notNullConstraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'notNullConstraint',  function(from)
  emlToS4(from))
setMethod(initialize, 'ConstraintType', function(.Object,
                                                 .Data = new('character'),
                                                 primaryKey = new('primaryKey'),
                                                 uniqueKey = new('uniqueKey'),
                                                 checkConstraint = new('checkConstraint'),
                                                 foreignKey = new('foreignKey'),
                                                 joinCondition = new('joinCondition'),
                                                 notNullConstraint = new('notNullConstraint'),
                                                 id = new('xml_attribute'),
                                                 system = new('xml_attribute'),
                                                 scope = new('xml_attribute'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'primaryKey') <-
    as(primaryKey, 'primaryKey')
  slot(.Object, 'uniqueKey') <-
    as(uniqueKey, 'uniqueKey')
  slot(.Object, 'checkConstraint') <-
    as(checkConstraint, 'checkConstraint')
  slot(.Object, 'foreignKey') <-
    as(foreignKey, 'foreignKey')
  slot(.Object, 'joinCondition') <-
    as(joinCondition, 'joinCondition')
  slot(.Object, 'notNullConstraint') <-
    as(notNullConstraint, 'notNullConstraint')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ConstraintType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ConstraintType',  function(from)
  emlToS4(from))
setAs('CardinalityChildOccurancesType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'CardinalityChildOccurancesType',  function(from)
  emlToS4(from))
setAs('constraintName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraintName',  function(from)
  emlToS4(from))
setAs('constraintDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraintDescription',  function(from)
  emlToS4(from))
setMethod(initialize, 'ConstraintBaseGroup', function(.Object,
                                                      .Data = new('character'),
                                                      constraintName = new('character'),
                                                      constraintDescription = new('constraintDescription'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'constraintName') <-
    as(constraintName, 'constraintName')
  slot(.Object, 'constraintDescription') <-
    as(constraintDescription, 'constraintDescription')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ConstraintBaseGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ConstraintBaseGroup',  function(from)
  emlToS4(from))
setAs('attributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeReference',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeReference'), function(x, ..., recursive = FALSE)
  new('ListOfattributeReference', list(x, ...)))
setMethod(initialize, 'key', function(.Object,
                                      attributeReference = character(),
                                      .Data = new('character'),
                                      schemaLocation = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'attributeReference') <-
    c_as(attributeReference, 'attributeReference')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('key', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'key',  function(from)
  emlToS4(from))
setAs('entityReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityReference',  function(from)
  emlToS4(from))
setAs('relationshipType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'relationshipType',  function(from)
  emlToS4(from))
setAs('parentOccurences', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'parentOccurences',  function(from)
  emlToS4(from))
setAs('childOccurences', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'childOccurences',  function(from)
  emlToS4(from))
setMethod(initialize, 'cardinality', function(.Object,
                                              .Data = new('character'),
                                              parentOccurences = new('parentOccurences'),
                                              childOccurences = new('CardinalityChildOccurancesType'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'parentOccurences') <-
    as(parentOccurences, 'parentOccurences')
  slot(.Object, 'childOccurences') <-
    as(childOccurences, 'childOccurences')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('cardinality', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cardinality',  function(from)
  emlToS4(from))
setMethod(initialize, 'ForeignKeyGroup', function(.Object,
                                                  .Data = new('character'),
                                                  ConstraintBaseGroup = new('ConstraintBaseGroup'),
                                                  key = new('key'),
                                                  entityReference = new('character'),
                                                  relationshipType = new('relationshipType'),
                                                  cardinality = new('cardinality'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'ConstraintBaseGroup') <-
    as(ConstraintBaseGroup, 'ConstraintBaseGroup')
  slot(.Object, 'key') <-
    as(key, 'key')
  slot(.Object, 'entityReference') <-
    as(entityReference, 'entityReference')
  slot(.Object, 'relationshipType') <-
    as(relationshipType, 'relationshipType')
  slot(.Object, 'cardinality') <-
    as(cardinality, 'cardinality')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ForeignKeyGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ForeignKeyGroup',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-literature.xsd  ####


setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))
setAs('contact', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'contact',  function(from)
  emlToS4(from))

setMethod(c, signature('contact'), function(x, ..., recursive = FALSE)
  new('ListOfcontact', list(x, ...)))
setAs('article', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'article',  function(from)
  emlToS4(from))
setAs('book', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'book',  function(from)
  emlToS4(from))
setAs('chapter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'chapter',  function(from)
  emlToS4(from))
setAs('editedBook', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'editedBook',  function(from)
  emlToS4(from))
setAs('manuscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'manuscript',  function(from)
  emlToS4(from))
setAs('report', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'report',  function(from)
  emlToS4(from))
setAs('thesis', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'thesis',  function(from)
  emlToS4(from))
setAs('conferenceProceedings', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceProceedings',  function(from)
  emlToS4(from))
setAs('personalCommunication', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'personalCommunication',  function(from)
  emlToS4(from))
setAs('map', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'map',  function(from)
  emlToS4(from))
setAs('generic', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'generic',  function(from)
  emlToS4(from))
setAs('audioVisual', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'audioVisual',  function(from)
  emlToS4(from))
setAs('presentation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'presentation',  function(from)
  emlToS4(from))
setMethod(initialize, 'CitationType', function(.Object,
                                               alternateIdentifier = character(),
                                               title = character(),
                                               creator = character(),
                                               metadataProvider = character(),
                                               associatedParty = character(),
                                               keywordSet = character(),
                                               additionalInfo = character(),
                                               distribution = character(),
                                               contact = character(),
                                               .Data = new('character'),
                                               shortName = new('character'),
                                               pubDate = new('yearDate'),
                                               language = new('character'),
                                               series = new('character'),
                                               abstract = new('TextType'),
                                               intellectualRights = new('TextType'),
                                               coverage = new('Coverage'),
                                               article = new('Article'),
                                               book = new('Book'),
                                               chapter = new('Chapter'),
                                               editedBook = new('Book'),
                                               manuscript = new('Manuscript'),
                                               report = new('Report'),
                                               thesis = new('Thesis'),
                                               conferenceProceedings = new('ConferenceProceedings'),
                                               personalCommunication = new('PersonalCommunication'),
                                               map = new('Map'),
                                               generic = new('Generic'),
                                               audioVisual = new('AudioVisual'),
                                               presentation = new('Presentation'),
                                               references = new('references'),
                                               id = new('xml_attribute'),
                                               system = new('xml_attribute'),
                                               scope = new('xml_attribute'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'creator') <-
    c_as(creator, 'creator')
  slot(.Object, 'metadataProvider') <-
    c_as(metadataProvider, 'metadataProvider')
  slot(.Object, 'associatedParty') <-
    c_as(associatedParty, 'associatedParty')
  slot(.Object, 'keywordSet') <-
    c_as(keywordSet, 'keywordSet')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  slot(.Object, 'contact') <-
    c_as(contact, 'contact')
  .Object@.Data <-
    .Data
  slot(.Object, 'shortName') <-
    as(shortName, 'shortName')
  slot(.Object, 'pubDate') <-
    as(pubDate, 'pubDate')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'series') <-
    as(series, 'series')
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'intellectualRights') <-
    as(intellectualRights, 'intellectualRights')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'article') <-
    as(article, 'article')
  slot(.Object, 'book') <-
    as(book, 'book')
  slot(.Object, 'chapter') <-
    as(chapter, 'chapter')
  slot(.Object, 'editedBook') <-
    as(editedBook, 'editedBook')
  slot(.Object, 'manuscript') <-
    as(manuscript, 'manuscript')
  slot(.Object, 'report') <-
    as(report, 'report')
  slot(.Object, 'thesis') <-
    as(thesis, 'thesis')
  slot(.Object, 'conferenceProceedings') <-
    as(conferenceProceedings, 'conferenceProceedings')
  slot(.Object, 'personalCommunication') <-
    as(personalCommunication, 'personalCommunication')
  slot(.Object, 'map') <-
    as(map, 'map')
  slot(.Object, 'generic') <-
    as(generic, 'generic')
  slot(.Object, 'audioVisual') <-
    as(audioVisual, 'audioVisual')
  slot(.Object, 'presentation') <-
    as(presentation, 'presentation')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('CitationType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'CitationType',  function(from)
  emlToS4(from))
setAs('journal', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'journal',  function(from)
  emlToS4(from))
setAs('volume', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'volume',  function(from)
  emlToS4(from))
setAs('issue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'issue',  function(from)
  emlToS4(from))
setAs('pageRange', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pageRange',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('ISSN', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ISSN',  function(from)
  emlToS4(from))
setMethod(initialize, 'Article', function(.Object,
                                          .Data = new('character'),
                                          journal = new('character'),
                                          volume = new('character'),
                                          issue = new('character'),
                                          pageRange = new('character'),
                                          publisher = new('ResponsibleParty'),
                                          publicationPlace = new('character'),
                                          ISSN = new('character'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'journal') <-
    as(journal, 'journal')
  slot(.Object, 'volume') <-
    as(volume, 'volume')
  slot(.Object, 'issue') <-
    as(issue, 'issue')
  slot(.Object, 'pageRange') <-
    as(pageRange, 'pageRange')
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'publicationPlace') <-
    as(publicationPlace, 'publicationPlace')
  slot(.Object, 'ISSN') <-
    as(ISSN, 'ISSN')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Article', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Article',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('edition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'edition',  function(from)
  emlToS4(from))
setAs('volume', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'volume',  function(from)
  emlToS4(from))
setAs('numberOfVolumes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numberOfVolumes',  function(from)
  emlToS4(from))
setAs('totalPages', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalPages',  function(from)
  emlToS4(from))
setAs('totalFigures', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalFigures',  function(from)
  emlToS4(from))
setAs('totalTables', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalTables',  function(from)
  emlToS4(from))
setAs('ISBN', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ISBN',  function(from)
  emlToS4(from))
setMethod(initialize, 'Book', function(.Object,
                                       .Data = new('character'),
                                       publisher = new('ResponsibleParty'),
                                       publicationPlace = new('character'),
                                       edition = new('character'),
                                       volume = new('character'),
                                       numberOfVolumes = new('character'),
                                       totalPages = new('character'),
                                       totalFigures = new('character'),
                                       totalTables = new('character'),
                                       ISBN = new('character'),
                                       schemaLocation = new('xml_attribute'),
                                       lang = new('xml_attribute'),
                                       slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'publicationPlace') <-
    as(publicationPlace, 'publicationPlace')
  slot(.Object, 'edition') <-
    as(edition, 'edition')
  slot(.Object, 'volume') <-
    as(volume, 'volume')
  slot(.Object, 'numberOfVolumes') <-
    as(numberOfVolumes, 'numberOfVolumes')
  slot(.Object, 'totalPages') <-
    as(totalPages, 'totalPages')
  slot(.Object, 'totalFigures') <-
    as(totalFigures, 'totalFigures')
  slot(.Object, 'totalTables') <-
    as(totalTables, 'totalTables')
  slot(.Object, 'ISBN') <-
    as(ISBN, 'ISBN')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Book', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Book',  function(from)
  emlToS4(from))
setAs('chapterNumber', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'chapterNumber',  function(from)
  emlToS4(from))
setAs('editor', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'editor',  function(from)
  emlToS4(from))

setMethod(c, signature('editor'), function(x, ..., recursive = FALSE)
  new('ListOfeditor', list(x, ...)))
setAs('bookTitle', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bookTitle',  function(from)
  emlToS4(from))
setAs('pageRange', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pageRange',  function(from)
  emlToS4(from))
setMethod(initialize, 'Chapter', function(.Object,
                                          editor = character(),
                                          .Data = new('character'),
                                          chapterNumber = new('character'),
                                          bookTitle = new('character'),
                                          pageRange = new('character'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  slot(.Object, 'editor') <-
    c_as(editor, 'editor')
  .Object@.Data <-
    .Data
  slot(.Object, 'chapterNumber') <-
    as(chapterNumber, 'chapterNumber')
  slot(.Object, 'bookTitle') <-
    as(bookTitle, 'bookTitle')
  slot(.Object, 'pageRange') <-
    as(pageRange, 'pageRange')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Chapter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Chapter',  function(from)
  emlToS4(from))
setAs('conferenceName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceName',  function(from)
  emlToS4(from))
setAs('conferenceDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceDate',  function(from)
  emlToS4(from))
setAs('conferenceLocation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceLocation',  function(from)
  emlToS4(from))
setMethod(initialize, 'ConferenceProceedings', function(.Object,
                                                        .Data = new('character'),
                                                        conferenceName = new('character'),
                                                        conferenceDate = new('character'),
                                                        conferenceLocation = new('Address'),
                                                        schemaLocation = new('xml_attribute'),
                                                        lang = new('xml_attribute'),
                                                        slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'conferenceName') <-
    as(conferenceName, 'conferenceName')
  slot(.Object, 'conferenceDate') <-
    as(conferenceDate, 'conferenceDate')
  slot(.Object, 'conferenceLocation') <-
    as(conferenceLocation, 'conferenceLocation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ConferenceProceedings', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ConferenceProceedings',  function(from)
  emlToS4(from))
setAs('institution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'institution',  function(from)
  emlToS4(from))

setMethod(c, signature('institution'), function(x, ..., recursive = FALSE)
  new('ListOfinstitution', list(x, ...)))
setAs('totalPages', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalPages',  function(from)
  emlToS4(from))
setMethod(initialize, 'Manuscript', function(.Object,
                                             institution = character(),
                                             .Data = new('character'),
                                             totalPages = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'institution') <-
    c_as(institution, 'institution')
  .Object@.Data <-
    .Data
  slot(.Object, 'totalPages') <-
    as(totalPages, 'totalPages')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Manuscript', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Manuscript',  function(from)
  emlToS4(from))
setAs('reportNumber', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'reportNumber',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('totalPages', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalPages',  function(from)
  emlToS4(from))
setMethod(initialize, 'Report', function(.Object,
                                         .Data = new('character'),
                                         reportNumber = new('character'),
                                         publisher = new('ResponsibleParty'),
                                         publicationPlace = new('character'),
                                         totalPages = new('character'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'reportNumber') <-
    as(reportNumber, 'reportNumber')
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'publicationPlace') <-
    as(publicationPlace, 'publicationPlace')
  slot(.Object, 'totalPages') <-
    as(totalPages, 'totalPages')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Report', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Report',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('communicationType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'communicationType',  function(from)
  emlToS4(from))
setAs('recipient', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'recipient',  function(from)
  emlToS4(from))

setMethod(c, signature('recipient'), function(x, ..., recursive = FALSE)
  new('ListOfrecipient', list(x, ...)))
setMethod(initialize, 'PersonalCommunication', function(.Object,
                                                        recipient = character(),
                                                        .Data = new('character'),
                                                        publisher = new('ResponsibleParty'),
                                                        publicationPlace = new('character'),
                                                        communicationType = new('character'),
                                                        schemaLocation = new('xml_attribute'),
                                                        lang = new('xml_attribute'),
                                                        slot_order = new('character')) {

  slot(.Object, 'recipient') <-
    c_as(recipient, 'recipient')
  .Object@.Data <-
    .Data
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'publicationPlace') <-
    as(publicationPlace, 'publicationPlace')
  slot(.Object, 'communicationType') <-
    as(communicationType, 'communicationType')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('PersonalCommunication', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'PersonalCommunication',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('edition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'edition',  function(from)
  emlToS4(from))
setAs('geographicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geographicCoverage',  function(from)
  emlToS4(from))

setMethod(c, signature('geographicCoverage'), function(x, ..., recursive = FALSE)
  new('ListOfgeographicCoverage', list(x, ...)))
setAs('scale', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'scale',  function(from)
  emlToS4(from))
setMethod(initialize, 'Map', function(.Object,
                                      geographicCoverage = character(),
                                      .Data = new('character'),
                                      publisher = new('ResponsibleParty'),
                                      edition = new('character'),
                                      scale = new('character'),
                                      schemaLocation = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'geographicCoverage') <-
    c_as(geographicCoverage, 'geographicCoverage')
  .Object@.Data <-
    .Data
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'edition') <-
    as(edition, 'edition')
  slot(.Object, 'scale') <-
    as(scale, 'scale')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Map', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Map',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))

setMethod(c, signature('publicationPlace'), function(x, ..., recursive = FALSE)
  new('ListOfpublicationPlace', list(x, ...)))
setAs('performer', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'performer',  function(from)
  emlToS4(from))

setMethod(c, signature('performer'), function(x, ..., recursive = FALSE)
  new('ListOfperformer', list(x, ...)))
setAs('ISBN', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ISBN',  function(from)
  emlToS4(from))
setMethod(initialize, 'AudioVisual', function(.Object,
                                              publicationPlace = character(),
                                              performer = character(),
                                              .Data = new('character'),
                                              publisher = new('ResponsibleParty'),
                                              ISBN = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'publicationPlace') <-
    c_as(publicationPlace, 'publicationPlace')
  slot(.Object, 'performer') <-
    c_as(performer, 'performer')
  .Object@.Data <-
    .Data
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'ISBN') <-
    as(ISBN, 'ISBN')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('AudioVisual', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'AudioVisual',  function(from)
  emlToS4(from))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('referenceType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'referenceType',  function(from)
  emlToS4(from))
setAs('volume', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'volume',  function(from)
  emlToS4(from))
setAs('numberOfVolumes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numberOfVolumes',  function(from)
  emlToS4(from))
setAs('totalPages', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalPages',  function(from)
  emlToS4(from))
setAs('totalFigures', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalFigures',  function(from)
  emlToS4(from))
setAs('totalTables', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalTables',  function(from)
  emlToS4(from))
setAs('edition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'edition',  function(from)
  emlToS4(from))
setAs('originalPublication', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'originalPublication',  function(from)
  emlToS4(from))
setAs('reprintEdition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'reprintEdition',  function(from)
  emlToS4(from))
setAs('reviewedItem', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'reviewedItem',  function(from)
  emlToS4(from))
setAs('ISBN', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ISBN',  function(from)
  emlToS4(from))
setAs('ISSN', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ISSN',  function(from)
  emlToS4(from))
setMethod(initialize, 'Generic', function(.Object,
                                          .Data = new('character'),
                                          publisher = new('ResponsibleParty'),
                                          publicationPlace = new('character'),
                                          referenceType = new('referenceType'),
                                          volume = new('character'),
                                          numberOfVolumes = new('character'),
                                          totalPages = new('character'),
                                          totalFigures = new('character'),
                                          totalTables = new('character'),
                                          edition = new('character'),
                                          originalPublication = new('character'),
                                          reprintEdition = new('character'),
                                          reviewedItem = new('character'),
                                          ISBN = new('character'),
                                          ISSN = new('character'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'publicationPlace') <-
    as(publicationPlace, 'publicationPlace')
  slot(.Object, 'referenceType') <-
    as(referenceType, 'referenceType')
  slot(.Object, 'volume') <-
    as(volume, 'volume')
  slot(.Object, 'numberOfVolumes') <-
    as(numberOfVolumes, 'numberOfVolumes')
  slot(.Object, 'totalPages') <-
    as(totalPages, 'totalPages')
  slot(.Object, 'totalFigures') <-
    as(totalFigures, 'totalFigures')
  slot(.Object, 'totalTables') <-
    as(totalTables, 'totalTables')
  slot(.Object, 'edition') <-
    as(edition, 'edition')
  slot(.Object, 'originalPublication') <-
    as(originalPublication, 'originalPublication')
  slot(.Object, 'reprintEdition') <-
    as(reprintEdition, 'reprintEdition')
  slot(.Object, 'reviewedItem') <-
    as(reviewedItem, 'reviewedItem')
  slot(.Object, 'ISBN') <-
    as(ISBN, 'ISBN')
  slot(.Object, 'ISSN') <-
    as(ISSN, 'ISSN')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Generic', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Generic',  function(from)
  emlToS4(from))
setAs('degree', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'degree',  function(from)
  emlToS4(from))
setAs('institution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'institution',  function(from)
  emlToS4(from))
setAs('totalPages', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalPages',  function(from)
  emlToS4(from))
setMethod(initialize, 'Thesis', function(.Object,
                                         .Data = new('character'),
                                         degree = new('character'),
                                         institution = new('ResponsibleParty'),
                                         totalPages = new('character'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'degree') <-
    as(degree, 'degree')
  slot(.Object, 'institution') <-
    as(institution, 'institution')
  slot(.Object, 'totalPages') <-
    as(totalPages, 'totalPages')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Thesis', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Thesis',  function(from)
  emlToS4(from))
setAs('conferenceName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceName',  function(from)
  emlToS4(from))
setAs('conferenceDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceDate',  function(from)
  emlToS4(from))
setAs('conferenceLocation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'conferenceLocation',  function(from)
  emlToS4(from))
setMethod(initialize, 'Presentation', function(.Object,
                                               .Data = new('character'),
                                               conferenceName = new('character'),
                                               conferenceDate = new('character'),
                                               conferenceLocation = new('Address'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'conferenceName') <-
    as(conferenceName, 'conferenceName')
  slot(.Object, 'conferenceDate') <-
    as(conferenceDate, 'conferenceDate')
  slot(.Object, 'conferenceLocation') <-
    as(conferenceLocation, 'conferenceLocation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Presentation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Presentation',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-coverage.xsd  ####


setAs('geographicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geographicCoverage',  function(from)
  emlToS4(from))

setMethod(c, signature('geographicCoverage'), function(x, ..., recursive = FALSE)
  new('ListOfgeographicCoverage', list(x, ...)))
setMethod(initialize, 'temporalCoverage', function(.Object,
                                                   singleDateTime = character(),
                                                   .Data = new('character'),
                                                   system = new('xml_attribute'),
                                                   scope = new('xml_attribute'),
                                                   rangeOfDates = new('rangeOfDates'),
                                                   references = new('references'),
                                                   id = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'singleDateTime') <-
    c_as(singleDateTime, 'singleDateTime')
  .Object@.Data <-
    .Data
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'rangeOfDates') <-
    as(rangeOfDates, 'rangeOfDates')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('temporalCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'temporalCoverage',  function(from)
  emlToS4(from))

setMethod(c, signature('temporalCoverage'), function(x, ..., recursive = FALSE)
  new('ListOftemporalCoverage', list(x, ...)))
setMethod(initialize, 'taxonomicCoverage', function(.Object,
                                                    taxonomicClassification = character(),
                                                    .Data = new('character'),
                                                    system = new('xml_attribute'),
                                                    scope = new('xml_attribute'),
                                                    taxonomicSystem = new('taxonomicSystem'),
                                                    generalTaxonomicCoverage = new('character'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'taxonomicClassification') <-
    c_as(taxonomicClassification, 'taxonomicClassification')
  .Object@.Data <-
    .Data
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'taxonomicSystem') <-
    as(taxonomicSystem, 'taxonomicSystem')
  slot(.Object, 'generalTaxonomicCoverage') <-
    as(generalTaxonomicCoverage, 'generalTaxonomicCoverage')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('taxonomicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicCoverage',  function(from)
  emlToS4(from))

setMethod(c, signature('taxonomicCoverage'), function(x, ..., recursive = FALSE)
  new('ListOftaxonomicCoverage', list(x, ...)))
setMethod(initialize, 'Coverage', function(.Object,
                                           geographicCoverage = character(),
                                           temporalCoverage = character(),
                                           taxonomicCoverage = character(),
                                           .Data = new('character'),
                                           references = new('references'),
                                           id = new('xml_attribute'),
                                           system = new('xml_attribute'),
                                           scope = new('xml_attribute'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'geographicCoverage') <-
    c_as(geographicCoverage, 'geographicCoverage')
  slot(.Object, 'temporalCoverage') <-
    c_as(temporalCoverage, 'temporalCoverage')
  slot(.Object, 'taxonomicCoverage') <-
    c_as(taxonomicCoverage, 'taxonomicCoverage')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Coverage',  function(from)
  emlToS4(from))
setAs('singleDateTime', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'singleDateTime',  function(from)
  emlToS4(from))

setMethod(c, signature('singleDateTime'), function(x, ..., recursive = FALSE)
  new('ListOfsingleDateTime', list(x, ...)))
setAs('beginDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'beginDate',  function(from)
  emlToS4(from))
setAs('endDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'endDate',  function(from)
  emlToS4(from))
setMethod(initialize, 'rangeOfDates', function(.Object,
                                               .Data = new('character'),
                                               beginDate = new('SingleDateTimeType'),
                                               endDate = new('SingleDateTimeType'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'beginDate') <-
    as(beginDate, 'beginDate')
  slot(.Object, 'endDate') <-
    as(endDate, 'endDate')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('rangeOfDates', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'rangeOfDates',  function(from)
  emlToS4(from))
setMethod(initialize, 'TemporalCoverage', function(.Object,
                                                   singleDateTime = character(),
                                                   .Data = new('character'),
                                                   rangeOfDates = new('rangeOfDates'),
                                                   references = new('references'),
                                                   id = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'singleDateTime') <-
    c_as(singleDateTime, 'singleDateTime')
  .Object@.Data <-
    .Data
  slot(.Object, 'rangeOfDates') <-
    as(rangeOfDates, 'rangeOfDates')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('TemporalCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'TemporalCoverage',  function(from)
  emlToS4(from))
setAs('calendarDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'calendarDate',  function(from)
  emlToS4(from))
setAs('time', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'time',  function(from)
  emlToS4(from))
setAs('timeScaleName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'timeScaleName',  function(from)
  emlToS4(from))
setAs('timeScaleAgeEstimate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'timeScaleAgeEstimate',  function(from)
  emlToS4(from))
setAs('timeScaleAgeUncertainty', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'timeScaleAgeUncertainty',  function(from)
  emlToS4(from))
setAs('timeScaleAgeExplanation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'timeScaleAgeExplanation',  function(from)
  emlToS4(from))
setAs('timeScaleCitation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'timeScaleCitation',  function(from)
  emlToS4(from))

setMethod(c, signature('timeScaleCitation'), function(x, ..., recursive = FALSE)
  new('ListOftimeScaleCitation', list(x, ...)))
setMethod(initialize, 'alternativeTimeScale', function(.Object,
                                                       timeScaleCitation = character(),
                                                       .Data = new('character'),
                                                       timeScaleName = new('character'),
                                                       timeScaleAgeEstimate = new('character'),
                                                       timeScaleAgeUncertainty = new('character'),
                                                       timeScaleAgeExplanation = new('character'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  slot(.Object, 'timeScaleCitation') <-
    c_as(timeScaleCitation, 'timeScaleCitation')
  .Object@.Data <-
    .Data
  slot(.Object, 'timeScaleName') <-
    as(timeScaleName, 'timeScaleName')
  slot(.Object, 'timeScaleAgeEstimate') <-
    as(timeScaleAgeEstimate, 'timeScaleAgeEstimate')
  slot(.Object, 'timeScaleAgeUncertainty') <-
    as(timeScaleAgeUncertainty, 'timeScaleAgeUncertainty')
  slot(.Object, 'timeScaleAgeExplanation') <-
    as(timeScaleAgeExplanation, 'timeScaleAgeExplanation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('alternativeTimeScale', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'alternativeTimeScale',  function(from)
  emlToS4(from))
setMethod(initialize, 'SingleDateTimeType', function(.Object,
                                                     .Data = new('character'),
                                                     calendarDate = new('yearDate'),
                                                     time = new('character'),
                                                     alternativeTimeScale = new('alternativeTimeScale'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'calendarDate') <-
    as(calendarDate, 'calendarDate')
  slot(.Object, 'time') <-
    as(time, 'time')
  slot(.Object, 'alternativeTimeScale') <-
    as(alternativeTimeScale, 'alternativeTimeScale')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SingleDateTimeType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SingleDateTimeType',  function(from)
  emlToS4(from))
setAs('geographicDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geographicDescription',  function(from)
  emlToS4(from))
setAs('westBoundingCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'westBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('eastBoundingCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'eastBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('northBoundingCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'northBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('southBoundingCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'southBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('altitudeMinimum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeMinimum',  function(from)
  emlToS4(from))
setAs('altitudeMaximum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeMaximum',  function(from)
  emlToS4(from))
setAs('altitudeUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'altitudeUnits',  function(from)
  emlToS4(from))
setMethod(initialize, 'boundingAltitudes', function(.Object,
                                                    .Data = new('character'),
                                                    altitudeMinimum = new('character'),
                                                    altitudeMaximum = new('character'),
                                                    altitudeUnits = new('LengthUnitType'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'altitudeMinimum') <-
    as(altitudeMinimum, 'altitudeMinimum')
  slot(.Object, 'altitudeMaximum') <-
    as(altitudeMaximum, 'altitudeMaximum')
  slot(.Object, 'altitudeUnits') <-
    as(altitudeUnits, 'altitudeUnits')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('boundingAltitudes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'boundingAltitudes',  function(from)
  emlToS4(from))
setMethod(initialize, 'boundingCoordinates', function(.Object,
                                                      .Data = new('character'),
                                                      westBoundingCoordinate = new('westBoundingCoordinate'),
                                                      eastBoundingCoordinate = new('eastBoundingCoordinate'),
                                                      northBoundingCoordinate = new('northBoundingCoordinate'),
                                                      southBoundingCoordinate = new('southBoundingCoordinate'),
                                                      boundingAltitudes = new('boundingAltitudes'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'westBoundingCoordinate') <-
    as(westBoundingCoordinate, 'westBoundingCoordinate')
  slot(.Object, 'eastBoundingCoordinate') <-
    as(eastBoundingCoordinate, 'eastBoundingCoordinate')
  slot(.Object, 'northBoundingCoordinate') <-
    as(northBoundingCoordinate, 'northBoundingCoordinate')
  slot(.Object, 'southBoundingCoordinate') <-
    as(southBoundingCoordinate, 'southBoundingCoordinate')
  slot(.Object, 'boundingAltitudes') <-
    as(boundingAltitudes, 'boundingAltitudes')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('boundingCoordinates', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'boundingCoordinates',  function(from)
  emlToS4(from))
setAs('gRingPoint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRingPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('gRingPoint'), function(x, ..., recursive = FALSE)
  new('ListOfgRingPoint', list(x, ...)))
setAs('gRing', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRing',  function(from)
  emlToS4(from))
setMethod(initialize, 'datasetGPolygonOuterGRing', function(.Object,
                                                            gRingPoint = character(),
                                                            .Data = new('character'),
                                                            gRing = new('GRingType'),
                                                            schemaLocation = new('xml_attribute'),
                                                            lang = new('xml_attribute'),
                                                            slot_order = new('character')) {

  slot(.Object, 'gRingPoint') <-
    c_as(gRingPoint, 'gRingPoint')
  .Object@.Data <-
    .Data
  slot(.Object, 'gRing') <-
    as(gRing, 'gRing')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('datasetGPolygonOuterGRing', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'datasetGPolygonOuterGRing',  function(from)
  emlToS4(from))
setAs('gRingPoint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRingPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('gRingPoint'), function(x, ..., recursive = FALSE)
  new('ListOfgRingPoint', list(x, ...)))
setAs('gRing', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRing',  function(from)
  emlToS4(from))
setMethod(initialize, 'datasetGPolygonExclusionGRing', function(.Object,
                                                                gRingPoint = character(),
                                                                .Data = new('character'),
                                                                gRing = new('GRingType'),
                                                                schemaLocation = new('xml_attribute'),
                                                                lang = new('xml_attribute'),
                                                                slot_order = new('character')) {

  slot(.Object, 'gRingPoint') <-
    c_as(gRingPoint, 'gRingPoint')
  .Object@.Data <-
    .Data
  slot(.Object, 'gRing') <-
    as(gRing, 'gRing')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('datasetGPolygonExclusionGRing', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'datasetGPolygonExclusionGRing',  function(from)
  emlToS4(from))

setMethod(c, signature('datasetGPolygonExclusionGRing'), function(x, ..., recursive = FALSE)
  new('ListOfdatasetGPolygonExclusionGRing', list(x, ...)))
setMethod(initialize, 'datasetGPolygon', function(.Object,
                                                  datasetGPolygonExclusionGRing = character(),
                                                  .Data = new('character'),
                                                  datasetGPolygonOuterGRing = new('datasetGPolygonOuterGRing'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'datasetGPolygonExclusionGRing') <-
    c_as(datasetGPolygonExclusionGRing,
         'datasetGPolygonExclusionGRing')
  .Object@.Data <-
    .Data
  slot(.Object, 'datasetGPolygonOuterGRing') <-
    as(datasetGPolygonOuterGRing, 'datasetGPolygonOuterGRing')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('datasetGPolygon', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'datasetGPolygon',  function(from)
  emlToS4(from))

setMethod(c, signature('datasetGPolygon'), function(x, ..., recursive = FALSE)
  new('ListOfdatasetGPolygon', list(x, ...)))
setMethod(initialize, 'GeographicCoverage', function(.Object,
                                                     datasetGPolygon = character(),
                                                     .Data = new('character'),
                                                     geographicDescription = new('character'),
                                                     boundingCoordinates = new('boundingCoordinates'),
                                                     references = new('references'),
                                                     id = new('xml_attribute'),
                                                     system = new('xml_attribute'),
                                                     scope = new('xml_attribute'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  slot(.Object, 'datasetGPolygon') <-
    c_as(datasetGPolygon, 'datasetGPolygon')
  .Object@.Data <-
    .Data
  slot(.Object, 'geographicDescription') <-
    as(geographicDescription, 'geographicDescription')
  slot(.Object, 'boundingCoordinates') <-
    as(boundingCoordinates, 'boundingCoordinates')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('GeographicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'GeographicCoverage',  function(from)
  emlToS4(from))
setAs('gRingLatitude', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRingLatitude',  function(from)
  emlToS4(from))
setAs('gRingLongitude', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'gRingLongitude',  function(from)
  emlToS4(from))
setMethod(initialize, 'GRingPointType', function(.Object,
                                                 .Data = new('character'),
                                                 gRingLatitude = new('gRingLatitude'),
                                                 gRingLongitude = new('gRingLongitude'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'gRingLatitude') <-
    as(gRingLatitude, 'gRingLatitude')
  slot(.Object, 'gRingLongitude') <-
    as(gRingLongitude, 'gRingLongitude')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('GRingPointType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'GRingPointType',  function(from)
  emlToS4(from))
setAs('GRingType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'GRingType',  function(from)
  emlToS4(from))
setAs('classificationSystemCitation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'classificationSystemCitation',  function(from)
  emlToS4(from))
setAs('classificationSystemModifications', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'classificationSystemModifications',  function(from)
  emlToS4(from))
setMethod(initialize, 'classificationSystem', function(.Object,
                                                       .Data = new('character'),
                                                       classificationSystemCitation = new('CitationType'),
                                                       classificationSystemModifications = new('character'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'classificationSystemCitation') <-
    as(classificationSystemCitation,
       'classificationSystemCitation')
  slot(.Object, 'classificationSystemModifications') <-
    as(classificationSystemModifications,
       'classificationSystemModifications')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('classificationSystem', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'classificationSystem',  function(from)
  emlToS4(from))

setMethod(c, signature('classificationSystem'), function(x, ..., recursive = FALSE)
  new('ListOfclassificationSystem', list(x, ...)))
setAs('identificationReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'identificationReference',  function(from)
  emlToS4(from))

setMethod(c, signature('identificationReference'), function(x, ..., recursive = FALSE)
  new('ListOfidentificationReference', list(x, ...)))
setAs('identifierName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'identifierName',  function(from)
  emlToS4(from))

setMethod(c, signature('identifierName'), function(x, ..., recursive = FALSE)
  new('ListOfidentifierName', list(x, ...)))
setAs('taxonomicProcedures', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicProcedures',  function(from)
  emlToS4(from))
setAs('taxonomicCompleteness', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicCompleteness',  function(from)
  emlToS4(from))
setAs('specimen', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'specimen',  function(from)
  emlToS4(from))
setAs('originator', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'originator',  function(from)
  emlToS4(from))

setMethod(c, signature('originator'), function(x, ..., recursive = FALSE)
  new('ListOforiginator', list(x, ...)))
setMethod(initialize, 'repository', function(.Object,
                                             originator = character(),
                                             .Data = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'originator') <-
    c_as(originator, 'originator')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('repository', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'repository',  function(from)
  emlToS4(from))
setMethod(initialize, 'vouchers', function(.Object,
                                           .Data = new('character'),
                                           specimen = new('character'),
                                           repository = new('repository'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'specimen') <-
    as(specimen, 'specimen')
  slot(.Object, 'repository') <-
    as(repository, 'repository')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('vouchers', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'vouchers',  function(from)
  emlToS4(from))

setMethod(c, signature('vouchers'), function(x, ..., recursive = FALSE)
  new('ListOfvouchers', list(x, ...)))
setMethod(initialize, 'taxonomicSystem', function(.Object,
                                                  classificationSystem = character(),
                                                  identificationReference = character(),
                                                  identifierName = character(),
                                                  vouchers = character(),
                                                  .Data = new('character'),
                                                  taxonomicProcedures = new('character'),
                                                  taxonomicCompleteness = new('character'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'classificationSystem') <-
    c_as(classificationSystem, 'classificationSystem')
  slot(.Object, 'identificationReference') <-
    c_as(identificationReference, 'identificationReference')
  slot(.Object, 'identifierName') <-
    c_as(identifierName, 'identifierName')
  slot(.Object, 'vouchers') <-
    c_as(vouchers, 'vouchers')
  .Object@.Data <-
    .Data
  slot(.Object, 'taxonomicProcedures') <-
    as(taxonomicProcedures, 'taxonomicProcedures')
  slot(.Object, 'taxonomicCompleteness') <-
    as(taxonomicCompleteness, 'taxonomicCompleteness')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('taxonomicSystem', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicSystem',  function(from)
  emlToS4(from))
setAs('generalTaxonomicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'generalTaxonomicCoverage',  function(from)
  emlToS4(from))
setAs('taxonomicClassification', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicClassification',  function(from)
  emlToS4(from))

setMethod(c, signature('taxonomicClassification'), function(x, ..., recursive = FALSE)
  new('ListOftaxonomicClassification', list(x, ...)))
setMethod(initialize, 'TaxonomicCoverage', function(.Object,
                                                    taxonomicClassification = character(),
                                                    .Data = new('character'),
                                                    taxonomicSystem = new('taxonomicSystem'),
                                                    generalTaxonomicCoverage = new('character'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'taxonomicClassification') <-
    c_as(taxonomicClassification, 'taxonomicClassification')
  .Object@.Data <-
    .Data
  slot(.Object, 'taxonomicSystem') <-
    as(taxonomicSystem, 'taxonomicSystem')
  slot(.Object, 'generalTaxonomicCoverage') <-
    as(generalTaxonomicCoverage, 'generalTaxonomicCoverage')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('TaxonomicCoverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'TaxonomicCoverage',  function(from)
  emlToS4(from))
setAs('taxonRankName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonRankName',  function(from)
  emlToS4(from))
setAs('taxonRankValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonRankValue',  function(from)
  emlToS4(from))
setAs('commonName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'commonName',  function(from)
  emlToS4(from))

setMethod(c, signature('commonName'), function(x, ..., recursive = FALSE)
  new('ListOfcommonName', list(x, ...)))
setAs('taxonomicClassification', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'taxonomicClassification',  function(from)
  emlToS4(from))

setMethod(c, signature('taxonomicClassification'), function(x, ..., recursive = FALSE)
  new('ListOftaxonomicClassification', list(x, ...)))
setMethod(initialize, 'TaxonomicClassificationType', function(.Object,
                                                              commonName = character(),
                                                              taxonomicClassification = character(),
                                                              .Data = new('character'),
                                                              taxonRankName = new('character'),
                                                              taxonRankValue = new('character'),
                                                              schemaLocation = new('xml_attribute'),
                                                              lang = new('xml_attribute'),
                                                              slot_order = new('character')) {

  slot(.Object, 'commonName') <-
    c_as(commonName, 'commonName')
  slot(.Object, 'taxonomicClassification') <-
    c_as(taxonomicClassification, 'taxonomicClassification')
  .Object@.Data <-
    .Data
  slot(.Object, 'taxonRankName') <-
    as(taxonRankName, 'taxonRankName')
  slot(.Object, 'taxonRankValue') <-
    as(taxonRankValue, 'taxonRankValue')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('TaxonomicClassificationType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'TaxonomicClassificationType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-physical.xsd  ####


setAs('physical', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'physical',  function(from)
  emlToS4(from))
setAs('objectName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'objectName',  function(from)
  emlToS4(from))
setMethod(initialize, 'size', function(.Object,
                                       .Data = new('character'),
                                       character = new('character'),
                                       unit = new('xml_attribute'),
                                       schemaLocation = new('xml_attribute'),
                                       lang = new('xml_attribute'),
                                       slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'unit') <-
    as(unit, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('size', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'size',  function(from)
  emlToS4(from))
setMethod(initialize, 'authentication', function(.Object,
                                                 .Data = new('character'),
                                                 character = new('character'),
                                                 method = new('xml_attribute'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'method') <-
    as(method, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('authentication', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'authentication',  function(from)
  emlToS4(from))

setMethod(c, signature('authentication'), function(x, ..., recursive = FALSE)
  new('ListOfauthentication', list(x, ...)))
setAs('compressionMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'compressionMethod',  function(from)
  emlToS4(from))

setMethod(c, signature('compressionMethod'), function(x, ..., recursive = FALSE)
  new('ListOfcompressionMethod', list(x, ...)))
setAs('encodingMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'encodingMethod',  function(from)
  emlToS4(from))

setMethod(c, signature('encodingMethod'), function(x, ..., recursive = FALSE)
  new('ListOfencodingMethod', list(x, ...)))
setAs('characterEncoding', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'characterEncoding',  function(from)
  emlToS4(from))
setAs('numHeaderLines', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numHeaderLines',  function(from)
  emlToS4(from))
setAs('numFooterLines', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numFooterLines',  function(from)
  emlToS4(from))
setAs('recordDelimiter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'recordDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('recordDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOfrecordDelimiter', list(x, ...)))
setAs('physicalLineDelimiter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'physicalLineDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('physicalLineDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOfphysicalLineDelimiter', list(x, ...)))
setAs('numPhysicalLinesPerRecord', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numPhysicalLinesPerRecord',  function(from)
  emlToS4(from))
setAs('maxRecordLength', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'maxRecordLength',  function(from)
  emlToS4(from))
setAs('attributeOrientation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeOrientation',  function(from)
  emlToS4(from))
setAs('fieldDelimiter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'fieldDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('fieldDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOffieldDelimiter', list(x, ...)))
setAs('collapseDelimiters', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'collapseDelimiters',  function(from)
  emlToS4(from))
setAs('quoteCharacter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quoteCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('quoteCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfquoteCharacter', list(x, ...)))
setAs('literalCharacter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'literalCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('literalCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfliteralCharacter', list(x, ...)))
setMethod(initialize, 'simpleDelimited', function(.Object,
                                                  fieldDelimiter = character(),
                                                  quoteCharacter = character(),
                                                  literalCharacter = character(),
                                                  .Data = new('character'),
                                                  collapseDelimiters = new('collapseDelimiters'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'fieldDelimiter') <-
    c_as(fieldDelimiter, 'fieldDelimiter')
  slot(.Object, 'quoteCharacter') <-
    c_as(quoteCharacter, 'quoteCharacter')
  slot(.Object, 'literalCharacter') <-
    c_as(literalCharacter, 'literalCharacter')
  .Object@.Data <-
    .Data
  slot(.Object, 'collapseDelimiters') <-
    as(collapseDelimiters, 'collapseDelimiters')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('simpleDelimited', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'simpleDelimited',  function(from)
  emlToS4(from))
setAs('fieldWidth', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'fieldWidth',  function(from)
  emlToS4(from))
setAs('lineNumber', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lineNumber',  function(from)
  emlToS4(from))
setAs('fieldStartColumn', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'fieldStartColumn',  function(from)
  emlToS4(from))
setMethod(initialize, 'textFixed', function(.Object,
                                            .Data = new('character'),
                                            fieldWidth = new('character'),
                                            lineNumber = new('character'),
                                            fieldStartColumn = new('character'),
                                            schemaLocation = new('xml_attribute'),
                                            lang = new('xml_attribute'),
                                            slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'fieldWidth') <-
    as(fieldWidth, 'fieldWidth')
  slot(.Object, 'lineNumber') <-
    as(lineNumber, 'lineNumber')
  slot(.Object, 'fieldStartColumn') <-
    as(fieldStartColumn, 'fieldStartColumn')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('textFixed', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'textFixed',  function(from)
  emlToS4(from))

setMethod(c, signature('textFixed'), function(x, ..., recursive = FALSE)
  new('ListOftextFixed', list(x, ...)))
setAs('fieldDelimiter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'fieldDelimiter',  function(from)
  emlToS4(from))
setAs('collapseDelimiters', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'collapseDelimiters',  function(from)
  emlToS4(from))
setAs('lineNumber', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lineNumber',  function(from)
  emlToS4(from))
setAs('quoteCharacter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quoteCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('quoteCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfquoteCharacter', list(x, ...)))
setAs('literalCharacter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'literalCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('literalCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfliteralCharacter', list(x, ...)))
setMethod(initialize, 'textDelimited', function(.Object,
                                                quoteCharacter = character(),
                                                literalCharacter = character(),
                                                .Data = new('character'),
                                                fieldDelimiter = new('character'),
                                                collapseDelimiters = new('collapseDelimiters'),
                                                lineNumber = new('character'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'quoteCharacter') <-
    c_as(quoteCharacter, 'quoteCharacter')
  slot(.Object, 'literalCharacter') <-
    c_as(literalCharacter, 'literalCharacter')
  .Object@.Data <-
    .Data
  slot(.Object, 'fieldDelimiter') <-
    as(fieldDelimiter, 'fieldDelimiter')
  slot(.Object, 'collapseDelimiters') <-
    as(collapseDelimiters, 'collapseDelimiters')
  slot(.Object, 'lineNumber') <-
    as(lineNumber, 'lineNumber')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('textDelimited', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'textDelimited',  function(from)
  emlToS4(from))

setMethod(c, signature('textDelimited'), function(x, ..., recursive = FALSE)
  new('ListOftextDelimited', list(x, ...)))

setAs('eml:complex', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'eml:complex',  function(from)
  emlToS4(from))
setMethod(initialize, 'textFormat', function(.Object,
                                             recordDelimiter = character(),
                                             physicalLineDelimiter = character(),
                                             .Data = new('character'),
                                             numHeaderLines = new('character'),
                                             numFooterLines = new('character'),
                                             numPhysicalLinesPerRecord = new('character'),
                                             maxRecordLength = new('character'),
                                             attributeOrientation = new('attributeOrientation'),
                                             simpleDelimited = new('simpleDelimited'),
                                             complex = new('eml:complex'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'recordDelimiter') <-
    c_as(recordDelimiter, 'recordDelimiter')
  slot(.Object, 'physicalLineDelimiter') <-
    c_as(physicalLineDelimiter, 'physicalLineDelimiter')
  .Object@.Data <-
    .Data
  slot(.Object, 'numHeaderLines') <-
    as(numHeaderLines, 'numHeaderLines')
  slot(.Object, 'numFooterLines') <-
    as(numFooterLines, 'numFooterLines')
  slot(.Object, 'numPhysicalLinesPerRecord') <-
    as(numPhysicalLinesPerRecord, 'numPhysicalLinesPerRecord')
  slot(.Object, 'maxRecordLength') <-
    as(maxRecordLength, 'maxRecordLength')
  slot(.Object, 'attributeOrientation') <-
    as(attributeOrientation, 'attributeOrientation')
  slot(.Object, 'simpleDelimited') <-
    as(simpleDelimited, 'simpleDelimited')
  slot(.Object, 'eml:complex') <-
    as(complex, 'eml:complex')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('textFormat', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'textFormat',  function(from)
  emlToS4(from))
setAs('formatName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'formatName',  function(from)
  emlToS4(from))
setAs('formatVersion', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'formatVersion',  function(from)
  emlToS4(from))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))
setMethod(initialize, 'externallyDefinedFormat', function(.Object,
                                                          .Data = new('character'),
                                                          formatName = new('character'),
                                                          formatVersion = new('character'),
                                                          citation = new('CitationType'),
                                                          schemaLocation = new('xml_attribute'),
                                                          lang = new('xml_attribute'),
                                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'formatName') <-
    as(formatName, 'formatName')
  slot(.Object, 'formatVersion') <-
    as(formatVersion, 'formatVersion')
  slot(.Object, 'citation') <-
    as(citation, 'citation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('externallyDefinedFormat', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'externallyDefinedFormat',  function(from)
  emlToS4(from))
setAs('rowColumnOrientation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'rowColumnOrientation',  function(from)
  emlToS4(from))
setAs('nbands', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'nbands',  function(from)
  emlToS4(from))
setAs('layout', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'layout',  function(from)
  emlToS4(from))
setMethod(initialize, 'multiBand', function(.Object,
                                            .Data = new('character'),
                                            nbands = new('character'),
                                            layout = new('character'),
                                            schemaLocation = new('xml_attribute'),
                                            lang = new('xml_attribute'),
                                            slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'nbands') <-
    as(nbands, 'nbands')
  slot(.Object, 'layout') <-
    as(layout, 'layout')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('multiBand', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'multiBand',  function(from)
  emlToS4(from))
setAs('nbits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'nbits',  function(from)
  emlToS4(from))
setAs('byteorder', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'byteorder',  function(from)
  emlToS4(from))
setAs('skipbytes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'skipbytes',  function(from)
  emlToS4(from))
setAs('bandrowbytes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bandrowbytes',  function(from)
  emlToS4(from))
setAs('totalrowbytes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'totalrowbytes',  function(from)
  emlToS4(from))
setAs('bandgapbytes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bandgapbytes',  function(from)
  emlToS4(from))
setMethod(initialize, 'binaryRasterFormat', function(.Object,
                                                     .Data = new('character'),
                                                     rowColumnOrientation = new('rowColumnOrientation'),
                                                     multiBand = new('multiBand'),
                                                     nbits = new('character'),
                                                     byteorder = new('character'),
                                                     skipbytes = new('character'),
                                                     bandrowbytes = new('character'),
                                                     totalrowbytes = new('character'),
                                                     bandgapbytes = new('character'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'rowColumnOrientation') <-
    as(rowColumnOrientation, 'rowColumnOrientation')
  slot(.Object, 'multiBand') <-
    as(multiBand, 'multiBand')
  slot(.Object, 'nbits') <-
    as(nbits, 'nbits')
  slot(.Object, 'byteorder') <-
    as(byteorder, 'byteorder')
  slot(.Object, 'skipbytes') <-
    as(skipbytes, 'skipbytes')
  slot(.Object, 'bandrowbytes') <-
    as(bandrowbytes, 'bandrowbytes')
  slot(.Object, 'totalrowbytes') <-
    as(totalrowbytes, 'totalrowbytes')
  slot(.Object, 'bandgapbytes') <-
    as(bandgapbytes, 'bandgapbytes')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('binaryRasterFormat', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'binaryRasterFormat',  function(from)
  emlToS4(from))
setMethod(initialize, 'dataFormat', function(.Object,
                                             .Data = new('character'),
                                             textFormat = new('textFormat'),
                                             externallyDefinedFormat = new('externallyDefinedFormat'),
                                             binaryRasterFormat = new('binaryRasterFormat'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'textFormat') <-
    as(textFormat, 'textFormat')
  slot(.Object, 'externallyDefinedFormat') <-
    as(externallyDefinedFormat, 'externallyDefinedFormat')
  slot(.Object, 'binaryRasterFormat') <-
    as(binaryRasterFormat, 'binaryRasterFormat')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('dataFormat', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataFormat',  function(from)
  emlToS4(from))
setAs('distribution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'distribution',  function(from)
  emlToS4(from))

setMethod(c, signature('distribution'), function(x, ..., recursive = FALSE)
  new('ListOfdistribution', list(x, ...)))
setMethod(initialize, 'PhysicalType', function(.Object,
                                               authentication = character(),
                                               compressionMethod = character(),
                                               encodingMethod = character(),
                                               distribution = character(),
                                               .Data = new('character'),
                                               objectName = new('character'),
                                               size = new('size'),
                                               characterEncoding = new('character'),
                                               dataFormat = new('dataFormat'),
                                               references = new('references'),
                                               id = new('xml_attribute'),
                                               system = new('xml_attribute'),
                                               scope = new('xml_attribute'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  slot(.Object, 'authentication') <-
    c_as(authentication, 'authentication')
  slot(.Object, 'compressionMethod') <-
    c_as(compressionMethod, 'compressionMethod')
  slot(.Object, 'encodingMethod') <-
    c_as(encodingMethod, 'encodingMethod')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  .Object@.Data <-
    .Data
  slot(.Object, 'objectName') <-
    as(objectName, 'objectName')
  slot(.Object, 'size') <-
    as(size, 'size')
  slot(.Object, 'characterEncoding') <-
    as(characterEncoding, 'characterEncoding')
  slot(.Object, 'dataFormat') <-
    as(dataFormat, 'dataFormat')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('PhysicalType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'PhysicalType',  function(from)
  emlToS4(from))
setAs('online', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'online',  function(from)
  emlToS4(from))
setAs('offline', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'offline',  function(from)
  emlToS4(from))
setAs('inline', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'inline',  function(from)
  emlToS4(from))
setAs('access', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'access',  function(from)
  emlToS4(from))
setMethod(initialize, 'PhysicalDistributionType', function(.Object,
                                                           .Data = new('character'),
                                                           online = new('PhysicalOnlineType'),
                                                           offline = new('OfflineType'),
                                                           inline = new('InlineType'),
                                                           access = new('AccessType'),
                                                           references = new('references'),
                                                           id = new('xml_attribute'),
                                                           system = new('xml_attribute'),
                                                           scope = new('xml_attribute'),
                                                           schemaLocation = new('xml_attribute'),
                                                           lang = new('xml_attribute'),
                                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'online') <-
    as(online, 'online')
  slot(.Object, 'offline') <-
    as(offline, 'offline')
  slot(.Object, 'inline') <-
    as(inline, 'inline')
  slot(.Object, 'access') <-
    as(access, 'access')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('PhysicalDistributionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'PhysicalDistributionType',  function(from)
  emlToS4(from))
setAs('onlineDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'onlineDescription',  function(from)
  emlToS4(from))
setAs('url', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'url',  function(from)
  emlToS4(from))
setAs('connection', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'connection',  function(from)
  emlToS4(from))
setMethod(initialize, 'PhysicalOnlineType', function(.Object,
                                                     .Data = new('character'),
                                                     onlineDescription = new('onlineDescription'),
                                                     url = new('UrlType'),
                                                     connection = new('ConnectionType'),
                                                     connectionDefinition = new('ConnectionDefinitionType'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'onlineDescription') <-
    as(onlineDescription, 'onlineDescription')
  slot(.Object, 'url') <-
    as(url, 'url')
  slot(.Object, 'connection') <-
    as(connection, 'connection')
  slot(.Object, 'connectionDefinition') <-
    as(connectionDefinition, 'connectionDefinition')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('PhysicalOnlineType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'PhysicalOnlineType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-project.xsd  ####


setAs('researchProject', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'researchProject',  function(from)
  emlToS4(from))
setAs('title', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'title',  function(from)
  emlToS4(from))

setMethod(c, signature('title'), function(x, ..., recursive = FALSE)
  new('ListOftitle', list(x, ...)))
setAs('role', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'role',  function(from)
  emlToS4(from))

setMethod(c, signature('role'), function(x, ..., recursive = FALSE)
  new('ListOfrole', list(x, ...)))
setMethod(initialize, 'personnel', function(.Object,
                                            individualName = character(),
                                            organizationName = character(),
                                            positionName = character(),
                                            address = character(),
                                            phone = character(),
                                            electronicMailAddress = character(),
                                            onlineUrl = character(),
                                            userId = character(),
                                            role = character(),
                                            .Data = new('character'),
                                            references = new('references'),
                                            id = new('xml_attribute'),
                                            system = new('xml_attribute'),
                                            scope = new('xml_attribute'),
                                            schemaLocation = new('xml_attribute'),
                                            lang = new('xml_attribute'),
                                            slot_order = new('character')) {

  slot(.Object, 'individualName') <-
    c_as(individualName, 'individualName')
  slot(.Object, 'organizationName') <-
    c_as(organizationName, 'organizationName')
  slot(.Object, 'positionName') <-
    c_as(positionName, 'positionName')
  slot(.Object, 'address') <-
    c_as(address, 'address')
  slot(.Object, 'phone') <-
    c_as(phone, 'phone')
  slot(.Object, 'electronicMailAddress') <-
    c_as(electronicMailAddress, 'electronicMailAddress')
  slot(.Object, 'onlineUrl') <-
    c_as(onlineUrl, 'onlineUrl')
  slot(.Object, 'userId') <-
    c_as(userId, 'userId')
  slot(.Object, 'role') <-
    c_as(role, 'role')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('personnel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'personnel',  function(from)
  emlToS4(from))

setMethod(c, signature('personnel'), function(x, ..., recursive = FALSE)
  new('ListOfpersonnel', list(x, ...)))
setAs('abstract', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'abstract',  function(from)
  emlToS4(from))
setAs('funding', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'funding',  function(from)
  emlToS4(from))
setMethod(initialize, 'descriptorValue', function(.Object,
                                                  .Data = new('character'),
                                                  character = new('character'),
                                                  name_or_id = new('xml_attribute'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'name_or_id') <-
    as(name_or_id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('descriptorValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'descriptorValue',  function(from)
  emlToS4(from))

setMethod(c, signature('descriptorValue'), function(x, ..., recursive = FALSE)
  new('ListOfdescriptorValue', list(x, ...)))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setMethod(initialize, 'descriptor', function(.Object,
                                             descriptorValue = character(),
                                             citation = character(),
                                             .Data = new('character'),
                                             name = new('xml_attribute'),
                                             citableClassificationSystem = new('xml_attribute'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'descriptorValue') <-
    c_as(descriptorValue, 'descriptorValue')
  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  .Object@.Data <-
    .Data
  slot(.Object, 'name') <-
    as(name, 'xml_attribute')
  slot(.Object, 'citableClassificationSystem') <-
    as(citableClassificationSystem, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('descriptor', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'descriptor',  function(from)
  emlToS4(from))

setMethod(c, signature('descriptor'), function(x, ..., recursive = FALSE)
  new('ListOfdescriptor', list(x, ...)))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))

setMethod(c, signature('coverage'), function(x, ..., recursive = FALSE)
  new('ListOfcoverage', list(x, ...)))
setMethod(initialize, 'studyAreaDescription', function(.Object,
                                                       descriptor = character(),
                                                       citation = character(),
                                                       coverage = character(),
                                                       .Data = new('character'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  slot(.Object, 'descriptor') <-
    c_as(descriptor, 'descriptor')
  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  slot(.Object, 'coverage') <-
    c_as(coverage, 'coverage')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('studyAreaDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'studyAreaDescription',  function(from)
  emlToS4(from))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))

setMethod(c, signature('description'), function(x, ..., recursive = FALSE)
  new('ListOfdescription', list(x, ...)))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setMethod(initialize, 'designDescription', function(.Object,
                                                    description = character(),
                                                    citation = character(),
                                                    .Data = new('character'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'description') <-
    c_as(description, 'description')
  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('designDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'designDescription',  function(from)
  emlToS4(from))
setAs('relatedProject', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'relatedProject',  function(from)
  emlToS4(from))

setMethod(c, signature('relatedProject'), function(x, ..., recursive = FALSE)
  new('ListOfrelatedProject', list(x, ...)))
setMethod(initialize, 'ResearchProjectType', function(.Object,
                                                      title = character(),
                                                      personnel = character(),
                                                      relatedProject = character(),
                                                      .Data = new('character'),
                                                      abstract = new('TextType'),
                                                      funding = new('TextType'),
                                                      studyAreaDescription = new('studyAreaDescription'),
                                                      designDescription = new('designDescription'),
                                                      references = new('references'),
                                                      id = new('xml_attribute'),
                                                      system = new('xml_attribute'),
                                                      scope = new('xml_attribute'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'personnel') <-
    c_as(personnel, 'personnel')
  slot(.Object, 'relatedProject') <-
    c_as(relatedProject, 'relatedProject')
  .Object@.Data <-
    .Data
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'funding') <-
    as(funding, 'funding')
  slot(.Object, 'studyAreaDescription') <-
    as(studyAreaDescription, 'studyAreaDescription')
  slot(.Object, 'designDescription') <-
    as(designDescription, 'designDescription')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ResearchProjectType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ResearchProjectType',  function(from)
  emlToS4(from))
setAs('DescriptorType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DescriptorType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-software.xsd  ####


setAs('software', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'software',  function(from)
  emlToS4(from))
setAs('distribution', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'distribution',  function(from)
  emlToS4(from))

setMethod(c, signature('distribution'), function(x, ..., recursive = FALSE)
  new('ListOfdistribution', list(x, ...)))
setAs('size', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'size',  function(from)
  emlToS4(from))
setAs('LanguageValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'LanguageValue',  function(from)
  emlToS4(from))
setAs('LanguageCodeStandard', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'LanguageCodeStandard',  function(from)
  emlToS4(from))

setAs('language', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'language',  function(from)
  emlToS4(from))


setAs('operatingSystem', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'operatingSystem',  function(from)
  emlToS4(from))

setMethod(c, signature('operatingSystem'), function(x, ..., recursive = FALSE)
  new('ListOfoperatingSystem', list(x, ...)))
setAs('machineProcessor', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'machineProcessor',  function(from)
  emlToS4(from))

setMethod(c, signature('machineProcessor'), function(x, ..., recursive = FALSE)
  new('ListOfmachineProcessor', list(x, ...)))
setAs('virtualMachine', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'virtualMachine',  function(from)
  emlToS4(from))
setAs('diskUsage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'diskUsage',  function(from)
  emlToS4(from))
setAs('runtimeMemoryUsage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'runtimeMemoryUsage',  function(from)
  emlToS4(from))
setAs('programmingLanguage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'programmingLanguage',  function(from)
  emlToS4(from))

setMethod(c, signature('programmingLanguage'), function(x, ..., recursive = FALSE)
  new('ListOfprogrammingLanguage', list(x, ...)))
setAs('checksum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'checksum',  function(from)
  emlToS4(from))
setMethod(initialize, 'implementation', function(.Object,
                                                 distribution = character(),
                                                 language = character(),
                                                 operatingSystem = character(),
                                                 machineProcessor = character(),
                                                 programmingLanguage = character(),
                                                 .Data = new('character'),
                                                 size = new('character'),
                                                 virtualMachine = new('character'),
                                                 diskUsage = new('character'),
                                                 runtimeMemoryUsage = new('character'),
                                                 checksum = new('character'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  slot(.Object, 'language') <-
    c_as(language, 'language')
  slot(.Object, 'operatingSystem') <-
    c_as(operatingSystem, 'operatingSystem')
  slot(.Object, 'machineProcessor') <-
    c_as(machineProcessor, 'machineProcessor')
  slot(.Object, 'programmingLanguage') <-
    c_as(programmingLanguage, 'programmingLanguage')
  .Object@.Data <-
    .Data
  slot(.Object, 'size') <-
    as(size, 'size')
  slot(.Object, 'virtualMachine') <-
    as(virtualMachine, 'virtualMachine')
  slot(.Object, 'diskUsage') <-
    as(diskUsage, 'diskUsage')
  slot(.Object, 'runtimeMemoryUsage') <-
    as(runtimeMemoryUsage, 'runtimeMemoryUsage')
  slot(.Object, 'checksum') <-
    as(checksum, 'checksum')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('implementation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'implementation',  function(from)
  emlToS4(from))

setMethod(c, signature('implementation'), function(x, ..., recursive = FALSE)
  new('ListOfimplementation', list(x, ...)))
setAs('licenseURL', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'licenseURL',  function(from)
  emlToS4(from))

setMethod(c, signature('licenseURL'), function(x, ..., recursive = FALSE)
  new('ListOflicenseURL', list(x, ...)))
setAs('license', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'license',  function(from)
  emlToS4(from))

setMethod(c, signature('license'), function(x, ..., recursive = FALSE)
  new('ListOflicense', list(x, ...)))
setAs('version', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'version',  function(from)
  emlToS4(from))
setAs('project', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'project',  function(from)
  emlToS4(from))
setMethod(initialize, 'SoftwareType', function(.Object,
                                               alternateIdentifier = character(),
                                               title = character(),
                                               creator = character(),
                                               metadataProvider = character(),
                                               associatedParty = character(),
                                               keywordSet = character(),
                                               additionalInfo = character(),
                                               distribution = character(),
                                               implementation = character(),
                                               licenseURL = character(),
                                               license = character(),
                                               .Data = new('character'),
                                               shortName = new('character'),
                                               pubDate = new('yearDate'),
                                               language = new('character'),
                                               series = new('character'),
                                               abstract = new('TextType'),
                                               intellectualRights = new('TextType'),
                                               coverage = new('Coverage'),
                                               version = new('character'),
                                               project = new('ResearchProjectType'),
                                               references = new('references'),
                                               id = new('xml_attribute'),
                                               system = new('xml_attribute'),
                                               scope = new('xml_attribute'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'creator') <-
    c_as(creator, 'creator')
  slot(.Object, 'metadataProvider') <-
    c_as(metadataProvider, 'metadataProvider')
  slot(.Object, 'associatedParty') <-
    c_as(associatedParty, 'associatedParty')
  slot(.Object, 'keywordSet') <-
    c_as(keywordSet, 'keywordSet')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  slot(.Object, 'implementation') <-
    c_as(implementation, 'implementation')
  slot(.Object, 'licenseURL') <-
    c_as(licenseURL, 'licenseURL')
  slot(.Object, 'license') <-
    c_as(license, 'license')
  .Object@.Data <-
    .Data
  slot(.Object, 'shortName') <-
    as(shortName, 'shortName')
  slot(.Object, 'pubDate') <-
    as(pubDate, 'pubDate')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'series') <-
    as(series, 'series')
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'intellectualRights') <-
    as(intellectualRights, 'intellectualRights')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'version') <-
    as(version, 'version')
  slot(.Object, 'project') <-
    as(project, 'project')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SoftwareType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SoftwareType',  function(from)
  emlToS4(from))
setAs('Action', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Action',  function(from)
  emlToS4(from))
setAs('action', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'action',  function(from)
  emlToS4(from))
setMethod(initialize, 'dependency', function(.Object,
                                             .Data = new('character'),
                                             action = new('Action'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'action') <-
    as(action, 'action')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('dependency', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dependency',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-protocol.xsd  ####


setAs('proceduralStep', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'proceduralStep',  function(from)
  emlToS4(from))

setMethod(c, signature('proceduralStep'), function(x, ..., recursive = FALSE)
  new('ListOfproceduralStep', list(x, ...)))
setMethod(initialize, 'ProtocolType', function(.Object,
                                               alternateIdentifier = character(),
                                               title = character(),
                                               creator = character(),
                                               metadataProvider = character(),
                                               associatedParty = character(),
                                               keywordSet = character(),
                                               additionalInfo = character(),
                                               distribution = character(),
                                               proceduralStep = character(),
                                               .Data = new('character'),
                                               shortName = new('character'),
                                               pubDate = new('yearDate'),
                                               language = new('character'),
                                               series = new('character'),
                                               abstract = new('TextType'),
                                               intellectualRights = new('TextType'),
                                               coverage = new('Coverage'),
                                               references = new('references'),
                                               id = new('xml_attribute'),
                                               system = new('xml_attribute'),
                                               scope = new('xml_attribute'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'creator') <-
    c_as(creator, 'creator')
  slot(.Object, 'metadataProvider') <-
    c_as(metadataProvider, 'metadataProvider')
  slot(.Object, 'associatedParty') <-
    c_as(associatedParty, 'associatedParty')
  slot(.Object, 'keywordSet') <-
    c_as(keywordSet, 'keywordSet')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  slot(.Object, 'proceduralStep') <-
    c_as(proceduralStep, 'proceduralStep')
  .Object@.Data <-
    .Data
  slot(.Object, 'shortName') <-
    as(shortName, 'shortName')
  slot(.Object, 'pubDate') <-
    as(pubDate, 'pubDate')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'series') <-
    as(series, 'series')
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'intellectualRights') <-
    as(intellectualRights, 'intellectualRights')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ProtocolType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ProtocolType',  function(from)
  emlToS4(from))
setAs('protocol', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'protocol',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-methods.xsd  ####


setAs('methods', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'methods',  function(from)
  emlToS4(from))
setAs('dataSource', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataSource',  function(from)
  emlToS4(from))

setMethod(c, signature('dataSource'), function(x, ..., recursive = FALSE)
  new('ListOfdataSource', list(x, ...)))
setMethod(initialize, 'methodStep', function(.Object,
                                             citation = character(),
                                             protocol = character(),
                                             instrumentation = character(),
                                             software = character(),
                                             subStep = character(),
                                             dataSource = character(),
                                             .Data = new('character'),
                                             description = new('TextType'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  slot(.Object, 'protocol') <-
    c_as(protocol, 'protocol')
  slot(.Object, 'instrumentation') <-
    c_as(instrumentation, 'instrumentation')
  slot(.Object, 'software') <-
    c_as(software, 'software')
  slot(.Object, 'subStep') <-
    c_as(subStep, 'subStep')
  slot(.Object, 'dataSource') <-
    c_as(dataSource, 'dataSource')
  .Object@.Data <-
    .Data
  slot(.Object, 'description') <-
    as(description, 'description')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('methodStep', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'methodStep',  function(from)
  emlToS4(from))

setMethod(c, signature('methodStep'), function(x, ..., recursive = FALSE)
  new('ListOfmethodStep', list(x, ...)))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))

setMethod(c, signature('coverage'), function(x, ..., recursive = FALSE)
  new('ListOfcoverage', list(x, ...)))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))

setMethod(c, signature('description'), function(x, ..., recursive = FALSE)
  new('ListOfdescription', list(x, ...)))
setMethod(initialize, 'studyExtent', function(.Object,
                                              coverage = character(),
                                              description = character(),
                                              .Data = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'coverage') <-
    c_as(coverage, 'coverage')
  slot(.Object, 'description') <-
    c_as(description, 'description')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('studyExtent', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'studyExtent',  function(from)
  emlToS4(from))
setAs('samplingDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'samplingDescription',  function(from)
  emlToS4(from))
setAs('referencedEntityId', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'referencedEntityId',  function(from)
  emlToS4(from))

setMethod(c, signature('referencedEntityId'), function(x, ..., recursive = FALSE)
  new('ListOfreferencedEntityId', list(x, ...)))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))

setMethod(c, signature('coverage'), function(x, ..., recursive = FALSE)
  new('ListOfcoverage', list(x, ...)))
setMethod(initialize, 'spatialSamplingUnits', function(.Object,
                                                       referencedEntityId = character(),
                                                       coverage = character(),
                                                       .Data = new('character'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  slot(.Object, 'referencedEntityId') <-
    c_as(referencedEntityId, 'referencedEntityId')
  slot(.Object, 'coverage') <-
    c_as(coverage, 'coverage')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('spatialSamplingUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialSamplingUnits',  function(from)
  emlToS4(from))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setMethod(initialize, 'sampling', function(.Object,
                                           citation = character(),
                                           .Data = new('character'),
                                           studyExtent = new('studyExtent'),
                                           samplingDescription = new('TextType'),
                                           spatialSamplingUnits = new('spatialSamplingUnits'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  .Object@.Data <-
    .Data
  slot(.Object, 'studyExtent') <-
    as(studyExtent, 'studyExtent')
  slot(.Object, 'samplingDescription') <-
    as(samplingDescription, 'samplingDescription')
  slot(.Object, 'spatialSamplingUnits') <-
    as(spatialSamplingUnits, 'spatialSamplingUnits')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('sampling', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'sampling',  function(from)
  emlToS4(from))

setMethod(c, signature('sampling'), function(x, ..., recursive = FALSE)
  new('ListOfsampling', list(x, ...)))
setAs('qualityControl', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'qualityControl',  function(from)
  emlToS4(from))

setMethod(c, signature('qualityControl'), function(x, ..., recursive = FALSE)
  new('ListOfqualityControl', list(x, ...)))
setMethod(initialize, 'MethodsType', function(.Object,
                                              methodStep = character(),
                                              sampling = character(),
                                              qualityControl = character(),
                                              .Data = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'methodStep') <-
    c_as(methodStep, 'methodStep')
  slot(.Object, 'sampling') <-
    c_as(sampling, 'sampling')
  slot(.Object, 'qualityControl') <-
    c_as(qualityControl, 'qualityControl')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('MethodsType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'MethodsType',  function(from)
  emlToS4(from))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('protocol', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'protocol',  function(from)
  emlToS4(from))

setMethod(c, signature('protocol'), function(x, ..., recursive = FALSE)
  new('ListOfprotocol', list(x, ...)))
setAs('instrumentation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'instrumentation',  function(from)
  emlToS4(from))

setMethod(c, signature('instrumentation'), function(x, ..., recursive = FALSE)
  new('ListOfinstrumentation', list(x, ...)))
setAs('software', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'software',  function(from)
  emlToS4(from))

setMethod(c, signature('software'), function(x, ..., recursive = FALSE)
  new('ListOfsoftware', list(x, ...)))
setAs('subStep', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'subStep',  function(from)
  emlToS4(from))

setMethod(c, signature('subStep'), function(x, ..., recursive = FALSE)
  new('ListOfsubStep', list(x, ...)))
setMethod(initialize, 'ProcedureStepType', function(.Object,
                                                    citation = character(),
                                                    protocol = character(),
                                                    instrumentation = character(),
                                                    software = character(),
                                                    subStep = character(),
                                                    .Data = new('character'),
                                                    description = new('TextType'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  slot(.Object, 'protocol') <-
    c_as(protocol, 'protocol')
  slot(.Object, 'instrumentation') <-
    c_as(instrumentation, 'instrumentation')
  slot(.Object, 'software') <-
    c_as(software, 'software')
  slot(.Object, 'subStep') <-
    c_as(subStep, 'subStep')
  .Object@.Data <-
    .Data
  slot(.Object, 'description') <-
    as(description, 'description')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ProcedureStepType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ProcedureStepType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-attribute.xsd  ####


setAs('attribute', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attribute',  function(from)
  emlToS4(from))
setAs('attribute', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attribute',  function(from)
  emlToS4(from))

setMethod(c, signature('attribute'), function(x, ..., recursive = FALSE)
  new('ListOfattribute', list(x, ...)))
setMethod(initialize, 'AttributeListType', function(.Object,
                                                    attribute = character(),
                                                    .Data = new('character'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'attribute') <-
    c_as(attribute, 'attribute')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('AttributeListType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'AttributeListType',  function(from)
  emlToS4(from))
setAs('attributeName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeName',  function(from)
  emlToS4(from))
setAs('attributeLabel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeLabel',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeLabel'), function(x, ..., recursive = FALSE)
  new('ListOfattributeLabel', list(x, ...)))
setAs('attributeDefinition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeDefinition',  function(from)
  emlToS4(from))
setMethod(initialize, 'storageType', function(.Object,
                                              .Data = new('character'),
                                              character = new('character'),
                                              typeSystem = new('xml_attribute'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'typeSystem') <-
    as(typeSystem, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('storageType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'storageType',  function(from)
  emlToS4(from))

setMethod(c, signature('storageType'), function(x, ..., recursive = FALSE)
  new('ListOfstorageType', list(x, ...)))
setAs('nonNumericDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'nonNumericDomain',  function(from)
  emlToS4(from))
setMethod(initialize, 'nominal', function(.Object,
                                          .Data = new('character'),
                                          nonNumericDomain = new('NonNumericDomainType'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'nonNumericDomain') <-
    as(nonNumericDomain, 'nonNumericDomain')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('nominal', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'nominal',  function(from)
  emlToS4(from))
setAs('nonNumericDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'nonNumericDomain',  function(from)
  emlToS4(from))
setMethod(initialize, 'ordinal', function(.Object,
                                          .Data = new('character'),
                                          nonNumericDomain = new('NonNumericDomainType'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'nonNumericDomain') <-
    as(nonNumericDomain, 'nonNumericDomain')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ordinal', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ordinal',  function(from)
  emlToS4(from))
setAs('unit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'unit',  function(from)
  emlToS4(from))
setAs('precision', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'precision',  function(from)
  emlToS4(from))
setAs('numericDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numericDomain',  function(from)
  emlToS4(from))
setMethod(initialize, 'interval', function(.Object,
                                           .Data = new('character'),
                                           unit = new('UnitType'),
                                           precision = new('PrecisionType'),
                                           numericDomain = new('NumericDomainType'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'unit') <-
    as(unit, 'unit')
  slot(.Object, 'precision') <-
    as(precision, 'precision')
  slot(.Object, 'numericDomain') <-
    as(numericDomain, 'numericDomain')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('interval', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'interval',  function(from)
  emlToS4(from))
setAs('unit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'unit',  function(from)
  emlToS4(from))
setAs('precision', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'precision',  function(from)
  emlToS4(from))
setAs('numericDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numericDomain',  function(from)
  emlToS4(from))
setMethod(initialize, 'ratio', function(.Object,
                                        .Data = new('character'),
                                        unit = new('UnitType'),
                                        precision = new('PrecisionType'),
                                        numericDomain = new('NumericDomainType'),
                                        schemaLocation = new('xml_attribute'),
                                        lang = new('xml_attribute'),
                                        slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'unit') <-
    as(unit, 'unit')
  slot(.Object, 'precision') <-
    as(precision, 'precision')
  slot(.Object, 'numericDomain') <-
    as(numericDomain, 'numericDomain')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ratio', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ratio',  function(from)
  emlToS4(from))
setAs('formatString', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'formatString',  function(from)
  emlToS4(from))
setAs('dateTimePrecision', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dateTimePrecision',  function(from)
  emlToS4(from))
setAs('dateTimeDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dateTimeDomain',  function(from)
  emlToS4(from))
setMethod(initialize, 'dateTime', function(.Object,
                                           .Data = new('character'),
                                           formatString = new('character'),
                                           dateTimePrecision = new('character'),
                                           dateTimeDomain = new('DateTimeDomainType'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'formatString') <-
    as(formatString, 'formatString')
  slot(.Object, 'dateTimePrecision') <-
    as(dateTimePrecision, 'dateTimePrecision')
  slot(.Object, 'dateTimeDomain') <-
    as(dateTimeDomain, 'dateTimeDomain')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('dateTime', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dateTime',  function(from)
  emlToS4(from))
setMethod(initialize, 'measurementScale', function(.Object,
                                                   .Data = new('character'),
                                                   nominal = new('nominal'),
                                                   ordinal = new('ordinal'),
                                                   interval = new('interval'),
                                                   ratio = new('ratio'),
                                                   dateTime = new('dateTime'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'nominal') <-
    as(nominal, 'nominal')
  slot(.Object, 'ordinal') <-
    as(ordinal, 'ordinal')
  slot(.Object, 'interval') <-
    as(interval, 'interval')
  slot(.Object, 'ratio') <-
    as(ratio, 'ratio')
  slot(.Object, 'dateTime') <-
    as(dateTime, 'dateTime')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('measurementScale', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'measurementScale',  function(from)
  emlToS4(from))
setAs('code', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'code',  function(from)
  emlToS4(from))
setAs('codeExplanation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'codeExplanation',  function(from)
  emlToS4(from))
setMethod(initialize, 'missingValueCode', function(.Object,
                                                   .Data = new('character'),
                                                   code = new('character'),
                                                   codeExplanation = new('character'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'code') <-
    as(code, 'code')
  slot(.Object, 'codeExplanation') <-
    as(codeExplanation, 'codeExplanation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('missingValueCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'missingValueCode',  function(from)
  emlToS4(from))

setMethod(c, signature('missingValueCode'), function(x, ..., recursive = FALSE)
  new('ListOfmissingValueCode', list(x, ...)))
setAs('accuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'accuracy',  function(from)
  emlToS4(from))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))
setAs('methods', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'methods',  function(from)
  emlToS4(from))
setMethod(initialize, 'AttributeType', function(.Object,
                                                attributeLabel = character(),
                                                storageType = character(),
                                                missingValueCode = character(),
                                                .Data = new('character'),
                                                attributeName = new('character'),
                                                attributeDefinition = new('character'),
                                                measurementScale = new('measurementScale'),
                                                accuracy = new('Accuracy'),
                                                coverage = new('Coverage'),
                                                methods = new('MethodsType'),
                                                references = new('references'),
                                                id = new('xml_attribute'),
                                                system = new('xml_attribute'),
                                                scope = new('xml_attribute'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'attributeLabel') <-
    c_as(attributeLabel, 'attributeLabel')
  slot(.Object, 'storageType') <-
    c_as(storageType, 'storageType')
  slot(.Object, 'missingValueCode') <-
    c_as(missingValueCode, 'missingValueCode')
  .Object@.Data <-
    .Data
  slot(.Object, 'attributeName') <-
    as(attributeName, 'attributeName')
  slot(.Object, 'attributeDefinition') <-
    as(attributeDefinition, 'attributeDefinition')
  slot(.Object, 'measurementScale') <-
    as(measurementScale, 'measurementScale')
  slot(.Object, 'accuracy') <-
    as(accuracy, 'accuracy')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('AttributeType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'AttributeType',  function(from)
  emlToS4(from))
setAs('attributeAccuracyReport', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeAccuracyReport',  function(from)
  emlToS4(from))
setAs('attributeAccuracyValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeAccuracyValue',  function(from)
  emlToS4(from))
setAs('attributeAccuracyExplanation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeAccuracyExplanation',  function(from)
  emlToS4(from))
setMethod(initialize, 'quantitativeAttributeAccuracyAssessment', function(.Object,
                                                                          .Data = new('character'),
                                                                          attributeAccuracyValue = new('character'),
                                                                          attributeAccuracyExplanation = new('character'),
                                                                          schemaLocation = new('xml_attribute'),
                                                                          lang = new('xml_attribute'),
                                                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'attributeAccuracyValue') <-
    as(attributeAccuracyValue, 'attributeAccuracyValue')
  slot(.Object, 'attributeAccuracyExplanation') <-
    as(attributeAccuracyExplanation,
       'attributeAccuracyExplanation')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('quantitativeAttributeAccuracyAssessment', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAttributeAccuracyAssessment',  function(from)
  emlToS4(from))

setMethod(c, signature('quantitativeAttributeAccuracyAssessment'), function(x, ..., recursive = FALSE)
  new(
    'ListOfquantitativeAttributeAccuracyAssessment',
    list(x, ...)
  ))
setMethod(initialize, 'Accuracy', function(.Object,
                                           quantitativeAttributeAccuracyAssessment = character(),
                                           .Data = new('character'),
                                           attributeAccuracyReport = new('character'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'quantitativeAttributeAccuracyAssessment') <-
    c_as(
      quantitativeAttributeAccuracyAssessment,
      'quantitativeAttributeAccuracyAssessment'
    )
  .Object@.Data <-
    .Data
  slot(.Object, 'attributeAccuracyReport') <-
    as(attributeAccuracyReport, 'attributeAccuracyReport')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('Accuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'Accuracy',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('standardUnit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'standardUnit',  function(from)
  emlToS4(from))
setAs('customUnit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'customUnit',  function(from)
  emlToS4(from))
setMethod(initialize, 'UnitType', function(.Object,
                                           .Data = new('character'),
                                           standardUnit = new('StandardUnitDictionary'),
                                           customUnit = new('character'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'standardUnit') <-
    as(standardUnit, 'standardUnit')
  slot(.Object, 'customUnit') <-
    as(customUnit, 'customUnit')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('UnitType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'UnitType',  function(from)
  emlToS4(from))
setAs('PrecisionType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'PrecisionType',  function(from)
  emlToS4(from))
setAs('code', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'code',  function(from)
  emlToS4(from))
setAs('definition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'definition',  function(from)
  emlToS4(from))
setAs('source', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'source',  function(from)
  emlToS4(from))
setMethod(initialize, 'codeDefinition', function(.Object,
                                                 .Data = new('character'),
                                                 code = new('character'),
                                                 definition = new('character'),
                                                 source = new('character'),
                                                 order = new('xml_attribute'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'code') <-
    as(code, 'code')
  slot(.Object, 'definition') <-
    as(definition, 'definition')
  slot(.Object, 'source') <-
    as(source, 'source')
  slot(.Object, 'order') <-
    as(order, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('codeDefinition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'codeDefinition',  function(from)
  emlToS4(from))

setMethod(c, signature('codeDefinition'), function(x, ..., recursive = FALSE)
  new('ListOfcodeDefinition', list(x, ...)))
setAs('codesetName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'codesetName',  function(from)
  emlToS4(from))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('codesetURL', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'codesetURL',  function(from)
  emlToS4(from))

setMethod(c, signature('codesetURL'), function(x, ..., recursive = FALSE)
  new('ListOfcodesetURL', list(x, ...)))
setMethod(initialize, 'externalCodeSet', function(.Object,
                                                  citation = character(),
                                                  codesetURL = character(),
                                                  .Data = new('character'),
                                                  codesetName = new('character'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'citation') <-
    c_as(citation, 'citation')
  slot(.Object, 'codesetURL') <-
    c_as(codesetURL, 'codesetURL')
  .Object@.Data <-
    .Data
  slot(.Object, 'codesetName') <-
    as(codesetName, 'codesetName')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('externalCodeSet', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'externalCodeSet',  function(from)
  emlToS4(from))
setAs('entityReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityReference',  function(from)
  emlToS4(from))
setAs('valueAttributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'valueAttributeReference',  function(from)
  emlToS4(from))
setAs('definitionAttributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'definitionAttributeReference',  function(from)
  emlToS4(from))
setAs('orderAttributeReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'orderAttributeReference',  function(from)
  emlToS4(from))
setMethod(initialize, 'entityCodeList', function(.Object,
                                                 .Data = new('character'),
                                                 entityReference = new('character'),
                                                 valueAttributeReference = new('character'),
                                                 definitionAttributeReference = new('character'),
                                                 orderAttributeReference = new('character'),
                                                 schemaLocation = new('xml_attribute'),
                                                 lang = new('xml_attribute'),
                                                 slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'entityReference') <-
    as(entityReference, 'entityReference')
  slot(.Object, 'valueAttributeReference') <-
    as(valueAttributeReference, 'valueAttributeReference')
  slot(.Object, 'definitionAttributeReference') <-
    as(definitionAttributeReference,
       'definitionAttributeReference')
  slot(.Object, 'orderAttributeReference') <-
    as(orderAttributeReference, 'orderAttributeReference')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('entityCodeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityCodeList',  function(from)
  emlToS4(from))
setMethod(initialize, 'enumeratedDomain', function(.Object,
                                                   codeDefinition = character(),
                                                   .Data = new('character'),
                                                   externalCodeSet = new('externalCodeSet'),
                                                   entityCodeList = new('entityCodeList'),
                                                   enforced = new('xml_attribute'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'codeDefinition') <-
    c_as(codeDefinition, 'codeDefinition')
  .Object@.Data <-
    .Data
  slot(.Object, 'externalCodeSet') <-
    as(externalCodeSet, 'externalCodeSet')
  slot(.Object, 'entityCodeList') <-
    as(entityCodeList, 'entityCodeList')
  slot(.Object, 'enforced') <-
    as(enforced, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('enumeratedDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'enumeratedDomain',  function(from)
  emlToS4(from))

setMethod(c, signature('enumeratedDomain'), function(x, ..., recursive = FALSE)
  new('ListOfenumeratedDomain', list(x, ...)))
setAs('definition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'definition',  function(from)
  emlToS4(from))
setAs('pattern', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pattern',  function(from)
  emlToS4(from))

setMethod(c, signature('pattern'), function(x, ..., recursive = FALSE)
  new('ListOfpattern', list(x, ...)))
setAs('source', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'source',  function(from)
  emlToS4(from))
setMethod(initialize, 'textDomain', function(.Object,
                                             pattern = character(),
                                             .Data = new('character'),
                                             definition = new('character'),
                                             source = new('character'),
                                             schemaLocation = new('xml_attribute'),
                                             lang = new('xml_attribute'),
                                             slot_order = new('character')) {

  slot(.Object, 'pattern') <-
    c_as(pattern, 'pattern')
  .Object@.Data <-
    .Data
  slot(.Object, 'definition') <-
    as(definition, 'definition')
  slot(.Object, 'source') <-
    as(source, 'source')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('textDomain', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'textDomain',  function(from)
  emlToS4(from))

setMethod(c, signature('textDomain'), function(x, ..., recursive = FALSE)
  new('ListOftextDomain', list(x, ...)))
setMethod(initialize, 'NonNumericDomainType', function(.Object,
                                                       enumeratedDomain = character(),
                                                       textDomain = character(),
                                                       .Data = new('character'),
                                                       references = new('references'),
                                                       id = new('xml_attribute'),
                                                       schemaLocation = new('xml_attribute'),
                                                       lang = new('xml_attribute'),
                                                       slot_order = new('character')) {

  slot(.Object, 'enumeratedDomain') <-
    c_as(enumeratedDomain, 'enumeratedDomain')
  slot(.Object, 'textDomain') <-
    c_as(textDomain, 'textDomain')
  .Object@.Data <-
    .Data
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('NonNumericDomainType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'NonNumericDomainType',  function(from)
  emlToS4(from))
setAs('numberType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numberType',  function(from)
  emlToS4(from))
setMethod(initialize, 'NumericDomainType', function(.Object,
                                                    .Data = new('character'),
                                                    numberType = new('NumberType'),
                                                    BoundsGroup = new('BoundsGroup'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'numberType') <-
    as(numberType, 'numberType')
  slot(.Object, 'BoundsGroup') <-
    as(BoundsGroup, 'BoundsGroup')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('NumericDomainType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'NumericDomainType',  function(from)
  emlToS4(from))
setMethod(initialize, 'DateTimeDomainType', function(.Object,
                                                     .Data = new('character'),
                                                     BoundsDateGroup = new('BoundsDateGroup'),
                                                     references = new('references'),
                                                     id = new('xml_attribute'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'BoundsDateGroup') <-
    as(BoundsDateGroup, 'BoundsDateGroup')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DateTimeDomainType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DateTimeDomainType',  function(from)
  emlToS4(from))
setMethod(initialize, 'minimum', function(.Object,
                                          .Data = new('character'),
                                          character = new('character'),
                                          exclusive = new('xml_attribute'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'exclusive') <-
    as(exclusive, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('minimum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'minimum',  function(from)
  emlToS4(from))
setMethod(initialize, 'maximum', function(.Object,
                                          .Data = new('character'),
                                          character = new('character'),
                                          exclusive = new('xml_attribute'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'exclusive') <-
    as(exclusive, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('maximum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'maximum',  function(from)
  emlToS4(from))
setMethod(initialize, 'bounds', function(.Object,
                                         .Data = new('character'),
                                         minimum = new('minimum'),
                                         maximum = new('maximum'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'minimum') <-
    as(minimum, 'minimum')
  slot(.Object, 'maximum') <-
    as(maximum, 'maximum')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('bounds', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bounds',  function(from)
  emlToS4(from))

setMethod(c, signature('bounds'), function(x, ..., recursive = FALSE)
  new('ListOfbounds', list(x, ...)))
setMethod(initialize, 'BoundsGroup', function(.Object,
                                              bounds = character(),
                                              .Data = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'bounds') <-
    c_as(bounds, 'bounds')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('BoundsGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'BoundsGroup',  function(from)
  emlToS4(from))
setMethod(initialize, 'minimum', function(.Object,
                                          .Data = new('character'),
                                          character = new('character'),
                                          exclusive = new('xml_attribute'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'exclusive') <-
    as(exclusive, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('minimum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'minimum',  function(from)
  emlToS4(from))
setMethod(initialize, 'maximum', function(.Object,
                                          .Data = new('character'),
                                          character = new('character'),
                                          exclusive = new('xml_attribute'),
                                          schemaLocation = new('xml_attribute'),
                                          lang = new('xml_attribute'),
                                          slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'exclusive') <-
    as(exclusive, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('maximum', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'maximum',  function(from)
  emlToS4(from))
setMethod(initialize, 'bounds', function(.Object,
                                         .Data = new('character'),
                                         minimum = new('minimum'),
                                         maximum = new('maximum'),
                                         schemaLocation = new('xml_attribute'),
                                         lang = new('xml_attribute'),
                                         slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'minimum') <-
    as(minimum, 'minimum')
  slot(.Object, 'maximum') <-
    as(maximum, 'maximum')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('bounds', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bounds',  function(from)
  emlToS4(from))

setMethod(c, signature('bounds'), function(x, ..., recursive = FALSE)
  new('ListOfbounds', list(x, ...)))
setMethod(initialize, 'BoundsDateGroup', function(.Object,
                                                  bounds = character(),
                                                  .Data = new('character'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'bounds') <-
    c_as(bounds, 'bounds')
  .Object@.Data <-
    .Data
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('BoundsDateGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'BoundsDateGroup',  function(from)
  emlToS4(from))
setAs('NumberType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'NumberType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-entity.xsd  ####


setAs('otherEntity', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'otherEntity',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('entityType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityType',  function(from)
  emlToS4(from))
setMethod(initialize, 'OtherEntityType', function(.Object,
                                                  alternateIdentifier = character(),
                                                  physical = character(),
                                                  additionalInfo = character(),
                                                  constraint = character(),
                                                  .Data = new('character'),
                                                  entityName = new('character'),
                                                  entityDescription = new('character'),
                                                  coverage = new('Coverage'),
                                                  methods = new('MethodsType'),
                                                  attributeList = new('AttributeListType'),
                                                  entityType = new('character'),
                                                  references = new('references'),
                                                  id = new('xml_attribute'),
                                                  system = new('xml_attribute'),
                                                  scope = new('xml_attribute'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'entityType') <-
    as(entityType, 'entityType')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('OtherEntityType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'OtherEntityType',  function(from)
  emlToS4(from))
setMethod(initialize, 'alternateIdentifier', function(.Object,
                                                      .Data = new('character'),
                                                      character = new('character'),
                                                      system = new('xml_attribute'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'character') <-
    as(character, 'character')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('alternateIdentifier', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'alternateIdentifier',  function(from)
  emlToS4(from))

setMethod(c, signature('alternateIdentifier'), function(x, ..., recursive = FALSE)
  new('ListOfalternateIdentifier', list(x, ...)))
setAs('entityName', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityName',  function(from)
  emlToS4(from))
setAs('entityDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'entityDescription',  function(from)
  emlToS4(from))
setAs('physical', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'physical',  function(from)
  emlToS4(from))

setMethod(c, signature('physical'), function(x, ..., recursive = FALSE)
  new('ListOfphysical', list(x, ...)))
setAs('coverage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'coverage',  function(from)
  emlToS4(from))
setAs('methods', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'methods',  function(from)
  emlToS4(from))
setAs('additionalInfo', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'additionalInfo',  function(from)
  emlToS4(from))

setMethod(c, signature('additionalInfo'), function(x, ..., recursive = FALSE)
  new('ListOfadditionalInfo', list(x, ...)))
setMethod(initialize, 'EntityGroup', function(.Object,
                                              alternateIdentifier = character(),
                                              physical = character(),
                                              additionalInfo = character(),
                                              .Data = new('character'),
                                              entityName = new('character'),
                                              entityDescription = new('character'),
                                              coverage = new('Coverage'),
                                              methods = new('MethodsType'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('EntityGroup', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'EntityGroup',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-dataTable.xsd  ####


setAs('dataTable', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataTable',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('caseSensitive', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'caseSensitive',  function(from)
  emlToS4(from))
setAs('numberOfRecords', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numberOfRecords',  function(from)
  emlToS4(from))
setMethod(initialize, 'DataTableType', function(.Object,
                                                alternateIdentifier = character(),
                                                physical = character(),
                                                additionalInfo = character(),
                                                constraint = character(),
                                                .Data = new('character'),
                                                entityName = new('character'),
                                                entityDescription = new('character'),
                                                coverage = new('Coverage'),
                                                methods = new('MethodsType'),
                                                attributeList = new('AttributeListType'),
                                                caseSensitive = new('caseSensitive'),
                                                numberOfRecords = new('character'),
                                                references = new('references'),
                                                id = new('xml_attribute'),
                                                system = new('xml_attribute'),
                                                scope = new('xml_attribute'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'caseSensitive') <-
    as(caseSensitive, 'caseSensitive')
  slot(.Object, 'numberOfRecords') <-
    as(numberOfRecords, 'numberOfRecords')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DataTableType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DataTableType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-view.xsd  ####


setAs('view', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'view',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('queryStatement', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'queryStatement',  function(from)
  emlToS4(from))
setMethod(initialize, 'ViewType', function(.Object,
                                           alternateIdentifier = character(),
                                           physical = character(),
                                           additionalInfo = character(),
                                           constraint = character(),
                                           .Data = new('character'),
                                           entityName = new('character'),
                                           entityDescription = new('character'),
                                           coverage = new('Coverage'),
                                           methods = new('MethodsType'),
                                           attributeList = new('AttributeListType'),
                                           queryStatement = new('character'),
                                           references = new('references'),
                                           id = new('xml_attribute'),
                                           system = new('xml_attribute'),
                                           scope = new('xml_attribute'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'queryStatement') <-
    as(queryStatement, 'queryStatement')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ViewType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ViewType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-storedProcedure.xsd  ####


setAs('storedProcedure', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'storedProcedure',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('parameter', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'parameter',  function(from)
  emlToS4(from))

setMethod(c, signature('parameter'), function(x, ..., recursive = FALSE)
  new('ListOfparameter', list(x, ...)))
setMethod(initialize, 'StoredProcedureType', function(.Object,
                                                      alternateIdentifier = character(),
                                                      physical = character(),
                                                      additionalInfo = character(),
                                                      constraint = character(),
                                                      parameter = character(),
                                                      .Data = new('character'),
                                                      entityName = new('character'),
                                                      entityDescription = new('character'),
                                                      coverage = new('Coverage'),
                                                      methods = new('MethodsType'),
                                                      attributeList = new('AttributeListType'),
                                                      references = new('references'),
                                                      id = new('xml_attribute'),
                                                      system = new('xml_attribute'),
                                                      scope = new('xml_attribute'),
                                                      schemaLocation = new('xml_attribute'),
                                                      lang = new('xml_attribute'),
                                                      slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  slot(.Object, 'parameter') <-
    c_as(parameter, 'parameter')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('StoredProcedureType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'StoredProcedureType',  function(from)
  emlToS4(from))
setAs('name', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'name',  function(from)
  emlToS4(from))
setAs('domainDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'domainDescription',  function(from)
  emlToS4(from))
setAs('required', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'required',  function(from)
  emlToS4(from))
setAs('repeats', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'repeats',  function(from)
  emlToS4(from))
setMethod(initialize, 'ParameterType', function(.Object,
                                                .Data = new('character'),
                                                name = new('character'),
                                                domainDescription = new('character'),
                                                required = new('character'),
                                                repeats = new('character'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'name') <-
    as(name, 'name')
  slot(.Object, 'domainDescription') <-
    as(domainDescription, 'domainDescription')
  slot(.Object, 'required') <-
    as(required, 'required')
  slot(.Object, 'repeats') <-
    as(repeats, 'repeats')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('ParameterType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ParameterType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialVector.xsd  ####


setAs('spatialVector', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialVector',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('geometry', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geometry',  function(from)
  emlToS4(from))

setMethod(c, signature('geometry'), function(x, ..., recursive = FALSE)
  new('ListOfgeometry', list(x, ...)))
setAs('geometricObjectCount', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'geometricObjectCount',  function(from)
  emlToS4(from))
setAs('topologyLevel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'topologyLevel',  function(from)
  emlToS4(from))
setAs('spatialReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialReference',  function(from)
  emlToS4(from))
setAs('horizontalAccuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizontalAccuracy',  function(from)
  emlToS4(from))
setAs('verticalAccuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'verticalAccuracy',  function(from)
  emlToS4(from))
setMethod(initialize, 'SpatialVectorType', function(.Object,
                                                    alternateIdentifier = character(),
                                                    physical = character(),
                                                    additionalInfo = character(),
                                                    constraint = character(),
                                                    geometry = character(),
                                                    .Data = new('character'),
                                                    entityName = new('character'),
                                                    entityDescription = new('character'),
                                                    coverage = new('Coverage'),
                                                    methods = new('MethodsType'),
                                                    attributeList = new('AttributeListType'),
                                                    geometricObjectCount = new('character'),
                                                    topologyLevel = new('TopologyLevel'),
                                                    spatialReference = new('SpatialReferenceType'),
                                                    horizontalAccuracy = new('DataQuality'),
                                                    verticalAccuracy = new('DataQuality'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    system = new('xml_attribute'),
                                                    scope = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  slot(.Object, 'geometry') <-
    c_as(geometry, 'geometry')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'geometricObjectCount') <-
    as(geometricObjectCount, 'geometricObjectCount')
  slot(.Object, 'topologyLevel') <-
    as(topologyLevel, 'topologyLevel')
  slot(.Object, 'spatialReference') <-
    as(spatialReference, 'spatialReference')
  slot(.Object, 'horizontalAccuracy') <-
    as(horizontalAccuracy, 'horizontalAccuracy')
  slot(.Object, 'verticalAccuracy') <-
    as(verticalAccuracy, 'verticalAccuracy')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SpatialVectorType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SpatialVectorType',  function(from)
  emlToS4(from))
setAs('GeometryType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'GeometryType',  function(from)
  emlToS4(from))
setAs('TopologyLevel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'TopologyLevel',  function(from)
  emlToS4(from))
setAs('accuracyReport', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'accuracyReport',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyValue',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyMethod',  function(from)
  emlToS4(from))
setMethod(initialize, 'quantitativeAccuracyReport', function(.Object,
                                                             .Data = new('character'),
                                                             quantitativeAccuracyValue = new('character'),
                                                             quantitativeAccuracyMethod = new('character'),
                                                             schemaLocation = new('xml_attribute'),
                                                             lang = new('xml_attribute'),
                                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'quantitativeAccuracyValue') <-
    as(quantitativeAccuracyValue, 'quantitativeAccuracyValue')
  slot(.Object, 'quantitativeAccuracyMethod') <-
    as(quantitativeAccuracyMethod, 'quantitativeAccuracyMethod')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('quantitativeAccuracyReport', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyReport',  function(from)
  emlToS4(from))

setMethod(c, signature('quantitativeAccuracyReport'), function(x, ..., recursive = FALSE)
  new('ListOfquantitativeAccuracyReport', list(x, ...)))
setMethod(initialize, 'DataQuality', function(.Object,
                                              quantitativeAccuracyReport = character(),
                                              .Data = new('character'),
                                              accuracyReport = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'quantitativeAccuracyReport') <-
    c_as(quantitativeAccuracyReport, 'quantitativeAccuracyReport')
  .Object@.Data <-
    .Data
  slot(.Object, 'accuracyReport') <-
    as(accuracyReport, 'accuracyReport')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DataQuality', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DataQuality',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialRaster.xsd  ####


setAs('spatialRaster', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialRaster',  function(from)
  emlToS4(from))
setAs('attributeList', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('spatialReference', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialReference',  function(from)
  emlToS4(from))
setAs('xCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'xCoordinate',  function(from)
  emlToS4(from))
setAs('yCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'yCoordinate',  function(from)
  emlToS4(from))
setAs('pointInPixel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pointInPixel',  function(from)
  emlToS4(from))
setAs('corner', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'corner',  function(from)
  emlToS4(from))
setMethod(initialize, 'cornerPoint', function(.Object,
                                              .Data = new('character'),
                                              xCoordinate = new('character'),
                                              yCoordinate = new('character'),
                                              pointInPixel = new('pointInPixel'),
                                              corner = new('rasterOriginType'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'xCoordinate') <-
    as(xCoordinate, 'xCoordinate')
  slot(.Object, 'yCoordinate') <-
    as(yCoordinate, 'yCoordinate')
  slot(.Object, 'pointInPixel') <-
    as(pointInPixel, 'pointInPixel')
  slot(.Object, 'corner') <-
    as(corner, 'corner')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('cornerPoint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cornerPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('cornerPoint'), function(x, ..., recursive = FALSE)
  new('ListOfcornerPoint', list(x, ...)))
setAs('column', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'column',  function(from)
  emlToS4(from))
setAs('row', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'row',  function(from)
  emlToS4(from))
setAs('xCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'xCoordinate',  function(from)
  emlToS4(from))
setAs('yCoordinate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'yCoordinate',  function(from)
  emlToS4(from))
setAs('pointInPixel', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pointInPixel',  function(from)
  emlToS4(from))
setMethod(initialize, 'controlPoint', function(.Object,
                                               .Data = new('character'),
                                               column = new('character'),
                                               row = new('character'),
                                               xCoordinate = new('character'),
                                               yCoordinate = new('character'),
                                               pointInPixel = new('pointInPixel'),
                                               schemaLocation = new('xml_attribute'),
                                               lang = new('xml_attribute'),
                                               slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'column') <-
    as(column, 'column')
  slot(.Object, 'row') <-
    as(row, 'row')
  slot(.Object, 'xCoordinate') <-
    as(xCoordinate, 'xCoordinate')
  slot(.Object, 'yCoordinate') <-
    as(yCoordinate, 'yCoordinate')
  slot(.Object, 'pointInPixel') <-
    as(pointInPixel, 'pointInPixel')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('controlPoint', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'controlPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('controlPoint'), function(x, ..., recursive = FALSE)
  new('ListOfcontrolPoint', list(x, ...)))
setAs('xIntercept', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'xIntercept',  function(from)
  emlToS4(from))
setAs('xSlope', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'xSlope',  function(from)
  emlToS4(from))
setAs('yIntercept', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'yIntercept',  function(from)
  emlToS4(from))
setAs('ySlope', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ySlope',  function(from)
  emlToS4(from))
setMethod(initialize, 'bilinearFit', function(.Object,
                                              .Data = new('character'),
                                              xIntercept = new('character'),
                                              xSlope = new('character'),
                                              yIntercept = new('character'),
                                              ySlope = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'xIntercept') <-
    as(xIntercept, 'xIntercept')
  slot(.Object, 'xSlope') <-
    as(xSlope, 'xSlope')
  slot(.Object, 'yIntercept') <-
    as(yIntercept, 'yIntercept')
  slot(.Object, 'ySlope') <-
    as(ySlope, 'ySlope')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('bilinearFit', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bilinearFit',  function(from)
  emlToS4(from))
setMethod(initialize, 'georeferenceInfo', function(.Object,
                                                   cornerPoint = character(),
                                                   controlPoint = character(),
                                                   .Data = new('character'),
                                                   bilinearFit = new('bilinearFit'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'cornerPoint') <-
    c_as(cornerPoint, 'cornerPoint')
  slot(.Object, 'controlPoint') <-
    c_as(controlPoint, 'controlPoint')
  .Object@.Data <-
    .Data
  slot(.Object, 'bilinearFit') <-
    as(bilinearFit, 'bilinearFit')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('georeferenceInfo', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'georeferenceInfo',  function(from)
  emlToS4(from))
setAs('horizontalAccuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'horizontalAccuracy',  function(from)
  emlToS4(from))
setAs('verticalAccuracy', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'verticalAccuracy',  function(from)
  emlToS4(from))
setAs('cellSizeXDirection', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cellSizeXDirection',  function(from)
  emlToS4(from))
setAs('cellSizeYDirection', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cellSizeYDirection',  function(from)
  emlToS4(from))
setAs('numberOfBands', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'numberOfBands',  function(from)
  emlToS4(from))
setAs('rasterOrigin', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'rasterOrigin',  function(from)
  emlToS4(from))
setAs('rows', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'rows',  function(from)
  emlToS4(from))
setAs('columns', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'columns',  function(from)
  emlToS4(from))
setAs('verticals', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'verticals',  function(from)
  emlToS4(from))
setAs('cellGeometry', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cellGeometry',  function(from)
  emlToS4(from))
setAs('toneGradation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'toneGradation',  function(from)
  emlToS4(from))
setAs('scaleFactor', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'scaleFactor',  function(from)
  emlToS4(from))
setAs('offset', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'offset',  function(from)
  emlToS4(from))
setAs('illuminationElevationAngle', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'illuminationElevationAngle',  function(from)
  emlToS4(from))
setAs('illuminationAzimuthAngle', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'illuminationAzimuthAngle',  function(from)
  emlToS4(from))
setAs('imageOrientationAngle', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'imageOrientationAngle',  function(from)
  emlToS4(from))
setAs('imagingCondition', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'imagingCondition',  function(from)
  emlToS4(from))
setAs('imageQualityCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'imageQualityCode',  function(from)
  emlToS4(from))
setAs('cloudCoverPercentage', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cloudCoverPercentage',  function(from)
  emlToS4(from))
setAs('preProcessingTypeCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'preProcessingTypeCode',  function(from)
  emlToS4(from))
setAs('compressionGenerationQuality', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'compressionGenerationQuality',  function(from)
  emlToS4(from))
setAs('triangulationIndicator', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'triangulationIndicator',  function(from)
  emlToS4(from))
setAs('radiometricDataAvailability', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'radiometricDataAvailability',  function(from)
  emlToS4(from))
setAs('cameraCalibrationInformationAvailability', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'cameraCalibrationInformationAvailability',  function(from)
  emlToS4(from))
setAs('filmDistortionInformationAvailability', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'filmDistortionInformationAvailability',  function(from)
  emlToS4(from))
setAs('lensDistortionInformationAvailability', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lensDistortionInformationAvailability',  function(from)
  emlToS4(from))
setAs('bandDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'bandDescription',  function(from)
  emlToS4(from))

setMethod(c, signature('bandDescription'), function(x, ..., recursive = FALSE)
  new('ListOfbandDescription', list(x, ...)))
setMethod(initialize, 'imageDescription', function(.Object,
                                                   bandDescription = character(),
                                                   .Data = new('character'),
                                                   illuminationElevationAngle = new('character'),
                                                   illuminationAzimuthAngle = new('character'),
                                                   imageOrientationAngle = new('character'),
                                                   imagingCondition = new('ImagingConditionCode'),
                                                   imageQualityCode = new('character'),
                                                   cloudCoverPercentage = new('character'),
                                                   preProcessingTypeCode = new('character'),
                                                   compressionGenerationQuality = new('character'),
                                                   triangulationIndicator = new('character'),
                                                   radiometricDataAvailability = new('character'),
                                                   cameraCalibrationInformationAvailability = new('character'),
                                                   filmDistortionInformationAvailability = new('character'),
                                                   lensDistortionInformationAvailability = new('character'),
                                                   schemaLocation = new('xml_attribute'),
                                                   lang = new('xml_attribute'),
                                                   slot_order = new('character')) {

  slot(.Object, 'bandDescription') <-
    c_as(bandDescription, 'bandDescription')
  .Object@.Data <-
    .Data
  slot(.Object, 'illuminationElevationAngle') <-
    as(illuminationElevationAngle, 'illuminationElevationAngle')
  slot(.Object, 'illuminationAzimuthAngle') <-
    as(illuminationAzimuthAngle, 'illuminationAzimuthAngle')
  slot(.Object, 'imageOrientationAngle') <-
    as(imageOrientationAngle, 'imageOrientationAngle')
  slot(.Object, 'imagingCondition') <-
    as(imagingCondition, 'imagingCondition')
  slot(.Object, 'imageQualityCode') <-
    as(imageQualityCode, 'imageQualityCode')
  slot(.Object, 'cloudCoverPercentage') <-
    as(cloudCoverPercentage, 'cloudCoverPercentage')
  slot(.Object, 'preProcessingTypeCode') <-
    as(preProcessingTypeCode, 'preProcessingTypeCode')
  slot(.Object, 'compressionGenerationQuality') <-
    as(compressionGenerationQuality,
       'compressionGenerationQuality')
  slot(.Object, 'triangulationIndicator') <-
    as(triangulationIndicator, 'triangulationIndicator')
  slot(.Object, 'radiometricDataAvailability') <-
    as(radiometricDataAvailability,
       'radiometricDataAvailability')
  slot(.Object, 'cameraCalibrationInformationAvailability') <-
    as(
      cameraCalibrationInformationAvailability,
      'cameraCalibrationInformationAvailability'
    )
  slot(.Object, 'filmDistortionInformationAvailability') <-
    as(
      filmDistortionInformationAvailability,
      'filmDistortionInformationAvailability'
    )
  slot(.Object, 'lensDistortionInformationAvailability') <-
    as(
      lensDistortionInformationAvailability,
      'lensDistortionInformationAvailability'
    )
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('imageDescription', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'imageDescription',  function(from)
  emlToS4(from))
setMethod(initialize, 'SpatialRasterType', function(.Object,
                                                    alternateIdentifier = character(),
                                                    physical = character(),
                                                    additionalInfo = character(),
                                                    constraint = character(),
                                                    .Data = new('character'),
                                                    entityName = new('character'),
                                                    entityDescription = new('character'),
                                                    coverage = new('Coverage'),
                                                    methods = new('MethodsType'),
                                                    attributeList = new('AttributeListType'),
                                                    spatialReference = new('SpatialReferenceType'),
                                                    georeferenceInfo = new('georeferenceInfo'),
                                                    horizontalAccuracy = new('DataQuality'),
                                                    verticalAccuracy = new('DataQuality'),
                                                    cellSizeXDirection = new('cellSizeXDirection'),
                                                    cellSizeYDirection = new('cellSizeYDirection'),
                                                    numberOfBands = new('numberOfBands'),
                                                    rasterOrigin = new('rasterOriginType'),
                                                    rows = new('character'),
                                                    columns = new('character'),
                                                    verticals = new('verticals'),
                                                    cellGeometry = new('CellGeometryType'),
                                                    toneGradation = new('character'),
                                                    scaleFactor = new('character'),
                                                    offset = new('character'),
                                                    imageDescription = new('imageDescription'),
                                                    references = new('references'),
                                                    id = new('xml_attribute'),
                                                    system = new('xml_attribute'),
                                                    scope = new('xml_attribute'),
                                                    schemaLocation = new('xml_attribute'),
                                                    lang = new('xml_attribute'),
                                                    slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'physical') <-
    c_as(physical, 'physical')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'constraint') <-
    c_as(constraint, 'constraint')
  .Object@.Data <-
    .Data
  slot(.Object, 'entityName') <-
    as(entityName, 'entityName')
  slot(.Object, 'entityDescription') <-
    as(entityDescription, 'entityDescription')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'attributeList') <-
    as(attributeList, 'attributeList')
  slot(.Object, 'spatialReference') <-
    as(spatialReference, 'spatialReference')
  slot(.Object, 'georeferenceInfo') <-
    as(georeferenceInfo, 'georeferenceInfo')
  slot(.Object, 'horizontalAccuracy') <-
    as(horizontalAccuracy, 'horizontalAccuracy')
  slot(.Object, 'verticalAccuracy') <-
    as(verticalAccuracy, 'verticalAccuracy')
  slot(.Object, 'cellSizeXDirection') <-
    as(cellSizeXDirection, 'cellSizeXDirection')
  slot(.Object, 'cellSizeYDirection') <-
    as(cellSizeYDirection, 'cellSizeYDirection')
  slot(.Object, 'numberOfBands') <-
    as(numberOfBands, 'numberOfBands')
  slot(.Object, 'rasterOrigin') <-
    as(rasterOrigin, 'rasterOrigin')
  slot(.Object, 'rows') <-
    as(rows, 'rows')
  slot(.Object, 'columns') <-
    as(columns, 'columns')
  slot(.Object, 'verticals') <-
    as(verticals, 'verticals')
  slot(.Object, 'cellGeometry') <-
    as(cellGeometry, 'cellGeometry')
  slot(.Object, 'toneGradation') <-
    as(toneGradation, 'toneGradation')
  slot(.Object, 'scaleFactor') <-
    as(scaleFactor, 'scaleFactor')
  slot(.Object, 'offset') <-
    as(offset, 'offset')
  slot(.Object, 'imageDescription') <-
    as(imageDescription, 'imageDescription')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('SpatialRasterType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'SpatialRasterType',  function(from)
  emlToS4(from))
setAs('sequenceIdentifier', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'sequenceIdentifier',  function(from)
  emlToS4(from))
setAs('highWavelength', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'highWavelength',  function(from)
  emlToS4(from))
setAs('lowWaveLength', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'lowWaveLength',  function(from)
  emlToS4(from))
setAs('waveLengthUnits', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'waveLengthUnits',  function(from)
  emlToS4(from))
setAs('peakResponse', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'peakResponse',  function(from)
  emlToS4(from))
setMethod(initialize, 'BandType', function(.Object,
                                           .Data = new('character'),
                                           sequenceIdentifier = new('character'),
                                           highWavelength = new('character'),
                                           lowWaveLength = new('character'),
                                           waveLengthUnits = new('lengthUnits'),
                                           peakResponse = new('peakResponse'),
                                           schemaLocation = new('xml_attribute'),
                                           lang = new('xml_attribute'),
                                           slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'sequenceIdentifier') <-
    as(sequenceIdentifier, 'sequenceIdentifier')
  slot(.Object, 'highWavelength') <-
    as(highWavelength, 'highWavelength')
  slot(.Object, 'lowWaveLength') <-
    as(lowWaveLength, 'lowWaveLength')
  slot(.Object, 'waveLengthUnits') <-
    as(waveLengthUnits, 'waveLengthUnits')
  slot(.Object, 'peakResponse') <-
    as(peakResponse, 'peakResponse')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('BandType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'BandType',  function(from)
  emlToS4(from))
setAs('CellValueType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'CellValueType',  function(from)
  emlToS4(from))
setAs('ImagingConditionCode', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'ImagingConditionCode',  function(from)
  emlToS4(from))
setAs('rasterOriginType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'rasterOriginType',  function(from)
  emlToS4(from))
setAs('CellGeometryType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'CellGeometryType',  function(from)
  emlToS4(from))
setAs('accuracyReport', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'accuracyReport',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyValue',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyMethod', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyMethod',  function(from)
  emlToS4(from))
setMethod(initialize, 'quantitativeAccuracyReport', function(.Object,
                                                             .Data = new('character'),
                                                             quantitativeAccuracyValue = new('character'),
                                                             quantitativeAccuracyMethod = new('character'),
                                                             schemaLocation = new('xml_attribute'),
                                                             lang = new('xml_attribute'),
                                                             slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'quantitativeAccuracyValue') <-
    as(quantitativeAccuracyValue, 'quantitativeAccuracyValue')
  slot(.Object, 'quantitativeAccuracyMethod') <-
    as(quantitativeAccuracyMethod, 'quantitativeAccuracyMethod')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('quantitativeAccuracyReport', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'quantitativeAccuracyReport',  function(from)
  emlToS4(from))

setMethod(c, signature('quantitativeAccuracyReport'), function(x, ..., recursive = FALSE)
  new('ListOfquantitativeAccuracyReport', list(x, ...)))
setMethod(initialize, 'DataQuality', function(.Object,
                                              quantitativeAccuracyReport = character(),
                                              .Data = new('character'),
                                              accuracyReport = new('character'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'quantitativeAccuracyReport') <-
    c_as(quantitativeAccuracyReport, 'quantitativeAccuracyReport')
  .Object@.Data <-
    .Data
  slot(.Object, 'accuracyReport') <-
    as(accuracyReport, 'accuracyReport')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DataQuality', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DataQuality',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-dataset.xsd  ####


setAs('dataset', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataset',  function(from)
  emlToS4(from))
setAs('purpose', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'purpose',  function(from)
  emlToS4(from))
setAs('maintenance', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'maintenance',  function(from)
  emlToS4(from))
setAs('contact', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'contact',  function(from)
  emlToS4(from))

setMethod(c, signature('contact'), function(x, ..., recursive = FALSE)
  new('ListOfcontact', list(x, ...)))
setAs('publisher', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'publisher',  function(from)
  emlToS4(from))
setAs('pubPlace', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'pubPlace',  function(from)
  emlToS4(from))
setAs('methods', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'methods',  function(from)
  emlToS4(from))
setAs('project', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'project',  function(from)
  emlToS4(from))
setAs('dataTable', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataTable',  function(from)
  emlToS4(from))

setMethod(c, signature('dataTable'), function(x, ..., recursive = FALSE)
  new('ListOfdataTable', list(x, ...)))
setAs('spatialRaster', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialRaster',  function(from)
  emlToS4(from))

setMethod(c, signature('spatialRaster'), function(x, ..., recursive = FALSE)
  new('ListOfspatialRaster', list(x, ...)))
setAs('spatialVector', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'spatialVector',  function(from)
  emlToS4(from))

setMethod(c, signature('spatialVector'), function(x, ..., recursive = FALSE)
  new('ListOfspatialVector', list(x, ...)))
setAs('storedProcedure', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'storedProcedure',  function(from)
  emlToS4(from))

setMethod(c, signature('storedProcedure'), function(x, ..., recursive = FALSE)
  new('ListOfstoredProcedure', list(x, ...)))
setAs('view', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'view',  function(from)
  emlToS4(from))

setMethod(c, signature('view'), function(x, ..., recursive = FALSE)
  new('ListOfview', list(x, ...)))
setAs('otherEntity', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'otherEntity',  function(from)
  emlToS4(from))

setMethod(c, signature('otherEntity'), function(x, ..., recursive = FALSE)
  new('ListOfotherEntity', list(x, ...)))
setMethod(initialize, 'DatasetType', function(.Object,
                                              alternateIdentifier = character(),
                                              title = character(),
                                              creator = character(),
                                              metadataProvider = character(),
                                              associatedParty = character(),
                                              keywordSet = character(),
                                              additionalInfo = character(),
                                              distribution = character(),
                                              contact = character(),
                                              dataTable = character(),
                                              spatialRaster = character(),
                                              spatialVector = character(),
                                              storedProcedure = character(),
                                              view = character(),
                                              otherEntity = character(),
                                              .Data = new('character'),
                                              shortName = new('character'),
                                              pubDate = new('yearDate'),
                                              language = new('character'),
                                              series = new('character'),
                                              abstract = new('TextType'),
                                              intellectualRights = new('TextType'),
                                              coverage = new('Coverage'),
                                              purpose = new('TextType'),
                                              maintenance = new('MaintenanceType'),
                                              publisher = new('ResponsibleParty'),
                                              pubPlace = new('character'),
                                              methods = new('MethodsType'),
                                              project = new('ResearchProjectType'),
                                              references = new('references'),
                                              id = new('xml_attribute'),
                                              system = new('xml_attribute'),
                                              scope = new('xml_attribute'),
                                              schemaLocation = new('xml_attribute'),
                                              lang = new('xml_attribute'),
                                              slot_order = new('character')) {

  slot(.Object, 'alternateIdentifier') <-
    c_as(alternateIdentifier, 'alternateIdentifier')
  slot(.Object, 'title') <-
    c_as(title, 'title')
  slot(.Object, 'creator') <-
    c_as(creator, 'creator')
  slot(.Object, 'metadataProvider') <-
    c_as(metadataProvider, 'metadataProvider')
  slot(.Object, 'associatedParty') <-
    c_as(associatedParty, 'associatedParty')
  slot(.Object, 'keywordSet') <-
    c_as(keywordSet, 'keywordSet')
  slot(.Object, 'additionalInfo') <-
    c_as(additionalInfo, 'additionalInfo')
  slot(.Object, 'distribution') <-
    c_as(distribution, 'distribution')
  slot(.Object, 'contact') <-
    c_as(contact, 'contact')
  slot(.Object, 'dataTable') <-
    c_as(dataTable, 'dataTable')
  slot(.Object, 'spatialRaster') <-
    c_as(spatialRaster, 'spatialRaster')
  slot(.Object, 'spatialVector') <-
    c_as(spatialVector, 'spatialVector')
  slot(.Object, 'storedProcedure') <-
    c_as(storedProcedure, 'storedProcedure')
  slot(.Object, 'view') <-
    c_as(view, 'view')
  slot(.Object, 'otherEntity') <-
    c_as(otherEntity, 'otherEntity')
  .Object@.Data <-
    .Data
  slot(.Object, 'shortName') <-
    as(shortName, 'shortName')
  slot(.Object, 'pubDate') <-
    as(pubDate, 'pubDate')
  slot(.Object, 'language') <-
    as(language, 'eml:language')
  slot(.Object, 'series') <-
    as(series, 'series')
  slot(.Object, 'abstract') <-
    as(abstract, 'abstract')
  slot(.Object, 'intellectualRights') <-
    as(intellectualRights, 'intellectualRights')
  slot(.Object, 'coverage') <-
    as(coverage, 'coverage')
  slot(.Object, 'purpose') <-
    as(purpose, 'purpose')
  slot(.Object, 'maintenance') <-
    as(maintenance, 'maintenance')
  slot(.Object, 'publisher') <-
    as(publisher, 'publisher')
  slot(.Object, 'pubPlace') <-
    as(pubPlace, 'pubPlace')
  slot(.Object, 'methods') <-
    as(methods, 'methods')
  slot(.Object, 'project') <-
    as(project, 'project')
  slot(.Object, 'references') <-
    as(references, 'references')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('DatasetType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'DatasetType',  function(from)
  emlToS4(from))
setAs('description', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'description',  function(from)
  emlToS4(from))
setAs('maintenanceUpdateFrequency', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'maintenanceUpdateFrequency',  function(from)
  emlToS4(from))
setAs('changeScope', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'changeScope',  function(from)
  emlToS4(from))
setAs('oldValue', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'oldValue',  function(from)
  emlToS4(from))
setAs('changeDate', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'changeDate',  function(from)
  emlToS4(from))
setAs('comment', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'comment',  function(from)
  emlToS4(from))
setMethod(initialize, 'changeHistory', function(.Object,
                                                .Data = new('character'),
                                                changeScope = new('character'),
                                                oldValue = new('character'),
                                                changeDate = new('character'),
                                                comment = new('character'),
                                                schemaLocation = new('xml_attribute'),
                                                lang = new('xml_attribute'),
                                                slot_order = new('character')) {

  .Object@.Data <-
    .Data
  slot(.Object, 'changeScope') <-
    as(changeScope, 'changeScope')
  slot(.Object, 'oldValue') <-
    as(oldValue, 'oldValue')
  slot(.Object, 'changeDate') <-
    as(changeDate, 'changeDate')
  slot(.Object, 'comment') <-
    as(comment, 'comment')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('changeHistory', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'changeHistory',  function(from)
  emlToS4(from))

setMethod(c, signature('changeHistory'), function(x, ..., recursive = FALSE)
  new('ListOfchangeHistory', list(x, ...)))
setMethod(initialize, 'MaintenanceType', function(.Object,
                                                  changeHistory = character(),
                                                  .Data = new('character'),
                                                  description = new('TextType'),
                                                  maintenanceUpdateFrequency = new('MaintUpFreqType'),
                                                  schemaLocation = new('xml_attribute'),
                                                  lang = new('xml_attribute'),
                                                  slot_order = new('character')) {

  slot(.Object, 'changeHistory') <-
    c_as(changeHistory, 'changeHistory')
  .Object@.Data <-
    .Data
  slot(.Object, 'description') <-
    as(description, 'description')
  slot(.Object, 'maintenanceUpdateFrequency') <-
    as(maintenanceUpdateFrequency, 'maintenanceUpdateFrequency')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('MaintenanceType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'MaintenanceType',  function(from)
  emlToS4(from))
setAs('MaintUpFreqType', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'MaintUpFreqType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml.xsd  ####


setAs('access', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'access',  function(from)
  emlToS4(from))
setAs('dataset', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'dataset',  function(from)
  emlToS4(from))
setAs('citation', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'citation',  function(from)
  emlToS4(from))
setAs('software', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'software',  function(from)
  emlToS4(from))
setAs('protocol', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'protocol',  function(from)
  emlToS4(from))
setAs('describes', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'describes',  function(from)
  emlToS4(from))

setMethod(c, signature('describes'), function(x, ..., recursive = FALSE)
  new('ListOfdescribes', list(x, ...)))
setAs('metadata', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'metadata',  function(from)
  emlToS4(from))
setMethod(initialize, 'additionalMetadata', function(.Object,
                                                     describes = character(),
                                                     .Data = new('character'),
                                                     metadata = new('metadata'),
                                                     id = new('xml_attribute'),
                                                     schemaLocation = new('xml_attribute'),
                                                     lang = new('xml_attribute'),
                                                     slot_order = new('character')) {

  slot(.Object, 'describes') <-
    c_as(describes, 'describes')
  .Object@.Data <-
    .Data
  slot(.Object, 'metadata') <-
    as(metadata, 'metadata')
  slot(.Object, 'id') <-
    as(id, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('additionalMetadata', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'additionalMetadata',  function(from)
  emlToS4(from))

setMethod(c, signature('additionalMetadata'), function(x, ..., recursive = FALSE)
  new('ListOfadditionalMetadata', list(x, ...)))
setMethod(initialize, 'eml', function(.Object,
                                      additionalMetadata = character(),
                                      .Data = new('character'),
                                      access = new('AccessType'),
                                      dataset = new('DatasetType'),
                                      citation = new('CitationType'),
                                      software = new('SoftwareType'),
                                      protocol = new('ProtocolType'),
                                      packageId = new('xml_attribute'),
                                      system = new('xml_attribute'),
                                      scope = new('xml_attribute'),
                                      lang = new('xml_attribute'),
                                      schemaLocation = new('xml_attribute'),
                                      slot_order = new('character')) {

  slot(.Object, 'additionalMetadata') <-
    c_as(additionalMetadata, 'additionalMetadata')
  .Object@.Data <-
    .Data
  slot(.Object, 'access') <-
    as(access, 'access')
  slot(.Object, 'dataset') <-
    as(dataset, 'dataset')
  slot(.Object, 'citation') <-
    as(citation, 'citation')
  slot(.Object, 'software') <-
    as(software, 'software')
  slot(.Object, 'protocol') <-
    as(protocol, 'protocol')
  slot(.Object, 'packageId') <-
    as(packageId, 'xml_attribute')
  slot(.Object, 'system') <-
    as(system, 'xml_attribute')
  slot(.Object, 'scope') <-
    as(scope, 'xml_attribute')
  slot(.Object, 'lang') <-
    as(lang, 'xml_attribute')
  slot(.Object, 'schemaLocation') <-
    as(schemaLocation, 'xml_attribute')
  slot(.Object, 'slot_order') <-
    as(slot_order, 'slot_order')
  .Object
})
setAs('eml', 'xml_node',   function(from)
  S4Toeml(from))
setAs('xml_node', 'eml',  function(from)
  emlToS4(from))
