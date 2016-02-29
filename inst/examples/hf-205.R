library("EML")

# Define the metadata shown in "https://raw.githubusercontent.com/ropensci/EML/master/inst/examples/hf205.xml"

HF_address <- new("address",
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA")
publisher <- new("publisher",
                 organizationName = "Harvard Forest",
                 address = c(HF_address))

aaron <- as.person("Aaron Ellison <fakeaddress@email.com>")
aaron <-as(aaron, "ResponsibleParty")
              
          new("contact",
              individualName = aaron@individualName,
              electronicMail = "fakeaddress@email.com",
              address = HF_address,
              organizationName = "Harvard Forest",
              phone = "000-000-0000")

keys <-
  c(new("keywordSet",
        keywordThesaurus = "LTER controlled vocabulary",
        keyword = c("bacteria",
                    "carnivorous plants",
                    "genetics",
                    "thresholds")),
    new("keywordSet",
        keywordThesaurus = "LTER core area",
        keyword =  c("populations", "inorganic nutrients", "disturbance")),
    new("keywordSet",
        keywordThesaurus = "HFR default",
        keyword = c("Harvard Forest", "HFR", "LTER", "USA")))



description <- "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"
box <- c(-122.44, -117.15, 37.38, 30.00)

EML:::set_geographicCoverage(box, description)
EML:::set_taxonomicCoverage("Sarracenia purpurea")
#EML:::set_temporalCoverage()




## Works only with dev version dplyr due to bug
attributes <-
  dplyr::frame_data(
    ~attributeName,  ~formatString, ~definition,         ~attributeDefinition,
    "run.num",        NA,           "which run number", "which run number (=block). Range: 1 - 6. (integer)",
    "year",          "YYYY",        NA,                 "year, 2012",
    "day",           "DDD",         NA,                 "Julian day. Range: 170 - 209.",
    "hour.min",      "hhmm",        NA,                 "hour and minute of observation. Range 1 - 2400 (integer)",
    "i.flag",        NA,            NA,                 "is variable Real, Interpolated or Bad (character/factor)",
    "variable",      NA,            NA,                 "what variable being measured in what treatment (character/factor).",
    "value.i",       NA,            NA,                 "value of measured variable for run.num on year/day/hour.min."
    )


## Factors table:

## Named char vectors are a natural way to define code/definition pairs in Code.
i.flag <- c(R = "real",
            I = "interpolated",
            B = "bad")
variable <- c(
  control  = "no prey added",
  low      = "0.125 mg prey added ml-1 d-1",
  med.low  = "0,25 mg prey added ml-1 d-1",
  med.high = "0.5 mg prey added ml-1 d-1",
  high     = "1.0 mg prey added ml-1 d-1",
  air.temp = "air temperature measured just above all plants (1 thermocouple)",
  water.temp = "water temperature measured within each pitcher",
  par       = "photosynthetic active radiation (PAR) measured just above all plants (1 sensor)"
)

value.i <- c(
  control  = "% dissolved oxygen",
  low      = "% dissolved oxygen",
  med.low  = "% dissolved oxygen",
  med.high = "% dissolved oxygen",
  high     = "% dissolved oxygen",
  air.temp = "degrees C",
  water.temp = "degrees C",
  par      = "micromoles m-1 s-1"
)

## Write these into a data.frame, because that's a more natural R type
factors <- rbind(
data.frame(
  attributeName = "i.flag",
  code = names(i.flag),
  definition = unname(i.flag)
),
data.frame(
  attributeName = "variable",
  code = names(variable),
  definition = unname(variable)
),
data.frame(
  attributeName = "value.i",
  code = names(value.i),
  definition = unname(value.i)
)
)


attList <- set_attributes(attributes, factors, col_classes = c("character", "Date", "Date", "Date", "factor", "factor", "factor"))

pubDate <- "2012" 
title <- "Thresholds and Tipping Points in a Sarracenia 
Microecosystem at Harvard Forest since 2012"
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
rights <- "This dataset is released to the public and may be freely
  downloaded. Please keep the designated Contact person informed of any
plans to use the dataset. Consultation or collaboration with the original
investigators is strongly encouraged. Publications and data products
that make use of the dataset must include proper acknowledgement. For
more information on LTER Network data access and use policies, please
see: http://www.lternet.edu/data/netpolicy.html."

dataTable <- new("dataTable",
                 attributeList = attList)

dataset <- new("dataset", 
               title = title,
               creator = creator,
               contact = contact,
               pubDate = pubDate,
               intellectualRights = rights,
               abstract = abstract,
               associatedParty = other_researchers,
               keywordSet = keys,
               coverage = coverage,
               methods = methods,
               dataTable = dataTable)

eml <- new("eml",
           packageId = uuid::UUIDgenerate(),
           system = "uuid", # type of identifier
           dataset = dataset)
