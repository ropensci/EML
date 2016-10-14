

#' is_standardUnit
#'
#' @param x name of unit to check
#'
#' @return TRUE if unit is exact match to the id of a unit in the Standard Units Table, FALSE otherwise.
#' @export
#'
#' @examples
#' is_standardUnit("amperePerMeter") # TRUE
#' is_standardUnit("speciesPerSquareMeter") # FALSE
is_standardUnit <- function(x) {
  #standard_unit_list <- read.csv(system.file("units/standard_unit_list.csv", package = "EML"))
  standard_unit_list <- standardUnits$units$id
  (x %in% standard_unit_list)
}
