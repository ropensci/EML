
## FIXME Don't use global options environment 
eml_settings <- list{
  get <- function(...)
    getOption(...)
  set <- function(...)
    options(...)
}
