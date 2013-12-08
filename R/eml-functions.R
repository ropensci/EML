#' @include generics.R


## Accessor / Extractor method for keywords 
setMethod("keywords", signature("keywordSet"), 
          function(object){
           unname(sapply(object@keyword, slot, "keyword"))
          }
         )

