#       '$RCSfile: README,v $'
#       Copyright: 1997-2002 Regents of the University of California,
#                            University of New Mexico, and
#                            Arizona State University
#        Sponsors: National Center for Ecological Analysis and Synthesis and
#                  Partnership for Interdisciplinary Studies of Coastal Oceans,
#                     University of California Santa Barbara
#                  Long-Term Ecological Research Network Office,
#                     University of New Mexico
#                  Center for Environmental Studies, Arizona State University
#   Other funding: National Science Foundation (see README for details)
#                  The David and Lucile Packard Foundation
#     For Details: http://knb.ecoinformatics.org/
#
#        '$Author: obrien $'
#          '$Date: 2009-02-26 21:10:21 $'
#      '$Revision: 1.45 $'
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

EML: Ecological Metadata Language
---------------------------------

Version: 2.1.0

Feedback and bugs to: eml-dev@ecoinformatics.org
                      http://bugzilla.ecoinformatics.org

Contributors: Matt Jones (jones@nceas.ucsb.edu)
              Chad Berkley (berkley@nceas.ucsb.edu)
              Jivka Bojilova (bojilova@nceas.ucsb.edu)
              Dan Higgins (higgins@nceas.ucsb.edu)
              Chris Jones (cjones@lifesci.ucsb.edu)
              Corinna Gries (corinna@asu.edu)
              Peter McCartney (peter.mccartney@asu.edu)
              James Brunt (jbrunt@lternet.edu)
              David Blankman (dblankman@lternet.edu)
              Owen Eddins (oeddins@lternet.edu)
              Mark Schildhauer (schild@nceas.ucsb.edu)
              John Harris (harris@nceas.ucsb.edu)
              Matthew Brooke (brooke@nceas.ucsb.edu)
              Scott Chapal (scott.chapal@jonesctr.org)
              Tim Bergsma (tbergsma@kbs.msu.edu)
              Ken Ramsey (kramsey@jornada.nmsu.edu)
              Saurabh Garg (sgarg@nceas.ucsb.edu)
              Margaret O'Brien (mob@msi.ucsb.edu)
	      Mark Servilla (servilla@lternet.edu)
	      James Brunt (brunt@lternet.edu)
			  
Web site: http://knb.ecoinformatics.org/software/eml

