Package Review
Please check off boxes as applicable, and elaborate in comments below. Your review is not limited to these topics, as described in the reviewer guide
- [x]  As the reviewer I confirm that there are no conflicts of interest for me to review this work (such as being a major contributor to the software).

Documentation
The package includes all the following forms of documentation:
- [x]  A statement of need clearly stating problems the software is designed to solve and its target audience in README
- [x]  Installation instructions: for the development version of package and any non-standard dependencies in README
- [x]  Vignette(s) demonstrating major functionality that runs successfully locally
- [x]  Function Documentation: for all exported functions in R help
- [x]  Examples for all exported functions in R Help that run successfully locally
- [x]  Community guidelines including contribution guidelines in the README or CONTRIBUTING, and `URL`, Maintainer and `BugReports` fields in DESCRIPTION 

Functionality
- [x] Installation: Installation succeeds as documented.
- [x]  Functionality: Any functional claims of the software been confirmed.
- [x]  Performance: Any performance claims of the software been confirmed.
- [x]  Automated tests: Unit tests cover essential functions of the package and a reasonable range of inputs and conditions. All tests pass on the local machine.
- [x]  Packaging guidelines: The package conforms to the rOpenSci packaging guidelines

Final approval (post-review)
- [ ] The author has responded to my review and made changes to my satisfaction. I recommend approving this package.

Estimated hours spent reviewing: 

---

Review Comments
As LTER information manager I have experience in using EML to document ecological datasets and will concentrate on reviewing those aspects rather than the technical design and implementation of the package, which I am not an expert in.
This package is greatly needed and will be used widely by ecological information managers and some scientists. I have now used it to develop EML for several datasets and found it to be at a point where a stable version should be available on CRAN. 
For the average user (me included) it would be nice to have a little more extensive documentation. I.e., in the description field of functions it would help to see more than just the function name again.  The examples are all very helpful and work great. The vignettes are great as well and really help to get started writing code to generate EML. The explanation for the ‘new’ method is, however, very short. I realize that it mainly takes understanding XML and EML specifically to get the hang of that and EML is complex with many ‘new’ constructs for using the more obscure elements.
One improvement that could still be considered for the first release is dealing with people information. I found myself very quickly writing some helper functions which I then also discovered in the arctic repository that was mentioned by @amoeba in [https://github.com/ropensci/EML/issues/183](url). Given the fact that we both seemed to need such and the basic `as.person` is not sufficient, some thought might go into improving that before everyone starts writing those helper functions. I would like to see the option to provide a csv file/data frame with the people information following the pattern of attribute and taxonomic coverage information. I have had datasets with almost 60 creators and their sequence changed several times in the process of publishing the paper. That would be very tedious to work out in code.
Which leads me to responding to @gmbecker that I find it very convenient to provide attribute and taxonomic information as a data frame. It allows for easy retrieval of the information from either a database or more frequently from a spreadsheet that data providers supply with this information. Most data providers don’t know about the EML subtleties of measurementScale or how to correctly spell the units, but it takes very little editing on my part to prepare a spreadsheet from the information that I do receive. Taxonomic coverage can be extensive and again frequently comes out of a database, i.e., can be easily provided as csv file and data frame. 
