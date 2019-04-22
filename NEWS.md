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
