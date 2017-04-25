## Corrections

* Migrates from XML dependency to xml2 for improved efficiency (see NEWS)
* Improves performance in serializing EML to XML
* Fixes the Warning that emerged on R-devel (now on) R-3.4.0 release

## Test environments

* local OS X install, R 3.4.0
* debian jessie, R 3.4.0, R-devel
* ubuntu 12.04 R oldrel, release, devel
* Windows tests via appveyor (devel and release), rhub

## R CMD check results

0 errors | 0 warnings | 1 note

Explanation of note: this note says: 

> installed size is  7.0Mb
>  sub-directories of 1Mb or more:
    xsd   5.4Mb

This subdirectory contains essential schema files used for tests and local validation.  If CRAN mantainers strongly prefer, 
the tests could be re-written to download these files on the fly.  This would mean most tests required an internet connection,
and would break the ability for users to perform schema validation of their metadata files offline, which could be useful
but non-essential.

## Reverse dependencies

There are no reverse dependencies.

