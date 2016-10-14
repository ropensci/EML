testthat::context("Creating coverage")
testthat::test_that("set_coverage creates a coverage object", {
  geographicDescription <-
    "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"

  coverage <-
    set_coverage(
      begin = '2012-06-01',
      end = '2013-12-31',
      sci_names = "Sarracenia purpurea",
      geographicDescription = geographicDescription,
      west = -122.44,
      east = -117.15,
      north = 37.38,
      south = 30.00,
      altitudeMin = 160,
      altitudeMaximum = 330,
      altitudeUnits = "meter"
    )

  testthat::expect_is(coverage, "coverage")


  coverage <-
    set_coverage(
      date = as.character(seq(
        from = as.Date("1970-01-01"),
        length = 56,
        by = "1 week"
      )),
      sci_names = "Sarracenia purpurea",
      geographicDescription = geographicDescription,
      west = -122.44,
      east = -117.15,
      north = 37.38,
      south = 30.00,
      altitudeMin = 160,
      altitudeMaximum = 330,
      altitudeUnits = "meter"
    )

  testthat::expect_is(coverage, "coverage")

  coverage <-
    set_coverage(
      begin = '2012-06-01',
      end = '2013-12-31',
      sci_names = list(
        KINGDOM = "Plantae",
        PHYLUM = "Phaeophyta",
        CLASS = "Phaeophyceae",
        ORDER = "Laminariales",
        FAMILY = "Lessoniaceae",
        GENUS = "Macrocystis",
        genusSpecies = "Macrocystis pyrifera",
        commonName = "MAPY"
      ),
      geographicDescription = "California coast, down through Baja, Mexico",
      west = -122.44,
      east = -117.15,
      north = 37.38,
      south = 30.00
    )

  testthat::expect_is(coverage, "coverage")

  coverage <-
    set_coverage(
      begin = '2012-06-01',
      end = '2013-12-31',
      sci_names = data.frame(
        KINGDOM = "Plantae",
        PHYLUM = "Phaeophyta",
        CLASS = "Phaeophyceae",
        ORDER = "Laminariales",
        FAMILY = "Lessoniaceae",
        GENUS = "Macrocystis",
        genusSpecies = "Macrocystis pyrifera",
        commonName = "MAPY"
      ),
      geographicDescription = "California coast, down through Baja, Mexico",
      west = -122.44,
      east = -117.15,
      north = 37.38,
      south = 30.00
    )

  testthat::expect_is(coverage, "coverage")
})

testthat::test_that("set_taxonomicCoverage creates a taxonomicCoverage object", {
  # input type: data frame
  taxon <-
    set_taxonomicCoverage(
      data.frame(
        KINGDOM = "Plantae",
        PHYLUM = "Phaeophyta",
        CLASS = "Phaeophyceae",
        ORDER = "Laminariales",
        FAMILY = "Lessoniaceae",
        GENUS = "Macrocystis",
        genusSpecies = "Macrocystis pyrifera",
        commonName = "MAPY"
      )
    )
  testthat::expect_is(taxon, "taxonomicCoverage")
  # input type: list
  taxon <-
    set_taxonomicCoverage(
      list(
        KINGDOM = "Plantae",
        PHYLUM = "Phaeophyta",
        CLASS = "Phaeophyceae",
        ORDER = "Laminariales",
        FAMILY = "Lessoniaceae",
        GENUS = "Macrocystis",
        genusSpecies = "Macrocystis pyrifera",
        commonName = "MAPY"
      )
    )
  testthat::expect_is(taxon, "taxonomicCoverage")
})

testthat::test_that("set_taxonomicCoverage create a object with correct depth", {
  # regular case
  dt <- data.frame(
    KINGDOM = "Plantae",
    PHYLUM = "Phaeophyta",
    CLASS = "Phaeophyceae",
    ORDER = "Laminariales",
    FAMILY = "Lessoniaceae",
    GENUS = "Macrocystis",
    genusSpecies = "Macrocystis pyrifera",
    commonName = "MAPY"
  )
  taxon <- set_taxonomicCoverage(dt)
  depth <- 0
  while (length(taxon@taxonomicClassification) > 0) {
    depth <- depth + 1
    taxon <- taxon@taxonomicClassification[[1]]
  }
  testthat::expect_equal(depth, 8)
})

testthat::test_that("set_taxonomicCoverage create valid EML", {
  testthat::skip_on_cran()

  f <- system.file("examples", "coverage_test.xml", package = "EML")
  eml <- read_eml(f)

  physical <- eml_get(eml, "physical")
  attributeList <- eml_get(eml, "attributeList")
  abstract <- eml_get(eml, "abstract")
  rights <- eml_get(eml, "intellectualRights")
  methods <- eml_get(eml, "methods")
  keys <- eml_get(eml, "keywordSet")

  dataTable <- new(
    "dataTable",
    entityName = "data.csv",
    entityDescription = "test",
    physical = physical[[1]][[1]],
    attributeList = attributeList[[1]][[1]]
  )
  title <- "test"
  pubDate <- "2000"
  creator <- new("ListOfcreator")
  creator[[1]] <- as(as.person("John Smith [cre]"), "creator")

  address <- new(
    "address",
    deliveryPoint = "123 Main St.",
    city = "None",
    administrativeArea = "None",
    postalCode = "None",
    country = "USA"
  )
  publisher <-
    new("publisher",
        organizationName = "None",
        address = address)
  contact <-
    new(
      "contact",
      individualName = creator[[1]]@individualName,
      electronicMail = "None",
      address = address,
      organizationName = "None",
      phone = "None"
    )

  df <- data.frame(
    KINGDOM = "Plantae",
    PHYLUM = "Phaeophyta",
    CLASS = "Phaeophyceae",
    ORDER = "Laminariales",
    FAMILY = "Lessoniaceae",
    GENUS = "Macrocystis",
    genusSpecies = "Macrocystis pyrifera",
    commonName = "MAPY"
  )
  geographicDescription <- "This is a test."
  coverage <- set_coverage(
    begin = "1900",
    end = "2000",
    sci_names = df,
    geographicDescription = geographicDescription,
    west = 0,
    east = 0,
    north = 0,
    south = 0
  )

  dataset <- new(
    "dataset",
    title = title,
    creator = creator,
    contact = contact,
    publisher = publisher,
    pubDate = pubDate,
    intellectualRights = rights[[1]],
    abstract = abstract[[1]],
    keywordSet = keys[[1]],
    coverage = coverage,
    methods = methods,
    dataTable = c(dataTable)
  )
  #create eml object
  eml <- new("eml",
             packageId = "a6397e2b-8df2-4261-9cae-3b3419c40e06",
             system = "uuid",
             dataset = dataset)

  testthat::expect_true(eml_validate(eml))
})

testthat::test_that("get_taxonomicCoverage", {
  f <- system.file("xsd/test/eml-i18n.xml", package = "EML")
  eml <- read_eml(f)
  df <-
    EML:::get_taxonomicCoverage(eml@dataset@coverage@taxonomicCoverage)

  testthat::expect_is(df, "data.frame")
  testthat::expect_equal(ncol(df), 8)
  testthat::expect_equal(nrow(df), 1)


  # coverage <- eml_get(eml, "coverage")

})
