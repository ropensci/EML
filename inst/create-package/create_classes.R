## ToDo:
# - [ ] Must declare ListOf when MaxOccurs is given inside xs:choice instead of xs:element!!
# - [ ] xml_attribute should just be XMLAttribute
# - [ ] Write out documentation strings (as roxygen?...) xs:annotation
# - [ ] get xs:restriction
# - [ ] Generate constructor functions
# - [ ] Should we be capturing required vs optional elements (e.g. add a class to indicate?) (what about choice-of?)


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



sanitize_type <- function(type, name, children, extension){
  ext_as_type <- is.na(type) & !is.na(extension)
  type[ext_as_type] <- extension[ext_as_type]

  name_as_type <- is.na(type) & children
  char_as_type <- is.na(type) & !children

  type[name_as_type] <- name[name_as_type]
  type[char_as_type] <- "character"

  str_type <- grepl(c("NonEmptyStringType"), type)
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
  write(sprintf("setClass('%s', contains = 'list')", class), class_file, append = TRUE)
}

set_class_element <- function(element, ns = character(),
                              class_file = "classes.R", methods_file = "methods.R", maxOccurs = NA){

  ## This should share more code with element_attr_table
  class <- xml2::xml_attr(element, "name")
  type <- xml2::xml_attr(element, "type")
  type <- sanitize_type(name = class, type = type,
                        children = has_children(element, ns),
                        extension = has_extension(element, ns))
  maxOccurs <- xml2::xml_attr(element, "maxOccurs")
  multiples <- !(is.na(maxOccurs) | maxOccurs == 1)

#  if(multiples | type != "character"){
    write(sprintf("setClass('%s', contains = '%s')", class, type), class_file, append = TRUE)
    set_coerces(class, methods_file)
#  }
}


set_class_simpletype <- function(element, class = xml2::xml_attr(element, "name"),
                                 ns = character(), class_file = "classes.R", methods_file = "methods.R"){

    type <- xml2::xml_attr(element, "type")
  type <- sanitize_type(name = class, type = type,
                        children = has_children(element, ns),
                        extension = has_extension(element, ns))
  write(sprintf("setClass('%s', contains = '%s')", class, type), class_file, append = TRUE)
  set_coerces(class, methods_file)
}



