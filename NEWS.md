# EML 2.0.3

* Note recent improvements to validation have been inherited through the release of `emld` 0.5.0,
  package dependency now requires upgrading `emld` as well.
* Fixed a bug in `set_attributes` causing an error when specifying an interval `measurementScale`. (#293)
* Updated test suite to account for the switch from taxize to taxadb
* Updated test suite to match recent changes in `emld` 0.5.0 regarding unit definitions (See https://github.com/ropensci/emld/issues/56)

# EML 2.0.2

* minor bugfix to documentation
* Moves to taxadb in place of taxize for optional species classification
* Note recent improvements to validation have been inherited through the release of `emld` 0.4.0,
  package dependency now requires upgrading `emld` as well.

# EML 2.0.1

* Improve error message for get_attributes (#286)
* Avoid `ifelse()` for portability (#283)
* Avoid edge case that can create invalid EML in `set_taxonomicNames()` (#280)
* Add documentation regarding the use of dimensionless units (#276)
* Avoid test errors on systems for which pandoc cannot be installed (#290)

# EML 2.0.0

* EML 2.0.0 is a ground-up rewrite of EML 1.x package.  The primary difference
  is that EML 2.0.0 is built on S3 (list) objects instead of S4 object system.
  This makes the package interface easier to use and extend.  Under the hood, this
  approach relies on the `emld` package, which uses a JSON-LD representation of EML
  which provides a natural translation into the list-based format.  
  
  While most high level functions for creating EML have been preserved, the change to
  S3 means that this package will not be backwards-compatible with  many scripts
  which relied on the S4 system. 

* Added a `NEWS.md` file to track changes to the package.
