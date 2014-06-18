
#' @import uuid 
eml_id <- function(prefix="EML_", uuid = TRUE) {
    if(uuid){
      id <- uuid::UUIDgenerate()
      scope <- "system"
      system <- "uuid"
      prefix <- "urn:uuid:"
    } else {
      id <- paste(prefix, format(Sys.time(), "%Y%m%d%H%M%s"), "1", sep=".")
      scope <- "system"
      system <- "EML"
    }
    c(id = id, system = system, scope = scope)
  }

