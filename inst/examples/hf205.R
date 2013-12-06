

## Illustrate that we can extract most relevant fields with appropriate type conversions


f <- system.file("examples", "hf205.xml", package="reml")
dat <- read.csv(system.file("examples", "hf205-01-TPexp1.csv", package="reml"))
hf205 <- read.eml(f)



## Extract metadata 

a = citationInfo(hf205)
title <- a$title 
pubDate <- a$year
creator <- creator(hf205)
contact <- contact(hf205)
keywords <- keywords(hf205)
coverage <- coverage(hf205)
metadata <- attributeList(hf205)
additionalMetadata <- hf205@additionalMetadata


###### Write metadata ####


col.defs <- c("run.num" = "which run number (=block). Range: 1 - 6. (integer)",
              "year" = "year, 2012",
              "day" = "Julian day. Range: 170 - 209.",
              "hour.min" = "hour and minute of observation. Range 1 - 2400 (integer)",
              "i.flag" =  "is variable Real, Interpolated or Bad (character/factor)",
              "variable" = "what variable being measured in what treatment (character/factor).",
              "value.i" = "value of measured variable for run.num on year/day/hour.min.",

unit.defs = list("which run number", 
                 "YYYY",
                 "DDD",
                 "hhmm", 
                 c(R = "real", I = "interpolated", B = "bad"),
                 c(control = "no prey added", 
                   low = "0.125 mg prey added ml-1 d-1",
                   med.low = "0,25 mg prey added ml-1 d-1",    # ERROR 
                   med.high "0.5 mg prey added ml-1 d-1",
                   high = "1.0 mg prey added ml-1 d-1",
                   air.temp = "air temperature measured just above all plants (1 thermocouple)",
                   water.temp = "water temperature measured within each pitcher",
                   par = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"),
                 c(control = "% dissolved oxygen",
                   low = "% dissolved oxygen",
                   med.low = "% dissolved oxygen",
                   med.high = "% dissolved oxygen",
                   high  = "% dissolved oxygen",
                   air.temp = "degrees C",
                   water.temp = "degrees C",
                   par = "micromoles m-1 s-1"))

datset <- data.set(dat, col.defs = col.defs, unit.defs = unit.defs)




aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")

HF_address <- new("address", 
        deliveryPoint = "324 North Main Street",
        city = "Petersham",
        administrativeArea = "MA",
        postalCode = "01366"
        country = "USA") 

contact <- new("contact", 
    individualName = aaron,
    organizationName = "Harvard Forest", 
    electronicMailAddress = aaron$email, 
    phone = "000-000-0000",
    address = HF_address)

publisher <- new("publisher", 
    organizationName = "Harvard Forest",
    address = HF_address)
  
creator <- as.person(c("Aaron Ellison", "Nicholas Gotelli"))
researchers <- as.person(c("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]"))
pubDate <- "2012" # Sys.Date()
title <- "Thresholds and Tipping Points in a Sarracenia Microecosystem at Harvard Forest since 2012"
keywords <- list("LTER controlled vocabulary" = c("bacteria", "carnivorous plants", "genetics", "thresholds"),
                 "LTER core area" = c("populations", "inorganic nutrients", "disturbance"),
                 "HFR default" = c("Harvard Forest", "HFR", "LTER", "USA"))

abstract <- "The primary goal of this project is to determine
experimentally the amount of lead time required to prevent a state
change. To achieve this goal, we will (1) experimentally induce state
changes in a natural aquatic ecosystem - the Sarracenia microecosystem;
(2) use proteomic analysis to identify potential indicators of states
and state changes; and (3) test whether we can forestall state changes
by experimentally intervening in the system. This work uses state-of-the
art molecular tools to identify early warning indicators in the field
of aerobic to anaerobic state changes driven by nutrient enrichment
in an aquatic ecosystem. The study tests two general hypotheses: (1)
proteomic biomarkers can function as reliable indicators of impending
state changes and may give early warning before increasing variances
and statistical flickering of monitored variables; and (2) well-timed
intervention based on proteomic biomarkers can avert future state changes
in ecological systems."  # readLines("abstract.txt")

rights <- "This dataset is released to the public and may be freely
downloaded. Please keep the designated Contact person informed of any
plans to use the dataset. Consultation or collaboration with the original
investigators is strongly encouraged. Publications and data products
that make use of the dataset must include proper acknowledgement. For
more information on LTER Network data access and use policies, please
see: http://www.lternet.edu/data/netpolicy.html."

coverage <- eml_coverage(scientific_names = "Sarracenia purpurea", 
             dates = c('2012-06-01' - '2013-12-31'),
             geographic_description = "Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)", 
             NSEWbox = c( 42.55,  42.42, -72.1, -72.29, 160, 330))


## Read in methods description from an XML file.  
library(RWordXML)
f <- wordDoc("inst/examples/methods.docx")
doc <- methods[[getDocument(f)]]
txt <- xpathSApply(doc, "//w:t", xmlValue)
## FIXME add <title> <section> and <para> blocking back: 
methods_section <- paste(txt, collapse = "\n\n") 


additionalMetadata <- hf205@additionalMetadata # extracted from previous eml file


## Construct the dataTable #########
## We really don't want to use the constructor function here, as much of this (e.g. physical node) is automatable

dataTable <- eml_dataTable(dat, 
                           title = "Supplemental Data, table 1", 
                           description = "Metadata documentation for S1.csv", 
                           file = "S1.csv")

### Construct the dataset ########## 
## FIXME dataset should have ListOfdataTable 
dataset <- new("dataset", 
                title = title,
                creator = creator,
                contact = contact,
                coverage = coverage,
                methods = methods,
                dataTable = dataTable)

## FIXME eml prototype should create packageId, system and scope.  
eml <- new("eml", 
            dataset = dataset,
            additionalMetadata = additionalMetadata)

write.eml(eml, "hf205_from_reml.xml")


