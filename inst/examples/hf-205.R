library("eml2")

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
contact <- as(aaron, "contact")
contact@address = HF_address
contact@organizationName = "Harvard Forest"
contact@phone = "000-000-0000"

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

eml2:::set_geographicCoverage(box, description)


eml2:::set_taxonomicCoverage("Sarracenia purpurea")




## attributes table

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


set_attributes(attributes, factors, col_classes = c("character", "Date", "Date", "Date", "factor", "factor", "factor"))


