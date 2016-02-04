library("XML")
library("xml2")
library("purrr")
source("R/xsd_classes.R")
##
file.remove("R/classes.R")
file.remove("R/methods.R")


## Define some dummy classes at start to avoid unsatisfiable collate order
c("eml-2.1.1", "ReferencesGroup", "AccessRule", "Coverage", "MethodsType", "ConstraintBaseGroup", "ForeignKeyGroup", "CitationType",
  "PhysicalType", "DatasetType", "ProcedureStepType") %>%
  purrr::map(set_dummy_class, "R/classes.R")

write("setClass('NonEmptyStringType', contains='character')", "R/classes.R", append = TRUE)

## Create the base xs classes
xs_base_classes("R/classes.R")

## needs custom namespace
create_classes("inst/xsd/stmml.xsd", "R/classes.R", "R/methods.R", ns = xml_ns(read_xml("inst/xsd/eml.xsd")))

## Collate list
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

source("R/classes.R")
source("R/methods.R")



##

## Misc code to determine collate order
# schema <- list.files("inst/xsd/", pattern="*.xsd")
# names(schema) = schema
# schema %>% map(function(x){
#  xsd <- read_xml(paste0("inst/xsd/", x))
#  xml_find_all(xsd, "//xs:import", ns) %>% xml_attr("schemaLocation")
# }) -> deps
