attributes <-
  data.frame(
    attributeName = c(
      "run.num",
      "year",
      "day",
      "hour.min",
      "i.flag",
      "variable",
      "value.i",
      "length"),
    attributeDefinition = c(
      "which run number (=block). Range: 1 - 6. (integer)",
      "year, 2012",
      "Julian day. Range: 170 - 209.",
      "hour and minute of observation. Range 1 - 2400 (integer)",
      "is variable Real, Interpolated or Bad (character/factor)",
      "what variable being measured in what treatment (character/factor).",
      "value of measured variable for run.num on year/day/hour.min.",
      "length of the species in meters (dummy example of numeric data)"),
    formatString = c(
      NA,
      "YYYY",
      "DDD",
      "hhmm",
      NA,
      NA,
      NA,
      NA),
    definition = c(
      "which run number",
      NA,
      NA,
      NA,
      NA,
      NA,
      NA,
      NA),
    unit = c(
      NA,
      NA,
      NA,
      NA,
      NA,
      NA,
      NA,
      "meter"),
    numberType = c(
      NA,
      NA,
      NA,
      NA,
      NA,
      NA,
      NA,
      "real"),
    stringsAsFactors = FALSE
  )

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

## Write these into the data.frame format
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

attributeList <- set_attributes(attributes, factors, col_classes = c("character", "Date", "Date", "Date", "factor", "factor", "factor", "numeric"))


physical <- set_physical("hf205-01-TPexp1.csv")

dataTable <- new("dataTable",
                 entityName = "hf205-01-TPexp1.csv",
                 entityDescription = "tipping point experiment 1",
                 physical = physical,
                 attributeList = attributeList)

getSlots("dataTable")

example <- new("dataTable")
#example@physical <- physical # Error -- wrong type.
example@physical <- c(physical) # concat method promotes 1 or more arguments to a ListOf


geographicDescription <- "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"


coverage <-
  set_coverage(begin = '2012-06-01', end = '2013-12-31',
               sci_names = "Sarracenia purpurea",
               geographicDescription = geographicDescription,
               west = -122.44, east = -117.15,
               north = 37.38, south = 30.00,
               altitudeMin = 160, altitudeMaximum = 330,
               altitudeUnits = "meter")

methods_file <- system.file("examples/hf205-methods.docx", package = "EML")
methods <- set_methods(methods_file)

R_person <- as.person("Maëlle Maëlle <fakeaddress@email.com> [cre]")
aaron <-as(R_person, "creator")

others <- c(as.person("Benjamin Baiser [ctb]"), as.person("Jennifer Sirota [ctb]"))
associatedParty <- as(others, "associatedParty")

HF_address <- new("address",
                  deliveryPoint = "324 North Main Street",
                  city = "Petersham",
                  administrativeArea = "MA",
                  postalCode = "01366",
                  country = "USA")

publisher <- new("publisher",
                 organizationName = "Harvard Forest",
                 address = HF_address)

contact <-
  new("contact",
      individualName = aaron@individualName,
      electronicMail = aaron@electronicMailAddress,
      address = HF_address,
      organizationName = "Harvard Forest",
      phone = "000-000-0000")

keywordSet <-
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

intellectualRights <- "This dataset is released to the public and may be freely
downloaded. Please keep the designated Contact person informed of any
plans to use the dataset. Consultation or collaboration with the original
investigators is strongly encouraged. Publications and data products
that make use of the dataset must include proper acknowledgement. For
more information on LTER Network data access and use policies, please
see: http://www.lternet.edu/data/netpolicy.html."

abstract_file <-  system.file("examples/hf205-abstract.md", package = "EML")
abstract <- as(set_TextType(abstract_file), "abstract")

  unit <- data.frame(id = "terameter", unitType = "length")
  units <- set_unitList(unit, as_metadata = TRUE)

  dataset <- new("dataset",
                 title = title,
                 creator = aaron,
                 pubDate = pubDate,
                 intellectualRights = intellectualRights,
                 abstract = abstract,
                 associatedParty = associatedParty,
                 keywordSet = keywordSet,
                 coverage = coverage,
                 contact = contact,
                 methods = methods,
                 dataTable = dataTable)

  eml <- new("eml",
             packageId = "f0cda3bf-2619-425e-b8be-8deb6bc6094d",  # from uuid::UUIDgenerate(),
             system = "uuid", # type of identifier
             dataset = dataset,
             additionalMetadata = units)
