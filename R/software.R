#' @include resource.R 


# The actual value for the language or a code for the language, and 
# The International Language Code being used in the field languageValue. 
# See http://www.loc.gov/standards/iso639-2/ e.g. ISO639-2
setClass("language", 
         slots = c(languageValue = "character", 
                   languageCodeStandard = "character") 


  # Not sure this is correctly defined? Simple types 
setClass("action", 
         slots = c(install = "character",
                   assert = "character"))

setClass("dependency",
         slots = c("action" = "action",  # required
                   "software" = "software")) # required 
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
                   language = "language", # optional  unbounded
                   operatingSystem = "character", # optional  unbounded
                   machineProcessor = "character",  #optional  unbounded
                   virtualMachine = "character", # optional  
                   diskUsage = "character", #  optional  
                   runtimeMemoryUsage = "character", # optional  
                   programmingLanguage = "character", # optional unbounded
                   checksum = "character",  # optional  
                   dependency = "ListOfdependency" # optional  unbounded
                   )



setClass("software_slots", 
         slots = c(implementation = "implementation",
                   dependency = "dependency",
                   licenceURL = "character",
                   license = "character", 
                   version = "character",
                   project = "chracter") # researchProject 

## FIXME flush out this class
setClass("software",
         contains = c("id_scope", 
                      "resourceGroup", 
                      "software_slots", 
                      "referencesGroup"))

setAs("XMLInternalElementNode", "software",   function(from) emlToS4(from))
setAs("software", "XMLInternalElementNode",   function(from) S4Toeml(from))



