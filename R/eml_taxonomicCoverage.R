

## Constructor for `taxonomicCoverage` class
eml_taxonomicCoverage <- function(scientific_names){
  if(is(scientific_names, "taxonomicCoverage"))
    scientific_names
  else 
    new("taxonomicCoverage", 
      taxonomicClassification = 
      new("ListOftaxonomicClassification", 
          lapply(scientific_names, as, "taxonomicClassification")))
}





