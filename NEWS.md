# EML 1.0.4

* `set_taxonomicCoverage` now supports expanding the provided species names into full taxonomic classifications via the taxize package
* Fixed two bugs in `get_TextType` which were preventing the method from working under multiple scenarios
* Improved `eml_view` so it works when there are XML comments in the EML record being viewed
* Added the ability to `set_physical` to calculate file size and checksums automatically
* Fixed a bug in `set_physical` which was setting the `recordDelimiter` to `\n\r` instead of `\r\n`

# EML 1.0.3

* Avoid vignette build errors on machines that lack pandoc (e.g. Solaris) using conditional checks

# EML 1.0.2

* Migrate dependency from XML to xml2
* Improved performance in displaying and serializing XML
* Added a `NEWS.md` file to track changes to the package
* Minor bug fixes


# EML 1.0.1

* Initial release


