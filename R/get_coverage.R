
# `get` methods are perhaps less necessary?  `set` methods can write a subset, `get` methods have to be more generic


## cannot necessarily extract a species name from a taxonomicCoverage.


#' get_taxanomicCoverage
#'
#' @param taxonomicCoverage a taxonomicCoverage EML element
#'
#' @return a data frame with column for rank and column for value, see examples
#' @export
#'
#' @examples
#' f <- system.file("xsd/test/eml-i18n.xml", package="EML")
#' eml <- read_eml(f)
#' df <- EML:::get_taxonomicCoverage(eml@dataset@coverage@taxonomicCoverage)
get_taxonomicCoverage <- function(taxonomicCoverage){
  lapply(taxonomicCoverage[[1]]@taxonomicClassification, taxa_to_df)[[1]]
  
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
