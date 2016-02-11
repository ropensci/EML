## ToDo:
# - [ ] Must declare ListOf when MaxOccurs is given inside xs:choice instead of xs:element!!
# - [ ] xml_attribute should just be XMLAttribute
# - [ ] Write out documentation strings (as roxygen?...) xs:annotation
# - [ ] get xs:restriction
# - [ ] Generate constructor functions
# - [ ] Should we be capturing required vs optional elements (e.g. add a class to indicate?) (what about choice-of?)

library("dplyr")
library("xml2")
library("purrr")
source("inst/create-package/utils.R")
source("inst/create-package/create_methods.R")


has_extension <- function(element, ns){
    xml_find_all(element, "./*/xs:simpleContent/xs:extension | ./*/xs:complexContent/xs:extension", ns = ns) %>%
      xml_attr("base") %>% replace_character_type() -> out
    if(length(out) == 0) out <- NA
    out
}

has_children <- function(element, ns){
    length(xml_find_all(element, ".//xs:element", ns = ns)) > 0
}

## vectorize. Note: xmlValue returns characters. if .Data not character but instead float or Date etc, would need coercion.
is_character_type <- function(types){
  purrr::map_lgl(types, function(type)
    type %in% c("xs:string", "xs:date", "i18nString", "i18nNonEmptyStringType", "NonEmptyStringType", "character",
                "xs:float", "xs:anyURI", "xs:time", "xs:decimal", "xs:int", "xs:unsignedInt", "xs:unsignedLong",
                "xs:long", "xs:integer", "xs:boolean", "xs:date", "xs:positiveInteger")
  )
}

replace_character_type <- function(type){
  is_chr <- is_character_type(type)
  type[is_chr] <- "character"
  type
  }



#### Functions that write R code as output #############################

set_class_list <- function(class, cf = "classes.R"){
  base <- gsub("^ListOf", "", class)
  write(sprintf("setClass('%s', contains = 'list', validity = function(object){ if(!all(sapply(object, is, '%s'))){ 'not all elements are %s objects'; } else { TRUE }})",
                class, base, base), "list-classes.R", append = TRUE)
}





parse_element <- function(node, ns, cf = "class.R", mf = "methods.R", maxOccurs = NA,
                          bits = list(slots = list(), contains = character())){

  name <- xml_attr(node, "name", ns)
  type <- xml_attr(node, "type", ns)
  if(is.na(maxOccurs))
    maxOccurs <- xml_attr(node, "maxOccurs")

  ### Compute type (for declaration)

  ## If no type, use extension
  if(is.na(type))
    type <- has_extension(node, ns)
  ## if still no type, use character
  if(is.na(type))
    type <- "character"
  ## we'll use mostly un-namedspaced types
  type <- strip_namespace(type) %>% replace_character_type()

  ## Side-effect: declare class
  if(!is.na(name)){
    declare_class(name, bits$slots, unique(c(bits$contains, type)), cf = cf, mf = mf)
  }

  ## And now for the slots:


  ## No name, just recurse
  if(is.na(name) )
    create_class(node, ns, cf = cf, mf = mf)

  else {
    ## Repeat if element maxOccurs
    if(!is.na(maxOccurs)){
      if(maxOccurs == "unbounded" || maxOccurs > 1){

        type <- paste0("ListOf", strip_namespace(name))

        ## Side effect: declare any ListOf type
        set_class_list(type, cf = cf)
      }
    }
    slots <- setNames(type, name)
    list(slots = slots, contains = character())
  }
}

parse_group <- function(node, ns, cf = "classes.R", mf = "methods.R"){
  ref <- xml_attr(node, "ref")
  if(is.na(ref))
    create_class(node, ns, cf = cf, mf = mf)
  else {
    slots <- ref %>% replace_character_type() %>% strip_namespace() %>% setNames(., .)
    list(slots = slots, contains = character())
  }
}

parse_attribute <- function(node, ns, cf = "classes.R", mf = "methods.R"){
  name <- xml_attr(node, "name")
  ref <- xml_attr(node, "ref")
  if(is.na(name))
    name <- ref
  if(is.na(name))
    create_class(node, ns, cf = cf, mf = mf)
  else {
    list(slots = setNames("xml_attribute", strip_namespace(name)),
         contains = character())
  }
}


parse_extend_restrict <- function(node, ns, cf = "classes.R", mf = "methods.R"){
  base <- xml_attr(node, "base")
  if(is.na(base))
    create_class(node, ns, cf = cf, mf = mf)
  else {
    contains <- base %>% replace_character_type() %>% strip_namespace()
    list(slots = list(),
         contains = contains)
  }
}


create_class <- function(node, ns = character(), cf = "classes.R", mf = "methods.R", maxOccurs = NA){

  s4_bits <- xml_children(node) %>% purrr::map(recurse, ns = ns, cf = cf, mf = mf, maxOccurs = maxOccurs)

  list(slots = purrr::flatten(purrr::map(s4_bits, `[[`, "slots")),
       contains = unique(as.character(purrr::flatten(purrr::map(s4_bits, `[[`, "contains")))))
}

