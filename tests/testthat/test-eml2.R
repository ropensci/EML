library(emld)

test_that("we can do a complete eml construction", {

  ## Appveyor cannot even evaluate rmarkdown::pandoc_version() ?
  skip_on_appveyor()
  skip_on_os("solaris")
  skip_on_cran()


## ------------------------------------------------------------------------
geographicDescription <-
  "Harvard Forest Greenhouse, Tom Swamp Tract (Harvard Forest)"
coverage <-
  set_coverage(
    begin = "2012-06-01", end = "2013-12-31",
    sci_names = "Sarracenia purpurea",
    geographicDescription = geographicDescription,
    west = -122.44, east = -117.15,
    north = 37.38, south = 30.00,
    altitudeMin = 160, altitudeMaximum = 330,
    altitudeUnits = "meter"
  )


methods_file <- system.file("examples", "hf205-methods.docx", package = "EML")
methods <- set_methods(methods_file)



R_person <- person(
  "Aaron", "Ellison", , "fakeaddress@email.com", "cre",
  c(ORCID = "0000-0003-4151-6081")
)
aaron <- as_emld(R_person)

## ------------------------------------------------------------------------
others <- c(as.person("Benjamin Baiser"), as.person("Jennifer Sirota"))
associatedParty <- as_emld(others)
associatedParty[[1]]$role <- "Researcher"
associatedParty[[2]]$role <- "Researcher"

## ------------------------------------------------------------------------
HF_address <- list(
  deliveryPoint = "324 North Main Street",
  city = "Petersham",
  administrativeArea = "MA",
  postalCode = "01366",
  country = "USA"
)

## ------------------------------------------------------------------------
publisher <- list(
  organizationName = "Harvard Forest",
  address = HF_address
)

## ------------------------------------------------------------------------
contact <-
  list(
    individualName = aaron$individualName,
    electronicMailAddress = aaron$electronicMailAddress,
    address = HF_address,
    organizationName = "Harvard Forest",
    phone = "000-000-0000"
  )


## ------------------------------------------------------------------------
attributes <- read.table(system.file("extdata/hf205_attributes.csv",
  package = "EML"
))
factors <- read.table(system.file("extdata/hf205_factors.csv",
  package = "EML"
))
attributeList <-
  set_attributes(attributes,
    factors,
    col_classes = c(
      "character",
      "Date",
      "Date",
      "Date",
      "factor",
      "factor",
      "factor",
      "numeric"
    )
  )

## ------------------------------------------------------------------------
f <- system.file("examples", "hf205-01-TPexp1.csv", package="EML")
#physical <- set_physical(f)
 testthat::expect_message(physical <- set_physical(f),
               "calculated file size")

## ------------------------------------------------------------------------
dataTable <- list(
  entityName = "hf205-01-TPexp1.csv",
  entityDescription = "tipping point experiment 1",
  physical = physical,
  attributeList = attributeList
)

## ------------------------------------------------------------------------
keywordSet <- list(
  list(
    keywordThesaurus = "LTER controlled vocabulary",
    keyword = list(
      "bacteria",
      "carnivorous plants",
      "genetics",
      "thresholds"
    )
  ),
  list(
    keywordThesaurus = "LTER core area",
    keyword = list("populations", "inorganic nutrients", "disturbance")
  ),
  list(
    keywordThesaurus = "HFR default",
    keyword = list("Harvard Forest", "HFR", "LTER", "USA")
  )
)

## ------------------------------------------------------------------------
pubDate <- "2012"

title <- "Thresholds and Tipping Points in a Sarracenia
Microecosystem at Harvard Forest since 2012"

intellectualRights <- "http://www.lternet.edu/data/netpolicy.html."

## ----eval=has_pandoc-----------------------------------------------------
abstract_file <- system.file("examples/hf205-abstract.md", package = "EML")
abstract <- set_TextType(abstract_file)

## ------------------------------------------------------------------------
dataset <- list(
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
  dataTable = dataTable
)

## ------------------------------------------------------------------------
eml <- list(dataset = dataset)


## ------------------------------------------------------------------------
write_eml(eml, "eml.xml")
testthat::expect_true(eml_validate("eml.xml"))

unlink("eml.xml")

})
