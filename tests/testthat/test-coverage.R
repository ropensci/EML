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
  })
