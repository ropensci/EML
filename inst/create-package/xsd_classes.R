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
element_attrs_table <- function(elements, ns = character()){
  df <- elements %>% purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
    column_check()

  nans <- is.na(df$maxOccurs)
  df$maxOccurs[nans] <- attr(elements, "maxOccurs")[[1]]
  df$children <- elements %>% purrr::map_lgl(has_children, ns)
  df$extension <- elements %>% purrr::map_chr(has_extension, ns = ns)

  df %>%
    ref_as_name() %>%
    dplyr::mutate(type = sanitize_type(type, name, children, extension)) %>%
    dplyr::mutate(slot = slotify(name, type, maxOccurs))

}



#### Functions that write R code as output #############################

set_dummy_class <- function(class, file = "classes.R", methods_file = "methods.R"){
  write(sprintf("setClass('%s')", class), file, append = TRUE)
  set_coerces(class, methods_file)
}


set_coerces <- function(class, file = "methods.R"){
  write(sprintf("setAs('%s', 'XMLInternalElementNode',   function(from) S4Toeml(from))", class), file, append = TRUE)
  write(sprintf("setAs('XMLInternalElementNode', '%s',  function(from) emlToS4(from))", class), file, append = TRUE)
}

set_class_list <- function(class, file = "classes.R"){
  write(sprintf("setClass('%s', contains = 'list')", class), file, append = TRUE)
}

set_class_element <- function(element, ns = character(), file = "classes.R", methods_file = "methods.R"){
  class <- xml2::xml_attr(element, "name")
  type <- xml2::xml_attr(element, "type")
  type <- sanitize_type(name = class, type = type,
                        children = has_children(element, ns),
                        extension = has_extension(element, ns))
  maxOccurs <- xml2::xml_attr(element, "maxOccurs")
  multiples <- !(is.na(maxOccurs) | maxOccurs == 1)

  if(multiples | type != "character"){
    write(sprintf("setClass('%s', contains = '%s')", class, type), file, append = TRUE)
    set_coerces(class, methods_file)
  }
}

set_class_simpletype <- function(element, class = xml2::xml_attr(element, "name"), ns = character(), file = "classes.R", methods_file = "methods.R"){
  type <- xml2::xml_attr(element, "type")
  type <- sanitize_type(name = class, type = type,
                        children = has_children(element, ns),
                        extension = has_extension(element, ns))
  write(sprintf("setClass('%s', contains = '%s')", class, type), file, append = TRUE)
  set_coerces(class, methods_file)
}


parse_elements <- function(nodes, ns = character()){
  children <- xml2::xml_find_all(nodes, "./xs:choice | ./xs:sequence | ./xs:all", ns = ns)
  maxOccurs <- children %>% purrr::map(xml_attr, "maxOccurs")
  elements <- xml2::xml_find_all(children, "./xs:element", ns = ns)
  attr(elements, "maxOccurs") <- maxOccurs
  if(length(elements) == 0){
    children <- xml2::xml_find_all(children, "./xs:choice | ./xs:sequence | ./xs:all", ns = ns)
    maxOccurs <- children %>% purrr::map(xml_attr, "maxOccurs")
    elements <- xml2::xml_find_all(children, "./xs:element", ns = ns)
    attr(elements, "maxOccurs") <- maxOccurs
    if(length(elements) == 0){
      children <- xml2::xml_find_all(children, "./xs:choice | ./xs:sequence | ./xs:all", ns = ns)
      maxOccurs <- children %>% purrr::map(xml_attr, "maxOccurs")
      elements <- xml2::xml_find_all(children, "./xs:element", ns = ns)
      attr(elements, "maxOccurs") <- maxOccurs
      #elements <- parse_elements(children, ns = ns)
    }
    #elements <- parse_elements(children, ns = ns)
  }
  elements
}


