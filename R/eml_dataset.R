#' Function to create an EML Dataset node
#' 
#' 
#' @references Normative technical specification given at
#' http://knb.ecoinformatics.org/software/eml/eml-2.1.1/eml-dataset.html
#' 
#' @import XML
#' @import XMLSchema 

## Add 

dataset = function(...){

# We want to provide several mechanisms to specify each
# Child Node of the dataset.
#   (a) Copy from template, possibly update
#   (b) pass a completed node 
#   (c) Generate the node from an R object 

newXMLNode("alternateIdentifier", parent = dataset)

root = xmlRoot(template)
dataset = root[["dataset"]]

title_node = xmlClone(dataset[["title"]])
xmlValue(title_node) = title
addChildren(parent, title_node)


# Equivalently: addParent(title_node, parent)
# We don't want to just clone dataset, since we want to be able to assemble dataset from existing nodesets.  

"title"
"creator" (multiple)  
"associatedParty"    (kind of like creator or co-author)
"pubDate"
"abstract" 
"keywordSet" (multiple, specify thesaurus) 
"intellectualRights" 
"distribution"
"coverage" 
"contact"    
"publisher"
"methods"
"dataTable"
"otherEntity"
".attrs"    
