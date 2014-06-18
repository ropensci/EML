#' constructor function to generate keywords
#' 
#' constructor function to generate keywords
#' @param x a list of character vectors, named by keywordThesaurus. See examples
#' @return a keywordSet EML object
#' @examples
#' keys <- eml_keyword(list(
#' "LTER controlled vocabulary" = c("bacteria", 
#'                                  "carnivorous plants", 
#'                                  "genetics", 
#'                                  "thresholds"),
#'             "LTER core area" = c("populations", 
#'                                  "inorganic nutrients", 
#'                                  "disturbance"),
#'                "HFR default" = c("Harvard Forest", 
#'                                  "HFR", 
#'                                  "LTER", 
#'                                  "USA")))
#'
#' data("ex")
#' # eml(dat, keywordSet = keys, contact = "John Smith <john@@example.com>")
#' @export 
eml_keyword <- function(x){
# expects x is a list of character vectors, named by keywordThesaurus
  out <- new("ListOfkeywordSet", lapply(x, 
    function(y){
      new("keywordSet", 
          keyword = new("ListOfkeyword", 
                        lapply(y, function(z) 
                               new("keyword", keyword = z))))
  }))
  thes <- names(x)
  for(i in 1:length(thes)){
    out[[i]]@keywordThesaurus <- thes[i]
  }
  out
}


