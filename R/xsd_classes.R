## ToDo:
#
# - [ ] xs:extension should -> contains base
# - [ ] Write out documentation strings (as roxygen?...) xs:annotation
# - [ ] Generate constructor functions
# - [ ] Should we be capturing required vs optional elements (e.g. add a class to indicate?) (what about choice-of?)

print_cmd <- function(l){
  n <- names(l)

  if(is.null(n)){
    out <- paste0("'", as.character(l), "'", collapse = ", ")
  } else {
    out <- ""
    if(length(l) > 1)
    for(i in 1:(length(l)-1))
      out <- paste0(out, n[i], " = '", l[i], "', ")
    out <- paste0(out, n[length(l)], " = '", l[length(l)], "'")
  }

  out
}

sanitize_type <- function(type, name = rep("character", length(type))){
  replace <- is.na(type) | grepl(c("NonEmptyStringType"), type)
    type[replace] <- name[replace]
  type
}

set_coerces <- function(class, file = "methods.R"){
  write(sprintf("setAs('%s', 'XMLInternalElementNode',   function(from) S4Toeml(from))", class), file, append = TRUE)
  write(sprintf("setAs('XMLInternalElementNode', '%s',  function(from) emlToS4(from))", class), file, append = TRUE)
}



set_class_list <- function(class, file = "classes.R"){
  #setClass(class, contains = "list")
  write(sprintf("setClass('%s', contains = 'list')", class), file, append = TRUE)
}


set_class_element <- function(element, file = "classes.R"){
  class <- xml2::xml_attr(element, "name")
  type <- xml2::xml_attr(element, "type") %>% sanitize_type()
  occurs <- xml2::xml_attr(element, "maxOccurs")

  #setClass(class, contains = type)
  write(sprintf("setClass('%s', contains = '%s')", class, type), file, append = TRUE)
}


slotify <- function(type, maxOccurs){
  multiples <- !(is.na(maxOccurs) | maxOccurs == 1)
  type[multiples] <- paste0("ListOf", type[multiples])
  type
}

column_check <- function(df){
  if(! "maxOccurs" %in% names(df))
    df$maxOccurs <- NA
  if(! "type" %in% names(df))
    df$type <- "character"
  df
}

set_class_complex_type <- function(complex_type,
                                   class = xml2::xml_attr(complex_type, "name"),
                                   ns = character(), file = "classes.R"){


  ## Get all immediate child elements in the complex_type
  elements <- xml2::xml_find_all(complex_type, "./*/*/xs:element | ./*/xs:element", ns = ns)

  ## Define class for the complex_type with a slot for each element. First, determine slot types:
  if(length(elements) > 0){
    element <- elements %>%
      purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
      column_check() %>%
      dplyr::mutate(type = sanitize_type(type, name)) %>%
      dplyr::mutate(slot = slotify(type, maxOccurs))
    slots <- setNames(element$slot, element$name)

    ## Create additional classes for the ListOf types
    element$slot[grepl("ListOf", element$slot)] %>% purrr::map(set_class_list, file)

    ## Write the coercion methods to/from XML/S4
    element$name %>% map(set_coerces)

  } else { ## has no elements
    slots <- list()
  }

  ## FIXME check this xpath: may or may not be inside an xs:choice?
  group <- xml2::xml_find_all(complex_type, "./*/xs:group", ns = ns) %>%
    purrr::map(xml_attr, "ref") %>%
    purrr::map(function(x) gsub(".*:", "", x))

  # all complex types contain 'eml-2.1.1' class as well
  group <- c(group, "eml-2.1.1")

  ## complex_type attributes as slots of type "character"
  att <- xml2::xml_find_all(complex_type, "./xs:attribute | ./xs:simpleContent/xs:extension/xs:attribute", ns = ns) %>%
    purrr::map(xml_attr, "name")
  att <- setNames(rep("character", length(att)), att)

  slots <- c(slots, att)

  ## write R script equiv to evaluating: setClass(class, slots = slots)
  write(sprintf("setClass('%s', slots = c(%s), contains = c(%s))", class, print_cmd(slots), print_cmd(group)), file, append=TRUE)

}


create_classes <- function(xsd_file, file = "classes.R"){

  xsd <- xml2::read_xml(xsd_file)
  ns <- xml2::xml_ns(xsd)

  ## Define class for all elements which declare a type attribute
  typed_elements <- xml2::xml_find_all(xsd, "//xs:element[@type]", ns = ns)
  typed_elements %>% purrr::map(set_class_element, file = file)

  ## Now get those elements without type
  untyped_elements <- xml2::xml_find_all(xsd, "//xs:element[not(@type)]", ns = ns)


  ## For those with one-or-more complexType, define setClass(element-name, slots = <children-of-complex-type)
  untyped_elements %>%
    purrr::map(function(e){
      xml2::xml_find_all(e, "./xs:complexType", ns = ns) %>%
      purrr::map(set_class_complex_type, class = xml_attr(e, "name"), ns = ns, file = file)
    })

  ## For those with a child simpleType, define setClass(element-name, slots = c(element-name = "character")
  xml2::xml_find_all(untyped_elements, "./xs:simpleType/..", ns = ns) %>%
    purrr::map(set_class_element, file = file)


  ## Define a class for complextTypes with names
  xml2::xml_find_all(xsd, "//xs:complexType[@name]", ns) %>%
  purrr::map(set_class_complex_type, ns = ns, file = file)

  TRUE

}


##
file.remove("classes.R")
file.remove("methods.R")
create_classes("../inst/xsd/eml-access.xsd")
#create_classes("../inst/xsd/eml-attribute.xsd")

#  xsd_file <- "../inst/xsd/eml-access.xsd"; xsd <- xml2::read_xml(xsd_file); ns <- xml2::xml_ns(xsd);
