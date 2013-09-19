library(reml)



dat = data.set(river = factor(c("SAC",  "SAC",   "AM")),
               spp   = c("Oncorhynchus tshawytscha",  "Oncorhynchus tshawytscha", "Oncorhynchus kisutch"),
               stg   = ordered(c("smolt", "parr", "smolt"), levels=c("parr", "smolt")), # levels indicates increasing level, eg. parr < smolt
               ct    = c(293L,    410L,    210L),
               day   = as.Date(c("2013-09-01", "2013-09-1", "2013-09-02")),
               stringsAsFactors = FALSE, 
               col.defs = c("River site used for collection",
                            "Species scientific name",
                            "Life Stage", 
                            "count of live fish in traps",
                            "day traps were sampled (usually in morning thereof)"),
               unit.defs = list(c(SAC = "The Sacramento River",                         # Factor 
                                  AM = "The American River"),
                                "Scientific name",                                      # Character string (levels not defined)
                                c(parr = "third life stage",                            # Ordered factor 
                                  smolt = "fourth life stage"),
                                c(unit = "number", precision = 1, bounds = c(0, Inf)),  # Integer
                                c(format = "YYYY-MM-DD", precision = 1)))               # Date
# Add example from ropenfisheries showing how factor definitions can come from two columns, rather than long entry...
# Date should support R format strings (%Y, %m, %d) as well as EML strings (YYYY, MM, DD)


# The weird thing about this is that it defines a loose object for unit.defs.  perhaps we should define as an explicit class(?!) 

# numeric: 
#   required: unit
#   optional: 
#     - type (natural, integer, real). If not given will be inferred from the column
#     - precision (numeric)
#     - bounds 
#     - interval? (logical)  Otherwwise assumed to be aratio

# dateTime
#   required: format format string
#   optional:
#     - precision


