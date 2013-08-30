context("Serializing S4 to XML")

require(reml)
dat = data.frame(river = c("SAC",  "SAC",   "AM"),
                 spp   = c("king",  "king", "ccho"),
                 stg   = c("smolt", "parr", "smolt"),
                 ct    = c(293L,    410L,    210L))
metadata <- 
  list("river" = list("river",
                      "River site used for collection",
                      c(SAC = "The Sacramento River", 
                        AM = "The American River")),
       "spp" = list("spp",
                    "Species common name", 
                    c(king = "King Salmon", 
                      ccho = "Coho Salmon")),
       "stg" = list("stg",
                    "Life Stage", 
                    c(parr = "third life stage", 
                      smolt = "fourth life stage")),
       "ct"  = list("ct",
                    "count", 
                    "number"))


S4obj <-  eml(dat, metadata, title = "title", description = "description")


# Currently produces all the empty nodes!
# Worse, doesn't define "enumeratedDomain" because it is a slot name but not a class definition (class is listOf
att <- S4obj@dataset@dataTable@attributeList@attribute[[1]]@measurementScale

reml:::emlS4ToXML(att)
