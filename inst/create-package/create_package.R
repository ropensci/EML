library("EML") ## ick, create_methods actually uses true slots to get slots and contains slots

library("XML")
library("xml2")
library("purrr")
library("dplyr")

## Filepaths assume working directory is package root

source("inst/create-package/post_process.R")
source("inst/create-package/create_classes.R")
classes_file <- "R/classes.R"
methods_file <- "R/methods.R"
## Start clean
file.remove(classes_file)
file.remove(methods_file)




## Create some boilerplate classes:
xs_base_classes <- function(file = "R/classes.R", methods_file = "R/methods.R"){

  write("
setClass('slot_order', contains = 'character')
setClass('xml_attribute', contains = 'character')
setClass('eml-2.1.1', slots = c('schemaLocation' = 'xml_attribute', 'lang' = 'xml_attribute', slot_order = 'character'))
setClass('i18nNonEmptyStringType', slots = c('value' = 'ListOfvalue', 'lang' = 'xml_attribute'), contains = c('eml-2.1.1', 'character'))
setClass('InlineType', contains=c('list'))",
        file, append = TRUE)

  ## Define classes for the these XSD schema types to correspond to the appropriate R object class
  data.frame(class =    c("xs:float", "xs:string", "xs:anyURI", "xs:time", "xs:decimal", "xs:int", "xs:unsignedInt", "xs:unsignedLong", "xs:long", "xs:integer", "xs:boolean", "xs:date", "xs:positiveInteger"),
             contains = c("numeric", "character", "character", "character", "numeric", "integer", "integer", "integer", "integer", "integer", "logical", "Date", "integer")) %>%
    purrr::by_row(function(x)
      write(sprintf("setClass('%s', contains = '%s')", x[["class"]], x[["contains"]]), file, append = TRUE)
    )

}

xs_base_classes(classes_file)


## This call to create_classes needs to pass a custom namespace
#stmml_ns <- xml_ns_rename( xml_ns(read_xml("inst/xsd/stmml.xsd")), xsd = "xs")
#create_classes("inst/xsd/stmml.xsd", classes_file, methods_file, ns = stmml_ns)

## Collate list -- avoid errors by manually setting the order of XSD file parsing
collate <- c(
  "eml-text.xsd",
  "eml-documentation.xsd",
  "eml-unitTypeDefinitions.xsd",
  "eml-party.xsd",
  "eml-resource.xsd",
  "eml-spatialReference.xsd",
  "eml-access.xsd",
  "eml-constraint.xsd",
  "eml-literature.xsd",
  "eml-coverage.xsd",
  "eml-physical.xsd",
  "eml-project.xsd",
  "eml-software.xsd",
  "eml-protocol.xsd",
  "eml-methods.xsd",
  "eml-attribute.xsd",
  "eml-entity.xsd",
  "eml-dataTable.xsd",
  "eml-view.xsd",
  "eml-storedProcedure.xsd",
  "eml-spatialVector.xsd",
  "eml-spatialRaster.xsd",
  "eml-dataset.xsd",
  "eml.xsd"
)
## Okay, here we go! Create all the classes...
paste0("inst/xsd/", collate) %>% map(create_classes, cf = classes_file, mf = methods_file)

fix_protected(classes_file)


## Goodness grief, fix ordering so that classes can load with no errors or warning (dependent classes must be defined first!)

