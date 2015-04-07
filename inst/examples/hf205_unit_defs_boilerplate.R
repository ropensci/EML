## This is an extension to the hf205.R example, to show a function to
## extract unit_def information from data frames
library(EML)
source("../../R/eml_boilerplate.R")

## Illustrate that we can extract most relevant fields with appropriate type conversions

## Illustrate reading in based on identifier and based on URL

f <- system.file("examples", "hf205.xml", package="EML")
hf205 <- read.eml(f)

dat <- eml_get(hf205, "data.set")
str(dat)
names(dat)
# dat <- read.csv(system.file("examples", "hf205-01-TPexp1.csv", package="EML"))



## Extract metadata

cite <- eml_get(hf205, "citation_info")
title <- cite$title
pubDate <- cite$year
creator <- eml_get(hf205, "creator")
contact <- eml_get(hf205, "contact")
keywords <- eml_get(hf205, "keywords")
coverage <- eml_get(hf205, "coverage")
metadata <- eml_get(hf205, "attributeList")
additionalMetadata <- hf205@additionalMetadata
creator <- eml_get(hf205, "id")


###### Write metadata ####


col.defs <- c("run.num" = "which run number (=block). Range: 1 - 6. (integer)",
              "year" = "year, 2012",
              "day" = "Julian day. Range: 170 - 209.",
              "hour.min" = "hour and minute of observation. Range 1 - 2400 (integer)",
              "i.flag" =  "is variable Real, Interpolated or Bad (character/factor)",
              "variable" = "what variable being measured in what treatment (character/factor).",
              "value.i" = "value of measured variable for run.num on year/day/hour.min.")

# the following commented section is from the original example
# I found this process to actually work better in the Morpho software
# which is a GUI to document data in the EML standard.
# however getting the rest of the metadata for the unit definitions generated in R EML package
# (even just as a skeleton, to be expanded on in Morpho) has provided a lot of benefits in terms of
# A) time. The Morpho GUI steps through one column at a time and it
# slows down each time it moves to next col... crashing after about a
# hundred cols
# B) ensuring the metadata closely aligns to the data (character
# cannot be mis-labelled as number for example when documenting a
# factor variable with "nominal" numbers)

# so this is the old example
## unit.defs = list("which run number",
##                  "YYYY",
##                  "DDD",
##                  "hhmm",
##                  c(R = "real", I = "interpolated", B = "bad"),
##                  c(control = "no prey added",
##                    low = "0.125 mg prey added ml-1 d-1",
##                    med.low = "0,25 mg prey added ml-1 d-1",    # ERROR
##                    med.high = "0.5 mg prey added ml-1 d-1",
##                    high = "1.0 mg prey added ml-1 d-1",
##                    air.temp = "air temperature measured just above all plants (1 thermocouple)",
##                    water.temp = "water temperature measured within each pitcher",
##                    par = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"),
##                  c(control = "% dissolved oxygen",
##                    low = "% dissolved oxygen",
##                    med.low = "% dissolved oxygen",
##                    med.high = "% dissolved oxygen",
##                    high  = "% dissolved oxygen",
##                    air.temp = "degrees C",
##                    water.temp = "degrees C",
##                    par = "micromoles m-1 s-1"))

#################################################
# using the boilerplate is simply
unit_defs <- eml_boilerplate(dat)
unit_defs

# if you have already figured out which cols are enumerated values
# lists then pass this vector of numbers identifying those cols
unit_defs <- eml_boilerplate(dat, enumerated = c(5,6,7))
unit_defs

# if you have a variable in a format that can be coerced to date with
# as.Date, this will write the correct units (YYYY-MM-DD)
table(dat$day)
dat$datevar <- paste(dat$year, dat$day, sep =" ")
dat$datevar <- as.Date(strptime(dat$datevar, "%Y %j"))
unit_defs <- eml_boilerplate(dat, enumerated = c(5,6,7))

unit_defs

dat <- data.set(dat, col.defs = col.defs, unit.defs = unit_defs)




aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")

HF_address <- new("address",
        deliveryPoint = "324 North Main Street",
        city = "Petersham",
        administrativeArea = "MA",
        postalCode = "01366",
        country = "USA")

## Can construct with R notation / person object if we just wanted a name and email address.
contact <- new("contact",
    individualName = as(aaron, "individualName"), # why isn't coercion automatically attempted?
    organizationName = "Harvard Forest",
    electronicMailAddress = aaron$email,
    phone = "000-000-0000",
    address = HF_address)

