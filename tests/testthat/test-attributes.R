testthat::context("get_attributes")

eml <-
  read_eml(system.file(
    "xsd/test/eml-datasetWithAttributelevelMethods.xml",
    package = "EML"
  ))
A <- eml@dataset@dataTable[[1]]@attributeList
df <- get_attributes(A)

eml <-
  read_eml(system.file("xsd/test/eml-i18n.xml", package = "EML"))
A <- eml@dataset@dataTable[[1]]@attributeList
df1 <- get_attributes(A)

testthat::test_that("we can have numeric data with bounds where some bounds are missing",
                    {
                      df <- data.frame(
                        attributeName = "svl",
                        attributeDefinition = "Snout-vent length",
                        unit = "meter",
                        numberType = "real",
                        minimum = "0",
                        maximum = NA,
                        stringsAsFactors = FALSE
                      )
                      attributeList <-
                        set_attributes(df, col_classes = "numeric")

                      dataTable <- new(
                        "dataTable",
                        attributeList = attributeList,
                        entityName = "file.csv",
                        entityDescription = "csv file containing the data",
                        physical = set_physical("file.csv")
                      )

                      me <-
                        as.person("Carl Boettiger <cboettig@gmail.com> [ctb]")
                      dataset <-
                        new(
                          "dataset",
                          title = "Example EML",
                          creator = me,
                          contact = me,
                          dataTable = dataTable
                        )
                      eml <-
                        new("eml",
                            packageId = "123",
                            system = "uuid",
                            dataset = dataset)

                      v <- eml_validate(eml)
                      testthat::expect_true(v)


                    })

testthat::test_that("The set_attributes function works for the vignette example", {
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
        "length"
      ),
      formatString = c(NA,
                       "YYYY",
                       "DDD",
                       "hhmm",
                       NA,
                       NA,
                       NA,
                       NA),
      definition = c("which run number",
                     NA,
                     NA,
                     NA,
                     NA,
                     NA,
                     NA,
                     NA),
      unit = c(NA,
               NA,
               NA,
               NA,
               NA,
               NA,
               NA,
               "meter"),
      attributeDefinition = c(
        "which run number (=block). Range: 1 - 6. (integer)",
        "year, 2012",
        "Julian day. Range: 170 - 209.",
        "hour and minute of observation. Range 1 - 2400 (integer)",
        "is variable Real, Interpolated or Bad (character/factor)",
        "what variable being measured in what treatment (character/factor).",
        "value of measured variable for run.num on year/day/hour.min.",
        "length of the species in meters (dummy example of numeric data)"
      ),
      numberType = c(NA,
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
  attributeList <-
    set_attributes(
      attributes,
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
  testthat::expect_is(attributeList, "attributeList")
})

testthat::test_that("The set_attributes function stops if missing required fields in attributes",
                    {
                      # attributeName
                      attributes <- data.frame(
                        attributeName = NA,
                        attributeDefinition = "date",
                        measurementScale = "dateTime",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      attributes <- data.frame(
                        attributeDefinition = "date",
                        measurementScale = "dateTime",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      # attributeDefinition
                      attributes <- data.frame(
                        attributeName = "date",
                        measurementScale = "dateTime",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))


                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = NA,
                        measurementScale = "dateTime",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      # measurementScale
                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        measurementScale = NA,
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        measurementScale = "datetime",
                        domain = "dateTimeDomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      # domain
                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        measurementScale = "dateTime",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        measurementScale = "dateTime",
                        domain = NA,
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))

                      attributes <- data.frame(
                        attributeName = "date",
                        attributeDefinition = "date",
                        measurementScale = "dateTime",
                        domain = "numberdomain",
                        formatString = "YYMMDD"
                      )

                      testthat::expect_error(set_attributes(attributes))
                    })