The Ecological Metadata Language consists of a number of modules that define
an XML markup syntax for ecologically relevant metadata.  It was originally
based on work done by the ESA Committee on the Future of Long-Term
Ecological Data (http://esa.sdsc.edu/FLED/FLED.html) and on a related paper
on ecological metadata by Michener et al. (see Michener, William K., et al., 
1997. Ecological Applications, "Nongeospatial metadata for the ecological 
sciences" Vol 7(1). pp. 330-342.).  Version 1.4 follows that paper closely in
its content implementation, but Version 2 has been modified substantially after
experience using the specification and from feedback from the ecological 
community.

This release represents the consensus view of a large number of knowledgeable
scientists and data managers on what metadata are relevant to ecological
data and how best to represent it.  Of course, many might differ in opinion 
about specific decisions made during the development of EML; we would like to
encourage users to faithfully use the specification in the spirit of 
community building.  It is better if we all use a metadata language that covers
most of our needs than to modify it and use one that is perfect but not shared
with anybody.

It is notable that some of the rules regarding EML that are important are
expressed only in the EML specification, not in the XML Schema files.  This is
because XML Schema was not able to express some of the constraints that we
felt were important to creating a coherent metadata document, particularly
with respect to identifiers and references to identifiers.  Thus, we have
included a new EML Validity Parser.  It checks both EML rules and the schema
rules to be sure an XML document is a valid EML document.  It is included
with the release, and provided as an online service. See docs/index.html.

DOCUMENTATION
-------------
Please see the docs/index.html directory for a a list of the relevant
documents pertaining to EML.  In particular, this release ships with a full
version of the EML Specification, which is the definitive document explaining
the rules associated with the Ecological Metadata Language.

FILES
-----
############
The files in this distribution are a part of the EML 2.1.0 release.
############


The files in this directory include a "docs" directory that contains the
EML Specification and all documentation for the modules, and an XML Schema
document for each of the modules that make up EML.  Also included is a schema
for supporting documentation, and an instance document defining standard
attribute units for EML. The "lib/sample/eml-sample.xml" file is a sample
document illustrating the use of EML. The "test" directory contains a number
of sample instance documents used for testing the schemas, and an application
for checking document validity under JUnit (see http://junit.org).

############
This RELEASE of EML can be retrieved from CVS using the
tag "RELEASE_EML_2_1_0".  Previous versions of EML (such as 2.0.1) 
are available from this repository using the analagous release tag
(e.g., RELEASE_EML_2_0_1).
############


HIGHLIGHTS IN THIS RELEASE
--------------------------
This release addresses bugs which caused the schema to be invalid with 
respect to the W3C specifications using modern validators 
(e.g., http://www.w3.org/2001/03/webdata/xsv). Although the changes were minor, 
one was incompatible with 2.0 releases, which necessitated the version 
number "2.1". In the 2.0 series, the content model for additionalMetadata 
included an element <describes> whose cardinality was 0..many, alongside 
<xs:any>. This construct is non-deterministic, and so a child element 
was added to the additionalMetadata section to contain the <xs:any> content.
Additionally, several elements of txt:TypeText required additional 
definition so that mixed content could be accommodated. These errors 
were not apparent with validation software available in 2004-2005, but 
were brought to light more recently. Several small changes were made to 
the enumeration list and unitTypes for standard units and stmml descriptions 
of customUnits. Two elements in the literature schema were allowed to be 
optional so that articles-in-press could be described.  The named type for 
element gRing was changed to GRingType.  

EML makes use of the STMML schema (stmml.xsd) for describing custom units
and describing its included list of standardUnits (unitList). The STMML
schema was also found to be non-deterministic, and the most reasonable fix 
for this bug was not compatible with earlier versions. This error 
was NOT related to elements used by EML (unitList or unitType). However, 
given that authors of EML instance documents may have made use of other 
parts of stmml.xsd, it was decided to the advance the namespace used for 
stmml-related files to "stmml-1.1", in keeping with the pattern of version
naming in EML. The stmml authors have been contacted. 

KNOWN ISSUES (see also http://bugzilla.ecoinformatics.org/)
-----------------------------------------------------------
Some areas of EML remain problematic for particular data types, and these 
are being addressed by sub-groups of the EML development group. These 
will be addressed in a backwards-incompatible release in the future. Areas
of future development include: 
1. use of external (or multiple) dictionaries 
2. handling of ongoing data, (e.g.,use of temporal coverage elements)
3. spatial datasets and map projections

BUGS FIXED AND NEW FEATURES IN CURRENT RELEASE
(see also http://bugzilla.ecoinformatics.org/)
--------------------------------------------------------------------------
2.1.0   (numbers refer to the corresponding Bugzilla bug)
Schema changes:
1132: eml.xsd, physical.xsd: fix access rule ambiguities 
2054: eml.xsd: added the <metadata> tag to additionalMetadata
1154: resource.xsd: required element offline has no required children
3480: resource.xsd, physical.xsd: nearly duplicate complexTypes, DistributionType and PhysicalDistributionType
3165: resource.xsd: provide a place for a url description
3227: coverage.xsd: gRing was declared as GRingPointType, is now GRingType
1019: coverage.xsd: altitudeUnits should use eml-unitDictionary
3500: coverage.xsd: restrict boundingCoordinates to realistic lat/lon ranges
1152: attribute.xsd: dateTime elements are named inconsistently; standarized on dateTime
2272: attribute.xsd: base types in BoundsGroup changed to xs:float 
3051: attribute.xsd: missing units were added to enumeration list to match eml-unitDitionary
2568: attribute.xsd, entity.xsd: inconsistent naming of methods elements, standardized to <methods>
2703: text.xsd: refined element declarations in txt:TextType for para, section; added ulink, citetitle 
3163: literature.xsd: cardinality of volume and pageRange is now 0..1
3164: literature.xsd: literature needs a contact tree
3445: stmml.xsd: non-deterministic
2083: stmml.xsd: dimension 'current' was wrongly entered as 'charge'

Parser :
3232: EML parser should use full-schema-checking
3836: runEMLParser script should include sax-validate

Stylesheets :
3508: create a stylesheet for EML2.0.x to EML 2.1.0
3590: eml-documentation stylesheet problem with derived content.
2048: param attributeindex defined twice in eml-settings.xsl
2085: Access control rules adapted for 2.0.1 and 2.1 (currently not shown)
2147: EML Stylesheet problem with web address URL's
2226: EML2 style sheet double the number of complex delimited f...
3492: the word 'unit' should be pluralized by default


PREVIOUS RELEASES
--------------------------------------------------------------------------
2.0.1 Changes- (numbers refer to the corresponding Bugzilla bug)
 249: Update XSLT stylesheets for EML 2.0 modules
 939: spelling errors for 'its' in index
 960: parser not correctly parsing <describes> tag in additiona...
1008: inline element doesn't support character child
1017: documentation error in eml-methods
1031: enumeratedDomain doesn't define value order for ordinals
1035: Technical documentation on eml-methods has an error
1124: update precision field definition and cardinality
1129: Change temporalCoverage calendarDate type
1132: fix access control rule ambiguities
1136: kelvin conversion incorrect in unit dictionary
1149: BoundsGroup bounds min & max have incorrect cardinality
1150: documentation for KeyTypeCode is wrong
1151: misspelled element name
1153: dateTimeDomain element should be optional
1155: Documentation incorrect for dateTimeDomainType bounds
1195: tracking bug for 2.0.1 release
1233: dateTime formatString Documentation contains incorrect ex...
1529: no tag to specify how to handle mutltiple, repeated delimimeters
1652: eml-constraint documentation error

2.0.0 Changes- (numbers refer to the corresponding Bugzilla bug)
670: DateTimeDomain id/reference validation
924: make date time its own measurement scale
661: spell check eml-attribute.xsd and synchronize with unitDi
918: example tag in eml:documentation

2.0.0rc3 Changes- (numbers refer to the corresponding Bugzilla bug)
471: eml spec overview document     
624: eml-methods/methodsType needs clarification on choice/seq...     
627: links broken in EML FAQ     
629: unit conversion coefficients need checking     
637: attributeDomain should be required     
638: request for id/ref in attributeDomain     
654: scope of the unit element     
655: need better model for numeric domains for attributes     
625: Cardinality regarding eml-methods should be corrected in ...     
626: ProcedureStepType schema needs revision to protect sequen...     
628: eml-physical has lit: rather than cit: references     
632: broken link in faq
634: Documentation of reference elements in the schemas
656: physical should be repeatable

RC2 Changes- (numbers refer to the corresponding Bugzilla bug)
568: accommodate of stateful connection information   
586: resolve validation problem with missing keys     
588: Remove lineage tags in documentation stylesheets     
589: eml-coverage: convert element references to types     
592: fix validation error with xs:anyType
594: change cardinality for designDescription and studyAreaDes...     
596: Proposal: make attribute optional in OtherEntityType.     
597: In eml-dataTable caseSensitive and orientation are modele...     
598: literature namespace references are inconsistent     
599: storageType is repeatable in eml-attribute     
600: eml-storedProcedure - problems & proposal     
601: element names in spatial modules do not follow guidelines     
602: eml-physical fixed textFormat to allow mixed fixed/delimited
608: release preparation tasks for EML2.0.0rc2
622: redundancy in eml-physical/binaryRaster

RC1 Changes- (numbers refer to the corresponding Bugzilla bug)
471: created an EML specification overview document
495: created FAQ for EML
588: removed lineage tags from documentation stylesheet
484: eml-attribute changes to unit and attributeDomain
579: fixed eml-docbook validation problems
491: eml-coverage changed to correctly import types and to fix
     singleDateTime model
485: eml-physical changed to fix fixed ascii descriptors and distribution
477: complexTypes imports changed to consistent model
486: fixed spelling errors in eml-constraint
492: eml-literature changed for EndNote consistency
496: copyright updated throughout
557: textual elements changed to use docbook subset define in eml-text.xsd
563: changed id types from xs:ID to xs:string to allow numeric ids
482: eml-dataset changed to include method element
489: eml-protocol completely revised based on feedback, eml-method.xsd created
544: eml-attribute storageType and attributeDomain documentation clarified
556: format of eml namespaces changed to include ecoinformatics.org
539: added additionalInfo and alternateIdentifier to eml-dataTable.xsd
568: redesigned DistributionType to allow richer connection descriptions
566: changed imports in eml-resource to import resource types not elements
567: created eml sample documents and XML validation framework using ant/junit 

Beta9 Fixes-
1) Changed packaging concept to use internal id and references instead
   of triples
2) Review and revised all modules according to agreed upon changes from 
   the April, 2002 EML meeting at Sevilleta Field Station

Beta 8 Fixes-
1) Fixed illegal declaration of type and extension in eml-entity
2) Updated all PNG image files

Beta 7 Fixes-
1) Added a 'style' subdirectory with a style sheet for most modules
   to translate the metadata to HTML
2) Changed names of coverage elements to be human readable
3) Updated the namespaces to reflect the current version number of EML
4) Added an eml-data module for the in-lining of data.
5) Added the eml module for creating packages all in one file.  It is a single
   node with a model of ANY so any of the eml modules can be put into it.
6) Numerous bug fixes (see bugzilla.ecoinformatics.org)

Legalese
--------
This software is copyrighted (1997-2002) by The Regents of the University
of California, University of New Mexico, and Arizona State University and
licensed under the GNU GPL; see the 'LICENSE' file for details.

This material is based upon work supported by the National Science Foundation
under Grant No. 0225676, DEB-9980154, DBI-9904777, DEB-0072909, DBI-9983132,
and DEB-9634135.  Any opinions, findings and conclusions or recommendations
expressed in this material are those of the author(s) and do not necessarily
reflect the views of the National Science Foundation (NSF).

This product includes software developed by the Apache Software 
Foundation (http://www.apache.org/). See the LICENSE file in lib/apache
for details.

The source code, object code, and documentation in the com.oreilly.servlet 
package is copyright and owned by Jason Hunter. See the cos-license.html file
for details of the license.  Licensor retains title to and ownership of the 
Software and all enhancements, modifications, and updates to the Software.

This product includes software developed by the JDOM Project 
(http://www.jdom.org/). See jdom-LICENSE.txt for details.

