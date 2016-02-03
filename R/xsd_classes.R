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
  strip_namespace(type)
}

strip_namespace <- function(x){
  if(length(x) > 0){
    if(grepl("^xs:",  x))
      x
    else if(grepl("^xsd:",  x))
      x <- gsub("^.*:(.*)", "xs:\\1", x)
    else
      x <- gsub("^.*:", "", x)
  }
  x
}

set_dummy_class <- function(class, file = "classes.R"){
  write(sprintf("setClass('%s')", class), file, append = TRUE)
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

  #setClass(class, contains = type)
  write(sprintf("setClass('%s', contains = '%s')", class, type), file, append = TRUE)
}


slotify <- function(type, maxOccurs){
  multiples <- !(is.na(maxOccurs) | maxOccurs == 1)
  type[multiples] <- paste0("ListOf", type[multiples])
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
  nans <- is.na(df$name)
  df$name[nans] <- df$ref[nans]
  df
}

#' @importFrom dplyr mutate
element_attrs_table <- function(elements){

  elements %>%
      purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
      column_check() %>%
      ref_as_name() %>%
      dplyr::mutate(type = sanitize_type(type, name)) %>%
      dplyr::mutate(slot = slotify(type, maxOccurs))

}


#' @importFrom dplyr as_data_frame
set_class_complex_type <- function(complex_type,
                                   class = xml2::xml_attr(complex_type, "name"),
                                   ns = character(), file = "classes.R"){


  ## Get all immediate child elements in the complex_type
  elements <- xml2::xml_find_all(complex_type, "./*/*/xs:element | ./*/xs:element", ns = ns)

  ## Define class for the complex_type with a slot for each element. First, determine slot types:
  if(length(elements) > 0){
    element <- element_attrs_table(elements)
    slots <- setNames(element$slot, element$name)

  } else { ## has no elements
    slots <- list()
  }

  ## FIXME check this xpath: may or may not be inside an xs:choice?
  group <- xml2::xml_find_all(complex_type, "./*/xs:group", ns = ns) %>%
    xml_attr("ref") %>%
    strip_namespace()

  # all complex types contain 'eml-2.1.1' class as well
  contains <- c(group, "eml-2.1.1")

  ## complex_type attributes as slots of type "character"
  att <- xml2::xml_find_all(complex_type, "./xs:attribute | ./xs:simpleContent/xs:extension/xs:attribute", ns = ns) %>%
    xml_attr("name")
  att <- setNames(rep("character", length(att)), att)

  ## Get any simpleType element extension
  extension <- xml2::xml_find_all(complex_type, "./xs:simpleContent/xs:extension", ns = ns) %>%
    purrr::map(xml_attr, "base") %>%
    strip_namespace()
  contains <- c(extension, contains)

  if(length(slots) > 0){
    write(sprintf("setClass('%s', slots = c(%s), contains = c(%s))", class, print_cmd(slots), print_cmd(contains)), file, append=TRUE)
  } else {
    write(sprintf("setClass('%s', contains = c(%s))", class, print_cmd(contains)), file, append=TRUE)
  }
}

xs_base_classes <- function(file = "classes.R"){
  data.frame(class =    c("xs:float", "xs:string", "xs:anyURI", "xs:time", "xs:decimal", "xs:int", "xs:unsignedInt", "xs:unsignedLong", "xs:long", "xs:integer", "xs:boolean", "xs:date"),
             contains = c("numeric", "character", "character", "character", "numeric", "integer", "integer", "integer", "integer", "integer", "logical", "Date")) %>%
  purrr::by_row(function(x)
    write(sprintf("setClass('%s', contains = '%s')", x[["class"]], x[["contains"]]), file, append = TRUE)
  )
}


create_classes <- function(xsd_file, classes_file = "classes.R", methods_file = "methods.R",
                           ns = xml2::xml_ns(xml2::read_xml(xsd_file))){

  xsd <- xml2::read_xml(xsd_file)

  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), classes_file, append = TRUE)

  ## Create all named <xs:simpleType> elements:
  xml2::xml_find_all(xsd, "//xs:simpleType[@name]", ns = ns) %>%
    purrr::map(set_class_element, file = classes_file)

  ## Now get those <xs:element> nodes without a type
  ## For those with one-or-more complexType, define setClass(element-name, slots = <children-of-complex-type)
  untyped_elements <- xml2::xml_find_all(xsd, "//xs:element[@name and not(@type)]", ns = ns)
  untyped_elements %>%
    purrr::map(function(e){
      xml2::xml_find_all(e, "./xs:complexType", ns = ns) %>%
      purrr::map(set_class_complex_type, class = xml_attr(e, "name"), ns = ns, file = classes_file)
    })


  ## Define a class for complexTypes with names
  xml2::xml_find_all(xsd, "//xs:complexType[@name]", ns) %>%
  purrr::map(set_class_complex_type, ns = ns, file = classes_file)


  ## Define class for all elements which declare a type attribute
  typed_elements <- xml2::xml_find_all(xsd, "//xs:element[@type]", ns = ns)
  typed_elements %>% purrr::map(set_class_element, file = classes_file)

  ## Create additional ListOf classes for any element that can appear multiple times
  if(length(typed_elements) > 0){
    element <- element_attrs_table(typed_elements)
    element$slot[grepl("ListOf", element$slot)] %>%
      purrr::map(set_class_list, file = classes_file)
  }

  ## Define coercions
  xml2::xml_find_all(xsd, "//xs:element[@name]", ns = ns) %>%
    purrr::map(xml2::xml_attr, "name") %>%
    set_coerces(file = methods_file)

  TRUE

}



##
#file.remove("classes.R")
#file.remove("methods.R")
#c("eml-2.1.1", "ReferencesGroup", "xs:string") %>% purrr::map(set_dummy_class, "classes.R")

#create_classes("../inst/xsd/eml-text.xsd")
#create_classes("../inst/xsd/eml-documentation.xsd")
#create_classes("../inst/xsd/eml-party.xsd")
#create_classes("../inst/xsd/eml-resource.xsd")
#create_classes("../inst/xsd/eml-access.xsd")
#create_classes("../inst/xsd/eml-attribute.xsd")
#create_classes("../inst/xsd/eml-constraint.xsd")
#create_classes("../inst/xsd/eml-dataset.xsd")
#create_classes("../inst/xsd/eml-dataTable.xsd")



#  xsd_file <- "../inst/xsd/eml-access.xsd"; xsd <- xml2::read_xml(xsd_file); ns <- xml2::xml_ns(xsd);