testthat::test_that(
  "The set_attributes function stops if non permitted values in col_classes or wrong length of col_classes",
  {
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
          "length"
        ),
        formatString = c(NA,
                         "YYYY",
                         "DDD",
                         "hhmm",
                         NA,
                         NA,
                         NA,
                         NA),
        definition = c("which run number",
                       NA,
                       NA,
                       NA,
                       NA,
                       NA,
                       NA,
                       NA),
        unit = c(NA,
                 NA,
                 NA,
                 NA,
                 NA,
                 NA,
                 NA,
                 "meter"),
        attributeDefinition = c(
          "which run number (=block). Range: 1 - 6. (integer)",
          "year, 2012",
          "Julian day. Range: 170 - 209.",
          "hour and minute of observation. Range 1 - 2400 (integer)",
          "is variable Real, Interpolated or Bad (character/factor)",
          "what variable being measured in what treatment (character/factor).",
          "value of measured variable for run.num on year/day/hour.min.",
          "length of the species in meters (dummy example of numeric data)"
        ),
        numberType = c(NA,
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
    testthat::expect_error(set_attributes(
      attributes,
      factors,
      col_classes = c(
        "character",
        "Date",
        "Date",
        "Date",
        "factor",
        "factor",
        "numeric"
      )
    ))
    testthat::expect_error(set_attributes(
      attributes,
      factors,
      col_classes = c(
        "character",
        "Date",
        "Date",
        "Date",
        "factor",
        "factor",
        "lalala",
        "numeric"
      )
    ))

    attributes <-
      data.frame(
        attributeName = c("run.num", "year", "day"),
        formatString = c(NA, "YYYY", "DDD"),
        definition = c("which run number", NA, NA),
        unit = c(NA, NA, NA),
        attributeDefinition = c(
          "which run number (=block). Range: 1 - 6. (integer)",
          "year, 2012",
          "Julian day. Range: 170 - 209."
        ),
        numberType = c(NA, NA, NA),
        domain = c("numericDomain", "numericDomain", "numericDomain"),
        measurementScale = c("ratio", "nominal", "interval"),
        stringsAsFactors = FALSE
      )
    testthat::expect_error(set_attributes(
      attributes,
      col_classes = list(run_numero = "character", year = "Date")
    ))
    testthat::expect_error(set_attributes(
      attributes,
      col_classes = list(
        run.num = "Date",
        year = "Date",
        day = "Date"
      )
    ))
    testthat::expect_error(set_attributes(attributes, col_classes = list("Date", "Date", "Date")))

    attributes <-
      data.frame(
        attributeName = c("run.num", "year", "day"),
        formatString = c(NA, "YYYY", "DDD"),
        definition = c("which run number", NA, NA),
        unit = c(NA, NA, NA),
        attributeDefinition = c(
          "which run number (=block). Range: 1 - 6. (integer)",
          "year, 2012",
          "Julian day. Range: 170 - 209."
        ),
        numberType = c(NA, NA, NA),
        measurementScale = c("ratio", "nominal", "interval"),
        stringsAsFactors = FALSE
      )
    testthat::expect_error(set_attributes(
      attributes,
      col_classes = list(
        run.num = "numeric",
        year = "Date",
        day = "Date"
      )
    ))

    testthat::expect_error(set_attributes(attributes, col_classes = list("Date", "Date", "Date")))

    attributes <-
      data.frame(
        attributeName = c("run.num", "year", "day"),
        formatString = c(NA, "YYYY", "DDD"),
        definition = c("which run number", NA, NA),
        unit = c(NA, NA, NA),
        attributeDefinition = c(
          "which run number (=block). Range: 1 - 6. (integer)",
          "year, 2012",
          "Julian day. Range: 170 - 209."
        ),
        numberType = c(NA, NA, NA),
        storageType = c("float", "float", "float"),
        stringsAsFactors = FALSE
      )
    testthat::expect_error(set_attributes(
      attributes,
      col_classes = list(
        run.num = "numeric",
        year = "Date",
        day = "Date"
      )
    ))

    testthat::expect_error(set_attributes(attributes, col_classes = list("Date", "Date", "Date")))


  }
)

testthat::test_that("The set_attributes function returns useful warnings", {
  attributes <- data.frame(
    attributeName = "date",
    attributeDefinition = "date",
    measurementScale = "dateTime",
    domain = "dateTimeDomain"
  )

  testthat::expect_warning(set_attributes(attributes),
                           "The required formatString")
})
