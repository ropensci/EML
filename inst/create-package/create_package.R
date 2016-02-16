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
xs_base_classes <- function(file = "classes.R", methods_file = "R/methods.R"){

  write("
setClass('xml_attribute', contains = 'character')
setClass('eml-2.1.1', slots = c('schemaLocation' = 'xml_attribute', lang = 'xml_attribute'))
setClass('any_xml', contains = 'XMLInternalElementNode')
setClass('InlineType', contains='XMLInternalElementNode')",
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
stmml_ns <- xml_ns_rename( xml_ns(read_xml("inst/xsd/stmml.xsd")), xsd = "xs")
create_classes("inst/xsd/stmml.xsd", classes_file, methods_file, ns = stmml_ns)

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
move_to_end("proceduralStep", classes_file)
move_to_end("methodStep", classes_file)
move_to_end("dataSource", classes_file)

#replace_class("ParagraphType", "setClass('ParagraphType', contains=c('character', 'InlineType'))", classes_file)
#replace_class("SectionType", "setClass('SectionType', contains=c('character','InlineType'))", classes_file)

replace_class("coverage", "setClass('coverage', contains=c('Coverage'))", classes_file)
replace_class("temporalCoverage", "setClass('temporalCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TemporalCoverage'))", classes_file)
replace_class("taxonomicCoverage", "setClass('taxonomicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('TaxonomicCoverage'))", classes_file)
replace_class("geographicCoverage", "setClass('geographicCoverage', slots = c('system' = 'xml_attribute', 'scope' = 'xml_attribute'), contains = c('GeographicCoverage'))", classes_file)
replace_class('size', "setClass('size', slots = c('character' = 'character', 'unit' = 'xml_attribute'), contains = c('eml-2.1.1', 'character'))", classes_file)
replace_class('metadata', "setClass('metadata', contains='InlineType')", classes_file)
replace_class('inline', "setClass('inline', contains='InlineType')", classes_file)
replace_class('InlineType', "setClass('InlineType', contains='XMLInternalElementNode')", classes_file)
replace_class('parameter', "setClass('parameter', slots = c(name = 'character', value = 'character', 'domainDescription' = 'character', 'required' = 'character', 'repeats' = 'character'))", classes_file)
#replace_class('online', "setClass('online', slots = c('onlineDescription' = 'character', 'url' = 'UrlType', 'connection' = 'ConnectionType', 'connectionDefinition' = 'ConnectionDefinitionType'), contains = c('eml-2.1.1'))", classes_file)
replace_class('online', "setClass('online', contains = c('PhysicalOnlineType', 'OnlineType', 'eml-2.1.1'))", classes_file)
move_to_end("coverage", classes_file)
move_to_end("temporalCoverage", classes_file)
move_to_end("taxonomicCoverage", classes_file)
move_to_end("geographicCoverage", classes_file)
move_to_end("metadata", classes_file)
move_to_end("inline", classes_file)
move_to_end("parameter", classes_file)
move_to_end("online", classes_file)



## Fix methods
M <- readLines(methods_file)
M <- gsub("'complex'", "'eml:complex'", M)
M <- gsub(".Object@complex", "slot(.Object, 'eml:complex')", M)
write(M, methods_file)

#drop_method('ParagraphType', methods_file)
#drop_method('SectionType', methods_file)
drop_method('metadata', methods_file)
drop_method('inline', methods_file)
drop_method('InlineType', methods_file)











