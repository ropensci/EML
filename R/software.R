#' @include baseAttributes.R
#' @include party.R 
#' @include resource.R 
#' @include coverage.R
#' @include physical.R

# FIXME teach the emlToS4 / S4Toeml functions that this class should match 
# a node named "language", which can't be used as the class name since that class 
# is already protected.  
#
# The actual value for the language or a code for the language, and 
# The International Language Code being used in the field languageValue. 
# See http://www.loc.gov/standards/iso639-2/ e.g. ISO639-2
setClass("eml_language", 
         slots = c(languageValue = "character", 
                   languageCodeStandard = "character")) 
setAs("XMLInternalElementNode", "language",   function(from) emlToS4(from))
setAs("language", "XMLInternalElementNode",   function(from) S4Toeml(from))



# Not sure this is correctly defined? Simple types 
setClass("action", 
         slots = c(install = "character",
                   assert = "character"))
setAs("XMLInternalElementNode", "action",   function(from) emlToS4(from))
setAs("action", "XMLInternalElementNode",   function(from) S4Toeml(from))


setClass("software") # Dummy declarations are now required..

setClass("dependency",
         slots = c("action" = "action",  # required
                   "software" = "software")) # required 
setAs("XMLInternalElementNode", "dependency",   function(from) emlToS4(from))
setAs("dependency", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("ListOfdependency", contains = "list")

# # Implementation describes the hardware, operating system resources a
# package runs on. Note, a package can have multiple implementations. So
# for example, a package may be written in java and the package may run
# on numerous hardware and/or operating systems like Pentium/Linux,
# Pentium/NT and so on. Hardware and Software descriptions that have
# different requirements can be placed here.   

setClass("implementation", 
         slots = c(distribution = "distribution", # required  unbounded
                   size = "character",# optional  
#                   language = "language", # optional  unbounded
                   operatingSystem = "character", # optional  unbounded
                   machineProcessor = "character",  #optional  unbounded
                   virtualMachine = "character", # optional  
                   diskUsage = "character", #  optional  
                   runtimeMemoryUsage = "character", # optional  
                   programmingLanguage = "character", # optional unbounded
                   checksum = "character"  # optional  
#                   dependency = "ListOfdependency" # optional  unbounded
                   ))

setAs("XMLInternalElementNode", "implementation",   function(from) emlToS4(from))
setAs("implementation", "XMLInternalElementNode",   function(from) S4Toeml(from))



setClass("software_slots", 
         slots = c(implementation = "implementation",
                   dependency = "dependency",
                   licenceURL = "character",
                   license = "character", 
                   version = "character",
                   project = "character")) # researchProject 

## FIXME flush out this class
setClass("software",
         contains = c("id_scope", 
                      "resourceGroup", 
                      "software_slots", 
                      "referencesGroup"))

setAs("XMLInternalElementNode", "software",   function(from) emlToS4(from))
setAs("software", "XMLInternalElementNode",   function(from) S4Toeml(from))