move_to_end("proceduralStep", classes_file)
move_to_end("methodStep", classes_file)
move_to_end("dataSource", classes_file)
replace_class("keyword", "setClass('keyword', slots = c('keywordType' = 'xml_attribute'), contains = c('i18nNonEmptyStringType', 'eml-2.1.1'))", classes_file)
replace_class("coverage", "setClass('coverage', contains=c('Coverage'))", classes_file)
replace_class("temporalCoverage", "setClass('temporalCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TemporalCoverage'))", classes_file)
replace_class("taxonomicCoverage", "setClass('taxonomicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TaxonomicCoverage'))", classes_file)
replace_class("geographicCoverage", "setClass('geographicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('GeographicCoverage'))", classes_file)
replace_class('size', "setClass('size', slots = c('character' = 'character', 'unit' = 'xml_attribute'), contains = c('eml-2.1.1', 'character'))", classes_file)
replace_class('metadata', "setClass('metadata', contains='InlineType')", classes_file)
replace_class('inline', "setClass('inline', contains='InlineType')", classes_file)
replace_class('InlineType', "setClass('InlineType', contains=c('list'))", classes_file)
replace_class('parameter', "setClass('parameter', slots = c(name = 'character', value = 'character', 'domainDescription' = 'character', 'required' = 'character', 'repeats' = 'character'))", classes_file)
replace_class('PhysicalOnlineType', "setClass('PhysicalOnlineType',  slots = c('onlineDescription' = 'i18nNonEmptyStringType', 'url' = 'UrlType', 'connection' = 'ConnectionType', 'connectionDefinition' = 'ConnectionDefinitionType'), contains = c('eml-2.1.1', 'character'))", classes_file)
replace_class('online', "setClass('online', contains = c('PhysicalOnlineType', 'OnlineType', 'eml-2.1.1'))", classes_file)
move_to_end("coverage", classes_file)
move_to_end("temporalCoverage", classes_file)
move_to_end("taxonomicCoverage", classes_file)
move_to_end("geographicCoverage", classes_file)
move_to_end("inline", classes_file)
move_to_end("parameter", classes_file)
move_to_end("online", classes_file)
move_to_end("metadata", classes_file)
move_to_end("additionalMetadata", classes_file)
move_up_n("UrlType", classes_file, 8)
move_up_n("schemeName", classes_file, 3)
move_up_n("ConnectionDefinitionType", classes_file, 4)
move_up_n("ConnectionType", classes_file, 5)
move_up_n("OfflineType", classes_file, 3)
move_up_n("OnlineType", classes_file, 3)
move_down_n("SpatialReferenceType", classes_file, 14)
move_down_n("foreignKey", classes_file, 10)
move_down_n("joinCondition", classes_file, 8)
move_down_n("ConstraintType", classes_file, 7)
move_up_n("CardinalityChildOccurancesType", classes_file, 12)
move_up_n("SingleDateTimeType", classes_file, 5)
move_up_n("alternativeTimeScale", classes_file, 5)
move_up_n("PhysicalOnlineType", classes_file, 2)
move_up_n("Action", classes_file, 6)
move_down_n("CitationType", classes_file, 14)
move_up_n("NonNumericDomainType", classes_file, 18)
move_up_n("NumericDomainType", classes_file, 18)
move_up_n("DateTimeDomainType", classes_file, 18)
move_up_n("UnitType", classes_file, 12)
move_up_n("BoundsGroup", classes_file, 25)
move_up_n("BoundsDateGroup", classes_file, 25)
move_down_n("AttributeType", classes_file, 3)
move_down_n("OtherEntityType", classes_file, 2)
move_down_n("SpatialVectorType", classes_file, 2)
move_down_n("DatasetType", classes_file, 2)
move_to_top("MaintUpFreqType", classes_file)
move_to_top("CellGeometryType", classes_file)
move_to_top("ImagingConditionCode", classes_file)
move_to_top("GeometryType", classes_file)
move_to_top("TopologyLevel", classes_file)
move_to_top("NumberType", classes_file)
move_to_top("PrecisionType", classes_file)
move_to_top("GRingType", classes_file)
move_to_top("ConstraintBaseGroup", classes_file)
move_to_top("constraintDescription", classes_file)
move_to_top("Coverage", classes_file)
move_to_top("ListOftaxonomicCoverage", classes_file)
move_to_top("ListOfgeographicCoverage", classes_file)
move_to_top("ListOftemporalCoverage", classes_file)
move_to_top("ReferencesGroup", classes_file)
move_to_top("references", classes_file)
move_to_top("ListOfvalue", classes_file)
move_to_top("eml-2.1.1", classes_file)
move_to_top("xml_attribute", classes_file)



