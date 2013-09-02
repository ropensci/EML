

## FIXME are defaults resonable? i.e. define creator and set contact = creator, rather than vice versa?  
#' @export
eml_config <- function(creator, contact = creator, defaultLicense = "CC0"){
  if(defaultLicense == "CC0")
    defaultLicense <- "<a rel='license' property='http://creativecommons.org/ns#license' href='http://creativecommons.org/publicdomain/zero/1.0/'>CC0</a>"
  defaultCreator <- as(creator, "creator")
  defaultContact <- as(contact, "contact")
  assign('defaultLicense', defaultLicense, envir=remlConfig)
  assign('defaultCreator', defaultCreator, envir=remlConfig)
  assign('defaultContact', defaultContact, envir=remlConfig)
}
