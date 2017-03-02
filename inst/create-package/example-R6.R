

## FIXME must define ordering of fields.
## define validation?  define choiceOf / exclusive elements?
coverage <- R6Class('coverage',
  inherit = idNode,
  public = list(
    geographicCoverage = NULL,
    temporalCoverage = NULL,
    taxonomicCoverage = NULL,
    references = NULL,
    initialize = function(){
      self$geographicCoverage = list(geographicCoverage$new())
      self$temporalCoverage = list(temporalCoverage$new())
      self$taxonomicCoverage = list(taxonomicCoverage$new())
      self$references = references$new()
    })
)

idNode <- R6Class("idNode",
                  public = list(
                    attr = c(id = NA, system = NA, scope = NA)
                  ))


geographicCoverage <- R6Class("geographicCoverage",
                              public = list(
                                boundingCoordinates = NULL)
                              )

taxonomicCoverage <- R6Class("taxonomicCoverage",
                              public = list(
                                x = NULL)
)


temporalCoverage <- R6Class("temporalCoverage",
                             public = list(
                               x = NULL)
)


references <- R6Class("references",
                            public = list(
                              x = NULL)
)


## FIXME must obey ordering of child elements
r6_to_xml <- function(obj, root){

    node_name <- class(obj)[[1]]
    fields <- public_fields(obj)
    xml <- xml_add_child(root, node_name)

    lapply(fields, function(child){
      node <- get(child, obj)
      if(is.null(node)){
        xml
      } else if(child == "attr"){
        xml_set_attrs(xml, node[!is.na(node)])
      } else if(is(node, "R6")){
        r6_to_xml(node, xml)
      } else if(is(node, "list")){
        lapply(node, r6_to_xml, xml) # side-effect
        root
      } else {
        xml_add_child(xml, child, node)
      }
    })

    empty <- "//*[not(*)][not(normalize-space())]"
    xml_remove(xml_find_all(root, empty))

    root
}

## Fixme return public fields in ordering requested
public_fields <- function(obj, exclude = NULL){
  who <- names(obj)
  who <- setdiff(who, c(exclude, ".__enclos_env__"))
  fields <- mget(who, obj)
  methods <- vapply(fields, is.function, logical(1))
  who[!methods]
}
public_methods <- function(obj){}






## Create a test element
x <- Coverage$new()
x$geographicCoverage[[1]]$boundingCoordinates <- 123


eml <- xml_new_root("eml",  xmlns = "eml://ecoinformatics.org/eml-2.1.1")
r6_to_xml(x, eml)

write_xml(eml, "test.xml")
