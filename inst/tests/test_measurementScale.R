context("testing measurement scale detection")



require(reml)
data(ex2)

s4 <- reml:::eml(dat, 
                 title = "title", 
                 creator = "Carl Boettiger <cboettig@gmail.com>")


## check that a factor becomes nominal/enumeratedDomain with levels defined

## check that an ordered becomes an ordinal/enumeratedDomain

## check that a numeric becomes a ratio

## check that a Date becomes a dateTime

## check that a character can become a nominal/textDefinition

##


## See https://github.com/ropensci/workshops-norwich-2013-09/blob/0f8738b50d5613526fa9dd531698649c9ad18490/04-reproducible-research/reml.Rmd for an example with different fields (including Date)

## Write more simple data cases showing this diversity of data types..