#' @importFrom dplyr as_data_frame
set_class_complextype <- function(complex_type,
                                  ns = character(),
                                  class_file = "classes.R",
                                  methods_file = "methods.R",
                                  class = NA){

  maxOccurs <- xml_attr(complex_type, "maxOccurs")

  #### All possible children of complexType ####
  documentation <- xml_find_all(complex_type, "./xs:annotation", ns)
  simple_types <- xml_find_all(complex_type, "./xs:simpleType", ns)
  groups <- xml_find_all(complex_type, "./xs:group", ns)
  complex_types <- xml_find_all(complex_type, "./xs:complexType", ns)
  elements <- xml_find_all(complex_type, "./xs:element", ns)
  choice <- xml2::xml_find_all(complex_type, "./xs:choice", ns)
  sequence <- xml2::xml_find_all(complex_type, "./xs:sequence", ns)
  attrib <- xml2::xml_find_all(complex_type, "./xs:attribute", ns)
  simple_content <- xml2::xml_find_all(complex_type, "./xs:simpleContent", ns)
  complex_content <- xml2::xml_find_all(complex_type, "./xs:complexContent", ns)
  extensions <- xml_find_all(complex_type, "./xs:extension", ns)


  #### Create these additional classes ####
  simple_types %>%  purrr::map(set_class_simpletype, ns = ns,
                              class_file = class_file,
                              methods_file = methods_file)

  groups %>% purrr::map(set_class_complextype, ns = ns,
                       class_file = class_file, methods_file = methods_file)

  complex_types %>% purrr::map(set_class_complextype, ns = ns,
                              class_file = class_file, methods_file = methods_file)

  elements %>% purrr::map(set_class_element, ns = ns,
                         class_file = class_file, methods_file = methods_file, maxOccurs = maxOccurs)

  ##  should pass maxOccurs
  choice %>% purrr::map(set_class_complextype, ns = ns,
                        class_file = class_file, methods_file = methods_file) -> choice_children

  ## Should use "sequence" version of method, which makes a shadowlist of sequence has attribute maxOccurs
  sequence %>% purrr::map(set_class_complextype, ns = ns,
                        class_file = class_file, methods_file = methods_file) -> sequence_children

  choice_children <- unlist(choice_children, recursive = FALSE)
  sequence_children <- unlist(sequence_children, recursive = FALSE)

  ## Now to define the focal class.
  # contains:
  #   .[child::xs:simpleContent | child::xs:complexContent]/*/xs:extension[@base]
  #   xs:group[@ref]
  #   "contains" from any xs:choice or xs:sequence chain.
  # slots:
  #   elements
  #   attributes
  #   simpleContent/*/attribute



  ## FIXME choice slots may not come before element slots...
  slots <- c(
    choice_children$slots,
    sequence_children$slots,
    attrib_to_slots(attrib),
    elements_to_slots(elements, ns = ns, maxOccurs = maxOccurs, class_file = class_file))

  contains <- c(
    choice_children$contains,
    sequence_children$contains,
    groups %>% purrr::map(xml_attr, "ref") %>% strip_namespace(),
    extensions %>% purrr::map(xml_attr, "base") %>% strip_namespace(),
    "eml-2.1.1"
  )

  ## Drop repeated elements from contains list
  contains <- unique(contains)

  mixed <- xml_attr(complex_type, "mixed")
  if(!is.na(mixed) & mixed=="true"){
    contains <- c("character", contains)
  }

  ## Inherit class
  if(is.na(class)){
    class <- xml2::xml_attr(complex_type, "name")
  }

  if(!is.na(class)){  ## if we have a named element, then we declare a class

    if(length(slots) > 0){
      write(sprintf("setClass('%s', slots = c(%s), contains = c(%s))", class,
                    print_cmd(slots), print_cmd(contains)), class_file, append=TRUE)
    } else {
      write(sprintf("setClass('%s', contains = c(%s))", class, print_cmd(contains)), class_file, append=TRUE)
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
    att <- att_df$name
    setNames(rep("xml_attribute", length(att)), att)
  } else {
    list()
  }
}

elements_to_slots <- function(elements, ns, maxOccurs = NA, class_file = "classes.R"){
  if(length(elements) > 0){
    df <- element_attrs_table(elements, ns = ns, maxOccurs = maxOccurs)

    ## Go ahead and define ListOf classes now
    unique(element$slot[grepl("ListOf", element$slot)]) %>%
      purrr::map(set_class_list, class_file = class_file)


    setNames(df$slot, df$name)

  } else {
    list()
  }
}



## Main method #######


create_classes <- function(xsd_file,
                           ns = character(),
                           class_file = paste0("R/", filename(xsd_file), "-classes.R"),
                           methods_file = paste0("R/", filename(xsd_file), "-methods.R")){
  xsd <- xml2::read_xml(xsd_file)
  imports <- xml_find_all(xsd, "./xs:import", ns)
  documentation <- xml_find_all(xsd, "./xs:annotation", ns)

  ## (all top-level elements should be named, since no name to inherit)

  simple_type <- xml_find_all(xsd, "./xs:simpleType", ns)
  simple_type %>%  purrr::map(set_class_simpletype, ns = ns,
               class_file = class_file, methods_file = methods_file)

  ##
  group <- xml_find_all(xsd, "./xs:group", ns)
  group %>% purrr::map(set_class_complextype, ns = ns,
               class_file = class_file, methods_file = methods_file)

  complex_type <- xml_find_all(xsd, "./xs:complexType", ns)
  complex_type %>% purrr::map(set_class_complextype, ns = ns,
               class_file = class_file, methods_file = methods_file)

  element <- xml_find_all(xsd, "./xs:element", ns)
  element %>% purrr::map(set_class_element, ns = ns,
               class_file = class_file, methods_file = methods_file)

}






















################ deprecated



stuff <- function(){





}

