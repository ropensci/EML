June 2, 2003  
Dan Higgins

NBII/FGDC is a content standard that does not define the format that information is stored in. XML is one possible format, but an indented text format (a textual outline format) is another possibility. One description of this format is given at http://geology.usgs.gov/tools/metadata/tools/doc/encoding.html.

It turns out that it is easy to write an XSLT transformation that converts an NBII/FGDC document in XML format to an indented text format. In fact, a method for doing this has been published in the "XSLT Cookbook" by Sal Mangano (O'Reilly). The (slighly modified) xslt files for the conversion are included here. Simply use the transformation file called "nbiixml2nbiitext.xslt" applied to an NBII file in XML format. 

[Actually, the transformation can be applied to any xml file. Currently, it ignores xml attributes (which are absent from nbii xml files).]