
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


#
#setAs("list", "keywordSet", function(from){
#
#})
