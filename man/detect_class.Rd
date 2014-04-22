\name{detect_class}
\alias{detect_class}
\title{Helper function to attach classes to metadata}
\usage{
detect_class(dat, meta = get_metadata(dat))
}
\arguments{
  \item{dat}{a data frame}

  \item{meta}{a list containing attribute-level metadata
  for each column. each element of list corresponds to a
  consecutive column, and gives a list containing the
  column name (as appearing in the data-frame), the column
  description (e.g. from col.defs) and the unit defs (e.g.
  from unit.defs) as a (named) character vector.}
}
\description{
Helper function to attach classes to metadata
}

