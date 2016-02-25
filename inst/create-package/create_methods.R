set_coerces <- function(class, class_file = "methods.R"){
  write(sprintf("setAs('%s', 'XMLInternalNode',   function(from) S4Toeml(from))", class), class_file, append = TRUE)
  write(sprintf("setAs('XMLInternalNode', '%s',  function(from) emlToS4(from))", class), class_file, append = TRUE)
}


create_concat_method <- function(class, methods_file = "methods.R"){
  out = sprintf("
setMethod(c, signature('%s'), function(x, ..., recursive = FALSE) new('ListOf%s', list(x, ...)))", class, class, class)
  write(out, methods_file, append = TRUE)
}

create_initialize_method <- function(slots, class, methods_file = "methods.R"){
  out = ""

  ## Only define this for classes containing at least one ListOf child
  is_listof <- grepl("ListOf", slots)
  if(any(is_listof)){
    if(inherits(class, "character"))
      out <- paste0(out, sprintf("setMethod(initialize, '%s', function(.Object, .Data = character(), %s){", class, print_init(slots)),
                  sep = "; ")
    else if(inherits(class, "list"))
      out <- paste0(out, sprintf("setMethod(initialize, '%s', function(.Object, .Data = list(), %s){", class, print_init(slots)),
                    sep = "; ")
    else if(inherits(class, "numeric"))
      out <- paste0(out, sprintf("setMethod(initialize, '%s', function(.Object, .Data = numeric(), %s){", class, print_init(slots)),
                    sep = "; ")
    else
      out <- paste0(out, sprintf("setMethod(initialize, '%s', function(.Object, %s){", class, print_init(slots)),
                    sep = "; ")

    list_slots <- slots[is_listof]

    if(length(list_slots) > 0){
      for(s in 1:length(list_slots)){
        base <- sub("^ListOf", "", list_slots[[s]])
        name <- names(list_slots)[[s]]

        out <- paste0(out, sprintf(".Object@%s <- c_as(%s, '%s')", base, base, base),
                      sep = "; ")
      }
    }
    plain_slots <- names(slots[!is_listof])

    for(s in plain_slots){
      out <- paste0(out, sprintf(".Object@%s <- as(%s, '%s')", s, s, slots[s]), sep = "; ")
    }
    if(any(sapply(c("list", "character", "numeric"), function(x) inherits("xml_attribute", x))))
      out <- paste0(out, ".Object@.Data <- .Data; .Object })")
    else
      out <- paste0(out, ".Object })")

    write(paste0(out, collapse=";"), methods_file, append = TRUE)
  }

}

# slots = c('salutation' = 'ListOfsalutation', 'givenName' = 'ListOfgivenName', 'surName' = 'surName')

empty_to_zero <- function(char){
  if(char == '')
    char <- character()
  char
}

print_init <- function(l){
  x <- names(l)
  listof <- grepl("ListOf", as.character(l))
  list_set <- character()
  plain_set <- character()
  if(any(listof)){
    list_set <- empty_to_zero(paste(x[listof], '= character()', collapse = ", "))
  }
  if(any(!listof)){
    plain_set <- empty_to_zero(paste0(x[!listof], " = new('", l[!listof], "')", collapse = ", "))
  }
  paste(c(list_set, plain_set), collapse = ", ")

}

#slots <- setNames(list('ListOfsalutation', 'ListOfgivenName', 'surName', 'xml_attribute'), c("salutation", "givenName", "surName", "id"))
#create_initialize_method(slots, "Person")

## should create something like:
# setMethod("initialize", "Person",
#           function(.Object, salutation=character(0), givenName=character(0), surName){
#             .Object@salutation <- do.call(c, lapply(salutation, as, "salutation"))
#             .Object@givenName <- do.call(c, lapply(givenName, as, "givenName"))
#             .Object@surName <- as(surName, "surName")
#             .Object
#           })


## avoid nulls -- here just for reference, must be written to methods file by create_package.R

c_as <- function(x, cls){
  if(length(x) > 0)
    do.call(c, lapply(x, as, cls))
  else
    new(paste0("ListOf", cls))
}
