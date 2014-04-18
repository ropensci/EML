\name{create_custom_unit}
\alias{create_custom_unit}
\title{create a custom unit}
\usage{
create_custom_unit(id, unitType = NULL, parentSI = NULL,
  multiplierToSI = NULL, name = id, constantToSI = NULL,
  description = NULL)
}
\arguments{
  \item{id}{The id of the unit, given in camelCase with
  `Per` signifying division, Squared for second power,
  etc.}

  \item{unitType}{The type of the unit.}

  \item{parentSI}{the parent SI unit from the Standard
  Units list}

  \item{multiplierToSI}{The multiplicative factor to
  convert the given unit into the parent unit}

  \item{constantToSI}{An additive constant needed for the
  conversion, such as farenheight to celsius}

  \item{description}{a plain text description of the unit}
}
\description{
create a custom unit
}
\details{
Defines a custom unit whose id is used in the unit
definition metadata. See
https://github.com/ropensci/EML/issues/12
}
\examples{
create_custom_unit(id = "metersSquaredPerHectare",
                    parentSI = "dimensionless",
                    unitType = "dimensionless",
                    multiplierToSI = "0.0001")
}

