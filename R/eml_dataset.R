#' Function to create an EML Dataset node
#' 
#' 
#' @references Normative technical specification given at
#' http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-dataset.html
#' @param ... arguments to \code{\link{eml_dataTable}}
#' @param .contact a list of argumens to \code{\link{eml_contact}}
#' @import XML
#' @import XMLSchema 
eml_dataset = function(..., .title = "Unnamed", .creator=list(), .contact=list()){
  browser()
  dataset = newXMLNode("dataset")
  title = newXMLNode("title", .title)
  addChildren(dataset, title)
  dataTable = eml_dataTable(...)

  creator = do.call(eml_creator, .contact)
  addChildren(dataset, creator)
  contact = do.call(eml_contact, .contact)
  addChildren(dataset, contact)
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
