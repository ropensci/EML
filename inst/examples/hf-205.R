library("eml2")

#eml = read_eml("https://raw.githubusercontent.com/ropensci/EML/master/inst/examples/hf205.xml")

HF_address <- new("address",
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA")
publisher <- new("publisher",
                 organizationName = "Harvard Forest",
                 address = c(HF_address))

aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")
contact <- as(aaron, "contact")
contact@address = HF_address
contact@organizationName = "Harvard Forest"
contact@phone = "000-000-0000"

keys <-
  c(new("keywordSet",
        keywordThesaurus = "LTER controlled vocabulary",
        keyword = c("bacteria",
                    "carnivorous plants",
                    "genetics",
                    "thresholds")),
    new("keywordSet",
        keywordThesaurus = "LTER core area",
        keyword =  c("populations", "inorganic nutrients", "disturbance")),
    new("keywordSet",
        keywordThesaurus = "HFR default",
        keyword = c("Harvard Forest", "HFR", "LTER", "USA")))

new("coverage", new("taxonomicCoverage"))


set_coverage <- function()

description <- "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"
box <- c(-122.44, -117.15, 37.38, 30.00)

set_geographicCoverage(box, description)

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
## Turn a string of scientific names into a taxonomicCoverage block
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