publisher <- new("publisher",
    organizationName = "Harvard Forest",
    address = HF_address)


## Uses an implicit coercion from string to person object,
## Also uses concatenation to generate ListOf
creator <- c(as("Aaron Ellison", "creator"), as("Nicholas Gotelli", "creator"))

## Yet another way to create person objects: The helper function eml_person decides these should be "associatedParty" nodes
## due to the presence of the "role" attribute, specified in R's person notation.
other_researchers <- eml_person("Benjamin Baiser [ctb]", "Jennifer Sirota [ctb]") # creates a 'ListOfassociatedParty' (roles != cre)



pubDate <- "2012" # Or Sys.Date() for the current date.
title <- "Thresholds and Tipping Points in a Sarracenia Microecosystem at Harvard Forest since 2012"


keywords <- list("LTER controlled vocabulary" = c("bacteria", "carnivorous plants", "genetics", "thresholds"),
                             "LTER core area" = c("populations", "inorganic nutrients", "disturbance"),
                                "HFR default" = c("Harvard Forest", "HFR", "LTER", "USA"))


## We build the coverage using a helper function:
coverage <- eml_coverage(scientific_names = "Sarracenia purpurea",
                         dates            = c('2012-06-01', '2013-12-31'),
                         geographic_description = "Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)",
                         NSEWbox          = c( 42.55,  42.42, -72.1, -72.29, 160, 330))




## We might define smaller blocks of text in the script itself.
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
  in ecological systems."

## We might read in larger chunks of text from a plain text file.
# abstract <- readLines("abstract.txt")

rights <- "This dataset is released to the public and may be freely
  downloaded. Please keep the designated Contact person informed of any
  plans to use the dataset. Consultation or collaboration with the original
  investigators is strongly encouraged. Publications and data products
  that make use of the dataset must include proper acknowledgement. For
  more information on LTER Network data access and use policies, please
  see: http://www.lternet.edu/data/netpolicy.html."



## For larger blocks of text we might rather write these Word.  We can read them in from there:
## Read in methods description from an Word file.
library(RWordXML)
library(XML)
f2 <- wordDoc(system.file("examples", "methods.docx", package="EML"))
doc <- f2[[getDocument(f2)]]
txt <- xpathSApply(doc, "//w:t", xmlValue)
## FIXME add <title> <section> and <para> blocking back:
method_description <- paste(txt, collapse = "\n\n")


methods <- new("methods")
methods
methods@methodsStep@description <- method_description

# TODO at this step I got a warning
## Error in methods@methodsStep@description <- method_description :
##   no slot of name "methodsStep" for this object of class "methods"

additionalMetadata <- hf205@additionalMetadata # extracted from previous eml file


## Construct the dataTable #########

# TODO this commented section did not work, see next addition
## dataTable <- EML:::eml_dataTable(dat,
##                            title = "Supplemental Data, table 1",
##                            description = "Metadata documentation for S1.csv",
##                            file = "S1.csv")

## ### Construct the dataset ##########
## dataset <- new("dataset",
##                 title = title,
##                 creator = creator,
##                 contact = contact,
##                 pubDate = pubDate,
##                 associatedParty = other_researchers,
## #                keywordSet = keywords,
##                 coverage = coverage,
##                 methods = methods,
##                 dataTable = c(dataTable))

## eml <- new("eml",
##             dataset = dataset,
##             additionalMetadata = additionalMetadata)

## write.eml(eml, "hf205_from_EML.xml")

# make a name for your data package
outfile <- "hf205_boilerplate.csv"
dat <- dat@.Data
dat <- as.data.frame(dat)
# now recall I added another col?  also this demonstrates a more
# minimal EML output from the R script, to be beautified in Morpho
col.defs <- c(names(col.defs), "datevar")
names(dat)  <- col.defs
str(dat)
eml_write(dat,
          col.defs = col.defs,
          unit.defs = unit_defs,
          file = gsub(".csv", "_eml_skeleton.xml", outfile),
          creator="TBA <fakeaddress@gmail.com>",
          title = gsub(".csv", "", outfile)
          )
# TODO this created our EML skeleton and a temp file, which is
# referred to in the EML at
# dataset/physical/objectName/xxx

# In publishing these to Metacat server I want to have same name as metadata document
#tempfile <- dir(pattern="^data_table_")
# rename the CSV file.
#file.rename(tempfile, outfile)
# and attach this through morpho
