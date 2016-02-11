
move_to_end <- function(class, file){
  R <- readLines(file)
  i <- grep(sprintf("^setClass\\('%s'.*", class), R)
  write(c(R[-i], R[i]), file)
}

fix_protected <- function(file){
  R <- readLines(file)
  R <- gsub("^setClass\\('language'", "setClass('eml:language'", R)
  R <- gsub("^setClass\\('name'", "setClass('eml:name'", R)
  R <- gsub("^setClass\\('array'", "setClass('eml:array'", R)
  R <- gsub("^setClass\\('matrix'", "setClass('eml:matrix'", R)
  R <- gsub("^setClass\\('table'", "setClass('eml:table'", R)
  R <- gsub("^setClass\\('list'", "setClass('eml:list'", R)
  R <- gsub("^setClass\\('complex'", "setClass('eml:complex'", R)
  R <- gsub("c\\('class' = ", "c('eml:class' =", R)
  write(R, file, append = FALSE)
}






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
