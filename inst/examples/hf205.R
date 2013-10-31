

## Illustrate that we can extract most relevant fields with appropriate type conversions



dat <- read.csv(system.file("examples", "hf205-01-TPexp1.csv", package="reml"))
eml <- read.eml(system.file("examples", "hf205.xml", package="reml"))



## Extract metadata 

a = citationInfo(eml)

title <- a$title 
pubDate <- a$year

creator <- creator(eml)
contact <- contact(eml)
keywords <- keywords(eml)

coverage <- coverage(eml)

metadata <- attributeList(eml)



## Write metadata




