context("get_unit_id")

test_that("allow for many unit input formats", {
  form_2.2.0 <- "kilometerPerSecondSquared"
  form_2.1.0 <- "kilometersPerSquareSecond"

  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id(form_2.1.0, "eml-2.2.0"))[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(get_unit_id(form_2.1.0, "eml-2.1.0"))[[1]]
  )

  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id(form_2.2.0, "eml-2.2.0"))[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(get_unit_id(form_2.2.0, "eml-2.1.0"))[[1]]
  )

  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id("km/s^2", "eml-2.2.0"))[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(get_unit_id("km/s^2", "eml-2.1.0"))[[1]]
  )

  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id("km s-2", "eml-2.2.0"))[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(get_unit_id("km s-2", "eml-2.1.0"))[[1]]
  )

  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id("km s-²", "eml-2.2.0"))[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(get_unit_id("km s-²", "eml-2.1.0"))[[1]]
  )

  expect_equal(
    form_2.2.0,
    suppressWarnings(
      get_unit_id("s-2 / kilometers-1", "eml-2.2.0")
    )[[1]]
  )
  expect_equal(
    form_2.1.0,
    suppressWarnings(
      get_unit_id("s-2 / kilometers-1", "eml-2.1.0")
    )[[1]]
  )

  exponents <- list(
    numeric = c("1", "2", "3"),
    preceeding = c("", "square", "cubic"),
    following = c("", "squared", "cubed"),
    symbolic = c("", "\u00B2", "\u00B3")
  )
  udunits_units <- load_udunits()
  
  complex <- "km/kg km/(s*km)*kg^3/(kg Kilograms seconds) sec(Seconds μs)/(μs s)"
  split_unit <- get_split_unit(complex, exponents)
  
  format_split_unit(split_unit, exponents, "eml-2.2.0", udunits_units)
  suppressWarnings(get_unit_id(complex, "eml-2.2.0"))
})

test_that("we can auto-simplify units", {
skip("auto-simplifying units does not yet work")

  ##FIXME -- did these ever simplify the units used?  I'm not seeing how that works
  expect_equal(
    form_2.2.0,
    suppressWarnings(get_unit_id(
      "km/kg km/(s^2*km)*kg^3/(kg Kilograms seconds) sec(s)(s)(Seconds μs)/(μs s)",
      "eml-2.2.0"
    ))[[1]]
  )
  expect_equal(form_2.1.0, suppressWarnings(
    get_unit_id(
      "km/kg km/(s^2*km)*kg^4/(kg Kilograms kg seconds) sec(s)(s)(Seconds μs)/(μs s^3)",
      "eml-2.1.0"
    )
  )[[1]])
})

test_that("prefixed capitalized units are handled appropriately", {
  skip("auto-simplifying units does not yet work")
  
  expect_equal(
    "kilowatt",
    suppressWarnings(get_unit_id("kW kW*kW/kW^2"))[[1]]
  )
})

test_that("exponents above 4 don't fail but return blank", {
  expect_equal("", suppressWarnings(get_unit_id("m^4"))[[1]])
})

test_that("warnings not errors occur when unit cannot be made", {
  expect_warning(get_unit_id("m^4"))
  expect_warning(get_unit_id("species/m^2"))
})
