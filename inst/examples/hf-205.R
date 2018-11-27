
## Works only with dev version dplyr due to dplyr bug
attributes <-
  dplyr::frame_data(
    ~attributeName, ~formatString, ~definition, ~attributeDefinition,
    "run.num", NA, "which run number", "which run number (=block). Range: 1 - 6. (integer)",
    "year", "YYYY", NA, "year, 2012",
    "day", "DDD", NA, "Julian day. Range: 170 - 209.",
    "hour.min", "hhmm", NA, "hour and minute of observation. Range 1 - 2400 (integer)",
    "i.flag", NA, NA, "is variable Real, Interpolated or Bad (character/factor)",
    "variable", NA, NA, "what variable being measured in what treatment (character/factor).",
    "value.i", NA, NA, "value of measured variable for run.num on year/day/hour.min."
  )