#' @importFrom dplyr as_data_frame
set_class_complex_type <- function(complex_type,
                                   class = xml2::xml_attr(complex_type, "name"),
                                   ns = character(), file = "classes.R", methods_file = "methods.R"){


  ## Get all immediate child elements in the complex_type (except those that are inside another complex type)
  # "*" here should really be just one of the schema indicator terms, http://www.w3schools.com/xml/schema_complex_indicators.asp
  # e.g. ".[child::xs:choice | child::xs:sequence | child::xs:all]".  Unclear what depth it could be between xs:element and xs:complexType

  ## FIXME if one of those * is an xs:choice with maxOccurs="unbounded" then we need a list type!
  ## e.g. ./xs:choice/xs:choice[@maxOccurs = 'unbounded']/xs:element[@name,@type]
  ### should inherit the @maxOccurs attr from the parent!

  #elements <- xml2::xml_find_all(complex_type, "./*/*/*/xs:element | ./*/*/xs:element | ./*/xs:element", ns = ns)
   elements <- parse_elements(complex_type, ns = ns)


  ## Define class for the complex_type with a slot for each element. First, determine slot types:
  if(length(elements) > 0){
    element <- element_attrs_table(elements, ns = ns)

    ## Go ahead and define ListOf classes now
    unique(element$slot[grepl("ListOf", element$slot)]) %>%
           purrr::map(set_class_list, file = file)

    slots <- setNames(element$slot, element$name)

  } else { ## has no elements
    slots <- list()
  }

  ## FIXME check this xpath: may or may not be inside an xs:choice?
  group <- xml2::xml_find_all(complex_type, "./*/xs:group[@ref] | ./*/*/xs:group[@ref] | ./*/*/xs:group[@ref]", ns = ns) %>%
    xml_attr("ref") %>%
    strip_namespace()

  # all complex types contain 'eml-2.1.1' class as well
  contains <- c(group, "eml-2.1.1")

  mixed <- xml_attr(complex_type, "mixed")
  if(!is.na(mixed) & mixed=="true"){
    contains <- c("character", contains)
  }

  ## complex_type attributes as slots of type "character"
  att_df <- xml2::xml_find_all(complex_type, "./xs:attribute | ./xs:simpleContent/xs:extension/xs:attribute", ns = ns) %>%
    purrr::map_df(function(x) dplyr::as_data_frame(as.list(xml2::xml_attrs(x)))) %>%
    ref_as_name()
  att <- att_df$name
  att <- setNames(rep("xml_attribute", length(att)), att)
  slots = c(slots, att)

  ## Get any element extension
  extension <- xml2::xml_find_all(complex_type, "./xs:simpleContent/xs:extension | ./xs:complexContent/xs:extension", ns = ns) %>%
    purrr::map(xml_attr, "base") %>%
    strip_namespace()
  contains <- c(extension, contains)

  if(length(slots) > 0){
    write(sprintf("setClass('%s', slots = c(%s), contains = c(%s))", class, print_cmd(slots), print_cmd(contains)), file, append=TRUE)
  } else {
    write(sprintf("setClass('%s', contains = c(%s))", class, print_cmd(contains)), file, append=TRUE)
  }
  set_coerces(class, methods_file)
}

## function(class)
## Declare a method making it easier to create "new" when object is a list.
#  paste0("setMethod('initialize', '", class, "'\n",
#             function(.Object, ...){
#              gsub(.Object@VAR <- new("ListOfVAR", lapply(VAR, function(x) new("VAR", x)))
#
#              .Object@surName <- surName
#              .Object
#            })
## Declare a method making it easier to create "new" when object is a list.
#  setMethod("initialize", "Person",
#            function(.Object, salutation=character(0), givenName=character(0), surName){
#              .Object@salutation <- new("ListOfsalutation", lapply(salutation, function(x) new("salutation", x)))
#              .Object@givenName <- new("ListOfgivenName", lapply(givenName, function(x) new("givenName", x)))
#              .Object@surName <- surName
#              .Object
#            })







## Main method #######
create_classes <- function(xsd_file,
                           classes_file = paste0("R/", filename(xsd_file), "-classes.R"),
                           methods_file = paste0("R/", filename(xsd_file), "-methods.R"),
                           ns = xml2::xml_ns(xml2::read_xml(xsd_file))){

  xsd <- xml2::read_xml(xsd_file)
  write(paste0("\n\n#####  ", xsd_file, "  ####\n\n"), classes_file, append = TRUE)


  ## Create all named <xs:simpleType> elements:
  xml2::xml_find_all(xsd, "//xs:simpleType[@name]", ns = ns) %>%
    purrr::map(set_class_simpletype, ns = ns, file = classes_file, methods_file = methods_file)

  ## Create additional ListOf classes for any element that can appear multiple times
 # named_elements <- xml2::xml_find_all(xsd, "//xs:element[@name] | //xs:element[@ref]", ns = ns)
 #   if(length(named_elements) > 0){
 #    element <- element_attrs_table(named_elements, ns = ns)
 #   unique(element$slot[grepl("ListOf", element$slot)]) %>%
 #      purrr::map(set_class_list, file = classes_file)
#  }

  ## Now get those <xs:element> nodes without a type
  ## For those with one-or-more complexType, define setClass(element-name, slots = <children-of-complex-type)
  untyped_elements <- xml2::xml_find_all(xsd, "//xs:element[@name and not(@type)]", ns = ns)
  untyped_elements %>%
    purrr::map(function(e){
      xml2::xml_find_all(e, "./xs:complexType", ns = ns) %>%
      purrr::map(set_class_complex_type, class = xml_attr(e, "name"), ns = ns, file = classes_file, methods_file = methods_file)
    })
  untyped_elements %>%
    purrr::map(function(e){
      xml2::xml_find_all(e, "./xs:simpleType", ns = ns) %>%
        purrr::map(set_class_simpletype, class = xml_attr(e, "name"), ns = ns, file = classes_file, methods_file = methods_file)
    })



  ## Define a class for named xs:group
  xml2::xml_find_all(xsd, "//xs:group[@name]", ns) %>%
    purrr::map(set_class_complex_type, ns = ns, file = classes_file, methods_file = methods_file)


  ## Define a class for complexTypes with names
  xml2::xml_find_all(xsd, "//xs:complexType[@name]", ns) %>%
  purrr::map(set_class_complex_type, ns = ns, file = classes_file, methods_file = methods_file)


  ## Define class for all elements which declare a type attribute
  typed_elements <- xml2::xml_find_all(xsd, "//xs:element[@type]", ns = ns)
  typed_elements %>% purrr::map(set_class_element, ns = ns, file = classes_file, methods_file = methods_file)


  TRUE
}
