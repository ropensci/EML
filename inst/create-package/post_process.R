set_dummy_class <- function(class, file = "R/classes.R") {
  write(sprintf("setClass('%s')", class), file, append = TRUE)
}


replace_class <- function(class, new, file = "R/classes.R") {
  R <- readLines(file)
  R <- gsub(sprintf("^setClass\\('%s'.*", class), new, R)
  write(R, file)
}


move_up_n <- function(class, file = "R/classes.R", n = 2) {
  R <- readLines(file)
  N <- length(R)
  i <- grep(sprintf("^setClass\\('%s'.*", class), R)[[1]]
  write(c(R[1:(i - n)], R[i], R[(i - n + 1):(i - 1)], R[(i + 1):N]), file)
}


move_down_n <- function(class, file = "R/classes.R", n = 2) {
  R <- readLines(file)
  N <- length(R)
  i <- grep(sprintf("^setClass\\('%s'.*", class), R)[[1]]
  write(c(R[1:(i - 1)], R[(i + 1):(i + n)], R[i], R[(i + n + 1):N]), file)
}


move_to_top <- function(class, file = "R/classes.R") {
  R <- readLines(file)
  i <- grep(sprintf("^setClass\\('%s'.*", class), R)
  write(c(R[i], R[-i]), file)
}


move_to_end <- function(class, file = "R/classes.R") {
  R <- readLines(file)
  i <- grep(sprintf("^setClass\\('%s'.*", class), R)
  write(c(R[-i], R[i]), file)
}


drop_method <- function(class, file) {
  M <- readLines(file)
  #  M <- gsub(sprintf("^setAs\\('%s',.*", class), "", M)
  #  M <- gsub(sprintf("setAs\\('xml_node', '%s',.*", class), "", M)
  M <- gsub(sprintf("setMethod\\(initialize, '%s'.*", class), "", M)
  write(M, file)
}

# make sure that " = 'complex'" etc also gets fixed. not a problem if class isn't used as a type.
fix_protected <- function(file) {
  R <- readLines(file)
  R <-
    gsub("^setClass\\('language'", "setClass('eml:language'", R)  ## not used? no "= 'language'"
  R <-
    gsub("^setClass\\('name'", "setClass('eml:name'", R)   ## not used?
  R <-
    gsub("^setClass\\('array'", "setClass('eml:array'", R) ## not used?
  R <-
    gsub("^setClass\\('matrix'", "setClass('eml:matrix'", R) ## not used?
  R <-
    gsub("^setClass\\('table'", "setClass('eml:table'", R) ## not used?
  R <-
    gsub("^setClass\\('list'", "setClass('eml:list'", R) ## not used?
  R <- gsub("'complex'", "'eml:complex'", R)
  R <- gsub("c\\('class' = ", "c('eml:class' =", R)
  write(R, file, append = FALSE)
}






## Misc code to determine collate order
ns <- xml_ns(read_xml("inst/xsd/eml-2.1.1/eml.xsd"))
schema <- list.files("inst/xsd/eml-2.1.1/", pattern = "*.xsd")
names(schema) = schema
schema %>% map(function(x) {
  xsd <- read_xml(paste0("inst/xsd/eml-2.1.1/", x))
  xml_find_all(xsd, "//xs:import", ns = ns) %>% xml_attr("schemaLocation")
}) -> deps


# shrink <- function(l){ l[sapply(l, length) > 0] }
#
#
# paste0("inst/xsd/eml-2.1.1/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:sequence[@maxOccurs]", ns) }) %>% shrink()
# paste0("inst/xsd/eml-2.1.1/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType/*/xs:choice[@maxOccurs]", ns) }) %>% shrink()




# create_classes("inst/xsd/eml-2.1.1/stmml.xsd", ns = stmml_ns, append = FALSE)
#  paste0("inst/xsd/eml-2.1.1/", collate) %>% map(create_classes, append = FALSE)
# fix_protected("R/stmml-classes.R")
# fix_protected("R/eml-resource-classes.R")
#
# file <- "R/eml-resource-classes.R"
# R <- readLines(file)
# R <- gsub("^setClass\\('InlineType'.*", "setClass('InlineType', contains='XMLInternalElementNode')", R)
# write(R, file)
#
# file <- "R/eml-literature-classes.R"
# R <- readLines(file)
# R <- gsub("^setClass\\('geographicCoverage'.*", "", R)
# write(R, file)
#
# fix_protected("R/eml-physical-classes.R")
# fix_protected("R/eml-software-classes.R")
# combine <- c(readLines("R/eml-protocol-classes.R"), readLines("R/eml-methods-classes.R"))
# write(combine, "R/eml-methods-classes.R")
# move_to_end("proceduralStep", "R/eml-methods-classes.R")
# fix_protected("R/eml-storedProcedure-classes.R")

# paste0("inst/xsd/eml-2.1.1/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType/xs:choice[@maxOccurs]", ns) }) %>% shrink()
# paste0("inst/xsd/eml-2.1.1/", collate) %>% map(function(x){ xsd = read_xml(x); xml_find_all(xsd, "//xs:complexType[child::xs:choice[@maxOccurs] | child::xs:sequence[@maxOccurs]]", ns) }) %>% shrink()
