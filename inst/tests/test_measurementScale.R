context("testing measurement scale detection")



library(EML)
dat = data.set(river = c("SAC",  "SAC",   "AM"),
               spp   = c("king",  "king", "ccho"),
               stg   = c("smolt", "parr", "smolt"),
               ct    = c(293L,    410L,    210L),
               col.defs = c("River site used for collection",
                            "Species common name",
                            "Life Stage", 
                            "count of live fish in traps"),
               unit.defs = list(c(SAC = "The Sacramento River", 
                                  AM = "The American River"),
                                c(king = "King Salmon", 
                                  ccho = "Coho Salmon"),
                                c(parr = "third life stage", 
                                  smolt = "fourth life stage"),
                                "number"))


s4 <- EML:::eml(dat, 
                 title = "title", 
                 creator = "Carl Boettiger <cboettig@gmail.com>")


## check that a factor becomes nominal/enumeratedDomain with levels defined

## check that an ordered becomes an ordinal/enumeratedDomain

## check that a numeric becomes a ratio

## check that a Date becomes a dateTime

## check that a character can become a nominal/textDefinition

##


## See https://github.com/ropensci/workshops-norwich-2013-09/blob/0f8738b50d5613526fa9dd531698649c9ad18490/04-reproducible-research/EML.Rmd for an example with different fields (including Date)

## Write more simple data cases showing this diversity of data types..


