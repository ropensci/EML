

## FIXME consider using S4 objects and their constructors as the standard way to set defaults. 
## FIXME are defaults resonable? i.e. define creator and set contact = creator, rather than vice versa?  



#' @title Configure EML default values 
#' 
#' Default options for generating EML objects
#' @param creator a character string, person object, or creator object
#' @param contact  a character string, person object, or contact object
#' @param defaultLicense a text string specifying the default intellectual rights text that should be indicated.  
#' @return Nothing, but updates the remlConfig environment where this information is stored.  
#' @details Configuration settings will be used as the default values when creating a new eml file or dataset object
#'   unless alternative values are provided at the time of creation.  Configuration settings last only for the duration
#'   of the current R session.  Add a call to `reml::eml_config` in your .Rprofile to have these settings used by
#'   default in each R session.  Repeating a call to eml_config will reset the settings. The default settings of `eml_config`
#'   are not applied if the function is not called explicitly.  
#' @include reml_environment.R
#' @export
eml_config <- function(creator = "", contact = "", defaultLicense = "CC0"){
  if(defaultLicense == "CC0")
#    defaultLicense <- "<a rel='license' property='http://creativecommons.org/ns#license' href='http://creativecommons.org/publicdomain/zero/1.0/'>CC0</a>"
  defaultLicense <- "CC0, http://creativecommons.org/publicdomain/zero/1.0"
  defaultCreator <- new("ListOfcreator", lapply(creator, as, "creator"))

  if(is.null(contact))
    defaultContact <- as(creator[[1]], "contact")
 else 
    defaultContact <- as(contact, "contact")
  assign('defaultLicense', defaultLicense, envir=remlConfig)
  assign('defaultCreator', defaultCreator, envir=remlConfig)
  assign('defaultContact', defaultContact, envir=remlConfig)
}
