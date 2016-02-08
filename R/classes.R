setClass('eml-2.1.1')
setClass('xml_attribute', contains = 'character')

setClass('PrecisionType', contains = c('numeric'))
setClass('ReferencesGroup', slots = c('references' = 'character'), contains = c('eml-2.1.1'))
setClass('ConstraintBaseGroup', slots = c('constraintName' = 'character', 'constraintDescription' = 'character'), contains = c('eml-2.1.1'))
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


#####  inst/xsd/stmml.xsd  ####


setClass('ListOfarray', contains = 'list')
setClass('ListOfunitList', contains = 'list')
setClass('ListOfannotation', contains = 'list')
setClass('ListOfdescription', contains = 'list')
setClass('ListOfentry', contains = 'list')
setClass('ListOfalternative', contains = 'list')
setClass('ListOfannotation', contains = 'list')
setClass('ListOfdescription', contains = 'list')
setClass('ListOfenumeration', contains = 'list')
setClass('ListOfrelatedEntry', contains = 'list')
setClass('ListOfdocumentation', contains = 'list')
setClass('ListOfappinfo', contains = 'list')
setClass('ListOfmetadata', contains = 'list')
setClass('ListOfunitType', contains = 'list')
setClass('ListOfunit', contains = 'list')
setClass('ListOfdimension', contains = 'list')
setClass('ListOfdescription', contains = 'list')
setClass('ListOfannotation', contains = 'list')
setClass('eml:array', slots = c('dataType' = 'xml_attribute', 'errorValues' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValues' = 'xml_attribute', 'maxValues' = 'xml_attribute', 'units' = 'xml_attribute', 'delimiter' = 'xml_attribute', 'size' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('scalar', slots = c('dataType' = 'xml_attribute', 'errorValue' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValue' = 'xml_attribute', 'maxValue' = 'xml_attribute', 'units' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('eml:matrix', slots = c('dataType' = 'xml_attribute', 'delimiter' = 'xml_attribute', 'rows' = 'xml_attribute', 'columns' = 'xml_attribute', 'units' = 'xml_attribute', 'matrixType' = 'xml_attribute', 'errorValues' = 'xml_attribute', 'errorBasis' = 'xml_attribute', 'minValues' = 'xml_attribute', 'maxValues' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('eml:table', slots = c('array' = 'ListOfarray', 'rows' = 'xml_attribute', 'columns' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('eml:list', slots = c('type' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('link', slots = c('from' = 'xml_attribute', 'to' = 'xml_attribute', 'ref' = 'xml_attribute', 'role' = 'xml_attribute', 'href' = 'xml_attribute', 'type' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('action', slots = c('type' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('actionList', slots = c('type' = 'xml_attribute', 'order' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('object', slots = c('type' = 'xml_attribute', 'count' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('observation', slots = c('type' = 'xml_attribute', 'count' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('dictionary', slots = c('unitList' = 'ListOfunitList', 'annotation' = 'ListOfannotation', 'description' = 'ListOfdescription', 'entry' = 'ListOfentry', 'href' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('entry', slots = c('definition' = 'character', 'alternative' = 'ListOfalternative', 'annotation' = 'ListOfannotation', 'description' = 'ListOfdescription', 'enumeration' = 'ListOfenumeration', 'relatedEntry' = 'ListOfrelatedEntry', 'dataType' = 'xml_attribute', 'rows' = 'xml_attribute', 'columns' = 'xml_attribute', 'recommendedUnits' = 'xml_attribute', 'unitType' = 'xml_attribute', 'minExclusive' = 'xml_attribute', 'minInclusive' = 'xml_attribute', 'maxExclusive' = 'xml_attribute', 'maxInclusive' = 'xml_attribute', 'totalDigits' = 'xml_attribute', 'fractionDigits' = 'xml_attribute', 'length' = 'xml_attribute', 'minLength' = 'xml_attribute', 'maxLength' = 'xml_attribute', 'units' = 'xml_attribute', 'whiteSpace' = 'xml_attribute', 'pattern' = 'xml_attribute', 'term' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('description', slots = c('eml:class' ='xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('enumeration', slots = c('annotation' = 'character', 'value' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('alternative', slots = c('type' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('relatedEntry', slots = c('type' = 'xml_attribute', 'href' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('annotation', slots = c('documentation' = 'ListOfdocumentation', 'appinfo' = 'ListOfappinfo', 'source' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('appinfo', slots = c('source' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('metadata', slots = c('name' = 'xml_attribute', 'content' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('metadataList', slots = c('metadata' = 'ListOfmetadata'), contains = c('eml-2.1.1')) ## A
setClass('dimension', slots = c('name' = 'xml_attribute', 'power' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('unitList', slots = c('unitType' = 'ListOfunitType', 'unit' = 'ListOfunit', 'href' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('unitType', slots = c('dimension' = 'ListOfdimension', 'id' = 'xml_attribute', 'name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('unit', slots = c('description' = 'ListOfdescription', 'annotation' = 'ListOfannotation', 'id' = 'xml_attribute', 'abbreviation' = 'xml_attribute', 'name' = 'xml_attribute', 'parentSI' = 'xml_attribute', 'unitType' = 'xml_attribute', 'multiplierToSI' = 'xml_attribute', 'constantToSI' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('dataGroup', slots = c('list' = 'character', 'scalar' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('coordinate2Type', contains = c('character')) ## B
setClass('coordinate3Type', contains = c('character')) ## B
setClass('dataTypeType', contains = c('character')) ## B
setClass('sizeType', contains = c('xs:positiveInteger')) ## B
setClass('delimiterType', contains = c('character')) ## B
setClass('floatArrayType', contains = c('character')) ## B
setClass('matrixType', contains = c('character')) ## B
setClass('countType', contains = c('xs:integer')) ## B
setClass('idType', contains = c('character')) ## B
setClass('errorBasisType', contains = c('character')) ## B
setClass('maxType', contains = c('character')) ## B
setClass('minType', contains = c('character')) ## B
setClass('namespaceRefType', contains = c('character')) ## B
setClass('refType', contains = c('idType')) ## B
setClass('metadataType', contains = c('character')) ## B
setClass('dimensionType', contains = c('character')) ## B
setClass('unitsType', contains = c('character')) ## B
setClass('stmml', contains = c('character')) ## B
setClass('definition', contains = c('character')) ## B
setClass('documentation', contains = c('character')) ## B


#####  inst/xsd/eml-text.xsd  ####


setClass('ListOfsection', contains = 'list')
setClass('ListOfpara', contains = 'list')
setClass('ListOfvalue', contains = 'list')
setClass('ListOfvalue', contains = 'list')
setClass('ListOfcitetitle', contains = 'list')
setClass('ListOfvalue', contains = 'list')
setClass('ListOfitemizedlist', contains = 'list')
setClass('ListOforderedlist', contains = 'list')
setClass('ListOfemphasis', contains = 'list')
setClass('ListOfsubscript', contains = 'list')
setClass('ListOfsuperscript', contains = 'list')
setClass('ListOfliteralLayout', contains = 'list')
setClass('ListOfulink', contains = 'list')
setClass('ListOfpara', contains = 'list')
setClass('ListOfsection', contains = 'list')
setClass('ListOfpara', contains = 'list')
setClass('ListOfitemizedlist', contains = 'list')
setClass('ListOforderedlist', contains = 'list')
setClass('ListOflistitem', contains = 'list')
setClass('ListOfvalue', contains = 'list')
setClass('ListOfsubscript', contains = 'list')
setClass('ListOfsuperscript', contains = 'list')
setClass('TextType', slots = c('section' = 'ListOfsection', 'para' = 'ListOfpara', 'xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('emphasis', slots = c('value' = 'ListOfvalue', 'xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('literalLayout', slots = c('value' = 'ListOfvalue'), contains = c('character', 'eml-2.1.1')) ## A
setClass('ulink', slots = c('citetitle' = 'ListOfcitetitle', 'url' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('ParagraphType', slots = c('value' = 'ListOfvalue', 'itemizedlist' = 'ListOfitemizedlist', 'orderedlist' = 'ListOforderedlist', 'emphasis' = 'ListOfemphasis', 'subscript' = 'ListOfsubscript', 'superscript' = 'ListOfsuperscript', 'literalLayout' = 'ListOfliteralLayout', 'ulink' = 'ListOfulink', 'xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('SectionType', slots = c('title' = 'character', 'para' = 'ListOfpara', 'section' = 'ListOfsection', 'xml:lang' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('listitem', slots = c('para' = 'ListOfpara', 'itemizedlist' = 'ListOfitemizedlist', 'orderedlist' = 'ListOforderedlist'), contains = c('eml-2.1.1')) ## A
setClass('ListType', slots = c('listitem' = 'ListOflistitem'), contains = c('eml-2.1.1')) ## A
setClass('SubSuperScriptType', slots = c('value' = 'ListOfvalue', 'subscript' = 'ListOfsubscript', 'superscript' = 'ListOfsuperscript', 'xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('i18nString', slots = c('xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('text', contains = c('TextType')) ## B
setClass('section', contains = c('SectionType')) ## B
setClass('para', contains = c('ParagraphType')) ## B
setClass('value', contains = c('character')) ## B
setClass('itemizedlist', contains = c('ListType')) ## B
setClass('orderedlist', contains = c('ListType')) ## B
setClass('value', contains = c('character')) ## B
setClass('subscript', contains = c('SubSuperScriptType')) ## B
setClass('superscript', contains = c('SubSuperScriptType')) ## B
setClass('value', contains = c('character')) ## B
setClass('citetitle', contains = c('character')) ## B
setClass('title', contains = c('character')) ## B
setClass('para', contains = c('ParagraphType')) ## B
setClass('section', contains = c('SectionType')) ## B
setClass('para', contains = c('ParagraphType')) ## B
setClass('itemizedlist', contains = c('ListType')) ## B
setClass('orderedlist', contains = c('ListType')) ## B
setClass('value', contains = c('character')) ## B
setClass('subscript', contains = c('SubSuperScriptType')) ## B
setClass('superscript', contains = c('SubSuperScriptType')) ## B


#####  inst/xsd/eml-documentation.xsd  ####


setClass('moduleDocs', slots = c('moduleName' = 'character', 'moduleDescription' = 'TextType', 'recommendedUsage' = 'character', 'standAlone' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('moduleName', contains = c('character')) ## B
setClass('moduleDescription', contains = c('TextType')) ## B
setClass('recommendedUsage', contains = c('character')) ## B
setClass('standAlone', contains = c('character')) ## B
setClass('tooltip', contains = c('character')) ## B
setClass('summary', contains = c('character')) ## B
setClass('description', contains = c('TextType')) ## B
setClass('example', contains = c('TextType')) ## B
setClass('lineage', contains = c('character')) ## B
setClass('module', contains = c('character')) ## B


#####  inst/xsd/eml-unitTypeDefinitions.xsd  ####


setClass('StandardUnitDictionary', contains = c('character')) ## B
setClass('LengthUnitType', contains = c('character')) ## B
setClass('MassUnitType', contains = c('character')) ## B
setClass('otherUnitType', contains = c('character')) ## B
setClass('angleUnitType', contains = c('character')) ## B


#####  inst/xsd/eml-party.xsd  ####


setClass('ListOfindividualName', contains = 'list')
setClass('ListOforganizationName', contains = 'list')
setClass('ListOfpositionName', contains = 'list')
setClass('ListOfaddress', contains = 'list')
setClass('ListOfphone', contains = 'list')
setClass('ListOfelectronicMailAddress', contains = 'list')
setClass('ListOfonlineUrl', contains = 'list')
setClass('ListOfuserId', contains = 'list')
setClass('ListOfsalutation', contains = 'list')
setClass('ListOfgivenName', contains = 'list')
setClass('ListOfdeliveryPoint', contains = 'list')
setClass('phone', slots = c('phonetype' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('userId', slots = c('directory' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('ResponsibleParty', slots = c('ReferencesGroup' = 'ReferencesGroup', 'address' = 'ListOfaddress', 'phone' = 'ListOfphone', 'electronicMailAddress' = 'ListOfelectronicMailAddress', 'onlineUrl' = 'ListOfonlineUrl', 'userId' = 'ListOfuserId', 'individualName' = 'ListOfindividualName', 'organizationName' = 'ListOforganizationName', 'positionName' = 'ListOfpositionName', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('Person', slots = c('salutation' = 'ListOfsalutation', 'givenName' = 'ListOfgivenName', 'surName' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Address', slots = c('ReferencesGroup' = 'ReferencesGroup', 'deliveryPoint' = 'ListOfdeliveryPoint', 'city' = 'character', 'administrativeArea' = 'character', 'postalCode' = 'character', 'country' = 'character', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('RoleType', contains = c('character')) ## B
setClass('party', contains = c('ResponsibleParty')) ## B
setClass('address', contains = c('Address')) ## B
setClass('electronicMailAddress', contains = c('character')) ## B
setClass('onlineUrl', contains = c('xs:anyURI')) ## B
setClass('individualName', contains = c('Person')) ## B
setClass('organizationName', contains = c('character')) ## B
setClass('positionName', contains = c('character')) ## B
setClass('salutation', contains = c('character')) ## B
setClass('givenName', contains = c('character')) ## B
setClass('surName', contains = c('character')) ## B
setClass('deliveryPoint', contains = c('character')) ## B
setClass('city', contains = c('character')) ## B
setClass('administrativeArea', contains = c('character')) ## B
setClass('postalCode', contains = c('character')) ## B
setClass('country', contains = c('character')) ## B


#####  inst/xsd/eml-resource.xsd  ####


setClass('ListOfkeyword', contains = 'list')
setClass('ListOfalternateIdentifier', contains = 'list')
setClass('ListOftitle', contains = 'list')
setClass('ListOfcreator', contains = 'list')
setClass('ListOfmetadataProvider', contains = 'list')
setClass('ListOfassociatedParty', contains = 'list')
setClass('ListOfkeywordSet', contains = 'list')
setClass('ListOfadditionalInfo', contains = 'list')
setClass('ListOfdistribution', contains = 'list')
setClass('ListOfparameterDefinition', contains = 'list')
setClass('ListOfmediumFormat', contains = 'list')
setClass('ListOfparameter', contains = 'list')
setClass('ListOfvalue', contains = 'list')
setClass('alternateIdentifier', slots = c('system' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('associatedParty', slots = c('role' = 'RoleType'), contains = c('ResponsibleParty', 'eml-2.1.1')) ## A
setClass('keyword', slots = c('keywordType' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('keywordSet', slots = c('keyword' = 'ListOfkeyword', 'keywordThesaurus' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('ResourceGroup', slots = c('alternateIdentifier' = 'ListOfalternateIdentifier', 'shortName' = 'character', 'title' = 'ListOftitle', 'creator' = 'ListOfcreator', 'metadataProvider' = 'ListOfmetadataProvider', 'associatedParty' = 'ListOfassociatedParty', 'pubDate' = 'yearDate', 'language' = 'character', 'series' = 'character', 'abstract' = 'TextType', 'keywordSet' = 'ListOfkeywordSet', 'additionalInfo' = 'ListOfadditionalInfo', 'intellectualRights' = 'TextType', 'distribution' = 'ListOfdistribution', 'coverage' = 'Coverage'), contains = c('eml-2.1.1')) ## A
setClass('references', slots = c('system' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('ReferencesGroup', slots = c('references' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('DistributionType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'online' = 'OnlineType', 'offline' = 'OfflineType', 'inline' = 'InlineType', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('schemeName', slots = c('system' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('parameterDefinition', slots = c('name' = 'character', 'definition' = 'character', 'defaultValue' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('ConnectionDefinitionType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'schemeName' = 'character', 'description' = 'TextType', 'parameterDefinition' = 'ListOfparameterDefinition', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('OfflineType', slots = c('mediumName' = 'character', 'mediumDensity' = 'character', 'mediumDensityUnits' = 'character', 'mediumVolume' = 'character', 'mediumFormat' = 'ListOfmediumFormat', 'mediumNote' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('OnlineType', slots = c('onlineDescription' = 'character', 'url' = 'UrlType', 'connection' = 'ConnectionType', 'connectionDefinition' = 'ConnectionDefinitionType'), contains = c('eml-2.1.1')) ## A
setClass('UrlType', slots = c('function' = 'xml_attribute'), contains = c('xs:anyURI', 'eml-2.1.1')) ## A
setClass('parameter', slots = c('name' = 'character', 'value' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('ConnectionType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'connectionDefinition' = 'ConnectionDefinitionType', 'parameter' = 'ListOfparameter', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('value', slots = c('xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('i18nNonEmptyStringType', slots = c('value' = 'ListOfvalue', 'xml:lang' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('KeyTypeCode', contains = c('character')) ## B
setClass('yearDate', contains = c('character')) ## B
setClass('IDType', contains = c('character')) ## B
setClass('SystemType', contains = c('character')) ## B
setClass('ScopeType', contains = c('character')) ## B
setClass('FunctionType', contains = c('character')) ## B
setClass('NonEmptyStringType', contains = c('character')) ## B
setClass('shortName', contains = c('character')) ## B
setClass('title', contains = c('character')) ## B
setClass('creator', contains = c('ResponsibleParty')) ## B
setClass('metadataProvider', contains = c('ResponsibleParty')) ## B
setClass('role', contains = c('RoleType')) ## B
setClass('pubDate', contains = c('yearDate')) ## B
setClass('eml:language', contains = c('character')) ## B
setClass('series', contains = c('character')) ## B
setClass('abstract', contains = c('TextType')) ## B
setClass('keywordThesaurus', contains = c('character')) ## B
setClass('additionalInfo', contains = c('TextType')) ## B
setClass('intellectualRights', contains = c('TextType')) ## B
setClass('distribution', contains = c('DistributionType')) ## B

setClass('online', contains = c('OnlineType')) ## B
setClass('offline', contains = c('OfflineType')) ## B
setClass('inline', contains='character')
setClass('description', contains = c('TextType')) ## B
setClass('eml:name', contains = c('character')) ## B
setClass('definition', contains = c('character')) ## B
setClass('defaultValue', contains = c('character')) ## B
setClass('InlineType', contains='character')
setClass('mediumName', contains = c('character')) ## B
setClass('mediumDensity', contains = c('character')) ## B
setClass('mediumDensityUnits', contains = c('character')) ## B
setClass('mediumVolume', contains = c('character')) ## B
setClass('mediumFormat', contains = c('character')) ## B
setClass('mediumNote', contains = c('character')) ## B
setClass('onlineDescription', contains = c('character')) ## B
setClass('url', contains = c('UrlType')) ## B
setClass('connection', contains = c('ConnectionType')) ## B
setClass('connectionDefinition', contains = c('ConnectionDefinitionType')) ## B
setClass('connectionDefinition', contains = c('ConnectionDefinitionType')) ## B
setClass('eml:name', contains = c('character')) ## B
setClass('value', contains = c('character')) ## B


#####  inst/xsd/eml-spatialReference.xsd  ####


setClass('ListOfhorizCoordSysDef', contains = 'list')
setClass('ListOfaltitudeResolution', contains = 'list')
setClass('ListOfdepthResolution', contains = 'list')
setClass('ListOfparameter', contains = 'list')
setClass('projectionList', slots = c('horizCoordSysDef' = 'ListOfhorizCoordSysDef'), contains = c('eml-2.1.1')) ## A
setClass('altitudeSysDef', slots = c('altitudeDatumName' = 'character', 'altitudeResolution' = 'ListOfaltitudeResolution', 'altitudeDistanceUnits' = 'character', 'altitudeEncodingMethod' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('depthSysDef', slots = c('depthDatumName' = 'character', 'depthResolution' = 'ListOfdepthResolution', 'depthDistanceUnits' = 'character', 'depthEncodingMethod' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('vertCoordSys', slots = c('altitudeSysDef' = 'character', 'depthSysDef' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('SpatialReferenceType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'vertCoordSys' = 'character', 'horizCoordSysName' = 'character', 'horizCoordSysDef' = 'horizCoordSysType', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('datum', slots = c('name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('spheroid', slots = c('name' = 'xml_attribute', 'semiAxisMajor' = 'xml_attribute', 'denomFlatRatio' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('primeMeridian', slots = c('name' = 'xml_attribute', 'longitude' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('unit', slots = c('name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('geogCoordSysType', slots = c('datum' = 'character', 'spheroid' = 'character', 'primeMeridian' = 'character', 'unit' = 'character', 'name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('parameter', slots = c('name' = 'xml_attribute', 'description' = 'xml_attribute', 'value' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('unit', slots = c('name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('projection', slots = c('parameter' = 'ListOfparameter', 'unit' = 'character', 'name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('projCoordSys', slots = c('geogCoordSys' = 'geogCoordSysType', 'projection' = 'projection'), contains = c('eml-2.1.1')) ## A
setClass('horizCoordSysType', slots = c('geogCoordSys' = 'geogCoordSysType', 'projCoordSys' = 'projCoordSys', 'name' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('lengthUnits', contains = c('character')) ## B
setClass('angleUnits', contains = c('character')) ## B
setClass('horizCoordSysDef', contains = c('horizCoordSysType')) ## B
setClass('spatialReference', contains = c('SpatialReferenceType')) ## B
setClass('altitudeDatumName', contains = c('character')) ## B
setClass('altitudeResolution', contains = c('character')) ## B
setClass('altitudeDistanceUnits', contains = c('character')) ## B
setClass('altitudeEncodingMethod', contains = c('character')) ## B
setClass('depthDatumName', contains = c('character')) ## B
setClass('depthResolution', contains = c('character')) ## B
setClass('depthDistanceUnits', contains = c('character')) ## B
setClass('depthEncodingMethod', contains = c('character')) ## B
setClass('horizCoordSysName', contains = c('character')) ## B
setClass('horizCoordSysDef', contains = c('horizCoordSysType')) ## B
setClass('geogCoordSys', contains = c('geogCoordSysType')) ## B
setClass('geogCoordSys', contains = c('geogCoordSysType')) ## B


#####  inst/xsd/eml-access.xsd  ####


setClass('ListOfallow', contains = 'list')
setClass('ListOfdeny', contains = 'list')
setClass('ListOfprincipal', contains = 'list')
setClass('ListOfpermission', contains = 'list')
setClass('AccessType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'allow' = 'ListOfallow', 'deny' = 'ListOfdeny', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute', 'order' = 'xml_attribute', 'authSystem' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('AccessRule', slots = c('principal' = 'ListOfprincipal', 'permission' = 'ListOfpermission'), contains = c('eml-2.1.1')) ## A
setClass('access', contains = c('AccessType')) ## B
setClass('allow', contains = c('AccessRule')) ## B
setClass('deny', contains = c('AccessRule')) ## B
setClass('principal', contains = c('character')) ## B
setClass('permission', contains = c('character')) ## B


#####  inst/xsd/eml-constraint.xsd  ####


setClass('ListOfattributeReference', contains = 'list')
setClass('ListOfattributeReference', contains = 'list')
setClass('ListOfattributeReference', contains = 'list')
setClass('ListOfattributeReference', contains = 'list')
setClass('ListOfattributeReference', contains = 'list')
setClass('ConstraintBaseGroup', slots = c('constraintName' = 'character', 'constraintDescription' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('key', slots = c('attributeReference' = 'ListOfattributeReference'), contains = c('eml-2.1.1')) ## A
setClass('cardinality', slots = c('parentOccurences' = 'character', 'childOccurences' = 'CardinalityChildOccurancesType'), contains = c('eml-2.1.1')) ## A
setClass('ForeignKeyGroup', slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'key', 'entityReference' = 'character', 'relationshipType' = 'character', 'cardinality' = 'cardinality'), contains = c('eml-2.1.1')) ## A
setClass('key', slots = c('attributeReference' = 'ListOfattributeReference'), contains = c('eml-2.1.1')) ## A
setClass('primaryKey', slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('key', slots = c('attributeReference' = 'ListOfattributeReference'), contains = c('eml-2.1.1')) ## A
setClass('uniqueKey', slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('checkConstraint', slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'checkCondition' = 'character', 'language' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('foreignKey', slots = c('ForeignKeyGroup' = 'ForeignKeyGroup'), contains = c('eml-2.1.1')) ## A
setClass('referencedKey', slots = c('attributeReference' = 'ListOfattributeReference'), contains = c('eml-2.1.1')) ## A
setClass('joinCondition', slots = c('ForeignKeyGroup' = 'ForeignKeyGroup', 'referencedKey' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('key', slots = c('attributeReference' = 'ListOfattributeReference'), contains = c('eml-2.1.1')) ## A
setClass('notNullConstraint', slots = c('ConstraintBaseGroup' = 'ConstraintBaseGroup', 'key' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('ConstraintType', slots = c('primaryKey' = 'character', 'uniqueKey' = 'character', 'checkConstraint' = 'character', 'foreignKey' = 'character', 'joinCondition' = 'character', 'notNullConstraint' = 'character', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('CardinalityChildOccurancesType', contains = c('character')) ## B
setClass('constraintName', contains = c('character')) ## B
setClass('constraintDescription', contains = c('character')) ## B
setClass('attributeReference', contains = c('character')) ## B
setClass('entityReference', contains = c('character')) ## B
setClass('relationshipType', contains = c('character')) ## B
setClass('parentOccurences', contains = c('xs:integer')) ## B
setClass('childOccurences', contains = c('CardinalityChildOccurancesType')) ## B
setClass('attributeReference', contains = c('character')) ## B
setClass('attributeReference', contains = c('character')) ## B
setClass('checkCondition', contains = c('character')) ## B
setClass('attributeReference', contains = c('character')) ## B
setClass('attributeReference', contains = c('character')) ## B


#####  inst/xsd/eml-literature.xsd  ####


setClass('ListOfcontact', contains = 'list')
setClass('ListOfeditor', contains = 'list')
setClass('ListOfinstitution', contains = 'list')
setClass('ListOfrecipient', contains = 'list')
setClass('ListOfgeographicCoverage', contains = 'list')
setClass('ListOfpublicationPlace', contains = 'list')
setClass('ListOfperformer', contains = 'list')
setClass('CitationType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'ResourceGroup' = 'ResourceGroup', 'contact' = 'ListOfcontact', 'article' = 'Article', 'book' = 'Book', 'chapter' = 'Chapter', 'editedBook' = 'Book', 'manuscript' = 'Manuscript', 'report' = 'Report', 'thesis' = 'Thesis', 'conferenceProceedings' = 'ConferenceProceedings', 'personalCommunication' = 'PersonalCommunication', 'map' = 'Map', 'generic' = 'Generic', 'audioVisual' = 'AudioVisual', 'presentation' = 'Presentation', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('Article', slots = c('journal' = 'character', 'volume' = 'character', 'issue' = 'character', 'pageRange' = 'character', 'publisher' = 'ResponsibleParty', 'publicationPlace' = 'character', 'ISSN' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Book', slots = c('publisher' = 'ResponsibleParty', 'publicationPlace' = 'character', 'edition' = 'character', 'volume' = 'character', 'numberOfVolumes' = 'character', 'totalPages' = 'character', 'totalFigures' = 'character', 'totalTables' = 'character', 'ISBN' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Chapter', slots = c('chapterNumber' = 'character', 'editor' = 'ListOfeditor', 'bookTitle' = 'character', 'pageRange' = 'character'), contains = c('Book', 'eml-2.1.1')) ## A
setClass('ConferenceProceedings', slots = c('conferenceName' = 'character', 'conferenceDate' = 'character', 'conferenceLocation' = 'Address'), contains = c('Chapter', 'eml-2.1.1')) ## A
setClass('Manuscript', slots = c('institution' = 'ListOfinstitution', 'totalPages' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Report', slots = c('reportNumber' = 'character', 'publisher' = 'ResponsibleParty', 'publicationPlace' = 'character', 'totalPages' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('PersonalCommunication', slots = c('publisher' = 'ResponsibleParty', 'publicationPlace' = 'character', 'communicationType' = 'character', 'recipient' = 'ListOfrecipient'), contains = c('eml-2.1.1')) ## A
setClass('Map', slots = c('publisher' = 'ResponsibleParty', 'edition' = 'character', 'geographicCoverage' = 'ListOfgeographicCoverage', 'scale' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('AudioVisual', slots = c('publisher' = 'ResponsibleParty', 'publicationPlace' = 'ListOfpublicationPlace', 'performer' = 'ListOfperformer', 'ISBN' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Generic', slots = c('publisher' = 'ResponsibleParty', 'publicationPlace' = 'character', 'referenceType' = 'character', 'volume' = 'character', 'numberOfVolumes' = 'character', 'totalPages' = 'character', 'totalFigures' = 'character', 'totalTables' = 'character', 'edition' = 'character', 'originalPublication' = 'character', 'reprintEdition' = 'character', 'reviewedItem' = 'character', 'ISBN' = 'character', 'ISSN' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Thesis', slots = c('degree' = 'character', 'institution' = 'ResponsibleParty', 'totalPages' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Presentation', slots = c('conferenceName' = 'character', 'conferenceDate' = 'character', 'conferenceLocation' = 'Address'), contains = c('eml-2.1.1')) ## A
setClass('citation', contains = c('CitationType')) ## B
setClass('contact', contains = c('ResponsibleParty')) ## B
setClass('article', contains = c('Article')) ## B
setClass('book', contains = c('Book')) ## B
setClass('chapter', contains = c('Chapter')) ## B
setClass('editedBook', contains = c('Book')) ## B
setClass('manuscript', contains = c('Manuscript')) ## B
setClass('report', contains = c('Report')) ## B
setClass('thesis', contains = c('Thesis')) ## B
setClass('conferenceProceedings', contains = c('ConferenceProceedings')) ## B
setClass('personalCommunication', contains = c('PersonalCommunication')) ## B
setClass('map', contains = c('Map')) ## B
setClass('generic', contains = c('Generic')) ## B
setClass('audioVisual', contains = c('AudioVisual')) ## B
setClass('presentation', contains = c('Presentation')) ## B
setClass('journal', contains = c('character')) ## B
setClass('volume', contains = c('character')) ## B
setClass('issue', contains = c('character')) ## B
setClass('pageRange', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('ISSN', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('edition', contains = c('character')) ## B
setClass('volume', contains = c('character')) ## B
setClass('numberOfVolumes', contains = c('character')) ## B
setClass('totalPages', contains = c('character')) ## B
setClass('totalFigures', contains = c('character')) ## B
setClass('totalTables', contains = c('character')) ## B
setClass('ISBN', contains = c('character')) ## B
setClass('chapterNumber', contains = c('character')) ## B
setClass('editor', contains = c('ResponsibleParty')) ## B
setClass('bookTitle', contains = c('character')) ## B
setClass('pageRange', contains = c('character')) ## B
setClass('conferenceName', contains = c('character')) ## B
setClass('conferenceDate', contains = c('character')) ## B
setClass('conferenceLocation', contains = c('Address')) ## B
setClass('institution', contains = c('ResponsibleParty')) ## B
setClass('totalPages', contains = c('character')) ## B
setClass('reportNumber', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('totalPages', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('communicationType', contains = c('character')) ## B
setClass('recipient', contains = c('ResponsibleParty')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('edition', contains = c('character')) ## B

setClass('scale', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('performer', contains = c('ResponsibleParty')) ## B
setClass('ISBN', contains = c('character')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('publicationPlace', contains = c('character')) ## B
setClass('referenceType', contains = c('character')) ## B
setClass('volume', contains = c('character')) ## B
setClass('numberOfVolumes', contains = c('character')) ## B
setClass('totalPages', contains = c('character')) ## B
setClass('totalFigures', contains = c('character')) ## B
setClass('totalTables', contains = c('character')) ## B
setClass('edition', contains = c('character')) ## B
setClass('originalPublication', contains = c('character')) ## B
setClass('reprintEdition', contains = c('character')) ## B
setClass('reviewedItem', contains = c('character')) ## B
setClass('ISBN', contains = c('character')) ## B
setClass('ISSN', contains = c('character')) ## B
setClass('degree', contains = c('character')) ## B
setClass('institution', contains = c('ResponsibleParty')) ## B
setClass('totalPages', contains = c('character')) ## B
setClass('conferenceName', contains = c('character')) ## B
setClass('conferenceDate', contains = c('character')) ## B
setClass('conferenceLocation', contains = c('Address')) ## B


#####  inst/xsd/eml-coverage.xsd  ####


setClass('ListOfgeographicCoverage', contains = 'list')
setClass('ListOftemporalCoverage', contains = 'list')
setClass('ListOftaxonomicCoverage', contains = 'list')
setClass('ListOfsingleDateTime', contains = 'list')
setClass('ListOftimeScaleCitation', contains = 'list')
setClass('ListOfgRingPoint', contains = 'list')
setClass('ListOfgRingPoint', contains = 'list')
setClass('ListOfdatasetGPolygonExclusionGRing', contains = 'list')
setClass('ListOfdatasetGPolygon', contains = 'list')
setClass('ListOforiginator', contains = 'list')
setClass('ListOfclassificationSystem', contains = 'list')
setClass('ListOfidentificationReference', contains = 'list')
setClass('ListOfidentifierName', contains = 'list')
setClass('ListOfvouchers', contains = 'list')
setClass('ListOftaxonomicClassification', contains = 'list')
setClass('ListOfcommonName', contains = 'list')
setClass('ListOftaxonomicClassification', contains = 'list')


setClass('Coverage', slots = c('ReferencesGroup' = 'ReferencesGroup', 'geographicCoverage' = 'ListOfgeographicCoverage', 'temporalCoverage' = 'ListOftemporalCoverage', 'taxonomicCoverage' = 'ListOftaxonomicCoverage', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('rangeOfDates', slots = c('beginDate' = 'SingleDateTimeType', 'endDate' = 'SingleDateTimeType'), contains = c('eml-2.1.1')) ## A
setClass('TemporalCoverage', slots = c('ReferencesGroup' = 'ReferencesGroup', 'singleDateTime' = 'ListOfsingleDateTime', 'rangeOfDates' = 'rangeOfDates', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('alternativeTimeScale', slots = c('timeScaleName' = 'character', 'timeScaleAgeEstimate' = 'character', 'timeScaleAgeUncertainty' = 'character', 'timeScaleAgeExplanation' = 'character', 'timeScaleCitation' = 'ListOftimeScaleCitation'), contains = c('eml-2.1.1')) ## A
setClass('SingleDateTimeType', slots = c('alternativeTimeScale' = 'character', 'calendarDate' = 'yearDate', 'time' = 'xs:time'), contains = c('eml-2.1.1')) ## A
setClass('boundingAltitudes', slots = c('altitudeMinimum' = 'xs:decimal', 'altitudeMaximum' = 'xs:decimal', 'altitudeUnits' = 'LengthUnitType'), contains = c('eml-2.1.1')) ## A
setClass('boundingCoordinates', slots = c('westBoundingCoordinate' = 'character', 'eastBoundingCoordinate' = 'character', 'northBoundingCoordinate' = 'character', 'southBoundingCoordinate' = 'character', 'boundingAltitudes' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('datasetGPolygonOuterGRing', slots = c('gRing' = 'GRingType', 'gRingPoint' = 'ListOfgRingPoint'), contains = c('eml-2.1.1')) ## A
setClass('datasetGPolygonExclusionGRing', slots = c('gRingPoint' = 'ListOfgRingPoint', 'gRing' = 'GRingType'), contains = c('eml-2.1.1')) ## A
setClass('datasetGPolygon', slots = c('datasetGPolygonOuterGRing' = 'character', 'datasetGPolygonExclusionGRing' = 'ListOfdatasetGPolygonExclusionGRing'), contains = c('eml-2.1.1')) ## A
setClass('GeographicCoverage', slots = c('ReferencesGroup' = 'ReferencesGroup', 'geographicDescription' = 'character', 'boundingCoordinates' = 'boundingCoordinates', 'datasetGPolygon' = 'ListOfdatasetGPolygon', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('GRingPointType', slots = c('gRingLatitude' = 'character', 'gRingLongitude' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('classificationSystem', slots = c('classificationSystemCitation' = 'CitationType', 'classificationSystemModifications' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('repository', slots = c('originator' = 'ListOforiginator'), contains = c('eml-2.1.1')) ## A
setClass('vouchers', slots = c('specimen' = 'character', 'repository' = 'repository'), contains = c('eml-2.1.1')) ## A
setClass('taxonomicSystem', slots = c('classificationSystem' = 'ListOfclassificationSystem', 'identificationReference' = 'ListOfidentificationReference', 'identifierName' = 'ListOfidentifierName', 'taxonomicProcedures' = 'character', 'taxonomicCompleteness' = 'character', 'vouchers' = 'ListOfvouchers'), contains = c('eml-2.1.1')) ## A
setClass('TaxonomicCoverage', slots = c('ReferencesGroup' = 'ReferencesGroup', 'taxonomicSystem' = 'taxonomicSystem', 'generalTaxonomicCoverage' = 'character', 'taxonomicClassification' = 'ListOftaxonomicClassification', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('TaxonomicClassificationType', slots = c('taxonRankName' = 'character', 'taxonRankValue' = 'character', 'commonName' = 'ListOfcommonName', 'taxonomicClassification' = 'ListOftaxonomicClassification'), contains = c('eml-2.1.1')) ## A
setClass('GRingType', contains = c('character')) ## B

setClass('singleDateTime', contains = c('SingleDateTimeType')) ## B
setClass('beginDate', contains = c('SingleDateTimeType')) ## B
setClass('endDate', contains = c('SingleDateTimeType')) ## B
setClass('timeScaleName', contains = c('character')) ## B
setClass('timeScaleAgeEstimate', contains = c('character')) ## B
setClass('timeScaleAgeUncertainty', contains = c('character')) ## B
setClass('timeScaleAgeExplanation', contains = c('character')) ## B
setClass('timeScaleCitation', contains = c('CitationType')) ## B
setClass('calendarDate', contains = c('yearDate')) ## B
setClass('time', contains = c('xs:time')) ## B
setClass('geographicDescription', contains = c('character')) ## B
setClass('westBoundingCoordinate', contains = c('xs:decimal')) ## B
setClass('eastBoundingCoordinate', contains = c('xs:decimal')) ## B
setClass('northBoundingCoordinate', contains = c('xs:decimal')) ## B
setClass('southBoundingCoordinate', contains = c('xs:decimal')) ## B
setClass('altitudeMinimum', contains = c('xs:decimal')) ## B
setClass('altitudeMaximum', contains = c('xs:decimal')) ## B
setClass('altitudeUnits', contains = c('LengthUnitType')) ## B
setClass('gRing', contains = c('GRingType')) ## B
setClass('gRingPoint', contains = c('GRingPointType')) ## B
setClass('gRingPoint', contains = c('GRingPointType')) ## B
setClass('gRing', contains = c('GRingType')) ## B
setClass('gRingLatitude', contains = c('xs:decimal')) ## B
setClass('gRingLongitude', contains = c('xs:decimal')) ## B
setClass('classificationSystemCitation', contains = c('CitationType')) ## B
setClass('classificationSystemModifications', contains = c('character')) ## B
setClass('identificationReference', contains = c('CitationType')) ## B
setClass('identifierName', contains = c('ResponsibleParty')) ## B
setClass('taxonomicProcedures', contains = c('character')) ## B
setClass('taxonomicCompleteness', contains = c('character')) ## B
setClass('specimen', contains = c('character')) ## B
setClass('originator', contains = c('ResponsibleParty')) ## B
setClass('generalTaxonomicCoverage', contains = c('character')) ## B
setClass('taxonomicClassification', contains = c('TaxonomicClassificationType')) ## B
setClass('taxonRankName', contains = c('character')) ## B
setClass('taxonRankValue', contains = c('character')) ## B
setClass('commonName', contains = c('character')) ## B
setClass('taxonomicClassification', contains = c('TaxonomicClassificationType')) ## B


#####  inst/xsd/eml-physical.xsd  ####


setClass('ListOffieldDelimiter', contains = 'list')
setClass('ListOfquoteCharacter', contains = 'list')
setClass('ListOfliteralCharacter', contains = 'list')
setClass('ListOfquoteCharacter', contains = 'list')
setClass('ListOfliteralCharacter', contains = 'list')
setClass('ListOftextFixed', contains = 'list')
setClass('ListOftextDelimited', contains = 'list')
setClass('ListOfrecordDelimiter', contains = 'list')
setClass('ListOfphysicalLineDelimiter', contains = 'list')
setClass('ListOfcompressionMethod', contains = 'list')
setClass('ListOfencodingMethod', contains = 'list')
setClass('ListOfauthentication', contains = 'list')
setClass('ListOfdistribution', contains = 'list')
setClass('size', slots = c('unit' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('authentication', slots = c('method' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('simpleDelimited', slots = c('fieldDelimiter' = 'ListOffieldDelimiter', 'collapseDelimiters' = 'character', 'quoteCharacter' = 'ListOfquoteCharacter', 'literalCharacter' = 'ListOfliteralCharacter'), contains = c('eml-2.1.1')) ## A
setClass('textFixed', slots = c('fieldWidth' = 'xs:unsignedLong', 'lineNumber' = 'xs:unsignedLong', 'fieldStartColumn' = 'xs:long'), contains = c('eml-2.1.1')) ## A
setClass('textDelimited', slots = c('fieldDelimiter' = 'character', 'collapseDelimiters' = 'character', 'lineNumber' = 'xs:unsignedLong', 'quoteCharacter' = 'ListOfquoteCharacter', 'literalCharacter' = 'ListOfliteralCharacter'), contains = c('eml-2.1.1')) ## A
setClass('eml:complex', slots = c('textFixed' = 'ListOftextFixed', 'textDelimited' = 'ListOftextDelimited'), contains = c('eml-2.1.1')) ## A
setClass('textFormat', slots = c('numHeaderLines' = 'xs:int', 'numFooterLines' = 'xs:int', 'recordDelimiter' = 'ListOfrecordDelimiter', 'physicalLineDelimiter' = 'ListOfphysicalLineDelimiter', 'numPhysicalLinesPerRecord' = 'xs:unsignedInt', 'maxRecordLength' = 'xs:unsignedLong', 'attributeOrientation' = 'character', 'simpleDelimited' = 'character', 'complex' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('externallyDefinedFormat', slots = c('formatName' = 'character', 'formatVersion' = 'character', 'citation' = 'CitationType'), contains = c('eml-2.1.1')) ## A
setClass('multiBand', slots = c('nbands' = 'xs:int', 'layout' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('binaryRasterFormat', slots = c('rowColumnOrientation' = 'character', 'multiBand' = 'multiBand', 'nbits' = 'xs:int', 'byteorder' = 'character', 'skipbytes' = 'character', 'bandrowbytes' = 'character', 'totalrowbytes' = 'character', 'bandgapbytes' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('dataFormat', slots = c('textFormat' = 'character', 'externallyDefinedFormat' = 'character', 'binaryRasterFormat' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('PhysicalType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'objectName' = 'character', 'size' = 'character', 'authentication' = 'ListOfauthentication', 'characterEncoding' = 'character', 'dataFormat' = 'dataFormat', 'distribution' = 'ListOfdistribution', 'compressionMethod' = 'ListOfcompressionMethod', 'encodingMethod' = 'ListOfencodingMethod', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('PhysicalDistributionType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'access' = 'AccessType', 'online' = 'PhysicalOnlineType', 'offline' = 'OfflineType', 'inline' = 'InlineType', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('PhysicalOnlineType', slots = c('onlineDescription' = 'character', 'url' = 'UrlType', 'connection' = 'ConnectionType'), contains = c('eml-2.1.1')) ## A
setClass('physical', contains = c('PhysicalType')) ## B
setClass('objectName', contains = c('character')) ## B
setClass('characterEncoding', contains = c('character')) ## B
setClass('numHeaderLines', contains = c('xs:int')) ## B
setClass('numFooterLines', contains = c('xs:int')) ## B
setClass('recordDelimiter', contains = c('character')) ## B
setClass('physicalLineDelimiter', contains = c('character')) ## B
setClass('numPhysicalLinesPerRecord', contains = c('xs:unsignedInt')) ## B
setClass('maxRecordLength', contains = c('xs:unsignedLong')) ## B
setClass('attributeOrientation', contains = c('character')) ## B
setClass('fieldDelimiter', contains = c('character')) ## B
setClass('collapseDelimiters', contains = c('character')) ## B
setClass('quoteCharacter', contains = c('character')) ## B
setClass('literalCharacter', contains = c('character')) ## B
setClass('fieldWidth', contains = c('xs:unsignedLong')) ## B
setClass('lineNumber', contains = c('xs:unsignedLong')) ## B
setClass('fieldStartColumn', contains = c('xs:long')) ## B
setClass('fieldDelimiter', contains = c('character')) ## B
setClass('collapseDelimiters', contains = c('character')) ## B
setClass('lineNumber', contains = c('xs:unsignedLong')) ## B
setClass('quoteCharacter', contains = c('character')) ## B
setClass('literalCharacter', contains = c('character')) ## B
setClass('formatName', contains = c('character')) ## B
setClass('formatVersion', contains = c('character')) ## B
setClass('citation', contains = c('CitationType')) ## B
setClass('rowColumnOrientation', contains = c('character')) ## B
setClass('nbands', contains = c('xs:int')) ## B
setClass('layout', contains = c('character')) ## B
setClass('nbits', contains = c('xs:int')) ## B
setClass('byteorder', contains = c('character')) ## B
setClass('skipbytes', contains = c('character')) ## B
setClass('bandrowbytes', contains = c('character')) ## B
setClass('totalrowbytes', contains = c('character')) ## B
setClass('bandgapbytes', contains = c('character')) ## B
setClass('distribution', contains = c('PhysicalDistributionType')) ## B
setClass('compressionMethod', contains = c('character')) ## B
setClass('encodingMethod', contains = c('character')) ## B
setClass('access', contains = c('AccessType')) ## B
setClass('online', contains = c('PhysicalOnlineType')) ## B
setClass('offline', contains = c('OfflineType')) ## B
setClass('inline', contains='character')
setClass('onlineDescription', contains = c('character')) ## B
setClass('url', contains = c('UrlType')) ## B
setClass('connection', contains = c('ConnectionType')) ## B


#####  inst/xsd/eml-project.xsd  ####


setClass('ListOfrole', contains = 'list')
setClass('ListOfdescriptorValue', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOfdescriptor', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOfcoverage', contains = 'list')
setClass('ListOfdescription', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOftitle', contains = 'list')
setClass('ListOfpersonnel', contains = 'list')
setClass('ListOfrelatedProject', contains = 'list')
setClass('personnel', slots = c('role' = 'ListOfrole'), contains = c('ResponsibleParty', 'eml-2.1.1')) ## A
setClass('descriptorValue', slots = c('name_or_id' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('descriptor', slots = c('descriptorValue' = 'ListOfdescriptorValue', 'citation' = 'ListOfcitation', 'name' = 'xml_attribute', 'citableClassificationSystem' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('studyAreaDescription', slots = c('descriptor' = 'ListOfdescriptor', 'citation' = 'ListOfcitation', 'coverage' = 'ListOfcoverage'), contains = c('eml-2.1.1')) ## A
setClass('designDescription', slots = c('description' = 'ListOfdescription', 'citation' = 'ListOfcitation'), contains = c('eml-2.1.1')) ## A
setClass('ResearchProjectType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'title' = 'ListOftitle', 'personnel' = 'ListOfpersonnel', 'abstract' = 'TextType', 'funding' = 'TextType', 'studyAreaDescription' = 'studyAreaDescription', 'designDescription' = 'designDescription', 'relatedProject' = 'ListOfrelatedProject', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('DescriptorType', contains = c('character')) ## B
setClass('researchProject', contains = c('ResearchProjectType')) ## B
setClass('title', contains = c('character')) ## B
setClass('role', contains = c('RoleType')) ## B
setClass('abstract', contains = c('TextType')) ## B
setClass('funding', contains = c('TextType')) ## B
setClass('citation', contains = c('CitationType')) ## B
setClass('citation', contains = c('CitationType')) ## B

setClass('description', contains = c('TextType')) ## B
setClass('citation', contains = c('CitationType')) ## B
setClass('relatedProject', contains = c('ResearchProjectType')) ## B


#####  inst/xsd/eml-software.xsd  ####


setClass('ListOfdistribution', contains = 'list')
setClass('ListOflanguage', contains = 'list')
setClass('ListOfoperatingSystem', contains = 'list')
setClass('ListOfmachineProcessor', contains = 'list')
setClass('ListOfprogrammingLanguage', contains = 'list')
setClass('ListOfdependency', contains = 'list')
setClass('ListOflicenseURL', contains = 'list')
setClass('ListOflicense', contains = 'list')
setClass('ListOfimplementation', contains = 'list')
setClass('ListOfdependency', contains = 'list')
setClass('dependency', slots = c('action' = 'Action', 'software' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('eml:language', slots = c('LanguageValue' = 'character', 'LanguageCodeStandard' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('implementation', slots = c('distribution' = 'ListOfdistribution', 'size' = 'character', 'language' = 'ListOflanguage', 'operatingSystem' = 'ListOfoperatingSystem', 'machineProcessor' = 'ListOfmachineProcessor', 'virtualMachine' = 'character', 'diskUsage' = 'character', 'runtimeMemoryUsage' = 'character', 'programmingLanguage' = 'ListOfprogrammingLanguage', 'checksum' = 'character', 'dependency' = 'ListOfdependency'), contains = c('eml-2.1.1')) ## A
setClass('SoftwareType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'ResourceGroup' = 'ResourceGroup', 'implementation' = 'ListOfimplementation', 'dependency' = 'ListOfdependency', 'version' = 'character', 'project' = 'ResearchProjectType', 'licenseURL' = 'ListOflicenseURL', 'license' = 'ListOflicense', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('Action', contains = c('character')) ## B
setClass('software', contains = c('SoftwareType')) ## B
setClass('action', contains = c('Action')) ## B
setClass('distribution', contains = c('PhysicalDistributionType')) ## B
setClass('size', contains = c('character')) ## B
setClass('LanguageValue', contains = c('character')) ## B
setClass('LanguageCodeStandard', contains = c('character')) ## B
setClass('operatingSystem', contains = c('character')) ## B
setClass('machineProcessor', contains = c('character')) ## B
setClass('virtualMachine', contains = c('character')) ## B
setClass('diskUsage', contains = c('character')) ## B
setClass('runtimeMemoryUsage', contains = c('character')) ## B
setClass('programmingLanguage', contains = c('character')) ## B
setClass('checksum', contains = c('character')) ## B
setClass('version', contains = c('character')) ## B
setClass('project', contains = c('ResearchProjectType')) ## B
setClass('licenseURL', contains = c('character')) ## B
setClass('license', contains = c('character')) ## B


#####  inst/xsd/eml-protocol.xsd  ####


setClass('ListOfproceduralStep', contains = 'list')
setClass('ProtocolType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'ResourceGroup' = 'ResourceGroup', 'proceduralStep' = 'ListOfproceduralStep', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A




#####  inst/xsd/eml-methods.xsd  ####


setClass('ListOfdataSource', contains = 'list')
setClass('ListOfcoverage', contains = 'list')
setClass('ListOfdescription', contains = 'list')
setClass('ListOfreferencedEntityId', contains = 'list')
setClass('ListOfcoverage', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOfmethodStep', contains = 'list')
setClass('ListOfsampling', contains = 'list')
setClass('ListOfqualityControl', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOfprotocol', contains = 'list')
setClass('ListOfinstrumentation', contains = 'list')
setClass('ListOfsoftware', contains = 'list')
setClass('ListOfsubStep', contains = 'list')

setClass('studyExtent', slots = c('coverage' = 'ListOfcoverage', 'description' = 'ListOfdescription'), contains = c('eml-2.1.1')) ## A
setClass('spatialSamplingUnits', slots = c('referencedEntityId' = 'ListOfreferencedEntityId', 'coverage' = 'ListOfcoverage'), contains = c('eml-2.1.1')) ## A
setClass('sampling', slots = c('studyExtent' = 'studyExtent', 'samplingDescription' = 'TextType', 'spatialSamplingUnits' = 'spatialSamplingUnits', 'citation' = 'ListOfcitation'), contains = c('eml-2.1.1')) ## A
setClass('MethodsType', slots = c('methodStep' = 'ListOfmethodStep', 'sampling' = 'ListOfsampling', 'qualityControl' = 'ListOfqualityControl'), contains = c('eml-2.1.1')) ## A
setClass('ProcedureStepType', slots = c('instrumentation' = 'ListOfinstrumentation', 'software' = 'ListOfsoftware', 'subStep' = 'ListOfsubStep', 'description' = 'TextType', 'citation' = 'ListOfcitation', 'protocol' = 'ListOfprotocol'), contains = c('eml-2.1.1')) ## A
setClass('methods', contains = c('MethodsType')) ## B


setClass('description', contains = c('TextType')) ## B
setClass('samplingDescription', contains = c('TextType')) ## B
setClass('referencedEntityId', contains = c('character')) ## B

setClass('citation', contains = c('CitationType')) ## B
setClass('qualityControl', contains = c('ProcedureStepType')) ## B
setClass('instrumentation', contains = c('character')) ## B
setClass('software', contains = c('SoftwareType')) ## B
setClass('subStep', contains = c('ProcedureStepType')) ## B
setClass('description', contains = c('TextType')) ## B
setClass('citation', contains = c('CitationType')) ## B



#####  inst/xsd/eml-attribute.xsd  ####


setClass('ListOfbounds', contains = 'list')
setClass('ListOfbounds', contains = 'list')
setClass('ListOfattribute', contains = 'list')
setClass('ListOfattributeLabel', contains = 'list')
setClass('ListOfstorageType', contains = 'list')
setClass('ListOfmissingValueCode', contains = 'list')
setClass('ListOfquantitativeAttributeAccuracyAssessment', contains = 'list')
setClass('ListOfcitation', contains = 'list')
setClass('ListOfcodesetURL', contains = 'list')
setClass('ListOfcodeDefinition', contains = 'list')
setClass('ListOfpattern', contains = 'list')
setClass('ListOfenumeratedDomain', contains = 'list')
setClass('ListOftextDomain', contains = 'list')
setClass('minimum', slots = c('exclusive' = 'xml_attribute'), contains = c('xs:float', 'eml-2.1.1')) ## A
setClass('maximum', slots = c('exclusive' = 'xml_attribute'), contains = c('xs:float', 'eml-2.1.1')) ## A
setClass('bounds', slots = c('minimum' = 'character', 'maximum' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('BoundsGroup', slots = c('bounds' = 'ListOfbounds'), contains = c('eml-2.1.1')) ## A
setClass('minimum', slots = c('exclusive' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('maximum', slots = c('exclusive' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('bounds', slots = c('minimum' = 'character', 'maximum' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('BoundsDateGroup', slots = c('bounds' = 'ListOfbounds'), contains = c('eml-2.1.1')) ## A
setClass('AttributeListType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'attribute' = 'ListOfattribute', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('storageType', slots = c('typeSystem' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('nominal', slots = c('nonNumericDomain' = 'NonNumericDomainType'), contains = c('eml-2.1.1')) ## A
setClass('ordinal', slots = c('nonNumericDomain' = 'NonNumericDomainType'), contains = c('eml-2.1.1')) ## A
setClass('interval', slots = c('unit' = 'UnitType', 'precision' = 'PrecisionType', 'numericDomain' = 'NumericDomainType'), contains = c('eml-2.1.1')) ## A
setClass('ratio', slots = c('unit' = 'UnitType', 'precision' = 'PrecisionType', 'numericDomain' = 'NumericDomainType'), contains = c('eml-2.1.1')) ## A
setClass('dateTime', slots = c('formatString' = 'character', 'dateTimePrecision' = 'character', 'dateTimeDomain' = 'DateTimeDomainType'), contains = c('eml-2.1.1')) ## A
setClass('measurementScale', slots = c('nominal' = 'character', 'ordinal' = 'character', 'interval' = 'character', 'ratio' = 'character', 'dateTime' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('missingValueCode', slots = c('code' = 'character', 'codeExplanation' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('AttributeType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'attributeName' = 'character', 'attributeLabel' = 'ListOfattributeLabel', 'attributeDefinition' = 'character', 'storageType' = 'ListOfstorageType', 'measurementScale' = 'measurementScale', 'missingValueCode' = 'ListOfmissingValueCode', 'accuracy' = 'Accuracy', 'coverage' = 'Coverage', 'methods' = 'MethodsType', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('quantitativeAttributeAccuracyAssessment', slots = c('attributeAccuracyValue' = 'character', 'attributeAccuracyExplanation' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('Accuracy', slots = c('attributeAccuracyReport' = 'character', 'quantitativeAttributeAccuracyAssessment' = 'ListOfquantitativeAttributeAccuracyAssessment'), contains = c('eml-2.1.1')) ## A
setClass('UnitType', slots = c('standardUnit' = 'StandardUnitDictionary', 'customUnit' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('codeDefinition', slots = c('code' = 'character', 'definition' = 'character', 'source' = 'character', 'order' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('externalCodeSet', slots = c('codesetName' = 'character', 'citation' = 'ListOfcitation', 'codesetURL' = 'ListOfcodesetURL'), contains = c('eml-2.1.1')) ## A
setClass('entityCodeList', slots = c('entityReference' = 'character', 'valueAttributeReference' = 'character', 'definitionAttributeReference' = 'character', 'orderAttributeReference' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('enumeratedDomain', slots = c('codeDefinition' = 'ListOfcodeDefinition', 'externalCodeSet' = 'character', 'entityCodeList' = 'character', 'enforced' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('textDomain', slots = c('definition' = 'character', 'pattern' = 'ListOfpattern', 'source' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('NonNumericDomainType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'enumeratedDomain' = 'ListOfenumeratedDomain', 'textDomain' = 'ListOftextDomain', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('NumericDomainType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'BoundsGroup' = 'BoundsGroup', 'numberType' = 'NumberType', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('DateTimeDomainType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'BoundsDateGroup' = 'BoundsDateGroup', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('NumberType', contains = c('character')) ## B
setClass('attribute', contains = c('AttributeType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('attribute', contains = c('AttributeType')) ## B
setClass('attributeName', contains = c('character')) ## B
setClass('attributeLabel', contains = c('character')) ## B
setClass('attributeDefinition', contains = c('character')) ## B
setClass('nonNumericDomain', contains = c('NonNumericDomainType')) ## B
setClass('nonNumericDomain', contains = c('NonNumericDomainType')) ## B
setClass('unit', contains = c('UnitType')) ## B
setClass('precision', contains = c('PrecisionType')) ## B
setClass('numericDomain', contains = c('NumericDomainType')) ## B
setClass('unit', contains = c('UnitType')) ## B
setClass('precision', contains = c('PrecisionType')) ## B
setClass('numericDomain', contains = c('NumericDomainType')) ## B
setClass('formatString', contains = c('character')) ## B
setClass('dateTimePrecision', contains = c('character')) ## B
setClass('dateTimeDomain', contains = c('DateTimeDomainType')) ## B
setClass('code', contains = c('character')) ## B
setClass('codeExplanation', contains = c('character')) ## B
setClass('accuracy', contains = c('Accuracy')) ## B

setClass('methods', contains = c('MethodsType')) ## B
setClass('attributeAccuracyReport', contains = c('character')) ## B
setClass('attributeAccuracyValue', contains = c('character')) ## B
setClass('attributeAccuracyExplanation', contains = c('character')) ## B
setClass('standardUnit', contains = c('StandardUnitDictionary')) ## B
setClass('customUnit', contains = c('character')) ## B
setClass('PrecisionType', contains = c('xs:float')) ## B
setClass('code', contains = c('character')) ## B
setClass('definition', contains = c('character')) ## B
setClass('source', contains = c('character')) ## B
setClass('codesetName', contains = c('character')) ## B
setClass('citation', contains = c('CitationType')) ## B
setClass('codesetURL', contains = c('xs:anyURI')) ## B
setClass('entityReference', contains = c('character')) ## B
setClass('valueAttributeReference', contains = c('character')) ## B
setClass('definitionAttributeReference', contains = c('character')) ## B
setClass('orderAttributeReference', contains = c('character')) ## B
setClass('definition', contains = c('character')) ## B
setClass('pattern', contains = c('character')) ## B
setClass('source', contains = c('character')) ## B
setClass('numberType', contains = c('NumberType')) ## B


#####  inst/xsd/eml-entity.xsd  ####


setClass('ListOfalternateIdentifier', contains = 'list')
setClass('ListOfphysical', contains = 'list')
setClass('ListOfadditionalInfo', contains = 'list')
setClass('ListOfconstraint', contains = 'list')
setClass('alternateIdentifier', slots = c('system' = 'xml_attribute'), contains = c('character', 'eml-2.1.1')) ## A
setClass('EntityGroup', slots = c('alternateIdentifier' = 'ListOfalternateIdentifier', 'entityName' = 'character', 'entityDescription' = 'character', 'physical' = 'ListOfphysical', 'coverage' = 'Coverage', 'methods' = 'MethodsType', 'additionalInfo' = 'ListOfadditionalInfo'), contains = c('eml-2.1.1')) ## A
setClass('OtherEntityType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'entityType' = 'character', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('otherEntity', contains = c('OtherEntityType')) ## B
setClass('entityName', contains = c('character')) ## B
setClass('entityDescription', contains = c('character')) ## B
setClass('physical', contains = c('PhysicalType')) ## B

setClass('methods', contains = c('MethodsType')) ## B
setClass('additionalInfo', contains = c('TextType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('entityType', contains = c('character')) ## B


#####  inst/xsd/eml-dataTable.xsd  ####


setClass('ListOfconstraint', contains = 'list')
setClass('DataTableType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'caseSensitive' = 'character', 'numberOfRecords' = 'character', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('dataTable', contains = c('DataTableType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('caseSensitive', contains = c('character')) ## B
setClass('numberOfRecords', contains = c('character')) ## B


#####  inst/xsd/eml-view.xsd  ####


setClass('ListOfconstraint', contains = 'list')
setClass('ViewType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'queryStatement' = 'character', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('view', contains = c('ViewType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('queryStatement', contains = c('character')) ## B


#####  inst/xsd/eml-storedProcedure.xsd  ####


setClass('ListOfconstraint', contains = 'list')
setClass('ListOfparameter', contains = 'list')
setClass('StoredProcedureType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'parameter' = 'ListOfparameter', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('ParameterType', slots = c('name' = 'character', 'domainDescription' = 'character', 'required' = 'xs:boolean', 'repeats' = 'xs:boolean'), contains = c('eml-2.1.1')) ## A
setClass('storedProcedure', contains = c('StoredProcedureType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('parameter', contains = c('ParameterType')) ## B
setClass('eml:name', contains = c('character')) ## B
setClass('domainDescription', contains = c('character')) ## B
setClass('required', contains = c('xs:boolean')) ## B
setClass('repeats', contains = c('xs:boolean')) ## B


#####  inst/xsd/eml-spatialVector.xsd  ####


setClass('ListOfconstraint', contains = 'list')
setClass('ListOfgeometry', contains = 'list')
setClass('ListOfquantitativeAccuracyReport', contains = 'list')
setClass('SpatialVectorType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'geometry' = 'ListOfgeometry', 'geometricObjectCount' = 'character', 'topologyLevel' = 'TopologyLevel', 'spatialReference' = 'SpatialReferenceType', 'horizontalAccuracy' = 'DataQuality', 'verticalAccuracy' = 'DataQuality', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('quantitativeAccuracyReport', slots = c('quantitativeAccuracyValue' = 'character', 'quantitativeAccuracyMethod' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('DataQuality', slots = c('accuracyReport' = 'character', 'quantitativeAccuracyReport' = 'ListOfquantitativeAccuracyReport'), contains = c('eml-2.1.1')) ## A
setClass('GeometryType', contains = c('character')) ## B
setClass('TopologyLevel', contains = c('character')) ## B
setClass('spatialVector', contains = c('SpatialVectorType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('geometry', contains = c('GeometryType')) ## B
setClass('geometricObjectCount', contains = c('character')) ## B
setClass('topologyLevel', contains = c('TopologyLevel')) ## B
setClass('spatialReference', contains = c('SpatialReferenceType')) ## B
setClass('horizontalAccuracy', contains = c('DataQuality')) ## B
setClass('verticalAccuracy', contains = c('DataQuality')) ## B
setClass('accuracyReport', contains = c('character')) ## B
setClass('quantitativeAccuracyValue', contains = c('character')) ## B
setClass('quantitativeAccuracyMethod', contains = c('character')) ## B


#####  inst/xsd/eml-spatialRaster.xsd  ####


setClass('ListOfcornerPoint', contains = 'list')
setClass('ListOfcontrolPoint', contains = 'list')
setClass('ListOfbandDescription', contains = 'list')
setClass('ListOfconstraint', contains = 'list')
setClass('ListOfquantitativeAccuracyReport', contains = 'list')
setClass('cornerPoint', slots = c('xCoordinate' = 'xs:float', 'yCoordinate' = 'xs:float', 'pointInPixel' = 'character', 'corner' = 'rasterOriginType'), contains = c('eml-2.1.1')) ## A
setClass('controlPoint', slots = c('column' = 'xs:int', 'row' = 'xs:int', 'xCoordinate' = 'xs:float', 'yCoordinate' = 'xs:float', 'pointInPixel' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('bilinearFit', slots = c('xIntercept' = 'xs:float', 'xSlope' = 'xs:float', 'yIntercept' = 'xs:float', 'ySlope' = 'xs:float'), contains = c('eml-2.1.1')) ## A
setClass('georeferenceInfo', slots = c('cornerPoint' = 'ListOfcornerPoint', 'controlPoint' = 'ListOfcontrolPoint', 'bilinearFit' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('imageDescription', slots = c('illuminationElevationAngle' = 'xs:float', 'illuminationAzimuthAngle' = 'xs:float', 'imageOrientationAngle' = 'xs:float', 'imagingCondition' = 'ImagingConditionCode', 'imageQualityCode' = 'character', 'cloudCoverPercentage' = 'xs:float', 'preProcessingTypeCode' = 'character', 'compressionGenerationQuality' = 'xs:integer', 'triangulationIndicator' = 'xs:boolean', 'radiometricDataAvailability' = 'xs:boolean', 'cameraCalibrationInformationAvailability' = 'xs:boolean', 'filmDistortionInformationAvailability' = 'xs:boolean', 'lensDistortionInformationAvailability' = 'xs:boolean', 'bandDescription' = 'ListOfbandDescription'), contains = c('eml-2.1.1')) ## A
setClass('SpatialRasterType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'EntityGroup' = 'EntityGroup', 'attributeList' = 'AttributeListType', 'constraint' = 'ListOfconstraint', 'spatialReference' = 'SpatialReferenceType', 'georeferenceInfo' = 'georeferenceInfo', 'horizontalAccuracy' = 'DataQuality', 'verticalAccuracy' = 'DataQuality', 'cellSizeXDirection' = 'character', 'cellSizeYDirection' = 'character', 'numberOfBands' = 'character', 'rasterOrigin' = 'rasterOriginType', 'rows' = 'character', 'columns' = 'character', 'verticals' = 'character', 'cellGeometry' = 'CellGeometryType', 'toneGradation' = 'xs:integer', 'scaleFactor' = 'character', 'offset' = 'character', 'imageDescription' = 'imageDescription', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('BandType', slots = c('sequenceIdentifier' = 'character', 'highWavelength' = 'xs:float', 'lowWaveLength' = 'xs:float', 'waveLengthUnits' = 'lengthUnits', 'peakResponse' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('quantitativeAccuracyReport', slots = c('quantitativeAccuracyValue' = 'character', 'quantitativeAccuracyMethod' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('DataQuality', slots = c('accuracyReport' = 'character', 'quantitativeAccuracyReport' = 'ListOfquantitativeAccuracyReport'), contains = c('eml-2.1.1')) ## A
setClass('CellValueType', contains = c('character')) ## B
setClass('ImagingConditionCode', contains = c('character')) ## B
setClass('rasterOriginType', contains = c('character')) ## B
setClass('CellGeometryType', contains = c('character')) ## B
setClass('spatialRaster', contains = c('SpatialRasterType')) ## B
setClass('attributeList', contains = c('AttributeListType')) ## B
setClass('constraint', contains = c('ConstraintType')) ## B
setClass('spatialReference', contains = c('SpatialReferenceType')) ## B
setClass('xCoordinate', contains = c('xs:float')) ## B
setClass('yCoordinate', contains = c('xs:float')) ## B
setClass('pointInPixel', contains = c('character')) ## B
setClass('corner', contains = c('rasterOriginType')) ## B
setClass('column', contains = c('xs:int')) ## B
setClass('row', contains = c('xs:int')) ## B
setClass('xCoordinate', contains = c('xs:float')) ## B
setClass('yCoordinate', contains = c('xs:float')) ## B
setClass('pointInPixel', contains = c('character')) ## B
setClass('xIntercept', contains = c('xs:float')) ## B
setClass('xSlope', contains = c('xs:float')) ## B
setClass('yIntercept', contains = c('xs:float')) ## B
setClass('ySlope', contains = c('xs:float')) ## B
setClass('horizontalAccuracy', contains = c('DataQuality')) ## B
setClass('verticalAccuracy', contains = c('DataQuality')) ## B
setClass('cellSizeXDirection', contains = c('character')) ## B
setClass('cellSizeYDirection', contains = c('character')) ## B
setClass('numberOfBands', contains = c('character')) ## B
setClass('rasterOrigin', contains = c('rasterOriginType')) ## B
setClass('rows', contains = c('character')) ## B
setClass('columns', contains = c('character')) ## B
setClass('verticals', contains = c('character')) ## B
setClass('cellGeometry', contains = c('CellGeometryType')) ## B
setClass('toneGradation', contains = c('xs:integer')) ## B
setClass('scaleFactor', contains = c('character')) ## B
setClass('offset', contains = c('character')) ## B
setClass('illuminationElevationAngle', contains = c('xs:float')) ## B
setClass('illuminationAzimuthAngle', contains = c('xs:float')) ## B
setClass('imageOrientationAngle', contains = c('xs:float')) ## B
setClass('imagingCondition', contains = c('ImagingConditionCode')) ## B
setClass('imageQualityCode', contains = c('character')) ## B
setClass('cloudCoverPercentage', contains = c('xs:float')) ## B
setClass('preProcessingTypeCode', contains = c('character')) ## B
setClass('compressionGenerationQuality', contains = c('xs:integer')) ## B
setClass('triangulationIndicator', contains = c('xs:boolean')) ## B
setClass('radiometricDataAvailability', contains = c('xs:boolean')) ## B
setClass('cameraCalibrationInformationAvailability', contains = c('xs:boolean')) ## B
setClass('filmDistortionInformationAvailability', contains = c('xs:boolean')) ## B
setClass('lensDistortionInformationAvailability', contains = c('xs:boolean')) ## B
setClass('bandDescription', contains = c('BandType')) ## B
setClass('sequenceIdentifier', contains = c('character')) ## B
setClass('highWavelength', contains = c('xs:float')) ## B
setClass('lowWaveLength', contains = c('xs:float')) ## B
setClass('waveLengthUnits', contains = c('lengthUnits')) ## B
setClass('peakResponse', contains = c('character')) ## B
setClass('accuracyReport', contains = c('character')) ## B
setClass('quantitativeAccuracyValue', contains = c('character')) ## B
setClass('quantitativeAccuracyMethod', contains = c('character')) ## B


#####  inst/xsd/eml-dataset.xsd  ####


setClass('ListOfdataTable', contains = 'list')
setClass('ListOfspatialRaster', contains = 'list')
setClass('ListOfspatialVector', contains = 'list')
setClass('ListOfstoredProcedure', contains = 'list')
setClass('ListOfview', contains = 'list')
setClass('ListOfotherEntity', contains = 'list')
setClass('ListOfcontact', contains = 'list')
setClass('ListOfchangeHistory', contains = 'list')
setClass('DatasetType', slots = c('ReferencesGroup' = 'ReferencesGroup', 'ResourceGroup' = 'ResourceGroup', 'purpose' = 'TextType', 'maintenance' = 'MaintenanceType', 'contact' = 'ListOfcontact', 'publisher' = 'ResponsibleParty', 'pubPlace' = 'character', 'methods' = 'MethodsType', 'project' = 'ResearchProjectType', 'dataTable' = 'ListOfdataTable', 'spatialRaster' = 'ListOfspatialRaster', 'spatialVector' = 'ListOfspatialVector', 'storedProcedure' = 'ListOfstoredProcedure', 'view' = 'ListOfview', 'otherEntity' = 'ListOfotherEntity', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('changeHistory', slots = c('changeScope' = 'character', 'oldValue' = 'character', 'changeDate' = 'xs:date', 'comment' = 'character'), contains = c('eml-2.1.1')) ## A
setClass('MaintenanceType', slots = c('description' = 'TextType', 'maintenanceUpdateFrequency' = 'MaintUpFreqType', 'changeHistory' = 'ListOfchangeHistory'), contains = c('eml-2.1.1')) ## A
setClass('MaintUpFreqType', contains = c('character')) ## B
setClass('dataset', contains = c('DatasetType')) ## B
setClass('purpose', contains = c('TextType')) ## B
setClass('maintenance', contains = c('MaintenanceType')) ## B
setClass('contact', contains = c('ResponsibleParty')) ## B
setClass('publisher', contains = c('ResponsibleParty')) ## B
setClass('pubPlace', contains = c('character')) ## B
setClass('methods', contains = c('MethodsType')) ## B
setClass('project', contains = c('ResearchProjectType')) ## B
setClass('dataTable', contains = c('DataTableType')) ## B
setClass('spatialRaster', contains = c('SpatialRasterType')) ## B
setClass('spatialVector', contains = c('SpatialVectorType')) ## B
setClass('storedProcedure', contains = c('StoredProcedureType')) ## B
setClass('view', contains = c('ViewType')) ## B
setClass('otherEntity', contains = c('OtherEntityType')) ## B
setClass('description', contains = c('TextType')) ## B
setClass('maintenanceUpdateFrequency', contains = c('MaintUpFreqType')) ## B
setClass('changeScope', contains = c('character')) ## B
setClass('oldValue', contains = c('character')) ## B
setClass('changeDate', contains = c('xs:date')) ## B
setClass('comment', contains = c('character')) ## B


#####  inst/xsd/eml.xsd  ####


setClass('ListOfdescribes', contains = 'list')
setClass('ListOfadditionalMetadata', contains = 'list')
setClass('additionalMetadata', slots = c('describes' = 'ListOfdescribes', 'metadata' = 'character', 'id' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('eml', slots = c('access' = 'AccessType', 'additionalMetadata' = 'ListOfadditionalMetadata', 'dataset' = 'DatasetType', 'citation' = 'CitationType', 'software' = 'SoftwareType', 'protocol' = 'ProtocolType', 'packageId' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute', 'xml:lang' = 'xml_attribute'), contains = c('eml-2.1.1')) ## A
setClass('access', contains = c('AccessType')) ## B
setClass('describes', contains = c('character')) ## B
setClass('metadata', contains = c('character')) ## B
setClass('dataset', contains = c('DatasetType')) ## B
setClass('citation', contains = c('CitationType')) ## B
setClass('software', contains = c('SoftwareType')) ## B


setClass('proceduralStep', contains = 'ProcedureStepType')
setClass('protocol', contains = 'ProtocolType')
setClass('dataSource', contains = 'DatasetType')
setClass('methodStep', slots = c('dataSource' = 'ListOfdataSource'), contains = c('ProcedureStepType', 'eml-2.1.1'))
setClass('temporalCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TemporalCoverage'))
setClass('taxonomicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TaxonomicCoverage'))
setClass('geographicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('GeographicCoverage'))
setClass('coverage', contains=c('Coverage'))

setClass('parameter', slots = c(name = 'character', value = 'character', 'domainDescription' = 'character', 'required' = 'logical', 'repeats' = 'logical'))
setClass('online', slots = c('onlineDescription' = 'character', 'url' = 'UrlType', 'connection' = 'ConnectionType', 'connectionDefinition' = 'ConnectionDefinitionType'), contains = c('eml-2.1.1'))
