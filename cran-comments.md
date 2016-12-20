## Corrections

* The package description now includes a link to EML, as requested

## Test environments

* local OS X install, R 3.3.2
* ubuntu 12.04 (on travis-ci), R oldrel, release, devel
* Windows tests via appveyor (devel and release) 

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

* This is a new release.

## Reverse dependencies

This is a new release, so there are no reverse dependencies.