## given: <xs:element name="additionalMetadata" maxOccurs="unbounded">
## returns: slot('additionalMetadata' = 'ListOfadditionalMetadata')
## side-effect: write: setClass('additionalMetadata', slots = ...)
## given: <xs:element name="access" type="AccessType">
## return: slot('access' = 'AccessType')
## side-effect: write setClass('access', contains = 'AccessType')

recurse <- function(node, ns = character(), cf = "classes.R", mf = "methods.R", maxOccurs = NA){
  node_name <- xml_name(node, ns = ns)
  if(is.na(maxOccurs))
    maxOccurs = xml_attr(node, "maxOccurs", ns)

  bits <-
  if(node_name %in% c("xs:element", "xs:complexType", "xs:simpleType")){
    if(!is.na(xml_attr(node, "name", ns)))
      bits <- create_class(node, ns, cf = cf, mf = mf)
    else
      bits <- list(slots = list(), contains = character())

    parse_element(node, ns, cf = cf, mf = mf, maxOccurs = maxOccurs, bits = bits)

  } else if(node_name == "xs:group"){

    if(!is.na(xml_attr(node, "name", ns))){
      bits <- create_class(node, ns, cf = cf, mf = mf)
      parse_element(node, ns, cf = cf, mf = mf, maxOccurs = maxOccurs, bits = bits)
    } else {
      parse_group(node, ns, cf = cf, mf = mf)
    }

  } else if(node_name == "xs:attribute"){
    parse_attribute(node, ns, cf = cf, mf = mf)
  } else if(node_name %in% c("xs:extension", "xs:restriction")){
    parse_extend_restrict(node, ns, cf = cf, mf = mf)
  } else {
    create_class(node, ns, cf = cf, mf = mf, maxOccurs = maxOccurs)
  }

  mixed <- xml_attr(node, "mixed")
  if(!is.na(mixed) & mixed=="true"){
    bits$contains <- c("character", bits$contains)
  }
  bits$contains <- c(bits$contains, "eml-2.1.1")
  bits$contains <- unique(replace_character_type(bits$contains))

  bits
}



declare_class <- function(class, slots, contains, cf = "classes.R", mf = "methods.R"){
    if(length(slots) > 0){
      #add_roxygen(slots, slot_descriptions, "A-classes.R")
      write(sprintf("setClass('%s', slots = c(%s), contains = c(%s)) ## A", class,  ## FIXME drop contains = character unless mixed?
                    print_cmd(slots), print_cmd(contains)), "A-classes.R", append=TRUE)
      create_initialize_method(slots, class, mf)
    } else {

      if(identical(contains, "eml-2.1.1"))  # hack to avoid no .Data error??
        contains = c("character", contains)

      ## Hack the order class definitions appear in
      mark <- "D"
      if(all(contains %in% c("eml-2.1.1", "character"))){
        mark <- "B"
      }
      if(any(grepl("^[A-Z]", class))){
        mark <- "C"
      }

      write(sprintf("setClass('%s', contains = c(%s)) ## %s", class, print_cmd(contains), mark), paste0(mark, "-classes.R"), append=TRUE)

    }
    set_coerces(class, mf)
}





get_descriptions <- function(elements){
  out <- elements %>% purrr::map(xml2::xml_find_all, "./xs:annotation/xs:appinfo/doc:summary", ns)
  setNames(out, xml_attr(elements, "name"))
  }

add_roxygen <- function(slots, slot_descriptions, cf = "A-classes.R"){
  write(sprintf("#' "), cf, append = TRUE)
}


readclass <- function(x){
  if(file.exists(x))
    readLines(x)
  else
    character()
}






## Main method #######


create_classes <- function(xsd_file,
                           ns = xml2::xml_ns(xml2::read_xml(xsd_file)),
                           cf = paste0("R/", filename(xsd_file), "-classes.R"),
                           mf = paste0("R/", filename(xsd_file), "-methods.R"),
                           append = TRUE){
  xsd <- xml2::read_xml(xsd_file)
  imports <- xml2::xml_find_all(xsd, "./xs:import", ns)
  documentation <- xml2::xml_find_all(xsd, "./xs:annotation", ns)

  ## (all top-level elements should be named, since no name to inherit)
  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), cf, append = append)
  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), mf, append = append)

  create_class(xsd, ns = ns, cf = cf, mf = mf)

  write(c(readclass("list-classes.R"), readclass("B-classes.R"), readclass("A-classes.R"), readclass("C-classes.R"), readclass("D-classes.R")), cf, append = append)
  unlink(c("list-classes.R", "A-classes.R", "B-classes.R", "C-classes.R", "D-classes.R"))
}
