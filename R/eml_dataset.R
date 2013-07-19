#' Function to create an EML Dataset node
#' 
#' 
#' @references Normative technical specification given at
#' http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-dataset.html
#' @param ... arguments to \code{\link{eml_dataTable}}
#' @param .contact a list of arguments to \code{\link{eml_contact}}
#' @param .creator a list of arguments to \code{\link{eml_creator}}
#' @param .methods a list of arguments to \code{\link{eml_methods}}
#' @param .coverage a list of arguments to \code{\link{eml_coverage}}
#' @import XML
#' @import XMLSchema 
eml_dataset <- function(..., .title = "Unnamed", .creator=list(), .contact=list(), .methods=list(), .coverage=list()){
  dataset <- newXMLNode("dataset")
  title <- newXMLNode("title", .title)
  addChildren(dataset, title)

  creator <- do.call(eml_person, c(person_type="creator", .contact))
  addChildren(dataset, creator)
  contact <- do.call(eml_person, c(person_type="contact", .creator)) 
  addChildren(dataset, contact)

  if(!is.empty(.coverage)){
   coverage <- do.call(eml_coverage, .coverage)
   addChildren(dataset, coverage)
  }
  
  ## Methods node
  methods_node <- newXMLNode("methods", parent=dataset)
  if(!is.empty(.methods)){
   methods_node <- 
     do.call(eml_methods, 
             c(node = methods_node,
               .methods))
  }
  ## In Methods node we note that the EML was generated in reml software
  methodsStep <- newXMLNode("methodsStep", parent = methods_node)
  addChildren(methodsStep, eml_R_software("reml"))
  addChildren(methodsStep, 
              newXMLNode("description", 
                         packageDescription("reml", fields="Description")))
#  addChildren(methodsStep, 
#              newXMLNode("citation", eml_R_citation("reml")))



  dataTable <- eml_dataTable(...)
  addChildren(dataset, dataTable)

  dataset
} 




# We want to provide several mechanisms to specify each
# Child Node of the dataset.
#   (a) Copy from template, possibly update
#   (b) pass a completed node 
#   (c) Generate the node from an R object 
# Equivalently: addParent(title_node, parent)
# We don't want to just clone dataset, since we want to be able to assemble dataset from existing nodesets. 


# # Required 
# "title"
# "creator" (multiple)  
# "contact"    
# "dataTable"
# 
# # Optional  (not all given in the schema Type documentation...)
# "associatedParty"    (kind of like creator or co-author)
# "pubDate"
# "abstract" 
# "keywordSet" (multiple, specify thesaurus) 
# "intellectualRights" 
# "distribution"
# "coverage" 
# "publisher"
# "methods"
# "otherEntity"
