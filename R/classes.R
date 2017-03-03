setClass('xml_attribute', contains = 'character')
setClass(
  'eml-2.1.1',
  slots = c(
    'schemaLocation' = 'xml_attribute',
    'lang' = 'xml_attribute',
    slot_order = 'character'
  )
)
setClass(
  'ListOfvalue',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'value'))) {
      'not all elements are value objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'references',
  slots = c('character' = 'character', 'system' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ReferencesGroup',
  slots = c('references' = 'references'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ListOftemporalCoverage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'temporalCoverage'))) {
      'not all elements are temporalCoverage objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfgeographicCoverage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'geographicCoverage'))) {
      'not all elements are geographicCoverage objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftaxonomicCoverage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'taxonomicCoverage'))) {
      'not all elements are taxonomicCoverage objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'Coverage',
  slots = c(
    'geographicCoverage' = 'ListOfgeographicCoverage',
    'temporalCoverage' = 'ListOftemporalCoverage',
    'taxonomicCoverage' = 'ListOftaxonomicCoverage',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('constraintDescription', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'ConstraintBaseGroup',
  slots = c(
    'constraintName' = 'character',
    'constraintDescription' = 'constraintDescription'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('GRingType', contains = c('eml-2.1.1', 'character')) ## C
setClass('PrecisionType', contains = c('eml-2.1.1', 'character')) ## C
setClass('NumberType', contains = c('eml-2.1.1', 'character')) ## C
setClass('TopologyLevel', contains = c('eml-2.1.1', 'character')) ## C
setClass('GeometryType', contains = c('eml-2.1.1', 'character')) ## C
setClass('ImagingConditionCode', contains = c('eml-2.1.1', 'character')) ## C
setClass('CellGeometryType', contains = c('eml-2.1.1', 'character')) ## C
setClass('MaintUpFreqType', contains = c('eml-2.1.1', 'character')) ## C

setClass('slot_order', contains = 'character')
setClass(
  'i18nNonEmptyStringType',
  slots = c('value' = 'ListOfvalue', 'lang' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
)
setClass('InlineType', contains = c('list'))
setClass('xs:float', contains = 'numeric')
setClass('xs:string', contains = 'character')
setClass('xs:anyURI', contains = 'character')
setClass('xs:time', contains = 'character')
setClass('xs:decimal', contains = 'numeric')
setClass('xs:int', contains = 'integer')
setClass('xs:unsignedInt', contains = 'integer')
setClass('xs:unsignedLong', contains = 'integer')
setClass('xs:long', contains = 'integer')
setClass('xs:integer', contains = 'integer')
setClass('xs:boolean', contains = 'logical')
setClass('xs:date', contains = 'Date')
setClass('xs:positiveInteger', contains = 'integer')
#####  inst/xsd/eml-text.xsd  ####
setClass(
  'ListOfsection',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'section'))) {
      'not all elements are section objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpara',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'para'))) {
      'not all elements are para objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfitemizedlist',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'itemizedlist'))) {
      'not all elements are itemizedlist objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOforderedlist',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'orderedlist'))) {
      'not all elements are orderedlist objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfemphasis',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'emphasis'))) {
      'not all elements are emphasis objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsubscript',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'subscript'))) {
      'not all elements are subscript objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsuperscript',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'superscript'))) {
      'not all elements are superscript objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfliteralLayout',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'literalLayout'))) {
      'not all elements are literalLayout objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcitetitle',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'citetitle'))) {
      'not all elements are citetitle objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfulink',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'ulink'))) {
      'not all elements are ulink objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOflistitem',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'listitem'))) {
      'not all elements are listitem objects'

    } else {
      TRUE
    }
  }
)
setClass('value', contains = c('eml-2.1.1', 'character')) ## B
setClass('value', contains = c('character')) ## B
setClass('citetitle', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'TextType',
  slots = c(
    'section' = 'ListOfsection',
    'para' = 'ListOfpara',
    'lang' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'emphasis',
  slots = c('value' = 'ListOfvalue', 'lang' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'literalLayout',
  slots = c('value' = 'ListOfvalue'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ulink',
  slots = c('citetitle' = 'ListOfcitetitle', 'url' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('ParagraphType', contains = c('InlineType'))
setClass('SectionType', contains = c('InlineType'))
setClass(
  'listitem',
  slots = c(
    'para' = 'ListOfpara',
    'itemizedlist' = 'ListOfitemizedlist',
    'orderedlist' = 'ListOforderedlist'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ListType',
  slots = c('listitem' = 'ListOflistitem'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'SubSuperScriptType',
  slots = c(
    'value' = 'ListOfvalue',
    'subscript' = 'ListOfsubscript',
    'superscript' = 'ListOfsuperscript',
    'lang' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'i18nString',
  slots = c('lang' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('text', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('section', contains = c('eml-2.1.1', 'SectionType')) ## D
setClass('para', contains = c('eml-2.1.1', 'ParagraphType')) ## D
setClass('itemizedlist', contains = c('eml-2.1.1', 'ListType')) ## D
setClass('orderedlist', contains = c('eml-2.1.1', 'ListType')) ## D
setClass('subscript', contains = c('eml-2.1.1', 'SubSuperScriptType')) ## D
setClass('superscript', contains = c('eml-2.1.1', 'SubSuperScriptType')) ## D
#####  inst/xsd/eml-documentation.xsd  ####
setClass('moduleName', contains = c('character')) ## B
setClass('recommendedUsage', contains = c('character')) ## B
setClass('standAlone', contains = c('character')) ## B
setClass('tooltip', contains = c('character')) ## B
setClass('summary', contains = c('character')) ## B
setClass('lineage', contains = c('character')) ## B
setClass('module', contains = c('character')) ## B
setClass(
  'moduleDocs',
  slots = c(
    'moduleName' = 'character',
    'moduleDescription' = 'TextType',
    'recommendedUsage' = 'character',
    'standAlone' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('moduleDescription', contains = c('TextType')) ## D
setClass('description', contains = c('TextType')) ## D
setClass('example', contains = c('TextType')) ## D
#####  inst/xsd/eml-unitTypeDefinitions.xsd  ####
setClass('otherUnitType', contains = c('eml-2.1.1', 'character')) ## B
setClass('angleUnitType', contains = c('eml-2.1.1', 'character')) ## B
setClass('StandardUnitDictionary',
         contains = c('eml-2.1.1', 'character')) ## C
setClass('LengthUnitType', contains = c('eml-2.1.1', 'character')) ## C
setClass('MassUnitType', contains = c('eml-2.1.1', 'character')) ## C
#####  inst/xsd/eml-party.xsd  ####
setClass(
  'ListOfindividualName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'individualName'))) {
      'not all elements are individualName objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOforganizationName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'organizationName'))) {
      'not all elements are organizationName objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpositionName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'positionName'))) {
      'not all elements are positionName objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfaddress',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'address'))) {
      'not all elements are address objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfphone',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'phone'))) {
      'not all elements are phone objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfelectronicMailAddress',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'electronicMailAddress'))) {
      'not all elements are electronicMailAddress objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfonlineUrl',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'onlineUrl'))) {
      'not all elements are onlineUrl objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfuserId',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'userId'))) {
      'not all elements are userId objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsalutation',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'salutation'))) {
      'not all elements are salutation objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfgivenName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'givenName'))) {
      'not all elements are givenName objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdeliveryPoint',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'deliveryPoint'))) {
      'not all elements are deliveryPoint objects'

    } else {
      TRUE
    }
  }
)
setClass('onlineUrl', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'phone',
  slots = c('character' = 'character', 'phonetype' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'userId',
  slots = c('character' = 'character', 'directory' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ResponsibleParty',
  slots = c(
    'individualName' = 'ListOfindividualName',
    'organizationName' = 'ListOforganizationName',
    'positionName' = 'ListOfpositionName',
    'address' = 'ListOfaddress',
    'phone' = 'ListOfphone',
    'electronicMailAddress' = 'ListOfelectronicMailAddress',
    'onlineUrl' = 'ListOfonlineUrl',
    'userId' = 'ListOfuserId',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Person',
  slots = c(
    'salutation' = 'ListOfsalutation',
    'givenName' = 'ListOfgivenName',
    'surName' = 'i18nNonEmptyStringType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Address',
  slots = c(
    'deliveryPoint' = 'ListOfdeliveryPoint',
    'city' = 'i18nNonEmptyStringType',
    'administrativeArea' = 'i18nNonEmptyStringType',
    'postalCode' = 'i18nNonEmptyStringType',
    'country' = 'i18nNonEmptyStringType',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('RoleType', contains = c('eml-2.1.1', 'character')) ## C
setClass('individualName', contains = c('eml-2.1.1', 'Person')) ## D
setClass('organizationName',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('positionName',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('address', contains = c('eml-2.1.1', 'Address')) ## D
setClass('electronicMailAddress',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('salutation',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('givenName',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('surName', contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('deliveryPoint',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('city', contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('administrativeArea',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('postalCode',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('country', contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('party', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
#####  inst/xsd/eml-resource.xsd  ####
setClass(
  'ListOfalternateIdentifier',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'alternateIdentifier'))) {
      'not all elements are alternateIdentifier objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftitle',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'title'))) {
      'not all elements are title objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcreator',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'creator'))) {
      'not all elements are creator objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfmetadataProvider',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'metadataProvider'))) {
      'not all elements are metadataProvider objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfassociatedParty',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'associatedParty'))) {
      'not all elements are associatedParty objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfkeyword',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'keyword'))) {
      'not all elements are keyword objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfkeywordSet',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'keywordSet'))) {
      'not all elements are keywordSet objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfadditionalInfo',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'additionalInfo'))) {
      'not all elements are additionalInfo objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdistribution',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'distribution'))) {
      'not all elements are distribution objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfparameterDefinition',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'parameterDefinition'))) {
      'not all elements are parameterDefinition objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfmediumFormat',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'mediumFormat'))) {
      'not all elements are mediumFormat objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfparameter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'parameter'))) {
      'not all elements are parameter objects'

    } else {
      TRUE
    }
  }
)
setClass('shortName', contains = c('eml-2.1.1', 'character')) ## B
setClass('series', contains = c('eml-2.1.1', 'character')) ## B
setClass('keywordThesaurus', contains = c('eml-2.1.1', 'character')) ## B
setClass('yearDate', contains = c('eml-2.1.1', 'character')) ## B
setClass('eml:name', contains = c('eml-2.1.1', 'character')) ## B
setClass('definition', contains = c('eml-2.1.1', 'character')) ## B
setClass('defaultValue', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumName', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumDensity', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumDensityUnits', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumVolume', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumFormat', contains = c('eml-2.1.1', 'character')) ## B
setClass('mediumNote', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'alternateIdentifier',
  slots = c('character' = 'character', 'system' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'associatedParty',
  slots = c(
    'individualName' = 'ListOfindividualName',
    'organizationName' = 'ListOforganizationName',
    'positionName' = 'ListOfpositionName',
    'address' = 'ListOfaddress',
    'phone' = 'ListOfphone',
    'electronicMailAddress' = 'ListOfelectronicMailAddress',
    'onlineUrl' = 'ListOfonlineUrl',
    'userId' = 'ListOfuserId',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute',
    'role' = 'RoleType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'keyword',
  slots = c('keywordType' = 'xml_attribute'),
  contains = c('i18nNonEmptyStringType', 'eml-2.1.1')
)
setClass(
  'keywordSet',
  slots = c('keyword' = 'ListOfkeyword', 'keywordThesaurus' = 'character'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ResourceGroup',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'shortName' = 'character',
    'title' = 'ListOftitle',
    'creator' = 'ListOfcreator',
    'metadataProvider' = 'ListOfmetadataProvider',
    'associatedParty' = 'ListOfassociatedParty',
    'pubDate' = 'yearDate',
    'language' = 'character',
    'series' = 'character',
    'abstract' = 'TextType',
    'keywordSet' = 'ListOfkeywordSet',
    'additionalInfo' = 'ListOfadditionalInfo',
    'intellectualRights' = 'TextType',
    'distribution' = 'ListOfdistribution',
    'coverage' = 'Coverage'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'UrlType',
  slots = c('function' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'schemeName',
  slots = c('character' = 'character', 'system' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ConnectionDefinitionType',
  slots = c(
    'schemeName' = 'schemeName',
    'description' = 'TextType',
    'parameterDefinition' = 'ListOfparameterDefinition',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ConnectionType',
  slots = c(
    'connectionDefinition' = 'ConnectionDefinitionType',
    'parameter' = 'ListOfparameter',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'OfflineType',
  slots = c(
    'mediumName' = 'character',
    'mediumDensity' = 'character',
    'mediumDensityUnits' = 'character',
    'mediumVolume' = 'character',
    'mediumFormat' = 'ListOfmediumFormat',
    'mediumNote' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'OnlineType',
  slots = c(
    'onlineDescription' = 'i18nNonEmptyStringType',
    'url' = 'UrlType',
    'connection' = 'ConnectionType',
    'connectionDefinition' = 'ConnectionDefinitionType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'DistributionType',
  slots = c(
    'online' = 'OnlineType',
    'offline' = 'OfflineType',
    'inline' = 'InlineType',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'parameterDefinition',
  slots = c(
    'name' = 'character',
    'definition' = 'character',
    'defaultValue' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'value',
  slots = c('character' = 'character', 'lang' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'i18nNonEmptyStringType',
  slots = c('value' = 'ListOfvalue', 'lang' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('KeyTypeCode', contains = c('eml-2.1.1', 'character')) ## C
setClass('IDType', contains = c('eml-2.1.1', 'character')) ## C
setClass('SystemType', contains = c('eml-2.1.1', 'character')) ## C
setClass('ScopeType', contains = c('eml-2.1.1', 'character')) ## C
setClass('FunctionType', contains = c('eml-2.1.1', 'character')) ## C
setClass('NonEmptyStringType', contains = c('eml-2.1.1', 'character')) ## C
setClass('title', contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('creator', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('metadataProvider',
         contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('role', contains = c('eml-2.1.1', 'RoleType')) ## D
setClass('pubDate', contains = c('eml-2.1.1', 'yearDate')) ## D
setClass(
  'eml:language',
  slots = c(
    'LanguageValue' = 'character',
    'LanguageCodeStandard' = 'character'
  ),
  contains = c('eml-2.1.1', 'character',  'i18nNonEmptyStringType')
)
setClass('abstract', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('additionalInfo', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('intellectualRights', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('distribution', contains = c('eml-2.1.1', 'DistributionType')) ## D
setClass('offline', contains = c('eml-2.1.1', 'OfflineType')) ## D
setClass('description', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('onlineDescription',
         contains = c('eml-2.1.1', 'i18nNonEmptyStringType')) ## D
setClass('url', contains = c('eml-2.1.1', 'UrlType')) ## D
setClass('connection', contains = c('eml-2.1.1', 'ConnectionType')) ## D
setClass('connectionDefinition',
         contains = c('eml-2.1.1', 'ConnectionDefinitionType')) ## D
#####  inst/xsd/eml-spatialReference.xsd  ####
setClass(
  'ListOfaltitudeResolution',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'altitudeResolution'))) {
      'not all elements are altitudeResolution objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdepthResolution',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'depthResolution'))) {
      'not all elements are depthResolution objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfhorizCoordSysDef',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'horizCoordSysDef'))) {
      'not all elements are horizCoordSysDef objects'

    } else {
      TRUE
    }
  }
)
setClass('horizCoordSysName', contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeDatumName', contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeResolution', contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeDistanceUnits', contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeEncodingMethod',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('depthDatumName', contains = c('eml-2.1.1', 'character')) ## B
setClass('depthResolution', contains = c('eml-2.1.1', 'character')) ## B
setClass('depthDistanceUnits', contains = c('eml-2.1.1', 'character')) ## B
setClass('depthEncodingMethod', contains = c('eml-2.1.1', 'character')) ## B
setClass('lengthUnits', contains = c('eml-2.1.1', 'character')) ## B
setClass('angleUnits', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'altitudeSysDef',
  slots = c(
    'altitudeDatumName' = 'character',
    'altitudeResolution' = 'ListOfaltitudeResolution',
    'altitudeDistanceUnits' = 'character',
    'altitudeEncodingMethod' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'depthSysDef',
  slots = c(
    'depthDatumName' = 'character',
    'depthResolution' = 'ListOfdepthResolution',
    'depthDistanceUnits' = 'character',
    'depthEncodingMethod' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'vertCoordSys',
  slots = c('altitudeSysDef' = 'altitudeSysDef', 'depthSysDef' = 'depthSysDef'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'datum',
  slots = c('name' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'spheroid',
  slots = c(
    'name' = 'xml_attribute',
    'semiAxisMajor' = 'xml_attribute',
    'denomFlatRatio' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'primeMeridian',
  slots = c('name' = 'xml_attribute', 'longitude' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'unit',
  slots = c('name' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'geogCoordSysType',
  slots = c(
    'datum' = 'datum',
    'spheroid' = 'spheroid',
    'primeMeridian' = 'primeMeridian',
    'unit' = 'unit',
    'name' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'projection',
  slots = c(
    'parameter' = 'ListOfparameter',
    'unit' = 'unit',
    'name' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'projCoordSys',
  slots = c('geogCoordSys' = 'geogCoordSysType', 'projection' = 'projection'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'horizCoordSysType',
  slots = c(
    'geogCoordSys' = 'geogCoordSysType',
    'projCoordSys' = 'projCoordSys',
    'name' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'projectionList',
  slots = c('horizCoordSysDef' = 'ListOfhorizCoordSysDef'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('horizCoordSysDef',
         contains = c('eml-2.1.1', 'horizCoordSysType')) ## D
setClass('geogCoordSys', contains = c('eml-2.1.1', 'geogCoordSysType')) ## D
setClass(
  'SpatialReferenceType',
  slots = c(
    'horizCoordSysName' = 'horizCoordSysName',
    'horizCoordSysDef' = 'horizCoordSysType',
    'vertCoordSys' = 'vertCoordSys',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('spatialReference', contains = c('SpatialReferenceType')) ## D
#####  inst/xsd/eml-access.xsd  ####
setClass(
  'ListOfallow',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'allow'))) {
      'not all elements are allow objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdeny',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'deny'))) {
      'not all elements are deny objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfprincipal',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'principal'))) {
      'not all elements are principal objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpermission',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'permission'))) {
      'not all elements are permission objects'

    } else {
      TRUE
    }
  }
)
setClass('principal', contains = c('eml-2.1.1', 'character')) ## B
setClass('permission', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'AccessType',
  slots = c(
    'allow' = 'ListOfallow',
    'deny' = 'ListOfdeny',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute',
    'order' = 'xml_attribute',
    'authSystem' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'AccessRule',
  slots = c('principal' = 'ListOfprincipal', 'permission' = 'ListOfpermission'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('access', contains = c('eml-2.1.1', 'AccessType')) ## D
setClass('allow', contains = c('eml-2.1.1', 'AccessRule')) ## D
setClass('deny', contains = c('eml-2.1.1', 'AccessRule')) ## D
#####  inst/xsd/eml-constraint.xsd  ####
setClass(
  'ListOfattributeReference',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'attributeReference'))) {
      'not all elements are attributeReference objects'

    } else {
      TRUE
    }
  }
)
setClass('attributeReference', contains = c('eml-2.1.1', 'character')) ## B
setClass('checkCondition', contains = c('eml-2.1.1', 'character')) ## B
setClass('constraintName', contains = c('eml-2.1.1', 'character')) ## B
setClass('entityReference', contains = c('eml-2.1.1', 'character')) ## B
setClass('relationshipType', contains = c('eml-2.1.1', 'character')) ## B
setClass('parentOccurences', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'key',
  slots = c('attributeReference' = 'ListOfattributeReference'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('CardinalityChildOccurancesType',
         contains = c('eml-2.1.1', 'character')) ## C
setClass(
  'primaryKey',
  slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'key'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'uniqueKey',
  slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'key'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'checkConstraint',
  slots = c(
    'ConstraintBaseGroup' = 'ConstraintBaseGroup',
    'checkCondition' = 'character',
    'language' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'referencedKey',
  slots = c('attributeReference' = 'ListOfattributeReference'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'notNullConstraint',
  slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'key'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'cardinality',
  slots = c('parentOccurences' = 'parentOccurences', 'childOccurences' = 'CardinalityChildOccurancesType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ForeignKeyGroup',
  slots = c(
    'ConstraintBaseGroup' = 'ConstraintBaseGroup',
    'key' = 'key',
    'entityReference' = 'character',
    'relationshipType' = 'relationshipType',
    'cardinality' = 'cardinality'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'joinCondition',
  slots = c('ForeignKeyGroup' = 'ForeignKeyGroup', 'referencedKey' = 'referencedKey'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'foreignKey',
  slots = c('ForeignKeyGroup' = 'ForeignKeyGroup'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ConstraintType',
  slots = c(
    'primaryKey' = 'primaryKey',
    'uniqueKey' = 'uniqueKey',
    'checkConstraint' = 'checkConstraint',
    'foreignKey' = 'foreignKey',
    'joinCondition' = 'joinCondition',
    'notNullConstraint' = 'notNullConstraint',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('childOccurences',
         contains = c('eml-2.1.1', 'CardinalityChildOccurancesType')) ## D
#####  inst/xsd/eml-literature.xsd  ####
setClass(
  'ListOfcontact',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'contact'))) {
      'not all elements are contact objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfeditor',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'editor'))) {
      'not all elements are editor objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfinstitution',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'institution'))) {
      'not all elements are institution objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfrecipient',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'recipient'))) {
      'not all elements are recipient objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpublicationPlace',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'publicationPlace'))) {
      'not all elements are publicationPlace objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfperformer',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'performer'))) {
      'not all elements are performer objects'

    } else {
      TRUE
    }
  }
)
setClass('journal', contains = c('eml-2.1.1', 'character')) ## B
setClass('volume', contains = c('eml-2.1.1', 'character')) ## B
setClass('issue', contains = c('eml-2.1.1', 'character')) ## B
setClass('pageRange', contains = c('eml-2.1.1', 'character')) ## B
setClass('publicationPlace', contains = c('eml-2.1.1', 'character')) ## B
setClass('edition', contains = c('eml-2.1.1', 'character')) ## B
setClass('numberOfVolumes', contains = c('eml-2.1.1', 'character')) ## B
setClass('totalPages', contains = c('eml-2.1.1', 'character')) ## B
setClass('totalFigures', contains = c('eml-2.1.1', 'character')) ## B
setClass('totalTables', contains = c('eml-2.1.1', 'character')) ## B
setClass('chapterNumber', contains = c('eml-2.1.1', 'character')) ## B
setClass('bookTitle', contains = c('eml-2.1.1', 'character')) ## B
setClass('conferenceName', contains = c('eml-2.1.1', 'character')) ## B
setClass('conferenceDate', contains = c('eml-2.1.1', 'character')) ## B
setClass('reportNumber', contains = c('eml-2.1.1', 'character')) ## B
setClass('communicationType', contains = c('eml-2.1.1', 'character')) ## B
setClass('scale', contains = c('eml-2.1.1', 'character')) ## B
setClass('referenceType', contains = c('eml-2.1.1', 'character')) ## B
setClass('originalPublication', contains = c('eml-2.1.1', 'character')) ## B
setClass('reprintEdition', contains = c('eml-2.1.1', 'character')) ## B
setClass('reviewedItem', contains = c('eml-2.1.1', 'character')) ## B
setClass('degree', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'Article',
  slots = c(
    'journal' = 'character',
    'volume' = 'character',
    'issue' = 'character',
    'pageRange' = 'character',
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'character',
    'ISSN' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Book',
  slots = c(
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'character',
    'edition' = 'character',
    'volume' = 'character',
    'numberOfVolumes' = 'character',
    'totalPages' = 'character',
    'totalFigures' = 'character',
    'totalTables' = 'character',
    'ISBN' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Chapter',
  slots = c(
    'chapterNumber' = 'character',
    'editor' = 'ListOfeditor',
    'bookTitle' = 'character',
    'pageRange' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ConferenceProceedings',
  slots = c(
    'conferenceName' = 'character',
    'conferenceDate' = 'character',
    'conferenceLocation' = 'Address'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Manuscript',
  slots = c('institution' = 'ListOfinstitution', 'totalPages' = 'character'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Report',
  slots = c(
    'reportNumber' = 'character',
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'character',
    'totalPages' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'PersonalCommunication',
  slots = c(
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'character',
    'communicationType' = 'character',
    'recipient' = 'ListOfrecipient'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Map',
  slots = c(
    'publisher' = 'ResponsibleParty',
    'edition' = 'character',
    'geographicCoverage' = 'ListOfgeographicCoverage',
    'scale' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'AudioVisual',
  slots = c(
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'ListOfpublicationPlace',
    'performer' = 'ListOfperformer',
    'ISBN' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Generic',
  slots = c(
    'publisher' = 'ResponsibleParty',
    'publicationPlace' = 'character',
    'referenceType' = 'referenceType',
    'volume' = 'character',
    'numberOfVolumes' = 'character',
    'totalPages' = 'character',
    'totalFigures' = 'character',
    'totalTables' = 'character',
    'edition' = 'character',
    'originalPublication' = 'character',
    'reprintEdition' = 'character',
    'reviewedItem' = 'character',
    'ISBN' = 'character',
    'ISSN' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Thesis',
  slots = c(
    'degree' = 'character',
    'institution' = 'ResponsibleParty',
    'totalPages' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Presentation',
  slots = c(
    'conferenceName' = 'character',
    'conferenceDate' = 'character',
    'conferenceLocation' = 'Address'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('ISSN', contains = c('eml-2.1.1', 'character')) ## C
setClass('ISBN', contains = c('eml-2.1.1', 'character')) ## C
setClass(
  'CitationType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'shortName' = 'character',
    'title' = 'ListOftitle',
    'creator' = 'ListOfcreator',
    'metadataProvider' = 'ListOfmetadataProvider',
    'associatedParty' = 'ListOfassociatedParty',
    'pubDate' = 'yearDate',
    'language' = 'character',
    'series' = 'character',
    'abstract' = 'TextType',
    'keywordSet' = 'ListOfkeywordSet',
    'additionalInfo' = 'ListOfadditionalInfo',
    'intellectualRights' = 'TextType',
    'distribution' = 'ListOfdistribution',
    'coverage' = 'Coverage',
    'contact' = 'ListOfcontact',
    'article' = 'Article',
    'book' = 'Book',
    'chapter' = 'Chapter',
    'editedBook' = 'Book',
    'manuscript' = 'Manuscript',
    'report' = 'Report',
    'thesis' = 'Thesis',
    'conferenceProceedings' = 'ConferenceProceedings',
    'personalCommunication' = 'PersonalCommunication',
    'map' = 'Map',
    'generic' = 'Generic',
    'audioVisual' = 'AudioVisual',
    'presentation' = 'Presentation',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('citation', contains = c('eml-2.1.1', 'CitationType')) ## D
setClass('contact', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('article', contains = c('eml-2.1.1', 'Article')) ## D
setClass('book', contains = c('eml-2.1.1', 'Book')) ## D
setClass('chapter', contains = c('eml-2.1.1', 'Chapter')) ## D
setClass('editedBook', contains = c('eml-2.1.1', 'Book')) ## D
setClass('manuscript', contains = c('eml-2.1.1', 'Manuscript')) ## D
setClass('report', contains = c('eml-2.1.1', 'Report')) ## D
setClass('thesis', contains = c('eml-2.1.1', 'Thesis')) ## D
setClass('conferenceProceedings',
         contains = c('eml-2.1.1', 'ConferenceProceedings')) ## D
setClass('personalCommunication',
         contains = c('eml-2.1.1', 'PersonalCommunication')) ## D
setClass('map', contains = c('eml-2.1.1', 'Map')) ## D
setClass('generic', contains = c('eml-2.1.1', 'Generic')) ## D
setClass('audioVisual', contains = c('eml-2.1.1', 'AudioVisual')) ## D
setClass('presentation', contains = c('eml-2.1.1', 'Presentation')) ## D
setClass('publisher', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('editor', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('conferenceLocation', contains = c('eml-2.1.1', 'Address')) ## D
setClass('institution', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('recipient', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('performer', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
#####  inst/xsd/eml-coverage.xsd  ####
setClass(
  'ListOfsingleDateTime',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'singleDateTime'))) {
      'not all elements are singleDateTime objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftimeScaleCitation',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'timeScaleCitation'))) {
      'not all elements are timeScaleCitation objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfgRingPoint',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'gRingPoint'))) {
      'not all elements are gRingPoint objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdatasetGPolygonExclusionGRing',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'datasetGPolygonExclusionGRing'))) {
      'not all elements are datasetGPolygonExclusionGRing objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdatasetGPolygon',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'datasetGPolygon'))) {
      'not all elements are datasetGPolygon objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfclassificationSystem',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'classificationSystem'))) {
      'not all elements are classificationSystem objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfidentificationReference',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'identificationReference'))) {
      'not all elements are identificationReference objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfidentifierName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'identifierName'))) {
      'not all elements are identifierName objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOforiginator',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'originator'))) {
      'not all elements are originator objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfvouchers',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'vouchers'))) {
      'not all elements are vouchers objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftaxonomicClassification',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'taxonomicClassification'))) {
      'not all elements are taxonomicClassification objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcommonName',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'commonName'))) {
      'not all elements are commonName objects'

    } else {
      TRUE
    }
  }
)
setClass('time', contains = c('eml-2.1.1', 'character')) ## B
setClass('timeScaleName', contains = c('eml-2.1.1', 'character')) ## B
setClass('timeScaleAgeEstimate', contains = c('eml-2.1.1', 'character')) ## B
setClass('timeScaleAgeUncertainty',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('timeScaleAgeExplanation',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('geographicDescription', contains = c('eml-2.1.1', 'character')) ## B
setClass('westBoundingCoordinate',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('eastBoundingCoordinate',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('northBoundingCoordinate',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('southBoundingCoordinate',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeMinimum', contains = c('eml-2.1.1', 'character')) ## B
setClass('altitudeMaximum', contains = c('eml-2.1.1', 'character')) ## B
setClass('gRingLatitude', contains = c('eml-2.1.1', 'character')) ## B
setClass('gRingLongitude', contains = c('eml-2.1.1', 'character')) ## B
setClass('classificationSystemModifications',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('taxonomicProcedures', contains = c('eml-2.1.1', 'character')) ## B
setClass('taxonomicCompleteness', contains = c('eml-2.1.1', 'character')) ## B
setClass('specimen', contains = c('eml-2.1.1', 'character')) ## B
setClass('generalTaxonomicCoverage',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('taxonRankName', contains = c('eml-2.1.1', 'character')) ## B
setClass('taxonRankValue', contains = c('eml-2.1.1', 'character')) ## B
setClass('commonName', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'alternativeTimeScale',
  slots = c(
    'timeScaleName' = 'character',
    'timeScaleAgeEstimate' = 'character',
    'timeScaleAgeUncertainty' = 'character',
    'timeScaleAgeExplanation' = 'character',
    'timeScaleCitation' = 'ListOftimeScaleCitation'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'SingleDateTimeType',
  slots = c(
    'calendarDate' = 'yearDate',
    'time' = 'character',
    'alternativeTimeScale' = 'alternativeTimeScale'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'rangeOfDates',
  slots = c('beginDate' = 'SingleDateTimeType', 'endDate' = 'SingleDateTimeType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'TemporalCoverage',
  slots = c(
    'singleDateTime' = 'ListOfsingleDateTime',
    'rangeOfDates' = 'rangeOfDates',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'boundingAltitudes',
  slots = c(
    'altitudeMinimum' = 'character',
    'altitudeMaximum' = 'character',
    'altitudeUnits' = 'LengthUnitType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'boundingCoordinates',
  slots = c(
    'westBoundingCoordinate' = 'westBoundingCoordinate',
    'eastBoundingCoordinate' = 'eastBoundingCoordinate',
    'northBoundingCoordinate' = 'northBoundingCoordinate',
    'southBoundingCoordinate' = 'southBoundingCoordinate',
    'boundingAltitudes' = 'boundingAltitudes'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'datasetGPolygonOuterGRing',
  slots = c('gRingPoint' = 'ListOfgRingPoint', 'gRing' = 'GRingType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'datasetGPolygonExclusionGRing',
  slots = c('gRingPoint' = 'ListOfgRingPoint', 'gRing' = 'GRingType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'datasetGPolygon',
  slots = c(
    'datasetGPolygonOuterGRing' = 'datasetGPolygonOuterGRing',
    'datasetGPolygonExclusionGRing' = 'ListOfdatasetGPolygonExclusionGRing'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'GeographicCoverage',
  slots = c(
    'geographicDescription' = 'character',
    'boundingCoordinates' = 'boundingCoordinates',
    'datasetGPolygon' = 'ListOfdatasetGPolygon',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'GRingPointType',
  slots = c('gRingLatitude' = 'gRingLatitude', 'gRingLongitude' = 'gRingLongitude'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'classificationSystem',
  slots = c(
    'classificationSystemCitation' = 'CitationType',
    'classificationSystemModifications' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'repository',
  slots = c('originator' = 'ListOforiginator'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'vouchers',
  slots = c('specimen' = 'character', 'repository' = 'repository'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'taxonomicSystem',
  slots = c(
    'classificationSystem' = 'ListOfclassificationSystem',
    'identificationReference' = 'ListOfidentificationReference',
    'identifierName' = 'ListOfidentifierName',
    'taxonomicProcedures' = 'character',
    'taxonomicCompleteness' = 'character',
    'vouchers' = 'ListOfvouchers'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'TaxonomicCoverage',
  slots = c(
    'taxonomicSystem' = 'taxonomicSystem',
    'generalTaxonomicCoverage' = 'character',
    'taxonomicClassification' = 'ListOftaxonomicClassification',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'TaxonomicClassificationType',
  slots = c(
    'taxonRankName' = 'character',
    'taxonRankValue' = 'character',
    'commonName' = 'ListOfcommonName',
    'taxonomicClassification' = 'ListOftaxonomicClassification'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('singleDateTime',
         contains = c('eml-2.1.1', 'SingleDateTimeType')) ## D
setClass('beginDate', contains = c('eml-2.1.1', 'SingleDateTimeType')) ## D
setClass('endDate', contains = c('eml-2.1.1', 'SingleDateTimeType')) ## D
setClass('calendarDate', contains = c('eml-2.1.1', 'yearDate')) ## D
setClass('timeScaleCitation', contains = c('eml-2.1.1', 'CitationType')) ## D
setClass('altitudeUnits', contains = c('eml-2.1.1', 'LengthUnitType')) ## D
setClass('gRingPoint', contains = c('eml-2.1.1', 'GRingPointType')) ## D
setClass('gRing', contains = c('eml-2.1.1', 'GRingType')) ## D
setClass('classificationSystemCitation',
         contains = c('eml-2.1.1', 'CitationType')) ## D
setClass('identificationReference',
         contains = c('eml-2.1.1', 'CitationType')) ## D
setClass('identifierName', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('originator', contains = c('eml-2.1.1', 'ResponsibleParty')) ## D
setClass('taxonomicClassification',
         contains = c('eml-2.1.1', 'TaxonomicClassificationType')) ## D
#####  inst/xsd/eml-physical.xsd  ####
setClass(
  'ListOfauthentication',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'authentication'))) {
      'not all elements are authentication objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcompressionMethod',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'compressionMethod'))) {
      'not all elements are compressionMethod objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfencodingMethod',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'encodingMethod'))) {
      'not all elements are encodingMethod objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfrecordDelimiter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'recordDelimiter'))) {
      'not all elements are recordDelimiter objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfphysicalLineDelimiter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'physicalLineDelimiter'))) {
      'not all elements are physicalLineDelimiter objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOffieldDelimiter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'fieldDelimiter'))) {
      'not all elements are fieldDelimiter objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfquoteCharacter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'quoteCharacter'))) {
      'not all elements are quoteCharacter objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfliteralCharacter',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'literalCharacter'))) {
      'not all elements are literalCharacter objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftextFixed',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'textFixed'))) {
      'not all elements are textFixed objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftextDelimited',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'textDelimited'))) {
      'not all elements are textDelimited objects'

    } else {
      TRUE
    }
  }
)
setClass('objectName', contains = c('eml-2.1.1', 'character')) ## B
setClass('compressionMethod', contains = c('eml-2.1.1', 'character')) ## B
setClass('encodingMethod', contains = c('eml-2.1.1', 'character')) ## B
setClass('characterEncoding', contains = c('eml-2.1.1', 'character')) ## B
setClass('numHeaderLines', contains = c('eml-2.1.1', 'character')) ## B
setClass('numFooterLines', contains = c('eml-2.1.1', 'character')) ## B
setClass('recordDelimiter', contains = c('eml-2.1.1', 'character')) ## B
setClass('physicalLineDelimiter', contains = c('eml-2.1.1', 'character')) ## B
setClass('numPhysicalLinesPerRecord',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('maxRecordLength', contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeOrientation', contains = c('eml-2.1.1', 'character')) ## B
setClass('fieldDelimiter', contains = c('eml-2.1.1', 'character')) ## B
setClass('collapseDelimiters', contains = c('eml-2.1.1', 'character')) ## B
setClass('quoteCharacter', contains = c('eml-2.1.1', 'character')) ## B
setClass('literalCharacter', contains = c('eml-2.1.1', 'character')) ## B
setClass('fieldWidth', contains = c('eml-2.1.1', 'character')) ## B
setClass('lineNumber', contains = c('eml-2.1.1', 'character')) ## B
setClass('fieldStartColumn', contains = c('eml-2.1.1', 'character')) ## B
setClass('formatName', contains = c('eml-2.1.1', 'character')) ## B
setClass('formatVersion', contains = c('eml-2.1.1', 'character')) ## B
setClass('rowColumnOrientation', contains = c('eml-2.1.1', 'character')) ## B
setClass('nbands', contains = c('eml-2.1.1', 'character')) ## B
setClass('layout', contains = c('eml-2.1.1', 'character')) ## B
setClass('nbits', contains = c('eml-2.1.1', 'character')) ## B
setClass('byteorder', contains = c('eml-2.1.1', 'character')) ## B
setClass('skipbytes', contains = c('eml-2.1.1', 'character')) ## B
setClass('bandrowbytes', contains = c('eml-2.1.1', 'character')) ## B
setClass('totalrowbytes', contains = c('eml-2.1.1', 'character')) ## B
setClass('bandgapbytes', contains = c('eml-2.1.1', 'character')) ## B
setClass('onlineDescription', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'size',
  slots = c('character' = 'character', 'unit' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
)
setClass(
  'authentication',
  slots = c('character' = 'character', 'method' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'simpleDelimited',
  slots = c(
    'fieldDelimiter' = 'ListOffieldDelimiter',
    'collapseDelimiters' = 'collapseDelimiters',
    'quoteCharacter' = 'ListOfquoteCharacter',
    'literalCharacter' = 'ListOfliteralCharacter'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'textFixed',
  slots = c(
    'fieldWidth' = 'character',
    'lineNumber' = 'character',
    'fieldStartColumn' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'textDelimited',
  slots = c(
    'fieldDelimiter' = 'character',
    'collapseDelimiters' = 'collapseDelimiters',
    'lineNumber' = 'character',
    'quoteCharacter' = 'ListOfquoteCharacter',
    'literalCharacter' = 'ListOfliteralCharacter'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'eml:complex',
  slots = c('textFixed' = 'ListOftextFixed', 'textDelimited' = 'ListOftextDelimited'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'textFormat',
  slots = c(
    'numHeaderLines' = 'character',
    'numFooterLines' = 'character',
    'recordDelimiter' = 'ListOfrecordDelimiter',
    'physicalLineDelimiter' = 'ListOfphysicalLineDelimiter',
    'numPhysicalLinesPerRecord' = 'character',
    'maxRecordLength' = 'character',
    'attributeOrientation' = 'attributeOrientation',
    'simpleDelimited' = 'simpleDelimited',
    'eml:complex' = 'eml:complex'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'externallyDefinedFormat',
  slots = c(
    'formatName' = 'character',
    'formatVersion' = 'character',
    'citation' = 'CitationType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'multiBand',
  slots = c('nbands' = 'character', 'layout' = 'character'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'binaryRasterFormat',
  slots = c(
    'rowColumnOrientation' = 'rowColumnOrientation',
    'multiBand' = 'multiBand',
    'nbits' = 'character',
    'byteorder' = 'character',
    'skipbytes' = 'character',
    'bandrowbytes' = 'character',
    'totalrowbytes' = 'character',
    'bandgapbytes' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'dataFormat',
  slots = c(
    'textFormat' = 'textFormat',
    'externallyDefinedFormat' = 'externallyDefinedFormat',
    'binaryRasterFormat' = 'binaryRasterFormat'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'PhysicalType',
  slots = c(
    'objectName' = 'character',
    'size' = 'size',
    'authentication' = 'ListOfauthentication',
    'compressionMethod' = 'ListOfcompressionMethod',
    'encodingMethod' = 'ListOfencodingMethod',
    'characterEncoding' = 'character',
    'dataFormat' = 'dataFormat',
    'distribution' = 'ListOfdistribution',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'PhysicalOnlineType',
  slots = c(
    'onlineDescription' = 'i18nNonEmptyStringType',
    'url' = 'UrlType',
    'connection' = 'ConnectionType',
    'connectionDefinition' = 'ConnectionDefinitionType'
  ),
  contains = c('eml-2.1.1', 'character')
)
setClass(
  'PhysicalDistributionType',
  slots = c(
    'online' = 'PhysicalOnlineType',
    'offline' = 'OfflineType',
    'inline' = 'InlineType',
    'access' = 'AccessType',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('physical', contains = c('eml-2.1.1', 'PhysicalType')) ## D
setClass('distribution',
         contains = c('eml-2.1.1', 'PhysicalDistributionType')) ## D
#####  inst/xsd/eml-project.xsd  ####
setClass(
  'ListOfrole',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'role'))) {
      'not all elements are role objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpersonnel',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'personnel'))) {
      'not all elements are personnel objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdescriptorValue',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'descriptorValue'))) {
      'not all elements are descriptorValue objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcitation',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'citation'))) {
      'not all elements are citation objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdescriptor',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'descriptor'))) {
      'not all elements are descriptor objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcoverage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'coverage'))) {
      'not all elements are coverage objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfdescription',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'description'))) {
      'not all elements are description objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfrelatedProject',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'relatedProject'))) {
      'not all elements are relatedProject objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'personnel',
  slots = c(
    'individualName' = 'ListOfindividualName',
    'organizationName' = 'ListOforganizationName',
    'positionName' = 'ListOfpositionName',
    'address' = 'ListOfaddress',
    'phone' = 'ListOfphone',
    'electronicMailAddress' = 'ListOfelectronicMailAddress',
    'onlineUrl' = 'ListOfonlineUrl',
    'userId' = 'ListOfuserId',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute',
    'role' = 'ListOfrole'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'descriptorValue',
  slots = c('character' = 'character', 'name_or_id' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'descriptor',
  slots = c(
    'descriptorValue' = 'ListOfdescriptorValue',
    'citation' = 'ListOfcitation',
    'name' = 'xml_attribute',
    'citableClassificationSystem' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'studyAreaDescription',
  slots = c(
    'descriptor' = 'ListOfdescriptor',
    'citation' = 'ListOfcitation',
    'coverage' = 'ListOfcoverage'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'designDescription',
  slots = c('description' = 'ListOfdescription', 'citation' = 'ListOfcitation'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ResearchProjectType',
  slots = c(
    'title' = 'ListOftitle',
    'personnel' = 'ListOfpersonnel',
    'abstract' = 'TextType',
    'funding' = 'TextType',
    'studyAreaDescription' = 'studyAreaDescription',
    'designDescription' = 'designDescription',
    'relatedProject' = 'ListOfrelatedProject',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('DescriptorType', contains = c('eml-2.1.1', 'character')) ## C
setClass('researchProject',
         contains = c('eml-2.1.1', 'ResearchProjectType')) ## D
setClass('funding', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('relatedProject',
         contains = c('eml-2.1.1', 'ResearchProjectType')) ## D
#####  inst/xsd/eml-software.xsd  ####
setClass(
  'ListOflanguage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'language'))) {
      'not all elements are language objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfoperatingSystem',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'operatingSystem'))) {
      'not all elements are operatingSystem objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfmachineProcessor',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'machineProcessor'))) {
      'not all elements are machineProcessor objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfprogrammingLanguage',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'programmingLanguage'))) {
      'not all elements are programmingLanguage objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfimplementation',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'implementation'))) {
      'not all elements are implementation objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOflicenseURL',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'licenseURL'))) {
      'not all elements are licenseURL objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOflicense',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'license'))) {
      'not all elements are license objects'

    } else {
      TRUE
    }
  }
)
setClass('operatingSystem', contains = c('eml-2.1.1', 'character')) ## B
setClass('machineProcessor', contains = c('eml-2.1.1', 'character')) ## B
setClass('virtualMachine', contains = c('eml-2.1.1', 'character')) ## B
setClass('diskUsage', contains = c('eml-2.1.1', 'character')) ## B
setClass('runtimeMemoryUsage', contains = c('eml-2.1.1', 'character')) ## B
setClass('programmingLanguage', contains = c('eml-2.1.1', 'character')) ## B
setClass('checksum', contains = c('eml-2.1.1', 'character')) ## B
setClass('licenseURL', contains = c('eml-2.1.1', 'character')) ## B
setClass('license', contains = c('eml-2.1.1', 'character')) ## B
setClass('version', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'eml:language',
  slots = c(
    'LanguageValue' = 'character',
    'LanguageCodeStandard' = 'character'
  ),
  contains = c('eml-2.1.1', 'character',  'i18nNonEmptyStringType')
)
setClass('Action', contains = c('eml-2.1.1', 'character')) ## C
setClass(
  'implementation',
  slots = c(
    'distribution' = 'ListOfdistribution',
    'size' = 'character',
    'language' = 'ListOflanguage',
    'operatingSystem' = 'ListOfoperatingSystem',
    'machineProcessor' = 'ListOfmachineProcessor',
    'virtualMachine' = 'character',
    'diskUsage' = 'character',
    'runtimeMemoryUsage' = 'character',
    'programmingLanguage' = 'ListOfprogrammingLanguage',
    'checksum' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'SoftwareType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'shortName' = 'character',
    'title' = 'ListOftitle',
    'creator' = 'ListOfcreator',
    'metadataProvider' = 'ListOfmetadataProvider',
    'associatedParty' = 'ListOfassociatedParty',
    'pubDate' = 'yearDate',
    'language' = 'character',
    'series' = 'character',
    'abstract' = 'TextType',
    'keywordSet' = 'ListOfkeywordSet',
    'additionalInfo' = 'ListOfadditionalInfo',
    'intellectualRights' = 'TextType',
    'distribution' = 'ListOfdistribution',
    'coverage' = 'Coverage',
    'implementation' = 'ListOfimplementation',
    'licenseURL' = 'ListOflicenseURL',
    'license' = 'ListOflicense',
    'version' = 'character',
    'project' = 'ResearchProjectType',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'dependency',
  slots = c('action' = 'Action'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('LanguageValue', contains = c('eml-2.1.1', 'character')) ## C
setClass('LanguageCodeStandard', contains = c('eml-2.1.1', 'character')) ## C
setClass('software', contains = c('eml-2.1.1', 'SoftwareType')) ## D
setClass('project', contains = c('eml-2.1.1', 'ResearchProjectType')) ## D
setClass('action', contains = c('eml-2.1.1', 'Action')) ## D
#####  inst/xsd/eml-protocol.xsd  ####
setClass(
  'ListOfproceduralStep',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'proceduralStep'))) {
      'not all elements are proceduralStep objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ProtocolType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'shortName' = 'character',
    'title' = 'ListOftitle',
    'creator' = 'ListOfcreator',
    'metadataProvider' = 'ListOfmetadataProvider',
    'associatedParty' = 'ListOfassociatedParty',
    'pubDate' = 'yearDate',
    'language' = 'character',
    'series' = 'character',
    'abstract' = 'TextType',
    'keywordSet' = 'ListOfkeywordSet',
    'additionalInfo' = 'ListOfadditionalInfo',
    'intellectualRights' = 'TextType',
    'distribution' = 'ListOfdistribution',
    'coverage' = 'Coverage',
    'proceduralStep' = 'ListOfproceduralStep',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('protocol', contains = c('eml-2.1.1', 'ProtocolType')) ## D
#####  inst/xsd/eml-methods.xsd  ####
setClass(
  'ListOfdataSource',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'dataSource'))) {
      'not all elements are dataSource objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfmethodStep',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'methodStep'))) {
      'not all elements are methodStep objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfreferencedEntityId',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'referencedEntityId'))) {
      'not all elements are referencedEntityId objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsampling',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'sampling'))) {
      'not all elements are sampling objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfqualityControl',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'qualityControl'))) {
      'not all elements are qualityControl objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfprotocol',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'protocol'))) {
      'not all elements are protocol objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfinstrumentation',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'instrumentation'))) {
      'not all elements are instrumentation objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsoftware',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'software'))) {
      'not all elements are software objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfsubStep',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'subStep'))) {
      'not all elements are subStep objects'

    } else {
      TRUE
    }
  }
)
setClass('referencedEntityId', contains = c('eml-2.1.1', 'character')) ## B
setClass('instrumentation', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'studyExtent',
  slots = c('coverage' = 'ListOfcoverage', 'description' = 'ListOfdescription'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'spatialSamplingUnits',
  slots = c('referencedEntityId' = 'ListOfreferencedEntityId', 'coverage' = 'ListOfcoverage'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'sampling',
  slots = c(
    'studyExtent' = 'studyExtent',
    'samplingDescription' = 'TextType',
    'spatialSamplingUnits' = 'spatialSamplingUnits',
    'citation' = 'ListOfcitation'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'MethodsType',
  slots = c(
    'methodStep' = 'ListOfmethodStep',
    'sampling' = 'ListOfsampling',
    'qualityControl' = 'ListOfqualityControl'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ProcedureStepType',
  slots = c(
    'description' = 'TextType',
    'citation' = 'ListOfcitation',
    'protocol' = 'ListOfprotocol',
    'instrumentation' = 'ListOfinstrumentation',
    'software' = 'ListOfsoftware',
    'subStep' = 'ListOfsubStep'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('methods', contains = c('eml-2.1.1', 'MethodsType')) ## D
setClass('samplingDescription', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('qualityControl',
         contains = c('eml-2.1.1', 'ProcedureStepType')) ## D
setClass('subStep', contains = c('eml-2.1.1', 'ProcedureStepType')) ## D
#####  inst/xsd/eml-attribute.xsd  ####
setClass(
  'ListOfattribute',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'attribute'))) {
      'not all elements are attribute objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfattributeLabel',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'attributeLabel'))) {
      'not all elements are attributeLabel objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfstorageType',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'storageType'))) {
      'not all elements are storageType objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfmissingValueCode',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'missingValueCode'))) {
      'not all elements are missingValueCode objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfquantitativeAttributeAccuracyAssessment',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'quantitativeAttributeAccuracyAssessment'))) {
      'not all elements are quantitativeAttributeAccuracyAssessment objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcodeDefinition',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'codeDefinition'))) {
      'not all elements are codeDefinition objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcodesetURL',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'codesetURL'))) {
      'not all elements are codesetURL objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfenumeratedDomain',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'enumeratedDomain'))) {
      'not all elements are enumeratedDomain objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfpattern',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'pattern'))) {
      'not all elements are pattern objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOftextDomain',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'textDomain'))) {
      'not all elements are textDomain objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfbounds',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'bounds'))) {
      'not all elements are bounds objects'

    } else {
      TRUE
    }
  }
)
setClass('attributeName', contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeLabel', contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeDefinition', contains = c('eml-2.1.1', 'character')) ## B
setClass('formatString', contains = c('eml-2.1.1', 'character')) ## B
setClass('dateTimePrecision', contains = c('eml-2.1.1', 'character')) ## B
setClass('code', contains = c('eml-2.1.1', 'character')) ## B
setClass('codeExplanation', contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeAccuracyReport',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeAccuracyValue',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('attributeAccuracyExplanation',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('customUnit', contains = c('eml-2.1.1', 'character')) ## B
setClass('source', contains = c('eml-2.1.1', 'character')) ## B
setClass('codesetName', contains = c('eml-2.1.1', 'character')) ## B
setClass('codesetURL', contains = c('eml-2.1.1', 'character')) ## B
setClass('valueAttributeReference',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('definitionAttributeReference',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('orderAttributeReference',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('pattern', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'BoundsGroup',
  slots = c('bounds' = 'ListOfbounds'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'AttributeListType',
  slots = c(
    'attribute' = 'ListOfattribute',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'NonNumericDomainType',
  slots = c(
    'enumeratedDomain' = 'ListOfenumeratedDomain',
    'textDomain' = 'ListOftextDomain',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'NumericDomainType',
  slots = c(
    'numberType' = 'NumberType',
    'BoundsGroup' = 'BoundsGroup',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'BoundsDateGroup',
  slots = c('bounds' = 'ListOfbounds'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'DateTimeDomainType',
  slots = c(
    'BoundsDateGroup' = 'BoundsDateGroup',
    'references' = 'references',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'UnitType',
  slots = c('standardUnit' = 'StandardUnitDictionary', 'customUnit' = 'character'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'storageType',
  slots = c('character' = 'character', 'typeSystem' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'nominal',
  slots = c('nonNumericDomain' = 'NonNumericDomainType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ordinal',
  slots = c('nonNumericDomain' = 'NonNumericDomainType'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'interval',
  slots = c(
    'unit' = 'UnitType',
    'precision' = 'PrecisionType',
    'numericDomain' = 'NumericDomainType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ratio',
  slots = c(
    'unit' = 'UnitType',
    'precision' = 'PrecisionType',
    'numericDomain' = 'NumericDomainType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'dateTime',
  slots = c(
    'formatString' = 'character',
    'dateTimePrecision' = 'character',
    'dateTimeDomain' = 'DateTimeDomainType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'measurementScale',
  slots = c(
    'nominal' = 'nominal',
    'ordinal' = 'ordinal',
    'interval' = 'interval',
    'ratio' = 'ratio',
    'dateTime' = 'dateTime'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'missingValueCode',
  slots = c('code' = 'character', 'codeExplanation' = 'character'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'quantitativeAttributeAccuracyAssessment',
  slots = c(
    'attributeAccuracyValue' = 'character',
    'attributeAccuracyExplanation' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'Accuracy',
  slots = c(
    'attributeAccuracyReport' = 'character',
    'quantitativeAttributeAccuracyAssessment' = 'ListOfquantitativeAttributeAccuracyAssessment'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'codeDefinition',
  slots = c(
    'code' = 'character',
    'definition' = 'character',
    'source' = 'character',
    'order' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'AttributeType',
  slots = c(
    'attributeName' = 'character',
    'attributeLabel' = 'ListOfattributeLabel',
    'attributeDefinition' = 'character',
    'storageType' = 'ListOfstorageType',
    'measurementScale' = 'measurementScale',
    'missingValueCode' = 'ListOfmissingValueCode',
    'accuracy' = 'Accuracy',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'externalCodeSet',
  slots = c(
    'codesetName' = 'character',
    'citation' = 'ListOfcitation',
    'codesetURL' = 'ListOfcodesetURL'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'entityCodeList',
  slots = c(
    'entityReference' = 'character',
    'valueAttributeReference' = 'character',
    'definitionAttributeReference' = 'character',
    'orderAttributeReference' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'enumeratedDomain',
  slots = c(
    'codeDefinition' = 'ListOfcodeDefinition',
    'externalCodeSet' = 'externalCodeSet',
    'entityCodeList' = 'entityCodeList',
    'enforced' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'textDomain',
  slots = c(
    'definition' = 'character',
    'pattern' = 'ListOfpattern',
    'source' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'minimum',
  slots = c('character' = 'character', 'exclusive' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'maximum',
  slots = c('character' = 'character', 'exclusive' = 'xml_attribute'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'bounds',
  slots = c('minimum' = 'minimum', 'maximum' = 'maximum'),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('attribute', contains = c('eml-2.1.1', 'AttributeType')) ## D
setClass('attribute', contains = c('AttributeType')) ## D
setClass('nonNumericDomain', contains = c('NonNumericDomainType')) ## D
setClass('unit', contains = c('UnitType')) ## D
setClass('precision', contains = c('PrecisionType')) ## D
setClass('numericDomain', contains = c('NumericDomainType')) ## D
setClass('dateTimeDomain',
         contains = c('eml-2.1.1', 'DateTimeDomainType')) ## D
setClass('accuracy', contains = c('eml-2.1.1', 'Accuracy')) ## D
setClass('attributeList', contains = c('eml-2.1.1', 'AttributeListType')) ## D
setClass('standardUnit',
         contains = c('eml-2.1.1', 'StandardUnitDictionary')) ## D
setClass('numberType', contains = c('eml-2.1.1', 'NumberType')) ## D
#####  inst/xsd/eml-entity.xsd  ####
setClass(
  'ListOfconstraint',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'constraint'))) {
      'not all elements are constraint objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfphysical',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'physical'))) {
      'not all elements are physical objects'

    } else {
      TRUE
    }
  }
)
setClass('entityType', contains = c('eml-2.1.1', 'character')) ## B
setClass('entityName', contains = c('eml-2.1.1', 'character')) ## B
setClass('entityDescription', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'EntityGroup',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'OtherEntityType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'entityType' = 'character',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('otherEntity', contains = c('eml-2.1.1', 'OtherEntityType')) ## D
setClass('constraint', contains = c('eml-2.1.1', 'ConstraintType')) ## D
#####  inst/xsd/eml-dataTable.xsd  ####
setClass('caseSensitive', contains = c('eml-2.1.1', 'character')) ## B
setClass('numberOfRecords', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'DataTableType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'caseSensitive' = 'caseSensitive',
    'numberOfRecords' = 'character',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('dataTable', contains = c('eml-2.1.1', 'DataTableType')) ## D
#####  inst/xsd/eml-view.xsd  ####
setClass('queryStatement', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'ViewType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'queryStatement' = 'character',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('view', contains = c('eml-2.1.1', 'ViewType')) ## D
#####  inst/xsd/eml-storedProcedure.xsd  ####
setClass('domainDescription', contains = c('eml-2.1.1', 'character')) ## B
setClass('required', contains = c('eml-2.1.1', 'character')) ## B
setClass('repeats', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'StoredProcedureType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'parameter' = 'ListOfparameter',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'ParameterType',
  slots = c(
    'name' = 'character',
    'domainDescription' = 'character',
    'required' = 'character',
    'repeats' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('storedProcedure',
         contains = c('eml-2.1.1', 'StoredProcedureType')) ## D
#####  inst/xsd/eml-spatialVector.xsd  ####
setClass(
  'ListOfgeometry',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'geometry'))) {
      'not all elements are geometry objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfquantitativeAccuracyReport',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'quantitativeAccuracyReport'))) {
      'not all elements are quantitativeAccuracyReport objects'

    } else {
      TRUE
    }
  }
)
setClass('geometricObjectCount', contains = c('eml-2.1.1', 'character')) ## B
setClass('accuracyReport', contains = c('eml-2.1.1', 'character')) ## B
setClass('quantitativeAccuracyValue',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('quantitativeAccuracyMethod',
         contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'quantitativeAccuracyReport',
  slots = c(
    'quantitativeAccuracyValue' = 'character',
    'quantitativeAccuracyMethod' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'DataQuality',
  slots = c(
    'accuracyReport' = 'character',
    'quantitativeAccuracyReport' = 'ListOfquantitativeAccuracyReport'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'SpatialVectorType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'geometry' = 'ListOfgeometry',
    'geometricObjectCount' = 'character',
    'topologyLevel' = 'TopologyLevel',
    'spatialReference' = 'SpatialReferenceType',
    'horizontalAccuracy' = 'DataQuality',
    'verticalAccuracy' = 'DataQuality',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('spatialVector', contains = c('eml-2.1.1', 'SpatialVectorType')) ## D
setClass('geometry', contains = c('eml-2.1.1', 'GeometryType')) ## D
setClass('topologyLevel', contains = c('eml-2.1.1', 'TopologyLevel')) ## D
setClass('spatialReference',
         contains = c('eml-2.1.1', 'SpatialReferenceType')) ## D
setClass('horizontalAccuracy', contains = c('eml-2.1.1', 'DataQuality')) ## D
setClass('verticalAccuracy', contains = c('eml-2.1.1', 'DataQuality')) ## D
#####  inst/xsd/eml-spatialRaster.xsd  ####
setClass(
  'ListOfcornerPoint',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'cornerPoint'))) {
      'not all elements are cornerPoint objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfcontrolPoint',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'controlPoint'))) {
      'not all elements are controlPoint objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfbandDescription',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'bandDescription'))) {
      'not all elements are bandDescription objects'

    } else {
      TRUE
    }
  }
)
setClass('xCoordinate', contains = c('eml-2.1.1', 'character')) ## B
setClass('yCoordinate', contains = c('eml-2.1.1', 'character')) ## B
setClass('pointInPixel', contains = c('eml-2.1.1', 'character')) ## B
setClass('column', contains = c('eml-2.1.1', 'character')) ## B
setClass('row', contains = c('eml-2.1.1', 'character')) ## B
setClass('xIntercept', contains = c('eml-2.1.1', 'character')) ## B
setClass('xSlope', contains = c('eml-2.1.1', 'character')) ## B
setClass('yIntercept', contains = c('eml-2.1.1', 'character')) ## B
setClass('ySlope', contains = c('eml-2.1.1', 'character')) ## B
setClass('cellSizeXDirection', contains = c('eml-2.1.1', 'character')) ## B
setClass('cellSizeYDirection', contains = c('eml-2.1.1', 'character')) ## B
setClass('numberOfBands', contains = c('eml-2.1.1', 'character')) ## B
setClass('rows', contains = c('eml-2.1.1', 'character')) ## B
setClass('columns', contains = c('eml-2.1.1', 'character')) ## B
setClass('verticals', contains = c('eml-2.1.1', 'character')) ## B
setClass('toneGradation', contains = c('eml-2.1.1', 'character')) ## B
setClass('scaleFactor', contains = c('eml-2.1.1', 'character')) ## B
setClass('offset', contains = c('eml-2.1.1', 'character')) ## B
setClass('illuminationElevationAngle',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('illuminationAzimuthAngle',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('imageOrientationAngle', contains = c('eml-2.1.1', 'character')) ## B
setClass('imageQualityCode', contains = c('eml-2.1.1', 'character')) ## B
setClass('cloudCoverPercentage', contains = c('eml-2.1.1', 'character')) ## B
setClass('preProcessingTypeCode', contains = c('eml-2.1.1', 'character')) ## B
setClass('compressionGenerationQuality',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('triangulationIndicator',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('radiometricDataAvailability',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('cameraCalibrationInformationAvailability',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('filmDistortionInformationAvailability',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('lensDistortionInformationAvailability',
         contains = c('eml-2.1.1', 'character')) ## B
setClass('sequenceIdentifier', contains = c('eml-2.1.1', 'character')) ## B
setClass('highWavelength', contains = c('eml-2.1.1', 'character')) ## B
setClass('lowWaveLength', contains = c('eml-2.1.1', 'character')) ## B
setClass('peakResponse', contains = c('eml-2.1.1', 'character')) ## B
setClass('rasterOriginType', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'cornerPoint',
  slots = c(
    'xCoordinate' = 'character',
    'yCoordinate' = 'character',
    'pointInPixel' = 'pointInPixel',
    'corner' = 'rasterOriginType'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'controlPoint',
  slots = c(
    'column' = 'character',
    'row' = 'character',
    'xCoordinate' = 'character',
    'yCoordinate' = 'character',
    'pointInPixel' = 'pointInPixel'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'bilinearFit',
  slots = c(
    'xIntercept' = 'character',
    'xSlope' = 'character',
    'yIntercept' = 'character',
    'ySlope' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'georeferenceInfo',
  slots = c(
    'cornerPoint' = 'ListOfcornerPoint',
    'controlPoint' = 'ListOfcontrolPoint',
    'bilinearFit' = 'bilinearFit'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'imageDescription',
  slots = c(
    'illuminationElevationAngle' = 'character',
    'illuminationAzimuthAngle' = 'character',
    'imageOrientationAngle' = 'character',
    'imagingCondition' = 'ImagingConditionCode',
    'imageQualityCode' = 'character',
    'cloudCoverPercentage' = 'character',
    'preProcessingTypeCode' = 'character',
    'compressionGenerationQuality' = 'character',
    'triangulationIndicator' = 'character',
    'radiometricDataAvailability' = 'character',
    'cameraCalibrationInformationAvailability' = 'character',
    'filmDistortionInformationAvailability' = 'character',
    'lensDistortionInformationAvailability' = 'character',
    'bandDescription' = 'ListOfbandDescription'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'SpatialRasterType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'entityName' = 'character',
    'entityDescription' = 'character',
    'physical' = 'ListOfphysical',
    'coverage' = 'Coverage',
    'methods' = 'MethodsType',
    'additionalInfo' = 'ListOfadditionalInfo',
    'attributeList' = 'AttributeListType',
    'constraint' = 'ListOfconstraint',
    'spatialReference' = 'SpatialReferenceType',
    'georeferenceInfo' = 'georeferenceInfo',
    'horizontalAccuracy' = 'DataQuality',
    'verticalAccuracy' = 'DataQuality',
    'cellSizeXDirection' = 'cellSizeXDirection',
    'cellSizeYDirection' = 'cellSizeYDirection',
    'numberOfBands' = 'numberOfBands',
    'rasterOrigin' = 'rasterOriginType',
    'rows' = 'character',
    'columns' = 'character',
    'verticals' = 'verticals',
    'cellGeometry' = 'CellGeometryType',
    'toneGradation' = 'character',
    'scaleFactor' = 'character',
    'offset' = 'character',
    'imageDescription' = 'imageDescription',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'BandType',
  slots = c(
    'sequenceIdentifier' = 'character',
    'highWavelength' = 'character',
    'lowWaveLength' = 'character',
    'waveLengthUnits' = 'lengthUnits',
    'peakResponse' = 'peakResponse'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('CellValueType', contains = c('eml-2.1.1', 'character')) ## C
setClass('spatialRaster', contains = c('eml-2.1.1', 'SpatialRasterType')) ## D
setClass('corner', contains = c('eml-2.1.1', 'rasterOriginType')) ## D
setClass('rasterOrigin', contains = c('eml-2.1.1', 'rasterOriginType')) ## D
setClass('cellGeometry', contains = c('eml-2.1.1', 'CellGeometryType')) ## D
setClass('imagingCondition',
         contains = c('eml-2.1.1', 'ImagingConditionCode')) ## D
setClass('bandDescription', contains = c('eml-2.1.1', 'BandType')) ## D
setClass('waveLengthUnits', contains = c('eml-2.1.1', 'lengthUnits')) ## D
#####  inst/xsd/eml-dataset.xsd  ####
setClass(
  'ListOfdataTable',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'dataTable'))) {
      'not all elements are dataTable objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfspatialRaster',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'spatialRaster'))) {
      'not all elements are spatialRaster objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfspatialVector',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'spatialVector'))) {
      'not all elements are spatialVector objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfstoredProcedure',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'storedProcedure'))) {
      'not all elements are storedProcedure objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfview',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'view'))) {
      'not all elements are view objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfotherEntity',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'otherEntity'))) {
      'not all elements are otherEntity objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfchangeHistory',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'changeHistory'))) {
      'not all elements are changeHistory objects'

    } else {
      TRUE
    }
  }
)
setClass('pubPlace', contains = c('eml-2.1.1', 'character')) ## B
setClass('changeScope', contains = c('eml-2.1.1', 'character')) ## B
setClass('oldValue', contains = c('eml-2.1.1', 'character')) ## B
setClass('changeDate', contains = c('eml-2.1.1', 'character')) ## B
setClass('comment', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'changeHistory',
  slots = c(
    'changeScope' = 'character',
    'oldValue' = 'character',
    'changeDate' = 'character',
    'comment' = 'character'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'MaintenanceType',
  slots = c(
    'description' = 'TextType',
    'maintenanceUpdateFrequency' = 'MaintUpFreqType',
    'changeHistory' = 'ListOfchangeHistory'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass(
  'DatasetType',
  slots = c(
    'alternateIdentifier' = 'ListOfalternateIdentifier',
    'shortName' = 'character',
    'title' = 'ListOftitle',
    'creator' = 'ListOfcreator',
    'metadataProvider' = 'ListOfmetadataProvider',
    'associatedParty' = 'ListOfassociatedParty',
    'pubDate' = 'yearDate',
    'language' = 'character',
    'series' = 'character',
    'abstract' = 'TextType',
    'keywordSet' = 'ListOfkeywordSet',
    'additionalInfo' = 'ListOfadditionalInfo',
    'intellectualRights' = 'TextType',
    'distribution' = 'ListOfdistribution',
    'coverage' = 'Coverage',
    'purpose' = 'TextType',
    'maintenance' = 'MaintenanceType',
    'contact' = 'ListOfcontact',
    'publisher' = 'ResponsibleParty',
    'pubPlace' = 'character',
    'methods' = 'MethodsType',
    'project' = 'ResearchProjectType',
    'dataTable' = 'ListOfdataTable',
    'spatialRaster' = 'ListOfspatialRaster',
    'spatialVector' = 'ListOfspatialVector',
    'storedProcedure' = 'ListOfstoredProcedure',
    'view' = 'ListOfview',
    'otherEntity' = 'ListOfotherEntity',
    'references' = 'references',
    'id' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('dataset', contains = c('eml-2.1.1', 'DatasetType')) ## D
setClass('purpose', contains = c('eml-2.1.1', 'TextType')) ## D
setClass('maintenance', contains = c('eml-2.1.1', 'MaintenanceType')) ## D
setClass('maintenanceUpdateFrequency',
         contains = c('eml-2.1.1', 'MaintUpFreqType')) ## D
#####  inst/xsd/eml.xsd  ####
setClass(
  'ListOfdescribes',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'describes'))) {
      'not all elements are describes objects'

    } else {
      TRUE
    }
  }
)
setClass(
  'ListOfadditionalMetadata',
  contains = 'list',
  validity = function(object) {
    if (!all(sapply(object, is, 'additionalMetadata'))) {
      'not all elements are additionalMetadata objects'

    } else {
      TRUE
    }
  }
)
setClass('describes', contains = c('eml-2.1.1', 'character')) ## B
setClass(
  'eml',
  slots = c(
    'access' = 'AccessType',
    'dataset' = 'DatasetType',
    'citation' = 'CitationType',
    'software' = 'SoftwareType',
    'protocol' = 'ProtocolType',
    'additionalMetadata' = 'ListOfadditionalMetadata',
    'packageId' = 'xml_attribute',
    'system' = 'xml_attribute',
    'scope' = 'xml_attribute',
    'lang' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('proceduralStep', contains = c('ProcedureStepType')) ## D
setClass(
  'methodStep',
  slots = c(
    'description' = 'TextType',
    'citation' = 'ListOfcitation',
    'protocol' = 'ListOfprotocol',
    'instrumentation' = 'ListOfinstrumentation',
    'software' = 'ListOfsoftware',
    'subStep' = 'ListOfsubStep',
    'dataSource' = 'ListOfdataSource'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
setClass('dataSource', contains = c('eml-2.1.1', 'DatasetType')) ## D
setClass('coverage', contains = c('Coverage'))
setClass(
  'temporalCoverage',
  slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'),
  contains = c('TemporalCoverage')
)
setClass(
  'taxonomicCoverage',
  slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'),
  contains = c('TaxonomicCoverage')
)
setClass(
  'geographicCoverage',
  slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'),
  contains = c('GeographicCoverage')
)
setClass('inline', contains = 'InlineType')
setClass(
  'parameter',
  slots = c(
    name = 'character',
    value = 'character',
    'domainDescription' = 'character',
    'required' = 'character',
    'repeats' = 'character'
  ),
  contains = "eml-2.1.1"
)
setClass('online',
         contains = c('PhysicalOnlineType', 'OnlineType', 'eml-2.1.1'))
setClass('metadata', contains = 'InlineType')
setClass(
  'additionalMetadata',
  slots = c(
    'describes' = 'ListOfdescribes',
    'metadata' = 'metadata',
    'id' = 'xml_attribute'
  ),
  contains = c('eml-2.1.1', 'character')
) ## A
