testthat::context("Creating custom units")

 
name = c("speed", "speed", "acceleration", "acceleration", "frequency")
dimension = c("length", "time", "length", "time", "time")
power = c(NA, "-1", NA, "-2", "-1")
unitTypes <- data.frame(name = name, dimension = dimension, power = power, stringsAsFactors = FALSE)

name = c("minute", "centimeter")
unitType = c("time", "length")
parentSI = c("second", "meter")
multiplierToSI = c("0.0166", "1")
description = c("one minute is 60 seconds", "centimeter is a 100th of a meter")
units = data.frame(name = name, unitType = unitType, parentSI = parentSI, multiplierToSI = multiplierToSI, description = description, stringsAsFactors = FALSE)

x = set_unitList(units, unitTypes)
testthat::expect_is(x, "stmml:unitList")


y = set_unitList(units)
testthat::expect_is(y, "stmml:unitList")