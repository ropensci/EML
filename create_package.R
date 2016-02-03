library("XML")
library("xml2")
library("purrr")
source("R/xsd_classes.R")
##
file.remove("R/classes.R")
file.remove("R/methods.R")


## Define some dummy classes at start to avoid unsatisfiable collate order
c("eml-2.1.1", "ReferencesGroup", "AccessRule", "Coverage", "MethodsType", "ConstraintBaseGroup", "ForeignKeyGroup", "CitationType",
  "PhysicalType", "DatasetType") %>%
  purrr::map(set_dummy_class, "R/classes.R")

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
R <- gsub("^setClass\\('language'", "setClass('eml_language'", R)
R <- gsub("^setClass\\('name'", "setClass('eml_name'", R)
R <- gsub("^setClass\\('array'", "setClass('eml_array'", R)
R <- gsub("^setClass\\('matrix'", "setClass('eml_matrix'", R)
R <- gsub("^setClass\\('table'", "setClass('eml_table'", R)
R <- gsub("^setClass\\('list'", "setClass('eml_list'", R)
R <- gsub("^setClass\\('complex'", "setClass('eml_complex'", R)


write(R, "R/classes.R", append = FALSE)


##
xsd_file <- "inst/xsd/eml-attribute.xsd"; xsd <- xml2::read_xml(xsd_file); ns <- xml2::xml_ns(xsd);
xsd_file <- "inst/xsd/eml-access.xsd"; xsd <- xml2::read_xml(xsd_file); ns <- xml2::xml_ns(xsd);


##

schema <- list.files("inst/xsd/", pattern="*.xsd")
names(schema) = schema
schema %>% map(function(x){
  xsd <- read_xml(paste0("inst/xsd/", x))
  xml_find_all(xsd, "//xs:import", ns) %>% xml_attr("schemaLocation")
}) -> deps
