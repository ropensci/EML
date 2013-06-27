\name{set_alias}
\alias{set_alias}
\title{Set aliases for chunk options}
\usage{
  set_alias(...)
}
\arguments{
  \item{...}{named arguments (argument names are aliases,
  and argument values are real chunk options)}
}
\value{
  NULL (\code{eml$get('aliases')} is modified as the side
  effect)
}
\description{
  We do not have to use the chunk option names given in
  \pkg{knitr}; we can set aliases for them. The aliases is
  a named character vector; the names are aliases and the
  elements in this vector are the real option names.
}

