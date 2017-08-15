## Package Review

_Please check off boxes as applicable, and elaborate in comments below.  Your review is not limited to these topics, as described in the reviewer guide_
- [x] As the reviewer I confirm that there are no conflicts of interest for me to review this work (such as being a major contributor to the software).

#### Documentation

The package includes all the following forms of documentation:
- [x] **A statement of need** clearly stating problems the software is designed to solve and its target audience in README
- [x] **Installation instructions:** for the development version of package and any non-standard dependencies in README
- [x] **Vignette(s)** demonstrating major functionality that runs successfully locally
- [x] **Function Documentation:** for all exported functions in R help
- [x] **Examples** for all exported functions in R Help that run successfully locally
- [x] **Community guidelines** including contribution guidelines in the README or CONTRIBUTING, and `URL`, `Maintainer` and `BugReports` fields in DESCRIPTION 

#### Functionality
- [x] **Installation:** Installation succeeds as documented.
- [x] **Functionality:** Any functional claims of the software been confirmed.
- [x] **Performance:** Any performance claims of the software been confirmed.
- [x] **Automated tests:** Unit tests cover essential functions of the package
  and a reasonable range of inputs and conditions. All tests pass on the local machine.
- [x] **Packaging guidelines**: The package conforms to the rOpenSci packaging guidelines

#### Final approval (post-review)
- [ ] **The author has responded to my review and made changes to my satisfaction. I recommend approving this package.**

Estimated hours spent reviewing: 

## 6 for initial review and comment writing

# Review Comments

I do not have experience within the field of application for this package. As such, I will focus in this review on the design and technical aspects of the package while speaking less to it's direct applicability to problems computational ecologists actually face. 

The package seems generally good, with code (both generated and hand-written) which is well conceived and behaves as intended.  I feel that with afew revisions to tighten up some aspects of it, it will be a strong and welcome contribution to ROpenSci core mission to facilitate interaction with open-data sources and formats from within R.

## S4 design and usage

 there are some S4-specific design and stylistic choices which I recommend the authors revisit.

### Constructors

Generally, all classes which any end users are expected to create themselves should have exported constructors, rather than requiring users to call `new` directly. This preserves the abstraction if the underlying class structure changes, and usually increases the readability of the users' code.

This is doable even when classes (and thus constructors) are automatically generated. I wrote some code that seems to successfully do the individual constructor generation for this package. I'm happy to contribute it, though achieving a positive final review and acceptance is, of course, in no way contingent on that particular code being used. 

Another note about constructors is that I believe it is stylistically cleaner to map the arguments directly to the slots and to use constructors for the classes of those slots as necessary, recursively, rather than utilizing nested `new` calls as the code does now, e.g., in `set_physical`.

Finally, I do not feel that set_ is an appropriate prefix for constructors, as in the S4 OOP style that suggests than an existing object is being modified by having a component (e.g., slot) of it set. The standard paradigm is to have constructors be functions with names identical to the classes they construct, although that is not mandatory.

### show method

The current show method for `eml` objects converts the object to XML before printing. This seems cumbersome, and, I suspect, is likely to cause problems for real-world-sized EML documents (in the same way the XML package does when printing a large XML blob).  It seems that EML is structured enough that a meaningful summary could be displayed by `show`, while  the emlToXML function would still allow users to easily display the entire XML blob if desired.  

### duplicated classes

I understand that the classes are automatically generated, but there seem to be some minor issues with how this is done. My copy of the package has two `value` class definitions, one right after the other, and they are different to boot. The first one, of course, will do nothing.

Also, there are the, e.g., `author` `Author` style pairs.  These are troublesome as well, from a design perspective, because the classes are the same, other than a different ordering of the class slots.  If the actual order of the class slots is relied upon in the code, I strongly  encourage refactoring away from that. Slots should, in my opinion, be checked for and used exclusively by name or accessor method.

## Other

### eml_get

The eml_get function's return value seems unintuitive to me. When run on the example hf205 EML content for "physical" elements, it returns a list, of length 3, with 3 length-1 ListOfPhysical objects. I don't follow why this is not a single length 3 ListOfPhysical object.

