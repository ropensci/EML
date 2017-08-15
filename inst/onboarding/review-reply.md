We believe we have now addressed the very helpful issues and suggestions raised by both reviewers.  While EML is still under active development that may address some of the more big-picture issues about being more user friendly, we feel this addresses the essential issues highlighted by reviewers as listed below.  Apologies for the long delay.  


# cgries


---


> For the average user (me included) it would be nice to have a little more extensive documentation. I.e., in the description field of functions it would help to see more than just the function name again.  The examples are all very helpful and work great. The vignettes are great as well and really help to get started writing code to generate EML. The explanation for the ‘new’ method is, however, very short. I realize that it mainly takes understanding XML and EML specifically to get the hang of that and EML is complex with many ‘new’ constructs for using the more obscure elements.

We agree.  We're working on making easier constructors, as suggested by @gmbecker, basically this is just waiting on his s4Coffee implementation which should be able to automate the generation of the 100s of methods needed to do this.  With help from the user community, we're also flushing out documentation aimed at users less familiar with EML and/or R internals, though of course it was necessary to get the fundamentals in place first, which is what we feel the current release now does.

> One improvement that could still be considered for the first release is dealing with people information. I found myself very quickly writing some helper functions which I then also discovered in the arctic repository that was mentioned by @amoeba in [https://github.com/ropensci/EML/issues/183](url). Given the fact that we both seemed to need such and the basic `as.person` is not sufficient, some thought might go into improving that before everyone starts writing those helper functions. I would like to see the option to provide a csv file/data frame with the people information following the pattern of attribute and taxonomic coverage information. I have had datasets with almost 60 creators and their sequence changed several times in the process of publishing the paper. That would be very tedious to work out in code.
Which leads me to responding to @gmbecker that I find it very convenient to provide attribute and taxonomic information as a data frame. It allows for easy retrieval of the information from either a database or more frequently from a spreadsheet that data providers supply with this information. Most data providers don’t know about the EML subtleties of measurementScale or how to correctly spell the units, but it takes very little editing on my part to prepare a spreadsheet from the information that I do receive. Taxonomic coverage can be extensive and again frequently comes out of a database, i.e., can be easily provided as csv file and data frame.

We agree that being able to maintain metadata such as taxonomic information or author details in in simple .csv files that can quickly be read into EML is a big win, and have been building methods around these patterns.  Understanding the use cases such as @cgries outlines here helps us do that better.  This is all currently possible with the `new` constructors, but requires a bit more coding.  Once we've auto


----

# gmbecker


## Package Review



### Constructors

> Generally, all classes which any end users are expected to create themselves should have exported constructors, rather than requiring users to call `new` directly. This preserves the abstraction if the underlying class structure changes, and usually increases the readability of the users' code. ....

We agree, this will be done once we can automate the creation of these methods with your awesome S4Coffee package!  See https://github.com/gmbecker/S4Coffee/issues/1.  

### show method

> The current show method for `eml` objects converts the object to XML before printing. This seems cumbersome, and, I suspect, is likely to cause problems for real-world-sized EML documents (in the same way the XML package does when printing a large XML blob).  It seems that EML is structured enough that a meaningful summary could be displayed by `show`, while  the emlToXML function would still allow users to easily display the entire XML blob if desired.

Yup, display issues now addressed in #182 and #189.  

### duplicated classes

> I understand that the classes are automatically generated, but there seem to be some minor issues with how this is done. My copy of the package has two `value` class definitions, one right after the other, and they are different to boot. The first one, of course, will do nothing.

> Also, there are the, e.g., `author` `Author` style pairs.  These are troublesome as well, from a design perspective, because the classes are the same, other than a different ordering of the class slots.  If the actual order of the class slots is relied upon in the code, I strongly  encourage refactoring away from that. Slots should, in my opinion, be checked for and used exclusively by name or accessor method.

This is a consequence of the underlying XSD schema.  `author` and `Author` are different elements in EML, so they are different here.  (Any class beginning with a captial is a generic XSD type, while those starting with a lower-case are actual valid complex elements in the XML.)  S4 classes are also simpler/more restricted than XSD classes, so the mapping is imperfect (XSD permits repeated elements, ordered or unordered child elements, etc).  An ideal implementation would probably avoid S4 entirely and focus on a more 1:1 correspondence to the XSD classes, but this would require creating a unique class system which is clearly beyond the scope here.  Note that regarding validation, this already happens on the XSD schema validation level, so is not re-implemented in S4 validation.  Some higher-level constructor functions do now have validation support though. 

## Other

### eml_get

The eml_get function's return value seems unintuitive to me. When run on the example hf205 EML content for "physical" elements, it returns a list, of length 3, with 3 length-1 ListOfPhysical objects. I don't follow why this is not a single length 3 ListOfPhysical object.

### class(blah) == "thing"

> This is not a safe way to test the class of an object, as it will miss/fail for both S3 (vector of classes) and S4 (formal) inheritance. E.g., a tibble will fail a `class(obj) == "data.frame"` check, as would an S4 class that contains data.frame. All such checks should be refactored to use `is`

fixed

### set_coverage data.frame column order requirement

> This seems like something that can be checked and enforced programatically rather than relying on good user behavior. The possible columns are fixed and the order is known.

> Another approach here is to create an S4 object with constructor that formally models the taxonomic hierarchy, rather than relying on a powerful but semantically poor structure like a data.frame. Particularly since from what I can tell it will only ever have one row, making the structure not a great fit anyway.

> It's not clear that data.frames are the correct model for _constructing_ the components of eml. It seems that an `eml_attribute` constructor, which can be called repeatedly and constructs a single attribute (row in the data.frame as it is currently factored) is more useful friendly With respect, it seems like it would be at least as easy to write a csv file directly than constructing and rbinding together these data.frames. I feel more/deeper api-design work is called for on the EML construction side of things.

> As @cgries points out, there are often many rows (for data working with many different species), which make this format convenient.  


### auto-generated code

Files with autogenerated code should contain a header comment to that effect and telling possible future contributors not to edit the file manually. This should be emitted automatically by the code-generation apparatus.

### importing packages

> The entire XML packages is imported. I actually feel this is correct in this case (and not terrible generally imho) but it is technically against the ropensci package guidelines. I leave it up to @noamross as the editor to make the final call on this. I recommend it not be an issue for final acceptance.

Dependency is now on `xml2`.

### Automated submission to EML repository?

> This is somewhat conjecture on my part, given the caveat I started these review comments with, but is there a single (or small set of), major repository for EML? If so, does it have an API for submission? If so, bindings to that so that users can submit their newly created EML from within R would magnify the utility of the creation aspect of this package substantially, and should be added either to this package (or via the creating of a sister convenience package).

Indeed!  This is already implemented in the `dataone` R package and docuemnted there.  We have also added a vignette to the EML package documenting it on our end!


### have the S4 version of the object carry around it's source XML

> XML objects are pointers, so duplication/memory will not be an issue. This could get hairy/infeasible if users are modifying the S4 representation of the eml manually and then re-exporting, but I don't get the sense that this is an intended use-pattern. This would make a couple of parts of the code much cleaner/more efficient when they switch between representations.

Users can create S4 objects from scratch that don't have a source XML.  In general things have been much more stable if we avoid too much manipulation through pointers to the XML and work primarily with in-memory, native S4 R objects.

### Does everything need to inherit from eml-2.1.1?

> I can see some benefits to this, but it also complicates things. A lot of the low-level/internal classes would inherit directly from character if not for also implimenting eml-2.1.1. Are those extra slots ever used at the low level, or only, e.g., once per larger document?

Yes, this lets us distinguish between some required behavior of all the EML objects when creating the serialization methods, etc. 

# Further reviewer comment

> @cboettig has started a discussion regarding the time-scale of implementing improvements vs putting out a stable release here ropensci/EML#183. In my capacity as a reviewer I feel it is most appropriate that I place my thoughts on this subject here as a secondary part of my review. Package authors, please find my recommendations on this question below.

> The most important aspect of a stable (read: CRAN) release is that the API is stable upon release for at least the near and preferably the medium term. As such, the most important issues to fix before release are ones that would actually break API compatibility. These are
> - changing the output class of eml_get, and
> - changing the names of existing constructors to remove the set_ prefix which I argue is misleading/a misnomer

These are excellent points, and actually the reason we ended up doing a CRAN release: the package already had signficant use in some important pipelines for the NSF Arctic database, and we felt having an archived, stable version for this was important.  Future modifications will provide a more friendly higher-level interface without breaking code that is built on lower-level constructors.  

> Beyond that, I feel the class checking is the next most important. People in the CRAN sphere are almost sure (in my opinion) to want to pass tbl_df objects to things that take data.frames. Tests to ensure that this works would not be out-of-place, and they should pass before CRAN release.

Yup, we've added these tests on `tbl_df`.  

> The other changes, while more important from a package design improvement perspective, can probably wait if they must, because they will likely be either backwards compatible or large enough that they warrant a new major version of the software.

Yup, that's the plan.  
