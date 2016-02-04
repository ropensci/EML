library("XML")
library("xml2")
library("purrr")
library("dplyr")

## Filepaths assume working directory is package root

source("inst/create-package/xsd_classes.R")
classes_file <- "R/classes.R"
methods_file <- "R/methods.R"
## Start clean
file.remove(classes_file)
file.remove(methods_file)



## Create some boilerplate classes:
xs_base_classes <- function(file = "classes.R"){

  ## Define some dummy classes defined later, but we define first at start to avoid tricky or unsatisfiable collate order issues
  c("ReferencesGroup", "AccessRule", "Coverage",
    "MethodsType", "ConstraintBaseGroup", "ForeignKeyGroup",
    "CitationType", "PhysicalType", "DatasetType",
    "ProcedureStepType") %>%
    purrr::map(set_dummy_class, file)

  ## Some basic classes we'll use
  write("setClass('eml-2.1.1', slots = c('schemaLocation' = 'xml_attribute'))", file, append = TRUE)

  write("setClass('NonEmptyStringType', contains='character')", file, append = TRUE)
  write(sprintf("setClass('xml_attribute', contains = 'character')"), file, append = TRUE)

  ## Define classes for the these XSD schema types to correspond to the appropriate R object class
  data.frame(class =    c("xs:float", "xs:string", "xs:anyURI", "xs:time", "xs:decimal", "xs:int", "xs:unsignedInt", "xs:unsignedLong", "xs:long", "xs:integer", "xs:boolean", "xs:date"),
             contains = c("numeric", "character", "character", "character", "numeric", "integer", "integer", "integer", "integer", "integer", "logical", "Date")) %>%
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
  "eml-coverage.xsd",
  "eml-attribute.xsd",
  "eml-entity.xsd",
  "eml-physical.xsd",
  "eml-spatialVector.xsd",
  "eml-spatialRaster.xsd",
  "eml-storedProcedure.xsd",
  "eml-literature.xsd",
  "eml-view.xsd",
  "eml-project.xsd",
  "eml-software.xsd",
  "eml-protocol.xsd",
  "eml-dataTable.xsd",
  "eml-dataset.xsd",
  "eml-methods.xsd",
  "eml.xsd"
)

## Okay, here we go! Create all the classes...
paste0("inst/xsd/", collate) %>% map(create_classes, "R/classes.R", "R/methods.R")



## Fix protected classes
R <- readLines("R/classes.R")
R <- gsub("^setClass\\('language'", "setClass('eml:language'", R)
R <- gsub("^setClass\\('name'", "setClass('eml:name'", R)
R <- gsub("^setClass\\('array'", "setClass('eml:array'", R)
R <- gsub("^setClass\\('matrix'", "setClass('eml:matrix'", R)
R <- gsub("^setClass\\('table'", "setClass('eml:table'", R)
R <- gsub("^setClass\\('list'", "setClass('eml:list'", R)
R <- gsub("^setClass\\('complex'", "setClass('eml:complex'", R)
R <- gsub("c\\('class' = ", "c('eml:class' =", R)

write(R, "R/classes.R", append = FALSE)


##

## Misc code to determine collate order
# schema <- list.files("inst/xsd/", pattern="*.xsd")
# names(schema) = schema
# schema %>% map(function(x){
#  xsd <- read_xml(paste0("inst/xsd/", x))
#  xml_find_all(xsd, "//xs:import", ns) %>% xml_attr("schemaLocation")
# }) -> deps
