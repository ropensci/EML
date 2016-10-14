


#####  inst/xsd/eml-text.xsd  ####


setAs('text', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'text',  function(from)
  emlToS4(from))
setAs('section', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'section',  function(from)
  emlToS4(from))

setMethod(c, signature('section'), function(x, ..., recursive = FALSE)
  new('ListOfsection', list(x, ...)))
setAs('para', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'para',  function(from)
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
setAs('TextType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'TextType',  function(from)
  emlToS4(from))
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setAs('itemizedlist', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'itemizedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('itemizedlist'), function(x, ..., recursive = FALSE)
  new('ListOfitemizedlist', list(x, ...)))
setAs('orderedlist', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'orderedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('orderedlist'), function(x, ..., recursive = FALSE)
  new('ListOforderedlist', list(x, ...)))
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
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
setAs('emphasis', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'emphasis',  function(from)
  emlToS4(from))

setMethod(c, signature('emphasis'), function(x, ..., recursive = FALSE)
  new('ListOfemphasis', list(x, ...)))
setAs('subscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'subscript',  function(from)
  emlToS4(from))

setMethod(c, signature('subscript'), function(x, ..., recursive = FALSE)
  new('ListOfsubscript', list(x, ...)))
setAs('superscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'superscript',  function(from)
  emlToS4(from))

setMethod(c, signature('superscript'), function(x, ..., recursive = FALSE)
  new('ListOfsuperscript', list(x, ...)))
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
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
setAs('literalLayout', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'literalLayout',  function(from)
  emlToS4(from))

setMethod(c, signature('literalLayout'), function(x, ..., recursive = FALSE)
  new('ListOfliteralLayout', list(x, ...)))
setAs('citetitle', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citetitle',  function(from)
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
setAs('ulink', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ulink',  function(from)
  emlToS4(from))

setMethod(c, signature('ulink'), function(x, ..., recursive = FALSE)
  new('ListOfulink', list(x, ...)))

setAs('ParagraphType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ParagraphType',  function(from)
  emlToS4(from))
setAs('title', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'title',  function(from)
  emlToS4(from))
setAs('para', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'para',  function(from)
  emlToS4(from))

setMethod(c, signature('para'), function(x, ..., recursive = FALSE)
  new('ListOfpara', list(x, ...)))
setAs('section', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'section',  function(from)
  emlToS4(from))

setMethod(c, signature('section'), function(x, ..., recursive = FALSE)
  new('ListOfsection', list(x, ...)))

setAs('SectionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SectionType',  function(from)
  emlToS4(from))
setAs('para', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'para',  function(from)
  emlToS4(from))

setMethod(c, signature('para'), function(x, ..., recursive = FALSE)
  new('ListOfpara', list(x, ...)))
setAs('itemizedlist', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'itemizedlist',  function(from)
  emlToS4(from))

setMethod(c, signature('itemizedlist'), function(x, ..., recursive = FALSE)
  new('ListOfitemizedlist', list(x, ...)))
setAs('orderedlist', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'orderedlist',  function(from)
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
setAs('listitem', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'listitem',  function(from)
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
setAs('ListType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ListType',  function(from)
  emlToS4(from))
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
  emlToS4(from))

setMethod(c, signature('value'), function(x, ..., recursive = FALSE)
  new('ListOfvalue', list(x, ...)))
setAs('subscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'subscript',  function(from)
  emlToS4(from))

setMethod(c, signature('subscript'), function(x, ..., recursive = FALSE)
  new('ListOfsubscript', list(x, ...)))
setAs('superscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'superscript',  function(from)
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
setAs('SubSuperScriptType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SubSuperScriptType',  function(from)
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
setAs('i18nString', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'i18nString',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-documentation.xsd  ####


setAs('moduleName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'moduleName',  function(from)
  emlToS4(from))
setAs('moduleDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'moduleDescription',  function(from)
  emlToS4(from))
setAs('recommendedUsage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'recommendedUsage',  function(from)
  emlToS4(from))
setAs('standAlone', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'standAlone',  function(from)
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
setAs('moduleDocs', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'moduleDocs',  function(from)
  emlToS4(from))
setAs('tooltip', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'tooltip',  function(from)
  emlToS4(from))
setAs('summary', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'summary',  function(from)
  emlToS4(from))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
  emlToS4(from))
setAs('example', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'example',  function(from)
  emlToS4(from))
setAs('lineage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lineage',  function(from)
  emlToS4(from))
setAs('module', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'module',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-unitTypeDefinitions.xsd  ####


setAs('StandardUnitDictionary', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'StandardUnitDictionary',  function(from)
  emlToS4(from))
setAs('LengthUnitType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'LengthUnitType',  function(from)
  emlToS4(from))
setAs('MassUnitType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'MassUnitType',  function(from)
  emlToS4(from))
setAs('otherUnitType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'otherUnitType',  function(from)
  emlToS4(from))
setAs('angleUnitType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'angleUnitType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-party.xsd  ####


setAs('individualName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'individualName',  function(from)
  emlToS4(from))

setMethod(c, signature('individualName'), function(x, ..., recursive = FALSE)
  new('ListOfindividualName', list(x, ...)))
setAs('organizationName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'organizationName',  function(from)
  emlToS4(from))

setMethod(c, signature('organizationName'), function(x, ..., recursive = FALSE)
  new('ListOforganizationName', list(x, ...)))
setAs('positionName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'positionName',  function(from)
  emlToS4(from))

setMethod(c, signature('positionName'), function(x, ..., recursive = FALSE)
  new('ListOfpositionName', list(x, ...)))
setAs('address', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'address',  function(from)
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
setAs('phone', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'phone',  function(from)
  emlToS4(from))

setMethod(c, signature('phone'), function(x, ..., recursive = FALSE)
  new('ListOfphone', list(x, ...)))
setAs('electronicMailAddress', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'electronicMailAddress',  function(from)
  emlToS4(from))

setMethod(c, signature('electronicMailAddress'), function(x, ..., recursive = FALSE)
  new('ListOfelectronicMailAddress', list(x, ...)))
setAs('onlineUrl', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'onlineUrl',  function(from)
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
setAs('userId', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'userId',  function(from)
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
setAs('ResponsibleParty', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ResponsibleParty',  function(from)
  emlToS4(from))
setAs('salutation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'salutation',  function(from)
  emlToS4(from))

setMethod(c, signature('salutation'), function(x, ..., recursive = FALSE)
  new('ListOfsalutation', list(x, ...)))
setAs('givenName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'givenName',  function(from)
  emlToS4(from))

setMethod(c, signature('givenName'), function(x, ..., recursive = FALSE)
  new('ListOfgivenName', list(x, ...)))
setAs('surName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'surName',  function(from)
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
setAs('Person', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Person',  function(from)
  emlToS4(from))
setAs('deliveryPoint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'deliveryPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('deliveryPoint'), function(x, ..., recursive = FALSE)
  new('ListOfdeliveryPoint', list(x, ...)))
setAs('city', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'city',  function(from)
  emlToS4(from))
setAs('administrativeArea', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'administrativeArea',  function(from)
  emlToS4(from))
setAs('postalCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'postalCode',  function(from)
  emlToS4(from))
setAs('country', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'country',  function(from)
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
setAs('Address', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Address',  function(from)
  emlToS4(from))
setAs('party', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'party',  function(from)
  emlToS4(from))
setAs('RoleType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'RoleType',  function(from)
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
setAs('alternateIdentifier', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'alternateIdentifier',  function(from)
  emlToS4(from))

setMethod(c, signature('alternateIdentifier'), function(x, ..., recursive = FALSE)
  new('ListOfalternateIdentifier', list(x, ...)))
setAs('shortName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'shortName',  function(from)
  emlToS4(from))
setAs('title', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'title',  function(from)
  emlToS4(from))

setMethod(c, signature('title'), function(x, ..., recursive = FALSE)
  new('ListOftitle', list(x, ...)))
setAs('creator', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'creator',  function(from)
  emlToS4(from))

setMethod(c, signature('creator'), function(x, ..., recursive = FALSE)
  new('ListOfcreator', list(x, ...)))
setAs('metadataProvider', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'metadataProvider',  function(from)
  emlToS4(from))

setMethod(c, signature('metadataProvider'), function(x, ..., recursive = FALSE)
  new('ListOfmetadataProvider', list(x, ...)))
setAs('role', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'role',  function(from)
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
setAs('associatedParty', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'associatedParty',  function(from)
  emlToS4(from))

setMethod(c, signature('associatedParty'), function(x, ..., recursive = FALSE)
  new('ListOfassociatedParty', list(x, ...)))
setAs('pubDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pubDate',  function(from)
  emlToS4(from))
setAs('language', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'language',  function(from)
  emlToS4(from))
setAs('series', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'series',  function(from)
  emlToS4(from))
setAs('abstract', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'abstract',  function(from)
  emlToS4(from))

setAs('keyword', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'keyword',  function(from)
  emlToS4(from))

setMethod(c, signature('keyword'), function(x, ..., recursive = FALSE)
  new('ListOfkeyword', list(x, ...)))
setAs('keywordThesaurus', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'keywordThesaurus',  function(from)
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
setAs('keywordSet', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'keywordSet',  function(from)
  emlToS4(from))

setMethod(c, signature('keywordSet'), function(x, ..., recursive = FALSE)
  new('ListOfkeywordSet', list(x, ...)))
setAs('additionalInfo', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'additionalInfo',  function(from)
  emlToS4(from))

setMethod(c, signature('additionalInfo'), function(x, ..., recursive = FALSE)
  new('ListOfadditionalInfo', list(x, ...)))
setAs('intellectualRights', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'intellectualRights',  function(from)
  emlToS4(from))
setAs('distribution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'distribution',  function(from)
  emlToS4(from))

setMethod(c, signature('distribution'), function(x, ..., recursive = FALSE)
  new('ListOfdistribution', list(x, ...)))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
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
setAs('ResourceGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ResourceGroup',  function(from)
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
setAs('references', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'references',  function(from)
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
setAs('ReferencesGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ReferencesGroup',  function(from)
  emlToS4(from))
setAs('KeyTypeCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'KeyTypeCode',  function(from)
  emlToS4(from))
setAs('yearDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'yearDate',  function(from)
  emlToS4(from))
setAs('IDType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'IDType',  function(from)
  emlToS4(from))
setAs('SystemType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SystemType',  function(from)
  emlToS4(from))
setAs('ScopeType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ScopeType',  function(from)
  emlToS4(from))
setAs('FunctionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'FunctionType',  function(from)
  emlToS4(from))
setAs('online', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'online',  function(from)
  emlToS4(from))
setAs('offline', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'offline',  function(from)
  emlToS4(from))
setAs('inline', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'inline',  function(from)
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
setAs('DistributionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DistributionType',  function(from)
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
setAs('schemeName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'schemeName',  function(from)
  emlToS4(from))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
  emlToS4(from))
setAs('name', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'name',  function(from)
  emlToS4(from))
setAs('definition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'definition',  function(from)
  emlToS4(from))
setAs('defaultValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'defaultValue',  function(from)
  emlToS4(from))

setAs('parameterDefinition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'parameterDefinition',  function(from)
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
setAs('ConnectionDefinitionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ConnectionDefinitionType',  function(from)
  emlToS4(from))
setAs('InlineType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'InlineType',  function(from)
  emlToS4(from))
setAs('mediumName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumName',  function(from)
  emlToS4(from))
setAs('mediumDensity', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumDensity',  function(from)
  emlToS4(from))
setAs('mediumDensityUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumDensityUnits',  function(from)
  emlToS4(from))
setAs('mediumVolume', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumVolume',  function(from)
  emlToS4(from))
setAs('mediumFormat', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumFormat',  function(from)
  emlToS4(from))

setMethod(c, signature('mediumFormat'), function(x, ..., recursive = FALSE)
  new('ListOfmediumFormat', list(x, ...)))
setAs('mediumNote', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'mediumNote',  function(from)
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
setAs('OfflineType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'OfflineType',  function(from)
  emlToS4(from))
setAs('onlineDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'onlineDescription',  function(from)
  emlToS4(from))
setAs('url', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'url',  function(from)
  emlToS4(from))
setAs('connection', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'connection',  function(from)
  emlToS4(from))
setAs('connectionDefinition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'connectionDefinition',  function(from)
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
setAs('OnlineType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'OnlineType',  function(from)
  emlToS4(from))

setAs('UrlType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'UrlType',  function(from)
  emlToS4(from))
setAs('connectionDefinition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'connectionDefinition',  function(from)
  emlToS4(from))
setAs('name', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'name',  function(from)
  emlToS4(from))
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
  emlToS4(from))

setAs('parameter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'parameter',  function(from)
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
setAs('ConnectionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ConnectionType',  function(from)
  emlToS4(from))
setAs('NonEmptyStringType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'NonEmptyStringType',  function(from)
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
setAs('value', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'value',  function(from)
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
setAs('i18nNonEmptyStringType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'i18nNonEmptyStringType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialReference.xsd  ####


setAs('horizCoordSysName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizCoordSysName',  function(from)
  emlToS4(from))
setAs('horizCoordSysDef', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizCoordSysDef',  function(from)
  emlToS4(from))
setAs('altitudeDatumName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeDatumName',  function(from)
  emlToS4(from))
setAs('altitudeResolution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeResolution',  function(from)
  emlToS4(from))

setMethod(c, signature('altitudeResolution'), function(x, ..., recursive = FALSE)
  new('ListOfaltitudeResolution', list(x, ...)))
setAs('altitudeDistanceUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeDistanceUnits',  function(from)
  emlToS4(from))
setAs('altitudeEncodingMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeEncodingMethod',  function(from)
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
setAs('altitudeSysDef', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeSysDef',  function(from)
  emlToS4(from))
setAs('depthDatumName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'depthDatumName',  function(from)
  emlToS4(from))
setAs('depthResolution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'depthResolution',  function(from)
  emlToS4(from))

setMethod(c, signature('depthResolution'), function(x, ..., recursive = FALSE)
  new('ListOfdepthResolution', list(x, ...)))
setAs('depthDistanceUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'depthDistanceUnits',  function(from)
  emlToS4(from))
setAs('depthEncodingMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'depthEncodingMethod',  function(from)
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
setAs('depthSysDef', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'depthSysDef',  function(from)
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
setAs('vertCoordSys', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'vertCoordSys',  function(from)
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
setAs('SpatialReferenceType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SpatialReferenceType',  function(from)
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
setAs('datum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'datum',  function(from)
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
setAs('spheroid', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spheroid',  function(from)
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
setAs('primeMeridian', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'primeMeridian',  function(from)
  emlToS4(from))

setAs('unit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'unit',  function(from)
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
setAs('geogCoordSysType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geogCoordSysType',  function(from)
  emlToS4(from))
setAs('geogCoordSys', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geogCoordSys',  function(from)
  emlToS4(from))
setAs('geogCoordSys', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geogCoordSys',  function(from)
  emlToS4(from))

setAs('parameter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'parameter',  function(from)
  emlToS4(from))

setMethod(c, signature('parameter'), function(x, ..., recursive = FALSE)
  new('ListOfparameter', list(x, ...)))

setAs('unit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'unit',  function(from)
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
setAs('projection', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'projection',  function(from)
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
setAs('projCoordSys', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'projCoordSys',  function(from)
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
setAs('horizCoordSysType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizCoordSysType',  function(from)
  emlToS4(from))
setAs('horizCoordSysDef', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizCoordSysDef',  function(from)
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
setAs('projectionList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'projectionList',  function(from)
  emlToS4(from))
setAs('spatialReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialReference',  function(from)
  emlToS4(from))
setAs('lengthUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lengthUnits',  function(from)
  emlToS4(from))
setAs('angleUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'angleUnits',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-access.xsd  ####


setAs('access', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'access',  function(from)
  emlToS4(from))
setAs('allow', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'allow',  function(from)
  emlToS4(from))

setMethod(c, signature('allow'), function(x, ..., recursive = FALSE)
  new('ListOfallow', list(x, ...)))
setAs('deny', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'deny',  function(from)
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
setAs('AccessType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'AccessType',  function(from)
  emlToS4(from))
setAs('principal', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'principal',  function(from)
  emlToS4(from))

setMethod(c, signature('principal'), function(x, ..., recursive = FALSE)
  new('ListOfprincipal', list(x, ...)))
setAs('permission', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'permission',  function(from)
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
setAs('AccessRule', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'AccessRule',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-constraint.xsd  ####


setAs('attributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeReference',  function(from)
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
setAs('key', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'key',  function(from)
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
setAs('primaryKey', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'primaryKey',  function(from)
  emlToS4(from))
setAs('attributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeReference',  function(from)
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
setAs('key', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'key',  function(from)
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
setAs('uniqueKey', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'uniqueKey',  function(from)
  emlToS4(from))
setAs('checkCondition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'checkCondition',  function(from)
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
setAs('checkConstraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'checkConstraint',  function(from)
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
setAs('foreignKey', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'foreignKey',  function(from)
  emlToS4(from))
setAs('attributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeReference',  function(from)
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
setAs('referencedKey', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'referencedKey',  function(from)
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
setAs('joinCondition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'joinCondition',  function(from)
  emlToS4(from))
setAs('attributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeReference',  function(from)
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
setAs('key', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'key',  function(from)
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
setAs('notNullConstraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'notNullConstraint',  function(from)
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
setAs('ConstraintType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ConstraintType',  function(from)
  emlToS4(from))
setAs('CardinalityChildOccurancesType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'CardinalityChildOccurancesType',  function(from)
  emlToS4(from))
setAs('constraintName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraintName',  function(from)
  emlToS4(from))
setAs('constraintDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraintDescription',  function(from)
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
setAs('ConstraintBaseGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ConstraintBaseGroup',  function(from)
  emlToS4(from))
setAs('attributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeReference',  function(from)
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
setAs('key', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'key',  function(from)
  emlToS4(from))
setAs('entityReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityReference',  function(from)
  emlToS4(from))
setAs('relationshipType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'relationshipType',  function(from)
  emlToS4(from))
setAs('parentOccurences', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'parentOccurences',  function(from)
  emlToS4(from))
setAs('childOccurences', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'childOccurences',  function(from)
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
setAs('cardinality', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cardinality',  function(from)
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
setAs('ForeignKeyGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ForeignKeyGroup',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-literature.xsd  ####


setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
  emlToS4(from))
setAs('contact', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'contact',  function(from)
  emlToS4(from))

setMethod(c, signature('contact'), function(x, ..., recursive = FALSE)
  new('ListOfcontact', list(x, ...)))
setAs('article', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'article',  function(from)
  emlToS4(from))
setAs('book', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'book',  function(from)
  emlToS4(from))
setAs('chapter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'chapter',  function(from)
  emlToS4(from))
setAs('editedBook', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'editedBook',  function(from)
  emlToS4(from))
setAs('manuscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'manuscript',  function(from)
  emlToS4(from))
setAs('report', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'report',  function(from)
  emlToS4(from))
setAs('thesis', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'thesis',  function(from)
  emlToS4(from))
setAs('conferenceProceedings', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceProceedings',  function(from)
  emlToS4(from))
setAs('personalCommunication', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'personalCommunication',  function(from)
  emlToS4(from))
setAs('map', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'map',  function(from)
  emlToS4(from))
setAs('generic', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'generic',  function(from)
  emlToS4(from))
setAs('audioVisual', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'audioVisual',  function(from)
  emlToS4(from))
setAs('presentation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'presentation',  function(from)
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
setAs('CitationType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'CitationType',  function(from)
  emlToS4(from))
setAs('journal', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'journal',  function(from)
  emlToS4(from))
setAs('volume', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'volume',  function(from)
  emlToS4(from))
setAs('issue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'issue',  function(from)
  emlToS4(from))
setAs('pageRange', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pageRange',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('ISSN', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ISSN',  function(from)
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
setAs('Article', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Article',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('edition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'edition',  function(from)
  emlToS4(from))
setAs('volume', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'volume',  function(from)
  emlToS4(from))
setAs('numberOfVolumes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numberOfVolumes',  function(from)
  emlToS4(from))
setAs('totalPages', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalPages',  function(from)
  emlToS4(from))
setAs('totalFigures', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalFigures',  function(from)
  emlToS4(from))
setAs('totalTables', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalTables',  function(from)
  emlToS4(from))
setAs('ISBN', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ISBN',  function(from)
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
setAs('Book', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Book',  function(from)
  emlToS4(from))
setAs('chapterNumber', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'chapterNumber',  function(from)
  emlToS4(from))
setAs('editor', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'editor',  function(from)
  emlToS4(from))

setMethod(c, signature('editor'), function(x, ..., recursive = FALSE)
  new('ListOfeditor', list(x, ...)))
setAs('bookTitle', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bookTitle',  function(from)
  emlToS4(from))
setAs('pageRange', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pageRange',  function(from)
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
setAs('Chapter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Chapter',  function(from)
  emlToS4(from))
setAs('conferenceName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceName',  function(from)
  emlToS4(from))
setAs('conferenceDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceDate',  function(from)
  emlToS4(from))
setAs('conferenceLocation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceLocation',  function(from)
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
setAs('ConferenceProceedings', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ConferenceProceedings',  function(from)
  emlToS4(from))
setAs('institution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'institution',  function(from)
  emlToS4(from))

setMethod(c, signature('institution'), function(x, ..., recursive = FALSE)
  new('ListOfinstitution', list(x, ...)))
setAs('totalPages', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalPages',  function(from)
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
setAs('Manuscript', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Manuscript',  function(from)
  emlToS4(from))
setAs('reportNumber', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'reportNumber',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('totalPages', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalPages',  function(from)
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
setAs('Report', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Report',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('communicationType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'communicationType',  function(from)
  emlToS4(from))
setAs('recipient', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'recipient',  function(from)
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
setAs('PersonalCommunication', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'PersonalCommunication',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('edition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'edition',  function(from)
  emlToS4(from))
setAs('geographicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geographicCoverage',  function(from)
  emlToS4(from))

setMethod(c, signature('geographicCoverage'), function(x, ..., recursive = FALSE)
  new('ListOfgeographicCoverage', list(x, ...)))
setAs('scale', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'scale',  function(from)
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
setAs('Map', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Map',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))

setMethod(c, signature('publicationPlace'), function(x, ..., recursive = FALSE)
  new('ListOfpublicationPlace', list(x, ...)))
setAs('performer', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'performer',  function(from)
  emlToS4(from))

setMethod(c, signature('performer'), function(x, ..., recursive = FALSE)
  new('ListOfperformer', list(x, ...)))
setAs('ISBN', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ISBN',  function(from)
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
setAs('AudioVisual', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'AudioVisual',  function(from)
  emlToS4(from))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('publicationPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publicationPlace',  function(from)
  emlToS4(from))
setAs('referenceType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'referenceType',  function(from)
  emlToS4(from))
setAs('volume', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'volume',  function(from)
  emlToS4(from))
setAs('numberOfVolumes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numberOfVolumes',  function(from)
  emlToS4(from))
setAs('totalPages', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalPages',  function(from)
  emlToS4(from))
setAs('totalFigures', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalFigures',  function(from)
  emlToS4(from))
setAs('totalTables', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalTables',  function(from)
  emlToS4(from))
setAs('edition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'edition',  function(from)
  emlToS4(from))
setAs('originalPublication', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'originalPublication',  function(from)
  emlToS4(from))
setAs('reprintEdition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'reprintEdition',  function(from)
  emlToS4(from))
setAs('reviewedItem', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'reviewedItem',  function(from)
  emlToS4(from))
setAs('ISBN', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ISBN',  function(from)
  emlToS4(from))
setAs('ISSN', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ISSN',  function(from)
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
setAs('Generic', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Generic',  function(from)
  emlToS4(from))
setAs('degree', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'degree',  function(from)
  emlToS4(from))
setAs('institution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'institution',  function(from)
  emlToS4(from))
setAs('totalPages', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalPages',  function(from)
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
setAs('Thesis', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Thesis',  function(from)
  emlToS4(from))
setAs('conferenceName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceName',  function(from)
  emlToS4(from))
setAs('conferenceDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceDate',  function(from)
  emlToS4(from))
setAs('conferenceLocation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'conferenceLocation',  function(from)
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
setAs('Presentation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Presentation',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-coverage.xsd  ####


setAs('geographicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geographicCoverage',  function(from)
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
setAs('temporalCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'temporalCoverage',  function(from)
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
setAs('taxonomicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicCoverage',  function(from)
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
setAs('Coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Coverage',  function(from)
  emlToS4(from))
setAs('singleDateTime', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'singleDateTime',  function(from)
  emlToS4(from))

setMethod(c, signature('singleDateTime'), function(x, ..., recursive = FALSE)
  new('ListOfsingleDateTime', list(x, ...)))
setAs('beginDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'beginDate',  function(from)
  emlToS4(from))
setAs('endDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'endDate',  function(from)
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
setAs('rangeOfDates', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'rangeOfDates',  function(from)
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
setAs('TemporalCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'TemporalCoverage',  function(from)
  emlToS4(from))
setAs('calendarDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'calendarDate',  function(from)
  emlToS4(from))
setAs('time', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'time',  function(from)
  emlToS4(from))
setAs('timeScaleName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'timeScaleName',  function(from)
  emlToS4(from))
setAs('timeScaleAgeEstimate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'timeScaleAgeEstimate',  function(from)
  emlToS4(from))
setAs('timeScaleAgeUncertainty', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'timeScaleAgeUncertainty',  function(from)
  emlToS4(from))
setAs('timeScaleAgeExplanation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'timeScaleAgeExplanation',  function(from)
  emlToS4(from))
setAs('timeScaleCitation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'timeScaleCitation',  function(from)
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
setAs('alternativeTimeScale', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'alternativeTimeScale',  function(from)
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
setAs('SingleDateTimeType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SingleDateTimeType',  function(from)
  emlToS4(from))
setAs('geographicDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geographicDescription',  function(from)
  emlToS4(from))
setAs('westBoundingCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'westBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('eastBoundingCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'eastBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('northBoundingCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'northBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('southBoundingCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'southBoundingCoordinate',  function(from)
  emlToS4(from))
setAs('altitudeMinimum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeMinimum',  function(from)
  emlToS4(from))
setAs('altitudeMaximum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeMaximum',  function(from)
  emlToS4(from))
setAs('altitudeUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'altitudeUnits',  function(from)
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
setAs('boundingAltitudes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'boundingAltitudes',  function(from)
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
setAs('boundingCoordinates', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'boundingCoordinates',  function(from)
  emlToS4(from))
setAs('gRingPoint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRingPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('gRingPoint'), function(x, ..., recursive = FALSE)
  new('ListOfgRingPoint', list(x, ...)))
setAs('gRing', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRing',  function(from)
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
setAs('datasetGPolygonOuterGRing', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'datasetGPolygonOuterGRing',  function(from)
  emlToS4(from))
setAs('gRingPoint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRingPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('gRingPoint'), function(x, ..., recursive = FALSE)
  new('ListOfgRingPoint', list(x, ...)))
setAs('gRing', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRing',  function(from)
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
setAs('datasetGPolygonExclusionGRing', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'datasetGPolygonExclusionGRing',  function(from)
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
setAs('datasetGPolygon', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'datasetGPolygon',  function(from)
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
setAs('GeographicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'GeographicCoverage',  function(from)
  emlToS4(from))
setAs('gRingLatitude', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRingLatitude',  function(from)
  emlToS4(from))
setAs('gRingLongitude', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'gRingLongitude',  function(from)
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
setAs('GRingPointType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'GRingPointType',  function(from)
  emlToS4(from))
setAs('GRingType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'GRingType',  function(from)
  emlToS4(from))
setAs('classificationSystemCitation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'classificationSystemCitation',  function(from)
  emlToS4(from))
setAs('classificationSystemModifications', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'classificationSystemModifications',  function(from)
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
setAs('classificationSystem', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'classificationSystem',  function(from)
  emlToS4(from))

setMethod(c, signature('classificationSystem'), function(x, ..., recursive = FALSE)
  new('ListOfclassificationSystem', list(x, ...)))
setAs('identificationReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'identificationReference',  function(from)
  emlToS4(from))

setMethod(c, signature('identificationReference'), function(x, ..., recursive = FALSE)
  new('ListOfidentificationReference', list(x, ...)))
setAs('identifierName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'identifierName',  function(from)
  emlToS4(from))

setMethod(c, signature('identifierName'), function(x, ..., recursive = FALSE)
  new('ListOfidentifierName', list(x, ...)))
setAs('taxonomicProcedures', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicProcedures',  function(from)
  emlToS4(from))
setAs('taxonomicCompleteness', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicCompleteness',  function(from)
  emlToS4(from))
setAs('specimen', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'specimen',  function(from)
  emlToS4(from))
setAs('originator', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'originator',  function(from)
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
setAs('repository', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'repository',  function(from)
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
setAs('vouchers', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'vouchers',  function(from)
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
setAs('taxonomicSystem', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicSystem',  function(from)
  emlToS4(from))
setAs('generalTaxonomicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'generalTaxonomicCoverage',  function(from)
  emlToS4(from))
setAs('taxonomicClassification', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicClassification',  function(from)
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
setAs('TaxonomicCoverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'TaxonomicCoverage',  function(from)
  emlToS4(from))
setAs('taxonRankName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonRankName',  function(from)
  emlToS4(from))
setAs('taxonRankValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonRankValue',  function(from)
  emlToS4(from))
setAs('commonName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'commonName',  function(from)
  emlToS4(from))

setMethod(c, signature('commonName'), function(x, ..., recursive = FALSE)
  new('ListOfcommonName', list(x, ...)))
setAs('taxonomicClassification', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'taxonomicClassification',  function(from)
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
setAs('TaxonomicClassificationType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'TaxonomicClassificationType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-physical.xsd  ####


setAs('physical', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'physical',  function(from)
  emlToS4(from))
setAs('objectName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'objectName',  function(from)
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
setAs('size', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'size',  function(from)
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
setAs('authentication', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'authentication',  function(from)
  emlToS4(from))

setMethod(c, signature('authentication'), function(x, ..., recursive = FALSE)
  new('ListOfauthentication', list(x, ...)))
setAs('compressionMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'compressionMethod',  function(from)
  emlToS4(from))

setMethod(c, signature('compressionMethod'), function(x, ..., recursive = FALSE)
  new('ListOfcompressionMethod', list(x, ...)))
setAs('encodingMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'encodingMethod',  function(from)
  emlToS4(from))

setMethod(c, signature('encodingMethod'), function(x, ..., recursive = FALSE)
  new('ListOfencodingMethod', list(x, ...)))
setAs('characterEncoding', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'characterEncoding',  function(from)
  emlToS4(from))
setAs('numHeaderLines', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numHeaderLines',  function(from)
  emlToS4(from))
setAs('numFooterLines', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numFooterLines',  function(from)
  emlToS4(from))
setAs('recordDelimiter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'recordDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('recordDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOfrecordDelimiter', list(x, ...)))
setAs('physicalLineDelimiter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'physicalLineDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('physicalLineDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOfphysicalLineDelimiter', list(x, ...)))
setAs('numPhysicalLinesPerRecord', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numPhysicalLinesPerRecord',  function(from)
  emlToS4(from))
setAs('maxRecordLength', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'maxRecordLength',  function(from)
  emlToS4(from))
setAs('attributeOrientation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeOrientation',  function(from)
  emlToS4(from))
setAs('fieldDelimiter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'fieldDelimiter',  function(from)
  emlToS4(from))

setMethod(c, signature('fieldDelimiter'), function(x, ..., recursive = FALSE)
  new('ListOffieldDelimiter', list(x, ...)))
setAs('collapseDelimiters', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'collapseDelimiters',  function(from)
  emlToS4(from))
setAs('quoteCharacter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quoteCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('quoteCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfquoteCharacter', list(x, ...)))
setAs('literalCharacter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'literalCharacter',  function(from)
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
setAs('simpleDelimited', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'simpleDelimited',  function(from)
  emlToS4(from))
setAs('fieldWidth', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'fieldWidth',  function(from)
  emlToS4(from))
setAs('lineNumber', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lineNumber',  function(from)
  emlToS4(from))
setAs('fieldStartColumn', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'fieldStartColumn',  function(from)
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
setAs('textFixed', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'textFixed',  function(from)
  emlToS4(from))

setMethod(c, signature('textFixed'), function(x, ..., recursive = FALSE)
  new('ListOftextFixed', list(x, ...)))
setAs('fieldDelimiter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'fieldDelimiter',  function(from)
  emlToS4(from))
setAs('collapseDelimiters', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'collapseDelimiters',  function(from)
  emlToS4(from))
setAs('lineNumber', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lineNumber',  function(from)
  emlToS4(from))
setAs('quoteCharacter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quoteCharacter',  function(from)
  emlToS4(from))

setMethod(c, signature('quoteCharacter'), function(x, ..., recursive = FALSE)
  new('ListOfquoteCharacter', list(x, ...)))
setAs('literalCharacter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'literalCharacter',  function(from)
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
setAs('textDelimited', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'textDelimited',  function(from)
  emlToS4(from))

setMethod(c, signature('textDelimited'), function(x, ..., recursive = FALSE)
  new('ListOftextDelimited', list(x, ...)))

setAs('eml:complex', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'eml:complex',  function(from)
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
setAs('textFormat', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'textFormat',  function(from)
  emlToS4(from))
setAs('formatName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'formatName',  function(from)
  emlToS4(from))
setAs('formatVersion', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'formatVersion',  function(from)
  emlToS4(from))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
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
setAs('externallyDefinedFormat', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'externallyDefinedFormat',  function(from)
  emlToS4(from))
setAs('rowColumnOrientation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'rowColumnOrientation',  function(from)
  emlToS4(from))
setAs('nbands', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'nbands',  function(from)
  emlToS4(from))
setAs('layout', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'layout',  function(from)
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
setAs('multiBand', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'multiBand',  function(from)
  emlToS4(from))
setAs('nbits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'nbits',  function(from)
  emlToS4(from))
setAs('byteorder', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'byteorder',  function(from)
  emlToS4(from))
setAs('skipbytes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'skipbytes',  function(from)
  emlToS4(from))
setAs('bandrowbytes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bandrowbytes',  function(from)
  emlToS4(from))
setAs('totalrowbytes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'totalrowbytes',  function(from)
  emlToS4(from))
setAs('bandgapbytes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bandgapbytes',  function(from)
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
setAs('binaryRasterFormat', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'binaryRasterFormat',  function(from)
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
setAs('dataFormat', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataFormat',  function(from)
  emlToS4(from))
setAs('distribution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'distribution',  function(from)
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
setAs('PhysicalType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'PhysicalType',  function(from)
  emlToS4(from))
setAs('online', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'online',  function(from)
  emlToS4(from))
setAs('offline', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'offline',  function(from)
  emlToS4(from))
setAs('inline', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'inline',  function(from)
  emlToS4(from))
setAs('access', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'access',  function(from)
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
setAs('PhysicalDistributionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'PhysicalDistributionType',  function(from)
  emlToS4(from))
setAs('onlineDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'onlineDescription',  function(from)
  emlToS4(from))
setAs('url', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'url',  function(from)
  emlToS4(from))
setAs('connection', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'connection',  function(from)
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
setAs('PhysicalOnlineType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'PhysicalOnlineType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-project.xsd  ####


setAs('researchProject', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'researchProject',  function(from)
  emlToS4(from))
setAs('title', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'title',  function(from)
  emlToS4(from))

setMethod(c, signature('title'), function(x, ..., recursive = FALSE)
  new('ListOftitle', list(x, ...)))
setAs('role', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'role',  function(from)
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
setAs('personnel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'personnel',  function(from)
  emlToS4(from))

setMethod(c, signature('personnel'), function(x, ..., recursive = FALSE)
  new('ListOfpersonnel', list(x, ...)))
setAs('abstract', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'abstract',  function(from)
  emlToS4(from))
setAs('funding', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'funding',  function(from)
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
setAs('descriptorValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'descriptorValue',  function(from)
  emlToS4(from))

setMethod(c, signature('descriptorValue'), function(x, ..., recursive = FALSE)
  new('ListOfdescriptorValue', list(x, ...)))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
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
setAs('descriptor', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'descriptor',  function(from)
  emlToS4(from))

setMethod(c, signature('descriptor'), function(x, ..., recursive = FALSE)
  new('ListOfdescriptor', list(x, ...)))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
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
setAs('studyAreaDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'studyAreaDescription',  function(from)
  emlToS4(from))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
  emlToS4(from))

setMethod(c, signature('description'), function(x, ..., recursive = FALSE)
  new('ListOfdescription', list(x, ...)))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
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
setAs('designDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'designDescription',  function(from)
  emlToS4(from))
setAs('relatedProject', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'relatedProject',  function(from)
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
setAs('ResearchProjectType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ResearchProjectType',  function(from)
  emlToS4(from))
setAs('DescriptorType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DescriptorType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-software.xsd  ####


setAs('software', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'software',  function(from)
  emlToS4(from))
setAs('distribution', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'distribution',  function(from)
  emlToS4(from))

setMethod(c, signature('distribution'), function(x, ..., recursive = FALSE)
  new('ListOfdistribution', list(x, ...)))
setAs('size', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'size',  function(from)
  emlToS4(from))
setAs('LanguageValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'LanguageValue',  function(from)
  emlToS4(from))
setAs('LanguageCodeStandard', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'LanguageCodeStandard',  function(from)
  emlToS4(from))

setAs('language', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'language',  function(from)
  emlToS4(from))

setMethod(c, signature('eml:language'), function(x, ..., recursive = FALSE)
  new('ListOflanguage', list(x, ...)))
setAs('operatingSystem', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'operatingSystem',  function(from)
  emlToS4(from))

setMethod(c, signature('operatingSystem'), function(x, ..., recursive = FALSE)
  new('ListOfoperatingSystem', list(x, ...)))
setAs('machineProcessor', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'machineProcessor',  function(from)
  emlToS4(from))

setMethod(c, signature('machineProcessor'), function(x, ..., recursive = FALSE)
  new('ListOfmachineProcessor', list(x, ...)))
setAs('virtualMachine', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'virtualMachine',  function(from)
  emlToS4(from))
setAs('diskUsage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'diskUsage',  function(from)
  emlToS4(from))
setAs('runtimeMemoryUsage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'runtimeMemoryUsage',  function(from)
  emlToS4(from))
setAs('programmingLanguage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'programmingLanguage',  function(from)
  emlToS4(from))

setMethod(c, signature('programmingLanguage'), function(x, ..., recursive = FALSE)
  new('ListOfprogrammingLanguage', list(x, ...)))
setAs('checksum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'checksum',  function(from)
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
setAs('implementation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'implementation',  function(from)
  emlToS4(from))

setMethod(c, signature('implementation'), function(x, ..., recursive = FALSE)
  new('ListOfimplementation', list(x, ...)))
setAs('licenseURL', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'licenseURL',  function(from)
  emlToS4(from))

setMethod(c, signature('licenseURL'), function(x, ..., recursive = FALSE)
  new('ListOflicenseURL', list(x, ...)))
setAs('license', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'license',  function(from)
  emlToS4(from))

setMethod(c, signature('license'), function(x, ..., recursive = FALSE)
  new('ListOflicense', list(x, ...)))
setAs('version', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'version',  function(from)
  emlToS4(from))
setAs('project', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'project',  function(from)
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
setAs('SoftwareType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SoftwareType',  function(from)
  emlToS4(from))
setAs('Action', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Action',  function(from)
  emlToS4(from))
setAs('action', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'action',  function(from)
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
setAs('dependency', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dependency',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-protocol.xsd  ####


setAs('proceduralStep', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'proceduralStep',  function(from)
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
setAs('ProtocolType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ProtocolType',  function(from)
  emlToS4(from))
setAs('protocol', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'protocol',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-methods.xsd  ####


setAs('methods', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'methods',  function(from)
  emlToS4(from))
setAs('dataSource', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataSource',  function(from)
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
setAs('methodStep', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'methodStep',  function(from)
  emlToS4(from))

setMethod(c, signature('methodStep'), function(x, ..., recursive = FALSE)
  new('ListOfmethodStep', list(x, ...)))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
  emlToS4(from))

setMethod(c, signature('coverage'), function(x, ..., recursive = FALSE)
  new('ListOfcoverage', list(x, ...)))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
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
setAs('studyExtent', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'studyExtent',  function(from)
  emlToS4(from))
setAs('samplingDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'samplingDescription',  function(from)
  emlToS4(from))
setAs('referencedEntityId', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'referencedEntityId',  function(from)
  emlToS4(from))

setMethod(c, signature('referencedEntityId'), function(x, ..., recursive = FALSE)
  new('ListOfreferencedEntityId', list(x, ...)))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
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
setAs('spatialSamplingUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialSamplingUnits',  function(from)
  emlToS4(from))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
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
setAs('sampling', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'sampling',  function(from)
  emlToS4(from))

setMethod(c, signature('sampling'), function(x, ..., recursive = FALSE)
  new('ListOfsampling', list(x, ...)))
setAs('qualityControl', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'qualityControl',  function(from)
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
setAs('MethodsType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'MethodsType',  function(from)
  emlToS4(from))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
  emlToS4(from))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('protocol', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'protocol',  function(from)
  emlToS4(from))

setMethod(c, signature('protocol'), function(x, ..., recursive = FALSE)
  new('ListOfprotocol', list(x, ...)))
setAs('instrumentation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'instrumentation',  function(from)
  emlToS4(from))

setMethod(c, signature('instrumentation'), function(x, ..., recursive = FALSE)
  new('ListOfinstrumentation', list(x, ...)))
setAs('software', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'software',  function(from)
  emlToS4(from))

setMethod(c, signature('software'), function(x, ..., recursive = FALSE)
  new('ListOfsoftware', list(x, ...)))
setAs('subStep', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'subStep',  function(from)
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
setAs('ProcedureStepType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ProcedureStepType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-attribute.xsd  ####


setAs('attribute', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attribute',  function(from)
  emlToS4(from))
setAs('attribute', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attribute',  function(from)
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
setAs('AttributeListType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'AttributeListType',  function(from)
  emlToS4(from))
setAs('attributeName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeName',  function(from)
  emlToS4(from))
setAs('attributeLabel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeLabel',  function(from)
  emlToS4(from))

setMethod(c, signature('attributeLabel'), function(x, ..., recursive = FALSE)
  new('ListOfattributeLabel', list(x, ...)))
setAs('attributeDefinition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeDefinition',  function(from)
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
setAs('storageType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'storageType',  function(from)
  emlToS4(from))

setMethod(c, signature('storageType'), function(x, ..., recursive = FALSE)
  new('ListOfstorageType', list(x, ...)))
setAs('nonNumericDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'nonNumericDomain',  function(from)
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
setAs('nominal', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'nominal',  function(from)
  emlToS4(from))
setAs('nonNumericDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'nonNumericDomain',  function(from)
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
setAs('ordinal', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ordinal',  function(from)
  emlToS4(from))
setAs('unit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'unit',  function(from)
  emlToS4(from))
setAs('precision', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'precision',  function(from)
  emlToS4(from))
setAs('numericDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numericDomain',  function(from)
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
setAs('interval', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'interval',  function(from)
  emlToS4(from))
setAs('unit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'unit',  function(from)
  emlToS4(from))
setAs('precision', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'precision',  function(from)
  emlToS4(from))
setAs('numericDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numericDomain',  function(from)
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
setAs('ratio', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ratio',  function(from)
  emlToS4(from))
setAs('formatString', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'formatString',  function(from)
  emlToS4(from))
setAs('dateTimePrecision', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dateTimePrecision',  function(from)
  emlToS4(from))
setAs('dateTimeDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dateTimeDomain',  function(from)
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
setAs('dateTime', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dateTime',  function(from)
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
setAs('measurementScale', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'measurementScale',  function(from)
  emlToS4(from))
setAs('code', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'code',  function(from)
  emlToS4(from))
setAs('codeExplanation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'codeExplanation',  function(from)
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
setAs('missingValueCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'missingValueCode',  function(from)
  emlToS4(from))

setMethod(c, signature('missingValueCode'), function(x, ..., recursive = FALSE)
  new('ListOfmissingValueCode', list(x, ...)))
setAs('accuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'accuracy',  function(from)
  emlToS4(from))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
  emlToS4(from))
setAs('methods', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'methods',  function(from)
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
setAs('AttributeType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'AttributeType',  function(from)
  emlToS4(from))
setAs('attributeAccuracyReport', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeAccuracyReport',  function(from)
  emlToS4(from))
setAs('attributeAccuracyValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeAccuracyValue',  function(from)
  emlToS4(from))
setAs('attributeAccuracyExplanation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeAccuracyExplanation',  function(from)
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
setAs('quantitativeAttributeAccuracyAssessment', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAttributeAccuracyAssessment',  function(from)
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
setAs('Accuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'Accuracy',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('standardUnit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'standardUnit',  function(from)
  emlToS4(from))
setAs('customUnit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'customUnit',  function(from)
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
setAs('UnitType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'UnitType',  function(from)
  emlToS4(from))
setAs('PrecisionType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'PrecisionType',  function(from)
  emlToS4(from))
setAs('code', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'code',  function(from)
  emlToS4(from))
setAs('definition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'definition',  function(from)
  emlToS4(from))
setAs('source', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'source',  function(from)
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
setAs('codeDefinition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'codeDefinition',  function(from)
  emlToS4(from))

setMethod(c, signature('codeDefinition'), function(x, ..., recursive = FALSE)
  new('ListOfcodeDefinition', list(x, ...)))
setAs('codesetName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'codesetName',  function(from)
  emlToS4(from))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
  emlToS4(from))

setMethod(c, signature('citation'), function(x, ..., recursive = FALSE)
  new('ListOfcitation', list(x, ...)))
setAs('codesetURL', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'codesetURL',  function(from)
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
setAs('externalCodeSet', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'externalCodeSet',  function(from)
  emlToS4(from))
setAs('entityReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityReference',  function(from)
  emlToS4(from))
setAs('valueAttributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'valueAttributeReference',  function(from)
  emlToS4(from))
setAs('definitionAttributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'definitionAttributeReference',  function(from)
  emlToS4(from))
setAs('orderAttributeReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'orderAttributeReference',  function(from)
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
setAs('entityCodeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityCodeList',  function(from)
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
setAs('enumeratedDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'enumeratedDomain',  function(from)
  emlToS4(from))

setMethod(c, signature('enumeratedDomain'), function(x, ..., recursive = FALSE)
  new('ListOfenumeratedDomain', list(x, ...)))
setAs('definition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'definition',  function(from)
  emlToS4(from))
setAs('pattern', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pattern',  function(from)
  emlToS4(from))

setMethod(c, signature('pattern'), function(x, ..., recursive = FALSE)
  new('ListOfpattern', list(x, ...)))
setAs('source', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'source',  function(from)
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
setAs('textDomain', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'textDomain',  function(from)
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
setAs('NonNumericDomainType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'NonNumericDomainType',  function(from)
  emlToS4(from))
setAs('numberType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numberType',  function(from)
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
setAs('NumericDomainType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'NumericDomainType',  function(from)
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
setAs('DateTimeDomainType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DateTimeDomainType',  function(from)
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
setAs('minimum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'minimum',  function(from)
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
setAs('maximum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'maximum',  function(from)
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
setAs('bounds', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bounds',  function(from)
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
setAs('BoundsGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'BoundsGroup',  function(from)
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
setAs('minimum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'minimum',  function(from)
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
setAs('maximum', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'maximum',  function(from)
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
setAs('bounds', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bounds',  function(from)
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
setAs('BoundsDateGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'BoundsDateGroup',  function(from)
  emlToS4(from))
setAs('NumberType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'NumberType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-entity.xsd  ####


setAs('otherEntity', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'otherEntity',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('entityType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityType',  function(from)
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
setAs('OtherEntityType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'OtherEntityType',  function(from)
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
setAs('alternateIdentifier', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'alternateIdentifier',  function(from)
  emlToS4(from))

setMethod(c, signature('alternateIdentifier'), function(x, ..., recursive = FALSE)
  new('ListOfalternateIdentifier', list(x, ...)))
setAs('entityName', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityName',  function(from)
  emlToS4(from))
setAs('entityDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'entityDescription',  function(from)
  emlToS4(from))
setAs('physical', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'physical',  function(from)
  emlToS4(from))

setMethod(c, signature('physical'), function(x, ..., recursive = FALSE)
  new('ListOfphysical', list(x, ...)))
setAs('coverage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'coverage',  function(from)
  emlToS4(from))
setAs('methods', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'methods',  function(from)
  emlToS4(from))
setAs('additionalInfo', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'additionalInfo',  function(from)
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
setAs('EntityGroup', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'EntityGroup',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-dataTable.xsd  ####


setAs('dataTable', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataTable',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('caseSensitive', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'caseSensitive',  function(from)
  emlToS4(from))
setAs('numberOfRecords', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numberOfRecords',  function(from)
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
setAs('DataTableType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DataTableType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-view.xsd  ####


setAs('view', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'view',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('queryStatement', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'queryStatement',  function(from)
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
setAs('ViewType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ViewType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-storedProcedure.xsd  ####


setAs('storedProcedure', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'storedProcedure',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('parameter', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'parameter',  function(from)
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
setAs('StoredProcedureType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'StoredProcedureType',  function(from)
  emlToS4(from))
setAs('name', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'name',  function(from)
  emlToS4(from))
setAs('domainDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'domainDescription',  function(from)
  emlToS4(from))
setAs('required', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'required',  function(from)
  emlToS4(from))
setAs('repeats', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'repeats',  function(from)
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
setAs('ParameterType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ParameterType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialVector.xsd  ####


setAs('spatialVector', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialVector',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('geometry', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geometry',  function(from)
  emlToS4(from))

setMethod(c, signature('geometry'), function(x, ..., recursive = FALSE)
  new('ListOfgeometry', list(x, ...)))
setAs('geometricObjectCount', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'geometricObjectCount',  function(from)
  emlToS4(from))
setAs('topologyLevel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'topologyLevel',  function(from)
  emlToS4(from))
setAs('spatialReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialReference',  function(from)
  emlToS4(from))
setAs('horizontalAccuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizontalAccuracy',  function(from)
  emlToS4(from))
setAs('verticalAccuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'verticalAccuracy',  function(from)
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
setAs('SpatialVectorType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SpatialVectorType',  function(from)
  emlToS4(from))
setAs('GeometryType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'GeometryType',  function(from)
  emlToS4(from))
setAs('TopologyLevel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'TopologyLevel',  function(from)
  emlToS4(from))
setAs('accuracyReport', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'accuracyReport',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyValue',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyMethod',  function(from)
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
setAs('quantitativeAccuracyReport', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyReport',  function(from)
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
setAs('DataQuality', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DataQuality',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-spatialRaster.xsd  ####


setAs('spatialRaster', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialRaster',  function(from)
  emlToS4(from))
setAs('attributeList', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'attributeList',  function(from)
  emlToS4(from))
setAs('constraint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'constraint',  function(from)
  emlToS4(from))

setMethod(c, signature('constraint'), function(x, ..., recursive = FALSE)
  new('ListOfconstraint', list(x, ...)))
setAs('spatialReference', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialReference',  function(from)
  emlToS4(from))
setAs('xCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'xCoordinate',  function(from)
  emlToS4(from))
setAs('yCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'yCoordinate',  function(from)
  emlToS4(from))
setAs('pointInPixel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pointInPixel',  function(from)
  emlToS4(from))
setAs('corner', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'corner',  function(from)
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
setAs('cornerPoint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cornerPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('cornerPoint'), function(x, ..., recursive = FALSE)
  new('ListOfcornerPoint', list(x, ...)))
setAs('column', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'column',  function(from)
  emlToS4(from))
setAs('row', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'row',  function(from)
  emlToS4(from))
setAs('xCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'xCoordinate',  function(from)
  emlToS4(from))
setAs('yCoordinate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'yCoordinate',  function(from)
  emlToS4(from))
setAs('pointInPixel', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pointInPixel',  function(from)
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
setAs('controlPoint', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'controlPoint',  function(from)
  emlToS4(from))

setMethod(c, signature('controlPoint'), function(x, ..., recursive = FALSE)
  new('ListOfcontrolPoint', list(x, ...)))
setAs('xIntercept', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'xIntercept',  function(from)
  emlToS4(from))
setAs('xSlope', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'xSlope',  function(from)
  emlToS4(from))
setAs('yIntercept', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'yIntercept',  function(from)
  emlToS4(from))
setAs('ySlope', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ySlope',  function(from)
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
setAs('bilinearFit', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bilinearFit',  function(from)
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
setAs('georeferenceInfo', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'georeferenceInfo',  function(from)
  emlToS4(from))
setAs('horizontalAccuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'horizontalAccuracy',  function(from)
  emlToS4(from))
setAs('verticalAccuracy', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'verticalAccuracy',  function(from)
  emlToS4(from))
setAs('cellSizeXDirection', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cellSizeXDirection',  function(from)
  emlToS4(from))
setAs('cellSizeYDirection', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cellSizeYDirection',  function(from)
  emlToS4(from))
setAs('numberOfBands', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'numberOfBands',  function(from)
  emlToS4(from))
setAs('rasterOrigin', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'rasterOrigin',  function(from)
  emlToS4(from))
setAs('rows', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'rows',  function(from)
  emlToS4(from))
setAs('columns', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'columns',  function(from)
  emlToS4(from))
setAs('verticals', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'verticals',  function(from)
  emlToS4(from))
setAs('cellGeometry', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cellGeometry',  function(from)
  emlToS4(from))
setAs('toneGradation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'toneGradation',  function(from)
  emlToS4(from))
setAs('scaleFactor', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'scaleFactor',  function(from)
  emlToS4(from))
setAs('offset', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'offset',  function(from)
  emlToS4(from))
setAs('illuminationElevationAngle', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'illuminationElevationAngle',  function(from)
  emlToS4(from))
setAs('illuminationAzimuthAngle', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'illuminationAzimuthAngle',  function(from)
  emlToS4(from))
setAs('imageOrientationAngle', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'imageOrientationAngle',  function(from)
  emlToS4(from))
setAs('imagingCondition', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'imagingCondition',  function(from)
  emlToS4(from))
setAs('imageQualityCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'imageQualityCode',  function(from)
  emlToS4(from))
setAs('cloudCoverPercentage', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cloudCoverPercentage',  function(from)
  emlToS4(from))
setAs('preProcessingTypeCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'preProcessingTypeCode',  function(from)
  emlToS4(from))
setAs('compressionGenerationQuality', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'compressionGenerationQuality',  function(from)
  emlToS4(from))
setAs('triangulationIndicator', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'triangulationIndicator',  function(from)
  emlToS4(from))
setAs('radiometricDataAvailability', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'radiometricDataAvailability',  function(from)
  emlToS4(from))
setAs('cameraCalibrationInformationAvailability', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'cameraCalibrationInformationAvailability',  function(from)
  emlToS4(from))
setAs('filmDistortionInformationAvailability', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'filmDistortionInformationAvailability',  function(from)
  emlToS4(from))
setAs('lensDistortionInformationAvailability', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lensDistortionInformationAvailability',  function(from)
  emlToS4(from))
setAs('bandDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'bandDescription',  function(from)
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
setAs('imageDescription', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'imageDescription',  function(from)
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
setAs('SpatialRasterType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'SpatialRasterType',  function(from)
  emlToS4(from))
setAs('sequenceIdentifier', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'sequenceIdentifier',  function(from)
  emlToS4(from))
setAs('highWavelength', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'highWavelength',  function(from)
  emlToS4(from))
setAs('lowWaveLength', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'lowWaveLength',  function(from)
  emlToS4(from))
setAs('waveLengthUnits', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'waveLengthUnits',  function(from)
  emlToS4(from))
setAs('peakResponse', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'peakResponse',  function(from)
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
setAs('BandType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'BandType',  function(from)
  emlToS4(from))
setAs('CellValueType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'CellValueType',  function(from)
  emlToS4(from))
setAs('ImagingConditionCode', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'ImagingConditionCode',  function(from)
  emlToS4(from))
setAs('rasterOriginType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'rasterOriginType',  function(from)
  emlToS4(from))
setAs('CellGeometryType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'CellGeometryType',  function(from)
  emlToS4(from))
setAs('accuracyReport', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'accuracyReport',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyValue',  function(from)
  emlToS4(from))
setAs('quantitativeAccuracyMethod', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyMethod',  function(from)
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
setAs('quantitativeAccuracyReport', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'quantitativeAccuracyReport',  function(from)
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
setAs('DataQuality', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DataQuality',  function(from)
  emlToS4(from))


#####  inst/xsd/eml-dataset.xsd  ####


setAs('dataset', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataset',  function(from)
  emlToS4(from))
setAs('purpose', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'purpose',  function(from)
  emlToS4(from))
setAs('maintenance', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'maintenance',  function(from)
  emlToS4(from))
setAs('contact', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'contact',  function(from)
  emlToS4(from))

setMethod(c, signature('contact'), function(x, ..., recursive = FALSE)
  new('ListOfcontact', list(x, ...)))
setAs('publisher', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'publisher',  function(from)
  emlToS4(from))
setAs('pubPlace', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'pubPlace',  function(from)
  emlToS4(from))
setAs('methods', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'methods',  function(from)
  emlToS4(from))
setAs('project', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'project',  function(from)
  emlToS4(from))
setAs('dataTable', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataTable',  function(from)
  emlToS4(from))

setMethod(c, signature('dataTable'), function(x, ..., recursive = FALSE)
  new('ListOfdataTable', list(x, ...)))
setAs('spatialRaster', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialRaster',  function(from)
  emlToS4(from))

setMethod(c, signature('spatialRaster'), function(x, ..., recursive = FALSE)
  new('ListOfspatialRaster', list(x, ...)))
setAs('spatialVector', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'spatialVector',  function(from)
  emlToS4(from))

setMethod(c, signature('spatialVector'), function(x, ..., recursive = FALSE)
  new('ListOfspatialVector', list(x, ...)))
setAs('storedProcedure', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'storedProcedure',  function(from)
  emlToS4(from))

setMethod(c, signature('storedProcedure'), function(x, ..., recursive = FALSE)
  new('ListOfstoredProcedure', list(x, ...)))
setAs('view', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'view',  function(from)
  emlToS4(from))

setMethod(c, signature('view'), function(x, ..., recursive = FALSE)
  new('ListOfview', list(x, ...)))
setAs('otherEntity', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'otherEntity',  function(from)
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
setAs('DatasetType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'DatasetType',  function(from)
  emlToS4(from))
setAs('description', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'description',  function(from)
  emlToS4(from))
setAs('maintenanceUpdateFrequency', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'maintenanceUpdateFrequency',  function(from)
  emlToS4(from))
setAs('changeScope', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'changeScope',  function(from)
  emlToS4(from))
setAs('oldValue', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'oldValue',  function(from)
  emlToS4(from))
setAs('changeDate', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'changeDate',  function(from)
  emlToS4(from))
setAs('comment', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'comment',  function(from)
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
setAs('changeHistory', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'changeHistory',  function(from)
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
setAs('MaintenanceType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'MaintenanceType',  function(from)
  emlToS4(from))
setAs('MaintUpFreqType', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'MaintUpFreqType',  function(from)
  emlToS4(from))


#####  inst/xsd/eml.xsd  ####


setAs('access', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'access',  function(from)
  emlToS4(from))
setAs('dataset', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'dataset',  function(from)
  emlToS4(from))
setAs('citation', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'citation',  function(from)
  emlToS4(from))
setAs('software', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'software',  function(from)
  emlToS4(from))
setAs('protocol', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'protocol',  function(from)
  emlToS4(from))
setAs('describes', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'describes',  function(from)
  emlToS4(from))

setMethod(c, signature('describes'), function(x, ..., recursive = FALSE)
  new('ListOfdescribes', list(x, ...)))
setAs('metadata', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'metadata',  function(from)
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
setAs('additionalMetadata', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'additionalMetadata',  function(from)
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
setAs('eml', 'XMLInternalNode',   function(from)
  S4Toeml(from))
setAs('XMLInternalNode', 'eml',  function(from)
  emlToS4(from))
