testthat::context("Creating coverage")
testthat::test_that("set_coverage creates a coverage object",{
  geographicDescription <- "The Geographic region of the kelp bed data extends along the California coast, down through the coast of Baja, Mexico: Central California (Halfmoon Bay to Purisima Point), Southern California (Point Arguello to the United States/Mexico border including the Channel Islands) and Baja California (points south of the United States/Mexico border including several offshore islands)"
  
  coverage <- 
    set_coverage(begin = '2012-06-01', end = '2013-12-31',
                 sci_names = "Sarracenia purpurea",
                 geographicDescription = geographicDescription,
                 west = -122.44, east = -117.15, 
                 north = 37.38, south = 30.00,
                 altitudeMin = 160, altitudeMaximum = 330,
                 altitudeUnits = "meter")
  
  testthat::expect_is(coverage, "coverage")
  
  
  coverage <- 
    set_coverage(date = as.character(seq(from = as.Date("1970-01-01"), length = 56, by = "1 week")),
                 sci_names = "Sarracenia purpurea",
                 geographicDescription = geographicDescription,
                 west = -122.44, east = -117.15, 
                 north = 37.38, south = 30.00,
                 altitudeMin = 160, altitudeMaximum = 330,
                 altitudeUnits = "meter")
  
  testthat::expect_is(coverage, "coverage")
  
  coverage <- 
    set_coverage(begin = '2012-06-01', end = '2013-12-31',
                 sci_names = list(KINGDOM="Plantae", PHYLUM="Phaeophyta", CLASS="Phaeophyceae",
                                  ORDER="Laminariales",FAMILY="Lessoniaceae",GENUS="Macrocystis",
                                  genusSpecies="Macrocystis pyrifera",commonName="MAPY"),
                 geographicDescription = "California coast, down through Baja, Mexico",
                 west = -122.44, east = -117.15, 
                 north = 37.38, south = 30.00)
  
  testthat::expect_is(coverage, "coverage")
  
  coverage <- 
    set_coverage(begin = '2012-06-01', end = '2013-12-31',
                 sci_names = data.frame(KINGDOM="Plantae", PHYLUM="Phaeophyta", CLASS="Phaeophyceae",
                                        ORDER="Laminariales",FAMILY="Lessoniaceae",GENUS="Macrocystis",
                                        genusSpecies="Macrocystis pyrifera",commonName="MAPY"),
                 geographicDescription = "California coast, down through Baja, Mexico",
                 west = -122.44, east = -117.15, 
                 north = 37.38, south = 30.00)
  
  testthat::expect_is(coverage, "coverage")
  })

testthat::test_that("get_taxonomicCoverage", {
  f <- system.file("xsd/test/eml-i18n.xml", package="EML")
  eml <- read_eml(f)
  df <- EML:::get_taxonomicCoverage(eml@dataset@coverage@taxonomicCoverage)
  
  testthat::expect_is(df, "data.frame")
  testthat::expect_equal(ncol(df), 8)
  testthat::expect_equal(nrow(df), 1)
  
  
  # coverage <- eml_get(eml, "coverage")
  
  })