


## Creates a 'show' method so that eml S4 elements display in XML format instead of the
## impossible-to-read S4 format
setMethod("show", signature("eml-2.1.1"), function(object){
  tmp <- tempfile()
  write_eml(object, tmp, namespaces = character(), ns = character(), options = c("format", "no_declaration"))
  cat(readLines(tmp), sep="\n")
})
