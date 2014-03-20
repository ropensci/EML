
#' @import uuid 
EML_id <- function(prefix="EML_", uuid = TRUE) {
    if(uuid){
      id <- paste0("urn:uuid:", uuid::UUIDgenerate())
      scope <- "system"
      system <- "uuid"
    } else {
      id <- paste(prefix, format(Sys.time(), "%Y%m%d%H%M%s"), "1", sep=".")
      scope <- "system"
      system <- "EML"
    }
    c(id = id, system = system, scope = scope)
  }

