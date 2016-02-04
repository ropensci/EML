March 20, 2003
Converting eml beta6 packages to eml2

There are currently 6 XSLT stylesheets in the xsl/ subdirectory which are used to convert a set of eml-beta6 modules into an eml2 document. These are: triple_info.xsl, emlb6toeml2.xsl, eml2attr.xsl, eml2cit.xls, eml2entphy.xsl, and eml2project.xsl. The starting point is an eml-beta6 dataset module which contains the triple information which defines the modules in the package. The triple_info.xsl transform processes the triples information into a hierarchy that is then used to create the eml2 document by the other stylesheets, starting with emlb6toeml2.xsl.  

There is a command line based java application (EMLConvert.java) that combines these steps. To run the compiled java code enter

java -cp ./ EMLConvert <beta6 package document>

where <beta6 package document> is the dataset document for the beta6 package (e.g. 'C:\work\higgins.204.2' on a Windows machine). Note that path can be included with the document name and the name is assumed to be the id. Other modules in the package are assumed to be in the same directory. The easiest way to create this directory is to use the 'Export' command in Morpho which will write all the modules in a package to directory with files names corresponding to the ids.  

The transformation should write a file called 'eml2out.xml' to the current working directory.           

The 'runnit.bat' file is a batch file the executes the java application discussed here using a simple set of metadata (in the 'metadata-jscientist.2.2' directory) that was exported from morpho.


-------------------------------

March 11, 2003    (comments superceded by above)
                  
Converting eml beta6 packages to eml2

The xslt stylesheets 'emlb6toeml2.xsl', 'triple_info.xsl', 'eml2entphy.xsl', and 'eml2attr.xsl' can be used to convert a set of eml beta6 modules that represent an emlbeta6 package into an eml2 document. There are two transformations in the process and a Windows batch file for executing the operation is named 'runnit.bat'.

The process starts with the beta6 dataset module. This XML document contains the 'triples' which identify all the modules in the document and the relationships among the modules. The stylesheet 'triple_info.xsl' reads the triples in the dataset module and builds an xml document called 'packageStructure.xml'. An example showing the basic structure is shown below. This xslt transform collects information in the triples and arranges it so there is a list of entities in the package and the attribute, physical, and datafile module document IDs are children of the appropriate entityID. 'triple_info.xsl' is thus an example of processing triple information using XSLT rather than Java. Note that xsl:params are used to give the stylesheet the id and path information for the package. 

----Example packageStructure document-----
?xml version="1.0" encoding="ISO-8859-1"?>
<package id="jones.204.18">
<acl>jones.203.2</acl>
<entities>
  <entity id="jones.206.3">
    <attribute>jones.207.3</attribute>
    <physical>jones.208.3</physical>
    <dataFile>jones.205.3</dataFile>
  </entity>

  <entity id="jones.215.1">
    <attribute>jones.216.1</attribute>
    <physical>jones.217.1</physical>
    <dataFile>jones.214.1</dataFile>
  </entity>
</entities>
</package>
------------------------------------------

The stylesheet 'emlb6toeml2.xsl' is the top level stylesheet for using the information in the packageStructure document to create an eml2 document. This stylesheet 'includes' the 'eml2entphy.xsl', and 'eml2attr.xsl' stylesheets for handling entity, physical, and attribute information. The xsl docs 'eml2cit.xsl' and 'eml2project.xsl' also now exist for handling citation and project translations. It should be noted that all the metadata modules for a package are assumed to be in the same directory and named with their ID (e.g. 'higgins.233.2'). An easy way to create such a directory is to use Morpho to 'export' a data package.       

The 'eml2attr.xsl' sheet includes checking units against the eml-unitDictionary. If a beta6 unit (or ist abbreviation) is found in the unit-Dictionary, a standard unit is created. Otherwise, a custom unit is defined. (Currently, a definition of the custom unit is not automatically created and added to the otherMetadata element.) [A copy of eml-unitDictionary needs to be in the same directory as the style sheets.]
Also, the determination of measurementScale is rather arbitrary. All nonNUmerica and nonDate attribute information (i.e. text) is mapped to the 'nominal' measurementScale. (No 'ordinal' values are ever created.) Numeric information is mapped to 'ratio' if the minimum is greater than 0, or 'interval' if the minumum is negative. 


Currently Unimplemented:
	Currently, modules other than access, dataset, entity, attribute, physical, project, and citation  are not included in the translated package. Data is not inserted 'in-line' but rather the 'online/url' element is set with the metacat url for downloading the data.

Problem Areas:
	The systemID part of the DOCTYPE declarations created in modules by Morpho are not always meaningful outside of Morpho (which only uses the PublicID). This may cause a problem in executing the transformations because XML parsers try to read the DTD files even when not validating. The DOCTYPE tags can be removed or edited to point to existing systemIDs to correct the problem.