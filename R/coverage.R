set_coverage <- function(){}




######## Geographic Coverage ####################

set_geographicCoverage <- function(box, description){
  box <- sapply(box, as.character) # FIXME S4 should use numerics
  if(is.null(names(box)))
    names(box) <- c("west", "east", "north", "south")
  new(
    "geographicCoverage",
    geographicDescription = description,
    boundingCoordinates = new(
      "boundingCoordinates",
      westBoundingCoordinate = box[["west"]],
      eastBoundingCoordinate = box[["east"]],
      northBoundingCoordinate = box[["north"]],
      southBoundingCoordinate = box[["south"]]
    )
  )
}


############ Temporal Coverage #################


######## Taxonomic Coverage ####################

## Turn a string of scientific names into a taxonomicCoverage block

## not the inverse of get_taxonomicCoverage!
set_taxonomicCoverage <- function(sci_names){
  taxa = lapply(sci_names, function(sci_name){
    s <- strsplit(sci_name, " ")[[1]]
    new("taxonomicClassification",
        taxonRankName = "genus",
        taxonRankValue = s[[1]],
        taxonomicClassification = c(new("taxonomicClassification",
                                        taxonRankName = "species",
                                        taxonRankValue = s[[2]])))
  })
  new("taxonomicCoverage",
      taxonomicClassification = do.call(c, taxa))
}

## cannot necessarily extract a species name from a taxonomicCoverage.
get_taxonomicCoverage <- function(taxonomicCoverage){
  lapply(taxonomicCoverage[[1]]@taxonomicClassification, taxa_to_df)

}



taxa_to_df <- function(object){
  df <- data.frame(rank = character(), value = character())
  while(length(object@taxonomicClassification) > 0){
    df <- rbind(df, data.frame(rank = object@taxonRankName,
                               value = object@taxonRankValue))
    object <- object@taxonomicClassification[[1]]
  }
  df <- rbind(df, data.frame(rank = object@taxonRankName,
                             value = object@taxonRankValue))
  df
}
