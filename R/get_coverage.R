

#' get_taxonomicCoverage
#'
#' @param taxonomicCoverage a taxonomicCoverage class object
#' @details extract information from a taxonomicCoverage object and construct a data frame
#'
#' @return a data frame with rank names as column names
#' @export
#'
#' @examples
#' f <- system.file("xsd/test/eml-i18n.xml", package="EML")
#' eml <- read_eml(f)
#' df <- get_taxonomicCoverage(eml@dataset@coverage@taxonomicCoverage)

# return a data frame whose column names are rank names
get_taxonomicCoverage <- function(taxonomicCoverage) {
  df <-
    lapply(taxonomicCoverage[[1]]@taxonomicClassification, taxa_to_df)[[1]]
  df <- t(as.data.frame(df))
  colnames(df) <- df[1, ]
  df <- t(as.data.frame(df[-1, ]))
  rownames(df) <- NULL
  as.data.frame(df)
}

taxa_to_df <- function(object) {
  df <- data.frame(rank = character(), value = character())
  while (length(object@taxonomicClassification) > 0) {
    df <- rbind(df,
                data.frame(
                  rank = object@taxonRankName,
                  value = object@taxonRankValue
                ))
    object <- object@taxonomicClassification[[1]]
  }
  df <- rbind(df,
              data.frame(
                rank = object@taxonRankName,
                value = object@taxonRankValue
              ))
  df
}