### class(blah) == "thing"

This is not a safe way to test the class of an object, as it will miss/fail for both S3 (vector of classes) and S4 (formal) inheritance. E.g., a tibble will fail a `class(obj) == "data.frame"` check, as would an S4 class that contains data.frame. All such checks should be refactored to use `is`

### set_coverage data.frame column order requirement

This seems like something that can be checked and enforced programatically rather than relying on good user behavior. The possible columns are fixed and the order is known.

Another approach here is to create an S4 object with constructor that formally models the taxonomic hierarchy, rather than relying on a powerful but semantically poor structure like a data.frame. Particularly since from what I can tell it will only ever have one row, making the structure not a great fit anyway.

### eml construction

It's not clear that data.frames are the correct model for _constructing_ the components of eml. It seems that an `eml_attribute` constructor, which can be called repeatedly and constructs a single attribute (row in the data.frame as it is currently factored) is more useful friendly With respect, it seems like it would be at least as easy to write a csv file directly than constructing and rbinding together these data.frames. I feel more/deeper api-design work is called for on the EML construction side of things.

### auto-generated code

Files with autogenerated code should contain a header comment to that effect and telling possible future contributors not to edit the file manually. This should be emitted automatically by the code-generation apparatus.

### importing packages

The entire XML packages is imported. I actually feel this is correct in this case (and not terrible generally imho) but it is technically against the ropensci package guidelines. I leave it up to @noamross as the editor to make the final call on this. I recommend it not be an issue for final acceptance.

### Automated submission to EML repository?

This is somewhat conjecture on my part, given the caveat I started these review comments with, but is there a single (or small set of), major repository for EML? If so, does it have an API for submission? If so, bindings to that so that users can submit their newly created EML from within R would magnify the utility of the creation aspect of this package substantially, and should be added either to this package (or via the creating of a sister convenience package).

## Musing and recommendations for consideration

These are things I feel warrant consideration by the package authors, but should not be taken as firm requirements, and may not even be desirable upon a closer look. I do ask that the authors notes in response to this review address these points and why they did or did not ultimately agree.

### have the S4 version of the object carry around it's source XML

XML objects are pointers, so duplication/memory will not be an issue. This could get hairy/infeasible if users are modifying the S4 representation of the eml manually and then re-exporting, but I don't get the sense that this is an intended use-pattern. This would make a couple of parts of the code much cleaner/more efficient when they switch between representations.

### Does everything need to inherit from eml-2.1.1?

I can see some benefits to this, but it also complicates things. A lot of the low-level/internal classes would inherit directly from character if not for also implimenting eml-2.1.1. Are those extra slots ever used at the low level, or only, e.g., once per larger document?


# Further reviewer comment

@cboettig has started a discussion regarding the time-scale of implementing improvements vs putting out a stable release here ropensci/EML#183. In my capacity as a reviewer I feel it is most appropriate that I place my thoughts on this subject here as a secondary part of my review. Package authors, please find my recommendations on this question below.

The most important aspect of a stable (read: CRAN) release is that the API is stable upon release for at least the near and preferably the medium term. As such, the most important issues to fix before release are ones that would actually break API compatibility. These are
- changing the output class of eml_get, and
- changing the names of existing constructors to remove the set_ prefix which I argue is misleading/a misnomer

This is because if you release  now without those changes, then release the next release with the changes in a half a year (or whenever), _people's existing code will break._ This is less acceptable for a CRAN release than it is for a package under heavy development within the ROpenSci incubator.

Beyond that, I feel the class checking is the next most important. People in the CRAN sphere are almost sure (in my opinion) to want to pass tbl_df objects to things that take data.frames. Tests to ensure that this works would not be out-of-place, and they should pass before CRAN release.

The other changes, while more important from a package design improvement perspective, can probably wait if they must, because they will likely be either backwards compatible or large enough that they warrant a new major version of the software.

EDIT: @noamross if as the editor you feel this post oversteps my role as a reviewer I can remove this post and make my comments in the linked issue (or not at all if it inappropriate for a reviewer to weigh in on the response to his comments in this manner).
