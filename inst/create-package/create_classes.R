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

## utils ##

filename <- function(x){
  strsplit(basename(x), "\\.")[[1]][1]
}

## Contrary to name, doesn't strip "xs:" namespace; this helps to avoid a lot of clashes with protected types
strip_namespace <- function(x){
  purrr::map_chr(x,
                 function(x){
                   if(length(x) > 0){
                     if(grepl("^xs:",  x))
                       x
                     else if(grepl("^xsd:",  x))
                       x <- gsub("^.*:(.*)", "xs:\\1", x)
                     else
                       x <- gsub("^.*:", "", x)
                   }
                   x
                 })
}

print_cmd <- function(l){
  n <- names(l)

  if(is.null(n)){
    out <- paste0("'", as.character(l), "'", collapse = ", ")
  } else {
    out <- ""
    if(length(l) > 1)
    for(i in 1:(length(l)-1))
      out <- paste0(out, "'", n[i], "'", " = '", l[i], "', ")
    out <- paste0(out, "'", n[length(l)], "'", " = '", l[length(l)], "'")
  }

  out
}


has_extension <- function(element, ns = character()){
    xml_find_all(element, "./*/xs:simpleContent/xs:extension | ./*/xs:complexContent/xs:extension", ns = ns) %>%
      xml_attr("base") -> out
    if(length(out) == 0) out <- NA
    out
}

has_children <- function(element, ns = character()){
    length(xml_find_all(element, ".//xs:element", ns = ns)) > 0
}

## vectorize
is_character_type <- function(types){
  purrr::map_lgl(types, function(type)
    type %in% c("xs:string", "i18nString", "i18nNonEmptyStringType", "NonEmptyStringType", "character")
  )
}

replace_character_type <- function(type){
  is_chr <- is_character_type(type)
  type[is_chr] <- "character"
  type
  }


sanitize_type <- function(type, name, children, extension){
  ext_as_type <- is.na(type) & !is.na(extension)
  type[ext_as_type] <- extension[ext_as_type]

  name_as_type <- is.na(type) & children
  char_as_type <- is.na(type) & !children

  type[name_as_type] <- name[name_as_type]
  type[char_as_type] <- "character"

  ### FIXME  create a bigger mapping set of types that should be replaced with "character" directly
  ### FIXME likewise, identify other xs: base types (e.g. xs:float, xs:time, xs:date) that we can define with native R types directly
  str_type <- is_character_type(type)
  type[str_type] <- "character"


  strip_namespace(type)
}

slotify <- function(name, type, maxOccurs){
  multiples <- !(is.na(maxOccurs) | maxOccurs == 1)
  type[multiples] <- paste0("ListOf", name[multiples])
  type
}

column_check <- function(df){
  if(! "name" %in% names(df))
    df$name <- NA
  if(! "maxOccurs" %in% names(df))
    df$maxOccurs <- NA
  if(! "type" %in% names(df))
    df$type <- "character"
  df
}

ref_as_name <- function(df){

  if(!is.null(df$name)){
    nans <- is.na(df$name)
    df$name[nans] <- df$ref[nans]
  } else {
    df$name <- df$ref
  }
  df
}

#' @importFrom dplyr mutate
element_attrs_table <- function(elements, ns = character(), maxOccurs = NA){

    df <- elements %>% purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
      column_check()

    nans <- is.na(df$maxOccurs)
    df$maxOccurs[nans] <- maxOccurs
    df$children <- elements %>% purrr::map_lgl(has_children, ns)
    df$extension <- elements %>% purrr::map_chr(has_extension, ns = ns)

    df %>%
      ref_as_name() %>%
      dplyr::mutate(type = sanitize_type(type, name, children, extension)) %>%
      dplyr::mutate(slot = slotify(name, type, maxOccurs))

}



#### Functions that write R code as output #############################

set_coerces <- function(class, class_file = "methods.R"){
  write(sprintf("setAs('%s', 'XMLInternalElementNode',   function(from) S4Toeml(from))", class), class_file, append = TRUE)
  write(sprintf("setAs('XMLInternalElementNode', '%s',  function(from) emlToS4(from))", class), class_file, append = TRUE)
}

set_class_list <- function(class, class_file = "classes.R"){
  write(sprintf("setClass('%s', contains = 'list')", class), "list-classes.R", append = TRUE)
}




recursive_parse <- function(child_sets, ns = ns, class_file = class_file, methods_file = methods_file){
  purrr::map(child_sets, function(set){
      purrr::map(set, set_class_complextype, ns = ns, class_file = class_file, methods_file = methods_file) %>%
        purrr::flatten()
    }) -> s4_bits

  list(slots = purrr::flatten(purrr::map(s4_bits, `[[`, "slots")),
       contains = purrr::flatten(purrr::map(s4_bits, `[[`, "contains")))
}




