

set_coerces <- function(class, class_file = "methods.R"){
  write(sprintf("setAs('%s', 'XMLInternalElementNode',   function(from) S4Toeml(from))", class), class_file, append = TRUE)
  write(sprintf("setAs('XMLInternalElementNode', '%s',  function(from) emlToS4(from))", class), class_file, append = TRUE)
}


create_initialize_method <- function(slots, class, methods_file = "methods.R"){

## Only define this for classes containing at least one ListOf child
  is_listof <- grepl("ListOf", slots)
  if(any(is_listof)){

    write(sprintf("setMethod(initialize, '%s',", class), methods_file, append = TRUE)
    write(sprintf("function(.Object, %s){", print_init(slots)), methods_file, append = TRUE)

    list_slots <- slots[is_listof]

    if(length(list_slots) > 0){
      for(s in 1:length(list_slots)){
        base <- sub("^ListOf", "", list_slots[[s]])
        name <- names(list_slots)[[s]]
        write(sprintf(".Object@%s <- new('%s', lapply(%s, function(x) new('%s', x)))", name, list_slots[[s]], name, name), methods_file, append = TRUE)
      }
    }
    plain_slots <- names(slots[!is_listof])

    for(s in plain_slots){
      write(sprintf(".Object@%s <- %s", s, s), methods_file, append = TRUE)
    }

    write(
          ".Object
})",
          methods_file, append = TRUE)
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
#             .Object@salutation <- new("ListOfsalutation", lapply(salutation, function(x) new("salutation", x)))
#             .Object@givenName <- new("ListOfgivenName", lapply(givenName, function(x) new("givenName", x)))
#             .Object@surName <- surName
#             .Object
#           })

