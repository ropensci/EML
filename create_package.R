library("XML")
library("xml2")
library("purrr")
source("R/xsd_classes.R")
##
file.remove("R/classes.R")
file.remove("R/methods.R")

write("#' @importFrom XML XMLInternalElementNode\n", "R/methods.R", append = TRUE)

c("eml-2.1.1", "ReferencesGroup", "AccessRule", "Coverage", "MethodsType") %>% purrr::map(set_dummy_class, "R/classes.R")
#

# create_classes("inst/xsd/stmml.xsd", "R/classes.R", "R/methods.R")

collate <- c(

  "eml-text.xsd",
  "eml-documentation.xsd",
  "eml-unitTypeDefinitions.xsd",
  "eml-party.xsd",
  "eml-resource.xsd",
  "eml-spatialReference.xsd",
  "eml-access.xsd"
#  "eml-attribute.xsd"
)

xs_base_classes("R/classes.R")
paste0("inst/xsd/", collate) %>% map(create_classes, "R/classes.R", "R/methods.R")

R <- readLines("R/classes.R")
R <- gsub("^setClass\\('language'", "setClass('eml:language'", R)
R <- gsub("^setClass\\('name'", "setClass('eml:name'", R)
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