#' @importFrom dplyr as_data_frame
set_class_complextype <- function(complex_type,
                                  ns = character(),
                                  class_file = "classes.R",
                                  methods_file = "methods.R",
                                  class = NA,
                                  maxOccurs = NA){

  if(is.na(class)){
    class <- xml2::xml_attr(complex_type, "name")
  }

  if(is.na(maxOccurs)){
    maxOccurs <- xml_attr(complex_type, "maxOccurs")
  }

  type <- xml_attr(complex_type, "type") %>% strip_namespace()
  if(is.na(type))
    type <- character(0)

  #### All possible children of complexType ####
  documentation <- xml2::xml_find_all(complex_type, "./xs:annotation", ns)
  simple_types <- xml2::xml_find_all(complex_type, "./xs:simpleType", ns)
  elements <- xml2::xml_find_all(complex_type, "./xs:element", ns)
  groups <- xml2::xml_find_all(complex_type, "./xs:group", ns)
  complex_types <- xml2::xml_find_all(complex_type, "./xs:complexType", ns)
  choice <- xml2::xml_find_all(complex_type, "./xs:choice | ./xs:any", ns)
  sequence <- xml2::xml_find_all(complex_type, "./xs:sequence", ns)
  simple_content <- xml2::xml_find_all(complex_type, "./xs:simpleContent", ns)
  complex_content <- xml2::xml_find_all(complex_type, "./xs:complexContent", ns)
  attrib <- xml2::xml_find_all(complex_type, "./xs:attribute", ns)
  extensions <- xml2::xml_find_all(complex_type, "./xs:extension", ns)
  restrictions <- xml2::xml_find_all(complex_type, "./xs:restriction", ns)


  children <- list(simple_types, elements, groups, complex_types, choice, sequence, simple_content, complex_content, extensions, restrictions) %>%
    recursive_parse(ns = ns, class_file = class_file, methods_file = methods_file)

  group_slots <- groups %>% purrr::map(xml_attr, "ref") %>% replace_character_type() %>% strip_namespace() %>% setNames(., .)
  ## FIXME choice slots may not come before element slots...  Be more careful about creating a valid slot order!!!
  slots <- c(
    group_slots,
    elements_to_slots(elements, ns = ns, maxOccurs = maxOccurs, class_file = class_file),
    children$slots,
    attrib_to_slots(attrib)
    )

  contains <- c(
    as.character(children$contains),
#    groups %>% purrr::map(xml_attr, "ref") %>% strip_namespace(),
    extensions %>% purrr::map(xml_attr, "base") %>% strip_namespace(),
    restrictions %>% purrr::map(xml_attr, "base") %>% strip_namespace(),
    type
  )


  mixed <- xml_attr(complex_type, "mixed")
  if(!is.na(mixed) & mixed=="true"){
    contains <- c("character", contains)
  }
  contains <- replace_character_type(contains)

  ## Drop repeated elements from contains list
  contains <- unique(contains)


  ## Inherit class
  if(!is.na(class)){  ## if we have a named element, then we declare a class

    if(length(slots) > 0){
      write(sprintf("setClass('%s', slots = c(%s), contains = c(%s)) ## A", class,
                    print_cmd(slots), print_cmd(c(contains, "eml-2.1.1"))), "A-classes.R", append=TRUE)
    } else {
      if(length(contains) == 0)  # hack?
        contains = "character"
      write(sprintf("setClass('%s', contains = c(%s)) ## B", class, print_cmd(contains)), "B-classes.R", append=TRUE)
    }
    set_coerces(class, methods_file)
    out <- list()

  } else { ## else return the slots to next level
    out <- list(slots = slots, contains = contains)
  }

  out
}


attrib_to_slots <- function(attrib){
  if(length(attrib) > 0){
    attrib %>%
      purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
      ref_as_name() -> att_df
    att <- replace_character_type(att_df$name)

    setNames(rep("xml_attribute", length(att)), att)
  } else {
    list()
  }
}

elements_to_slots <- function(elements, ns, maxOccurs = NA, class_file = "classes.R"){
  if(length(elements) > 0){
    df <- element_attrs_table(elements, ns = ns, maxOccurs = maxOccurs)

    ## Go ahead and define ListOf classes now
    unique(df$slot[grepl("ListOf", df$slot)]) %>%
      purrr::map(set_class_list, class_file = class_file)


    setNames(replace_character_type(df$slot), df$name)

  } else {
    list()
  }
}



## Main method #######


create_classes <- function(xsd_file,
                           ns = xml2::xml_ns(xml2::read_xml(xsd_file)),
                           class_file = paste0("R/", filename(xsd_file), "-classes.R"),
                           methods_file = paste0("R/", filename(xsd_file), "-methods.R"),
                           append = TRUE){
  xsd <- xml2::read_xml(xsd_file)
  imports <- xml2::xml_find_all(xsd, "./xs:import", ns)
  documentation <- xml2::xml_find_all(xsd, "./xs:annotation", ns)

  ## (all top-level elements should be named, since no name to inherit)
  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), class_file, append = append)
  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), methods_file, append = append)

  set_class_complextype(xsd, ns = ns, class_file = class_file, methods_file = methods_file)

  write(c(readclass("list-classes.R"), readclass("A-classes.R"), readclass("B-classes.R"), readclass("D-classes.R")),
        class_file, append = append)

  unlink(c("list-classes.R", "D-classes.R", "A-classes.R", "B-classes.R"))
}

readclass <- function(x){
  if(file.exists(x))
    readLines(x)
  else
    character()
}
