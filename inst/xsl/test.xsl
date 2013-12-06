<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" indent="yes" encoding="utf-8" />
  <xsl:param name="BaseURI">http://www.github.com/eml</xsl:param>


  <xsl:template match="/">
    <xsl:element name="rdf:RDF">
      <rdf:Description>
          <xsl:attribute name="rdf:about">
            <xsl:value-of select="$BaseURI"/>
            <xsl:text>#</xsl:text> 
          </xsl:attribute> 
          <xsl:apply-templates select="/*|/@*"/>
       </rdf:Description>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*">
    <xsl:param name="subjectname"/>
              <!-- Build URI for subjects resources from acestors elements -->
              <xsl:element name="dc:date">
                <xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#string</xsl:attribute>
                <xsl:value-of select="dataset/pubDate"/>
              </xsl:element>


  </xsl:template>
 </xsl:stylesheet>


