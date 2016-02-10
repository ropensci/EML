library("XML")
library("xml2")
library("purrr")
library("dplyr")

## Filepaths assume working directory is package root

source("inst/create-package/create_classes.R")
classes_file <- "R/classes.R"
methods_file <- "R/methods.R"
## Start clean
file.remove(classes_file)
file.remove(methods_file)



## Create some boilerplate classes:
xs_base_classes <- function(file = "classes.R", methods_file = "R/methods.R"){

  write("
setClass('xml_attribute', contains = 'character')
setClass('eml-2.1.1', slots = c(schemaLocation = 'xml_attribute', lang = 'xml_attribute'))
setClass('any_xml', contains = 'XMLInternalElementNode')",
        file, append = TRUE)

write("
setClass('PrecisionType', contains = c('numeric'))
setClass('ReferencesGroup', slots = c('references' = 'character'), contains = c('eml-2.1.1'))
setClass('ConstraintBaseGroup', slots = c('constraintName' = 'character', 'constraintDescription' = 'character'), contains = c('eml-2.1.1'))",
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
create_classes("inst/xsd/stmml.xsd", classes_file, methods_file, ns = xml_ns(read_xml("inst/xsd/eml.xsd")))

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
paste0("inst/xsd/", collate) %>% map(create_classes, class_file = "R/classes.R", methods_file = "R/methods.R")



## Fix protected classes
R <- readLines(classes_file)
R <- gsub("^setClass\\('language'", "setClass('eml:language'", R)
R <- gsub("^setClass\\('name'", "setClass('eml:name'", R)
R <- gsub("^setClass\\('array'", "setClass('eml:array'", R)
R <- gsub("^setClass\\('matrix'", "setClass('eml:matrix'", R)
R <- gsub("^setClass\\('table'", "setClass('eml:table'", R)
R <- gsub("^setClass\\('list'", "setClass('eml:list'", R)
R <- gsub("^setClass\\('complex'", "setClass('eml:complex'", R)
R <- gsub("c\\('class' = ", "c('eml:class' =", R)

## Move this definition down below ForeignKeyGroup definition

# joinCondition <- "setClass('joinCondition', slots = c('referencedKey' = 'character'), contains = c('ForeignKeyGroup', 'eml-2.1.1'))"
# escape_parens <- function(x){
#   x <- gsub("\\(", "\\\\(", x)
#   gsub("\\)", "\\\\)", x)
# }
# R <- gsub(escape_parens(joinCondition), "", R)
#R <- sub("setClass\\('attributeReference', contains = 'character'\\)", joinCondition, R)



## coverage repeats a couple times before defined. Remove it, replace with definition at end
R <- gsub("^setClass\\('coverage'.*", "", R)


R <- gsub("^setClass\\('inline'.*", "", R)


## These need to be defined later than they appear.  Manually move to end.
R <- gsub("^setClass\\('proceduralStep'.*", "", R)
R <- gsub("^setClass\\('protocol'.*", "", R)
R <- gsub("^setClass\\('temporalCoverage'.*", "", R)
R <- gsub("^setClass\\('taxonomicCoverage'.*", "", R)
R <- gsub("setClass\\('geographicCoverage.*", "", R)
R <- gsub("^setClass\\('methodStep'.*", "", R)
R <- gsub("^setClass\\('dataSource'.*", "", R)
R <- gsub("^setClass\\('unit'.*", "", R)
R <- gsub("^setClass\\('InlineType'.*", "setClass('InlineType', contains='XMLInternalElementNode')", R)

write(R, classes_file, append = FALSE)

write("
setClass('proceduralStep', contains = 'ProcedureStepType')
setClass('protocol', contains = 'ProtocolType')
setClass('dataSource', contains = 'DatasetType')
setClass('methodStep', slots = c('dataSource' = 'ListOfdataSource'), contains = c('ProcedureStepType', 'eml-2.1.1'))
setClass('temporalCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TemporalCoverage'))
setClass('taxonomicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TaxonomicCoverage'))
setClass('geographicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('GeographicCoverage'))
setClass('coverage', contains=c('Coverage'))
setClass('inline', contains='InlineType')

setClass('unit', slots = c('description' = 'ListOfdescription', 'annotation' = 'ListOfannotation', 'id' = 'xml_attribute', 'abbreviation' = 'xml_attribute', 'name' = 'xml_attribute', 'parentSI' = 'xml_attribute', 'unitType' = 'xml_attribute', 'multiplierToSI' = 'xml_attribute', 'constantToSI' = 'xml_attribute'), contains = c('UnitType', 'eml-2.1.1'))
setClass('parameter', slots = c(name = 'character', value = 'character', 'domainDescription' = 'character', 'required' = 'character', 'repeats' = 'character'))
setClass('online', slots = c('onlineDescription' = 'character', 'url' = 'UrlType', 'connection' = 'ConnectionType', 'connectionDefinition' = 'ConnectionDefinitionType'), contains = c('eml-2.1.1'))",
      classes_file, append = TRUE)

M <- readLines(methods_file)
M <- gsub("^setAs\\('inline',.*", "", M)
M <- gsub("setAs\\('XMLInternalElementNode', 'inline',.*", "", M)
M <- gsub("^setAs\\('InlineType',.*", "", M)
M <- gsub("setAs\\('XMLInternalElementNode', 'InlineType',.*", "", M)
write(M, methods_file)


## Misc code to determine collate order
ns <- xml_ns(read_xml("inst/xsd/eml.xsd"))
 schema <- list.files("inst/xsd/", pattern="*.xsd")
 names(schema) = schema
 schema %>% map(function(x){
  xsd <- read_xml(paste0("inst/xsd/", x))
  xml_find_all(xsd, "//xs:import", ns = ns) %>% xml_attr("schemaLocation")
 }) -> deps


# shrink <- function(l){ l[sapply(l, length) > 0] }
#
#
# paste0("inst/xsd/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:sequence[@maxOccurs]", ns) }) %>% shrink()
# paste0("inst/xsd/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType/*/xs:choice[@maxOccurs]", ns) }) %>% shrink()
# paste0("inst/xsd/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType/xs:choice[@maxOccurs]", ns) }) %>% shrink()
# paste0("inst/xsd/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType[child::xs:choice[@maxOccurs] | child::xs:sequence[@maxOccurs]]", ns) }) %>% shrink()