R <- readLines(classes_file)
R <- gsub("'language' = 'i18nNonEmptyStringType'", "'language' = 'character'", R)
R <- gsub("setClass\\('title', contains = c\\('eml-2.1.1', 'character'\\)\\).*", "", R)
## Consistent Ordering please
R <- gsub("contains = c\\('character', 'eml-2.1.1'\\)", "contains = c('eml-2.1.1', 'character')", R)

## avoid ReferencesGroup as separate class.
R <- gsub("'ReferencesGroup' = 'ReferencesGroup'", "'references' = 'references'", R)
resource_group_slots <- "'alternateIdentifier' = 'ListOfalternateIdentifier', 'shortName' = 'character', 'title' = 'ListOftitle', 'creator' = 'ListOfcreator', 'metadataProvider' = 'ListOfmetadataProvider', 'associatedParty' = 'ListOfassociatedParty', 'pubDate' = 'yearDate', 'language' = 'character', 'series' = 'character', 'abstract' = 'TextType', 'keywordSet' = 'ListOfkeywordSet', 'additionalInfo' = 'ListOfadditionalInfo', 'intellectualRights' = 'TextType', 'distribution' = 'ListOfdistribution', 'coverage' = 'Coverage'"
R <- gsub("'ResourceGroup' = 'ResourceGroup'", resource_group_slots, R)
entity_group_slots <- "'alternateIdentifier' = 'ListOfalternateIdentifier', 'entityName' = 'character', 'entityDescription' = 'character', 'physical' = 'ListOfphysical', 'coverage' = 'Coverage', 'methods' = 'MethodsType', 'additionalInfo' = 'ListOfadditionalInfo'"
R <- gsub("'EntityGroup' = 'EntityGroup'", entity_group_slots, R)
responsible_party_slots = "'individualName' = 'ListOfindividualName', 'organizationName' = 'ListOforganizationName', 'positionName' = 'ListOfpositionName', 'address' = 'ListOfaddress', 'phone' = 'ListOfphone', 'electronicMailAddress' = 'ListOfelectronicMailAddress', 'onlineUrl' = 'ListOfonlineUrl', 'userId' = 'ListOfuserId', 'references' = 'references', 'id' = 'xml_attribute', 'system' = 'xml_attribute', 'scope' = 'xml_attribute'"
R <- gsub("'ResponsibleParty' = 'ResponsibleParty'", responsible_party_slots, R)
R <- gsub("'ProcedureStepType' = 'ProcedureStepType'", "'description' = 'TextType', 'citation' = 'ListOfcitation', 'protocol' = 'ListOfprotocol', 'instrumentation' = 'ListOfinstrumentation', 'software' = 'ListOfsoftware', 'subStep' = 'ListOfsubStep'", R)

R <- unique(R)
write(R, classes_file)

## Fix methods
M <- readLines(methods_file)
M <- gsub("'complex'", "'eml:complex'", M)
M <- gsub("signature\\('language'", "signature('eml:language'", M)
M <- gsub(".Object@complex", "slot(.Object, 'eml:complex')", M)
write(M, methods_file)

replace_class("ParagraphType", "setClass('ParagraphType', contains=c('InlineType'))", classes_file)
replace_class("SectionType", "setClass('SectionType', contains=c('InlineType'))", classes_file)
replace_class("eml:language", "setClass('eml:language', slots = c('LanguageValue' = 'character', 'LanguageCodeStandard' = 'character'), contains = c('eml-2.1.1', 'character',  'i18nNonEmptyStringType'))", classes_file)

drop_method('ParagraphType', methods_file)
drop_method('SectionType', methods_file)
drop_method('UrlType', methods_file)
sapply(c("array", "table", "matrix", "list", "description", "keyword", "unit", "eml:complex", "language", "parameter", "parameterDefinition"), drop_method, methods_file)

