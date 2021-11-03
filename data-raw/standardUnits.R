standardUnits <- EML::get_unitList()
udunits_units <- load_udunits()
usethis::use_data(standardUnits, udunits_units, internal = TRUE, overwrite = TRUE)
